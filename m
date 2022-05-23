Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4915310EA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235288AbiEWMO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 08:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235263AbiEWMOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 08:14:53 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8036415A1F
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 05:14:51 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id h8so16952705ljb.6
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 05:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=uX9d5hIWoXzMD0tjqgO7/m3MNoobSBwjH437XKo6A0w=;
        b=o60utXph4rkX5O0ZrcbCs4JRtaq8ztJgO8ytaInX0yvoONM4YBM9Ol9CHiJ+98yRVT
         Qq8u+qXfJ+eNKNnJF8zR9EMYLHAT/uOzyPJdTBU5BhXsG7J+C1qoQ3lH0se8ZTVNZ540
         iHdmyk/p/vg7erY6rGwMM1+wiFOnuPwQL7lCBhnIAvPmAs5S4V9rTBO5b7Ya8ZSjptG8
         EZ08YxWL8ZaukbpHcSNHPo2HKmG0GWx+ptrrxy8GiEsrOzxMoEMppiJnNqy4QHRUW4Ui
         iUBQ3ZrmKInoIo8xGSrSAd/BLcoxVufuo/IUS7VBPU6wB2WI7/7/sPjgon7Pqp50TneF
         yqpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uX9d5hIWoXzMD0tjqgO7/m3MNoobSBwjH437XKo6A0w=;
        b=vQBZrrMf4Q3VBZspF2Y8uA8OA0OCkyxgJu4EH/EOsPMw80BOpD009JRBXt6gCUpu3S
         2YwgX8ZW+kQ5eEYqCUj3Xq018VeuB6iBWInJxfvRuah+ENMX00pqPdJHlwMacOTT06XD
         CmGQJUZo5DMezXRVVfO5yNhgH1NYmNVzvruKUB5dgdY6wWIt4mu1b/aS53X6LxYaLMqD
         lpcJNfwFOlvc4Ia/7dIiRX7wdAcRsK+iZMGFpO58G1J76D9sJsnCRqKyEcOHSq57Zikj
         t+N/k50moMz4UMcveees/jtC1sCHUF4ppB+tG/puqC51OE0X+O2GAWapZbPL5rgvi7Pp
         a1Ug==
X-Gm-Message-State: AOAM533GcVXHz0XUYUZieQ53/fWQ+QP9cqArid7h2y9oClWjH1cO2cRL
        BBKJ9vbHChM1fKXl72N0zW3F3w==
X-Google-Smtp-Source: ABdhPJxsbVHsUzd6F21SGSmpQtO4Ozxicb4OdX/lzmoOgx8PVHYlhfr2FBaN5SbxOkD/A5NnPDRGEA==
X-Received: by 2002:a2e:9887:0:b0:253:da3e:6d10 with SMTP id b7-20020a2e9887000000b00253da3e6d10mr10615727ljj.32.1653308089648;
        Mon, 23 May 2022 05:14:49 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id k8-20020a2e92c8000000b0024f3d1daeccsm1790464ljh.84.2022.05.23.05.14.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 05:14:49 -0700 (PDT)
Message-ID: <49a52870-9aab-c4bd-2077-66732f42bbba@linaro.org>
Date:   Mon, 23 May 2022 14:14:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Removal of qcom,board-id and qcom,msm-id
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     agross@kernel.org, arnd@arndb.de, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, olof@lixom.net, robh@kernel.org,
        sboyd@kernel.org
References: <a3c932d1-a102-ce18-deea-18cbbd05ecab@linaro.org>
 <20220522195138.35943-1-konrad.dybcio@somainline.org>
 <53d5999b-88ee-24db-fd08-ff9406e2b7b7@linaro.org>
 <02ab0276-b078-fe66-8596-fcec4378722b@somainline.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <02ab0276-b078-fe66-8596-fcec4378722b@somainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/05/2022 14:02, Konrad Dybcio wrote:
> 
> On 23/05/2022 09:21, Krzysztof Kozlowski wrote:
>> On 22/05/2022 21:51, Konrad Dybcio wrote:
>>> Hi,
>>>
>>> removing these properties will not bring almost any benefit (other than making
>>> some checks happy any saving some <200 LoC) and will make the lives of almost
>>> all people doing independent development for linux-on-msm harder. There are
>>> almost unironically like 3 people outside Linaro and QUIC who have
>>> non-vendor-fused development boards AND the sources to rebuild the
>>> bootloader on their own. Making it harder to boot is only going to
>>> discourage people from developing on these devices, which is already not
>>> that pleasant, especially with newer platforms where you have to fight with
>>> the oh-so-bright ideas of Android boot chain..
>>>
>>> This only concerns devices released before sm8350, as the new ones will not
>>> even boot with these properties present (or at least SONY Sagami, but I
>>> doubt it's an isolated case), so other than completing support for older
>>> devices, it won't be an issue going forward, anyway. But there are give
>>> or take 50 locked down devices in mainline right now, and many more waiting
>>> to be upstreamed in various downstream close-to-mainline trees that should
>>> not be disregarded just because Qualcomm is far from the best at making
>>> their BSP software stack clean.
>> I actually wonder why do you need these properties for community work on
>> such boards? You ship kernel with one concatenated DTB and the
>> bootloader does not need the board-id/msm-id fields, doesn't it?
> 
> If that were the case, I would have never complained about this! It's 
> the bootloader itself that needs it, you can see it in a "Best match 
> [blah blah] 258/0x1000/...." log line, where it walks through the 
> appended (or otherwise compiled into the boot.img) DTBs and looks for 
> matches for the burnt-in msm-, board- and (on newer-older platforms) 
> pmic-id. If it cannot find these, it refuses to boot with an Android 
> Verified Boot red state and you get a not-so-nice "Your device has been 
> unlocked and the boot image is not working" or something like this on 
> your screen.
> 
> 
>>
>> Not mentioning that in the past bootloader was actually not using these
>> properties at all, because it was the dtbTool who was parsing them.
> 
> Not sure when that was the case, maybe with very old arm32 bootloaders 
> in the times before I did development on Qualcomm devices.
> 
> 
>>   So
>> in any case either your device works fine without these properties or
>> you have to use dtbTool, right?
> 
> To the best of my idea, wrong :( Unless the vendor modified the LK/XBL 
> code on their own, it looks for a "best match" (but if it's not a 
> precise match, it won't even bother trying to boot, just fyi..), meaning 
> it tries to go through a list of SoC ID and revision pairs (msm-id), 
> board IDs (board-id) and PMIC id+rev pairs (pmic-id) and if no match is 
> found, it doesn't even exit the bootloader and says something like "no 
> dtbs found".

This would mean that dtbTool as described in the actual patch [1] is not
used and bootloader ignores the table. If that's the case, the commit
and requirement of such complex board-foundry-pmic-compatibles should be
dropped. So I am getting now to what Dmitry said...

[1]
https://lore.kernel.org/all/1448062280-15406-2-git-send-email-sboyd@codeaurora.org/


Best regards,
Krzysztof
