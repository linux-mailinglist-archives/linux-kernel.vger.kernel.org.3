Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972CF592052
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 17:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbiHNPH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 11:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiHNPHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 11:07:53 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C310D19C1B
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 08:07:52 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id r22so4700463pgm.5
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 08:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=jcOfyY3rbjfU9BLS27mCS6B6DeTsKt/CKZatx5u5NeY=;
        b=g4xkGaxSZlIDFYI5+HoHclUGV7OtpUCqFcR9/JTsj8u36VeZZoJuZBUV4GXh1nEKU5
         N+GBFyTnnRREu5SmQtN/ZZVFfUl7KMFGuWKQKEnC+pWh50YEvUUzcpIUix/FMiriCf0j
         ZY466uwhyv7d16k61N2oHiXRismmVpzxb2mQJk2Gao9/1k+tYrzxrZ5uE7wL4fYLwOAE
         QIEJRHR3S6Ms4yBZKE6v/AbQ9pZcXoKSMSHjfTcbeHcpfUF62j+maWKZQlz+QE3Oe3Vi
         Z0vaQInhxMCIXnvhp9QSJDHnCOdTemU7qhcXnsWvUcnBqJwKDEFx3pLix6q7Gba9Aago
         QxEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=jcOfyY3rbjfU9BLS27mCS6B6DeTsKt/CKZatx5u5NeY=;
        b=eZkm5gT0nmPeb9XzSHibg6jzn/B+jWrggOOdZvrTY8r12V3VSP5xO2VrmFVo3ErWjz
         ituRBuLE6zwqsjrwuKFsiGEmelOb+MnU8EGAkYIInMtxLw2r6PNz0EFDlACXX0eCdMDg
         9rmoMwbgPucGx+hQnPorviWDywBs3lauJffDX5VygwmpGQ27gQPbLLyDvQrpBt8qt3k7
         k8XEJQI6a6erAXF0/oIKlNL3zr+KN+ULMCFqNEe81MFu9SgLhDVVVYNLWdP9tnz6vtW8
         wL5QQBxgHYt/H4vD3oi/UfIa5nhHszDxzOzUJ0NPlE+Jfotx/CpNlnMhATmU1McSxfHw
         Uelg==
X-Gm-Message-State: ACgBeo3QpNJ31ua1LqM959oWTsVcQ0eXJrsLl2vB5gT8atnjaG7cxKY5
        DlZVhvY1D4ZM8WZk2Vnx3FI=
X-Google-Smtp-Source: AA6agR4aC3QBiN4WqXcuw8ypbpzsNqg8UXuZikqWY2gJttG72K62mi2CCiysmJnhyy6Hog+Pd2rUAQ==
X-Received: by 2002:a63:e241:0:b0:41b:b374:caf8 with SMTP id y1-20020a63e241000000b0041bb374caf8mr10762109pgj.310.1660489672088;
        Sun, 14 Aug 2022 08:07:52 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id mg18-20020a17090b371200b001f200eabc65sm3232672pjb.41.2022.08.14.08.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 08:07:50 -0700 (PDT)
Date:   Mon, 15 Aug 2022 00:07:45 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     haoxin <xhao@linux.alibaba.com>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/1] mm/slub: release kobject if kobject_init_and_add
 failed in sysfs_slab_add
Message-ID: <YvkPwZGebvsy9WU8@hyeyoo>
References: <20220811071844.74020-1-xhao@linux.alibaba.com>
 <20220811071844.74020-2-xhao@linux.alibaba.com>
 <Yvis1knnMomoeuAx@hyeyoo>
 <6af16141-1f9d-d74c-1a76-c752417a4283@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6af16141-1f9d-d74c-1a76-c752417a4283@linux.alibaba.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 14, 2022 at 09:48:54PM +0800, haoxin wrote:
> 
> 在 2022/8/14 下午4:05, Hyeonggon Yoo 写道:
> > On Thu, Aug 11, 2022 at 03:18:44PM +0800, Xin Hao wrote:
> > > In kobject_init_and_add() function, the refcount is setted by calling
> > > kobject_init() function, regardless of whether the return value is zero
> > > or not, therefore, we must call kobject_del(&s->kobj) to prevent memory
> > > of s->kobj is leaked.
> > TL;DR: IIUC current code works just fine
> > 
> > After thinking more, I don't think the memory leak you said exist.
> > The space for s->kobj is freed in create_cache() when __kmem_cache_create() failed.
> 
> Yes, Agree what you explain,  but  in slab_sysfs_init() function, it also
> call slab_sysfs_add() and  there no other function to release it,  so i
> think the memory leak still exist.

That is in fact not a memory leak.

some early caches are made when sysfs subsystem is not up, so it cannot
call sysfs_slab_add().

So the solution is to call sysfs_slab_add() in late boot process
by using initcall mechanism.

One difference is that early caches does not fail to create
because it failed to register sysfs group - because you do it later.

Then, if kernel succeeded to create caches and then failed to register
sysfs group later, what should it do? release resources that are being used
actively? or just shutdown the system?

No, it just normally uses caches but just ignore the failure. 
Because resources of caches are being used normally, it is not a *leak*.

Thanks!

> > The situation here is:
> > 
> > create_cache() {
> > 	s = kmem_cache_alloc(kmem_cache, GFP_KERNEL)
> > 	err = __kmem_cache_create()
> > 	if (err)
> > 		goto out_free_cache;
> > 	
> > out_free_cache:
> > 	kmem_cache_free(s) // s is freed here (including its kobject)
> > 	[...]
> > }
> > 
> > __kmem_cache_create() {
> > 	[...]
> > 
> > 	err = sysfs_slab_add();
> > 	if (err) {
> > 		__kmem_cache_release(s);
> > 		return err;
> > 	}
> > }
> > 
> > The primary goal of kobject_put() is to call release() function
> > of kobj_type (when reference becomes zero), which is kmem_cache_release().
> > 
> > kmem_cache_release() {
> > 	__kmem_cache_release(s)
> > 	kfree_const(s->name)
> > 	kmem_cache_free(s)
> > }
> > 
> > But when slab_sysfs_add() failed, __kmem_cache_release() and
> > create_cache() releases resources related to the cache.
> > (Also its name is freed in kmem_cache_create_usercopy().)
> > 
> > So IIUC current code works just fine!
> > 
> > > Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
> > > ---
> > >   mm/slub.c | 7 +++----
> > >   1 file changed, 3 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/mm/slub.c b/mm/slub.c
> > > index b1281b8654bd..940a3f52e07c 100644
> > > --- a/mm/slub.c
> > > +++ b/mm/slub.c
> > > @@ -5981,19 +5981,18 @@ static int sysfs_slab_add(struct kmem_cache *s)
> > >   	err = sysfs_create_group(&s->kobj, &slab_attr_group);
> > >   	if (err)
> > > -		goto out_del_kobj;
> > > +		goto out;
> > >   	if (!unmergeable) {
> > >   		/* Setup first alias */
> > >   		sysfs_slab_alias(s, s->name);
> > >   	}
> > > +	return err;
> > >   out:
> > >   	if (!unmergeable)
> > >   		kfree(name);
> > > +	kobject_put(&s->kobj);
> > >   	return err;
> > > -out_del_kobj:
> > > -	kobject_del(&s->kobj);
> > So related resources are released in create_cache(), instead of by
> > calling kobject_put().
> > 
> > But kobject_del() is still needed because it should unlink kobject
> > hierarchy when kobject_add() succeeded but sysfs_create_group() failed!
> > 
> > > -	goto out;
> > >   }
> > >   void sysfs_slab_unlink(struct kmem_cache *s)
> > > -- 
> > > 2.31.0
> > > 

-- 
Thanks,
Hyeonggon
