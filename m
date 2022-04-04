Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3144F1C13
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381651AbiDDVXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379825AbiDDSLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 14:11:31 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613993A1BB
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 11:09:34 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id by7so14106292ljb.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 11:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uz4lPE2rdo2tRM1taU9hjtHkKN6cEscjMgtJGGpCZK0=;
        b=AKh+Xx8Jri22FLpKBD4E3RoftVzjoBrDVxvOksJJs1GiZpvdGJdEX2vPXJvyGWVcDC
         Tsws7vziNMKhEc1zFl/txeNmPo/Wx7XJU0EJZq+3mQ6ntGZLXmpSi8w6nhlFDGUBzWmX
         Yq+MB4VarfRzItJWG71o6LZ/2bUZ5IMRLDkDDxXbx8gBkWa58++9ibIS0lfl8QXbFYIc
         e6nDCpIHZIZkDQigSykJm8MIxAStv7nYv6rs85ZIHdGzECyEPFVpFeNZslA0YGNsgm/J
         vb7bEkgtvx02wVWUHzX1C4z68lOmkxFEyA4y4BJ3/zRjlRU1yBfRbZ5ORhOrFwx5FwrM
         BsDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uz4lPE2rdo2tRM1taU9hjtHkKN6cEscjMgtJGGpCZK0=;
        b=bc4GBUiNShsejMNaP/uJXtehM69fw0cRqMkq1dEwkJ14Z9jrk6S1ln/kKj/Ytrk3E6
         ae2lfaAIlNxoPdDdBXqBMXMHSpDYsOlVSFHP5TASyzvvOmaJCORQk9VfybEjIpfwSGqn
         Ba2HzaMP9hKWTFC8mMAmDPRc/4mUUg1YsmFz3VqkKI8OUEorCi06ScDG98tAOfRggtli
         uo0uq1BlBPmsXPNUXxARH/fh4po888ooQoDMot+JIjMvqgC/cKG4+SRFSkpWnLjDAszj
         LNviWeflSaKAD/cJwjut0feeNwUnbWD6TNY+Z9BTQbnPD1PWKzGTgMf23B3Umlvu7lqH
         Sleg==
X-Gm-Message-State: AOAM533kRuDyM042CYznj740177FGkwU3AgLSaR7hZXgGeOoUEWkA9KS
        S+9tEpTvKEbM4UZOVsuQjSUqVFLSQR7e/UoyKiFFQkcJWRmStg==
X-Google-Smtp-Source: ABdhPJyEamkccvVwsWuiMfR8yOe39RymGH9/TLP+zLi/6TZpWH3im6mHt1c9jyr67LnqZRKEZnZwcP1sY9HjUQIPna4=
X-Received: by 2002:a05:651c:1588:b0:249:b90d:253c with SMTP id
 h8-20020a05651c158800b00249b90d253cmr525887ljq.408.1649095772447; Mon, 04 Apr
 2022 11:09:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220318000055.79280-1-colin.i.king@gmail.com>
In-Reply-To: <20220318000055.79280-1-colin.i.king@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 4 Apr 2022 11:09:21 -0700
Message-ID: <CAKwvOd=GRBTs43JcwMBS=aEYtOXLP+SVEj3d89LjcfJJZLOZ5Q@mail.gmail.com>
Subject: Re: [PATCH] amd64-agp: remove redundant assignment to variable i
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
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

On Thu, Mar 17, 2022 at 5:01 PM Colin Ian King <colin.i.king@gmail.com> wrote:
>
> Variable i is being assigned a value that is never read, it is being
> re-assigned later in a for-loop. The assignment is redundant and can
> be removed.
>
> Cleans up clang scan build warning:
> drivers/char/agp/amd64-agp.c:336:2: warning: Value stored to 'i' is
> never read [deadcode.DeadStores]
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  drivers/char/agp/amd64-agp.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/char/agp/amd64-agp.c b/drivers/char/agp/amd64-agp.c
> index dc78a4fb879e..5f64991c73bf 100644
> --- a/drivers/char/agp/amd64-agp.c
> +++ b/drivers/char/agp/amd64-agp.c
> @@ -333,7 +333,6 @@ static int cache_nbs(struct pci_dev *pdev, u32 cap_ptr)
>         if (!amd_nb_has_feature(AMD_NB_GART))
>                 return -ENODEV;
>
> -       i = 0;
>         for (i = 0; i < amd_nb_num(); i++) {
>                 struct pci_dev *dev = node_to_amd_nb(i)->misc;
>                 if (fix_northbridge(dev, pdev, cap_ptr) < 0) {
> --
> 2.35.1
>
>


-- 
Thanks,
~Nick Desaulniers
