Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49448584FD4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 14:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235924AbiG2MBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 08:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235606AbiG2MBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 08:01:04 -0400
Received: from relay02.th.seeweb.it (relay02.th.seeweb.it [IPv6:2001:4b7a:2000:18::163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F315028E27;
        Fri, 29 Jul 2022 05:01:03 -0700 (PDT)
Received: from [192.168.1.101] (abxi232.neoplus.adsl.tpnet.pl [83.9.2.232])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id B34871F927;
        Fri, 29 Jul 2022 14:01:01 +0200 (CEST)
Message-ID: <f0a4790d-7739-3bc5-b877-2dacbdb5158b@somainline.org>
Date:   Fri, 29 Jul 2022 14:01:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/3] ARM: dts: qcom: msm8960: add reference to sleep_clk
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Shinjo Park <peremen@gmail.com>
Cc:     David Heidelberg <david@ixit.cz>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220728111603.30503-1-peremen@gmail.com>
 <66e15d42-96fd-5b02-b7c8-a284d3f8d21f@linaro.org>
 <f932415d-3bee-0948-a016-a2e837dd7256@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <f932415d-3bee-0948-a016-a2e837dd7256@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29.07.2022 13:33, Dmitry Baryshkov wrote:
> On 28/07/2022 14:51, Krzysztof Kozlowski wrote:
>> On 28/07/2022 13:16, Shinjo Park wrote:
>>> Change the reference of sleep_clk to the same as qcom-apq8064.dtsi.
>>
>> You add label, not change something.
>>
>>>
>>> Signed-off-by: Shinjo Park <peremen@gmail.com>
>>> Reviewed-by: David Heidelberg <david@ixit.cz>
>>> ---
>>>   arch/arm/boot/dts/qcom-msm8960.dtsi | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm/boot/dts/qcom-msm8960.dtsi b/arch/arm/boot/dts/qcom-msm8960.dtsi
>>> index e8cd1c9c0..991eb1948 100644
>>> --- a/arch/arm/boot/dts/qcom-msm8960.dtsi
>>> +++ b/arch/arm/boot/dts/qcom-msm8960.dtsi
>>> @@ -71,7 +71,7 @@ pxo_board: pxo_board {
>>>               clock-output-names = "pxo_board";
>>>           };
>>>   -        sleep_clk {
>>> +        sleep_clk: sleep_clk {
>>
>> Since you touch the line, make the device node sleep-clk (device node
>> names should not have underscores) and mention this in commit msg.
> 
> 
> Then we are back to the compat issues, since the gcc expects the 'sleep_clk' clock.
clock-output-names = "sleep_clk";

Konrad
> 
> 
