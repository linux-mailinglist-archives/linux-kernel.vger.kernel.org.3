Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD9EA4C193D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 18:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243094AbiBWRER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 12:04:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242901AbiBWREP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 12:04:15 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291AC4F451
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 09:03:47 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id v21so5428278wrv.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 09:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ElO9QEbGLtnu2p6W3GD9GPPjHEDjjQB7rKG2MNcXjTo=;
        b=G+xOg7T+04bMRKlVUgToQEK2c/ffsPvL110Jz+fIMvwsLWu1ybRtq+t6PQSAhLQ8j0
         7sTVUBMHyai1goZZ/dQ9gJvv7UzwsoirhukYn8nEdNtQor6B+lpLFYK+kjx6mb/3m48+
         zot+BKoAuxzx/k2KSnOKZVt+bN9NjfU6xVPMvZ9GXYygvUevYvDnNK52FFEyOIMZlKoS
         GPDtGZNklJaMuN0Bu5H1dd09/ydEP8hUyWICcbBA/x0vNLo4BdrUaLuNmZQOiH4Wubis
         1YpygnqH5Dm01r9RV4uMCizKBI6mlf7xccD8U9cbKDo6LJBJXzqSnmz7CLxzL8bdzh3t
         yf4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ElO9QEbGLtnu2p6W3GD9GPPjHEDjjQB7rKG2MNcXjTo=;
        b=AIF4fACDMWLbajuMpPKI2kfB6h+x5TiM7+tan+8dl/wZ52n29C4GnKS3ZQCvVrybcc
         ny+RqT33uRnD/voDnGDmxdMQVhZpryxG/H/Bo3rSaerLsyKeTI8xAfw0Y1nGTyB+Kj0b
         +17ZtRFFvRQY5Laz6g5jLd5lNHod4EN76cEhJLpTKgBNX/yp6g9ISzdzAF+d4NroL8wj
         kuyzgs0BWocavNp88TUUuYIKX3teBZkV4/KduQtsvnPdOguje44YR4mENSMsC7+j+B+q
         r0KRSBOzYOsgGmPSWkLOH8sztf5hBQJsfTX9AVuFoJegQiNY7QqrSo+fS2+fBsc9xr/W
         Slvw==
X-Gm-Message-State: AOAM532g1ZC/Infyui7MdC5LTApurZti4NVeL0y6R8WsH362DHy/8abU
        ztal2h145IXHc9o02d9O+LHqc6WZNd7lYg==
X-Google-Smtp-Source: ABdhPJyXVCWuB+rFR5nYOFMwxEw+dZda/CgCF6/Cv/qMMYwhuOZgxxqIXnasLFlN38UTBKvwgnH9bQ==
X-Received: by 2002:a5d:65cc:0:b0:1e5:a360:cb06 with SMTP id e12-20020a5d65cc000000b001e5a360cb06mr385847wrw.713.1645635825662;
        Wed, 23 Feb 2022 09:03:45 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id x17sm69353wrv.107.2022.02.23.09.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 09:03:45 -0800 (PST)
Date:   Wed, 23 Feb 2022 17:03:43 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the mfd tree
Message-ID: <YhZo7xnNRKz8U1Lf@google.com>
References: <20220223165416.2359767-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220223165416.2359767-1-broonie@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Feb 2022, broonie@kernel.org wrote:

> Hi all,
> 
> After merging the mfd tree, today's linux-next build (KCONFIG_NAME)
> failed like this:
> 
> /tmp/next/build/drivers/mfd/sprd-sc27xx-spi.c:255:35: error: redefinition of 'sprd_pmic_spi_ids'
>   255 | static const struct spi_device_id sprd_pmic_spi_ids[] = {
>       |                                   ^~~~~~~~~~~~~~~~~
> /tmp/next/build/drivers/mfd/sprd-sc27xx-spi.c:242:35: note: previous definition of 'sprd_pmic_spi_ids' was here
>   242 | static const struct spi_device_id sprd_pmic_spi_ids[] = {
>       |                                   ^~~~~~~~~~~~~~~~~
> 
> Caused by commit
> 
>   6fc90b92e9c7ef348 ("mfd: sprd: Add SPI device ID table")
> 
> I used the MFD tree from yesterday instead.

Thanks.

Will fix for tomorrow.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
