Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481245A60C8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 12:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiH3K3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 06:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiH3K3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 06:29:04 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B499D8EF;
        Tue, 30 Aug 2022 03:29:02 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 423FE6601D92;
        Tue, 30 Aug 2022 11:29:00 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1661855340;
        bh=PKyYLG/23Jae2iv0f8420lyRHaoRQtmdhQus4GBtX3k=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fbYaphZJdongwYOH2xf/j+qNzpDQmmZ3fdf+w5NANSWPI+ABahvzh0CV2cIQqp+ZY
         eUrQyQw9/75pm0mBGLmQ4sKCMEKA1OyXNEZj2/3sMPuLyM9TRru7dBByChzmuGJDMp
         F4sFBSeI70zpJJX0yJ2Y7AIEmi3mBDH/jmIofcDdGz4mB53Ufs8Ti0rpzYGXgq0+hi
         xcc5IEN9TFy72cRgV0I6hcpZsfiSTHvu6dZkB8Jsl4+haNdr44Qna9sVFBWeTSf13c
         41IgHfYj4BdTBXCE1PPksFfB/C6prBGcvSLM+6qwow3oafKixAbbAPiaZ0npZS6Asm
         SIOiy5Qp4KitQ==
Message-ID: <68e2d818-3b82-733d-43d8-288f84df6885@collabora.com>
Date:   Tue, 30 Aug 2022 12:28:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 3/4] soc: mediatek: add support of MTK_SCPD_STRICT_BUSP
 cap
Content-Language: en-US
To:     Markus Schneider-Pargmann <msp@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Fabien Parent <parent.f@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Bailon <abailon@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>
References: <20220822144303.3438467-1-msp@baylibre.com>
 <20220822144303.3438467-4-msp@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220822144303.3438467-4-msp@baylibre.com>
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

Il 22/08/22 16:43, Markus Schneider-Pargmann ha scritto:
> From: Alexandre Bailon <abailon@baylibre.com>
> 
> This adds support for MTK_SCPD_STRICT_BUSP capability. It is a strict
> bus protection policy that requires the bus protection to be disabled
> before accessing the bus.
> This is required by the mt8365, for the MM power domain.
> 
> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>

You've renamed the cap, but you kept the old name in both the commit description
and title. Please fix that.


> ---
> 
> Notes:
>      Changes in v3:
>      - Rename MTK_SCPD_STRICT_BUSP to MTK_SCPD_STRICT_BUS_PROTECTION
>      - Remove extra bool variable reflecting the capability
>      
>      Changes in v2:
>      - Fixup error handling path.
> 
