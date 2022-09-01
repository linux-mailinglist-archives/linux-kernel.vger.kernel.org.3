Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E085A94AD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 12:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234184AbiIAKcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 06:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232666AbiIAKci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 06:32:38 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC9E12206C
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 03:32:37 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id v26so13520857lfd.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 03:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=HXeJHCAXo+Xl23q56BVg26tN6HoFjavkkhsO/UPUSCA=;
        b=eWV9NJYuWmlhBNQjRqqJh21c9CuVTF8puoFd6FhvGU1FcWeHJwWakos45j1Ht7fc/O
         Z13gOUa1yogoHDNl23GvvdjaT02jEi/pzJbE2IbdTWJ601oyMdmuq92FYWXGMP+2Rfem
         1x5ZPTRNxtX52Ff6rNPZi+dnScPcqIEG28qfVSwqIKv5migHKqaepCVcAkYC5iCtzR0y
         /38kX9+s/r50kTv8Bab9SHE+wF0lC9vdchJIDXwjhIqIu13M3gxubRsFwmzrONxRRNsS
         npa4TiMaFzYEj2Qr8w8KEWoyE8VBzzllh1a92e2+GNBcnF3e3Su0t3PbxcVhHfN12InO
         AmKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=HXeJHCAXo+Xl23q56BVg26tN6HoFjavkkhsO/UPUSCA=;
        b=MJmdPB8ERBLg8FvsbAPE3494OVLFny/IIsGsb4Kt0yQbgBqxH2Qqo7EX8WAg767nZj
         D73VnQCVfpQEfpqTPezrseeJ0GNy7/3b+rmTr4lZDBUPIhg0khcxaOG50NgFvhSF8Y0+
         cbxu2xsO2iE5eiZksSyiwKQ2oMF06Ufr+4MP4JmAcvZId1YLCuiTgZyNyQWsLsJoAbwB
         BFTJlGREwZNdfKmwGtmut1NAcvcP+X0lFDBdvIj2+DsfdrcpdtO9kZLRQtWOT4cylVQE
         6IIt8+Etcua3Q+BeJyRZaCbD/ZsL/E3Hawvi16OJRmp2neLg2Wkpfl15ZzEST8jip98q
         pLvA==
X-Gm-Message-State: ACgBeo01Jznr5YKabcnQ3w6Z7VzBfZ+lGcTp3+U5fJYLQmljGvwmVD67
        8LhtcHlxXIbq/ygahpn14hw/qA6Wx//4TyjLsVNOow==
X-Google-Smtp-Source: AA6agR6N5ywWgfouWR/JVPBzzKCE4dtOVAqUK96KtyUH5iS36msWajnh943hORgNKjzHwQ7pKxba9YlqO2wq3xL5t28=
X-Received: by 2002:ac2:5d26:0:b0:494:6d31:4c5b with SMTP id
 i6-20020ac25d26000000b004946d314c5bmr5836840lfb.358.1662028356081; Thu, 01
 Sep 2022 03:32:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220830083349.276709-1-ye.xingchen@zte.com.cn>
In-Reply-To: <20220830083349.276709-1-ye.xingchen@zte.com.cn>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 1 Sep 2022 12:31:59 +0200
Message-ID: <CAPDyKFp_r3RNbeYHFC2ncezJHJkmPcNkZ17N-FDQqxpLq0b20w@mail.gmail.com>
Subject: Re: [PATCH linux-next] mmc: sdhci_am654: Remove the unneeded result variable
To:     cgel.zte@gmail.com
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
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

On Tue, 30 Aug 2022 at 10:33, <cgel.zte@gmail.com> wrote:
>
> From: ye xingchen <ye.xingchen@zte.com.cn>
>
> Return the value cqhci_init() directly instead of storing it in another
> redundant variable.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci_am654.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index e7ced1496a07..8f1023480e12 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -554,7 +554,6 @@ static const struct cqhci_host_ops sdhci_am654_cqhci_ops = {
>  static int sdhci_am654_cqe_add_host(struct sdhci_host *host)
>  {
>         struct cqhci_host *cq_host;
> -       int ret;
>
>         cq_host = devm_kzalloc(mmc_dev(host->mmc), sizeof(struct cqhci_host),
>                                GFP_KERNEL);
> @@ -568,9 +567,7 @@ static int sdhci_am654_cqe_add_host(struct sdhci_host *host)
>
>         host->mmc->caps2 |= MMC_CAP2_CQE;
>
> -       ret = cqhci_init(cq_host, host->mmc, 1);
> -
> -       return ret;
> +       return cqhci_init(cq_host, host->mmc, 1);
>  }
>
>  static int sdhci_am654_get_otap_delay(struct sdhci_host *host,
> --
> 2.25.1
