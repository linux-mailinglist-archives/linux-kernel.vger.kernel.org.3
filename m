Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 337C051845D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 14:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235362AbiECMgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 08:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232602AbiECMgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 08:36:19 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7071EAC0;
        Tue,  3 May 2022 05:32:48 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 451221F42C92
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651581166;
        bh=qxbwIud/z0dkgi/rqpCFxK4Db8RLK0j+LCYn27SBNtA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=DE56hFw4/S2R6lSczDYKbM/I2R4smmMDXxQaukD7P9b0dzmlXOfvp1JgQMUu8IYJB
         D4nUan73wyKjV6sD6Wz15zOrCrfJ5Uk8yxJRPQJLXqXYgFR8g9mR8zW7jazlvQoXI/
         tiNSxB96wtyzwh0smXgCyuU67mJ8iTsIun1yEc+9UECcZO106YtWzZoUoICl3ZTQm6
         xSdobzynER0B41xDE4UuPPEsCWvSr1LKx7WCwu75muaNWliR5P5AcZWS9AnKZ/qqbV
         +1YyyR3BFyLvIkIPSDSEWUvkDYhWIqwT4+byLxnFD6noQ3E/qedtKEJg1qpEdz/oSV
         +RoNpDORyJ3fw==
Message-ID: <07889dc4-4198-086b-4df6-e02b65daff10@collabora.com>
Date:   Tue, 3 May 2022 14:32:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/2] dt-bindings: pinctrl: Add MediaTek MT6795 pinctrl
 bindings
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     linux-gpio@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, sean.wang@kernel.org,
        matthias.bgg@gmail.com, linus.walleij@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        nfraprado@collabora.com, kernel@collabora.com
References: <20220503105317.54696-1-angelogioacchino.delregno@collabora.com>
 <20220503105317.54696-3-angelogioacchino.delregno@collabora.com>
 <1651579140.664800.3296827.nullmailer@robh.at.kernel.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <1651579140.664800.3296827.nullmailer@robh.at.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 03/05/22 13:59, Rob Herring ha scritto:
> On Tue, 03 May 2022 12:53:17 +0200, AngeloGioacchino Del Regno wrote:
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
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> ./Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml:100:14: [error] syntax error: expected <block end>, but found '<block mapping start>' (syntax)
> 

Oops. I'm sorry for that, apparently I've sent the wrong version of this series.
Luckily, only the yaml file had issues in that version.

I'll send a v2 soon. Sorry for the noise.

Regards,
Angelo
