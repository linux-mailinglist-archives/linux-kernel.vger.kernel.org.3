Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C8351357C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 15:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347564AbiD1NqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 09:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347544AbiD1NqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 09:46:00 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F16145D18C;
        Thu, 28 Apr 2022 06:42:43 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id CD87C1F4516F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651153362;
        bh=iYZrQyYDaLcwiw1zmixcr5Bi+R+FQl0Qqzr4h2rIpAg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Je7BTlfRn/a3tWlEOvFgYsukbFtu7bK5qQ8Bo+FmTlcItjfbEI34AvlLw/h71C6UH
         0LnW8NT71nVeg/Z8F9eoai7khoDT8/en5bPRpGJmHrQbz51VNNH7ZQMho1+PQXqP5K
         5DEPiIzKdK6rmDUeq85JFM86o75i+YZr/Fmevxfmjp4d60l+wD1BBUZfLnZvWjLKXE
         d1VPbsp2qbAG/l2WobO1lVvPO/NtjC5w/gfO7CLbJDPNuAibZJg0vCfTgvNvjFz45d
         OXTeetGwRRUFnXa7HuYY0nj41jMFQ1YDAAVo/Yhbp8O2ERajhKIFcFdE0edc+P6u3B
         DkjqKnFKwgUMQ==
Message-ID: <211b2227-5057-a48f-f813-f50f9c304805@collabora.com>
Date:   Thu, 28 Apr 2022 15:42:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V5 12/16] dt-bindings: reset: mediatek: Add infra_ao reset
 bit for MT8195
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
 <20220428115620.13512-13-rex-bc.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220428115620.13512-13-rex-bc.chen@mediatek.com>
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
> To support reset of infra_ao, add the bit definitions for MT8195.
> The infra_ao reset includes 5 banks and 32 bits for each bank.
> 
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

