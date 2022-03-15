Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377C74D9627
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 09:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345889AbiCOI2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 04:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239420AbiCOI17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 04:27:59 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267454BFD7;
        Tue, 15 Mar 2022 01:26:45 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22F4JVqv027247;
        Tue, 15 Mar 2022 09:26:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=oDQ0bPSs1kEQPGA4aIXxaRySi/P2J26ASVpVIJPCOfw=;
 b=eCCUCU3ckkjg9JZogaLrJW4bezRHw/mjZBIHhc9DDxaL78yvZ/BafbdZQPDnl81zrBbw
 oD5Gnarfz/xDPmKyulwxiKLb/EbAgrir1PJgnqCHblXu6B7r2oIUym5/jte3hgVn0ZlC
 niCX3zel4DKTke6eYb2627c/hzZxLkv83G93CX5zcfSvIRDqklqNW817kvikFPt1d401
 A8FBfs3AEfWbl/SO0C4Wc1cnYBa2tTz6iiS+VhI2ezSrgY9NxOnn7GY6y0wCOmikD/Fr
 3SKmphfBhfhbn14vDgjV+W6Hy2LCFfF3DeHYksxjqaeecvvQu6c+4G918U/XsxG8+Z38 bw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3etj2ahghy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Mar 2022 09:26:03 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8560B10002A;
        Tue, 15 Mar 2022 09:26:02 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7B789212FC5;
        Tue, 15 Mar 2022 09:26:02 +0100 (CET)
Received: from [10.201.21.172] (10.75.127.46) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Tue, 15 Mar
 2022 09:26:01 +0100
Message-ID: <0bc53018-fce4-4104-fa47-6e60d2367d69@foss.st.com>
Date:   Tue, 15 Mar 2022 09:26:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/3] dt-bindings: mmc: mmci: add a property to disable DMA
 LLI
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Ludovic Barre <ludovic.barre@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Marek Vasut <marex@denx.de>, <kernel@dh-electronics.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Grzegorz Szymaszek <gszymaszek@short.pl>
References: <20220304135134.47827-1-yann.gautier@foss.st.com>
 <20220304135134.47827-2-yann.gautier@foss.st.com>
 <CACRpkdYQz+-im3n-r0_8RKL7so2bHS=aZobty4BbzixmPzms-Q@mail.gmail.com>
From:   Yann Gautier <yann.gautier@foss.st.com>
In-Reply-To: <CACRpkdYQz+-im3n-r0_8RKL7so2bHS=aZobty4BbzixmPzms-Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-14_14,2022-03-14_02,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/14/22 23:43, Linus Walleij wrote:
> "On Fri, Mar 4, 2022 at 2:52 PM Yann Gautier <yann.gautier@foss.st.com> wrote:
> 
>> On STMicroelectronics variant of PL18x, the DMA Linked Lists are supported
>> starting from revision v2 of the peripheral. But it has limitations,
>> as all the buffers should be aligned on block size (except the last one).
>> But this cannot be guaranteed with SDIO. We should then have a property
>> to disable the support of LLI.
>>
>> Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
> 
> Actually I think this is present also on the ux500 variants. See:
> commit 2253ed4b36dc876d1598c4dab5587e537ec68c34
> "mmc: mmci: Support any block sizes for ux500v2 and qcom variant"
> 
> Spot the variant data "dma_power_of_2".
> 
> So whatever property you add
> to the variant data (not in the device tree please) should
> be added to the ux500 variants as well, it will *VERY* likely
> have a problem with LLI elements not being a power of 2
> as it is the ancestor of later STMicro variants.
> 
> It might actually be the reason for some annoying WiFi error
> messages I have seen :/
> 
> Yours,
> Linus Walleij

Hi Linus,

The STM32 variant uses an internal DMA, and the DMA functions are in its 
dedicated file. So I was planning to do the same as what is done in 
meson-gx-mmc.c: using a bounce buffer to copy from/to in case DMA 
constraints are not fulfilled. Not sure it can help for Ux500.

Ulf, before I send my new series (although it is not ready yet), would 
you be OK with the bounce buffer idea?


Best regards,
Yann
