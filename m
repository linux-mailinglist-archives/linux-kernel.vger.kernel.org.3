Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D03AD513567
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 15:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347468AbiD1Nlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 09:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347513AbiD1Nlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 09:41:35 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7459B3C41;
        Thu, 28 Apr 2022 06:38:20 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id A6BB21F458A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651153099;
        bh=cmIfSy8CafEA7WKzM2siN0tevY6CnBZ1OIjAqjL90Co=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bt4Q8bVE5cw+o5ezxzLR/F6y/Suo6+8SwvV5DVnTXw0ZJ5inAli4PziK4OhL7eH1T
         gxycmkloO9rgd4t7ACEOIVzKWompfyvDJpECT2xCsE3dqO7mtPSPtkSsuk6cLI2ZeU
         PzpQZFP2mpiZfeI4thXumVDg/VvmCyhwwNKA4pRsjwWzW6dxM40pt0/28EnlHc2lJy
         QAmFz1gayjcBfaHYU+KWB58mPpQ2hBil4dlb9uk1WotJ7VOv2T3la0jd+LQ18gG3xn
         88xImrSs7MBLUJZTe8fF9rIsumT43J3LfG/sQI7V1/8YuIJmAXw08gk1IR4/oF6gEO
         29uLM0zKmRUBA==
Message-ID: <79b2bdef-37b5-9b15-3739-5281d4bc8c9e@collabora.com>
Date:   Thu, 28 Apr 2022 15:38:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V5 07/16] clk: mediatek: reset: Support nonsequence base
 offsets of reset registers
Content-Language: en-US
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, mturquette@baylibre.com,
        sboyd@kernel.org, matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     p.zabel@pengutronix.de, chun-jie.chen@mediatek.com,
        wenst@chromium.org, runyang.chen@mediatek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220428115620.13512-1-rex-bc.chen@mediatek.com>
 <20220428115620.13512-8-rex-bc.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220428115620.13512-8-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 28/04/22 13:56, Rex-BC Chen ha scritto:
> The bank offsets are not serial for all reset registers.
> For example, there are five infra reset banks for MT8192: 0x120, 0x130,
> 0x140, 0x150 and 0x730.
> 
> To support this,
> - Change reg_ofs to rst_bank_ofs which is a pointer to base offsets of
>    the reset register.
> - Add a new define RST_NR_PER_BANK to define reset number for each
>    reset bank.
> 
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

