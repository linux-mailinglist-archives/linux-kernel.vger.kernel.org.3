Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C314599C96
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 15:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349062AbiHSNIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 09:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349002AbiHSNIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 09:08:07 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C9BBBA6F
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 06:08:05 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id x19so6045551lfq.7
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 06:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=DxUbL1u2TvCgqbMMq8b5Q8Jcv4hpOmVj7LVtiRDhqBM=;
        b=XFHS0xP6pzd1hzxev3TOYgtvPI55W/itopzKm0dvSDGy+6a7OvvL6KrvnD6lCEFa9H
         EQt8Cdm+9hmcb46qvWyULanaCBJmNbQBG2NgkC4SOCQ0lX+0q90G6hTbKc7BMhjsMvHV
         kw1AFxlZhDgAaOw8MsMn39uZoBagGabvZlY1HK0zpLDdo4U1JuUgA8nqPx3Pso45FtgZ
         IfQWiSi+k3z8Aqj81hf6hMtB15CYd0yZizfpL+zzVvgidbmKtRcDiNZCAtX1SoPQtD1u
         0evlGBqtt31yQ6UZU6jxrBNRPUXUmE/R2sNR7CWermmkhToxaTZrmHfgClMwYb+SYOT0
         dFrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=DxUbL1u2TvCgqbMMq8b5Q8Jcv4hpOmVj7LVtiRDhqBM=;
        b=DX6UrPeLuM/qsEtPrtXgCGCCsLNcLPzstHmB/eRInIp9XoEu6oOTR29/mHH7R/PAr+
         XOMOcL1wwlNTJYY+WShWXN9NlZvfBKIaCm47ipiHWvoNWd0r1xKwECeGXR1l5TzhTAaA
         SzDEvgnRzVeCCrNPJxnMvflcr4qp8yxwHQpbeWZAIVFFyYphs3gAN1SA40e2kPewYy7H
         P1wuaCsTRAfEzuOOzvGCJYuvtd53GiJJrbflwja1RQ+r4uLfs1g1Rn0uJE3Ew8m1fV2i
         wh1kiFEad99lhHX6UatwPAb7dsXADH4vsjn0AzO6/286y72awVhTn1k2NlIK2HRi22yJ
         mxhQ==
X-Gm-Message-State: ACgBeo2+VVzsH4JLfZZc9s+TZ0cjU10n0FcqVuKRsJ/zP5NMR7cV2Ne3
        k88dAexE2iJEdXwIB+6AEcYOAg==
X-Google-Smtp-Source: AA6agR7f+iFFzmMMAkNIIujsBnwTB5naNjGrtk1S4+hnAkCY2l6GkulULJahswJWGF1zJGKzS718dg==
X-Received: by 2002:a05:6512:2398:b0:48d:4ec:11c4 with SMTP id c24-20020a056512239800b0048d04ec11c4mr2353881lfv.583.1660914483914;
        Fri, 19 Aug 2022 06:08:03 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ac:e5a8:ef73:73ed:75b3:8ed5? (d1xw6v77xrs23np8r6z-4.rev.dnainternet.fi. [2001:14bb:ac:e5a8:ef73:73ed:75b3:8ed5])
        by smtp.gmail.com with ESMTPSA id c4-20020a056512324400b0048137a6486bsm632547lfr.228.2022.08.19.06.08.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Aug 2022 06:08:03 -0700 (PDT)
Message-ID: <8472463e-d99a-d0f6-9551-45a79a15f567@linaro.org>
Date:   Fri, 19 Aug 2022 16:08:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 1/4] dt-bindings: sound: Add Apple MCA I2S transceiver
Content-Language: en-US
To:     =?UTF-8?Q?Martin_Povi=c5=a1er?= <povik+lin@cutebit.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>, asahi@lists.linux.dev,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220819125430.4920-1-povik+lin@cutebit.org>
 <20220819125430.4920-2-povik+lin@cutebit.org>
 <AE646B68-CA14-483C-A1AB-30358560DAAD@cutebit.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <AE646B68-CA14-483C-A1AB-30358560DAAD@cutebit.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/08/2022 15:58, Martin Povišer wrote:
> 
>> On 19. 8. 2022, at 14:54, Martin Povišer <povik+lin@cutebit.org> wrote:
>>
>> Add binding schema for MCA I2S transceiver found on Apple M1 and other
>> chips.
>>
>> Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
>> ---
>> .../devicetree/bindings/sound/apple,mca.yaml  | 131 ++++++++++++++++++
>> 1 file changed, 131 insertions(+)
>> create mode 100644 Documentation/devicetree/bindings/sound/apple,mca.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/sound/apple,mca.yaml b/Documentation/devicetree/bindings/sound/apple,mca.yaml
>> new file mode 100644
>> index 000000000000..7b4f348c2be3
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sound/apple,mca.yaml
>> @@ -0,0 +1,131 @@
> 
> 
>> +properties:
>> +  compatible:
>> +    items:
>> +      - enum:
>> +          - apple,t8103-mca
>> +          - apple,t6000-mca
> 
> Since it was brought up last time but I didn’t respond: the
> nonalphabetical order is as the chips were introduced (and
> matches other schemas).

Sure, just keep that order for future compatibles as well - so always
put them according to verifiable time of market introduction...

This is very poor reason, instead of alphabetical order. Even worse
reason is repeating wrong pattern just because someone else did it.

Best regards,
Krzysztof
