Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036D251028A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 18:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352805AbiDZQJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 12:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236812AbiDZQJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 12:09:25 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2784579A;
        Tue, 26 Apr 2022 09:06:16 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 5E74D1F42C72
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650989172;
        bh=1wvRqjVZjbReycK48tbxPvly7/Q6yNLcAhf9ITv2WX4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YJ+JNryBr+ROkJYtXFkF2H7ftrQmFIYl0D5Zd8CaOOtgTlc4zdhdCLz4PcLX35eWL
         8LlIMGeCuzRmK5RG257HlotWDGpbNlMgzHXqy4Gw7oR2KBXSx4FjL0HZ3YIys1ZWgK
         Q+dTEiHDJOhNl85mAePKB3wKTVETMQyV6AfLu9ho/YtTWReGmumRRSbAEB3mvyqvpo
         uCoHd0koRXgJUNYWwi/WnkHuMMdL0T10+aMc+rxmrEKSI7Yv5UWDJKJ/q/hbVWWu8+
         6JQq3FJ5jH3QJcgXGiuXkD3MPc1j6lLrdttCq3OL4Tm4RiAX7gUdH+N0e6RPnJfe34
         BeSwA7WpwmCpg==
Message-ID: <bad44be8-abc7-169f-bc7a-cef3692c9a71@collabora.com>
Date:   Tue, 26 Apr 2022 18:06:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v7 2/2] phy: mediatek: Add PCIe PHY driver
Content-Language: en-US
To:     Jianjun Wang <jianjun.wang@mediatek.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Wei-Shun Chang <weishunc@google.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        rex-bc.chen@mediatek.com, randy.wu@mediatek.com,
        jieyy.yang@mediatek.com, chuanjia.liu@mediatek.com,
        qizhong.cheng@mediatek.com, jian.yang@mediatek.com
References: <20220422142331.17173-1-jianjun.wang@mediatek.com>
 <20220422142331.17173-3-jianjun.wang@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220422142331.17173-3-jianjun.wang@mediatek.com>
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

Il 22/04/22 16:23, Jianjun Wang ha scritto:
> Add PCIe GEN3 PHY driver support on MediaTek chipsets.
> 
> Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>

Hello Jianjun,
there's only one last bit to fix, check below:

> ---
>   drivers/phy/mediatek/Kconfig        |  11 ++
>   drivers/phy/mediatek/Makefile       |   1 +
>   drivers/phy/mediatek/phy-mtk-pcie.c | 267 ++++++++++++++++++++++++++++
>   3 files changed, 279 insertions(+)
>   create mode 100644 drivers/phy/mediatek/phy-mtk-pcie.c
> 

..snip..

> +static int mtk_pcie_read_efuse(struct mtk_pcie_phy *pcie_phy)
> +{
> +	struct device *dev = pcie_phy->dev;
> +	bool nvmem_enabled;
> +	int ret, i;
> +
> +	/* nvmem data is optional */
> +	nvmem_enabled = device_property_read_bool(dev, "nvmem-cells");

device_property_read_bool() returns device_property_present().

I would prefer that, instead, you call the latter:

	nvmem_enabled = device_property_present(dev, "nvmem-cells");

It's the same, yes, but this will increase human readability, as the function
name clearly states the intention here.

Thanks,
Angelo

