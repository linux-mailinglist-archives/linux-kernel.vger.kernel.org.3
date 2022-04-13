Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 007024FF76A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 15:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233607AbiDMNMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 09:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232476AbiDMNMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 09:12:02 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7433636B49;
        Wed, 13 Apr 2022 06:09:40 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id z6-20020a17090a398600b001cb9fca3210so2136356pjb.1;
        Wed, 13 Apr 2022 06:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=OmdGyzNAeRxm3nkDHt1WCAV+MzEwG75Y0ksewbX+MF4=;
        b=PAOM8WIfUZW45BC2wg57HYBsBtUv0BVv3ho9de5zzfBGpQcV6dc+dv8zglA2PNG0TM
         5Rq3N98WLNH/UgggAEoq11zI1cWyX9OGI1tINPc0Lz5+EYhkXmpDvfYozaT+65d/ZZhp
         NtWg/2ngoAva0x1K3o0GAkZxlVMWlzAPalDK6JsjyE5vzvzz/VNVoQaWE37Js6wLpwXX
         657YJGsQj8kRKNyDHLuQCl86qjMX+P3TwoS+CVqqlPOUytcql1pDJnkuNyJKWaG/FEZC
         onwHaBuMHTSiur9x7RRrMP1mJlD4cQjN6V7FhF73pmPl9msEMnnWn9yAYsOMt77zLeyi
         fIUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=OmdGyzNAeRxm3nkDHt1WCAV+MzEwG75Y0ksewbX+MF4=;
        b=iQHQ+nhQODh2lObSxsdZRCwkqj9vDB3jofBcgYHhq+s2diTZrDnYVMbDzX70s7W5eN
         eJN6PFuHYeehQ6hLZrP5b92tSEaE9P1pc/rcnj1UHVKBScnTglxyJ/M5ENh2YINaWkdY
         S01yE4eLRJLextYXCzp9bmvB9p557gh8pn4JikyQkXCAIknDGON5ry0VcbwZSChGszfA
         d2VUpjnKzZG6KKIxA2WqbmoezffbmPiAmCa11uVw/U4hHPt5hvniTIppsk1xj2o5Ong3
         ZQ9TJ0oublsKSkBql48tnnp7Zn9+08HPMEkj+79ercEclj5VN5smL3GFqS7VZoPssZ6I
         k7+g==
X-Gm-Message-State: AOAM533p7bluuHIUNKOyoNe6cnvZYU4wnteH3QZglWkGJ9GcHHqotr1k
        TALAWYWWo9vh2zxEVeSGzC4=
X-Google-Smtp-Source: ABdhPJxZ3lc5i6nvGo31seZiu+YtpLNfRWuJ6SkCtAfWac6phK2piMZLcrwDr4ywT/xF+5hk0GwYOg==
X-Received: by 2002:a17:90a:4fa6:b0:1cb:1b77:c931 with SMTP id q35-20020a17090a4fa600b001cb1b77c931mr10849472pjh.63.1649855379956;
        Wed, 13 Apr 2022 06:09:39 -0700 (PDT)
Received: from ?IPV6:240b:11:ea00:8f10:1cbd:f3fd:b9f6:da2b? ([240b:11:ea00:8f10:1cbd:f3fd:b9f6:da2b])
        by smtp.gmail.com with ESMTPSA id w7-20020a63a747000000b003991d7d3728sm6445338pgo.74.2022.04.13.06.09.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 06:09:39 -0700 (PDT)
Message-ID: <52225285-3b64-f709-81ff-0c26a9b13c02@gmail.com>
Date:   Wed, 13 Apr 2022 22:09:32 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
From:   SHIMAMOTO Takayoshi <takayoshi.shimamoto.360@gmail.com>
Subject: Re: [PATCH] ARM: dts: BCM5301X: Add DT for Buffalo WZR-1166DHP2
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        bcm-kernel-feedback-list@broadcom.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220412154432.12124-1-takayoshi.shimamoto.360@gmail.com>
 <ab529968-7dc5-f4c9-5ce4-5dc95b64838f@gmail.com>
Content-Language: en-US
In-Reply-To: <ab529968-7dc5-f4c9-5ce4-5dc95b64838f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Thank you for the replies.

On 2022/04/13 2:49, Rafał Miłecki wrote:
>>   - 4x 10/100M ethernet switch
> 
> Isn't that 10/100/1000?

You are right.
It supports 10/100/1000Mbps.

>> +    model = "Buffalo WZR-1166DHP2 (BCM4708)";
> 
> We stopped adding SoC name to the "model" value, please drop it.

Understood.

I will fix it as follows
model = "Buffalo WZR-1166DHP2";

>> +
>> +        wireless1 {
>> +            label = "bcm53xx:amber:wireless";
>> +            gpios = <&hc595 7 GPIO_ACTIVE_HIGH>;
>> +        };
>> +    };
> 
> I'm wondering if all new DTS files should use "function" and "color"
> instead of "label". That's preferred solution and I guess it's good idea
> to use it for new code.

Understood.

I will rewrite it with "function" and "color."

I will post the patch again after testing.

Best regards
