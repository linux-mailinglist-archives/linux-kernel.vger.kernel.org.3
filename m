Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F86A57C50F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 09:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiGUHLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 03:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiGUHLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 03:11:39 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C13E7B1DA
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 00:11:38 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id p6so754632ljc.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 00:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=VBDe4gorRUprlTmBClJI/DlecJjKNCX0yBbr1Si/Kq4=;
        b=UY8lpCxmvbtL/toGtsqltQnAwxXPAPj/BCPbeGrIolwMwllrvM9dWaWjlPyDIKSFQR
         N8A4f2HAiYO7ETqOVF6xYsfX8YcjEL2Ts5VkzkYYcT6bbgiSF/5xTTJcb48nsn1wYTtC
         3tT1PfchNwMIwVobbX17i2WWsNDAe+okLqFBmvAM5WT1vZMy5siVrVW/I02HtMI4zaFd
         SpeZPF9BpsR1vPBEwDoJVjQleSxqTT+xjGj113pcLEyxUfRFq4xFnS0bm/GboRE10dI0
         I/x5/rrcTMDs/IT7G0+IUi7cSCbkXZR6BiIfInjMFX/BGD8oKFmWlHMGNLCL+u5EKu+c
         SRVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VBDe4gorRUprlTmBClJI/DlecJjKNCX0yBbr1Si/Kq4=;
        b=ZZBbCoq/ipF775KleePWwQv/Uq/HKtkKm86PQe/uBOSBwjwzZEUXcos9IkrHHzwgMy
         dS3I2ClZv6OGWzDDSreAYmL2Nzoz4DFs2N0vdG7LJv1mzohZ/uCxkjNfdJmoEFg5xle+
         fZwdfJOtEekyrem5Wx6Jew5//L1OMkpIOQ2yu3Z47r/DWkhOcghW1QfPNTNon94PMCQI
         HL9SemVijWZLPFMNFRMqSkZIvMy+dPbhJyfOliKaLOtL41Vbox3xQow10AZSIB+krS4R
         AubR4Btzl9KRb6HC4qOEyD80ep6TkepddLe/dvwDqf3z7XRCopT0H9DycD6twCKxFvZP
         6tEA==
X-Gm-Message-State: AJIora+f71kbZLF2qptDS6EP6At6mUls1LJgsXJb4g+9pZVM7R3NrYj8
        d7Ajn23pV1YWJeGv7Bsj8x6CnQ==
X-Google-Smtp-Source: AGRyM1sP/W0gXXiVd0E1gcpliLF83/mwjurfkbq28/xa3UPvrWoPr9+eLGizH6pNBoPYCugtoCbZfQ==
X-Received: by 2002:a2e:a287:0:b0:25d:b515:430c with SMTP id k7-20020a2ea287000000b0025db515430cmr9235376lja.358.1658387496614;
        Thu, 21 Jul 2022 00:11:36 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id 23-20020ac25f57000000b0048159b43083sm255519lfz.201.2022.07.21.00.11.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 00:11:36 -0700 (PDT)
Message-ID: <174eaacb-27e6-0ce3-3a27-07137a4d1a0d@linaro.org>
Date:   Thu, 21 Jul 2022 09:11:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: aspeed: document Ampere
 Mt.Mitchell BMC compatibles
Content-Language: en-US
To:     Quan Nguyen <quan@os.amperecomputing.com>,
        openbmc@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, soc@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        Open Source Submission <patches@amperecomputing.com>
Cc:     Phong Vo <phong@os.amperecomputing.com>,
        thang@os.amperecomputing.com
References: <20220720085230.3801945-1-quan@os.amperecomputing.com>
 <20220720085230.3801945-2-quan@os.amperecomputing.com>
 <0a5cbaaa-565a-7215-5e31-12c52f4bbcbd@linaro.org>
 <4516d7a6-f493-aa51-2700-bbab8ea8533a@os.amperecomputing.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <4516d7a6-f493-aa51-2700-bbab8ea8533a@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/07/2022 04:46, Quan Nguyen wrote:
> 
> 
> On 20/07/2022 17:34, Krzysztof Kozlowski wrote:
>> On 20/07/2022 10:52, Quan Nguyen wrote:
>>> Document Ampere Mt.Mitchell BMC board compatible.
>>>
>>> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
>>
>> Thank you for your patch. There is something to discuss/improve.
>>
>>> ---
>>> v2:
>>>    + Introduce in v2 to add Ampere Mt. Mitchell BMC compatible [Krzysztof]
>>>
>>>   Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
>>> index d61408194998..b8146d5c4431 100644
>>> --- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
>>> +++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
>>> @@ -71,6 +71,7 @@ properties:
>>>             - enum:
>>>                 - aspeed,ast2600-evb
>>>                 - aspeed,ast2600-evb-a1
>>> +              - ampere,mtmitchell-bmc
>>
>> Put the entry ordered alphabetically.
>>
> 
> Thanks Krzysztof for the review.
> 
> Will change to :
>               - enum:
>   +              - ampere,mtmitchell-bmc
>                  - aspeed,ast2600-evb
>                  - aspeed,ast2600-evb-a1
> 
> But, should we correct the below as well? ie: to move 
> "ampere,mtjade-bmc" to before "aspeed,ast2500-evb" ?
> 
Oops, indeed, I added aspeed in wrong place. I'll correct it in my tree.

Best regards,
Krzysztof
