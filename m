Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E474E58D36C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 07:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235464AbiHIF7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 01:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235453AbiHIF6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 01:58:55 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECCE51D316
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 22:58:53 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id o2so8292530lfb.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 22:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ZJBG39fDlqpaA1Zn84O39JgZL/7c6kJ0cMrFhlEKwFI=;
        b=cF6DYtSQF0stJ1CklN9S6lnCCiKTvVh4l582v8zver+q5dkthBM2hDHFtqqgD3vpzv
         VyEwIdYW9dFG+9eeHT5hzJXRCrBYr3v5e2c9a0+cXy2rG2ka9vgMgULDh9qqCg6dN8R2
         vxfc41hPt2SkciLqQSsQjVKjg/dOTmcY0sfiRcJnGS8m++N3+ZjVZcOaof7Eid5qlopc
         wFWYE2SNNvZkr3lNbHQIRcXnl7if5ziUXzhxctpa0yFcXZaEcvbc9Jq34vSiFPRcACmM
         lASoM0i3qNBLOirpH47TuLVvU1gibZSdYdJuktGaJNi01R89TjrataCup3qdwaO4gkLf
         6i6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZJBG39fDlqpaA1Zn84O39JgZL/7c6kJ0cMrFhlEKwFI=;
        b=Di/wzvjIy82/MjXiZzEsLuWCpUf4Se/5/gDS21AqM+wOzUzqtut83x/fid+EDqc+9q
         3EAybvepPSi+WeoCigutezNI/GKf+TmtrB9J9IOwpTdE74I99rZpkFn5zI+Y73O9y1cN
         0JdN63TcoGQUrLK0ldTpWgRoVRdwn/aU9BSJEI79iaCfNj+i63oZ6/4SDhCSsOLg1gbl
         cpi87oiutIB3SOlP8yABAilYPLHXyfzjMkDhZamStM/Yr2YjjfiRjmntxuHw0hWcEdK2
         WAmzqTd2bW3czbOn9Y9ONmXadMIPt306WmQA2s/AHCK/i9hbJrNJAIaqxAovZMqfPNLj
         bNJg==
X-Gm-Message-State: ACgBeo0rwNu7N6Cyzh4V2P0T29Iqdufv7Nf4VtKa1oxfZcVB4GKNVnCe
        PEqRwh/S1SzE46kW29TCJ4uArA==
X-Google-Smtp-Source: AA6agR7Y0wTdjv8S/L+wC/7ttd0yMMGYE/ktj9TQq6IRkdGMV2hIRNr5NbmqQ4cTi1fq6XauXxa44g==
X-Received: by 2002:ac2:5f70:0:b0:48b:ca3:14d2 with SMTP id c16-20020ac25f70000000b0048b0ca314d2mr7189598lfc.41.1660024732351;
        Mon, 08 Aug 2022 22:58:52 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id t7-20020a05651c204700b0025e5a65afbbsm1550472ljo.120.2022.08.08.22.58.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 22:58:51 -0700 (PDT)
Message-ID: <20a349c9-a479-ad5b-fe33-4758a773972e@linaro.org>
Date:   Tue, 9 Aug 2022 08:58:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] dt-bindings: marvell: Update Armada 37xx platform
 bindings
Content-Language: en-US
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220713200123.22612-1-pali@kernel.org>
 <20220808202352.iimhb2q6yawi35y6@pali>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220808202352.iimhb2q6yawi35y6@pali>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/2022 23:23, Pali Rohár wrote:
> PING?
> 
> On Wednesday 13 July 2022 22:01:23 Pali Rohár wrote:
>> Distinguish between Armada 3700 family, Armada 3710 SoC and Armada 3720 SoC.
>> Armada 3720 DB is name of the board with Armada 3720 SoC, so correctly
>> indicate SoC in example.
>>
>> Signed-off-by: Pali Rohár <pali@kernel.org>
>> ---
>>  .../devicetree/bindings/arm/marvell/armada-37xx.txt        | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt b/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt
>> index f6d6642d81c0..d2ca008de266 100644
>> --- a/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt
>> +++ b/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt
>> @@ -4,6 +4,11 @@ Marvell Armada 37xx Platforms Device Tree Bindings
>>  Boards using a SoC of the Marvell Armada 37xx family must carry the
>>  following root node property:
>>  
>> + - compatible: must contain "marvell,armada3700"
>> +
>> +In addition, boards using the Marvell Armada 3710 SoC shall have the
>> +following property before the previous one:
>> +

The change is an ABI break, which looks reasonable, but still platform
maintainer should comment on it. Especially on the aspect why the
marvell,armada3710 fallback was chosen at the first place.

Unfortunately none of Marvel folks were CCed here, so you will need to
resend it. Otherwise no one will apply it, regardless of our ack.

Best regards,
Krzysztof
