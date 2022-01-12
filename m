Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F99148C8D3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 17:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355363AbiALQvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 11:51:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244049AbiALQv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 11:51:27 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9947EC06173F;
        Wed, 12 Jan 2022 08:51:26 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id c126-20020a1c9a84000000b00346f9ebee43so1981034wme.4;
        Wed, 12 Jan 2022 08:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=4ZjYXj8qv6hS2+wAqvl/1Wwk2r8Pq9/2mXi3yeFtF7s=;
        b=G8hh+mN2ry5Cl0PdUPbwUVdIr12Ls+UpaTmKZrd8cd4bl/ww1l0YrKPrZoNwqqocx+
         xFzIhogN9FhfLGSHoDKjxkrR78G2GFuIm1ZkLsp3HxQ7N1JLDeDOoXz7W3TovhLK4UwG
         MSOPegKkisyPZhvXmVVyRmmhGuygElbWdv0Bahf5VF31bTBAkSUVu3gLSZf1IUvyArYg
         6g04YWmKok+0kL6y3ZW+WbdFufYeIWnpOGtz0IdfDT7ron4g0gZbiiWs+RmpA4YohuH/
         ra0G4g53zdx7sMBqUaejufmmW2aEIMZUwYy/yeBOV3C8MKOrzQJKAOJ+GTdBawaEwyLd
         M9fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4ZjYXj8qv6hS2+wAqvl/1Wwk2r8Pq9/2mXi3yeFtF7s=;
        b=IC+H3MmjupYHmfLWakLX9wRwkhqXBzbvE57ARrrKwifXCtCThMisk7PTnYFeBUUUBR
         OoPe24eC5WYGQWKoPoWhxN7ZnMGd6YohaUqbOoUvO1rszjuCruWws2B3Q3ZiOR/2hz2n
         PcKpfULjsT2S62MVCwZ3/3hJzeWNn3Wun8bVmJIPIvNXCN5WFFNC8UmTNwYL9/Q0OxYV
         4wzypROqQ+v46NmpIi4hVjKm3gum+FXcSItZmnDBkzkJPcSGbGGQ6/MIBCpDMpk18K5u
         WS08fgSjEwAYedwIFO2wFBSjmchq7u4hAbw8HmbbyepzXCpYlutZveIz6PMQS+aS01Wq
         9zdQ==
X-Gm-Message-State: AOAM530CfwqA2+3q62d+Xe5ZNVkPpWDSHU7M0GINK0JLyO71re9eeh0x
        VhrK3tiblNJVE/slePw8DG9+7+sRdUI=
X-Google-Smtp-Source: ABdhPJwtsfyctmVr0hfiK420v1vmhZrSn70gHUl4KHbqdmHhSLTtJsJyC092jeLQk0GpCHzE1DUivw==
X-Received: by 2002:a05:600c:4ec7:: with SMTP id g7mr310500wmq.152.1642006285088;
        Wed, 12 Jan 2022 08:51:25 -0800 (PST)
Received: from [192.168.0.18] (81.172.62.207.dyn.user.ono.com. [81.172.62.207])
        by smtp.gmail.com with ESMTPSA id f9sm362657wry.115.2022.01.12.08.51.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jan 2022 08:51:24 -0800 (PST)
Message-ID: <d36d276a-c3be-431b-3636-c313cabda3d4@gmail.com>
Date:   Wed, 12 Jan 2022 17:51:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v3 0/5] Update MT8192 Clock Setting
Content-Language: en-US
To:     "allen-kh.cheng" <allen-kh.cheng@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>, nfraprado@collabora.com
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        chun-jie.chen@mediatek.com, devicetree@vger.kernel.org,
        drinkcat@chromium.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        srv_heupstream@mediatek.com, Chen-Yu Tsai <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>
References: <20220112115542.10606-1-allen-kh.cheng@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220112115542.10606-1-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/01/2022 12:55, allen-kh.cheng wrote:
> From: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
> 
> This patch is base on v5.16-rc8,
> series "Mediatek MT8192 clock support"[1], [2] annd [3].
> [1] https://patchwork.kernel.org/project/linux-mediatek/list/?series=521127
> [2] https://patchwork.kernel.org/project/linux-mediatek/patch/20210727023205.20319-2-chun-jie.chen@mediatek.com/
> [3] https://lore.kernel.org/all/20210825011120.30481-1-chun-jie.chen@mediatek.com/

Please update that list to only who the patches that are not yet upstream. That 
will help me to understand if I can take them right now or if we have to wait 
for something to get applied first.

Thanks,
Matthias

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
>   arch/arm64/boot/dts/mediatek/mt8192.dtsi | 92 +++++++++++++-----------
>   1 file changed, 52 insertions(+), 40 deletions(-)
> 
