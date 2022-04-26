Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A73250F9C3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 12:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345305AbiDZKLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 06:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348373AbiDZKLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:11:07 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A7020A438;
        Tue, 26 Apr 2022 02:34:16 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id D45D81F42EA7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650965655;
        bh=jtBKZC8RMt0jLfx45LC4xjlbnrdyLhFIEyBfRCIsU3c=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=EcC8zmqm/98TOeg67Q/LVCohjVTuTwTt4SBXcqP8tjTZHkv3Of0oI8k4aeTi0udqc
         uT6y59H10IzChaboaSVVAGq/UzdJS0i29i3axjratfqWD7BR8QACinuR1FqxQID/ga
         rL6A3q5XfpOQOTsmuIRJflpK04MnCYtg54VPtZpoawu0bW9P1OZQKOkmTtslW5VHHF
         D8Ku4jqS0Ln0NizY9tc9OoJfSgFvorQWwu1Ifxs+I1WCh7JYqBtTwP2S0J2y2+Lr7k
         XzFcqVsMDgcAwOMEAFwBY6lYrDPg46jNjkIZkVDWCq+uo0XH+caicKAWYt6pC2kD+v
         IelgBvEo69KEQ==
Message-ID: <5a927c06-92af-4608-cb74-eb53a12248d7@collabora.com>
Date:   Tue, 26 Apr 2022 11:34:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH V3 05/17] clk: mediatek: reset: Merge and revise reset
 register function
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, mturquette@baylibre.com,
        sboyd@kernel.org, matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     p.zabel@pengutronix.de, chun-jie.chen@mediatek.com,
        wenst@chromium.org, runyang.chen@mediatek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220422060152.13534-1-rex-bc.chen@mediatek.com>
 <20220422060152.13534-6-rex-bc.chen@mediatek.com>
Content-Language: en-US
In-Reply-To: <20220422060152.13534-6-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 22/04/22 08:01, Rex-BC Chen ha scritto:
> There are two versions for clock reset register control of MediaTek
> SoCs. The old hardware is one bit per reset control, and does not
> have separate registers for bit set, clear and read-back operations.
> This matches the scheme supported by the simple reset driver.
> 
> However, because we need to use our data structure "struct mtk_reset",
> we can not use the operation of simple reset driver. We keep the
> original functions and name this version as "MTK_RST_SIMPLE".
> 
> In this patch:
> - Add a version enum to separate different MediaTek reset hardware.
> - Merge the reset register function of simple and set_clr into one
>    function "mtk_register_reset_controller".
> - Rename input variable "num_regs" to "rst_set_nr" to avoid
>    confusion. This variable is used to define the number of reset set.
> - Rename "regofs" to "reg_ofs".
> - Adjust delaration type for mtk_register_reset_controller().
> 
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

