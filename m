Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74AE15A2256
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 09:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245686AbiHZHxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 03:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245701AbiHZHxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 03:53:16 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A527DD3EDB;
        Fri, 26 Aug 2022 00:53:14 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27Q4BrUw029243;
        Fri, 26 Aug 2022 09:52:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=ookSdX10s6McVPFxAp5HE80ngw+811erW+VzbFTf1Nw=;
 b=P3WE8Dt00QZ9LjDWdelLsEkE0Cam0tx18Ij0WsIKbYIN+EwQZGGqcco+WTt+rZ151/S/
 bIN0zCoLm69qCnwO7FIlGY7VRTRjkKdFl8Ejh44FStaSYb97cYhhPk8lcPN9CQDJBd8D
 pzhS19GxbZ96uQMcXubQZstUS4M+hM9v9sFx1D9k5AlS+JWJZQLmznUuO9WnKFU6LZdd
 4yGfppIa0+cuDlS1W+HTEjfpnyso6Nn54IZUFE/T40fZEFfp03WKaocPb/biEc0pDAlt
 Q7NkrhPUAL4n0FnQhXR9GWWekcM3BFaGSon+jlF7hGsGHOVEmN//G5ygqnRpMmjs9l3J 0w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3j4w3djv0e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Aug 2022 09:52:53 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D67EF100039;
        Fri, 26 Aug 2022 09:52:51 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D135B215123;
        Fri, 26 Aug 2022 09:52:51 +0200 (CEST)
Received: from [10.201.21.93] (10.75.127.46) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Fri, 26 Aug
 2022 09:52:51 +0200
Message-ID: <c8a72852-3398-fa27-bc11-07342c88fe3d@foss.st.com>
Date:   Fri, 26 Aug 2022 09:52:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/2] ARM: dts: stm32: add i2c in STM32MP13
Content-Language: en-US
To:     Alain Volmat <alain.volmat@foss.st.com>
CC:     <robh+dt@kernel.org>, <mcoquelin.stm32@gmail.com>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <amelie.delaunay@foss.st.com>
References: <20220721152933.3805272-1-alain.volmat@foss.st.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20220721152933.3805272-1-alain.volmat@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_02,2022-08-25_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alain

On 7/21/22 17:29, Alain Volmat wrote:
> This series adds all i2c nodes for the stm32mp131 platform and
> enables i2c1 and i2c5 on the stm32mp135 discovery board.
> 
> Alain Volmat (2):
>    ARM: dts: stm32: add i2c nodes into stm32mp131.dtsi
>    ARM: dts: stm32: enable i2c1 and i2c5 on stm32mp135f-dk.dts
> 
>   arch/arm/boot/dts/stm32mp13-pinctrl.dtsi | 34 +++++++++
>   arch/arm/boot/dts/stm32mp131.dtsi        | 90 ++++++++++++++++++++++++
>   arch/arm/boot/dts/stm32mp135f-dk.dts     | 26 +++++++
>   3 files changed, 150 insertions(+)
> 

Series applied on stm32-next.

Regards
Alex
