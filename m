Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA9E52D698
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 16:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240083AbiESO65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 10:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238833AbiESO6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 10:58:48 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D173DD80BB;
        Thu, 19 May 2022 07:58:43 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 0AADC1F44EC7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652972322;
        bh=Um2t/mQTT0Dfq5mGxwYI25I8sQfayys0cBiO/aP38w4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LdfZwN5W6GT9WmGChNKa2aESgz37yUfbtnVDS6og+GqOBa53Qwpc+CCVFJtLhuLcq
         /DAfg6JwEvY1KuxMLzketpMx9FiAKSxxZKKil5+D3iZ+PZKEKmIIYyw43k9ETR03Vu
         bZ8iSTGJPaNrUjQ4mmCV80y3zhdRym/Ir02fTIzgW9bRRNy8ilj5JzAtDdlDCKYjm9
         GC8fzeFrtkA/q6MEP5JdryG+TlLCS3lzkn2Rm21/GPtdOi0FwLVCYOE05ySIIukvch
         v0N58JWyVSHRMyGvzgshdNk41n9pkic10Nh8PYR6GzVowVJjXKpXF2cTDEkQs76GsV
         LHXLTrnSU0AgA==
Message-ID: <3f3dd71b-6e5c-4e19-c8d6-ece88c7e0eb4@collabora.com>
Date:   Thu, 19 May 2022 16:58:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v4 1/2] dt-bindings: pinctrl: Add MediaTek MT6795 pinctrl
 bindings
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, sean.wang@kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, nfraprado@collabora.com
References: <20220517083957.11816-1-angelogioacchino.delregno@collabora.com>
 <20220517083957.11816-2-angelogioacchino.delregno@collabora.com>
 <CACRpkdaj42rcQdX1+dVWyHmexrq4UDQHB0JLHgfREY9kn0zv2A@mail.gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CACRpkdaj42rcQdX1+dVWyHmexrq4UDQHB0JLHgfREY9kn0zv2A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 19/05/22 15:13, Linus Walleij ha scritto:
> On Tue, May 17, 2022 at 10:40 AM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
> 
>> Add devicetree and pinfunc bindings for MediaTek Helio X10 MT6795.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> Patch applied, along with patch 2.
> 
> BTW nice work on the X10!!
> I can see from the feature matrix here:
> https://wiki.postmarketos.org/wiki/Mediatek
> that this enables a whole slew of cheapo phones and tablets to be used
> with PostmarketOS.
> 

I'm really happy to see that you appreciate this effort!

Unfortunately though, the PostmarketOS wiki contains just a small subset of
Helio X10 devices, there's many more around!!

I'll start the trend with a Sony Xperia M5, hoping that someone else starts
following up with some more :)))

Cheers,
Angelo

