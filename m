Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CACD7563F1F
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 10:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbiGBIgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 04:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiGBIgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 04:36:42 -0400
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [IPv6:2001:4b7a:2000:18::171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18DE15A16
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 01:36:40 -0700 (PDT)
Received: from [192.168.1.101] (abxi46.neoplus.adsl.tpnet.pl [83.9.2.46])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id C330D3F6DB;
        Sat,  2 Jul 2022 10:36:36 +0200 (CEST)
Message-ID: <3d1c84f6-bd38-902f-3499-d32d0d4ab846@somainline.org>
Date:   Sat, 2 Jul 2022 10:36:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] dt-bindings: qcom: readme: document preferred compatible
 naming
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Alex Elder <elder@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>
References: <20220701074659.12680-1-krzysztof.kozlowski@linaro.org>
 <20220701204218.GA1478943-robh@kernel.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20220701204218.GA1478943-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,TVD_PH_BODY_ACCOUNTS_PRE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1.07.2022 22:42, Rob Herring wrote:
> On Fri, Jul 01, 2022 at 09:46:59AM +0200, Krzysztof Kozlowski wrote:
>> Compatibles can come in two formats.  Either "vendor,ip-soc" or
>> "vendor,soc-ip".  Qualcomm bindings were mixing both of usages, so add a
>> readme file documenting preferred policy.
> 
> Is this all I needed to do to stop this from QCom? </sarcasm>
> 
> This convention is not QCom specific, though the error mostly is. 
> Perhaps this should be documented generically.
> 
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> ---
>>
>> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> Cc: Vinod Koul <vkoul@kernel.org>
>> Cc: Alex Elder <elder@linaro.org>
>> Cc: Robert Foss <robert.foss@linaro.org>
>> Cc: Bhupesh Sharma <bhupesh.sharma@linaro.org>
>> ---
>>  .../devicetree/bindings/soc/qcom/README.rst      | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/README.rst
>>
>> diff --git a/Documentation/devicetree/bindings/soc/qcom/README.rst b/Documentation/devicetree/bindings/soc/qcom/README.rst
>> new file mode 100644
>> index 000000000000..322b329ac7c1
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/soc/qcom/README.rst
>> @@ -0,0 +1,16 @@
>> +.. SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +
>> +Qualcomm SoC compatibles naming convention
>> +==========================================
>> +1. When adding new compatibles in new bindings, use the format:
>> +   ::
>> +
>> +     qcom,SoC-IP
>> +
>> +   For example:
>> +   ::
>> +
>> +     qcom,sdm845-llcc-bwmon
> 
> Assuming the list of possible SoCs was maintained, you could make this a 
> schema. Though there might be false positives.
Maybe there could be a list of *all* (maaaybe except the really vintage ones
that could barely run Linux at all, if even..), qcom SoCs (for example based
on the Wikipedia one [1]) that would account for future porting and could be
updated with new platforms as they get released?

Konrad

[1] https://en.wikipedia.org/wiki/List_of_Qualcomm_Snapdragon_processors
>
>> +
>> +2. When adding new compatibles to existing bindings, use the format
>> +   in the existing binding, even if it contradicts the above.
>> -- 
>> 2.34.1
>>
>>
