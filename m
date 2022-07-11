Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B78856FFCC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 13:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbiGKLMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 07:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbiGKLMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:12:15 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77848048F;
        Mon, 11 Jul 2022 03:22:41 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EE47466016BD;
        Mon, 11 Jul 2022 11:22:39 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657534960;
        bh=uNSY1KEUgiLFkGB3AzkLv6tdObowCzuDnC7wc0SAWcA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jaInF/oFJOarybKy7pplqdc+rLHn+dLm1J0QKzitXilrUM1PEx0vV2KNOJcnmdTk7
         HO0KjGSoAigB8FuhjpPwLvOmzNJI2MmMuhuVtfgDe86pWqhOo/lWroTyw/DKV2V2OP
         8gFc/3Iu65wdE48j02tuZsXbduJldgUBUEXmAtV2Hq0dDYfcbdfD6Cw5HJoDMqwWUA
         fLfM9Lp2OmWrDNP0jrsTu2NbS3SvsRlBNAcHyzeSfEKIJyshgvbgIYh4580E1BXkzq
         RAIdnbvQ6YAugn8qluz6iaEUxnZhyqaquElhKKPkHvzYhR0SnPWzcGL8GrsC81BXE5
         q0MnMz+yehjdg==
Message-ID: <ae9ec58e-649a-0738-7dff-dffadea3de4c@collabora.com>
Date:   Mon, 11 Jul 2022 12:22:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V3 1/2] arm64: dts: mt8173: Fix nor_flash node
Content-Language: en-US
To:     Xiangsheng Hou <xiangsheng.hou@mediatek.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, bin.zhang@mediatek.com,
        benliang.zhao@mediatek.com, linux-mediatek@lists.infradead.org
References: <20220708021548.21453-1-xiangsheng.hou@mediatek.com>
 <20220708021548.21453-2-xiangsheng.hou@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220708021548.21453-2-xiangsheng.hou@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 08/07/22 04:15, Xiangsheng Hou ha scritto:
> Add axi clock since the driver change to DMA mode which need
> to enable axi clock. And change spi clock to 26MHz as default.
> 
> Signed-off-by: Xiangsheng Hou <xiangsheng.hou@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

