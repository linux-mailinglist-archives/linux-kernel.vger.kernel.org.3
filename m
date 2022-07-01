Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B039F5632D2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 13:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235232AbiGALoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 07:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233002AbiGALov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 07:44:51 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC5583F03;
        Fri,  1 Jul 2022 04:44:50 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2619A9MQ011365;
        Fri, 1 Jul 2022 13:44:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=GJJ52lhUhj4o1qROaAEGP2w0pWrROy0u95uriOoeI1I=;
 b=1oSQWtBzUSFQuUFs+b3lbw4wkppk6imbg9I3DGX1oyRbaTQw4q1xUAPR0rHv0BERoWp5
 bWQvfOugvELpgKJZ2NwWncbrrHAdxvvIbabWvLq0Qg4LZvgiLn1BhntPq+fe+8l3Bl+w
 zfhWZps/gQ0VKYhWZlUDsDbsMxAQi0vXCgRn7im0nMUP8FJVfjZx41xD4uZLZXE4Ip/P
 /cW2l1TSM7gi3PdqRryD5qi/RDx+PcMmrU+QVMfY9CljdBibcRxYDDxReJ7mE8pwdEYe
 HBLpsAQmLxz30AJxPrankjt1xYCtkIqJwSJzzaek2q1JeORseFn7weW6hcYBRq6Mq+Mb 0Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3h1x2brv02-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Jul 2022 13:44:41 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A6E1010002A;
        Fri,  1 Jul 2022 13:44:40 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A0FC021B514;
        Fri,  1 Jul 2022 13:44:40 +0200 (CEST)
Received: from [10.201.21.93] (10.75.127.49) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Fri, 1 Jul
 2022 13:44:40 +0200
Message-ID: <157d783b-156a-72fb-542a-87c483ca2411@foss.st.com>
Date:   Fri, 1 Jul 2022 13:44:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 0/3] SCMI Update for STM32MP15 boards
Content-Language: en-US
To:     <gabriel.fernandez@foss.st.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20220624092715.1397827-1-gabriel.fernandez@foss.st.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20220624092715.1397827-1-gabriel.fernandez@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.49]
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

Hi Gabriel

On 6/24/22 11:27, gabriel.fernandez@foss.st.com wrote:
> From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
> 
> Update for SCMI version of ST boards:
> - delete fixed clocks because there are now provided by SCMI
> - add missing SCMI impact for DSI IP on DK1/ED1 STM32 board
> - fix peripheral clock for CEC
> 
> Gabriel Fernandez (3):
>    ARM: dts: stm32: use the correct clock source for CEC on stm32mp151
>    ARM: dts: stm32: DSI should use LSE SCMI clock on DK1/ED1 STM32 board
>    ARM: dts: stm32: delete fixed clock node on STM32MP15-SCMI
> 
>   arch/arm/boot/dts/stm32mp15-scmi.dtsi      | 6 ++++++
>   arch/arm/boot/dts/stm32mp151.dtsi          | 2 +-
>   arch/arm/boot/dts/stm32mp157a-dk1-scmi.dts | 4 ++++
>   arch/arm/boot/dts/stm32mp157c-ed1-scmi.dts | 4 ++++
>   4 files changed, 15 insertions(+), 1 deletion(-)
> 

Series applied in stm32-fixes.

Alex
