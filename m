Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4B8573025
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 10:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234787AbiGMILB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 04:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234268AbiGMIK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 04:10:57 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13608E95C6;
        Wed, 13 Jul 2022 01:10:57 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BCD84660159E;
        Wed, 13 Jul 2022 09:10:54 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657699855;
        bh=SYXH3VV5ZDj1Hp31QoluVhawUYk9CSuIakPAfiP/RDY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=B58lSA6mYO+vxcsz/XDdSZoo8bNzhTBWQ79EyX0dwUfixquA+WkdvHS4jEk6qbxAc
         r/LJ0DdIuhk5uwcsFlyLrVftGLCQsSzSpUykRb9ywJqab8f+O38BoymJbk3g/MUkb5
         cySE0opDa+R6dqjcdb5gsCGOlMq16WSVY0tHnh0P7u/IwnNgH9lAM6TnDaOeGHyV7L
         pruGCeK9fjERA9Fdx8LGsCWyen6zJSytLJi6Ll6TBv/HzhaF16BUIiZS6cWsUdGuGV
         8S92+cKm8sMoi9p01AmEyP0AXvVcI9lVKXsIXvXtfyCbviXrXVD+MrO8wcoJnqRRbY
         s8t9LnpY0Q+DA==
Message-ID: <eeb303a0-4a00-dee0-6982-b9eff13e55da@collabora.com>
Date:   Wed, 13 Jul 2022 10:10:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 3/5] arm64: dts: mediatek: Add mmsys #reset-cells
 property for mt8192
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>
References: <20220712114046.15574-1-allen-kh.cheng@mediatek.com>
 <20220712114046.15574-4-allen-kh.cheng@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220712114046.15574-4-allen-kh.cheng@mediatek.com>
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

Il 12/07/22 13:40, Allen-KH Cheng ha scritto:
> To support reset of mmsys, we include mt8192-resets.h and add
> property of #reset-cells in mmsys.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
