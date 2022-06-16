Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716EE54E112
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 14:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbiFPMtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 08:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiFPMtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 08:49:12 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86156EA6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 05:49:11 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id d19so1362654lji.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 05:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hESFz66pGYPiw3LdS0z2t9AkdnHybf1jrKiYG9djd50=;
        b=HsrfKgDGX5TxR8pSo4XltbKHokxukbGhJItfynC9jGiTojG7IEu3X7DmlesE9zIcDY
         Vs9d2BDPVN4PZshDww7+8XwnJQTMK31HjIW31GtpwYmrQdEKnTqwiF8FNVMXqWONqmip
         JfTqWXNNEKZXJz3MzgPe4JFwW/Vq/IKDnht8bLkXjNE5XvG4U/O1s0v1McOb4WC4/MvU
         zxMD14c0HgWhbKgs9hOfrvwbbVCGlnxzE6SgTjBD8qTQTmDMyYwR1ezsxa3dEqa4oTi5
         UuR3isq5MaMov5+4koDk6oTFEKkvhSei5cuyJuH0kyostJ8J5228wxNnzOSVUAAWq+O4
         S2pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hESFz66pGYPiw3LdS0z2t9AkdnHybf1jrKiYG9djd50=;
        b=nH6AWeHNoKaSE4yQ1vhekPU7HuCEG8bLz/WBra5rKLWHbgEyXQ2YEaICplmyn4bGlg
         PeaDPcUniZO2yp6299KtNPPUckhCRGvUGnCgUpdeo1Stv6KdUs9FM4aJt4T+0tB/H6HY
         Tj6y0JofPyyHjNBlUGmGlMUXNxqDhuORjiPw6XD/DcfrerG9Rz7KxaGlbyOVOUjBLJM3
         9HcIbfomn56sGGzoSPlnhOOeBxrknN8WHAExZtQkYvwhVAa12gZohg00PdsofwPllohK
         e5CPYFgntzSSQhpp0v7096MDGSHIajIkwZAnxU5gP/HOnSkF+1e6U8mj86yxvOP0mMTy
         hBjg==
X-Gm-Message-State: AJIora/limkHhgT+gk/L+HQxLtgNM3qgj6259C2ATJK/WfsZE6mpXuFq
        qpsMV7dz+QpT4fu7/sqokWg=
X-Google-Smtp-Source: AGRyM1tqk0FvUmgFrBjiTkmoBCqC2rb0nk3jQIdRCmFABWuipeaHtdMQkVk00ICE9DYQg7ZeZQLeYg==
X-Received: by 2002:a05:651c:550:b0:255:5b77:b1a4 with SMTP id q16-20020a05651c055000b002555b77b1a4mr2506358ljp.181.1655383749649;
        Thu, 16 Jun 2022 05:49:09 -0700 (PDT)
Received: from [192.168.2.145] (109-252-136-92.dynamic.spd-mgts.ru. [109.252.136.92])
        by smtp.googlemail.com with ESMTPSA id a5-20020a2eb165000000b002553ab60e17sm238709ljm.122.2022.06.16.05.49.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 05:49:09 -0700 (PDT)
Message-ID: <aa1f187c-786e-16ca-c156-448108f8fcc5@gmail.com>
Date:   Thu, 16 Jun 2022 15:49:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] soc: mediatek: Introduce mediatek-regulator-coupler
 driver
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, matthias.bgg@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wenst@chromium.org,
        alyssa.rosenzweig@collabora.com, nfraprado@collabora.com
References: <20220616094502.15318-1-angelogioacchino.delregno@collabora.com>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <20220616094502.15318-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

16.06.2022 12:45, AngeloGioacchino Del Regno пишет:
> +static int mediatek_regulator_attach(struct regulator_coupler *coupler,
> +				     struct regulator_dev *rdev)
> +{
> +	struct mediatek_regulator_coupler *mrc = to_mediatek_coupler(coupler);
> +	const char *rdev_name = rdev_get_name(rdev);
> +
> +	if (strstr(rdev_name, "sram")) {
> +		if (mrc->vsram_rdev)
> +			return -EINVAL;
> +		mrc->vsram_rdev = rdev;
> +	}

You should filter out regulators unrelated to SRAM and GPU, see
regulator_find_coupler().

> +	return 0;
> +}
> +
> +static int mediatek_regulator_detach(struct regulator_coupler *coupler,
> +				     struct regulator_dev *rdev)
> +{
> +	struct mediatek_regulator_coupler *mrc = to_mediatek_coupler(coupler);
> +
> +	if (rdev == mrc->vsram_rdev) {
> +		mrc->vsram_rdev = NULL;
> +		return 0;
> +	}

The regulator core should emit error message about GPU regulator failed
to detach because you're returning -EINVAL for it.

> +	return -EINVAL;
> +}

