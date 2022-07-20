Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C50E757B70E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 15:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238778AbiGTNMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 09:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiGTNMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 09:12:03 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FE759252;
        Wed, 20 Jul 2022 06:11:58 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4DAF16601A9B;
        Wed, 20 Jul 2022 14:11:56 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658322716;
        bh=7oc6WBjJf/tumB9KMpI0YZxq6H6lB5W4oL3qgJ6y3OU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XKOQM+fNh6zsoKIecOTLM/vTXJzlPo2d/YtqnK4NKSzBa6GjNl+WxBspoIXMCFjtH
         EguKTTTHQzCCJ1o74zw6+wG8Ki/fo8QcYImbOUJ/xND6Z90h/d6Td8b1BjCnSk3D/G
         70ue2tNlOzsMfac3u4U0z3iCtv1IBSFJIAhCPFAaQO3t38FwhLl6GYUIaekBRri/fK
         aQ+lX6DFdY4oO8o4SvHLLug550ecwc057i9O4xUbs7AKtpl4Y9nc5r5A76blF+xPFt
         /AzC4aACQuBkO13poWsxbv5KxnU4S20MXPHpiNmGVY0u4xrZ8TuqoF5jpmeVbMGcZs
         Sr3FYeNe6+A2g==
Message-ID: <bfefe80e-9f14-fccc-bd4a-58ddadfc287f@collabora.com>
Date:   Wed, 20 Jul 2022 15:11:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 3/4] arm64: dts: mediatek: Remove mt6589 wdt fallback
 string from mt8195
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
 <20220720125015.13797-4-allen-kh.cheng@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220720125015.13797-4-allen-kh.cheng@mediatek.com>
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
> The watchdog driver for mt8195 relies on DT data. The fallback
> compatible "mediatek,mt6589-wdt" won't work.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

