Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6994E22C5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 10:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345569AbiCUJB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 05:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345505AbiCUJBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 05:01:22 -0400
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BAA74625;
        Mon, 21 Mar 2022 01:59:56 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id r22so8342543ejs.11;
        Mon, 21 Mar 2022 01:59:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:content-language:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=KRRTaiowhTFiSU/AwzcdwKwVkTXFIC8zPamc05kYi08=;
        b=FVwI7360URwLrqtUQ9bcGhyIEfVpMcicRQUdh/nReECGeZhIHQ+nXkLOsHl9z6IZ+t
         LiIaHvU38VJIhHnE/GDY+ZWe82dvWWCrXOrI23BLDUZzVLFhTHROvf1qthdKow239/UY
         ilFhmDxzBB0J0ZcDGolWi7Zna4jP/8DPd9/3sxDbSALsXhb09BL/JWaeMxAhiwAJ+gZr
         QwvOKWZTMl60YZ9YbMI0NhWpymElszT9PbvYQ5aVI4+3oYPjsAww1TjaKo2XqGdllB4j
         DSigSgG8K0EtT27Xeyb7qSKfJhaOSZC2HRWR9sGf3q9V//DD0BC+u0O0HtrNYyjnmrd/
         W7UA==
X-Gm-Message-State: AOAM532u22hYSOXx0o/QbxmZXs4dghCyAToQ95/d7z59ATGwj8o9I9w8
        nreI0Qdji+QIsWo3o02UU4w=
X-Google-Smtp-Source: ABdhPJzQDdtrXwr62oHXBR+r3Zxj9WS5mOJMQjOnMzrvDrnJKWIRehXBIFg5pA2QHkUbl4Kmjav/qg==
X-Received: by 2002:a17:907:1628:b0:6d0:ae1c:251b with SMTP id hb40-20020a170907162800b006d0ae1c251bmr19791393ejc.393.1647853194551;
        Mon, 21 Mar 2022 01:59:54 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id p3-20020a1709060e8300b006d0e8ada804sm6506135ejf.127.2022.03.21.01.59.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 01:59:53 -0700 (PDT)
Message-ID: <21044180-faeb-a590-f195-dc2dc5257e05@kernel.org>
Date:   Mon, 21 Mar 2022 09:59:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v4 1/2] dt-binding: mmc: Add mmc yaml file for Sunplus
 SP7021
Content-Language: en-US
To:     =?UTF-8?B?VG9ueSBIdWFuZyDpu4Pmh7fljpo=?= <tony.huang@sunplus.com>,
        Tony Huang <tonyhuang.sunplus@gmail.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "lhjeff911@gmail.com" <lhjeff911@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>
Cc:     =?UTF-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>
References: <cover.1647652688.git.tonyhuang.sunplus@gmail.com>
 <27dba330ec0c1cd7edbcec53083f78169713a42e.1647652688.git.tonyhuang.sunplus@gmail.com>
 <c78aa9fa-8001-2c48-7a25-1f44f9952c9b@kernel.org>
 <cab5bdafed86451a99cd59da3b1c5a38@sphcmbx02.sunplus.com.tw>
In-Reply-To: <cab5bdafed86451a99cd59da3b1c5a38@sphcmbx02.sunplus.com.tw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On 21/03/2022 03:35, Tony Huang 黃懷厚 wrote:
> Dear Krzysztof:
> 
>>> +++ b/Documentation/devicetree/bindings/mmc/sunplus,mmc.yaml
>>> @@ -0,0 +1,79 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) # Copyright
>>> +(C) Sunplus Ltd. Co. 2021 %YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/mmc/sunplus,mmc.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: sunplus MMC controller
>>
>> s/sunplus/Sunplus/
>>
> 
> Below is my modification:
> title: Sunplus MMC Controller
> 
>>> +
>>> +allOf:
>>> +  - $ref: "mmc-controller.yaml"
>>
>> allOf below maintainers,
>>
> 
> I will modify it.
> 
>>> +
>>> +maintainers:
>>> +  - Tony Huang <tonyhuang.sunplus@gmail.com>
>>> +  - Li-hao Kuo <lhjeff911@gmail.com>
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - sunplus,mmc-v1
>>> +      - sunplus,mmc-v2
>>
>> How did this happen? Versions of blocks are usually discouraged, unless you
>> have clear specification,. The previous discussion did not end with "add v1 and
>> v2".
>>
>> Do you have clear documentation/specification of these blocks? If no, please
>> use SoC compatibles.
>>
> 
> v1: support SDIO 2.0							
> v2: support eMMC 4.41		

That's spec is not enough. You need to provide detailed specification of
each of them. See for example versioned blocks of Synopsys DeisgnWare
(e.g. eMMC/SDHCI).

					
> The register base address and offset address of emmc and sd card are different.							
> eMMC and sdcard are individual hardware settings							
> We need version to distinguish different speeds	

That's not the answer. How did it happen that you have now versions and
before there were SoC compatibles? No one pointed to this and you did
not mention it in description of changes.

Best regards,
Krzysztof
