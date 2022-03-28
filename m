Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2F534E98EA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 16:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243627AbiC1OGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 10:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243612AbiC1OGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 10:06:46 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1F21CB13
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 07:05:05 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id j2so26263534ybu.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 07:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NKTQQt1eAM2QXg4NHEpyfpFhb+tbp65Bmfh3/IyYTI8=;
        b=ko+VIK6/TNL5u8v1hmd9Qi3maHA0kRvq9dKngfv0JrurPB8BTUwO4X7jHJpqrxUjgF
         +5PQrIl1jootBkFAFNgAUKNBmll77yKYDarFWo1tpUQ/JpKIJ7lQ7dNCk1dt+JUU7csR
         UMO72zDIT90FTTMT8a0S4JRM/d4W4XTvf2y04QB+z6ZP0R6a3GZFj3ZFKuP3MKLachjE
         NnvaGTgQ+ohcWH0lRN28opUr9MoZ2JGlbPVzbptffa0cVdvpG7QNsAeY0z6cstvh/enz
         v1V4N6TsFRYmUCsF6SwwFLTZc+ALDT9zQrc4F4L/liRppTCMpj2dqYcDvqjNmUtGIG27
         p2VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NKTQQt1eAM2QXg4NHEpyfpFhb+tbp65Bmfh3/IyYTI8=;
        b=tz3ILCzaEzVB7DzZ6t9m9ROLkdAvtvqmwSSc+DiOsdWSxecQdLyCduMlHcMws9n+2l
         vz9B8tYvZq2DVibWypqYzAoneJ4thkVoi7Tb9EB326Jok2WVYXcu9kpjQ17+co0MSV7J
         fUgcWTyHa18tnyD97BvusyosG6T5WQ3DR+w3CF9TzK8yZmcAnTfk2OpXSJ9vo90cAaCI
         mtrkbVdHNpvztDf/+F5o1i24HOa6tNehFfFhPvOPDVYB34N5ZO8XouckrbTO8mbxiIK8
         6wnkB7IHTIdrqAOf6LVLXxgCrGVncToS6oK1AeSGKWBudA4NooyqTbp+2vO+2tebD+Ta
         B7+g==
X-Gm-Message-State: AOAM530NLEtV075GHuuqg58a/7Y3jgbD+NYO4IA80ddD7K6nF/p6p7Zk
        +LUGlHgXuQQBBiWhtVtGBn3dmzCdNjpxrE3LkodIIA==
X-Google-Smtp-Source: ABdhPJx9733RddLzhyh+FUHD1TVLaxlvDzZGX6W0kOnkhSYE3AzWJNrw99CEPh1XUVS/r1iN7q150DGcBIq81rJaWAE=
X-Received: by 2002:a25:23c2:0:b0:633:b871:ce27 with SMTP id
 j185-20020a2523c2000000b00633b871ce27mr23812254ybj.644.1648476304398; Mon, 28
 Mar 2022 07:05:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220318141441.32329-1-pali@kernel.org>
In-Reply-To: <20220318141441.32329-1-pali@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 28 Mar 2022 16:04:26 +0200
Message-ID: <CAPDyKFrQiHoY6wrGRDE6p0zarBiABJJB3DH5d1K+Mw5SrxMmEA@mail.gmail.com>
Subject: Re: [PATCH] Revert "mmc: sdhci-xenon: fix annoying 1.8V regulator warning"
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     Hu Ziji <huziji@marvell.com>,
        =?UTF-8?B?TWFyZWsgQmVow7pu?= <marek.behun@nic.cz>,
        Marcin Wojtas <mw@semihalf.com>,
        Konstantin Porotchkin <kostap@marvell.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Mar 2022 at 15:14, Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> This reverts commit bb32e1987bc55ce1db400faf47d85891da3c9b9f.
>
> Commit 1a3ed0dc3594 ("mmc: sdhci-xenon: fix 1.8v regulator stabilization"=
)
> contains proper fix for the issue described in commit bb32e1987bc5 ("mmc:
> sdhci-xenon: fix annoying 1.8V regulator warning").
>
> Fixes: 8d876bf472db ("mmc: sdhci-xenon: wait 5ms after set 1.8V signal en=
able")
> Cc: stable@vger.kernel.org # 1a3ed0dc3594 ("mmc: sdhci-xenon: fix 1.8v re=
gulator stabilization")
> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-xenon.c | 10 ----------
>  1 file changed, 10 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xeno=
n.c
> index 666cee4c7f7c..08e838400b52 100644
> --- a/drivers/mmc/host/sdhci-xenon.c
> +++ b/drivers/mmc/host/sdhci-xenon.c
> @@ -241,16 +241,6 @@ static void xenon_voltage_switch(struct sdhci_host *=
host)
>  {
>         /* Wait for 5ms after set 1.8V signal enable bit */
>         usleep_range(5000, 5500);
> -
> -       /*
> -        * For some reason the controller's Host Control2 register report=
s
> -        * the bit representing 1.8V signaling as 0 when read after it wa=
s
> -        * written as 1. Subsequent read reports 1.
> -        *
> -        * Since this may cause some issues, do an empty read of the Host
> -        * Control2 register here to circumvent this.
> -        */
> -       sdhci_readw(host, SDHCI_HOST_CONTROL2);
>  }
>
>  static unsigned int xenon_get_max_clock(struct sdhci_host *host)
> --
> 2.20.1
>
