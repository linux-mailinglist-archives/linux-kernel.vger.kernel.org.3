Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCF6D50715F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 17:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353628AbiDSPJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 11:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343927AbiDSPJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 11:09:36 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E270B3A5FE;
        Tue, 19 Apr 2022 08:06:52 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id t25so21668345edt.9;
        Tue, 19 Apr 2022 08:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=yICZo35JVSCay/S/x1TB8kX9507M+hco0NaA8O/7pCU=;
        b=dqhBAOnaEOaiRPgnwFlRiMHN3lB5cjbPy5HM5ysMYjsbjEcCoKfr7kln27sTR9pRgV
         gE5PzIU0MJamXr0s+yAUwpgHUDOCYAE5LWPiTTJqtWn4BulTN10rSw9f/JjshFGaTM1L
         YUTdDpHPJ02DV3sOMYKKCj86Y0cspr8Ys8jwmp9x38xRSrRXkgqDG0EGAjaRdSUDuZH/
         DLzHUrk0uJg7sOLFCc8na9Jplo0SYN3U9ynpRRJfaU2I9hNcr01RuWySYDl0NbjwNHYi
         kELwR6JUC8qvRI1xwp2ur+FRci7aVgOBkEsRITJyLUOcbjQQkHmWPBdNgjdFsoLWcndc
         k7dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yICZo35JVSCay/S/x1TB8kX9507M+hco0NaA8O/7pCU=;
        b=CjFt3RuyUlQtj0ApaNJl+rs+r60vQblj6A0C6IKUtqi8XLA8MsPgZu/lKL0Q5ctDFf
         3djTVSXv55GRtbSUVuiCrMhNKunWNrP19TqJ5Zg9CAPz3OSVnnwLY3eRZWEr3nAi2fzX
         QYZn5wCFISUNbxRoodp3ob7Ly4fq/SrpsdJuxFR/72eQSQX5VqIzQfjlmh8p7Kiz5Jc2
         KltNisGLif6+62iKKrY4dUJ7PoSLGR6iJO60Uo455TYxxk9K8Be5tD0LMgp4fHFzXzvc
         i++QynjcYngKX7PswPn4s1nn2pqf7Vde1Th23qqbbkmGlbipwNXDn1jcPitFzRPCkaHa
         BoXg==
X-Gm-Message-State: AOAM533Qu48lnM9BzWjFg27YeFEj5AmU21yU5Bv8d6lsUVWbGT54LPTv
        GOTH6DlTneoTjw/qSfRkP4w=
X-Google-Smtp-Source: ABdhPJyydUHtFp3YDsnBHqpecx1FOJ26DObQViOuhiNGCtKScNX7BimnMLHUfAZfVE1+x3dHcfClpQ==
X-Received: by 2002:aa7:c948:0:b0:413:2bed:e82e with SMTP id h8-20020aa7c948000000b004132bede82emr17908502edt.394.1650380811313;
        Tue, 19 Apr 2022 08:06:51 -0700 (PDT)
Received: from [192.168.0.182] ([188.24.22.234])
        by smtp.gmail.com with ESMTPSA id kb9-20020a1709070f8900b006e889aad94esm5772063ejc.128.2022.04.19.08.06.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 08:06:50 -0700 (PDT)
Message-ID: <417c3fdb-a264-250b-7385-d5f9acf166d1@gmail.com>
Date:   Tue, 19 Apr 2022 18:06:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: add AD4130
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-kernel@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Linus Walleij <linus.walleij@linaro.org>
References: <20220419093506.135553-1-cosmin.tanislav@analog.com>
 <20220419093506.135553-2-cosmin.tanislav@analog.com>
 <1650370363.604220.1977871.nullmailer@robh.at.kernel.org>
From:   Cosmin Tanislav <demonsingur@gmail.com>
In-Reply-To: <1650370363.604220.1977871.nullmailer@robh.at.kernel.org>
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



On 4/19/22 15:12, Rob Herring wrote:
> On Tue, 19 Apr 2022 12:35:05 +0300, Cosmin Tanislav wrote:
>> AD4130-8 is an ultra-low power, high precision, measurement solution for
>> low bandwidth battery operated applications.
>>
>> The fully integrated AFE (Analog Front-End) includes a multiplexer for up
>> to 16 single-ended or 8 differential inputs, PGA (Programmable Gain
>> Amplifier), 24-bit Sigma-Delta ADC, on-chip reference and oscillator,
>> selectable filter options, smart sequencer, sensor biasing and excitation
>> options, diagnostics, and a FIFO buffer.
>>
>> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
>> ---
>>   .../bindings/iio/adc/adi,ad4130.yaml          | 263 ++++++++++++++++++
>>   1 file changed, 263 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
>>
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> Error: Documentation/devicetree/bindings/iio/adc/adi,ad4130.example.dts:35.30-31 syntax error
> FATAL ERROR: Unable to parse input tree
> make[1]: *** [scripts/Makefile.lib:364: Documentation/devicetree/bindings/iio/adc/adi,ad4130.example.dtb] Error 1
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:1401: dt_binding_check] Error 2
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/patch/
> 
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit.
> 

Sending V3 to fix this. Please disregard.

