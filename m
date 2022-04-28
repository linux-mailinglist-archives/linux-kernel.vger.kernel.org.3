Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E982513574
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 15:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347566AbiD1NqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 09:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347551AbiD1NqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 09:46:00 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF685D1AA;
        Thu, 28 Apr 2022 06:42:45 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 1DA3A1F458A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651153363;
        bh=lFSmPQ6PFhO5ERCn4hu/jKvQB+1Z2GRxC2+gfU9daR0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Br1Q7PegFMBxQSWK/j+TKX1R87dhrCv4H68XpuT+wJjXMu6ssa9WYeLkSnzTtSfW8
         giwvsb8RiWTKcGrDk//NCu/rFINIDOq5a/S02ytf8ZdRfb0fpYY/lnCKdsWvHTpXkQ
         ePzRFS7XpFgT1VohDudfoYmI6FSB6RQfiCLKlg2RCQXJwUr/AQs0dSE89H0RIGoehd
         dyHIPhmH7te1t35bMJOcYWrk8qmsCAsu73E+PgadWze8/IzoALhB8tNg9DO4QcRb0P
         FYOzXNLoetf/lUvQ2mT35NBGV0oTtypP/BliKJWs5K1r2P0E4vx67PY1kFn1IacoRG
         MqX6dIPunKhCQ==
Message-ID: <8552f214-3476-8140-47dc-5d5b95ebcb1f@collabora.com>
Date:   Thu, 28 Apr 2022 15:42:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V5 13/16] dt-bindings: reset: mediatek: Add infra_ao reset
 bit for MT8192
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
 <20220428115620.13512-14-rex-bc.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220428115620.13512-14-rex-bc.chen@mediatek.com>
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
> To support reset of infra_ao, add the bit definitions for MT8192.
> There are 5 banks for infra reset and 32 bits for each bank.
> 
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

