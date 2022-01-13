Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEAC48D55C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 11:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233695AbiAMKDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 05:03:13 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:44232 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232646AbiAMKDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 05:03:11 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id C5C941F4585A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1642068189;
        bh=hb/R6US81LTa1t2TGkbgA8tWMlH58p732cTuKIWvdk4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=UZR6x5Z78fHITIWr6PrsdCNWdFS8PEi6UmHuwhvEfyUHly6ER+uH7jldZC5q3kUoI
         QCClQsZZN1Wvo+509NMUoBH3vhkWaY/rw3rxkNNs8XyubZeSUZncG6qq56VeAI2Nhl
         EecHxZzNyoTn25Jh7N3lwuv7RQaSArAcTM3NDJQ5+IwHVFZgSjko6t2YsuDVX7VDQI
         8Pup239z9US7XJnYDo9AFqtZtGIT1gGk+G/9bQ6KsQO82M3kyw+L6seMqihOmgJUUF
         aZH4jY9GMUTacMGuJwJv4HZ1LIVjnuomg3qmtyeGJJ+e+h46CWtIw/2CatMvV6J95e
         u7Jgjpe//MKaA==
Subject: Re: [PATCH v4 4/5] arm64: dts: mediatek: Correct I2C clock of MT8192
To:     "allen-kh.cheng" <allen-kh.cheng@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, nfraprado@collabora.com
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        chun-jie.chen@mediatek.com, devicetree@vger.kernel.org,
        drinkcat@chromium.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        srv_heupstream@mediatek.com, Chen-Yu Tsai <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>
References: <20220113065822.11809-1-allen-kh.cheng@mediatek.com>
 <20220113065822.11809-5-allen-kh.cheng@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <b9068bf4-5019-f322-24e6-3869ab36ec90@collabora.com>
Date:   Thu, 13 Jan 2022 11:03:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220113065822.11809-5-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 13/01/22 07:58, allen-kh.cheng ha scritto:
> From: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
> 
> When the initial devicetree for mt8192 was added in 48489980e27e ("arm64:
> dts: Add Mediatek SoC MT8192 and evaluation board dts and Makefile"), the
> clock driver for mt8192 was not yet upstream, so the clock property nodes
> were set to the clk26m clock as a placeholder.
> 
> Given that the clock driver has since been added through 710573dee31b ("clk:
> mediatek: Add MT8192 basic clocks support"), as well as its dt-bindings
> through f35f1a23e0e1 ("clk: mediatek: Add dt-bindings of MT8192 clocks") and
> devicetree nodes through 5d2b897bc6f5 ("arm64: dts: mediatek: Add mt8192
> clock controllers"), fix the I2C clock property to point to the actual
> clock.
> 
> Signed-off-by: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
> Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

