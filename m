Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376304DACA3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 09:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354585AbiCPIlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 04:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354565AbiCPIlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 04:41:09 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A8864BC2;
        Wed, 16 Mar 2022 01:39:55 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 0F2571F42D12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647419994;
        bh=bHSGpAY3H23x1JXYE/vlHRyklr14DosBMgReoFNi82w=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MHiJhWlwW1xeZka6HRhpj+rlWu+9Kd8BURuDH3UuA5LviMHOn7BaZFsEDpXsdmgOv
         33hZ9D/+xvXcxuh8EtscEFl7PtXnhKjsn1+r399kfidoFhnO4Sb3f7ZunA5iKpgUzJ
         RcYSOtEUGInpXxyp9kZTHWi0G7ZmgN2POFwYI0CCrKJQBcDf6/836YmDrkDERGUzZz
         vm7GvoqYB1530JKF4ZqoPAmYivaUJd6EvhY6N1xE4/m1rxAjjjZkQgRW23+LnGPxtX
         FQAdnaOdyY4t4BWCriSGuJ3ej9Cxf2YqK+tO0wefzLkFkVyZCDPfPcgPn+Dcfl2P3t
         J57/EiGZFw6wQ==
Message-ID: <49885741-ec06-c73e-23e9-6c946c25a2df@collabora.com>
Date:   Wed, 16 Mar 2022 09:39:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v1 1/4] dt-bindings: pinctrl: mt8192: Add wrapping node
 for pin configurations
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
 <20220315211936.442708-2-nfraprado@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220315211936.442708-2-nfraprado@collabora.com>
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
> On mt8192, the pinctrl node has pinctrl groups to group pin
> configurations. Each pinctrl group contains one or more pinmux subnodes
> to list needed pins and their configurations. By supporting multiple
> subnodes, we can configure different pin characteristics
> (driving/pull-up/pull-down/etc.) in a pinctrl group.
> 
> Update the mt8192 pinctrl dt-binding to add the missing pinctrl group
> node that wraps the pinmux subnodes and update the example at the end.
> While at it, also remove the example embedded in the description since
> it is redundant to the already supplied example at the end.
> 
> This same change was done for mt8195 in commit 79dcd4e840cc ("dt-bindings:
> pinctrl: mt8195: add wrapping node of pin configurations").
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 

Hello Nicolas!

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
