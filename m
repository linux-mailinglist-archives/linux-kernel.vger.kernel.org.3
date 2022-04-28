Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54F415138F5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 17:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349609AbiD1PsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 11:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349582AbiD1PsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 11:48:15 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4DDB898B
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 08:44:59 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id j4so9355539lfh.8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 08:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/eHeCrUed7+/lXNEub6C0Esktyijgekt4pzIp04f+IY=;
        b=qmImpLMyvpPiGXndoQS4+JPohrtWd+U93ZMfCS764koCLYF+LfLEJlGCRc9bNVlkpm
         uOAcQkxhwAbGZcQbukHvYX1u9qZlDObgKeSEvI5swYN10wSgiHjnD3d7KcLgYcx4pWbU
         jrjnXlFa4wJ2XDgAb9SX9kDgIMhqklx/LKWPlogXMu9ef72gMDEjnT3hHgVz1JV857Za
         +NFzlNDl7ap1vo9LVJpipW3Bqq2Eu7nGWzr9tta2O1Lgb1tZPD+t8/o+/3Bp6BWq2olQ
         jRTjmqdnVL/mIECDN6sb3FxCPylnVKxG7suSSOMHkZvphHpXCEzXJ1a7E1zDezRg+rMh
         BMqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/eHeCrUed7+/lXNEub6C0Esktyijgekt4pzIp04f+IY=;
        b=ROPQm7mblrTfzKZ382gMjs7Q0O668H3+Cpu18rArXkOebPZPy1UQSeXbwf1kbWOAXg
         cCXVcryt3Ae7FUgcSszQkoyJcHu0LBjNWcPd7JGTxUqbzu+v2NXwYl2gnJ2wYMXGTBYj
         Vfvy2NRAO2DQMXtDwMR2xetrXeBF3R41ENNDw3S9M8/jSc4hwnYGl3g2ngVgEoKrQlz1
         eL1mv4QL0zNgK8HANh8I1zVM/99gxgShl/tjgFI5WVRQVPuGhsFpww5tXjivTqphPIfY
         E5yo3O5D27WsfC8YvDeviyeNoB1jYLtQwz14+ThB6Ftc8vMj65wDO2gH2oYbHtog5UVy
         b/Eg==
X-Gm-Message-State: AOAM530pVZMJDgO74kczbuO8OFE5hGgsllNUzRQq/Ri/IlEU4pSbsHxx
        PfNzCKIOx3T8hhcwUd5YUa/BBgPrGA7tGA==
X-Google-Smtp-Source: ABdhPJx1R2shs/1lmY9s+F36SjRY1gPrpxivXAjchKHJsFAjhSOfHRd2WUNUy5GPegCOgB14eRmKuA==
X-Received: by 2002:a05:6512:128d:b0:471:c860:aab3 with SMTP id u13-20020a056512128d00b00471c860aab3mr24075823lfs.361.1651160697990;
        Thu, 28 Apr 2022 08:44:57 -0700 (PDT)
Received: from [192.168.43.7] ([188.162.64.61])
        by smtp.gmail.com with ESMTPSA id k7-20020a2e92c7000000b0024f1556b6basm25333ljh.92.2022.04.28.08.44.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 08:44:57 -0700 (PDT)
Message-ID: <3fb043e6-2748-24f8-0115-b5372c747a12@linaro.org>
Date:   Thu, 28 Apr 2022 18:44:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 1/2] dt-bindings: clock: Add Qualcomm SC8280XP GCC
 bindings
Content-Language: en-GB
To:     Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_tdas@quicinc.com
References: <20220422230013.1332993-1-bjorn.andersson@linaro.org>
 <20220423014824.912ACC385A0@smtp.kernel.org> <YmNsYSxLtwLpw98t@ripper>
 <20220423031350.01299C385A0@smtp.kernel.org> <YmN11qt/PqogYruQ@ripper>
 <20220425223426.BE973C385A4@smtp.kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220425223426.BE973C385A4@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/04/2022 01:34, Stephen Boyd wrote:
> Quoting Bjorn Andersson (2022-04-22 20:43:18)
>> On Fri 22 Apr 20:13 PDT 2022, Stephen Boyd wrote:
>>>
>>> I'd really rather not have clock-names at all because we spend a bunch
>>> of time comparing strings with them when we could just as easily use
>>> a number.
>>
>> I know that you would like to get rid of the clock-names for the clock
>> controllers. I've looked at it since and while it will be faster to
>> execute I still feel that it's going to be harder to write and maintain.
>>
>> E.g. look at gcc_pcie_4_pipe_clk_src, its parents today are
>> pcie_4_pipe_clk and bi_tcxo. Something I can reason about being correct
>> or not.
>>
>> If we ditch the clock-names I will have:
>>
>> static const struct clk_parent_data gcc_parent_data_14[] = {
>>          { .index = 30 },
>>          { .index = 0 },
> 
> Those numbers could have some #define.
> 
> 	{ .index = PCIE_4_PIPE_CLK_DT }
> 	{ .index = BI_TCXO_DT }
> 
>> };
>>
>> Generally we would perhaps use some compile time constant, but that
>> won't work here because we're talking about the index in the clocks
>> array in the yaml.
>>
>>
>> But perhaps I'm missing something that would make this manageable?
> 
> I dunno. Maybe a macro in the dt-binding header could be used to specify
> the 'clocks' property of the DT node that is providing the other side?
> The idea is to make a bunch of macros that insert the arguments of the
> macro in the right place for the clocks property and then define the
> order of arguments otherwise. It would be similar to how
> CREATE_TRACE_POINTS is used in include/trace/define_trace.h
> 
> In the dt-bindings/qcom,gcc-soc.h file:
> 
> 	#ifdef IN_DTSI
> 
> 	#undef GCC_DT_NODE_CLOCKS
> 	#define GCC_DT_NODE_CLOCKS
> 		clocks = <BI_TCXO_DT>,
> 			 <SLEEP_CLK_DT>;
> 
> 	#endif /* IN_DTSI */
> 
> 	#define BI_TCXO_DT 0
> 	#define SLEEP_CLK_DT 1

Isn't this being an overkill, to define exact properties in the bindings 
header? Also this would mean that we'd have to add dt-binding headers 
for all _consumers_ of clocks. And to make things more complex, e.g. for 
PCIe devices different instances of the device would use different 
amount of clocks. This would mean that we'd have to define 
SM8250_PCI0_CLOCKS, SM8250_PCIE1_CLOCKS and SM8250_PCIE2_CLOCKS.


If we were to switch to this fragile path of using indices (yes I 
consider it to be very fragile), I'd consider something like the 
following to work in the platform dtsi file:

clocks =
BEGIN_CLOCK
CLOCK(BI_TCXO_DT, &bi_tcxo)
CLOCK(SLEEP_CLK_DT, &sleep_clk)
END_CLOCK;

While the following should give an error:
clocks =
BEGIN_CLOCK
CLOCK(SLEEP_CLK_DT, &sleep_clk)
CLOCK(BI_TCXO_DT, &bi_tcxo)
END_CLOCK;

I think we can make this error out by using some additional tool (or 
additional preprocessor pass over the sources)

> And then in the SoC.dtsi file have
> 
> 	#define IN_DTSI
> 	#include <dt-bindings/qcom,gcc-soc.h>
> 
> 	#define BI_TCXO_DT	&xo_board
> 	#define SLEEP_CLK_DT	&sleep_clk
> 
> 	...
> 
> 	clock-controller@a000000 {
> 		compatible = "qcom,gcc-soc";
> 		reg = <0xa000000 0x10000>;
> 		GCC_DT_NODE_CLOCKS
> 	};
> 
> 
> and then in drivers/clk/qcom/gcc-soc.c file:
> 
> 	#include <dt-bindings/qcom,gcc-soc.h>
> 
> 	static const struct clk_parent_data gcc_parent_data_14[] = {
> 		{ .index = PCIE_4_PIPE_CLK_DT },
> 		{ .index = BI_TCXO_DT },
> 	};
> 
> The benefit I see to this is that the index for each clock is in the
> header file (BI_TCXO_DT is 0) and it's next to the clocks property.
> Someone could still mess up the index based on where the macro is used
> in the clocks property though.

And actually might I suggest an alternative approach to manually using 
indices everywhere? What about spending the time once during the boot to 
convert .fw_name and clock_names to parent indices during clock 
registration and then using them for all the further operations?

-- 
With best wishes
Dmitry
