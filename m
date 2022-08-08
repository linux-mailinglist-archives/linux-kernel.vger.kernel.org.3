Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B266658CBDB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 18:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243881AbiHHQJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 12:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243316AbiHHQJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 12:09:22 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2D615A2B;
        Mon,  8 Aug 2022 09:09:20 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 278BeAh0022290;
        Mon, 8 Aug 2022 18:09:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=rf79dk1iiMXWP3qcuM7pMgLmAweJ/wxrLQJ66XbRxFc=;
 b=S2UxETO7/2Zq2pKp71n5vrL2HZpPfqQtHZk65AhuEGIwmyT7zOZDvtmnYmuRniEw3U3M
 FhTZBIZIPBSGifuI8x7CAB30JJO7mqVd71fRol9RINJMxO4jyAbKuX+quXmakdX1Tt1D
 xT4Qm5T9Bk+tbHzZj+duojwrPeRvOBWSyipcuaQdhiHnV9pDQ0CrldPt0K+S707iDioq
 kofTBdJ1PJsLr4a1nuoiUiRT+RWbiI1xInSs1IehGeyRCsBnvsO+FD30cx1rRFWT0nqA
 lPOsnEvldrlkdjZdgAtpMp9hTdhYQAY7J9dc9vJiQTDd2jWLNks56bGKnQOBjpGX19yG rg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3hsfn0ames-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Aug 2022 18:09:01 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C6A5E10002A;
        Mon,  8 Aug 2022 18:09:00 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B18B3257AB8;
        Mon,  8 Aug 2022 18:09:00 +0200 (CEST)
Received: from [10.201.21.72] (10.75.127.46) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Mon, 8 Aug
 2022 18:09:00 +0200
Message-ID: <79fd7e19-ceef-14fb-5a83-603740735f8f@foss.st.com>
Date:   Mon, 8 Aug 2022 18:08:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/3] dt-bindings: spi: stm32: Add st,dual-flash property
 in st,stm32-qspi.yaml
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <christophe.kerello@foss.st.com>,
        <devicetree@vger.kernel.org>
References: <20220808074051.44736-1-patrice.chotard@foss.st.com>
 <20220808074051.44736-2-patrice.chotard@foss.st.com>
 <9ad4b4a8-988e-f185-f80c-6f15f341ce8c@linaro.org>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <9ad4b4a8-988e-f185-f80c-6f15f341ce8c@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-08_10,2022-08-08_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzystof

On 8/8/22 11:01, Krzysztof Kozlowski wrote:
> On 08/08/2022 10:40, patrice.chotard@foss.st.com wrote:
>> From: Patrice Chotard <patrice.chotard@foss.st.com>
>>
>> Add new property st,dual-flash which allows to use the QSPI interface as a
>> communication channel using up to 8 qspi line.
>> This mode can only be used if cs-gpios property is defined.
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>  Documentation/devicetree/bindings/spi/st,stm32-qspi.yaml | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/spi/st,stm32-qspi.yaml b/Documentation/devicetree/bindings/spi/st,stm32-qspi.yaml
>> index 6ec6f556182f..5e4f9109799e 100644
>> --- a/Documentation/devicetree/bindings/spi/st,stm32-qspi.yaml
>> +++ b/Documentation/devicetree/bindings/spi/st,stm32-qspi.yaml
>> @@ -46,6 +46,14 @@ properties:
>>        - const: tx
>>        - const: rx
>>  
>> +  st,dual-flash:
>> +    type: boolean
>> +    description:
>> +      Allows to use 8 data lines in case cs-gpios property is defined.
> 
> It's named dual-flash, but what if you want to use QSPI to connect for
> example to FPGA?
> 
> Also how is this related to parallel-memories property?

I called it "dual-flash" simply because it enable the dual flash feature of the QSPI block (bit CR_DFM : Dual Flash Mode)
which allows to use the 8 lines simultaneously of our dual QSPI block.

Best regards
Patrice


> 
> Best regards,
> Krzysztof
