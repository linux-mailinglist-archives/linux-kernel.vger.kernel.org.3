Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD2715730EE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 10:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235065AbiGMIXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 04:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235585AbiGMIWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 04:22:43 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FA2E95F6;
        Wed, 13 Jul 2022 01:20:25 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7F2796601A38;
        Wed, 13 Jul 2022 09:20:23 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657700424;
        bh=yUZfFeWX08WQ/h5QZHogA0CwHAk3IBZ1IURWDjXkS94=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=khuBMLoFTYzGB7cWlzNd6mF6vKuHAyJnQAYpzWiDtyBL3aj2pahqgwvfWG4YsWbBb
         5plNZNtCLN2aNVHLY07BlTDzQcM7r+GpEOMg63+na0OOmxN/+YB5YM5QAOPGDj1bmd
         PtixwRkB2fydejmOlqHUzd7cXYPC0CLZp7AZuG/WhzVUeRnpCeY9Z/d2CfyzLiklTH
         /TH/i6I7GTuNMfKHMeK4ceg4Oz2y+8qt7jvWGWmiLCDt/inmgTh0OHYVt56PzM5fU3
         /vx4jZZsqYzpM1lZ0z6lfjRIfCF44sQSC4G8dIhSgzfpS3/yYq17GHAd53wKyZIzea
         TtWQEccGBo7rA==
Message-ID: <4b6a4a1f-2e33-f037-6736-b2dfb1750ed6@collabora.com>
Date:   Wed, 13 Jul 2022 10:20:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/2] dt-bindings: soc: mediatek: add mdp3 mutex support
 for mt8186
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Xiandong Wang <xiandong.wang@mediatek.com>
References: <20220711123247.15807-1-allen-kh.cheng@mediatek.com>
 <20220711123247.15807-2-allen-kh.cheng@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220711123247.15807-2-allen-kh.cheng@mediatek.com>
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

Il 11/07/22 14:32, Allen-KH Cheng ha scritto:
> Add mdp3 mutex compatible for mt8186 SoC.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> Signed-off-by: Xiandong Wang <xiandong.wang@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

