Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 952214DE1A7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 20:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240317AbiCRTPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 15:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233464AbiCRTPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 15:15:15 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238291A6343
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 12:13:55 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id p10-20020a056820044a00b00320d7d4af22so11298616oou.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 12:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZS9ok05PYKlNZu1rxfnTOBmw2CBJcOeQT2M61z+cNaM=;
        b=jIcNV6Y6FHF5WfQofdJeZLGkRRnKmqhlhP8GAhYV5fqxojJwo/iFsNSPY+BkpqUx7z
         cVnP2eLTY1pfuAozuXk/issL2JSOMhtZA+gPLzBCLnV4X2gfx+e35DiEB0llqIVUxNaw
         zClS82Yj+F+Z+MzHVvIlgQULs/WrocF2gkjtdtohEcYlpq/M9+X+CyeGgwengz0wUlsN
         iQVpXAo54MRxJIry/OK2L2T49djs92Umr4iyRknwjjs9Uw2/moDkBYWu7YyiUGTZRmw2
         lCecRMLp+NgziUvdg1zC8O4201TG6JjJgSb2GpJede3OUOanB2ifRJDxvRCQ3D+3N918
         q3WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZS9ok05PYKlNZu1rxfnTOBmw2CBJcOeQT2M61z+cNaM=;
        b=r7VKIN7LC5bldaVkiBsj6n8QdVAfxgA8oVTJfMipxOy3I19F66AV5UD/TYgEFDidLp
         ybTOXc/ZVcPfRisCyAhbGwBY5Jz5QWb99EAtCBchJ48KG7sYl1e5+FHXrxoR25aDecLF
         ujfOQHn5Ar+cRQ/K0wfnGC0rQyUIVmNfCpKxTKSctlQ0lfr3PGMFC1q9h1oQ6mBvut5G
         K+yWqUv+7cahh6dLlXUBcYKR+ysiQunBqqGYWmih8NJekSqcr8xfVR2boOtyWVK7pBty
         siylASFh1RhojYbDqlCg5YSVt1ceAlCAWAR38yA3lXi387UQICm+/RwtvOBuB4dXRua2
         eeYQ==
X-Gm-Message-State: AOAM532FQ0N8vTm1js7fL3iVs1X/p9xSuq5KPzC2kBuqBT26z5FYhGo4
        XpK8HmBF88rZa7tl460t9BIN4aIkNHU7zeAbX3Xt/Q==
X-Google-Smtp-Source: ABdhPJwtCprt5WfOMNYtaolfRijaJQkSfbdULl/jCbQlU9R26vgNkGVJ0PVOEQw7N6gWxYJnOirUUqEN1URoIj/hfk0=
X-Received: by 2002:a05:6870:58aa:b0:dd:a976:5e8f with SMTP id
 be42-20020a05687058aa00b000dda9765e8fmr5294282oab.112.1647630833948; Fri, 18
 Mar 2022 12:13:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220318191012.4113266-1-daeho43@gmail.com>
In-Reply-To: <20220318191012.4113266-1-daeho43@gmail.com>
From:   Daeho Jeong <daehojeong@google.com>
Date:   Fri, 18 Mar 2022 12:13:18 -0700
Message-ID: <CABdZyexJoHaymH5Xqn=TcPLf8ek7H9i3vPE=AJz=6Asd=+nAxw@mail.gmail.com>
Subject: Re: [PATCH] f2fs: make gc_urgent and gc_segment_mode sysfs node readable
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Plz, sorry, ignore this one.

On Fri, Mar 18, 2022 at 12:10 PM Daeho Jeong <daeho43@gmail.com> wrote:
>
> From: Daeho Jeong <daehojeong@google.com>
>
> Changed a way of showing values of them to use strings.
>
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
>  fs/f2fs/sysfs.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index fe29bcb70f46..f2613cc83888 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -41,6 +41,16 @@ enum {
>         ATGC_INFO,      /* struct atgc_management */
>  };
>
> +const char *gc_mode_names[MAX_GC_MODE] = {
> +       "GC_NORMAL",
> +       "GC_IDLE_CB",
> +       "GC_IDLE_GREEDY",
> +       "GC_IDLE_AT",
> +       "GC_URGENT_HIGH",
> +       "GC_URGENT_LOW",
> +       "GC_URGENT_MID"
> +};
> +
>  struct f2fs_attr {
>         struct attribute attr;
>         ssize_t (*show)(struct f2fs_attr *, struct f2fs_sb_info *, char *);
> @@ -316,8 +326,13 @@ static ssize_t f2fs_sbi_show(struct f2fs_attr *a,
>                 return sysfs_emit(buf, "%u\n", sbi->compr_new_inode);
>  #endif
>
> +       if (!strcmp(a->attr.name, "gc_urgent"))
> +               return sysfs_emit(buf, "%s\n",
> +                               gc_mode_names[sbi->gc_mode]);
> +
>         if (!strcmp(a->attr.name, "gc_segment_mode"))
> -               return sysfs_emit(buf, "%u\n", sbi->gc_segment_mode);
> +               return sysfs_emit(buf, "%s\n",
> +                               gc_mode_names[sbi->gc_segment_mode]);
>
>         if (!strcmp(a->attr.name, "gc_reclaimed_segments")) {
>                 return sysfs_emit(buf, "%u\n",
> --
> 2.35.1.894.gb6a874cedc-goog
>
