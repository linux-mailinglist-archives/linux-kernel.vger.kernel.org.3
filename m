Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 607E5516789
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 21:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354114AbiEATpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 15:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242704AbiEATp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 15:45:29 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1468013CD6
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 12:42:03 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id p12so22282584lfs.5
        for <linux-kernel@vger.kernel.org>; Sun, 01 May 2022 12:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Sb18QTlst2GMPixG5lE6GOjj3E96mmvATu5tTksShfU=;
        b=TPihLFQQ4TWDX9nyo9eCksuPePuKQj3FzZ/C87BLTD8aIaShyo2SlgnTcXqOpZtcS+
         Dn7LNhJBtTFkm8uEQxw1I+4HIzocK/AR5JyyNhoaX4yQkIJOz2UWuUdAdTxjn2FOMO8M
         0EMZ5vxdxu54t7qriPzXmDNxxqas6rRXAMVaDCMZDQ3SLK4sM/OCsbfAMYu/8QcLk0TD
         VwB2JQdzRdqvdKGtE8yYGKNGa+KKJMVLDmMG5dGoYr2wPhr2tyuaK8sbZb8ytksO+oK2
         dAcKPBJAkWvMCyQGsIJ35FBMZ15N7dT67NfDyJm2cBwk5k/wjvZQqhKe1phZ9JMYHeWZ
         GJ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Sb18QTlst2GMPixG5lE6GOjj3E96mmvATu5tTksShfU=;
        b=1RfcqH0LpFBf8orkGLfkp2J4TTt0oV0po3tNl2GPeVKtTTtJ1h7zRg6Q6E9oadfE+6
         ddsPykEYq8XJG4aD8tGN6HaxZLwretKx7qw1IN0nI3da2JyDwPvBMf0iYnU1kJ9aV+kA
         q5FYzuZz3ZRG/QwA2tB6L/anrDyM0k5sPnSfOTlKam4Tju+nN4mhAKRE6h8eZrMEPLoo
         VCLXWnpPg6P7SgJf6LqytTG3Gdyu7nlLPo+O/L5h08WgCK6lR+vur+InLZrRgpEHQA3v
         Mm2a33fpZRDOctJ08j3V5kM+Hk7HhZ1E45qGts7+jVhQWJy5ZPzgbZQRZ7TZgZlUVLUh
         n7gQ==
X-Gm-Message-State: AOAM532KCpP+ySmm/w2PKRnhMsoLro5cB5OW8bnsQ9Z80e58an3YQXUB
        +CX5nHepwG5aoQxLqsmckB2dCw==
X-Google-Smtp-Source: ABdhPJytmnEVlN3dum4EEXcube6P1OlhJMzZ/zB9pTJSGUqHDLak5XL2jo+QmoYS/dUC1eYNua8nsw==
X-Received: by 2002:a05:6512:1085:b0:472:1013:aac7 with SMTP id j5-20020a056512108500b004721013aac7mr7136469lfg.463.1651434121431;
        Sun, 01 May 2022 12:42:01 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id z1-20020a2eb521000000b0024f3d1dae97sm869668ljm.31.2022.05.01.12.42.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 May 2022 12:42:00 -0700 (PDT)
Message-ID: <1c66890b-6736-61ef-7d16-619f90ced4a0@linaro.org>
Date:   Sun, 1 May 2022 22:41:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 0/2] spmi: pmic-arb: Add support for PMIC v7
Content-Language: en-GB
To:     Vinod Koul <vkoul@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        David Collins <quic_collinsd@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        David Dai <daidavid1@codeaurora.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220201134108.2677578-1-vkoul@kernel.org>
 <YhUVAwtfjuIdKrRQ@matsya>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <YhUVAwtfjuIdKrRQ@matsya>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/02/2022 19:53, Vinod Koul wrote:
> On 01-02-22, 19:11, Vinod Koul wrote:
>> Hello,
>>
>> The is version 3 of support for PMIC v7. I have added a new property
>> qcom,bus-id for supporting v7 and then add driver changes for v7
>>
>> This depends on yaml conversion patch:
>> https://lore.kernel.org/linux-arm-msm/20211227170151.73116-1-david@ixit.cz/
> 
> Any feedback on this...

Another gracious reminder about these patches. At this moment this is 
one of the important pieces lacking for the full SM8450 support in the 
upstream kernel.

> 
>>
>> Changes since v2:
>>   - Drop yaml conversion patch
>>   - Fix author for spmi patch
>> Changes since v1:
>>   - Add yaml conversion patch and new binding
>>   - fix driver bug report by Jonathan
>>
>> David Collins (1):
>>    spmi: pmic-arb: Add support for PMIC v7
>>
>> Vinod Koul (1):
>>    dt-bindings: spmi: Add qcom,bus-id
>>
>>   .../bindings/spmi/qcom,spmi-pmic-arb.yaml     |  11 +
>>   drivers/spmi/spmi-pmic-arb.c                  | 233 ++++++++++++++++--
>>   2 files changed, 225 insertions(+), 19 deletions(-)
>>
>> -- 
>> 2.31.1
> 


-- 
With best wishes
Dmitry
