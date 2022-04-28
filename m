Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3570512B4F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 08:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243543AbiD1GSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 02:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236458AbiD1GSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 02:18:06 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008B321256
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 23:14:52 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id g6so7485618ejw.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 23:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=+ZIXV2LLVgo4LwCBTD4ugdbUMSH+dsG0f0fk8L+x54M=;
        b=TF/NWe395gOl8BHS3S78qFofPQwaFTjv32LLH0o7wH0SZ27a412ooJWNGyqlkl+vAb
         7NN+p4urCC2+joKG09ocuVBEIClJ+QO6NfKEB4YEEwyqzOBLZ/M4qhxb7QN2aH9ylWvk
         ZWAHbs8QeFpm3d91vOLg/fMSQD4GQd+jGqUbQBjkYHSp96gZ3UC8ocHkW8b6GeLPh2cQ
         Ti60WLNpSmf5AsBXhG7pHGCvFXs/LkVw37cXwv54CzyqjIIiiv4LKvVLF0wBF394wvPH
         jxZClmk67AhyrxeBZuT4GEyZJwZBPoPCAFh2d3jEABRvyotYrvjvUoL4P+8sncnvlo/a
         bY6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+ZIXV2LLVgo4LwCBTD4ugdbUMSH+dsG0f0fk8L+x54M=;
        b=nN63Y/HND97NDShuIYQ726m9s9whpH34dL/BHFxUgQqFuM9kpq/8Setvmc+ON0k/Sc
         tTl7jRACXqFEEMiQDEVV23Oa9CRwBjoyxNuwrGc7KzOM03TlIPCq3t5hSXlh/pvbjysW
         jzvwZljWi6gkclm2OdutitiIoa0sEtnRG6U6VcGmKKiy0xQHhLJtHo6kvNLfJx8EDoz7
         tJB0pEQhKW+avjiF0soNXUsHDD/wuRUu9W4hQOCsSZr63BE1oNSCmrg49QBVp/FSUhkV
         bwxaJTnGo5nKWA+tzo4pT9Y/Ag3HLbNh7q/DW0It903i/2Uvwyq3InIeoCXIhF8sUstb
         82FQ==
X-Gm-Message-State: AOAM533h4BmrZza7mxlZrEp/y/7TMD5SLsPeNPfvdsoJ0n7YkMxvtXQq
        fgGEIG7EMQfUV5DWAcz7IUHAmw==
X-Google-Smtp-Source: ABdhPJzL+j0KsDRXFj07hIztrF9YSG4t1iFa37y0+WHpiKXmj5te+vwXKDfRosj3q3WBEKgNHy1+qQ==
X-Received: by 2002:a17:907:9804:b0:6ee:f915:9c25 with SMTP id ji4-20020a170907980400b006eef9159c25mr29527027ejc.121.1651126491491;
        Wed, 27 Apr 2022 23:14:51 -0700 (PDT)
Received: from [192.168.0.159] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id z22-20020a1709063ad600b006e8867caa5dsm7782023ejd.72.2022.04.27.23.14.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 23:14:50 -0700 (PDT)
Message-ID: <8b6b92ca-bfa3-5903-57e1-3baf58e0c37b@linaro.org>
Date:   Thu, 28 Apr 2022 08:14:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] Documentation/process: use scripts/get_maintainer.pl on
 patches
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220427185645.677039-1-krzysztof.kozlowski@linaro.org>
 <0d32cc45-bf65-e279-19f5-3db078ee8cc8@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <0d32cc45-bf65-e279-19f5-3db078ee8cc8@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/04/2022 07:42, Bagas Sanjaya wrote:
> On 4/28/22 01:56, Krzysztof Kozlowski wrote:
>> diff --git a/Documentation/process/3.Early-stage.rst b/Documentation/process/3.Early-stage.rst
>> index 6bfd60d77d1a..894a920041c6 100644
>> --- a/Documentation/process/3.Early-stage.rst
>> +++ b/Documentation/process/3.Early-stage.rst
>> @@ -154,10 +154,11 @@ that the kernel developers have added a script to ease the process:
>>  This script will return the current maintainer(s) for a given file or
>>  directory when given the "-f" option.  If passed a patch on the
>>  command line, it will list the maintainers who should probably receive
>> -copies of the patch.  There are a number of options regulating how hard
>> -get_maintainer.pl will search for maintainers; please be careful about
>> -using the more aggressive options as you may end up including developers
>> -who have no real interest in the code you are modifying.
>> +copies of the patch.  This is the preferred way (unlike "-f" option) to get the
>> +list of people to Cc for your patches.  There are a number of options
>> +regulating how hard get_maintainer.pl will search for maintainers; please be
>> +careful about using the more aggressive options as you may end up including
>> +developers who have no real interest in the code you are modifying.
>>  
> 
> This raises my question: Supposed that I'm ready to send multiple-patch
> series (two or more patches in the series). How can I get maintainers list,
> given such series?

Method is the same, nothing differs. What is inaccurate in my
description above around such case?

Best regards,
Krzysztof
