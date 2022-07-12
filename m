Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA3FC571808
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 13:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbiGLLJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 07:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbiGLLJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 07:09:24 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A4AAF753
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 04:09:23 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id z25so13365844lfr.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 04:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GtGgLrxNDhgvI+v91Xovps7msOe7jAt3sd0zY52IjMA=;
        b=t5g/R6Cvxremka/ngioUBUxrLfcHv38NZoo7Rn0q2Lk4elrTfMleQk/4uutnjOAvlo
         TCNJD6Nr3WAGC1HNyQarKTWNoP7u0L7dXuUjEc1CQHyNKFNN87hUCwpoZFuDOdpbEyI6
         uHECB+yw2Kt2tpyFu+RFfV7rOneCyg2938xlusajEZEDYx1hTPsLKwU8TtJ4YyACHeJ/
         gjhvUTInwOmvZLacj1QRBvTJwgHAn/2NZfvo+rgdt8UNlovsv5QV7YR/gUf6VsRtXhzM
         AUqPtq06bms/W2UORSjknX7RG6MjmJqywzjOwYp3HWfegguDTPuL5/ZAqmh/UmjI9i9g
         k5tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GtGgLrxNDhgvI+v91Xovps7msOe7jAt3sd0zY52IjMA=;
        b=J58lPYNrmU2MlrjdvYw806Gd5Six3gj/KNRkCLreb2LbznqWecQwIv0ddjTyafy0FD
         StkX9TxwZ5Zyjvw6nNxvMsDJjchnSYi11/2eeiTu/j0TztDtFgG1o0VNG6AGBGJO4E8m
         DLrFfyhYrcmCNpEfSecca2oNnnZfG+fmkl0HYGcDpdec439gb5Ck8qKFAy4LoAlbzrYk
         Vy8ZKtoWCN+kOAc7OPNksCGRbBPG+0KHp4ZZ52tXVcgPJpS7cuMyGGrb5UVLkt8/RBFO
         +ZBSksqsE+PKYVbDKNVWB1Ukp/3YmEmiisxMAICh2/IqZFqVbXG3qDEs+gKgNdZouPDL
         Zq2A==
X-Gm-Message-State: AJIora/LOm3/EI7c2YqbtQHYeSyVK08eN8SLYtOwRrV8vu8ZmuGnOjIp
        LRB3EAEIbczMMUnQ90+khClKxaVCk5PERQzeL0d6Ow==
X-Google-Smtp-Source: AGRyM1uD9PTLxT7S3witbZ69cn8djykXJyQX+Yil2WB3puDpqBIZz/kTrVAoqdgMsDjFKJyib2hTZvrIZ/bHJs7bUPQ=
X-Received: by 2002:a05:6512:15a8:b0:489:ed48:24 with SMTP id
 bp40-20020a05651215a800b00489ed480024mr2184751lfb.184.1657624162065; Tue, 12
 Jul 2022 04:09:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220624181438.4355-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220624181438.4355-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 12 Jul 2022 13:08:45 +0200
Message-ID: <CAPDyKFpEsL1i5pikDmGdsjg-q-HbpMGWbxytB=8XEgTYJ_rOzA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] mmc: renesas_sdhi: Trivial fixes
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Pavel Machek <pavel@denx.de>, linux-mmc@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jun 2022 at 20:14, Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
>
> Hi All,
>
> This patch series adds trivial fixes to renesas mmc driver.
>
> v2->v3
> * Fixed Review comments pointed by Wolfram.
> * Included RB tags from Geert.
>
> v1->v2
> * Fixed review comments pointed by Geert and Wolfram.
>
> v1: https://patchwork.kernel.org/project/linux-renesas-soc/cover/
> 20220404172322.32578-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
>
> Cheers,
> Prabhakar
>
> Lad Prabhakar (2):
>   mmc: renesas_sdhi: Get the reset handle early in the probe
>   mmc: renesas_sdhi: Fix typo's
>
>  drivers/mmc/host/renesas_sdhi_core.c          | 8 ++++----
>  drivers/mmc/host/renesas_sdhi_internal_dmac.c | 4 ++--
>  2 files changed, 6 insertions(+), 6 deletions(-)
>

Applied for next, thanks!

Kind regards
Uffe
