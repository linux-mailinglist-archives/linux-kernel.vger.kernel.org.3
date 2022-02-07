Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09EA54AB85C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 11:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243836AbiBGKHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 05:07:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353161AbiBGJvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 04:51:38 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEFD8C0401EB;
        Mon,  7 Feb 2022 01:51:29 -0800 (PST)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21778x1Q010779;
        Mon, 7 Feb 2022 10:15:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=Kkqvjurj574bD6gSsyenZFngomf2r4egE+kYpU9wKEE=;
 b=5RJjR3tqCnt97bpxcyy+Jfq4LrcLWOw7zRdNgCz1Ly3ZIjEmiRymDYVlrTLwMfELyrVA
 05sHR8zK2e0GD7vh1ifN4HtvOW4rQCcNJO2zdhiD1lGgjTt1Dzflk4gd7rSSZGySh9rw
 pLqYAbECREKnRHD/01y2o+jF4npbtUJjkMJtI2fedNCpAtz0JaGjdY5U4qllZLYZ+bXa
 ryDbvT+5g8xlDnJt0x8jNTx72yxHFJwdYVdNkW31n3ao9ZVjgDxoz0yD0RoRQv81HWlW
 U+6tk2udkrqD7c74cqFaqgCIcw7/d+MnF8NqcWJmbh+zQE5xWw71L10Myu9t4vObzr9g PQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3e2fg5k7pr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Feb 2022 10:15:19 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1227F10002A;
        Mon,  7 Feb 2022 10:15:17 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E30B9212FDF;
        Mon,  7 Feb 2022 10:15:17 +0100 (CET)
Received: from [10.48.0.252] (10.75.127.46) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Mon, 7 Feb
 2022 10:15:16 +0100
Message-ID: <6d60031b-2164-bdda-1048-ec047d9bd59e@foss.st.com>
Date:   Mon, 7 Feb 2022 10:15:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 0/2] ARM: dts: stm32: remove timer duplicate unit-address
 on stm32f4 series
Content-Language: en-US
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>, <robh+dt@kernel.org>
CC:     <olivier.moysan@foss.st.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <1638959596-6656-1-git-send-email-fabrice.gasnier@foss.st.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <1638959596-6656-1-git-send-email-fabrice.gasnier@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.46]
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

Hi Fabrice

On 12/8/21 11:33, Fabrice Gasnier wrote:
> Remove a series of warnings seen when building with W=1, like:
> Warning (unique_unit_address): /soc/timer@40000c00: duplicate unit-address
> (also used in node /soc/timers@40000c00)
> 
> This approach is based on some discussions[1], to restructure the dtsi
> and dts files.
> [1] https://lore.kernel.org/linux-arm-kernel/Yaf4jiZIp8+ndaXs@robh.at.kernel.org/
> 
> Fabrice Gasnier (2):
>    ARM: dts: stm32: remove some timer duplicate unit-address on stm32f4
>      series
>    ARM: dts: stm32: remove timer5 duplicate unit-address on stm32f4
>      series
> 
>   arch/arm/boot/dts/stm32429i-eval.dts  | 12 +++++++++
>   arch/arm/boot/dts/stm32f429-disco.dts | 12 +++++++++
>   arch/arm/boot/dts/stm32f429.dtsi      | 47 -----------------------------------
>   arch/arm/boot/dts/stm32f469-disco.dts | 12 +++++++++
>   4 files changed, 36 insertions(+), 47 deletions(-)
> 

Series applied on stm32-next.

Thanks
Alex
