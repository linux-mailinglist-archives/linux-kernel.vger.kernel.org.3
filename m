Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7775A583585
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 01:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbiG0XPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 19:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236179AbiG0XOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 19:14:31 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799F84F6A2;
        Wed, 27 Jul 2022 16:14:14 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id b11so221050eju.10;
        Wed, 27 Jul 2022 16:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=TcR/Hba16utRWgzQ8bdXRxPgeMOIHRSrEa8M8CqJAe8=;
        b=blQu6uJ/ksKBqhhrpsET0yR3sRRpKO8zTyMyBxMBZHb7cBmfNsb19+xa6J5OtHpuZf
         denPmiVelgTazluhPaCaJUkc4VZicW4xeY8fhJXMWey7hg5/IDDsP0Lnz8kPhMVcrmoU
         Ac1g2Wutw6irx1dv5kjcMdZu+0YD3UJlW7xafYm/MV55JHuRTc7dfiq1RzIl0aOqSDs0
         krBAwEtJL40MFyWUXFUcopB5KtaNkIrg2d0qrZQrbyL/knj1PDssGo9o1QRDdMQz6WX8
         C5elhvMh1iSDgbFk+dOy8SDBw99MC9LFWSUhNQfnGnTJ0NDAk9kOpntf8KPCYriPCEcS
         jFEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=TcR/Hba16utRWgzQ8bdXRxPgeMOIHRSrEa8M8CqJAe8=;
        b=EfaxxfnesWhWhzKyNQ2KuGGMK05PfhERV3e993knBwmPCeZCtqcmK/iDJNyatwZdA8
         QPsdDkMvMbxk4/D8efuew8J/xGTWV2CQS5lZHlAlUx5exlVPhPbkN7WNez8hKzARsZD2
         2yTDdJn2jpN5vaM6ZHAXmM6h4Bp7Tz9kOQJNgTq7xwAB0Yq3EadorrJFjKJnBlN3E6gV
         Ij0zAE9bPGwjhBB5xQFLC8t4HYGHfDs0xBuZRPv6N15ZH+PenkLgerpeJfM3UHDvWnik
         k5SxkXST6NevSCY9YpQ4NoTE1IyiLyVf9sqQIH/LO377897K/sR7WTCXi7iGrKyCkqWk
         Yu+A==
X-Gm-Message-State: AJIora+hc6tRRYFzDf4xHJytf8xak9K4FHPZS3TEYkg2Tkq2uihgE1ck
        4xtaaGwOqEzAXJwyjAmMWZnJjOEnjUkd+iZN
X-Google-Smtp-Source: AGRyM1tL0RDZ8Eh6SJuyD07h37mCSFRwuyhUVDR0BMwC/BbTbxZmaeQ3MLIE83tlp7vlSYaKV5/fuA==
X-Received: by 2002:a17:907:6ea7:b0:72f:2cf2:9aef with SMTP id sh39-20020a1709076ea700b0072f2cf29aefmr19471363ejc.215.1658963652300;
        Wed, 27 Jul 2022 16:14:12 -0700 (PDT)
Received: from [192.168.74.101] ([77.78.38.236])
        by smtp.gmail.com with ESMTPSA id ck15-20020a0564021c0f00b0043adc6552d6sm10806486edb.20.2022.07.27.16.14.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jul 2022 16:14:11 -0700 (PDT)
Message-ID: <79077e08-4bd8-6967-748d-876589ef978e@gmail.com>
Date:   Thu, 28 Jul 2022 02:14:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 3/5] regulator: qcom_spmi: Add support for new
 regulator types
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Adam Skladowski <a39.skl@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20220726181133.3262695-1-iskren.chernev@gmail.com>
 <20220726181133.3262695-4-iskren.chernev@gmail.com>
 <YuEoLteLBgd+b8sg@sirena.org.uk>
From:   Iskren Chernev <iskren.chernev@gmail.com>
In-Reply-To: <YuEoLteLBgd+b8sg@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




On 7/27/22 14:57, Mark Brown wrote:
> On Tue, Jul 26, 2022 at 09:11:31PM +0300, Iskren Chernev wrote:
>
>> Add support for some regulator types that are missing in this driver, all
>> belonging to the FTSMPS426 register layout.  This is done in preparation
>> for adding support for the PM6125 PMIC.
>
>> +	.set_mode		= spmi_regulator_ftsmps3_set_mode,
>> +	.get_mode		= spmi_regulator_ftsmps426_get_mode,
>
> Why are set and get asymmetric?

Because the get method, only uses AUTO and HPM, which have the same value
for ftsmps3 and ftsmps426 (so there is no need for a new function).

>> @@ -1473,7 +1557,7 @@ static const struct spmi_regulator_mapping supported_regulators[] = {
>>  	SPMI_VREG(LDO,   HT_P600,  0, INF, HFS430, hfs430, ht_p600, 10000),
>>  	SPMI_VREG(LDO,   HT_P150,  0, INF, HFS430, hfs430, ht_p150, 10000),
>>  	SPMI_VREG(BUCK,  GP_CTL,   0, INF, SMPS,   smps,   smps,   100000),
>> -	SPMI_VREG(BUCK,  HFS430,   0, INF, HFS430, hfs430, hfs430,  10000),
>> +	SPMI_VREG(BUCK,  HFS430,   0,   3, HFS430, hfs430, hfs430,  10000),
>
> The changelog said we were adding support for new types but this looks
> like changing an existing type.

The code, as written now does a different thing for BUCK, HFS430 (on
mainline (ML) and downstream (DS) linked in the commit message). Since DS
only supports newer stuff, to be on safe side, I kept existing behavior for
rev 0-3 on BUCK(3)+HFS430(10), so at least DS and ML agree on pm6125
completely.

The commit [1] that adds support for BUCK+HFS430 might be wrong, or it
might be right for the time being (i.e initial revisions had different
behavior). I'm CC-ing Jorge.

Question is is BUCK+HFS430 on common2 (ftsmps426) or common3 (ftsmps3) or
a mix (depending on revision).

[1] 0211f68e626f (regulator: qcom_spmi: add PMS405 SPMI regulator, 2019-06-17)
