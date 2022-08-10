Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A93558F0BE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 18:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbiHJQvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 12:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbiHJQvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 12:51:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF6F13DDA;
        Wed, 10 Aug 2022 09:51:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 55DECB81E19;
        Wed, 10 Aug 2022 16:51:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36894C433C1;
        Wed, 10 Aug 2022 16:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660150259;
        bh=P83Tql5tDzqXLpKNY/r1pvDY0Hno2eRYNpIyIJiqu4M=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=QjPtmmaL3A+2IOpCb/qcQi3rmMEn3fFona591VAMQyOQEShOZK3Bcg4z4jHWe1cxh
         +l/m45scotgufR0MLbUsiCFcY/95oVeh6cdxCGHerDXLUzUvIQs+TWuIls7CSDGu0C
         FCSZgcTuzCN9/mamt/nNI1+6BJl6UOIjhn/VlwSUEQRsx+Fa+8o0CYygygq3Xazsa6
         vMUeEZm/sNXRF3Z84hSwALF+gT/3IS5et1OtlK3mYteK2XuHOomgVFQy9KR03A657y
         mZKm2o8oJY1Vp5J7GGjw4LhLhn/K99ZtuYViiX0i+Try1dpbdrghmwwk0j8jzOck/B
         xrfeTZfXCAuUg==
Message-ID: <815b03aa-ab39-ec8b-294b-68dff36e2d54@kernel.org>
Date:   Wed, 10 Aug 2022 19:50:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v4 1/4] dt-bindings: mediatek: watchdog: Fix compatible
 fallbacks and example
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        angelogioacchino.delregno@collabora.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20220721014845.19044-1-allen-kh.cheng@mediatek.com>
 <20220721014845.19044-2-allen-kh.cheng@mediatek.com>
 <CAGXv+5HXwVpaJPV-4Z6qw14xZzEkx_E7dVks6-GBa7bQyN8hCg@mail.gmail.com>
 <5dac39d1-3b42-40e9-5693-0c127e8c689a@gmail.com>
 <0fadcd9f50d49ecbb329e76a9ceb6ee689648955.camel@mediatek.com>
 <20220808170355.c2ih3xwqxlddsal7@notapiano>
 <6271732eb27824c5b841760243738ceb062f4c4a.camel@mediatek.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <6271732eb27824c5b841760243738ceb062f4c4a.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/2022 15:58, Allen-KH Cheng wrote:
> I agree the advantage of patch is aesthetic. Since I also want to send
> another "watchdog: Convert binding to YAML" PATCH, it's better let all
> wdt compatibles in the binding match the contents of mtk_wdt_dt_ids in
> drivers/watchdog/mtk_wdt.c
> 
> static const struct of_device_id mtk_wdt_dt_ids[] = {
> 	{ .compatible = "mediatek,mt2712-wdt", .data = &mt2712_data },
> 	{ .compatible = "mediatek,mt6589-wdt" },
> 	{ .compatible = "mediatek,mt7986-wdt", .data = &mt7986_data },
> 	{ .compatible = "mediatek,mt8183-wdt", .data = &mt8183_data },
> 	{ .compatible = "mediatek,mt8186-wdt", .data = &mt8186_data },
> 	{ .compatible = "mediatek,mt8192-wdt", .data = &mt8192_data },
> 	{ .compatible = "mediatek,mt8195-wdt", .data = &mt8195_data },
> 	{ /* sentinel */ }
> };
> 
> We have "mediatek,mt8186-wdt" "mediatek,mt8195-wdt" and
> "mediatek,mt7986-wdt" now and they have their DT data for the reset
> control.
> 
> It's weird and unuseful to add "mediatek,mt6589-wdt" as fallback. 
> 
> 
> Please kindly let me know if I missed anything

How the driver arranges it should not be a reason to use or not to use
specific fallback. Although Rob acked it, but I still think you did not
provide valid reason for the change.

Valid reason is usually the actual hardware (so they are actually not
compatible with mt6589), not exactly how once someone did it in the driver.

Best regards,
Krzysztof
