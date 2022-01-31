Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21C8B4A4CE0
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 18:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380815AbiAaRPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 12:15:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380814AbiAaRO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 12:14:27 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA24AC061756
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 09:14:07 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id v13so26709332wrv.10
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 09:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=3yjwrap5tpYm/7QbYNvtDb/JoJt6s3ryblr4h6gy70g=;
        b=B9HaQORPQI4grECruzNH3W+5u9nr8Jr+sg/eSIGAmjXJFQktjGrhuXth86OUoDUDk0
         F8KVjBz8fMrLGo9uot3DKOYGGZCgCW1EO7WUvB96P0z1vy0TcRSa3isfz9sj3U96KLOe
         PNCxCicRGoUn7coFaA0s95MUo7A4g+08oGMU19+JFpG8R4ho4ZcvV2AMKW8Dku5ALzyk
         Bxj8UflaWGrlzxrODda/USFX9z+byyIVe1MEjmZQcWWEY26xFbIQLi7/0ewjYM//yoVT
         YNthBy7I45H0mHaDYxKwQ8BbRrLwurtVU2+Q6EJRoL/DD395wskazTLP3DlP7J29vuHf
         /Mpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=3yjwrap5tpYm/7QbYNvtDb/JoJt6s3ryblr4h6gy70g=;
        b=kbNfVbE4KDxR7+/rnA6aw39/JZo45ZZj1b7pLjkJGVeC+6ajRRjocfKTLzs07fLlGE
         P+Do5VT9wYNjyXxaDtooe7OwpP5vYIVOp9+Fx5Hjmb+8eW59IQQmCedTlHo6WBoBWi+m
         gE+fazWsM0DDKFBsQU3ayF3WO7ztS6cbWO7FtQ5BwBWmcuM7Tzt3df/3K3uZ/IH+uFhj
         RUug7SjV4ujRz/81jIryGcqbIlU5mdUWNBT2wZRzcoxGVf/cUWsy7dcI1R3LDHcCc7dN
         4cIuAgqfgh5E8ejmGs0+26J3P2TYKRRq6jsCMa5RQopnjJ5uaDwbKe1QwFkVVDBprslJ
         LiNQ==
X-Gm-Message-State: AOAM5338/2eAMTnZz1ZHdZYr2PRwUnSIbiaJughz80c/Icxvx8HPXMwb
        O6/PdHqzmMvT6wGoOx8E9ymTnkWLXJqYfw==
X-Google-Smtp-Source: ABdhPJw42Le5iZT2qXkgrtxMR7FF4qTxmm9m8ebyY+4Wba7HFzlF7+BZgNB/svyFpU6zRVFN50opiA==
X-Received: by 2002:a05:6000:1a89:: with SMTP id f9mr8845596wry.573.1643649246296;
        Mon, 31 Jan 2022 09:14:06 -0800 (PST)
Received: from google.com (cpc106310-bagu17-2-0-cust853.1-3.cable.virginm.net. [86.15.223.86])
        by smtp.gmail.com with ESMTPSA id o8sm9042175wmc.46.2022.01.31.09.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 09:14:05 -0800 (PST)
Date:   Mon, 31 Jan 2022 17:14:04 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] mfd: intel_soc_pmic_crc: Add crystal_cove_charger
 cell to BYT cells
Message-ID: <YfgY3IdqiXo75rX2@google.com>
References: <20211225115509.94891-1-hdegoede@redhat.com>
 <20211225115509.94891-3-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211225115509.94891-3-hdegoede@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Dec 2021, Hans de Goede wrote:

> The Crystal Cove PMIC has a pin which can be used to connect the IRQ of
> an external charger IC. On some boards this is used and we need to have
> a cell for this, with a driver which creates its own irqchip with
> a single IRQ for the charger driver to consume.
> 
> The charger driver cannot directly consume the IRQ from the MFD level
> irqchip because the PMIC has 2 levels of interrupts and the second
> level interrupt status register, which is handled by the cell drivers,
> needs to have the IRQ acked to avoid an IRQ storm.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/mfd/intel_soc_pmic_crc.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
