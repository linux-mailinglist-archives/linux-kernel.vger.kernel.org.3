Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED9E518742
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 16:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237431AbiECOzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 10:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237424AbiECOzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 10:55:40 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E4A2529C;
        Tue,  3 May 2022 07:52:05 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 243A1AJQ000434;
        Tue, 3 May 2022 16:51:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=1U+jXKnIsS7rQlKgrVn1pp4mv3sRe9hTsUCKKNCqfto=;
 b=GmEUOW+Omwl9ECrQ4aSWCN+wUS1ns/MiHuUtTxn1vi6+s7j4SO5dteDkZVaVFHAaOI7D
 9DBmZjMSn7e04juYoU10HjwBfAPcTJe0HFSIyYEB1ArCrq92VWmCBQJ2CbQo6bz5K4hV
 5gMMz+lTJ380vvbmiJLEQjEGm7a7jizPEjV4NBCTHNgUnXHpzG4DggZ+Qp5LbLCfhbxa
 KrQmGDFJPDfFQetLwbOKq1UmLF39XqORx7JwcyY3prHeB+S5oYc/+7qNdWXImOKb9wV8
 M2ZbHl7Vp1u3f/vwTM1EIIFiL4HCf8FW7G/7KDM1e02OFGJMwZDT8RwzuuEB1FqQ+31q 7Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3frt88r2ah-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 May 2022 16:51:44 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2FC2910002A;
        Tue,  3 May 2022 16:51:40 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C54BE2248D5;
        Tue,  3 May 2022 16:51:40 +0200 (CEST)
Received: from [10.201.21.93] (10.75.127.47) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Tue, 3 May
 2022 16:51:39 +0200
Message-ID: <25ed3a16-c277-5170-3feb-51484f744de1@foss.st.com>
Date:   Tue, 3 May 2022 16:51:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 0/8] Add SCMI version of ST boards
Content-Language: en-US
To:     <arnd@arndb.de>, <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>, <soc@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, Marek Vasut <marex@denx.de>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        <etienne.carriere@st.com>
References: <20220422150952.20587-1-alexandre.torgue@foss.st.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20220422150952.20587-1-alexandre.torgue@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-03_06,2022-05-02_03,2022-02-23_01
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/22/22 17:09, Alexandre Torgue wrote:
> The aim of this series is to add OPTEE and SCMI support for STM32 boards in
> order to enable secure services for clocks and resets. New boards have been added
> to enable this support in order to not break boot of current STM32 boards users.
> 
> This series targets only boards provided by ST which are:
> -STM32MP157A-DK1
> -STM32MP157C-DK2
> -STM32MP157C-ED1
> -STM32MP157C-EV1
> 
> Some modifications in bindings files (yaml and .h) was needed and OPTEE/TEE
> configs are now enabled by default for ARCH_STM32 architecture.
> 
> Note that patch [1] "dt-bindings: rcc: Add optional external ethernet RX clock
> properties" done by Marek has been already merged in Rob tree.
> 
> Thanks
> Alex
> 
> Alexandre Torgue (7):
>    dt-bindings: clock: stm32mp1: describes clocks if
>      "st,stm32mp1-rcc-secure"
>    dt-bindings: clock: stm32mp15: rename CK_SCMI define
>    dt-bindings: reset: stm32mp15: rename RST_SCMI define
>    ARM: stm32: select OPTEE on MPU family
>    ARM: dts: stm32: enable optee firmware and SCMI support on STM32MP15
>    dt-bindings: arm: stm32: Add SCMI version of STM32 boards
>      (DK1/DK2/ED1/EV1)
>    ARM: dts: stm32: Add SCMI version of STM32 boards (DK1/DK2/ED1/EV1)
> 
> Marek Vasut (1):
>    dt-bindings: rcc: Add optional external ethernet RX clock properties
> 
>   .../devicetree/bindings/arm/stm32/stm32.yaml  |  17 +++
>   .../bindings/clock/st,stm32mp1-rcc.yaml       |  34 ++++++
>   arch/arm/boot/dts/Makefile                    |   4 +
>   arch/arm/boot/dts/stm32mp151.dtsi             |  41 +++++++
>   arch/arm/boot/dts/stm32mp157a-dk1-scmi.dts    |  86 +++++++++++++++
>   arch/arm/boot/dts/stm32mp157c-dk2-scmi.dts    |  95 +++++++++++++++++
>   arch/arm/boot/dts/stm32mp157c-ed1-scmi.dts    |  91 ++++++++++++++++
>   arch/arm/boot/dts/stm32mp157c-ev1-scmi.dts    | 100 ++++++++++++++++++
>   arch/arm/mach-stm32/Kconfig                   |   2 +
>   include/dt-bindings/clock/stm32mp1-clks.h     |  46 ++++----
>   include/dt-bindings/reset/stm32mp1-resets.h   |  24 ++---
>   11 files changed, 503 insertions(+), 37 deletions(-)
>   create mode 100644 arch/arm/boot/dts/stm32mp157a-dk1-scmi.dts
>   create mode 100644 arch/arm/boot/dts/stm32mp157c-dk2-scmi.dts
>   create mode 100644 arch/arm/boot/dts/stm32mp157c-ed1-scmi.dts
>   create mode 100644 arch/arm/boot/dts/stm32mp157c-ev1-scmi.dts
> 

Series applied on stm32-next. Patch[5] has been dropped.

Alex
