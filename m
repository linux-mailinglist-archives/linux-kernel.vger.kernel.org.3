Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB6759E5E1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 17:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243063AbiHWPVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 11:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242920AbiHWPUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 11:20:50 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905A21EA9CA
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 03:43:15 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id v10so13093326ljh.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 03:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=zlhiOYsPO1lxnFbk6GeooWOYWo0I9KXmwvWTtnk2Kvc=;
        b=4NHvRurmuAP9DAcDX01JpyDcV3gqk6Z6qkCh7qC6bjAqcqi5CpmWuo1ZGp9ivNtcRw
         MbQaAui1oUSF6V0T8avgj6at41atHJd1dTU6UPDjKZSS0WqCPP+W8YMHq/Zehair5qLX
         Sgk/ClhkHRJOKxkihrsqSL1iFamu6UZwcyD3uK/fcukboiwPfmPYYCaFEf9lk5NLMTxi
         p60yA3BzW4AEtrpiMRdZOmHzWphG1y+zNmQcuNzEdUHgs/+X1Y3HZsk8+RA1eizgBxa5
         wEHBEfmaWiZ5Hs0hRtfZ3KmgZdz9ROxLpAJ63h4KDV4e/YAK0sjcRwY2KlriQ0THzR5e
         BVNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=zlhiOYsPO1lxnFbk6GeooWOYWo0I9KXmwvWTtnk2Kvc=;
        b=vvMUFkdKpt0h1Ckw6G102vAha9S+9kxsRP2AQ+j+MlJrcQD+vl2m3gNZgXjNWYRG6u
         I8Af6dGYiN0m2gWEK5K4e7pPhi50Cl8X0mLD3j0HdNvaYlRQaIDe8Ljfs9dMuhYJdCOj
         ksNTPVynI9tnyUnIcNeed7T9uhHNM9RFjt8syb+TjUU2hkQRzQpR7RAHdpuX35Z3+kxF
         Rs4GLDBTylwBGwWN29Zohp3OLLS5j06VjxCvbM5/wwbp6hrKwRt2bEKLHJTi0Y4wkTu5
         DWQVYxhd+iijj/cTPEoyi5+aJS4S89JSAzbVfOYunoqwV58mW9C7+tAWzqtUfIKPu+oD
         IaZw==
X-Gm-Message-State: ACgBeo3HKBpAcurFyjRjPKFNiyFyMb0pgj6q+ugb8f6DcGC4Zl1zmHb+
        W1XukWR5Pk/bsTRo56Fv4w0BoKthtKnE7A==
X-Google-Smtp-Source: AA6agR7b9gpe4aYPGnXGo0tDfbgF0Ur+9tlHzeVbrqFwVOBdVDEQLeBsowX7fwP9TwX1hQUTSxYu+Q==
X-Received: by 2002:a2e:a307:0:b0:261:ce0c:365f with SMTP id l7-20020a2ea307000000b00261ce0c365fmr2390014lje.288.1661251358119;
        Tue, 23 Aug 2022 03:42:38 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.143])
        by smtp.gmail.com with ESMTPSA id h19-20020a2e5313000000b00261c848af1dsm1401863ljb.46.2022.08.23.03.42.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 03:42:37 -0700 (PDT)
Message-ID: <ab83125e-bac4-c5eb-160b-7f5611f5fcb0@openvz.org>
Date:   Tue, 23 Aug 2022 13:42:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH] simple_xattr: switch from list to rb_tree
Content-Language: en-US
To:     Christian Brauner <brauner@kernel.org>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>, mkoutny@suse.com,
        tj@kernel.org, gregkh@linuxfoundation.org, hannes@cmpxchg.org,
        kernel@openvz.org, linux-kernel@vger.kernel.org, mhocko@suse.com,
        shakeelb@google.com, songmuchun@bytedance.com,
        viro@zeniv.linux.org.uk
References: <62188f37-f816-08e9-cdd5-8df23131746d@openvz.org>
 <d73bd478-e373-f759-2acb-2777f6bba06f@openvz.org>
 <20220818131928.6zymceds5ka7hg4u@wittgenstein>
From:   Vasily Averin <vvs@openvz.org>
In-Reply-To: <20220818131928.6zymceds5ka7hg4u@wittgenstein>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/18/22 16:19, Christian Brauner wrote:
> On Thu, Aug 18, 2022 at 12:12:30PM +0300, Vasily Averin wrote:
>> The patch was announced here:
>> https://lore.kernel.org/all/62188f37-f816-08e9-cdd5-8df23131746d@openvz.org/
>> "5) simple_xattrs: replace list to rb-tree
>>   This significantly reduces the search time for existing entries."
>>
>> It was compiled but was not tested yet.
>> ---
>> Currently simple_xattr uses a list to store existing entries.
>> If the list grows, the presence check may be slow and potentially
>> lead to problems. Red-black tree should work more efficiently
>> in this situation.
>>
>> This patch replaces list to rb_tree and switches simple_xattr_* calls
>> to its using.
>>
>> Signed-off-by: Vasily Averin <vvs@openvz.org>
>> ---
> 
> I think the background for the performance issues in the commit message
> would be helpful and I have a few comments. Also, trying to test whether the
> lockups are gone due to the rbtree switch would be +1. 
> 
> This will likely conflict with some acl/xattr changes I have lined up so
> if we decide to proceed I wouldn't mind dealing with this series if
> there are no objections.

I would be very grateful if you pick up this issue.
Unfortunately I do not have enough time to process it properly. 

I'm agree with all your remarks, however I would like to comment following one.

> I think keeping this rather close to the original code might be nicer.
> I find the code more difficult to follow afterwards. So how about
> (COMPLETELY UNTESTED) sm like:

I had this idea too, however it have one disadvantage in rb-tree scenario:
in the most typical case, when adding a new entry, we run through the tree twice:
first in simple_xattr_rb_search() and then in simple_xattr_rb_insert().
In my patch version we run through the rb-tree once only.

However now I think we can save closest neighbour on "search" stage, 
and use it on "insert" stage. This should be safe because both functions
are called under the same spinlock. 

> @@ -1077,30 +1139,40 @@ int simple_xattr_set(struct simple_xattrs *xattrs, const char *name,
>         }
> 
>         spin_lock(&xattrs->lock);
> -       list_for_each_entry(xattr, &xattrs->head, list) {
> -               if (!strcmp(name, xattr->name)) {
> -                       if (flags & XATTR_CREATE) {
> -                               xattr = new_xattr;
> -                               err = -EEXIST;
> -                       } else if (new_xattr) {
> -                               list_replace(&xattr->list, &new_xattr->list);
> -                               if (removed_size)
> -                                       *removed_size = xattr->size;
> -                       } else {
> -                               list_del(&xattr->list);
> -                               if (removed_size)
> -                                       *removed_size = xattr->size;
> -                       }
> -                       goto out;
> +       /* Find any matching xattr by name. */
> +       xattr = simple_xattr_rb_search(&xattrs->rb_root, name);
> +       if (xattr) {
> +               if (flags & XATTR_CREATE) {
> +                       /* Creating request but the xattr already existed. */
> +                       xattr = new_xattr;
> +                       err = -EEXIST;
> +               } else if (new_xattr) {
> +                       /* Replace the existing xattr. */
> +                       rb_replace_node(&xattr->node, &new_xattr->node,
> +                                       &xattrs->rb_root);
> +                       if (removed_size)
> +                               *removed_size = xattr->size;
> +               } else {
> +                       /* No new xattr specified so wipe the existing xattr. */
> +                       rb_erase(&xattr->node, &xattrs->rb_root);
> +                       if (removed_size)
> +                               *removed_size = xattr->size;
>                 }
> +               goto out;
>         }
> +
>         if (flags & XATTR_REPLACE) {
> +               /* There's no matching xattr so fail on replace. */
>                 xattr = new_xattr;
>                 err = -ENODATA;
>         } else {
> -               list_add(&new_xattr->list, &xattrs->head);
> -               xattr = NULL;
> +               /*
> +                * We're holding the lock and verified that there's no
> +                * pre-existing xattr so this should always succeed.
> +                */
> +               WARN_ON(!simple_xattr_rb_insert(&xattrs->rb_root, new_xattr))
>         }
> +
>  out:
>         spin_unlock(&xattrs->lock);
>         if (xattr) {
> 
> 
>> -		xattr = new_xattr;
>> -		err = -ENODATA;
>> -	} else {
>> -		list_add(&new_xattr->list, &xattrs->head);
>> -		xattr = NULL;
>> -	}
>> -out:
>>  	spin_unlock(&xattrs->lock);
>>  	if (xattr) {
>>  		kfree(xattr->name);
