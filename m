Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3654578432
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 15:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235191AbiGRNrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 09:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235441AbiGRNrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 09:47:02 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CDB1B7BC;
        Mon, 18 Jul 2022 06:46:55 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BD5E366015A2;
        Mon, 18 Jul 2022 14:46:53 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658152014;
        bh=6W6w/V/cgC7i8dcLnR8Z1tgmXFyjXKpDCXUfV/w0+2c=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YdS48N30Hps+3LGmWFkFB4fikJKuoYdrzAvLVEHRxUquGqm4k68AP27mMCJczodZn
         95tmpuqcvKk2A1IsrYE6RWCLUFY1TinpdHHaVZw+wAIHJVtdXZuyxI9YCLGpn3DRFa
         88o1fY2ybN9Cdm580ibkNjVmZ/S6f/2kYcoAxQlDqTkdnB1qvZ57O9Mmq9Wcj6r0rq
         glEgQdfah3YCTHCL5ZSvezg0GGQPI0sLy/J/I7gIyqB/VB5A+//JyKekUZ2z4xyQ8e
         MLV03qDJ9AYwJhExZBjBmNiTs/6g8nvGZuWTmUaXCOzsZNUP+iyJVw8xVmaRyxkLrA
         EQq/7RcQsY/Og==
Message-ID: <acfac038-3ac8-1748-1ffa-cb85771f2f6c@collabora.com>
Date:   Mon, 18 Jul 2022 15:46:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] dt-bindings: pinctrl: mt8195: Use drive-strength-microamp
 in examples
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, sean.wang@mediatek.com,
        nfraprado@collabora.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220715103029.204500-1-angelogioacchino.delregno@collabora.com>
 <CACRpkdYagmVAim68q=AOzrQfPw=fk5Q1z+B7X3nRDa-X4XukOw@mail.gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CACRpkdYagmVAim68q=AOzrQfPw=fk5Q1z+B7X3nRDa-X4XukOw@mail.gmail.com>
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

Il 18/07/22 15:35, Linus Walleij ha scritto:
> On Fri, Jul 15, 2022 at 12:30 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
> 
>> The property mediatek,drive-strength-adv was deprecated: change the
>> example for i2c0-pins to use drive-strength-microamp.
>>
>> Fixes: b6d9af2c6b69 ("dt-bindings: pinctrl: mt8195: Add and use drive-strength-microamp")
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> After finding this in my Inbox, drop my own uglyfix and apply this instead.
> 
> Yours,
> Linus Walleij

Thank you!
