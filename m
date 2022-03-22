Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F674E4631
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 19:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240792AbiCVSoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 14:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240800AbiCVSn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 14:43:57 -0400
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CEB19156D;
        Tue, 22 Mar 2022 11:42:27 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id c62so3296340edf.5;
        Tue, 22 Mar 2022 11:42:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jmg2q4syeLne/1r7gmtu68by9oPMiShvZ+PkjYKZz8o=;
        b=BwIUPwP1QiVpkVuGyoh0AyqrDlgpgl2az5+bo5TYfo5tDFa/IZngSvdyOSkirGty3R
         O+/v0cLlhYqt9EIGKfjNBQjb0jomyArjTTtwNdGMCPyTz0w9yLrWn2pPTUxHSPnqK+8Z
         IZESUhUTkejFhAOs6ZkpyOiWf7phPVoJQCzS0RZMs9gUIg2B2Spn/w3tIOC28Btmtwgv
         6Mpa+3CidcdBYhVMomqSqbJ+7HB40I8prWMvMkbpsy3FV/nQSZ3OvCRerthAEFCsXk1U
         Sypl4B7PahPLsPFiRPZJvDQ4vSoA47tCADhIqnGOObJJAek8ighq8t6XBi46ykWophrx
         fmog==
X-Gm-Message-State: AOAM533AWD0+N3wN1yTutNKqOBcsCQBZeaCRta4pCSVgycHu91p1kmv5
        WcZ10KAD9dAQ5TuZrijmLlA=
X-Google-Smtp-Source: ABdhPJxJuJYtbm+Py4ZRcZImQ/eCDCzzY4Ghp+eDk6BpA8azMvEnPHZDjGuRUc2og3w9kQ66OyibYg==
X-Received: by 2002:a05:6402:40d5:b0:419:496b:5ab0 with SMTP id z21-20020a05640240d500b00419496b5ab0mr9879853edb.284.1647974545888;
        Tue, 22 Mar 2022 11:42:25 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id rv11-20020a17090710cb00b006d5c0cd5e0dsm8617228ejb.82.2022.03.22.11.42.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Mar 2022 11:42:25 -0700 (PDT)
Message-ID: <81745773-bc8b-2669-3fdb-47890613f166@kernel.org>
Date:   Tue, 22 Mar 2022 19:42:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [Patch v5 3/4] dt-bindings: memory: Update reg maxitems for
 tegra186
Content-Language: en-US
To:     Ashish Mhetre <amhetre@nvidia.com>, robh+dt@kernel.org,
        thierry.reding@gmail.com, digetx@gmail.com, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org
Cc:     vdumpa@nvidia.com, Snikam@nvidia.com
References: <20220316092525.4554-1-amhetre@nvidia.com>
 <20220316092525.4554-4-amhetre@nvidia.com>
 <74db8a20-7cce-ff86-7ae4-466416443ba9@canonical.com>
 <66a3f996-ac12-9165-93c9-e1fa93b80eed@nvidia.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <66a3f996-ac12-9165-93c9-e1fa93b80eed@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/2022 19:12, Ashish Mhetre wrote:
> 
> 
> On 3/20/2022 6:12 PM, Krzysztof Kozlowski wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On 16/03/2022 10:25, Ashish Mhetre wrote:
>>>  From tegra186 onwards, memory controller support multiple channels.
>>> Reg items are updated with address and size of these channels.
>>> Tegra186 has overall 5 memory controller channels. Tegra194 and tegra234
>>> have overall 17 memory controller channels each.
>>> There is 1 reg item for memory controller stream-id registers.
>>> So update the reg maxItems to 18 in tegra186 devicetree documentation.
>>>
>>> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
>>> ---
>>>   .../nvidia,tegra186-mc.yaml                   | 20 +++++++++++++------
>>>   1 file changed, 14 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
>>> index 13c4c82fd0d3..3c4e231dc1de 100644
>>> --- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
>>> +++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
>>> @@ -34,8 +34,8 @@ properties:
>>>             - nvidia,tegra234-mc
>>>
>>>     reg:
>>> -    minItems: 1
>>> -    maxItems: 3
>>> +    minItems: 6
>>> +    maxItems: 18
>>
>> Still ABI break and now the in-kernel DTS will report dt check errors.
>>
> The dt check error is because I mistakenly updated example in EMC node
> instead of MC. I'll fix it in next version.

The existing DTS will start failing with:
nvidia,tegra186-mc.example.dtb: memory-controller@2c00000: reg: [[0,
46137344, 0, 720896]] is too short


because you require now length of 6 minimum.

> 
>> I think you ignored the comments you got about breaking ABI.
>>
> No, I took care of the ABI break in v5. I have updated details about
> how we took care of it in first patch.

Right, driver part looks ok.


Best regards,
Krzysztof
