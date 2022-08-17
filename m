Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32C62597024
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 15:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239557AbiHQNqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 09:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbiHQNqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 09:46:21 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7F495697
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 06:46:15 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id c28so15017611lfh.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 06:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=gQ9ZdHAonv1+cNCneY42f+VkcN8uTabWejW5IY05OD4=;
        b=KTjTHibusJ3Q5B6hEEPhteJ85Ffv8KvOEn3uUw/xQVRdL6Zo1CkYrEOL7ZAC1Tw1Ou
         uU5RufF2Tdvu2+nmf2C0KTfR7A2Igxvxw8T/eUeKx52INZGiEKRka7WEIwxCR2CZ+ZSJ
         e/vQmpHliCd7Cqy1Zy50sfUCIIZLixaPjkqOK/7InUSjMIC23bUaIt6Mck1XWtEetmMJ
         xqdxUZuSJKJ3/glf0Mj/ekPD8QxDCZ/UHom2kzqDSWgHHwSlRbzFsqaKV29BqFV401mW
         L7PQ51pKmSprJ5+3vGlxrNT1VYAzmVYMxSR7p0A1IxGR+jY3AsB4EmseuYJKfMqe6EzN
         W1KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=gQ9ZdHAonv1+cNCneY42f+VkcN8uTabWejW5IY05OD4=;
        b=UcaV1PAbxWTvyui/dqM9hxHCqwpUKKBRkXtj/xbxCdF+3LVtrDySHFjfqofiN7V1GB
         2+4+7CC4cPxC5K6iQbBvtrBtp0cSBb1yR+RYO2+a1OUKCJoTRq9XJX9wnR9QLfMO9RV+
         vi3926IY/osnAQuvtopyWNAvVK8iEqTFwz1gEWtUpbiMtk+9Q/aZ/41EgCpG8OuSJTHz
         LIJlDp3PcSnvEQNKCfVN9BbfZw3HEltJ6yBGV0MzpYtsa360um5ezxIV8JWyIIQj/m3i
         fAZjbOtKukzNp2HeSKJI0kUNby32lhTwPHdqBFo844vCbUyAEqRC9uICV42KUDH09OqQ
         k9Zw==
X-Gm-Message-State: ACgBeo1uGdeDaq+LEBLf7daCCd+GohjLd4T6eS6I8W1nC3gmuyiR2lQM
        Dk9C4hUU9sQGbGfJ3R9DWOv9zg==
X-Google-Smtp-Source: AA6agR4vOLQVaDpNaTlrgQpr6MQJs6T1zj+svIXXP/Rtynk4ey8sYo2c1ptChOUd++TTtrnFyrV1cw==
X-Received: by 2002:a19:6b0b:0:b0:48a:e7de:d34c with SMTP id d11-20020a196b0b000000b0048ae7ded34cmr8780224lfa.454.1660743973563;
        Wed, 17 Aug 2022 06:46:13 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ae:539c:1b1c:14b7:109b:ed76? (d15l54h48cw7vbh-qr4-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1b1c:14b7:109b:ed76])
        by smtp.gmail.com with ESMTPSA id b10-20020a05651c032a00b0025d5eb5dde7sm2151655ljp.104.2022.08.17.06.46.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 06:46:13 -0700 (PDT)
Message-ID: <64913eef-8b4f-7617-578b-53ddc22bd06e@linaro.org>
Date:   Wed, 17 Aug 2022 16:46:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 1/4] regulator: dt-bindings: Add Allwinner D1 LDOs
Content-Language: en-US
To:     Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
References: <20220815043436.20170-1-samuel@sholland.org>
 <20220815043436.20170-2-samuel@sholland.org>
 <c4ec080a-b8b1-e3a9-c9d7-063e138c9bb8@linaro.org>
 <03de0f7b-9251-a5c0-91a1-5f2b5d41d8a0@sholland.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <03de0f7b-9251-a5c0-91a1-5f2b5d41d8a0@sholland.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/08/2022 11:15, Samuel Holland wrote:
>>> +    audio-codec@2030000 {
>>> +        compatible = "simple-mfd", "syscon";
>>
>> This cannot be on its own. Both require device specific compatible.
> 
> Again, the device-specific compatible does not exist, because the binding for
> the audio codec has not been written (and it will be quite nontrivial).
> 
> So I can:
>   1) Leave the example as-is until the audio codec binding gets written,
>      and fill in the specific compatible at that time.
>   2) Remove the example, with the reasoning that the example really
>      belongs with the MFD parent (like for the other regulator). Then
>      there will be no example until the audio codec binding is written.
>   3) Drop the analog LDOs from this series entirely, and some parts
>      of the SoC (like thermal monitoring) cannot be added to the DTSI
>      until the audio codec binding is written.
> 
> What do you think?
> 
> The same question applies for the D1 SoC DTSI, where I use this same construct.
> 
> (And technically this does validate with the current schema.)

BTW, it validates only because of limitation in DT schema. Such
combination is not allowed and I wonder if we can make the schema
stricter...

Best regards,
Krzysztof
