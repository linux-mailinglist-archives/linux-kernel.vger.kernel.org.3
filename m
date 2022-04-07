Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C844F7B0A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 11:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243512AbiDGJLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 05:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233149AbiDGJLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 05:11:02 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4B57D03A
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 02:08:59 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id b15so5641356edn.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 02:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:references:in-reply-to:content-transfer-encoding;
        bh=km7YDgXOOV7rG3EqjZY4Ow0H9hY7KhPPBDDm+Yl9d7A=;
        b=yP+Vxa0X7YrFMxjKewfSkiVXJGff+bC22DJPwyck9DWPZJoyBLiER4bnvKxXorNOQo
         JTLj1jzptS3VsIdzOioRfmddhZoOL7X78t+0X8hWGxrtTSLmdmehLb1bRYyy8VOWiFXY
         jpFdkhTyFDoSMS1Qf4OZnY7yAUEFYwxbN/KQMrZN2CMDse+5elHhs9BzubU/xKCKXHeB
         jKKLCguNvW8N75I23MZXQ/112QtXC5B/9rd2UrpEnAzN9ZPrQhuly9ZPkn07xM8/7wr6
         HMLzdyT7mtH9OWoLW0s4VjjObdHXgbB8tiPwjNAGKc3fO0GAwVliTu41VBTxoX5dTM1P
         pIow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:references:in-reply-to
         :content-transfer-encoding;
        bh=km7YDgXOOV7rG3EqjZY4Ow0H9hY7KhPPBDDm+Yl9d7A=;
        b=cKuW4Iw4KDaSr9a155FTlMPIAru6KT7aADaIbpMO5Ls0ouZT+dsKRBa7SXf2UrT4pi
         yYSylDM5yyOn41L4EXAZZiciffC+4h6wVBuE4cYgo5Mbj/I41nayrbIt/gScS5cI88Yf
         b2nmm34WLE5jBy2nrUn/WRoR/xoJXsm/xXioyNRGv+yAtOW7Pj84AEbGAHcQbou8akxa
         lSR7kBwEbf85HElptV/VTJbkXt9pEjB9nGPHriMNnRvMjQmA3oJ83IlTimhym1G6bUKK
         U9/Aj5eWVjPeKarlbdBiAXFzAOFX1Tz6ktuBH4y186ZPdIyugdWxEz8fYJV/zSCsnBvU
         0j/A==
X-Gm-Message-State: AOAM530pESmnol6fK4f1c/sQ2H/BfmQkqRYWt9AOOjC8HoZ91gCauh8r
        XgJaSbNOH8IcFSYDTlIPETpvYg==
X-Google-Smtp-Source: ABdhPJxw7gv8EPUrw7/sGUZum9MmwKlh/qJD/2jHUPwjU1bAC7Q/FnhhIL0IGsswPYlisJmZWmtOMg==
X-Received: by 2002:a05:6402:2029:b0:41c:e234:a545 with SMTP id ay9-20020a056402202900b0041ce234a545mr13217304edb.132.1649322537928;
        Thu, 07 Apr 2022 02:08:57 -0700 (PDT)
Received: from [192.168.0.185] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id b12-20020a056402278c00b004195a50759fsm8899923ede.84.2022.04.07.02.08.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 02:08:57 -0700 (PDT)
Message-ID: <a184142f-d61a-0e70-0b5b-c77ba8c57181@linaro.org>
Date:   Thu, 7 Apr 2022 11:08:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] dt-bindings: soc: ti: wkup_m3_ipc: convert bindings to
 json-schema
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Drew Fustini <dfustini@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Dave Gerlach <d-gerlach@ti.com>, Suman Anna <s-anna@ti.com>,
        Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220407032208.2249485-1-dfustini@baylibre.com>
 <e9e3a689-fafd-62e8-9e17-1f15445228cd@linaro.org>
In-Reply-To: <e9e3a689-fafd-62e8-9e17-1f15445228cd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/2022 09:55, Krzysztof Kozlowski wrote:

(...)

>> +  - |
>> +    soc {
>> +        #address-cells = <1>;
>> +        #size-cells = <1>;
>> +
>> +        mailbox: mailbox {
>> +            #mbox-cells = <1>;
>> +        };
> 
> I propose to skip the mailbox node, it's trivial and obvious from
> mailbox providers/consumers documentation.

That was a wrong advice, you indeed need it to describe the phandle, as
Rob suggested.

Best regards,
Krzysztof
