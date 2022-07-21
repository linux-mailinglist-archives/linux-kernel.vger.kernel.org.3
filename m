Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2C5057C61A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 10:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbiGUIUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 04:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbiGUIUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 04:20:09 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A63FE20;
        Thu, 21 Jul 2022 01:20:05 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 95E0766019C1;
        Thu, 21 Jul 2022 09:20:03 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658391604;
        bh=y/fFPsOlPV4GL2mR0m0pPDApjYJ3cj6PObA4XyuM2gk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hjwZ3AZkGo3csXK7vpW5drB34k2UtUTcsEezCjcr8zAIljSnqljqal3EMebAdg00d
         Ru/dzPEdqy4a0V1pp25fqfqn1OoqNJMFUQn5WOYwouRRT2x5ftXz24BoA04yavjGA2
         SaC8y2kuMj2Bvb/hkV8E7kp4qqOLRELWL6SM9Z2+41/nFmdIDm7f/JAhpZWA2bsnq6
         7v9TeoUtx+GFVTrQtMHG0WrAlsZy7PkeEfelupm9npMCoLgNKnF5rFmlRF80uy5yoL
         daJo7CabNCX6ffwrMMscM/9yhuhoccGQkwTnFvT22ZKJvMYNXsZujHgdLwJzLVKk2M
         985AMvC1mPsZw==
Message-ID: <dd610200-4edb-e2b2-2fe0-33cafc852952@collabora.com>
Date:   Thu, 21 Jul 2022 10:20:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/4] dt-bindings: thermal: mediatek: add binding
 documentation for MT8365 SoC
Content-Language: en-US
To:     Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        matthias.bgg@gmail.com
Cc:     rafael@kernel.org, fparent@baylibre.com, amitk@kernel.org,
        daniel.lezcano@linaro.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
        robh+dt@kernel.org, rui.zhang@intel.com
References: <20220720181854.547881-1-aouledameur@baylibre.com>
 <20220720181854.547881-2-aouledameur@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220720181854.547881-2-aouledameur@baylibre.com>
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

Il 20/07/22 20:18, Amjad Ouled-Ameur ha scritto:
> From: Fabien Parent <fparent@baylibre.com>
> 
> Add the binding documentation for the thermal support on MT8365 SoC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Acked-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

