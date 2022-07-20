Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B429157B707
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 15:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbiGTNKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 09:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbiGTNKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 09:10:36 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D65253D01;
        Wed, 20 Jul 2022 06:10:35 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3CF996601A88;
        Wed, 20 Jul 2022 14:10:33 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658322633;
        bh=jeqvqgxO7A/6sT1qqpmHd9fisrNBZJEFg3LINFIwS7Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=OilSlXJ8lGmJdbXTdLM/ZW+CXHjEwbXiW84uU0jghgqXV/kadvEKWj58iEza6Izdf
         RpU9SJaBmnWeLZONnxIFWfDuDDaPtdgpJRFcm4qM6a9+Ejv9wERp3gXld2lC4qwREX
         uqEZwtmz4m1aEgMcnzqbv+L2iObZMPf/+67hv3DyOukeUqtPfPydIbxt01FiteMCEc
         nSiexE2qz29S22Z5/i71JezrcAy1JQr4JDqPMuOWMThzp7BAiJxAQONNxksrH1OJeY
         1uERup10s+iJLE76Pqm20H1NYYISsrbqmLWk47ZeHfVDgRUuQTPLZaoWktSGet1zqm
         fjPFaXiELCmAA==
Message-ID: <4c75be1e-d1d9-f70f-5d84-3e32c8e757e7@collabora.com>
Date:   Wed, 20 Jul 2022 15:10:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 1/4] dt-binding: mediatek: watchdog: Fix compatible
 fallbacks and example
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, nfraprado@collabora.com
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20220720125015.13797-1-allen-kh.cheng@mediatek.com>
 <20220720125015.13797-2-allen-kh.cheng@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220720125015.13797-2-allen-kh.cheng@mediatek.com>
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

Il 20/07/22 14:50, Allen-KH Cheng ha scritto:
> The watchdog timer of mt8186. mt8195 and mt7986 have their DT data.
> We should not use 'mediatek,mt6589-wdt' as fallback.
> 
> For mediatek,wdt example of mt8183, We remove mediatek,mt6589-wdt fallback.
> 
> Fixes:a45b408a020b("dt-bindings: watchdog: Add compatible for MediaTek MT8186")
> Fixes:b326f2c85f3d("dt-bindings: watchdog: Add compatible for Mediatek MT8195")
> Fixes:41e73feb1024("dt-bindings: watchdog: Add compatible for Mediatek MT7986")
> Fixes:f43f97a0fc0e("dt-bindings: mediatek: mt8183: Add #reset-cells")
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>

Please fix the commit title: dt-binding: => dt-bindings:

After which....

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

