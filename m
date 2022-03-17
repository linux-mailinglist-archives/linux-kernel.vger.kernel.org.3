Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F194DC363
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 10:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbiCQJzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 05:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbiCQJzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 05:55:42 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED381DB3FA
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 02:54:25 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id ja24so4117523ejc.11
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 02:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=gW7kOKK7V7pspvar7Z3AV8JkKJaIW60c95pvf/QvtJU=;
        b=DpYDn7zwd3HjXoXmYbpayeyC4NYCPpPnll9KWttDoEirj+zncLhWZ5Hky8I8q3/4h3
         D8K0z8QEu/KAO7K7vkyIww01hRH72xKVDavzSTShF0t8OJoiXf25i6iipMXr637xdJhD
         Y5a4REyjjGpEUZ8Hrds8DGaQ96fEp3R+AQbIr3SYlNcUdJ4v52i7qm0cGFwKGVHB9MDU
         PIWNLehQbYptux6UYkrpig+SeBzRGtQRkPjmriZu48gcreMWbJ6D8urnqg45BVXAjVLt
         4OlwkmS+PrQkWMOf5PFGdeY6mHfOGIO3n/EJ0ZvsApThdaFapEAB4YjPmsxl4yveBjld
         cs6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=gW7kOKK7V7pspvar7Z3AV8JkKJaIW60c95pvf/QvtJU=;
        b=KQ3ZXpANIuNVVkxNd/n1SYNQedcTevPsVHe/mKuA1tlPBeCd6+wPJQ6BSknlLzQOCB
         kmA6o7zRtX8x+w8xly9ks6hc8b9L8+RrQWYCIbyvLipUI2p4ezkZYWWuk8UgsjZoHYlP
         BmVLhYovy3/lWuED63Yg5LS35YNBTPIAopKhl1giQtsQJR0VrQlxhhn3vkLLsrNpVoDi
         GKfUo7HKRSP2F4yvrZnGUwmPNMDAB7u02QEoDT6uxaMfTGlEtE3JAslcdSxDApOMBn7+
         fefQpVaMGPPAK8YLw0hsea2hunQ70t8jZldO0lb6cEYi+NbMtjMf1wBaQI9fs9faXZY3
         hrAw==
X-Gm-Message-State: AOAM531JoNzEBpgBKXV+DlD4AYxHKEY2d+4ugBoJP0rimQbNt05BwKbY
        nu+o6vGutAcAaqGk5cokCw==
X-Google-Smtp-Source: ABdhPJzAThsGiLrgJiQEuu6BRsWPAxD23J0epCgvB7yBKal7P7Zea9OmtH1mDStEfDXlehxUtOq3hA==
X-Received: by 2002:a17:907:2d0a:b0:6df:8bc8:236f with SMTP id gs10-20020a1709072d0a00b006df8bc8236fmr3053287ejc.527.1647510863598;
        Thu, 17 Mar 2022 02:54:23 -0700 (PDT)
Received: from localhost.localdomain ([46.53.248.53])
        by smtp.gmail.com with ESMTPSA id a1-20020a1709063e8100b006ce06ed8aa7sm2142980ejj.142.2022.03.17.02.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 02:54:23 -0700 (PDT)
Date:   Thu, 17 Mar 2022 12:54:21 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     hui li <juanfengpy@gmail.com>
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: discussing about proc_misc_d_delete
Message-ID: <YjMFTSKZp9eX/c4k@localhost.localdomain>
References: <CAPmgiUJVaACDyWkEhpC5Tfk233t-Tw6_f-Y99KLUDqv6dEq0tw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPmgiUJVaACDyWkEhpC5Tfk233t-Tw6_f-Y99KLUDqv6dEq0tw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	[cc linux-kernel ]

On Mon, Mar 14, 2022 at 11:54:37AM +0800, hui li wrote:
> We noticed that, commit 1da4d377f94 (“proc: revalidate misc dentries”)
> introduced proc_misc_dentry_ops as default ops for /proc dentry,
> dentry ops for /proc/pid/net/stat/ is set as proc_net_dentry_ops,
> which will revalidate dentry each time when this path is resolved and
> dentry for the stat file is removed from dcache. This time, if files
> under /proc/pid/net/stat/ are in use, then dentries of these files
> will be put in lru when closed, which is meanlingless,  as parrent
> dentry (stat) of these files are remove from dcache.
> 
> This can be reproduced when use linux command "while :;do du
> /proc/;done”, then refcount of each dentry of /proc/pid/net/stat/ will
> increase rapidly which should be deleted at once.

Are you worried that reference count can overflow? Those dentries will be
flushed eventually and reference count goes back to normal values.
This is easy to see with "echo 3 >/proc/sys/vm/drop_caches".

> I think this problem may by solved by checking whether parrent
> dentries are in d_cache inside proc_misc_d_delete, or set
> proc_misc_dentry_ops->d_delete = always_delete_dentry, just as what is
> used in kernel version 4.x and 3.x.
> --- a/fs/proc/generic.c
> +++ b/fs/proc/generic.c
> @@ -236,6 +236,16 @@ static int proc_misc_d_revalidate(struct dentry
> *dentry, unsigned int flags)
> 
>  static int proc_misc_d_delete(const struct dentry *dentry)
>  {
> +       struct dentry *p;
> +       for (p = dentry->d_parent; !IS_ROOT(p); p = p->d_parent) {
> +               if (!spin_trylock(&p->d_lock))
> +                       break;
> +               if (unlikely(d_unhashed(p))){
> +                       spin_unlock(&p->d_lock);
> +                       return 1;
> +               }
> +               spin_unlock(&p->d_lock);
> +       }
>         return atomic_read(&PDE(d_inode(dentry))->in_use) < 0;
>  }
