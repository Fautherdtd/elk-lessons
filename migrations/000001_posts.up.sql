CREATE TABLE posts (
    id serial primary key,
    title varchar(255) not null,
    description varchar(255) null,
    body text not null,
    category varchar(255) not null,
    verifed boolean default false,
    factor integer default 0,
    created_at timestamp with time zone default current_timestamp
);