Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE924AB81A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 11:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241052AbiBGJsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 04:48:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245311AbiBGJql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 04:46:41 -0500
X-Greylist: delayed 1740 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 01:46:40 PST
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0982CC043181;
        Mon,  7 Feb 2022 01:46:39 -0800 (PST)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2177eoFF028141;
        Mon, 7 Feb 2022 10:46:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=oOSVeuiwVcknZy/uywJxudXEDah2iCuCkHFyhcMZmdY=;
 b=1rQn7010jrDIA5RFqb16ksXRsTaa3Qj53EtAqUiQd2MQKR9ifK/kzSK4oqy+lvdl+eVe
 k9FepXUCrEvLcksBBVmNB0lRC/ey9iALP8IQW9M+gvfdSWGi5BhR59UDnIfygkbsRAL7
 CmUqaIn/XfTIwJpH5LLgM6DRlWDpZQBs5xPzb089c9lMx9InYHpbYz90a0lIEAdvWqqJ
 IcOVCr9HgksQ3AcRS8C2P+LV8AMqVSdVbqctwrqlUZaWeNsTKOu/Un3RovFj9I/JIuaN
 ulizCyvlnIQYQSI/Ig0LkBo++rt+ZCVXgagN4u12l6dTcFHTYx8sjYZAp2dGwSSAsynA mw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3e2fg5kd26-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Feb 2022 10:46:31 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A345A10002A;
        Mon,  7 Feb 2022 10:46:30 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 807962138C1;
        Mon,  7 Feb 2022 10:46:30 +0100 (CET)
Received: from [10.48.0.252] (10.75.127.45) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Mon, 7 Feb
 2022 10:46:29 +0100
Message-ID: <c6091ca7-2c82-7169-4a76-e1506212439a@foss.st.com>
Date:   Mon, 7 Feb 2022 10:46:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 0/2] new emtrion hardware emSBC-Argon
Content-Language: en-US
To:     <reinhold.mueller@emtrion.com>, <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20211209104947.4647-1-reinhold.mueller@emtrion.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20211209104947.4647-1-reinhold.mueller@emtrion.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-07_03,2022-02-07_01,2021-12-02_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinhold

On 12/9/21 11:49, reinhold.mueller@emtrion.com wrote:
> From: Reinhold Mueller <reinhold.mueller@emtrion.com>
> 
> This patch series adds support for the emtrion emSBC-Argon
> 
> Changes
> 
> v2:
> [PATCH 1/2]
> 	- replaced enum by const
> [PATCH 2/2]
> 	- no fixes
> 
> v1:
> [PATCH 0/2]
> 	- split former patch in dts -and yaml patches
> [PATCH 1/2]
> 	- no fixes
> [PATCH 2/2]
> 	- small modification in subject name
> 	- node name for leds moved to led-X
> 	- update of clocknames removed,
> 		already defined in stm32mp151.dtsi
> 	- removing some unneeded entries status = "disabled"
> 	- moved pin configurations to stm32mp15-pinctrl
> 
> Reinhold Mueller (2):
>    dt-binding: arm/stm32: Add emtrion hardware emSBC-Argon
>    ARM: dts: stm32: Add support for the emtrion emSBC-Argon
> 
>   .../devicetree/bindings/arm/stm32/stm32.yaml  |   6 +
>   arch/arm/boot/dts/Makefile                    |   1 +
>   arch/arm/boot/dts/stm32mp15-pinctrl.dtsi      |  92 +++
>   arch/arm/boot/dts/stm32mp157c-emsbc-argon.dts |  53 ++
>   .../boot/dts/stm32mp157c-emstamp-argon.dtsi   | 552 ++++++++++++++++++
>   5 files changed, 704 insertions(+)
>   create mode 100644 arch/arm/boot/dts/stm32mp157c-emsbc-argon.dts
>   create mode 100644 arch/arm/boot/dts/stm32mp157c-emstamp-argon.dtsi
> 

Thanks to add new STM32 board! Series applied on stm32-next.

Arnd,
This series introduces new dtbs_check errors mainly because it re-use
nodes from existing STM32 boards. I think it is acceptable to merge it 
as it is not "new' errors but replication of existing errors.

Thanks
Alex
