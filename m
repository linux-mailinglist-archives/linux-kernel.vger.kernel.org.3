Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC4358D32A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 07:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233256AbiHIF3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 01:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbiHIF3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 01:29:20 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115981EAEC
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 22:29:19 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id d14so15503867lfl.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 22:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=u/hZlxsdOPGw/Z2ifZgq67lFc+EwFWOndp1d8qCJ2O8=;
        b=NrPr10ZujPg8N0R6nOI/K7Quje7yvVAdJqW1wgapVrP2H2s6lwauQKiIXAxsKK2t0Z
         yC2HhUydYskBXLH+QWkY3YaqPz98IdV0xfAwn4S9KIcOY4UBT1WWjX40m10j8T66ZkjE
         munSYPDFjcQeRlPSCC8pWfem/9NzH1hufVR22KKTHL/eOEQn6H5FFRqiviGWMGHqGzio
         yamuy90GMkH526Ut/tvyvfiUmgyX+irBDbWQxITknIkHKbh5x2fSISsf8rX3xKHZbBPh
         CKtcZ2OhvZxxQxmYmD0W6lN4GHK+n6+aL/IY5i9458Nrpr8aBTKSoUcr/vAXEHHbQkNZ
         dMmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=u/hZlxsdOPGw/Z2ifZgq67lFc+EwFWOndp1d8qCJ2O8=;
        b=Rvf3gRkMlBE56zq/C7DyvLbVY132R/L/P2YEWb2uvXtLvy9wfXyAqQbmmwIPdjzRCt
         R5N9id2O1a3YoYMd3JOYaXRmPtB7oXTM2174mjAgsGgxCfTDxiGrtt40/XyrrkfreBqp
         laAqdzjh/ItT9sYxIngWgNCV2WzJaP0Gl1UyPOpYrOL8ewznldD0Evr7oaMyQwpokzUn
         YVQqau+ph09RZcsXmMoEWMIIfnEMKKTawAYxgGyo2bAQxAL47CzyMU3nQjBqIoVhc6PG
         N9e+qIOAZusBxiRjOwsd7MU5ofXHO5b25LVpv/trcOcqZQJ+1PRe6NlvLk7OPD9F68+s
         xT9A==
X-Gm-Message-State: ACgBeo1J7fHBbN+6IK9iR+vX67V62MvJar8/Fi2tvNOZEePGL1UTdzxt
        mbmw+LUPOE/oFkCEljHHutKQdQ==
X-Google-Smtp-Source: AA6agR5kYLA7ov5xiceEa1hxn2Gue+4ehJgPDN3o+sVTwyH9ADjDLIH0KZGgfn2gz8GFF5FQS73zQA==
X-Received: by 2002:a19:654e:0:b0:48b:965d:d182 with SMTP id c14-20020a19654e000000b0048b965dd182mr5558154lfj.610.1660022957344;
        Mon, 08 Aug 2022 22:29:17 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id w27-20020a05651c119b00b0025e01ee7229sm1551622ljo.54.2022.08.08.22.29.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 22:29:16 -0700 (PDT)
Message-ID: <b15184d6-c9e7-d042-621b-ef4ccd3c87ba@linaro.org>
Date:   Tue, 9 Aug 2022 08:29:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/3] dt-bindings: spi: stm32: Add st,dual-flash property
 in st,stm32-qspi.yaml
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Patrice CHOTARD <patrice.chotard@foss.st.com>,
        Mark Brown <broonie@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        christophe.kerello@foss.st.com, devicetree@vger.kernel.org
References: <20220808074051.44736-1-patrice.chotard@foss.st.com>
 <20220808074051.44736-2-patrice.chotard@foss.st.com>
 <9ad4b4a8-988e-f185-f80c-6f15f341ce8c@linaro.org>
 <79fd7e19-ceef-14fb-5a83-603740735f8f@foss.st.com>
 <38c3977a-0196-1832-ff94-317064cbc439@linaro.org>
In-Reply-To: <38c3977a-0196-1832-ff94-317064cbc439@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/2022 07:18, Krzysztof Kozlowski wrote:
> On 08/08/2022 19:08, Patrice CHOTARD wrote:
>> Hi Krzystof
>>
>> On 8/8/22 11:01, Krzysztof Kozlowski wrote:
>>> On 08/08/2022 10:40, patrice.chotard@foss.st.com wrote:
>>>> From: Patrice Chotard <patrice.chotard@foss.st.com>
>>>>
>>>> Add new property st,dual-flash which allows to use the QSPI interface as a
>>>> communication channel using up to 8 qspi line.
>>>> This mode can only be used if cs-gpios property is defined.
>>>>
>>>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>>>> ---
>>>>  Documentation/devicetree/bindings/spi/st,stm32-qspi.yaml | 8 ++++++++
>>>>  1 file changed, 8 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/spi/st,stm32-qspi.yaml b/Documentation/devicetree/bindings/spi/st,stm32-qspi.yaml
>>>> index 6ec6f556182f..5e4f9109799e 100644
>>>> --- a/Documentation/devicetree/bindings/spi/st,stm32-qspi.yaml
>>>> +++ b/Documentation/devicetree/bindings/spi/st,stm32-qspi.yaml
>>>> @@ -46,6 +46,14 @@ properties:
>>>>        - const: tx
>>>>        - const: rx
>>>>  
>>>> +  st,dual-flash:
>>>> +    type: boolean
>>>> +    description:
>>>> +      Allows to use 8 data lines in case cs-gpios property is defined.
>>>
>>> It's named dual-flash, but what if you want to use QSPI to connect for
>>> example to FPGA?
>>>
>>> Also how is this related to parallel-memories property?
>>
>> I called it "dual-flash" simply because it enable the dual flash feature of the QSPI block (bit CR_DFM : Dual Flash Mode)
>> which allows to use the 8 lines simultaneously of our dual QSPI block.
> 
> And how is it related to existing parallel-memories property?

Maybe I was not specific enough, so let me rephrase - we have already
parallel-memories property. How this one is different (to justify the
new property)? Is just one memory connected in your case to QSPI over 8
data lines?

Best regards,
Krzysztof
