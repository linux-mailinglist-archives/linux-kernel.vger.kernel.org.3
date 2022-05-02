Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6990A516C45
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 10:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382641AbiEBIoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 04:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349872AbiEBIow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 04:44:52 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EDB96587
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 01:41:24 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 241Ho1GI031550;
        Mon, 2 May 2022 10:41:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=OIm67OrlPR48cgLJCF67IRmcukDJA6gxPswbFRVsEdE=;
 b=xdfccTqUVbsyowR7P/+xUbMdw1lhHJNAlGdZ/xXNY0B361ED92dydtdaOu+V8vQgmdzz
 7iC7asEKuNzuz/kaHwhbwi7Bob72ud0Z1mCOkwNvJMlr9TZyXiJsC7xoM7JoMkYNEHSH
 Cozlq1eYscTtiJZqqFIVbA+1rgFaObWIbfc21MECuhvYohY/jKloA/lW7U3sIzsVVXdq
 iYHFnW3ZxkOCKCZxmtBFjG20TXmXeyxnoQ/F2y3/eyo0zzXbbsVQv+dsMFfw80vwO5Fe
 QfqYC0N+EA/bS6BP0i+PQ6sTFeOyygftKaJYAeA7iMfBuHbtJJLVMG8Th72jywjcP97a 5g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3frthjfbnm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 May 2022 10:41:08 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6322A10002A;
        Mon,  2 May 2022 10:41:00 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5C8F72138F9;
        Mon,  2 May 2022 10:41:00 +0200 (CEST)
Received: from [10.201.21.93] (10.75.127.46) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Mon, 2 May
 2022 10:40:59 +0200
Message-ID: <b86e02aa-ecee-b159-e4c7-b562afefb0ed@foss.st.com>
Date:   Mon, 2 May 2022 10:40:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 0/4] mainline Protonic PRTT1x boards
Content-Language: en-US
To:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        =?UTF-8?B?SsOpcsO0bWUgUG91aWxsZXI=?= <jerome.pouiller@silabs.com>
CC:     <kernel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20220426073511.1160119-1-o.rempel@pengutronix.de>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20220426073511.1160119-1-o.rempel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-02_03,2022-04-28_01,2022-02-23_01
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oleksij

On 4/26/22 09:35, Oleksij Rempel wrote:
> changes v4:
> - reorder prtt1X compatible again
> - remove spaces in stm32mp151a-prtt1c.dts
> 
> changes v3:
> - add silabs,wfx compatible
> - move spi pin configuration to stm32mp15-pinctrl.dtsi
> - move prtt1X compatible in alphabetical order
> - add watchdog and thermal nodes
> 
> changes v2:
> - cleanup mmc nodes
> - disabled dma for uart4 (this is console interface and it should work
>    as simple as possible)
> 
> Oleksij Rempel (4):
>    dt-bindings: arm: stm32: Add compatible strings for Protonic T1L
>      boards
>    dt-bindings: net: silabs,wfx: add prt,prtt1c-wfm200 antenna variant
>    ARM: dts: stm32: stm32mp15-pinctrl: add spi1-1 pinmux group
>    ARM: dts: stm32: add support for Protonic PRTT1x boards
> 
>   .../devicetree/bindings/arm/stm32/stm32.yaml  |   8 +
>   .../staging/net/wireless/silabs,wfx.yaml      |   1 +
>   arch/arm/boot/dts/Makefile                    |   3 +
>   arch/arm/boot/dts/stm32mp15-pinctrl.dtsi      |  15 +
>   arch/arm/boot/dts/stm32mp151a-prtt1a.dts      |  52 +++
>   arch/arm/boot/dts/stm32mp151a-prtt1c.dts      | 304 ++++++++++++++++++
>   arch/arm/boot/dts/stm32mp151a-prtt1l.dtsi     | 229 +++++++++++++
>   arch/arm/boot/dts/stm32mp151a-prtt1s.dts      |  63 ++++
>   8 files changed, 675 insertions(+)
>   create mode 100644 arch/arm/boot/dts/stm32mp151a-prtt1a.dts
>   create mode 100644 arch/arm/boot/dts/stm32mp151a-prtt1c.dts
>   create mode 100644 arch/arm/boot/dts/stm32mp151a-prtt1l.dtsi
>   create mode 100644 arch/arm/boot/dts/stm32mp151a-prtt1s.dts
> 

Series applied on stm32-next.

Regards
Alex
