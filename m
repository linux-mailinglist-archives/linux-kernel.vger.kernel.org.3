Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E127057DF0C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 12:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235965AbiGVJml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 05:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235597AbiGVJmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 05:42:19 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647F01EC57
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 02:33:16 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id by8so4756240ljb.13
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 02:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tAZZ+zZvrQNIBH53DRQidJGGL3IywgMOgKasOQHqRGI=;
        b=yecc/o33SpG3FJV0705q2XlNAbffHKx037EfzgEpjB95oGMlEEJuMDVgipIXcH1Odo
         AU92urHlfHEwMBzYNq+7xtxxz1QN9jPvCae//JvoifaUHBSbPdpBHgykid7Q2L+RUHy3
         jtI89CCN4iNAY5yY80DO5ykohnJDZa6+wsozZGLxZe7uVUktmW5Cll6O1Rlsl8r7i5yE
         6C7eaioh5drnHTfhAtdR5ic6k23mBXrTM6q1w7Jretkg8HJio2ZiuIL1zmC7ooC+7FAy
         aHme9eVzQJWo4IsJvN7mARluA8ClLB6ITXe1AqMSlMfeZMxkmYyFzBc+t/JX6mpzcpUo
         U8rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tAZZ+zZvrQNIBH53DRQidJGGL3IywgMOgKasOQHqRGI=;
        b=Qf5/ZTTtTP1SkooaTimvIWwxL56BTy3e0Jt9+spvf8/A+A1FpD+AXiykkVe2Wv65iv
         j/zK5tGXjS9PfEfjBClqHSmWh1BPU7/Ba5poelho5DvAy7X44U2crISfdFISIZm6oKNp
         I6ztrvIwdONqvFc4cAZ4hoUVzroWMoTEMTs2xBS1y1gDQum4YPHBDCHQm89bVBeID9No
         FUMi1Qg+HN0ROklebRrlRNJdu5ghG+CgS40pDYOkHLq3AJ0xZU4gyclAGZD2C9kRv+YD
         4ookoAzmbmqbXKWtmACEiMu8zPU3va+GHx/qM7B9ara0+xTaj1qhlCM2BO2wDScLH0+z
         z0vQ==
X-Gm-Message-State: AJIora8RE0P4AkyltcEf5YMvR6yH2JpgQdj/ENZo09Okxt1rayXNBuYa
        ksLi77FZE4DaLC8k4pyJkTCW3QLUo6dRsyClnrfPFw==
X-Google-Smtp-Source: AGRyM1tuFeL40FXNplF3DiaFKWMK80dA2FT32q0LOAoiBjUTCYptRGrlgOmrTynjE+KfsV1d7HA14nI3swNVUSJTITg=
X-Received: by 2002:a2e:a5c9:0:b0:25d:dc6e:1918 with SMTP id
 n9-20020a2ea5c9000000b0025ddc6e1918mr903972ljp.229.1658482394393; Fri, 22 Jul
 2022 02:33:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220718082650.9784-1-wangborong@cdjrlc.com>
In-Reply-To: <20220718082650.9784-1-wangborong@cdjrlc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 22 Jul 2022 11:32:38 +0200
Message-ID: <CAPDyKFpBc_XZStRb7mwQ_nN-YUnxxmXrqx6hFFxoVG=iJ-VdiQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] mmc: sdhci-acpi: Fix comment typo
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     adrian.hunter@intel.com, haibo.chen@nxp.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, kishon@ti.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jul 2022 at 18:30, Jason Wang <wangborong@cdjrlc.com> wrote:
>
> The double `the' is duplicated in the comment, remove one.
>

Hi Jason, these spelling fixups are getting somewhat annoying to me,
sorry. Don't get me wrong, it's nice to have good readable comments,
but the patches don't really need to be one line of change per patch.
Could you perhaps look over all mmc host drivers and fix all spelling
mistakes in them and send one patch to cover all of them instead?

Kind regards
Uffe

> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
> ---
>  drivers/mmc/host/sdhci-acpi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
> index 4cca4c90769b..bddfaba091a9 100644
> --- a/drivers/mmc/host/sdhci-acpi.c
> +++ b/drivers/mmc/host/sdhci-acpi.c
> @@ -648,7 +648,7 @@ static int sdhci_acpi_emmc_amd_probe_slot(struct platform_device *pdev,
>          *       in reading a garbage value and using the wrong presets.
>          *
>          *       Since HS400 and HS200 presets must be identical, we could
> -        *       instead use the the SDR104 preset register.
> +        *       instead use the SDR104 preset register.
>          *
>          *    If the above issues are resolved we could remove this quirk for
>          *    firmware that that has valid presets (i.e., SDR12 <= 12 MHz).
> --
> 2.35.1
>
