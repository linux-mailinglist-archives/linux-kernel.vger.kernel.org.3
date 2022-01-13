Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0A1848DB44
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 17:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236446AbiAMQHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 11:07:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236201AbiAMQHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 11:07:33 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434B4C061574;
        Thu, 13 Jan 2022 08:07:33 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id l25so10938240wrb.13;
        Thu, 13 Jan 2022 08:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=PwSeFv9GB4Ge8brnKE8VTFo9qC32x3isiJuiciOy0+g=;
        b=bGvpTJ0coW2ogYsySYSLmXRaVlo4krdScJuayYqdI8bJJxI6EDMQNEN/86qFdwVPTM
         LJvpWMbyl+QIcHoyT4ZYHOG9k/oVxOUnAX0/HUcWKETUxXEQ0UHmZQrckmxduwWCgwUY
         msT9t1UHr8yWZ54u2lt/zcShA0/Rz2k3UlG9wLH1jgpNX88Q31Trny6nKixoJucF+TIQ
         Sp94V1z6ls89wI4FYTKtNWnZbIHOXtGt3M4j0+HM+gQABK5zk/IeGBGPEi/6fYZ7R1mB
         o9S6jMT24mhFsSYg4vsUQkB3qW5uFcRL6+tbK5EZmPQ3tRrtlCDMSosiBPmSBsf/Dbd6
         XoMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PwSeFv9GB4Ge8brnKE8VTFo9qC32x3isiJuiciOy0+g=;
        b=Pc53SjzNDTAKF1ErUc0RdvD5ZsT42aIMmNZuK/sz0ZlpJg/7xnqcvld5S/xf4Fuje1
         9eMgxXUskOGeCtOrDO8byasGfR08im8Zc4MrGlPFirzutDcncaO1GQY4nd+eKbRagCkm
         /Pgeq7BWFSpkJbuz4FOVBRtfn1C0dlbOsP7e35GgbXBuhQ/q2EELIIHmRtdGlhTS+pXg
         WrToNbh9GS+YN50QY5KwCkmAMiFrRVSib/1QI2BN1rCxxJ9VojEhZn/40LvD2cPuYV0A
         UQuU/xTBGSavDZYE2yYG2pu9kN1nAWP8Vnr7HJxyTXeSHFS3kzpmpbqqoIxYIQ3wYJu2
         anxg==
X-Gm-Message-State: AOAM532OkwVqU3VULjG3zH/mQXH2X1I0cFMKTNt6aqWnx0YioJbn/vej
        yWtjN43+XwWgTOnv+0sz/Cc=
X-Google-Smtp-Source: ABdhPJzky7QYTuWWb3OI01G2wOYM6MMzIoWxm0AABm8ROBu/qSEU/Sr7Ja8mkDYAZySUN9+WRMqvYw==
X-Received: by 2002:a5d:5848:: with SMTP id i8mr4580577wrf.398.1642090051785;
        Thu, 13 Jan 2022 08:07:31 -0800 (PST)
Received: from [192.168.0.18] (81.172.62.207.dyn.user.ono.com. [81.172.62.207])
        by smtp.gmail.com with ESMTPSA id c11sm9214288wmq.48.2022.01.13.08.07.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jan 2022 08:07:30 -0800 (PST)
Message-ID: <9d82a86a-74ea-3d2a-2d7a-64fc45042974@gmail.com>
Date:   Thu, 13 Jan 2022 17:07:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v4 0/5] Update MT8192 Clock Setting
Content-Language: en-US
To:     "allen-kh.cheng" <allen-kh.cheng@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>, nfraprado@collabora.com
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        chun-jie.chen@mediatek.com, devicetree@vger.kernel.org,
        drinkcat@chromium.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        srv_heupstream@mediatek.com, Chen-Yu Tsai <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>
References: <20220113065822.11809-1-allen-kh.cheng@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220113065822.11809-1-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/01/2022 07:58, allen-kh.cheng wrote:
> From: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
> 
> This patch is base on v5.16-rc8,
> 
> changes since v3:
>   - update that list(remove already upstream patch)
> 
> changes since v2:
>   - add missing "clock" at the end of commit message
> 
> changes since v1:
>   - update the commit message
> 
> Allen-KH Cheng (5):
>    arm64: dts: mediatek: Correct uart clock of MT8192
>    arm64: dts: mediatek: Correct SPI clock of MT8192
>    arm64: dts: mediatek: Correct Nor Flash clock of MT8192
>    arm64: dts: mediatek: Correct I2C clock of MT8192
>    arm64: dts: mediatek: Correct system timer clock of MT8192
> 

Whole series queued in v5.17-tmp/dts64 which will be renamed to v5.17-next/dts64 
as soon as v5.17-rc1 is released.

Thanks!
Matthias

>   arch/arm64/boot/dts/mediatek/mt8192.dtsi | 92 +++++++++++++-----------
>   1 file changed, 52 insertions(+), 40 deletions(-)
> 
