Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E75FD4ABF72
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 14:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448541AbiBGNLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 08:11:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392199AbiBGMIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 07:08:39 -0500
X-Greylist: delayed 98 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 04:01:26 PST
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36270C03FEC8;
        Mon,  7 Feb 2022 04:01:25 -0800 (PST)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2179FfGc007141;
        Mon, 7 Feb 2022 12:57:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=wkola+8NHOUeci6BL9R7HWr0Ol8gFmoM9m2H0WsXXDU=;
 b=sXhijxibbheFKoQO5MsAVP3hEVT/FA1WLrm5HONuzT/QnD6h1m3XO/DobKDKsWlOhfH1
 tRFtHxPC+t7Ws/OWxG5zBkfp18apG7WN7mRB6WaYrllJPly9p/rK/H1+p441TQquX+6/
 +Z3XVO1Wa22x++0uA2b29EX1lARuXruUDnGqZKx7l3wyVqRFFZOVyyf8nDB5VVdUIDID
 eAeJxLI+9km+2aQW+aguC83wt0CB86xa0PpvjbISjiBXvoKQ8wfJupez0EjVVUzOgYsf
 v5PF/FATTD+TFeL/sFT18mHni2QHcgiBgRuELQuVGOX92dRtF7I8rB6BU5z44A05ug/r kg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3e30mxrtuw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Feb 2022 12:57:38 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id ABCBC10002A;
        Mon,  7 Feb 2022 12:57:37 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A4FC42194D8;
        Mon,  7 Feb 2022 12:57:37 +0100 (CET)
Received: from [10.48.0.252] (10.75.127.46) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Mon, 7 Feb
 2022 12:57:37 +0100
Message-ID: <8e5057e7-62e4-bb94-8cd2-13517fd72ff2@foss.st.com>
Date:   Mon, 7 Feb 2022 12:57:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 0/2] Add DMA and MDMA support on STM32MP13x SoC family
Content-Language: en-US
To:     Amelie Delaunay <amelie.delaunay@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220201160506.348701-1-amelie.delaunay@foss.st.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20220201160506.348701-1-amelie.delaunay@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-07_04,2022-02-07_02,2021-12-02_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amélie

On 2/1/22 17:05, Amelie Delaunay wrote:
> This patchset enables DMA1 and DMA2 routed on DMAMUX1, and MDMA on
> STM32MP13.
> 
> Amelie Delaunay (2):
>    ARM: dts: stm32: add DMA1, DMA2 and DMAMUX1 on STM32MP13x SoC family
>    ARM: dts: stm32: add MDMA on STM32MP13x SoC family
> 
>   arch/arm/boot/dts/stm32mp131.dtsi | 54 +++++++++++++++++++++++++++++++
>   1 file changed, 54 insertions(+)
> 

Series applied on stm32-next.

Thanks
Alex
