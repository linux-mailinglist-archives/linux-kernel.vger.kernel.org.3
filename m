Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA32F528617
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 15:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244089AbiEPN5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 09:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244439AbiEPN4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 09:56:25 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB693B284
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 06:55:57 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id a23so10123824ljd.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 06:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MeiTmWKbfFkyUDAu36ZyhnVOygglTiIR0GOA0B1eY0c=;
        b=YSvJoVFPtG6bnfTeQxzBBXy77ERTEhTsg7XgRIV7EvSdREsTC+AE70ohYj7+FaK3bh
         OZ7sjzRe0LmR1tB7sIiFJ86bssbYh2hpR0Y+aNF/BknPMKa7voNiy1bXK6AW9VSd65yv
         v93gBe0NGiYn3Ng3ITfp5tpi4Zm9UD8CupDajz7yaQAyoxRnLxRhMZUdN71V296ixtDP
         dkyIm2FRzpKSi0w/RUH3Cd2tWDxZ+pd/bqglKQcNSg/Jn5paNs/SwNzOb+tRvGMX/LUe
         855GCPqwIABjYfRzwwNyEXTYySq0ebhv/pRlBayaA8U/7pAbULFuWXgIj151YCTknIOb
         X47g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MeiTmWKbfFkyUDAu36ZyhnVOygglTiIR0GOA0B1eY0c=;
        b=IM0oCrXHKk5aH7TlAw4biWtoW2Bev6XcMXZJk30M9XuS5sXTg4nOqkLIzmiabdGjY/
         D76HMLVeBvDZVss5jzW6z3C9Z49WG22Q36U+HA/DqahxjhCv3inI1M0Nt9ktbZOko/8P
         1Xl9akM/lsc7x8ZHwTid+4HQR2jqValPVFR0kMVCE6FhrayfQk+W0GAJkJS3kRNr6vI0
         HztgYPsqcqOPJatjwQEGDcsCuRTj0EEkE6nRVzX5NDpTGRd57o6kGmvTtqhYR0Z+GhXC
         IyAVRZ4PYaKRRYuIWZus+xPGnVFB4ttLV1tY1gNFUZCc726flovLq2+Oj9gjcGumc+hm
         tEew==
X-Gm-Message-State: AOAM530Xr8tvXp6nyokQ4ydUThLzRnDAYMKLn7+KZ7QJm5v/j8tMedEm
        6uhXlqzZJTkE/SrvKPsafAuMfNRIJgSZc4+QT5op2w==
X-Google-Smtp-Source: ABdhPJwZ6Em0eLu7RM1SxBb2WiY0uU1ovRh7DwLWOyrbGByueTpyFAw3U7b/oAPWL/x87mDro49Q7VbiwqbPhOi6nCM=
X-Received: by 2002:a2e:9e54:0:b0:250:d6c8:c2a6 with SMTP id
 g20-20020a2e9e54000000b00250d6c8c2a6mr11865448ljk.16.1652709355591; Mon, 16
 May 2022 06:55:55 -0700 (PDT)
MIME-Version: 1.0
References: <1652339993-27280-1-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
In-Reply-To: <1652339993-27280-1-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 16 May 2022 15:55:18 +0200
Message-ID: <CAPDyKFoWdq+908f18Uz3TPj50M2eDiECC7iLU8UGGEuawCpo1w@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-arasan: Add NULL check for data field
To:     Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, git@xilinx.com,
        saikrishna12468@gmail.com, sgoud@xilinx.com
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

On Thu, 12 May 2022 at 09:20, Sai Krishna Potthuri
<lakshmi.sai.krishna.potthuri@xilinx.com> wrote:
>
> Add NULL check for data field retrieved from of_device_get_match_data()
> before dereferencing the data.
> Addresses-coverity: CID 305057:Dereference null return value (NULL_RETURNS)
>
> Signed-off-by: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index 6a2e5a468424..757801dfc308 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -1577,6 +1577,9 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>         const struct sdhci_arasan_of_data *data;
>
>         data = of_device_get_match_data(dev);
> +       if (!data)
> +               return -EINVAL;
> +
>         host = sdhci_pltfm_init(pdev, data->pdata, sizeof(*sdhci_arasan));
>
>         if (IS_ERR(host))
> --
> 2.17.1
>
