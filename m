Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6E2350E878
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 20:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244497AbiDYSpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 14:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244483AbiDYSpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 14:45:40 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2317A53E09
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 11:42:35 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 16so3839316lju.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 11:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TirRwgljTb63OydsOJ9R6RLPJiUK3wHHOhwLNel8FTw=;
        b=EEgsvBUfwpFzXZbRjVtvOtLasuyx2i9KStoUbH4fHv0F4KSBI+Ldm68Gt6oo+Dtcas
         xzBvDMLJCNUGP+LMe1ZLXN8aILpXzCjA7DZGfSuYM502Okb96ZLq7hhMuyn1s6eahI74
         s9WVa6MINSUHXv9R9zIDszxpK9xMnNLDxn+f1rcIk4ri5MQ+ykyu0YMhsPKy+8z3H4b5
         LS9lsCvd2DSEdfjB8OO/CB6HYITJt5lh9h4yoj5RTtwQ9WQ78GQauzm13bIHoAZgmmzo
         jw0WqcE9WAXR5SyF4i0SYQi6GhzcdDbqYCThsXr6wUKi4Bm3d8xDoacxMAu3ZHrV6fUQ
         F0fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TirRwgljTb63OydsOJ9R6RLPJiUK3wHHOhwLNel8FTw=;
        b=qWRSn7W5mR3VYlmvwU2CucOSiVMWoCkJPkboUb3vvP/6en7WykxMI9lEjCyazljpGd
         O41HKw2xhJNEWDjaIlpm047pEBQ07AQg5t2HCeoPFsekzuKc3yexkKwQK/fLboCaH2Ns
         kDUUBmgAEMp/dNIpk0KOiJAvnCGYDsHrUE4y31G8CBA+Z14zxGPHLdCxuZulaqE4DtdF
         Y2vzQsGIxYrcc1HVVKXAQLumN2ooytyYyt04G9GQ80NSm9NwTF8N/taHay3V0Yz6ungN
         TH/3b59pFeNBUqRGhKzOEufk+TyElICk74+ErAZK2L8M6ciokwi7VKYiesJ1ZB6HsIiW
         jikw==
X-Gm-Message-State: AOAM532P4zZ7/Z9BjqU5T6aNRj36em5Zz15YptGaBi3w7nMMDz8SgeIV
        quVyPdp5Z4Rl0xQYoC7jiI3s2Towpp+lo48XsRaNJw==
X-Google-Smtp-Source: ABdhPJwsCQvnsTBZgV2Kk2hGpCXcIOtUqcgAFZqJQNwX6Bnx0R7oobBI07BZKO5IkiRo/OvDHd0y6hcBI5tA8eLmkZU=
X-Received: by 2002:a2e:9ec4:0:b0:24b:115c:aedb with SMTP id
 h4-20020a2e9ec4000000b0024b115caedbmr11671679ljk.235.1650912153025; Mon, 25
 Apr 2022 11:42:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220424190811.1678416-1-masahiroy@kernel.org> <20220424190811.1678416-8-masahiroy@kernel.org>
In-Reply-To: <20220424190811.1678416-8-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 25 Apr 2022 11:42:21 -0700
Message-ID: <CAKwvOd=2pYsUZkvK-d97xC749mCs1QUUc68BfZdTR1diz52Hww@mail.gmail.com>
Subject: Re: [PATCH 07/27] modpost: import include/linux/list.h
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 24, 2022 at 12:09 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Import include/linux/list.h to use convenient list macros in modpost.
>
> I dropped kernel-space code such as {WRITE,READ}_ONCE etc. and unneeded
> macros.
>
> I also imported container_of() from include/linux/container_of.h and
> type definitions from include/linux/types.h.

Is there a better way to just use the kernel headers? I kind of hate
copy+paste since the in tree duplication will diverge over time.

>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  scripts/mod/list.h | 336 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 336 insertions(+)
>  create mode 100644 scripts/mod/list.h
>
> diff --git a/scripts/mod/list.h b/scripts/mod/list.h
> new file mode 100644
> index 000000000000..c87583a71714
> --- /dev/null
> +++ b/scripts/mod/list.h
> @@ -0,0 +1,336 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef LIST_H
> +#define LIST_H
> +
> +#include <stdbool.h>
> +#include <stddef.h>
> +
> +/* Are two types/vars the same type (ignoring qualifiers)? */
> +#define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
> +
> +/**
> + * container_of - cast a member of a structure out to the containing structure
> + * @ptr:       the pointer to the member.
> + * @type:      the type of the container struct this is embedded in.
> + * @member:    the name of the member within the struct.
> + *
> + */
> +#define container_of(ptr, type, member) ({                             \
> +       void *__mptr = (void *)(ptr);                                   \
> +       _Static_assert(__same_type(*(ptr), ((type *)0)->member) ||      \
> +                     __same_type(*(ptr), void),                        \
> +                     "pointer type mismatch in container_of()");       \
> +       ((type *)(__mptr - offsetof(type, member))); })
> +
> +#define LIST_POISON1  ((void *) 0x100)
> +#define LIST_POISON2  ((void *) 0x122)
> +
> +/*
> + * Circular doubly linked list implementation.
> + *
> + * Some of the internal functions ("__xxx") are useful when
> + * manipulating whole lists rather than single entries, as
> + * sometimes we already know the next/prev entries and we can
> + * generate better code by using them directly rather than
> + * using the generic single-entry routines.
> + */
> +
> +struct list_head {
> +       struct list_head *next, *prev;
> +};
> +
> +#define LIST_HEAD_INIT(name) { &(name), &(name) }
> +
> +#define LIST_HEAD(name) \
> +       struct list_head name = LIST_HEAD_INIT(name)
> +
> +/**
> + * INIT_LIST_HEAD - Initialize a list_head structure
> + * @list: list_head structure to be initialized.
> + *
> + * Initializes the list_head to point to itself.  If it is a list header,
> + * the result is an empty list.
> + */
> +static inline void INIT_LIST_HEAD(struct list_head *list)
> +{
> +       list->next = list;
> +       list->prev = list;
> +}
> +
> +/*
> + * Insert a new entry between two known consecutive entries.
> + *
> + * This is only for internal list manipulation where we know
> + * the prev/next entries already!
> + */
> +static inline void __list_add(struct list_head *new,
> +                             struct list_head *prev,
> +                             struct list_head *next)
> +{
> +       next->prev = new;
> +       new->next = next;
> +       new->prev = prev;
> +       prev->next = new;
> +}
> +
> +/**
> + * list_add - add a new entry
> + * @new: new entry to be added
> + * @head: list head to add it after
> + *
> + * Insert a new entry after the specified head.
> + * This is good for implementing stacks.
> + */
> +static inline void list_add(struct list_head *new, struct list_head *head)
> +{
> +       __list_add(new, head, head->next);
> +}
> +
> +/**
> + * list_add_tail - add a new entry
> + * @new: new entry to be added
> + * @head: list head to add it before
> + *
> + * Insert a new entry before the specified head.
> + * This is useful for implementing queues.
> + */
> +static inline void list_add_tail(struct list_head *new, struct list_head *head)
> +{
> +       __list_add(new, head->prev, head);
> +}
> +
> +/*
> + * Delete a list entry by making the prev/next entries
> + * point to each other.
> + *
> + * This is only for internal list manipulation where we know
> + * the prev/next entries already!
> + */
> +static inline void __list_del(struct list_head *prev, struct list_head *next)
> +{
> +       next->prev = prev;
> +       prev->next = next;
> +}
> +
> +static inline void __list_del_entry(struct list_head *entry)
> +{
> +       __list_del(entry->prev, entry->next);
> +}
> +
> +/**
> + * list_del - deletes entry from list.
> + * @entry: the element to delete from the list.
> + * Note: list_empty() on entry does not return true after this, the entry is
> + * in an undefined state.
> + */
> +static inline void list_del(struct list_head *entry)
> +{
> +       __list_del_entry(entry);
> +       entry->next = LIST_POISON1;
> +       entry->prev = LIST_POISON2;
> +}
> +
> +/**
> + * list_is_head - tests whether @list is the list @head
> + * @list: the entry to test
> + * @head: the head of the list
> + */
> +static inline int list_is_head(const struct list_head *list, const struct list_head *head)
> +{
> +       return list == head;
> +}
> +
> +/**
> + * list_empty - tests whether a list is empty
> + * @head: the list to test.
> + */
> +static inline int list_empty(const struct list_head *head)
> +{
> +       return head->next == head;
> +}
> +
> +/**
> + * list_entry - get the struct for this entry
> + * @ptr:       the &struct list_head pointer.
> + * @type:      the type of the struct this is embedded in.
> + * @member:    the name of the list_head within the struct.
> + */
> +#define list_entry(ptr, type, member) \
> +       container_of(ptr, type, member)
> +
> +/**
> + * list_first_entry - get the first element from a list
> + * @ptr:       the list head to take the element from.
> + * @type:      the type of the struct this is embedded in.
> + * @member:    the name of the list_head within the struct.
> + *
> + * Note, that list is expected to be not empty.
> + */
> +#define list_first_entry(ptr, type, member) \
> +       list_entry((ptr)->next, type, member)
> +
> +/**
> + * list_next_entry - get the next element in list
> + * @pos:       the type * to cursor
> + * @member:    the name of the list_head within the struct.
> + */
> +#define list_next_entry(pos, member) \
> +       list_entry((pos)->member.next, typeof(*(pos)), member)
> +
> +/**
> + * list_entry_is_head - test if the entry points to the head of the list
> + * @pos:       the type * to cursor
> + * @head:      the head for your list.
> + * @member:    the name of the list_head within the struct.
> + */
> +#define list_entry_is_head(pos, head, member)                          \
> +       (&pos->member == (head))
> +
> +/**
> + * list_for_each_entry -       iterate over list of given type
> + * @pos:       the type * to use as a loop cursor.
> + * @head:      the head for your list.
> + * @member:    the name of the list_head within the struct.
> + */
> +#define list_for_each_entry(pos, head, member)                         \
> +       for (pos = list_first_entry(head, typeof(*pos), member);        \
> +            !list_entry_is_head(pos, head, member);                    \
> +            pos = list_next_entry(pos, member))
> +
> +/**
> + * list_for_each_entry_safe - iterate over list of given type safe against removal of list entry
> + * @pos:       the type * to use as a loop cursor.
> + * @n:         another type * to use as temporary storage
> + * @head:      the head for your list.
> + * @member:    the name of the list_head within the struct.
> + */
> +#define list_for_each_entry_safe(pos, n, head, member)                 \
> +       for (pos = list_first_entry(head, typeof(*pos), member),        \
> +               n = list_next_entry(pos, member);                       \
> +            !list_entry_is_head(pos, head, member);                    \
> +            pos = n, n = list_next_entry(n, member))
> +
> +/*
> + * Double linked lists with a single pointer list head.
> + * Mostly useful for hash tables where the two pointer list head is
> + * too wasteful.
> + * You lose the ability to access the tail in O(1).
> + */
> +
> +struct hlist_head {
> +       struct hlist_node *first;
> +};
> +
> +struct hlist_node {
> +       struct hlist_node *next, **pprev;
> +};
> +
> +#define HLIST_HEAD_INIT { .first = NULL }
> +#define HLIST_HEAD(name) struct hlist_head name = {  .first = NULL }
> +#define INIT_HLIST_HEAD(ptr) ((ptr)->first = NULL)
> +static inline void INIT_HLIST_NODE(struct hlist_node *h)
> +{
> +       h->next = NULL;
> +       h->pprev = NULL;
> +}
> +
> +/**
> + * hlist_unhashed - Has node been removed from list and reinitialized?
> + * @h: Node to be checked
> + *
> + * Not that not all removal functions will leave a node in unhashed
> + * state.  For example, hlist_nulls_del_init_rcu() does leave the
> + * node in unhashed state, but hlist_nulls_del() does not.
> + */
> +static inline int hlist_unhashed(const struct hlist_node *h)
> +{
> +       return !h->pprev;
> +}
> +
> +static inline void __hlist_del(struct hlist_node *n)
> +{
> +       struct hlist_node *next = n->next;
> +       struct hlist_node **pprev = n->pprev;
> +
> +       *pprev = next;
> +       if (next)
> +               next->pprev = pprev;
> +}
> +
> +/**
> + * hlist_del - Delete the specified hlist_node from its list
> + * @n: Node to delete.
> + *
> + * Note that this function leaves the node in hashed state.  Use
> + * hlist_del_init() or similar instead to unhash @n.
> + */
> +static inline void hlist_del(struct hlist_node *n)
> +{
> +       __hlist_del(n);
> +       n->next = LIST_POISON1;
> +       n->pprev = LIST_POISON2;
> +}
> +
> +/**
> + * hlist_del_init - Delete the specified hlist_node from its list and initialize
> + * @n: Node to delete.
> + *
> + * Note that this function leaves the node in unhashed state.
> + */
> +static inline void hlist_del_init(struct hlist_node *n)
> +{
> +       if (!hlist_unhashed(n)) {
> +               __hlist_del(n);
> +               INIT_HLIST_NODE(n);
> +       }
> +}
> +
> +/**
> + * hlist_add_head - add a new entry at the beginning of the hlist
> + * @n: new entry to be added
> + * @h: hlist head to add it after
> + *
> + * Insert a new entry after the specified head.
> + * This is good for implementing stacks.
> + */
> +static inline void hlist_add_head(struct hlist_node *n, struct hlist_head *h)
> +{
> +       struct hlist_node *first = h->first;
> +       n->next = first;
> +       if (first)
> +               first->pprev = &n->next;
> +       h->first = n;
> +       n->pprev = &h->first;
> +}
> +
> +#define hlist_entry(ptr, type, member) container_of(ptr, type, member)
> +
> +#define hlist_entry_safe(ptr, type, member) \
> +       ({ typeof(ptr) ____ptr = (ptr); \
> +          ____ptr ? hlist_entry(____ptr, type, member) : NULL; \
> +       })
> +
> +/**
> + * hlist_for_each_entry        - iterate over list of given type
> + * @pos:       the type * to use as a loop cursor.
> + * @head:      the head for your list.
> + * @member:    the name of the hlist_node within the struct.
> + */
> +#define hlist_for_each_entry(pos, head, member)                                \
> +       for (pos = hlist_entry_safe((head)->first, typeof(*(pos)), member);\
> +            pos;                                                       \
> +            pos = hlist_entry_safe((pos)->member.next, typeof(*(pos)), member))
> +
> +/**
> + * hlist_for_each_entry_safe - iterate over list of given type safe against removal of list entry
> + * @pos:       the type * to use as a loop cursor.
> + * @n:         a &struct hlist_node to use as temporary storage
> + * @head:      the head for your list.
> + * @member:    the name of the hlist_node within the struct.
> + */
> +#define hlist_for_each_entry_safe(pos, n, head, member)                        \
> +       for (pos = hlist_entry_safe((head)->first, typeof(*pos), member);\
> +            pos && ({ n = pos->member.next; 1; });                     \
> +            pos = hlist_entry_safe(n, typeof(*pos), member))
> +
> +#endif /* LIST_H */
> --
> 2.32.0
>


-- 
Thanks,
~Nick Desaulniers
