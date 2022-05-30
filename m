Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B4B537710
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 10:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233889AbiE3Ie3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 04:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbiE3IeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 04:34:25 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0781A66CAC;
        Mon, 30 May 2022 01:34:23 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id B78A41F42694
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653899662;
        bh=qUCGQiwcmmxHUZWpHYZduseXroEBbLWvH0gOBqAZRus=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=OegG5mkCCC00NQZCKbWpWKo/eyoZEns6uPwDCnhGm7pcarfTCq/jkMWxjMvPVBKvA
         TrOUXwCPnkWP5PtrHHJO/2MRxVMWbhUA2wAqy34QewdTSuhv0o48C/+JBJBNFb6fJh
         kFzJwwRaQDt6p/C9Tip+aJ5zPMfs7yOuas8lRHaUTeQNu+waJ1EMHeNuRUGCtmxDum
         4Xs3pkjATcmTNICMZReOTqhAPi4eSG54/WfHM+G4N4AwE1VSpCXbkbJT6/YCs0xogC
         +SqFChfGfaWZscKKXbY0UmcLBzhQTDRwxAJh261kwsstOLUvPhP+61x6ghWe4V3l5l
         1FSrHDNDPuE7g==
Message-ID: <74a6159b-40d0-bbc3-5b4a-ebf6ed98bac7@collabora.com>
Date:   Mon, 30 May 2022 10:34:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v1 0/2] MT8192 pinctrl properties adjustments
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Linus Walleij <linus.walleij@linaro.org>
Cc:     kernel@collabora.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20220525155714.1837360-1-nfraprado@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220525155714.1837360-1-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 25/05/22 17:57, Nícolas F. R. A. Prado ha scritto:
> 
> The two patches in this series substitute properties in the mt8192
> pinctrl dt-binding for ones which have a clearer meaning and are more
> standardized. At this point there's no DT using the mt8192 pinctrl
> binding, so if such changes are to be made, they need to happen now.
> 
> 
> Nícolas F. R. A. Prado (2):
>    dt-bindings: pinctrl: mt8192: Add drive-strength-microamp
>    dt-bindings: pinctrl: mt8192: Use generic bias instead of pull-*-adv
> 
>   .../bindings/pinctrl/pinctrl-mt8192.yaml      | 58 ++++++-------------
>   1 file changed, 18 insertions(+), 40 deletions(-)
> 

Hey Nic,

As you know, I definitely agree with these changes, but they don't deserve
to get any Fixes tag: backporting should be useless in this case... and you
anyway aren't fixing a faulty binding.

Cheers!
Angelo
