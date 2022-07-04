Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B62456501B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 10:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233245AbiGDI4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 04:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbiGDI4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 04:56:37 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D04ABCAE;
        Mon,  4 Jul 2022 01:56:35 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 130D966015BA;
        Mon,  4 Jul 2022 09:56:33 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656924993;
        bh=h88dIXJoIJXAQxMuEMOCRNyb0NRHhhEuFsKWrKzCZ3k=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ddINcCtt3FLR1cEjg2qYn/7puGj6dmBsZ8y9bjU2xY9P2Y7mN6NRJDgC3SINCsBKK
         svw7V5vK7wmw6+aiYfNm/vnz3GAYvOKwImKXVTKAbPFbqJEChqA4Kol+l3aMcn16O2
         5aGBYhqIenzshT1ysarDFRpioFSWuSONc0jDJuSaLMfaFMTKalbgKSDsNGzgmAmtAg
         25iv2hyM0PcfC9twPBz2AjHG5bpAYZO+06lvNA3rqK0YcGlmAQmCfjAVf1cRUkkRig
         YxxvZl1IAbLVf1BEZlSM6NeP0N+iaZ+0FW/NcmodvQeVjEfXTjbb+C/mH1H9J7OhFN
         VbD3TYvj1BlVg==
Message-ID: <e846676e-11d7-1bdc-93e6-8999bb66b2a5@collabora.com>
Date:   Mon, 4 Jul 2022 10:56:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 01/11] dt-bindings: arm: mediatek: Add MT8195 Cherry
 Tomato Chromebooks
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, hsinyi@chromium.org,
        allen-kh.cheng@mediatek.com, gtk3@inbox.ru, luca@z3ntu.xyz,
        sam.shih@mediatek.com, sean.wang@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wenst@chromium.org
References: <20220630153316.308767-1-angelogioacchino.delregno@collabora.com>
 <20220630153316.308767-2-angelogioacchino.delregno@collabora.com>
 <20220701220402.v4g6u75mzptb2fly@notapiano>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220701220402.v4g6u75mzptb2fly@notapiano>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 02/07/22 00:04, Nícolas F. R. A. Prado ha scritto:
> On Thu, Jun 30, 2022 at 05:33:06PM +0200, AngeloGioacchino Del Regno wrote:
>> Document board compatibles for the MT8195 Cherry platform's
>> Tomato Chromebooks, at the time of writing composed of four
>> revisions (r0, r1, r2, r3-r4).
> 
> Though r0 is not added in this series?
> 
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   Documentation/devicetree/bindings/arm/mediatek.yaml | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
>> index dd6c6e8011f9..3e0afa17ed2e 100644
>> --- a/Documentation/devicetree/bindings/arm/mediatek.yaml
>> +++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
>> @@ -144,6 +144,19 @@ properties:
>>             - const: google,spherion-rev0
>>             - const: google,spherion
>>             - const: mediatek,mt8192
> 
> Angelo, this patch is depending on the patch from the asurada-spherion series
> [1] to apply. Since this isn't the case for patch 2 as well, I assume this was
> a mistake. And it does seem better to keep them independent.

Yes, thanks for pointing that out - I forgot to advertise the dependency in the
cover letter.

Though, making this one independent from yours isn't really possible, as doing
that would ruin the ordering in mediatek.yaml.

I will advertise the dependency in v2.

Cheers,
Angelo

> 
> [1] https://lore.kernel.org/all/20220629155956.1138955-2-nfraprado@collabora.com/
> 
> Thanks,
> Nícolas
> 
>> +      - description: Google Tomato (Acer Chromebook Spin 513)
>> +        items:
>> +          - enum:
>> +              - google,tomato-rev2
>> +              - google,tomato-rev1
>> +          - const: google,tomato
>> +          - const: mediatek,mt8195
>> +      - description: Google Tomato (rev3 - 4)
>> +        items:
>> +          - const: google,tomato-rev4
>> +          - const: google,tomato-rev3
>> +          - const: google,tomato
>> +          - const: mediatek,mt8195
>>         - items:
>>             - enum:
>>                 - mediatek,mt8186-evb
>> -- 
>> 2.35.1
>>



