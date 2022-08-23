Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF6E959E4BF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 15:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241159AbiHWN5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 09:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240884AbiHWN4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 09:56:52 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2FB122B8B4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 04:02:58 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id l23so2107605lji.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 04:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=Nh/dSfQpjawYJKjYiUJyrmH/Pdok2iA80vxKA7PHHnc=;
        b=FEdHHqbCC7TtKYyi1L6Ks5VnxgHVgIZG9H2aCY0WL2r6YX2J+LFzAfOn6HO5uQDI/N
         VioQTqrYqgOeSYlSKy8Aa68z0lWTheqQMMuGdCClPHt1N9/1M/GDE9wwN8zAxENmLYxZ
         /gfXbXMVk5ecw0/NuAh5Nk921ymDUjP54UvLi4/G3pCBNy17k0s7sCVQLelgYvQ+OIUv
         n/OLH3fbZAb9qDNSeAD0a9w6s7lORF5A8lDu+KbicYZLUeU3r4Bnvf0G3XmH+v2Z3EAo
         9h242JRXKE5jZrnYtJOVAEOSXBD9M8Rz5dRRHGN/FE8cbqCSaP3R27EV0I7G1FW1cs0q
         ospg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Nh/dSfQpjawYJKjYiUJyrmH/Pdok2iA80vxKA7PHHnc=;
        b=XoIrkcAh2H92f9lcHQOZqJhMJrrRuPJ5HPcLCCVi+8o91ZGcuJhT8FJP8nCTGbw4Rp
         febYC/0TGNJn9LqpFNwIRiHyEs2YOo+DtTbHXj6FN0l6ZgSTGV4S1SC+aOar75FzTP1u
         noKemZBNYPxnJBk1gqVNjIyk7BBzcbMe+Oq7lohF2gN49LYEvXVytkX1pOifh9jAgPNV
         zdf0ixX9syDucJEVUJRp7dcnO/aJI+JOtI3LLJzS1sWNHldQk3Y0td5TUtRC3x1OF5lb
         tKO7bNcHZwz7E50Z1rjQuveUaK/cT6TQhb5LuxftUyXMedHEHMqtqIriiY5IhJqySJGl
         gv8Q==
X-Gm-Message-State: ACgBeo2k8d0aU3HvRwUkbfe0jTSmyE6XYW5Fuk3eSExJhGU26pNGxdCn
        J4I8e6QB/A9OUYCj0AsAErY3wQ==
X-Google-Smtp-Source: AA6agR5vbYNjhHFnx+6VhB11BI4MrfWNs+kd+/HTfFywhleTdAxL7fiMVIIBFB64PGTaYQ6X+iS3mg==
X-Received: by 2002:a2e:8e75:0:b0:261:d530:86f4 with SMTP id t21-20020a2e8e75000000b00261d53086f4mr975578ljk.461.1661252564894;
        Tue, 23 Aug 2022 04:02:44 -0700 (PDT)
Received: from [192.168.0.11] (89-27-92-210.bb.dnainternet.fi. [89.27.92.210])
        by smtp.gmail.com with ESMTPSA id p17-20020a2ea4d1000000b0025d64453f4dsm2316547ljm.122.2022.08.23.04.02.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 04:02:44 -0700 (PDT)
Message-ID: <ae5a10b8-a459-11c9-3fac-4f5de0ba2218@linaro.org>
Date:   Tue, 23 Aug 2022 14:02:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 2/4] arm64: dts: apple: t8103: Add MCA and its support
Content-Language: en-US
To:     =?UTF-8?Q?Martin_Povi=c5=a1er?= <povik+lin@cutebit.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        asahi@lists.linux.dev, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220819125430.4920-1-povik+lin@cutebit.org>
 <20220819125430.4920-3-povik+lin@cutebit.org>
 <38094e2d-c75c-920b-4b4d-aa377971f615@linaro.org>
 <A9E366E2-EA4D-4F35-BE28-63745296D222@cutebit.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <A9E366E2-EA4D-4F35-BE28-63745296D222@cutebit.org>
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

On 19/08/2022 17:24, Martin Povišer wrote:
> 
> 
>> On 19. 8. 2022, at 15:12, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 19/08/2022 15:54, Martin Povišer wrote:
>>> Add the MCA I2S transceiver node and its supporting NCO, ADMAC nodes.
>>>
>>> Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
>>> ---
>>> arch/arm64/boot/dts/apple/t8103.dtsi | 70 ++++++++++++++++++++++++++++
>>> 1 file changed, 70 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/apple/t8103.dtsi b/arch/arm64/boot/dts/apple/t8103.dtsi
>>> index 51a63b29d404..2dc3125aca5b 100644
>>> --- a/arch/arm64/boot/dts/apple/t8103.dtsi
>>> +++ b/arch/arm64/boot/dts/apple/t8103.dtsi
>>> @@ -532,6 +532,76 @@ port02: pci@2,0 {
>>> 						<0 0 0 4 &port02 0 0 0 3>;
>>> 			};
>>> 		};
>>> +
>>> +		dart_sio: iommu@235004000 {
>>> +			compatible = "apple,t8103-dart", "apple,dart";
>>> +			reg = <0x2 0x35004000 0x0 0x4000>;
>>> +			interrupt-parent = <&aic>;
>>> +			interrupts = <AIC_IRQ 635 IRQ_TYPE_LEVEL_HIGH>;
>>> +			#iommu-cells = <1>;
>>> +			power-domains = <&ps_sio_cpu>;
>>> +		};
>>> +
>>> +		nco_clkref: clock-ref {
>>> +			compatible = "fixed-clock";
>>> +			#clock-cells = <0>;
>>> +			clock-frequency = <900000000>;
>>> +			clock-output-names = "nco_ref";
>>> +		};
>>
>> Reference clocks are usually physically outside of SoC (e.g. on the
>> board), so:
>> 1. Not part of "soc" node.
>> 2. It should be defined by board. At least clock-frequency should be there.
> 
> Ah, right, this deserves commentary: Since this is a reverse-engineered
> driver/platform support, we give up on knowing the clock tree exactly. Instead
> we model the clock input to the Numerically Controlled Oscillator (‘nco’ node
> below) with this fabulated fixed clock reference.
> 
> I guess eventually the clock tree is rooted off the SoC, and there’s
> nothing guaranteeing the same reference clock to the NCO across machines (being
> function of the board wiring and the proprietary firmware). In the end I would
> argue for keeping the ‘clock-ref’ here in ’soc' but have the clock-frequency
> defined by board.  Sounds reasonable?

Yes.

Best regards,
Krzysztof
