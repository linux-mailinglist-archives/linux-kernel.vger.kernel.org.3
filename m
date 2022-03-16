Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3A64DACD9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 09:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354638AbiCPIvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 04:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351817AbiCPIvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 04:51:08 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456A764BED;
        Wed, 16 Mar 2022 01:49:55 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 8E38B1F42733
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647420594;
        bh=tB66TbykoyRuCQTUG/BUm2gTEb/zfXeS1QShvZrZ3cI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=l2KY2+et+JM2EnehlF7yfh95/xSJPPuKCNqM/xv645c16tLUeTYamXldQSlTtLAvU
         wYIN4rsjnhZzKivS5TxpaFSpUfVN/ZwxNzEU/Dx1ql2IECazOa08zyEiwvv01dnIw3
         cXExk3h7CqAd+0QbodnNAVtNs5xcFZj0RjXBHE24RUIbVPE2oUqd62UuZ+3Ne9t2/g
         PEW8xv3C+gKUNQqjm7Hsp1FcG+F4poCz7K+Xyfihb+juAya2nuoU5WQ9rUncH2iBsj
         S2bRfbY9shy8YfLRGO/bGNUbr304a/Jo4KmDbcKRCFCcCWa2wwUQegz5CyI71bNEFs
         70P5mzh/6xWTw==
Message-ID: <6d599c20-0331-d19b-5d20-27a3d3e63533@collabora.com>
Date:   Wed, 16 Mar 2022 09:49:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v1 0/4] dt-bindings: pinctrl: mt8192: Add missing wrapping
 node and properties
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     kernel@collabora.com, Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20220315211936.442708-1-nfraprado@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220315211936.442708-1-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 15/03/22 22:19, Nícolas F. R. A. Prado ha scritto:
> 
> This series adds the wrapping node for pinmux nodes that was missing in
> the mt8192-pinctrl dt-binding as well as a couple other missing
> properties.
> 
> 
> Nícolas F. R. A. Prado (4):
>    dt-bindings: pinctrl: mt8192: Add wrapping node for pin configurations
>    dt-bindings: pinctrl: mt8192: Add mediatek,drive-strength-adv property
>    dt-bindings: pinctrl: mt8192: Add mediatek,pull-up-adv property
>    dt-bindings: pinctrl: mt8192: Add gpio-line-names property
> 
>   .../bindings/pinctrl/pinctrl-mt8192.yaml      | 155 +++++++++++-------
>   1 file changed, 98 insertions(+), 57 deletions(-)
> 

Hello maintainers,
adding context to this series.

We are in the process of upstreaming mt8192-asurada device trees and during
the cleanup process and internal peer-review of those, we have found and fixed
those issues on the dt-bindings for pinctrl-mt8192 with this patch series.

Before submitting the series that introduces the device-trees for those machines
we need some more things in mt8192.dtsi, which are in the process of being
upstreamed by MediaTek (currently at v3 [1] - that needs small changes, but we
expect v4 to be finally ok).

For this reason, we are submitting dt-bindings fixes now, as to have a ready
ground before submitting the aforementioned device-trees (for which, we anyway
need to wait a little, as just mentioned).

[1]: https://lore.kernel.org/all/20220304130809.12924-1-allen-kh.cheng@mediatek.com/

Cheers,
Angelo
