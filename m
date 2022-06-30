Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4580C562722
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 01:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbiF3XeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 19:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiF3XeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 19:34:03 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198F759243;
        Thu, 30 Jun 2022 16:34:00 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id fi2so943925ejb.9;
        Thu, 30 Jun 2022 16:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TFqfUF78j/Tk5aGxQYB7DDx8w1mScgju1rP7Z1XpJBA=;
        b=RSj7apgIcVo7OW5YhyHL12a9tRznXdiBY1kkukptNhHiZJnolm8DsDGaRwU9doP6Bh
         NF6IwyPZvsaNLVXXEOMKj60upVErX2xVLASyxiW4cv2NKv+lMH5PvvPzEHisl3dN/fJR
         Ox2kzRHs4goDIv39i8fpvMjm2J9fKF9wAClt8fMjlfWZQ0wZO3fHjKGZTVWpr5pk+hDw
         N5eD8tj2GJHDquEklVSgJOQ1VlS3gtHDpkXQWz+8v8GKmB3eMtQBuLpUvzArzKdZ07Av
         lHyf+m2fB60Z9IMj2IbZ9fc0XCSHSNbk/rMUIO66ubcvcX3k09wwiL4X7/tZ4VG29N2M
         anSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TFqfUF78j/Tk5aGxQYB7DDx8w1mScgju1rP7Z1XpJBA=;
        b=ExrsJfSu6INmkuqKjNK1RGeZGRkJzJSVph2FSp4QTCqqtKoJA5HH2vsCoL5lR+b6Wk
         5K4GvQ6uqkQWEiSrOjOc9lziV6rvgRiIiPqB8g7k2fenpDG5LXA18wCeybtSB8zOG7Ph
         106JKFZbRwcd8JpN6czf0CO+KOvzwDJrD7VrZ5iwbj69QEK+AB3Ex4saQkMKapKrhJD6
         kSwU218sjZ68eS0AirfnkPRCR7o8tELBbrYXLYII20PYr1csxBfyGWzBz9LWYCmXKhHS
         mRcQCsMn9G7leq38V6Qd4UTEbxGNgk5xY2xyUhRyq1NGDDDuOdoR3tFygE8NDwKxRNdB
         3AiA==
X-Gm-Message-State: AJIora/kYjQVCtesYvQYCgG1yvrb1wAfHSgf4OPO9JlYohGCD9My+Oyf
        blZCpQLqiKB0AKXMhvdNVqIRMbuLkK8jyv3+R/0=
X-Google-Smtp-Source: AGRyM1vlteZwA/CUwg+vWaMGq1OuWVA8m5V52q4hDFoMaNMHOgC/3HcHz3o52T4WUGYq2bbCAdPVejXO63d/VvydWgE=
X-Received: by 2002:a17:907:2706:b0:72a:3216:96bd with SMTP id
 w6-20020a170907270600b0072a321696bdmr10530712ejk.658.1656632038712; Thu, 30
 Jun 2022 16:33:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220701085657.230b2e13@canb.auug.org.au>
In-Reply-To: <20220701085657.230b2e13@canb.auug.org.au>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 30 Jun 2022 19:33:46 -0400
Message-ID: <CADnq5_OrvvPTbWX7_OsWOxnDKKXHOTD2itteOdTqxcr61yLFbQ@mail.gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the amdgpu tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
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

Fixed.  Sorry for the noise.

Alex

On Thu, Jun 30, 2022 at 7:09 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> In commits
>
>   41a2d4df3d72 ("drm/amd/display: Fix __nedf2 undefined for 32 bit compilation")
>   916ae9cc5385 ("drm/amd/display: Fix __muldf3 undefined for 32 bit compilation")
>   f20eb84561de ("drm/amd/display: Fix __floatunsidf undefined for 32 bit compilation")
>
> Fixes tag
>
>   Fixes: 9b79abf79c414 ("drm/amd/display: add CLKMGR changes for DCN32/321")
>
> has these problem(s):
>
>   - Target SHA1 does not exist
>
> Maybe you meant
>
> Fixes: 265280b99822 ("drm/amd/display: add CLKMGR changes for DCN32/321")
>
> In commit
>
>   204b022bcbbf ("drm/amd/display: Fix __umoddi3 undefined for 32 bit compilation")
>
> Fixes tag
>
>   Fixes: 9b0e0d433f74 ("drm/amd/display: Add dependant changes for DCN32/321")
>
> has these problem(s):
>
>   - Target SHA1 does not exist
>
> Maybe you meant
>
> Fixes: d3dfceb58de5 ("drm/amd/display: Add dependant changes for DCN32/321")
>
> --
> Cheers,
> Stephen Rothwell
