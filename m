Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCCC49829B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 15:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240084AbiAXOl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 09:41:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240243AbiAXOlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 09:41:55 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31E6C061401
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 06:41:54 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id x23so2967519lfc.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 06:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QZbvOPh0/0dWbRnDZOEAQomVipOBDWGGfczoZ2UW+iM=;
        b=LiGD1toO/LRPZDHp4KGkcSQgx1i3QQzKY5uftp4Po6q84BZnFekU+eNgTQl2J2iNbl
         PfXHLC8bUhSv3rrm1pxZCUnCeo3HsketKjTBBO/CX4YssEPZXAEe46RnEWkPQqZFjfu7
         7l1MOot8E6vccP0gHqa9s1eO/vSAdqqN96LuD1aBpCp388QDL7IGzYphFL1GESxEhp+A
         H49aq9XOJJxkNi2FxqDoEdtxSzVN1Jy8mkrmq+8o35KoIB8+2GtgWQdhBtyntoRiwrpn
         Ll8Sde3ixIxLl9dl2BmiNzSA5lyySP7nkuzBiOKa6YzZuEKn2Mkh7vSUV/xFqxMwTyEZ
         9v1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QZbvOPh0/0dWbRnDZOEAQomVipOBDWGGfczoZ2UW+iM=;
        b=37QAjoJ9Ltubf0aPyYJ/b8xh9Ca4n0duUXx7dppOC20N/TFjEn0St0KJ8ZtErOvKQb
         86j1FE1Qx8VcLNbo22/DsAxDM81AApNlOH6iZ8no8PNjr/8h7xPNq589rC7WwYiQK/J6
         5a6eJ9bavj6UyplvqmgRGdJUQNQZLS6JUX6pCIj3JhU+9n+9y6xucO8aM/jK06X1mQY0
         qUKsYEScjb8gOsD+CFCml0WjanNIo2JvHanoMsNBVomv1mtebIstEKyJ8G3d80cMYLDN
         8l5/OhqKc/E4Fe9ZGO0QKR4/FMP3B25nt7WzLmAp7UfIMPKxhsbGDuTXGlR1us14Mklr
         vCDA==
X-Gm-Message-State: AOAM532udpWO8RL24QIqYfdy8eRg8C6gJO8uLnZqZ2A9aZ2CF4d5ryRQ
        s3zXKU2z/X46JrRfTQkAdA5A2D69ODUmqWTlCpypMQ==
X-Google-Smtp-Source: ABdhPJyj1IZdftQcab/AVm2rxmLvDVzarEL3T1BUfgRMmoyyexfCgCe6gHZBjqElCQU8fhDjSEVWFEO92p2qSIhU7hw=
X-Received: by 2002:a05:6512:10d2:: with SMTP id k18mr13054961lfg.167.1643035313039;
 Mon, 24 Jan 2022 06:41:53 -0800 (PST)
MIME-Version: 1.0
References: <20220119075339.36281-1-benchuanggli@gmail.com>
In-Reply-To: <20220119075339.36281-1-benchuanggli@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 24 Jan 2022 15:41:16 +0100
Message-ID: <CAPDyKFr6CPS6uAnZc_CdCSg2iWGvZXSmoO4+cHTo6eEyfXnQDg@mail.gmail.com>
Subject: Re: [PATCH 2/3] mmc: sdhci-pci-gli: Enable SSC at 50MHz and 100MHz
 for GL9750 and GL9755
To:     Ben Chuang <benchuanggli@gmail.com>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, greg.tu@genesyslogic.com.tw,
        ben.chuang@genesyslogic.com.tw, SeanHY.Chen@genesyslogic.com.tw
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jan 2022 at 08:53, Ben Chuang <benchuanggli@gmail.com> wrote:
>
> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
>
> Enable SSC function at 50MHz and 100MHz for GL9750 and GL9755.
>
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-pci-gli.c | 36 ++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index 9ead32d73447..9de3d91283af 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -394,6 +394,20 @@ static void gl9750_set_ssc_pll_205mhz(struct sdhci_host *host)
>         gl9750_set_pll(host, 0x1, 0x246, 0x0);
>  }
>
> +static void gl9750_set_ssc_pll_100mhz(struct sdhci_host *host)
> +{
> +       /* set pll to 100MHz and enable ssc */
> +       gl9750_set_ssc(host, 0x1, 0xE, 0x51EC);
> +       gl9750_set_pll(host, 0x1, 0x244, 0x1);
> +}
> +
> +static void gl9750_set_ssc_pll_50mhz(struct sdhci_host *host)
> +{
> +       /* set pll to 50MHz and enable ssc */
> +       gl9750_set_ssc(host, 0x1, 0xE, 0x51EC);
> +       gl9750_set_pll(host, 0x1, 0x244, 0x3);
> +}
> +
>  static void sdhci_gl9750_set_clock(struct sdhci_host *host, unsigned int clock)
>  {
>         struct mmc_ios *ios = &host->mmc->ios;
> @@ -411,6 +425,10 @@ static void sdhci_gl9750_set_clock(struct sdhci_host *host, unsigned int clock)
>         if (clock == 200000000 && ios->timing == MMC_TIMING_UHS_SDR104) {
>                 host->mmc->actual_clock = 205000000;
>                 gl9750_set_ssc_pll_205mhz(host);
> +       } else if (clock == 100000000) {
> +               gl9750_set_ssc_pll_100mhz(host);
> +       } else if (clock == 50000000) {
> +               gl9750_set_ssc_pll_50mhz(host);
>         }
>
>         sdhci_enable_clk(host, clk);
> @@ -537,6 +555,20 @@ static void gl9755_set_ssc_pll_205mhz(struct pci_dev *pdev)
>         gl9755_set_pll(pdev, 0x1, 0x246, 0x0);
>  }
>
> +static void gl9755_set_ssc_pll_100mhz(struct pci_dev *pdev)
> +{
> +       /* set pll to 100MHz and enable ssc */
> +       gl9755_set_ssc(pdev, 0x1, 0xE, 0x51EC);
> +       gl9755_set_pll(pdev, 0x1, 0x244, 0x1);
> +}
> +
> +static void gl9755_set_ssc_pll_50mhz(struct pci_dev *pdev)
> +{
> +       /* set pll to 50MHz and enable ssc */
> +       gl9755_set_ssc(pdev, 0x1, 0xE, 0x51EC);
> +       gl9755_set_pll(pdev, 0x1, 0x244, 0x3);
> +}
> +
>  static void sdhci_gl9755_set_clock(struct sdhci_host *host, unsigned int clock)
>  {
>         struct sdhci_pci_slot *slot = sdhci_priv(host);
> @@ -557,6 +589,10 @@ static void sdhci_gl9755_set_clock(struct sdhci_host *host, unsigned int clock)
>         if (clock == 200000000 && ios->timing == MMC_TIMING_UHS_SDR104) {
>                 host->mmc->actual_clock = 205000000;
>                 gl9755_set_ssc_pll_205mhz(pdev);
> +       } else if (clock == 100000000) {
> +               gl9755_set_ssc_pll_100mhz(pdev);
> +       } else if (clock == 50000000) {
> +               gl9755_set_ssc_pll_50mhz(pdev);
>         }
>
>         sdhci_enable_clk(host, clk);
> --
> 2.34.1
>
