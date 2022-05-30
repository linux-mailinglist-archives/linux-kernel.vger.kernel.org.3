Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F5D5376D7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 10:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233917AbiE3Ig6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 04:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbiE3Igz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 04:36:55 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C2F63EA;
        Mon, 30 May 2022 01:36:54 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 868C41F4268D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653899813;
        bh=Y/KtP99ehw9i7ZwsNuEGtXoz1oqAmizCXVVyI5AAj9Y=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Y1zqd2ujFrL3awd9MbIdWvCY47uoQi3Cf8I/Gd+ZxqgM1DoSmpjFPqjlRFth+dcE+
         Vdhtz1b765+cFXX/WbkMNGrRdpsosEPRpaoqa37XNx5DL9jLy3E9/QuHs06pZE8wRY
         YOt+iWAFTw0Wp/lPmXRYfI10A2PkE1faj0fsuSMsXqcD9xpqfYdcqnWk6+0gjEfmVp
         26ZJZ5iVkpCA4fbBymeP+510wy0E45gfGXBDcQjPhq7LrzsXu+DFU38I9r/vS1dyRg
         Cgx2+97WXYGj9gxuuUuhhUrN0JEpxZLjb0OqD+q83ebINTpErHfZpi858NdDGPjwUP
         VEZM5AIw1zJRA==
Message-ID: <5f312705-f09c-763f-7f29-5461cf08ced7@collabora.com>
Date:   Mon, 30 May 2022 10:36:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v1 1/2] dt-bindings: pinctrl: mt8192: Add
 drive-strength-microamp
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
 <20220525155714.1837360-2-nfraprado@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220525155714.1837360-2-nfraprado@collabora.com>
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
> Commit e5fabbe43f3f ("pinctrl: mediatek: paris: Support generic
> PIN_CONFIG_DRIVE_STRENGTH_UA") added support for using
> drive-strength-microamp instead of mediatek,drive-strength-adv.
> 
> Since there aren't any users of mediatek,drive-strength-adv on mt8192
> yet, remove this property and add drive-strength-microamp in its place,
> which has a clearer meaning.
> 
> Fixes: 4ac68333ff6d ("dt-bindings: pinctrl: mt8192: Add mediatek,drive-strength-adv property")
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 

Reviewed-by: AngeloGioacchino Del Regno <angelogiocchino.delregno@collabora.com>

