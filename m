Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCFDC57D1CE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 18:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbiGUQna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 12:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbiGUQn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 12:43:28 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D74E88F38;
        Thu, 21 Jul 2022 09:43:27 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id bf13so2130255pgb.11;
        Thu, 21 Jul 2022 09:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=bNFDOQJmah/n0o0sHwBe0yT2GoEjpBUain290VFdMeY=;
        b=oUJb93XcDYND+H8F4QP1synpsUQWk144CHQzGU1fzTScljXFDWN+oIembsZD83hQ4y
         xJkSndeuheb+4j24JYz6T2NTeUmwuK3e01C227x53UZAuHGHUL9DDpFH6W4N7cVi3NMK
         5vjpYDM7A1l61OhTjTTN2qI9Il5hYdhbUWAwgv5+WxuQHUoZFPrDxxmFII61FvCw2lEC
         jfYVUuVYAjkCvJ92WudTsZgataz0in/SZPGNzY5SGZb/fLZatIIpNa99CErDAwuA8Kkw
         gFrw6+b6dGH7PTFgpztfDaKWPbBoxfvOIPQXVkT12xWDu4DGmLcQrr/JcdDB5/2D0nSR
         Q4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bNFDOQJmah/n0o0sHwBe0yT2GoEjpBUain290VFdMeY=;
        b=ck97FcBIH8z+7NMz1gKwA2bZ/Vzvml24V7yTKtHKFzpUafKRB93wrygNQguurDMrwS
         AOjef8RVD+ggFJokKAhnQfRc1anPhTFraPR5/wS7SSiLpE9Ql4I4F5E7PBwn9IHwzuCX
         7+4PWFD39IvywGNByaIm90ETOufspfKpE9ZZdtmuBKeDyowmzauhlkhaysBqMpe+f2oc
         u7p7Arw2H1CNchIJJSAObC5u/RL+MrgUd5Gzhxa0w1SV+nA9X0K7dNlUcW8oq+qEsuTX
         Q649Mk6a9OJuOomzTOCGeA3FhpBZSeGMPDjuf0v8QTaEP+gf+Kh9aVKVxrqWQRIdrfjv
         x/qA==
X-Gm-Message-State: AJIora/sDsZU2ByJfTv7sSZTvySlqTmuHkI3LZOwUxo1RKXYs8Tzrrf+
        pHy1eEjGLbqa+rafnBEe3BI=
X-Google-Smtp-Source: AGRyM1tnpxCZCmFptuho0vezsmTa+pYW+ygzYGyHR88YbHknNP7gDiyyBLlDleOQ/rF/qBngJYfshQ==
X-Received: by 2002:a05:6a00:1d18:b0:52a:c350:6538 with SMTP id a24-20020a056a001d1800b0052ac3506538mr45895167pfx.7.1658421806871;
        Thu, 21 Jul 2022 09:43:26 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id 40-20020a17090a09ab00b001f054633283sm3832600pjo.42.2022.07.21.09.43.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 09:43:26 -0700 (PDT)
Message-ID: <e5f3474c-ba7f-7107-064b-74a04b11d7af@gmail.com>
Date:   Thu, 21 Jul 2022 09:43:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RESEND PATCH 2/9] dt-bindings: arm64: bcmbca: Update BCM4908
 description
Content-Language: en-US
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>,
        joel.peshkin@broadcom.com, dan.beygelman@broadcom.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Anand Gore <anand.gore@broadcom.com>,
        Kursad Oney <kursad.oney@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20220721000658.29537-1-william.zhang@broadcom.com>
 <a635754e-bf41-4058-5fbb-57ead36b7128@linaro.org>
 <883c2ad4c36220b488519a8902ad72bc@milecki.pl>
 <193845cb-6149-1ae6-5eb6-6b01ffcf763b@linaro.org>
 <4b5100e4a6e9e581f4b8ab58e5ca4927@milecki.pl>
 <c5b37e68-dc1f-cdae-83e4-23aa0216db69@linaro.org>
 <1d39bbba3f267086eb2884ffcbf4807b@milecki.pl>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <1d39bbba3f267086eb2884ffcbf4807b@milecki.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/21/22 00:50, Rafał Miłecki wrote:
> On 2022-07-21 09:36, Krzysztof Kozlowski wrote:
>> On 21/07/2022 09:13, Rafał Miłecki wrote:
>>>> That's better argument. But what's the benefit of adding generic
>>>> compatible? Devices cannot bind to it (it is too generic). Does it
>>>> describe the device anyhow? Imagine someone adding compatible
>>>> "brcm,all-soc-of-broadcom" - does it make any sense?
>>>
>>> OK, I see it now. I can't think of any case of handling all devices
>>> covered with suc a wide brcm,bcmbca binding.
>>
>> Maybe there is some common part of a SoC which that generic compatible
>> would express?
>>
>> Most archs don't use soc-wide generic compatible, because of reasons I
>> mentioned - no actual benefits for anyone from such compatible.
>>
>> But there are exceptions. I fouun socfpga and apple. The apple sounds as
>> mistake to me, because the generic "apple,arm-platform" compatible looks
>> like covering all possible Apple ARM platforms. I think Apple ARM
>> designs in 20 years will not be compatible at all with current design,
>> so such broad compatible is not useful... but that's only my opinion.
> 
> Let's see if William / Broadcom guys can provide a valid argument for
> the brcm,bcmbca.

It is common practice to provide a generic fallback compatible string for a given chip family/architecture and all of our existing in-tree (and out of tree for that matter) DTSes for Broadcom SoCs do that:

- Documentation/devicetree/bindings/arm/bcm/brcm,brcmstb.txt
- Documentation/devicetree/bindings/arm/bcm/brcm,ns2.yaml
- Documentation/devicetree/bindings/arm/bcm/brcm,nsp.yaml
- Documentation/devicetree/bindings/arm/bcm/brcm,cygnus.yaml

list goes on and on, of course the counter examples are bcm2835, bcm4708 etc. although those are both chip and families technically, so I suppose the conflation is appropriate in that case. So the pattern is simple:

- outside of Broadcom contributors used convention
- inside of Broadcom contributors used another

so if nothing else, we ought to be consistent within ourselves as Broadcom insiders, which we are doing here.

While the generic fallback may not be in use, it still serves a purpose:

- Broadcom likes to create a gazillion of part numbers that are hard to untangle from their original SoC architecture unless you happen to work there so it serves as documentation for others to identify what family they belong to, and what to expect from that

- you never know when you might want to be matching on just the generic compatible string of a family and putting it in there costs nothing at all

The point of William's patch series is to right a number of wrongs on Broadcom's side:

- lack of appropriate involvements at the time Rafal submitted the 4908 support as a "standalone" family, I am to take the blame for suggesting that name in the first place, though I did not know at the time that William and others would ever be contributing upstream

- avoid the proliferation of "sub" families within a larger family (BCMBCA) since that serves no purpose other than to make it harder on users to select what they should be selecting in their kernel *and* it makes us inconsistent with arch/arm64/Kconfig.platforms that attempts to reduce those

I would conclude by asking you: why is this such a big issue? What *actual* problem does it causes, except maybe setting a precedent that you do not like, but for which you practically should have no reason to care as long as the binding is enforced.

> 
> 
>>> This leads me to another question if we should actually totally drop
>>> brcm,bcmbca from other SoCs bindings, see linux-next's
>>> Documentation/devicetree/bindings/arm/bcm/brcm,bcmbca.yaml
>>
>> This would be tricky as it was already accepted, unless all sit in
>> linux-next and did not make to v5.19-rc1.
> 
> 5.19-rc7 has only 1 case with brcm,bcmbca, see ff6992735ade7
> ("Linux 5.19-rc7"):
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/arm/bcm/brcm,bcmbca.yaml?id=ff6992735ade75aae3e35d16b17da1008d753d28
> 
> So we can still clean it up for the 5.20-rc1 or 5.20-rc2.

Not so fast.
-- 
Florian
