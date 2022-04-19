Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F38D507108
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 16:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352988AbiDSOxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 10:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353024AbiDSOxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 10:53:47 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 059D73A5FD;
        Tue, 19 Apr 2022 07:51:03 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id f5so10658265ilj.13;
        Tue, 19 Apr 2022 07:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=2/CLF6HwL0IQsaCNZtZxcU3NkwNds1QQIy0mQEierNo=;
        b=IVU18bp77G6GNO2M46k8FQ4vC23PrIiOqenVp0QBE3NQIyU5oZmqz7Wz79xyimgR1O
         HarbGV1HZn0PsQJo9loLD06pawA5m2K530CGOPPfNIHhgpZEZF8MwbKyB22RiIOevcur
         AUuN/6kUIWhmQItev/LyQQhcS4va+4k0tLOkjWJkhoh0/ACrLCbyPdYz1b3uwBrfJuVj
         N568P8hJL0mKWujn0+MmHmUZ440cwphsZbO1XYTTYOyaTQtq7THeGDg0ihHckD6ot6tR
         ZAmqbfesjffnmNkjm7w2O/PT8Co8HxHwhPIKCuX4cgeud1By9ItvofqhtIu7lk0G0fEz
         rYYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2/CLF6HwL0IQsaCNZtZxcU3NkwNds1QQIy0mQEierNo=;
        b=BpdExltw7BrCuN4YT0fVSTX18DQ4rAW5ovJ9DK0l7MUDkDdjSzmIE1sotIcKugzETj
         3LqaEi2z1SQry4tWqWEib9cKSXcx7f+zsiV5RI07Vm4FUxSon784gKuQ4J1QeRvG0K3f
         rEeKJ57C/cC8WVzl9CXN7eKCBx/ve/DVw9sWWD7MUfLu3BuhCh7Kk8GCcYCjRwAqVA4y
         aiNW+R01n8LYVuAQOkQ7U/dgIoxr4sYnDfdO/b0VFPPhEYxu1JDUKUuEdNFfB8Y4Lvfy
         4ZX/aSuLfi0ZbdDhRDypsYZCd7ga9NdXxwJkG5gc0cx3lE3qz8jBpPLOfVj+wr5EmqFF
         STxQ==
X-Gm-Message-State: AOAM530o6lkKd4YtRMQv5Jn72vtVkW6DRAfUFkGPKDKeJfQC95zWEkIi
        Kl4CpfjEoJf60nwxKOj7siU=
X-Google-Smtp-Source: ABdhPJyW3L77tWAzuH7FzU57Z0U26kp0CzYvcDUc7c4NjVWDuIlOF9zEAf31P5AKUEhQZnwi5g12lg==
X-Received: by 2002:a05:6e02:1486:b0:2cc:3ee4:f27f with SMTP id n6-20020a056e02148600b002cc3ee4f27fmr2768124ilk.67.1650379862180;
        Tue, 19 Apr 2022 07:51:02 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id r9-20020a6b6009000000b006412abddbbbsm9618307iog.24.2022.04.19.07.51.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 07:51:01 -0700 (PDT)
Message-ID: <45b90a0b-0b7f-1fd9-194c-533ade996f1d@gmail.com>
Date:   Tue, 19 Apr 2022 16:50:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] arm64: dts: mediatek: align operating-points table
 name with dtschema
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org
References: <20210820081616.83674-1-krzysztof.kozlowski@canonical.com>
 <165036314214.180327.9860190048104061653.b4-ty@linaro.org>
 <448093df-288f-3c49-270e-5d830a986b27@gmail.com>
 <83037bd9-d4f0-7116-0b7f-26f64170a5ad@linaro.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <83037bd9-d4f0-7116-0b7f-26f64170a5ad@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/04/2022 16:34, Krzysztof Kozlowski wrote:
> On 19/04/2022 16:31, Matthias Brugger wrote:
>> On 19/04/2022 12:12, Krzysztof Kozlowski wrote:
>>> On Fri, 20 Aug 2021 10:16:15 +0200, Krzysztof Kozlowski wrote:
>>>> Align the name of operating-points node to dtschema to fix warnings like:
>>>>
>>>>     arch/arm64/boot/dts/mediatek/mt8173-elm.dt.yaml:
>>>>       opp_table0: $nodename:0: 'opp_table0' does not match '^opp-table(-[a-z0-9]+)?$'
>>>>
>>>>
>>>
>>> Applied, thanks!
>>
>> Could you please provide a stable branch for this patches? So that I can pull
>> that into my branch. This will help to reduce merge conflicts later on.
> 
> Then maybe better take them directly? These patches were waiting on
> lists for long time, I resent them and pinged. I took them only because
> there seems to be little interest but we want to fix all dtbs_check
> warnings.
> 

Yes definitely. I'm just overloaded and forgot about them. Although at least on 
that thread I don't see any ping. Anway thanks for the tag, I merged it into my 
branch now, so we are good.

Regards,
Matthias

> There are three for Mediatek:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git/log/?h=for-v5.19/arm-dts64-cleanups
> 
> Best regards,
> Krzysztof
