Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52DB858A852
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 10:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237754AbiHEItG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 04:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiHEItE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 04:49:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF3A7205FC;
        Fri,  5 Aug 2022 01:49:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8B3E1B8275D;
        Fri,  5 Aug 2022 08:49:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 319E1C433D6;
        Fri,  5 Aug 2022 08:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659689341;
        bh=QV2T3OgNhSLSxJ+SL9EEf8c34jK/JO3wBghCapg8t5o=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=sSvMNYmA33n1k21Ws5eZ1oDJSeOQbqX3HY+kdNH54GuCS1+owWIUZtcQg77HhzjcE
         aSSM8ABQZv/Mu5ho3x0aIbreKRc6BdHdNM4I20clcG+4FIXzu9hEdBKJsUeOvAeeY6
         kXI8YgHw8QOV/parqBed4LxkJHrJOxsUDnmOtFIv14JUTzTVX3rPxgHks2NEY2+spq
         ItmTemqm0LePFMIumon8bOBUOfSfwSF+4rUAIj5aSoBpMV9VT9YMB3N9bMcgmRKv45
         5tgoyzB5yqIK1UjtSknhhVlFHbHRLzK4yjv6Q4PTYU2FZXymMoUSX190gR/NA/CBj9
         DP7sqeQwkffAg==
Message-ID: <d681bcab-da6e-4cd9-f3f1-438e9a7481cd@kernel.org>
Date:   Fri, 5 Aug 2022 10:48:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v8.1, 2/7] dt-bindings: thermal: Add binding document for
 LVTS thermal controllers
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, bchihi@baylibre.com
Cc:     rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amitk@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        mka@chromium.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        matthias.bgg@gmail.com, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, james.lo@mediatek.com,
        fan.chen@mediatek.com, louis.yu@mediatek.com,
        rex-bc.chen@mediatek.com, abailon@baylibre.com
References: <20220804130912.676043-1-bchihi@baylibre.com>
 <20220804130912.676043-3-bchihi@baylibre.com>
 <20220804231119.x6l2nl362rqvlk6u@notapiano>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220804231119.x6l2nl362rqvlk6u@notapiano>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/08/2022 01:11, Nícolas F. R. A. Prado wrote:
>> diff --git a/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml b/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
>> new file mode 100644
>> index 000000000000..53c44a73f3a4
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
> [..]
>> +  nvmem-cells:
> 
>        minItems: 1
> 
> since mt8192 only has one of them.

Then add allOf:if:then: which will constrain it per variant/compatible.

Best regards,
Krzysztof
