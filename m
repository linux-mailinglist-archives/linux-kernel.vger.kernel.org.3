Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 219D0529C95
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 10:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243314AbiEQIeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 04:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236144AbiEQIeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 04:34:11 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25E44339A;
        Tue, 17 May 2022 01:34:09 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 2B88F1F41ECB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652776448;
        bh=LCe72gf7Q6QuyRU8/hNAkV44/40CUOPrEMqg9amSQ6k=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mWuOx6AFAnuY4LuC4el83eJaIr8+U3BZJlHbPUYkQtJljV6YtNFTt7BsfuUSe0+Be
         Kkt1sSbONVTRTrxKUd3jMN1iqIOJ7woU8CjO16EYzUO4NPpj5Sq9lW2srgPc27jPUM
         D+jR1YYzKTzx8Zz4tr+OuxurKqpxGJdEhi4gzziD+eKoRCMRHXJxK2rvyUx1hAxThA
         pJlf75oPSboAcQlnABY1MKvccRmjm2CogQqQW9bqiUmw2HwzHWltElzn17Pf9oh5hD
         KCJ1+roGMSkFEiwkxb87NuoGWHbfsaMMKlrs3CCswLO9CealVlEVy1DMqNeAJbCb3R
         Pi/bAk0pq/VYA==
Message-ID: <ca40156f-5bc1-ef3a-517e-6ad61e9bf3df@collabora.com>
Date:   Tue, 17 May 2022 10:34:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v3 1/2] dt-bindings: pinctrl: Add MediaTek MT6795 pinctrl
 bindings
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     linus.walleij@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, sean.wang@kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, nfraprado@collabora.com
References: <20220505083757.11288-1-angelogioacchino.delregno@collabora.com>
 <20220505083757.11288-2-angelogioacchino.delregno@collabora.com>
 <20220517000657.GA3609297-robh@kernel.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220517000657.GA3609297-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 17/05/22 02:06, Rob Herring ha scritto:
> On Thu, May 05, 2022 at 10:37:56AM +0200, AngeloGioacchino Del Regno wrote:
>> Add devicetree and pinfunc bindings for MediaTek Helio X10 MT6795.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   .../pinctrl/mediatek,pinctrl-mt6795.yaml      | 224 +++++
>>   include/dt-bindings/pinctrl/mt6795-pinfunc.h  | 908 ++++++++++++++++++
>>   2 files changed, 1132 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml
>>   create mode 100644 include/dt-bindings/pinctrl/mt6795-pinfunc.h
>>

..snip..

>> diff --git a/include/dt-bindings/pinctrl/mt6795-pinfunc.h b/include/dt-bindings/pinctrl/mt6795-pinfunc.h
>> new file mode 100644
>> index 000000000000..4888bb7fb9cf
>> --- /dev/null
>> +++ b/include/dt-bindings/pinctrl/mt6795-pinfunc.h
>> @@ -0,0 +1,908 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
> 
> Dual license please.
> 

Whoooops!

Sorry, my intention was to indeed put (GPL-2.0-only OR BSD-3-Clause) here,
like I've done for the others.
I'm sending a v4 with the right license right away.

Thanks for making me notice this unintentional mistake.

Regards,
Angelo

