Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4D8447D0B1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 12:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244513AbhLVLQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 06:16:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236636AbhLVLQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 06:16:25 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E82C061746
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 03:16:24 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id v11so4134686wrw.10
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 03:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=XPWgMgD0XzqoivywAckaojk88eeT9YD0wWezKrZwghA=;
        b=TSQvltnJVjN3Yxq5i38Kl4Zl+tIZLyfhNSEv8RP6YUqRZeNA+cHVSjDndysUjDRfNp
         9pAxUCsoF4c4bKarlN0yohlCyEkXltFo0uTGZxKKnBMkys0KDKqKJUCK6sfApzEY760Q
         DxigGxoUD2smGsMvnNnitkRtD7vIBrGHLvEEhCkuwmQcG8/S50V0jWiC13Q8+drZ6UGi
         ZOnLihm7FMgr7wIL/QE4t0vWJlNZFkN6IagPIfkODJ67ckYHngyQmVRleLEBj/zqVS8m
         uHgpx3J2J/U6g5OgwHEfuZ2FziBzKqcQ9jks70Dz3h8BmSJJQRBvcjKrIJQmSpaeD33R
         16yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=XPWgMgD0XzqoivywAckaojk88eeT9YD0wWezKrZwghA=;
        b=Tuc6MR/KBEBC3dQlWTR6snuFaw8dQ/VRtWV93mwEDFLpZiiX26GCTBvwVu9kwv6LaU
         ZtqKS6qCPgh8rFWijkb5RpSCrjqatIrCYMR4/Jnbu2Ph/3cjmlGMb8arRdG+wZ5Z3I7I
         N6yWqFu4SKpn+J8BemyQW5MNNGTLa0IhxqY+IZUMTT0tLJy7V8cgLaOsdh7U9dtIG/KN
         YgW2qphW16cqx5MSmyU80yjLX3thJDonocP7Gfh5FlLsUKH10HesLxj27dZdYU2nj7GE
         TkGsANftzkVyJZ5Kt+GE1FOnEbOKjT7yTRQNfoXP6QJweNWgfjbFmBpFgurYeqtdLzSS
         Uofw==
X-Gm-Message-State: AOAM5300KwwlK+HbX8uHIszitZwxeZa/RiKSYgl03Gxe7PiGrkYWEtvr
        beBCM9Ulnb49COMz1nm46wnsSw==
X-Google-Smtp-Source: ABdhPJzkB3s0YBKaAq8SlAKtUF6TM0YviOwwlicJEmYHnBrD6uxPU06eJZhrr/MgKRKs9FFzJP99HA==
X-Received: by 2002:a5d:564f:: with SMTP id j15mr1733297wrw.366.1640171783261;
        Wed, 22 Dec 2021 03:16:23 -0800 (PST)
Received: from google.com ([2.31.167.18])
        by smtp.gmail.com with ESMTPSA id j3sm1612934wrt.14.2021.12.22.03.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 03:16:22 -0800 (PST)
Date:   Wed, 22 Dec 2021 11:16:20 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Pavel Dubrova <pashadubrova@gmail.com>,
        Kiran Gunda <kgunda@codeaurora.org>,
        Bryan Wu <cooloney@gmail.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v3 3/9] backlight: qcom-wled: Use cpu_to_le16 macro to
 perform conversion
Message-ID: <YcMJBDcoZc1g7R2M@google.com>
References: <20211115203459.1634079-1-marijn.suijten@somainline.org>
 <20211115203459.1634079-4-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211115203459.1634079-4-marijn.suijten@somainline.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Nov 2021, Marijn Suijten wrote:

> The kernel already provides appropriate primitives to perform endianness
> conversion which should be used in favour of manual bit-wrangling.
> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> ---
>  drivers/video/backlight/qcom-wled.c | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
