Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006A9553620
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 17:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352674AbiFUPbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 11:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235961AbiFUPbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 11:31:11 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F123A2AC4F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 08:31:08 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id x6-20020a1c7c06000000b003972dfca96cso7463234wmc.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 08:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YT/g1l+EhzOy6M+nS+bPwU5QfP9vQQuvmLes4FWs9nA=;
        b=zm+1B948VVBoC9zdmS3mRHOhlTzOOstEX1Msg5XVi49sfVCOnSIpk8b2dkPB7fCY+b
         Goajm2o/+0sxjayYUUrpCaauVigP981n/ef88s3lg6Uqd5IfgNwqM53vWLn6uYW44CJO
         lkW+eFe9poXybTn/y6UBnLxcT0pP53FHB87n0FydsMHrArcwuEOqj0Ylj1LCz2b+ZhfP
         Kx7dzCo3ZOFJQwnU+k51JdhWtP75KrzU6M7WiyIbwxRqRT05baeCa9ONMuUMG7eAPqW4
         f8ljW+lxxbIxsxEiA4J/qXviadQuo9KvaXEr4SF9Om93jcCcnr4DsHENocUxEsi/XAcw
         VsDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YT/g1l+EhzOy6M+nS+bPwU5QfP9vQQuvmLes4FWs9nA=;
        b=3hA2ET9wYX2+y6vBD6zs1hFaS7sejUuKOqD+4DoTrcb6MO2k5cuoxp/uL2lomRdsLj
         uq6nPlGu5H/LFignFy9FYlr1ZcfRUocYfNVqecYdAhs2w+H04phfZK0QWT/aARJsK2Fd
         bP7c1xxQvLoL7PHo8W6mwh76sO9YXPeCT6fkkf7LyUC4T/oJYEHd3qWwsXCTm3Q0njrp
         dd5inxVX04f9BYXFWf5GEtYrDWGfNyOM8U6tT4BUmFUoH1HQg+evZT4JlDNbwfl0aQm+
         B2QhPLW0yWb9E5WuHrRPF1H3DCIefnNie9ZKBEHZOMkb1qKtce4cVSjfvrW9W5oij+kL
         CwQQ==
X-Gm-Message-State: AJIora+WwBC55DKgkVO1vs6Hg3U6jJCwQY9jH/Rx30mwyoxsihCaYFbO
        YosETfQSX5YuC/br2B5FcKqTI/k6P9S/DAS8eklf
X-Google-Smtp-Source: AGRyM1tFlJzbaN0YRLI5nskwlap9strrp/mdu6n5GbB1zR8mMrlXwMjuJjoJ9Y5PdA6fFEJb3dRbMrNRS3BfacwgBKA=
X-Received: by 2002:a05:600c:2215:b0:39c:55a0:9531 with SMTP id
 z21-20020a05600c221500b0039c55a09531mr30734498wml.29.1655825467479; Tue, 21
 Jun 2022 08:31:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220621063824.241527-1-xiujianfeng@huawei.com>
In-Reply-To: <20220621063824.241527-1-xiujianfeng@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 21 Jun 2022 11:30:56 -0400
Message-ID: <CAHC9VhTXf=L97d9zuMOXr0JOm-vVgifJx7cSOJT+wLZZ7uA=gg@mail.gmail.com>
Subject: Re: [PATCH -next] selinux: Cleanup the enum SEL_COMPAT_NET
To:     Xiu Jianfeng <xiujianfeng@huawei.com>
Cc:     stephen.smalley.work@gmail.com, eparis@parisplace.org,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 2:40 AM Xiu Jianfeng <xiujianfeng@huawei.com> wrote:
>
> The "compat_net" compatibility code has been removed since commit
> 58bfbb51ff2b ("selinux: Remove the "compat_net" compatibility code"),
> so SEL_COMPAT_NET need to be removed as well.
>
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>  security/selinux/selinuxfs.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index 8fcdd494af27..7115ca91ec05 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -58,7 +58,6 @@ enum sel_inos {
>         SEL_DISABLE,    /* disable SELinux until next reboot */
>         SEL_MEMBER,     /* compute polyinstantiation membership decision */
>         SEL_CHECKREQPROT, /* check requested protection, not kernel-applied one */
> -       SEL_COMPAT_NET, /* whether to use old compat network packet controls */
>         SEL_REJECT_UNKNOWN, /* export unknown reject handling to userspace */
>         SEL_DENY_UNKNOWN, /* export unknown deny handling to userspace */
>         SEL_STATUS,     /* export current status using mmap() */

Thanks for the patch, but keeping the old enum value is harmless
considering the size of sel_inos and I would rather see it preserved
just on the odd chance that some userspace tool is relying on specific
inode values.

-- 
paul-moore.com
