Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9054828CE
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 01:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbiABAGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jan 2022 19:06:45 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:49226 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbiABAGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jan 2022 19:06:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C90C960C61;
        Sun,  2 Jan 2022 00:06:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18894C36AEC;
        Sun,  2 Jan 2022 00:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641082004;
        bh=ZAUy90d6O2KXPxJR35W4rfyA39P/1qMUOwjjl8GsxCc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Oe4N2coccA5BDgwcczeS7n88UUIcCNwQwcajKE7YyAvaExQOmpvhn7cUPJPilUYDD
         BjXNsQGT+d+38P0/1l95/sPEPVvwkSjukwVWDYY7mR/e9d4VueD4sUFu6Gaz6jCG+U
         OOFdFfpFVNSnFI8pocqT6nHAAhOoQyqZFupUKBcwmR9kJaOAA+mNOBRpyqbLeI4G6o
         G2VxehkTeChlljXPONBnnY5olzZgY160C4CXZk7rDwC1twWBoxQ1X6TFS3KgtSQwc3
         v5zE2gmbb1nBKqlwFdtm1dx7xGZbc/rIzZpI2qRhuX43cO4KH37AjdfNtspPM4FzxG
         oGsG/33nSiNnA==
Received: by mail-yb1-f179.google.com with SMTP id e202so46656693ybf.4;
        Sat, 01 Jan 2022 16:06:43 -0800 (PST)
X-Gm-Message-State: AOAM533ZkxGfPhEr6dyzR9uyuQpQfIDTDrHJzQQU0pGi5VzE9oFVejf2
        LThvqygGWSX7HyqIbuTXAWL3aqQjdS+TD5j4B6Q=
X-Google-Smtp-Source: ABdhPJwdbYaJtCvfmIiaaj7O/eygUcSXYW0xsFgFpSc8iYQgx7lh9fqWlwjn4IuDYZ3HrHceOBN/3j9+w5UMh+RdI2s=
X-Received: by 2002:a25:3745:: with SMTP id e66mr5560519yba.208.1641082003191;
 Sat, 01 Jan 2022 16:06:43 -0800 (PST)
MIME-Version: 1.0
References: <20211226022411.22437-1-rdunlap@infradead.org>
In-Reply-To: <20211226022411.22437-1-rdunlap@infradead.org>
From:   Song Liu <song@kernel.org>
Date:   Sat, 1 Jan 2022 16:06:32 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5sC5bi3CfAtL1iwHHUbHvsVc0f0y6rn7szK1okBAaEWw@mail.gmail.com>
Message-ID: <CAPhsuW5sC5bi3CfAtL1iwHHUbHvsVc0f0y6rn7szK1okBAaEWw@mail.gmail.com>
Subject: Re: [PATCH] md: fix spelling of "its"
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 25, 2021 at 6:24 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Use the possessive "its" instead of the contraction "it's"
> in printed messages.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Song Liu <song@kernel.org>
> Cc: linux-raid@vger.kernel.org

Applied to md-next.

Thanks!

> ---
>  drivers/md/md-cluster.c |    2 +-
>  drivers/md/md.c         |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> --- linux-next-20211224.orig/drivers/md/md.c
> +++ linux-next-20211224/drivers/md/md.c
> @@ -8402,7 +8402,7 @@ int md_setup_cluster(struct mddev *mddev
>         spin_lock(&pers_lock);
>         /* ensure module won't be unloaded */
>         if (!md_cluster_ops || !try_module_get(md_cluster_mod)) {
> -               pr_warn("can't find md-cluster module or get it's reference.\n");
> +               pr_warn("can't find md-cluster module or get its reference.\n");
>                 spin_unlock(&pers_lock);
>                 return -ENOENT;
>         }
> --- linux-next-20211224.orig/drivers/md/md-cluster.c
> +++ linux-next-20211224/drivers/md/md-cluster.c
> @@ -574,7 +574,7 @@ static int process_recvd_msg(struct mdde
>         int ret = 0;
>
>         if (WARN(mddev->cluster_info->slot_number - 1 == le32_to_cpu(msg->slot),
> -               "node %d received it's own msg\n", le32_to_cpu(msg->slot)))
> +               "node %d received its own msg\n", le32_to_cpu(msg->slot)))
>                 return -1;
>         switch (le32_to_cpu(msg->type)) {
>         case METADATA_UPDATED:
