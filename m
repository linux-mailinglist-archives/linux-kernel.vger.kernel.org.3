Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C279A563322
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 14:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234708AbiGAMG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 08:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233643AbiGAMGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 08:06:54 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2509F83F00;
        Fri,  1 Jul 2022 05:06:52 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 261B9fXx023260;
        Fri, 1 Jul 2022 14:06:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=JLmeDHmz4HYB0KdQ39Am9oL6EYP+j5fi0LmM0OxLjj8=;
 b=Atmu8pudBECmO/zqgpwsyX+5ucxttWYE4QYbZQ0NCtybBIzd8ESriP5LRObQyxkJYOgo
 fnsIp+5eWHnX6sr1gML2tRpi8gB1tWqmQYCwijX3n38affi2catfI9IeSRf1XQR1gXhV
 2rE+xKJGYpCEzslJUQ7HSadK4gGzPQF3bPLhelO3NbUeGpZ/qFfybCHzE98mbgcSKisU
 j+WIZrRiL2EYODGuoFXEvHvyh/YWnoGBcaTY+kFGfaf8cSuD9fkpU/q2qO6TCURtX15w
 zYIoN+nlJz9HZbm9Ds3Ck/9IkEmjX2vtuX5iTQKK4dqymF8XUtHG+gTY4jTMuLU5z9Q6 AA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3h1d2mpe5d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Jul 2022 14:06:38 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B92C2100034;
        Fri,  1 Jul 2022 14:06:37 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B3D5221BF46;
        Fri,  1 Jul 2022 14:06:37 +0200 (CEST)
Received: from [10.201.21.93] (10.75.127.48) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Fri, 1 Jul
 2022 14:06:37 +0200
Message-ID: <707af18d-bd00-ae2e-f58e-ce546ab389b9@foss.st.com>
Date:   Fri, 1 Jul 2022 14:06:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] ARM: dts: stm32: fix pwr regulators references to use
 scmi
Content-Language: en-US
To:     Etienne Carriere <etienne.carriere@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
References: <20220624090055.569400-1-etienne.carriere@linaro.org>
 <7329b1e1-6337-5430-e90f-7f4c59c00636@foss.st.com>
 <CAN5uoS_yWujQ=zDHaLqsFuH9w-fnzePhU=CJFwxxLRJOxoEgyw@mail.gmail.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <CAN5uoS_yWujQ=zDHaLqsFuH9w-fnzePhU=CJFwxxLRJOxoEgyw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-01_06,2022-06-28_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/1/22 13:58, Etienne Carriere wrote:
> Thanks Alex,
> 
> By the way, my review tags for other fixes to the scmi DTS files [1],
> [2] and [3]:
> Acked-by: Etienne Carriere <etienne.carriere@linaro.org>
> Tested-by: Etienne Carriere <etienne.carriere@linaro.org>
> These are needed for a consistent kernel configuration of these boards.
> 

Sorry Etienne, I just sent it. But thanks for your tests ;)

Alex

> Br,
> etienne
> 
> [1] https://lore.kernel.org/lkml/20220624092715.1397827-2-gabriel.fernandez@foss.st.com/
> [2] https://lore.kernel.org/lkml/20220624092715.1397827-3-gabriel.fernandez@foss.st.com/
> [3] https://lore.kernel.org/lkml/20220624092715.1397827-4-gabriel.fernandez@foss.st.com/
> 
> On Fri, 1 Jul 2022 at 13:44, Alexandre TORGUE
> <alexandre.torgue@foss.st.com> wrote:
>>
>> Hi Etienne
>>
>> On 6/24/22 11:00, Etienne Carriere wrote:
>>> Fixes stm32mp15*-scmi DTS files introduced in [1] to also access PWR
>>> regulators through SCMI service. This is needed since enabling secure
>>> only access to RCC clock and reset controllers also enables secure
>>> access only on PWR voltage regulators reg11, reg18 and usb33 hence
>>> these must also be accessed through SCMI Voltage Domain protocol.
>>> This change applies on commit [2] that already corrects issues from
>>> commit [1].
>>>
>>> Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
>>> Link: [1] https://lore.kernel.org/linux-arm-kernel/20220422150952.20587-7-alexandre.torgue@foss.st.com
>>> Link: [2] https://lore.kernel.org/linux-arm-kernel/20220613071920.5463-1-alexandre.torgue@foss.st.com
>>> Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
>>> ---
>>
>> Applied in stm32-fixes.
>>
>> Thanks
>> Alex

