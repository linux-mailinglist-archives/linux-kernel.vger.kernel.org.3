Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30005584D6E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 10:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234963AbiG2Igy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 04:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233362AbiG2Igw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 04:36:52 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B216863C2;
        Fri, 29 Jul 2022 01:36:51 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 96A9E6601B3E;
        Fri, 29 Jul 2022 09:36:49 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1659083810;
        bh=E+J4ZQLAfZnJ/hOyKXBDqkSw25fcCpHV7oqmKwt4gPw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ViGmF/4qrWVzRtacm9u7huN9NbQz6TuQ1qOqMdgfd54uTJ6s5TonGlb+5/996UBDH
         1YUOXbZoQzlNtjyKx1t6ion+/ey67KjxUzRQhpwUk8c/6IivlfzQ11TAl8caBKBfMH
         SNrUlM7a4RkQ2KpCpBXZTcL7ijrUR0VFzzJQFs7Zc+gcFcCkr1h0uMnecwG64/jiZU
         Yu7MSe7vV6zusJ6G1C5/ysM2VN1gsd1RyUp4vQlJxX5t+82Y4+++sU+DWrP3PP2d34
         P++qFaq/S8CXMA3nrKkVo2AywYfCUtuFUdQE94Rc3jH/jvBZY9vd1x8SbFL+3+//ix
         tdSnbW9Fn0Tsw==
Message-ID: <9d1d8831-844f-f30f-6c8a-fac052f8699b@collabora.com>
Date:   Fri, 29 Jul 2022 10:36:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5] arm64: dts: mt8173-elm: Switch to SMC watchdog
Content-Language: en-US
To:     Pin-yen Lin <treapking@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Evan Benn <evanbenn@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Eizan Miyamoto <eizan@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
References: <20220729053254.220585-1-treapking@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220729053254.220585-1-treapking@chromium.org>
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

Il 29/07/22 07:32, Pin-yen Lin ha scritto:
> Switch to SMC watchdog because we need direct control of HW watchdog
> registers from kernel. The corresponding firmware was uploaded in
> https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/3405.
> 
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
