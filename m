Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 066FD5A6437
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 14:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbiH3M62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 08:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiH3M6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 08:58:16 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679B0BC17
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 05:58:15 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id b5so14107098wrr.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 05:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=YGmkAZyavh+X9La7k+CFGGjIc+C3jV0M+2ia4/QWjpk=;
        b=nAszEbPHvTpl4eyJg2fuRS7ZObScYrqd1N/RhNUC43Hyeu3SMZO5iY+wvqOFUaysJx
         siq91yP79RGZRyAGXtSxRYbHENA2EZBjnR1mOUY1QjbRvpGf9fFltg2PUNK8w+viOecx
         hiMOOsVI5a4/nrqi4vJmuXhAOmdFSRay5yXiVueQ90Pob6BdW3OdkeYXrxkKZuRH/Gkh
         3IWJsU/KZOXZzR5MpVFluwpvqJQU2wu8DHSXs2PT1Lf1fHbBcywk0YDQAqTSp/Oxjnb4
         raN3nvqUR6nMgoSIzAj+b7rHtuvpT3TJTdraYkNRXrj7kxguhup/RPD1rl3YCj3KX9tw
         SgoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=YGmkAZyavh+X9La7k+CFGGjIc+C3jV0M+2ia4/QWjpk=;
        b=iJiTB3QbZUIgR0hnknUOiDiAhRaHHn9OrJTlBUX5zHX6nTQeKDXeiywGzmgx//U2rd
         /cM704VPXdFLX8V9ov3xfooVha9XusRLU2YYXtIJQXubQFzHvr6yaD+sId+ncBjaCuH4
         21Upt04UnLnL4NdSPc9UrrMZ1eX/YT9ooQUHKWtLwABOgTkLlwkXrYgm9cysLwXiHEBt
         q/RfZBZ+510bdWoxRBqzAZbllGWHL0BRHiQnW014xJo5wJci/zyakKxBBgpk6xXUOc3q
         +kzwTrB6fBZD/u5sOVsMZfhYFWIMjxXNJXoxwOgQirnGK5hFf46eYFeWZ7sYZjv90kvo
         IImw==
X-Gm-Message-State: ACgBeo0rjsvDx295jgo0oGf+Rk6LGw/kNPltF/29gxgT7TAVV6Mv04dZ
        Gv8v6DWJzkAuKhegHl+eEIUwbg==
X-Google-Smtp-Source: AA6agR51p0EDWKeeNESKGCHV+BZqCfWQ96nO9J+kb64Y+l4lI4KMbkrcUhW3hqrmrES73N832iz+dw==
X-Received: by 2002:adf:e18a:0:b0:225:8c08:2411 with SMTP id az10-20020adfe18a000000b002258c082411mr8631521wrb.548.1661864293933;
        Tue, 30 Aug 2022 05:58:13 -0700 (PDT)
Received: from [10.35.5.6] ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id q28-20020a056000137c00b002205cbc1c74sm9543475wrz.101.2022.08.30.05.58.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 05:58:13 -0700 (PDT)
Message-ID: <6b6837c1-5a2c-567b-ba64-72a1dca38807@sifive.com>
Date:   Tue, 30 Aug 2022 13:58:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.1
Subject: Re: [RESEND PATCH] dt-bindings: sifive-ccache: fix cache level for l3
 cache
Content-Language: en-GB
To:     Conor.Dooley@microchip.com, palmer@dabbelt.com,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
        greentime.hu@sifive.com, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org
References: <20220829062202.3287-1-zong.li@sifive.com>
 <20220830125133.1698781-1-ben.dooks@sifive.com>
 <b810d354-18f3-9ae0-6310-57d9e36f4f9b@microchip.com>
From:   Ben Dooks <ben.dooks@sifive.com>
In-Reply-To: <b810d354-18f3-9ae0-6310-57d9e36f4f9b@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/08/2022 13:56, Conor.Dooley@microchip.com wrote:
> On 30/08/2022 13:51, Ben Dooks wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> With newer cores such as the p550, the SiFive composable cache can be
>> a level 3 cache. Update the cache level to be one of 2 or 3.
>>
>> Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
>> ---
>>    Documentation/devicetree/bindings/riscv/sifive-ccache.yaml | 2 +-
>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/riscv/sifive-ccache.yaml b/Documentation/devicetree/bindings/riscv/sifive-ccache.yaml
>> index 1a64a5384e36..6190deb65455 100644
>> --- a/Documentation/devicetree/bindings/riscv/sifive-ccache.yaml
>> +++ b/Documentation/devicetree/bindings/riscv/sifive-ccache.yaml
>> @@ -45,7 +45,7 @@ properties:
>>        const: 64
>>
>>      cache-level:
>> -    const: 2
>> +    enum: [2, 3]
> 
> Do we want to enforce the cache level like we currently do for
> interrupts and cache-sets?

Not sure on that, for the P550 cores the ccache is going to be level3
and my colleague has said it does confuse some tooling if the level is
not set correctly.

-- 
Ben

