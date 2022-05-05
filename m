Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD9D51BE3E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 13:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358020AbiEELlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 07:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350382AbiEELlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 07:41:47 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C334535849;
        Thu,  5 May 2022 04:38:07 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2458OXkn015790;
        Thu, 5 May 2022 13:37:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=nah7mSDbtSwqT6AwNkM/s3+n1ALTH54pR+JyiLo0OUA=;
 b=jW6cEH7ZRj/XQEGpAAz73I8QIYZM9G9joxCDuohfazgHejixWyuRIUuZgn47sylctAkV
 7kmgCflxJWiiVWw8n3C1rTp2LU3VOzlim7pci54gfZ8EOcqDWAM75P2ySWmxcXSMXkZV
 p1BZQPlHFIGOrVrN0Idc1RynTfjSDp4Nq7JcPdwanmiXDJltCc2XY7wZ8O6qLh6CuDV8
 g4ZxBuNS9PSaC7oNFJNIOnvZ7k8aXTrwktIGp/zXbN29dRizirEFxaJjbaNrHgjMuwZS
 u6jkeH6HxaFO7Ticfsc2wG04W3ILXceTCivxcED9whTCujVNSdWQyUO7lmibfm/iSKL7 1Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3frvf0sswk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 May 2022 13:37:54 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D6A4F100034;
        Thu,  5 May 2022 13:37:39 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CFF1D21A23F;
        Thu,  5 May 2022 13:37:39 +0200 (CEST)
Received: from [10.211.10.105] (10.75.127.48) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Thu, 5 May
 2022 13:37:39 +0200
Message-ID: <44356f74-5ab9-5cb9-ae76-6495803d845e@foss.st.com>
Date:   Thu, 5 May 2022 13:37:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] dt-bindings: remoteproc: Fix phandle-array parameters
 description
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220504094143.1272200-1-arnaud.pouliquen@foss.st.com>
 <e0af5143-7fe1-fa68-25c0-eb81d695844a@linaro.org>
From:   Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
In-Reply-To: <e0af5143-7fe1-fa68-25c0-eb81d695844a@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-05_04,2022-05-05_01,2022-02-23_01
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/5/22 11:10, Krzysztof Kozlowski wrote:
> On 04/05/2022 11:41, Arnaud Pouliquen wrote:
>> Replace the FIXME by appropriate description.
>>
>> Fixes: 39bd2b6a3783 ("dt-bindings: Improve phandle-array schemas")
>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
>> ---
>>  .../bindings/remoteproc/st,stm32-rproc.yaml      | 16 ++++++++--------
> 
> Please add "st,stm32-rproc" as last prefix in the subject. With that:
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 

Done in a V2,
Thanks
Arnaud

> 
> Best regards,
> Krzysztof
