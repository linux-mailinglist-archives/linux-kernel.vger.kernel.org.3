Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8743357BEBF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 21:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234254AbiGTTm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 15:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbiGTTm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 15:42:26 -0400
Received: from relay01.th.seeweb.it (relay01.th.seeweb.it [5.144.164.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16CA52DC5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 12:42:25 -0700 (PDT)
Received: from [192.168.1.101] (abxj77.neoplus.adsl.tpnet.pl [83.9.3.77])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id F3ECD200CD;
        Wed, 20 Jul 2022 21:42:22 +0200 (CEST)
Message-ID: <e34e7932-b64a-59d8-dfa2-2de23a52425c@somainline.org>
Date:   Wed, 20 Jul 2022 21:42:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/3] dt-bindings: clock: add SM6375 QCOM global clock
 bindings
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220719115756.32231-1-konrad.dybcio@somainline.org>
 <20220719115756.32231-2-konrad.dybcio@somainline.org>
 <11cc46d8-ae01-f3d2-b9c6-c366c6e4afc9@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <11cc46d8-ae01-f3d2-b9c6-c366c6e4afc9@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20.07.2022 08:27, Krzysztof Kozlowski wrote:
> On 19/07/2022 13:57, Konrad Dybcio wrote:
>> Add device tree bindings for global clock controller for SM6375 SoCs.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
>> ---

[...]

>> +++ b/include/dt-bindings/clock/qcom,sm6375-gcc.h
>> @@ -0,0 +1,234 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
> 
> Hm, Qualcomm gave permission to relicense bindings to dual-license,
> although I am not sure how this works with files where copyrights were
> transferred to Linux Foundation...
Right, I overlooked this.

Considering all of the headers for the clock controllers are an exact or
almost exact copy of the downstream ones ever since qcom switched to using
the common clock framework in 2017 or so, plus I am not sure how
copyrightable this is, given copying names from the .c driver, making them
uppercase and assigning them consecutive numbers is not exactly much of a
creative work.. so I don't think anybody would oppose it?

Obviously I'm not a lawyer and this is not legal advice..

Konrad
> 
>> +/*
>> + * Copyright (c) 2021, The Linux Foundation. All rights reserved.
>> + * Copyright (c) 2022, Konrad Dybcio <konrad.dybcio@somainline.org>
>> + */
>> +
>> +#ifndef _DT_BINDINGS_CLK_QCOM_GCC_SM6375_H
>> +#define _DT_BINDINGS_CLK_QCOM_GCC_SM6375_H
>> +
> 
> 
> Best regards,
> Krzysztof
