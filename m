Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A70234E6414
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 14:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350437AbiCXN3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 09:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236979AbiCXN3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 09:29:24 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877B0A7752
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 06:27:52 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id mj15-20020a17090b368f00b001c637aa358eso9525577pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 06:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=35DPDgwgR7o28S5QkagymkokXPJZP06Ii37nZqLEji8=;
        b=TVmJKgB/OzleOMpj1pIVXCTYSugZonqt1iUBoppqzRKjaqxEB1Z4oZpJ1y3TllNPxL
         ZlpC4VhRzwN6c44GQ/VJ0PJWp0h8KnNkDtiLIkrO5nK6qC09V7qpMKQo70feblyeZO/B
         kQt3XHgxv80rA6j4naLrW7VHjmAO/FUbWfNTHF46w+WzVx8y7mkh9LnnXpfwVdEj6k7r
         8bFQqq2wXr9+Z7t3qcQSw+WEJve5WbedHcwQeMbztO0em9qplQPr4vZUTb8Tv0qSvDdT
         gT7NZwSf/C8KzyY64NkxnzHIydjlC0EsTyMo1gs1PgqLY3NJkSEzr/DAmz8BQIgk5Gop
         DU1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=35DPDgwgR7o28S5QkagymkokXPJZP06Ii37nZqLEji8=;
        b=fVlTuk8Qni2ZgU8tRQySnK/yCxuX1MFF30Dtxh54knutB4DDa035wVcs5J6iSOkLln
         LMYtlNjYO0Rk+v+Xk30C3EkoOSMolxSMh34anaiz8323kY+e9wbVZyhjTWDSrKX3smNr
         F+MsAyuBYq9z6rTrlg3ri6cEFD4SUQUUkKut6TYGL6WcM+37dbnAfBwyCYbAsIt6rmNf
         XgymAgKRPzBSyKtxKXXFFrLdmrDbx7e+x989OjIJuP+krIjDaEuKqrDxIwwo2XRuOPq8
         4DBXO244mhpmUglPvV14wAXeC82l6VlnAerZIdPSivSqeKIkzyd55kXxHDJ4HyTX9feZ
         hvWg==
X-Gm-Message-State: AOAM530EO36lgk0HsqFPCNHSzYnQHh1cnu1oAxYlkR/fCJolrDWmYVg+
        nwv135DKWBFHftO+qFhuX70kDW31xKfReIflvTA=
X-Google-Smtp-Source: ABdhPJxeqBu7n+Zf/rPdKKKFm/6W80UtX3/8NZoJ6RYIq0AE4XmWppWuTad4TO8fH+1z2oKV+zytXS6quAtYCAL+X68=
X-Received: by 2002:a17:902:70c1:b0:154:667f:e361 with SMTP id
 l1-20020a17090270c100b00154667fe361mr6041346plt.148.1648128471988; Thu, 24
 Mar 2022 06:27:51 -0700 (PDT)
MIME-Version: 1.0
References: <1648112848-29052-1-git-send-email-baihaowen@meizu.com>
In-Reply-To: <1648112848-29052-1-git-send-email-baihaowen@meizu.com>
From:   Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date:   Thu, 24 Mar 2022 14:27:40 +0100
Message-ID: <CAMeQTsZ3bxs=3o0-WvXa8RYY83BVn9X-m9TSkqmxTpHxpYS1_g@mail.gmail.com>
Subject: Re: [PATCH] drm: gma500: clean up some style problems reported by checkpatch.pl
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 10:16 AM Haowen Bai <baihaowen@meizu.com> wrote:
>
> WARNING: Statements should start on a tabstop
>
> WARNING: Missing a blank line after declarations
>
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>

Hi, thanks for the patch.

> ---
>  drivers/gpu/drm/gma500/mid_bios.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/gma500/mid_bios.c b/drivers/gpu/drm/gma500/mid_bios.c
> index 7e76790..71942c2 100644
> --- a/drivers/gpu/drm/gma500/mid_bios.c
> +++ b/drivers/gpu/drm/gma500/mid_bios.c
> @@ -50,8 +50,8 @@ static void mid_get_fuse_settings(struct drm_device *dev)
>         DRM_INFO("internal display is %s\n",
>                  dev_priv->iLVDS_enable ? "LVDS display" : "MIPI display");
>
> -        /* Prevent runtime suspend at start*/
> -        if (dev_priv->iLVDS_enable) {
> +       /* Prevent runtime suspend at start*/

There should also be a space between "start" and "*/" at the end of the line

-Patrik

> +       if (dev_priv->iLVDS_enable) {
>                 dev_priv->is_lvds_on = true;
>                 dev_priv->is_mipi_on = false;
>         } else {
> @@ -325,6 +325,7 @@ static void mid_get_vbt_data(struct drm_psb_private *dev_priv)
>  int mid_chip_setup(struct drm_device *dev)
>  {
>         struct drm_psb_private *dev_priv = to_drm_psb_private(dev);
> +
>         mid_get_fuse_settings(dev);
>         mid_get_vbt_data(dev_priv);
>         mid_get_pci_revID(dev_priv);
> --
> 2.7.4
>
