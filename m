Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57393583C78
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 12:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236405AbiG1KtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 06:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236532AbiG1Ks4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 06:48:56 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05DAC291;
        Thu, 28 Jul 2022 03:48:52 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AAA976601B41;
        Thu, 28 Jul 2022 11:48:50 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1659005331;
        bh=Rfxcg0iEQFXBWxGeTeIp30bpOBIQldLdjIXrXh76rkw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=h0cQQ3Cg7rssjGPUCBqL5TZ8M89UkaL4FM5h6WwF+d68/KFa2P+OqQ9cu4KRkG1mF
         ONf5jMjK7LmQk69AalHqV6jw4aNiFA9+fCC/fpkh7jLmtPRBaWDB+ExSVdRzmSATqd
         bc3y5H4/FjPT+cDUjUq2mOfu0cbYVV5wd6sPasVpKcgvibhSqDoG4qlP821NTb6eKW
         uRQ/30ExIE2xmOTlGFKPcYHkksZwVWdngzINr5GWgvC1SauO8PBogBTSsOHrUZnH1k
         wH6so/lk4PQQu/gND4YHMZJSE9cgo16ipk/jb4pVR3W5Wx+HSCg2AzGhztnyfyAnyn
         w7Sqw5oqN3DNQ==
Message-ID: <de66908a-76cd-db18-82d3-6125ddb6b798@collabora.com>
Date:   Thu, 28 Jul 2022 12:48:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 2/2] pinctrl: mediatek: add mt8188 driver
Content-Language: en-US
To:     Hui Liu <hui.liu@mediatek.com>, linus.walleij@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        jianguo.zhang@mediatek.com, zhiyong.tao@mediatek.com,
        sean.wang@mediatek.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220728084951.22102-1-hui.liu@mediatek.com>
 <20220728084951.22102-3-hui.liu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220728084951.22102-3-hui.liu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 28/07/22 10:49, Hui Liu ha scritto:
> From: "Hui.Liu" <hui.liu@mediatek.com>
> 
> Add pinctrl driver support for MediaTek SoC mt8188.
> 
> Signed-off-by: Hui.Liu <hui.liu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

