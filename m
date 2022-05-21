Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB5F952FD52
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 16:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355241AbiEUOdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 10:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355226AbiEUOdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 10:33:12 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2E160043
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 07:33:10 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id l13so12010674lfp.11
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 07:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Hn1tpaExx4W+/e0w4YZThPk8OvIZPTL/mPjUx1/h2t4=;
        b=cKZtkaIjNKIn8y6S+OXauTN4MPMFZ8458LigpDSBhWV76hYXxYBdqHWjYYzTFz9gzK
         9J8yEJ9NsTW4U0FxzdG4RKJr4DMj81BSBvuJgKyYZ77lvujT3ufH15rxd+/L8KtBb5le
         LeQSrU494fo6TMGAJQOP2cTf+5AIZ6EO/EIzZIRIpF5Lpp8/AwKlx79/PRfwcHw93UrB
         kr/NZdnBb0ysyfY96bSS0k4xXjPormKhzj5JKYhy/rspkqFDzHc4Cnr8TVt0YDItzc+o
         9Rd63W88lrb2ERvIb9uW6v5IKs0EmuW2S+GdliJIqeuQzRlG1AI9rtaxLb4F2rwojlAm
         Vlcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Hn1tpaExx4W+/e0w4YZThPk8OvIZPTL/mPjUx1/h2t4=;
        b=P/+VXjIbHAGftPP9wAkKPbePuhcg4JgibF180UWKDrxMqThyXhgVtbzbbHbkh6BUah
         jdgNjR/e6uqgJBLC8AWKnC7QbezfC6I4iHdC95oRs8wKGmDJcuFSrO3FmrZN76UnROf7
         lf6HWexqgP411p+z9MYnAAr+clenbSi2UFUiSZGGFonJPBMdP6m27lfL3cw28+pTb1Bj
         YYqDvQnaq70+B1SatH11f6+g0Feot1p+vrPpIz+a4BaEldix7t1crWZXAbXQVX/p3Tl1
         rzjl6FVZn9aeO/wYps4ez/PJ3AFL5vs9vod3LubZXbVsa/35sZeMNkgZ36gkpk11ZKmS
         LYRQ==
X-Gm-Message-State: AOAM533i1L0ZVCVs1uQaUrtqRUAsOSNGhxGFDn61dwQnaPDfvWre/5xd
        hI0tRQnSFPXgm5DoKNICxH9xNc3bRlEzOvCL
X-Google-Smtp-Source: ABdhPJyx6Mwjo8UHnCdnLrCqjRw6qNRdRwXtYGACm3ClOhYNuNa7LoKqXYd5gtbZXBA3V855VgXOlQ==
X-Received: by 2002:a05:6512:ad2:b0:478:623e:ca73 with SMTP id n18-20020a0565120ad200b00478623eca73mr1771941lfu.290.1653143588422;
        Sat, 21 May 2022 07:33:08 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id s25-20020a2e81d9000000b00253bb2564cbsm726024ljg.134.2022.05.21.07.33.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 May 2022 07:33:07 -0700 (PDT)
Message-ID: <2a7ff8d1-9ef8-af6c-e541-80417aba7782@linaro.org>
Date:   Sat, 21 May 2022 16:33:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 2/3] dt-bindings: remoteproc: qcom: Convert SC7280 MSS
 bindings to YAML
Content-Language: en-US
To:     Sibi Sankar <quic_sibis@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>, bjorn.andersson@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Cc:     ohad@wizery.com, agross@kernel.org, mathieu.poirier@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mka@chromium.org
References: <1652978825-5304-1-git-send-email-quic_sibis@quicinc.com>
 <1652978825-5304-3-git-send-email-quic_sibis@quicinc.com>
 <CAE-0n50iYAUmj6GEdCuOJ1d_SgeeFWtoxqWf7qN=jZ_js4wBcQ@mail.gmail.com>
 <1289c2e4-5607-b515-88b1-f44585e62cd3@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1289c2e4-5607-b515-88b1-f44585e62cd3@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/05/2022 20:46, Sibi Sankar wrote:
>>> +  memory-region:
>>> +    maxItems: 2
>>> +    description: Phandle reference to the reserved-memory for the MBA region followed
>>> +                 by the modem region.
>>> +
>>> +  firmware-name:
>>> +    $ref: /schemas/types.yaml#/definitions/string-array
>>> +    maxItems: 2
>>
>> Instead of maxItems can this be
>>
>>         items:
>>           - description: Name of MBA firmware
>> 	 - description: Name of modem firmware
>>
>> so that we know the order? Same for 'memory-region' above.
> 
> ack
> 
>>
>>> +    description:
>>> +      The name of the MBA and modem firmware to be loaded for this remote processor.
>>> +
>>> +  qcom,halt-regs:
>>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>>
>> Should this have maxItems: 1? Or that's implicit from description?
> 
> It's implicit!

I am not aware of such implicit rule in schema. maxItems are always
required. If this is maxItems:1 it is not even an array.

> 
>>
>>> +    description:
>>> +      Phandle reference to a syscon representing TCSR followed by the
>>> +      four offsets within syscon for q6, modem, nc and vq6 halt registers.
>>> +
>>> +  qcom,ext-regs:
>>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>>
>> Should this have min/maxItems: 2?
> 
> ack

You should also define the items. This applies to all such fields. Check
the examples of syscon consumers.

> 
>>
>>> +    description:
>>> +      Two phandle references to syscons representing TCSR_REG and TCSR register
>>> +      space followed by the two offsets within the syscon to force_clk_en/rscc_disable
>>> +      and axim1_clk_off/crypto_clk_off registers respectively.
>>> +
>>> +  qcom,qaccept-regs:
>>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>>> +    description:
>>> +      Phandle reference to a syscon representing TCSR followed by the
>>> +      three offsets within syscon for mdm, cx and axi qaccept registers.
>>> +
>>> +  qcom,qmp:
>>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>> +    description: Reference to the AOSS side-channel message RAM.
>>> +
>>> +  qcom,smem-states:
>>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>>> +    description: States used by the AP to signal the Hexagon core
>>> +    items:
>>> +      - description: Stop the modem
>>
>> This one did items for a phandle array so I think we should follow the
>> same above.
> 
> ack
> 
>>
>>> +
>>> +  qcom,smem-state-names:
>>> +    description: The names of the state bits used for SMP2P output
>>> +    const: stop
>>> +
>>> +  glink-edge:
>>> +    $ref: qcom,glink-edge.yaml#
>>> +    description:
>>> +      Qualcomm G-Link subnode which represents communication edge, channels
>>> +      and devices related to the DSP.
>> [..]
>>> +        power-domain-names = "cx", "mss";
>>> +
>>> +        memory-region = <&mba_mem>, <&mpss_mem>;
>>> +
>>> +        qcom,qmp = <&aoss_qmp>;
>>> +
>>> +        qcom,smem-states = <&modem_smp2p_out 0>;
>>> +        qcom,smem-state-names = "stop";
>>> +
>>> +        resets = <&aoss_reset AOSS_CC_MSS_RESTART>,
>>> +                 <&pdc_reset PDC_MODEM_SYNC_RESET>;
>>> +        reset-names = "mss_restart", "pdc_reset";
>>> +
>>> +        qcom,halt-regs = <&tcsr_mutex 0x23000 0x25000 0x28000 0x33000>;
>>> +        qcom,ext-regs = <&tcsr 0x10000 0x10004 &tcsr_mutex 0x26004 0x26008>;
>>
>> Because it's two items I'd expect:
>> 	
>> 	<&tcsr 0x10000 0x10004>, <&tcsr_mutex 0x26004 0x26008>;
> 
> I guess both the ways work since the driver uses
> of_parse_phandle_with_fixed_args.

But only one is correct...


Best regards,
Krzysztof
