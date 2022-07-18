Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47EAD578587
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 16:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233271AbiGROeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 10:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234996AbiGROeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 10:34:17 -0400
Received: from relay01.th.seeweb.it (relay01.th.seeweb.it [5.144.164.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8F81117E
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 07:34:14 -0700 (PDT)
Received: from [192.168.1.101] (abxj77.neoplus.adsl.tpnet.pl [83.9.3.77])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 6EFA41F560;
        Mon, 18 Jul 2022 16:34:10 +0200 (CEST)
Message-ID: <624057b9-62d2-9807-8d3f-4bfa8f2996df@somainline.org>
Date:   Mon, 18 Jul 2022 16:34:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/6] dt-bindings: firmware: scm: Add compatible for SM6375
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220716193257.456023-1-konrad.dybcio@somainline.org>
 <20220716193257.456023-2-konrad.dybcio@somainline.org>
 <53d57eb3-c859-6f56-c104-4c05ebe737b8@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <53d57eb3-c859-6f56-c104-4c05ebe737b8@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18.07.2022 16:29, Krzysztof Kozlowski wrote:
> On 16/07/2022 21:32, Konrad Dybcio wrote:
>> Add a SCM compatible for SM6375.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
>> ---
>>  Documentation/devicetree/bindings/firmware/qcom,scm.txt | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.txt b/Documentation/devicetree/bindings/firmware/qcom,scm.txt
>> index b3f702cbed87..de7bb8b8d85e 100644
>> --- a/Documentation/devicetree/bindings/firmware/qcom,scm.txt
>> +++ b/Documentation/devicetree/bindings/firmware/qcom,scm.txt
>> @@ -35,6 +35,7 @@ Required properties:
>>   * "qcom,scm-sm8250"
>>   * "qcom,scm-sm8350"
>>   * "qcom,scm-sm8450"
>> + * "qcom,sm6375-scm"
> 
> Uh, I think we wanted to keep it consistent with existing ones, didn't we?
> 
I still haven't sent DT yet (need to get drivers in first), so I can do either,
though I thought it would be good practice to switch to the now-preferred
format and not have to add any more compatibles to the exception list.
> 
> Best regards,
> Krzysztof
