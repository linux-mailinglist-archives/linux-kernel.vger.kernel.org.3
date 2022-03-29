Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 580634EB136
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 18:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239120AbiC2QDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 12:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238372AbiC2QDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 12:03:17 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B7665132F;
        Tue, 29 Mar 2022 09:01:33 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22TAHJ9G029059;
        Tue, 29 Mar 2022 18:00:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=3Yxk1/MIRHxufTH1ZAuAKAEKJlCKfQFMRe3OV5pXA3I=;
 b=M/o4rnHgOdL7/4U054PT4yWWxcHnF+pjF5huaoZOGUf9nzk+ASp8GzUnnId8qszD/+MC
 840HgkW4QN+OtrCW6zLDmGflJ077XWaIshkoc4TjjIqT1TCVVte5x6UxgnKIncNhKnpr
 L22r0/o6kNmm2EFC14mBnotbGVq9gRxGWhcxZfNRKwXyTX/o+OuzQww7t8z8E81nJ6x5
 61IlQ5C706XsFspHaNu/mNVI/M0YzYy7Q5wqkkQT1S3dT5Hu3R1yxl4Rx/cTcwt8lfb2
 yOKfXy/eWy4mxBPlPygVHbn53Jf9NINgkWGQJCdMnWjpASGdkdImos9+yimU5n8Tw1jT Rg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3f1rudbcjk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Mar 2022 18:00:31 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B2FB110002A;
        Tue, 29 Mar 2022 18:00:28 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A356322FA30;
        Tue, 29 Mar 2022 18:00:28 +0200 (CEST)
Received: from [10.201.21.172] (10.75.127.50) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Tue, 29 Mar
 2022 18:00:26 +0200
Message-ID: <71b10ce2-7b87-14d5-c8e4-3a4598c889e0@foss.st.com>
Date:   Tue, 29 Mar 2022 18:00:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/3] dt-bindings: mmc: mmci: add a property to disable DMA
 LLI
Content-Language: en-US
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
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
        Grzegorz Szymaszek <gszymaszek@short.pl>
References: <20220304135134.47827-1-yann.gautier@foss.st.com>
 <20220304135134.47827-2-yann.gautier@foss.st.com>
 <CACRpkdYQz+-im3n-r0_8RKL7so2bHS=aZobty4BbzixmPzms-Q@mail.gmail.com>
 <0bc53018-fce4-4104-fa47-6e60d2367d69@foss.st.com>
 <20220329153114.GA58120@thinkpad>
From:   Yann Gautier <yann.gautier@foss.st.com>
In-Reply-To: <20220329153114.GA58120@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-29_06,2022-03-29_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/22 17:31, Manivannan Sadhasivam wrote:
> On Tue, Mar 15, 2022 at 09:26:01AM +0100, Yann Gautier wrote:
>> On 3/14/22 23:43, Linus Walleij wrote:
>>> "On Fri, Mar 4, 2022 at 2:52 PM Yann Gautier <yann.gautier@foss.st.com> wrote:
>>>
>>>> On STMicroelectronics variant of PL18x, the DMA Linked Lists are supported
>>>> starting from revision v2 of the peripheral. But it has limitations,
>>>> as all the buffers should be aligned on block size (except the last one).
>>>> But this cannot be guaranteed with SDIO. We should then have a property
>>>> to disable the support of LLI.
>>>>
>>>> Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
>>>
>>> Actually I think this is present also on the ux500 variants. See:
>>> commit 2253ed4b36dc876d1598c4dab5587e537ec68c34
>>> "mmc: mmci: Support any block sizes for ux500v2 and qcom variant"
>>>
>>> Spot the variant data "dma_power_of_2".
>>>
>>> So whatever property you add
>>> to the variant data (not in the device tree please) should
>>> be added to the ux500 variants as well, it will *VERY* likely
>>> have a problem with LLI elements not being a power of 2
>>> as it is the ancestor of later STMicro variants.
>>>
>>> It might actually be the reason for some annoying WiFi error
>>> messages I have seen :/
>>>
>>> Yours,
>>> Linus Walleij
>>
>> Hi Linus,
>>
>> The STM32 variant uses an internal DMA, and the DMA functions are in its
>> dedicated file. So I was planning to do the same as what is done in
>> meson-gx-mmc.c: using a bounce buffer to copy from/to in case DMA
>> constraints are not fulfilled. Not sure it can help for Ux500.
>>

Hi Mani,

> 
> Irrelevant to this patch: May I know why the internal DMA cannot be represented
> as a dmaengine driver? We started seeing these internal DMA implementations in
> the other subsystems as well with pointers towards MMC core [1].

As for Prabhakar's answer, the IDMA here is inside our IP, and not used 
in any other IP. So I'm not sure it is really relevant to move that to 
another dmaengine driver.

> 
> Thanks,
> Mani

Best regards,
Yann

> 
> [1] https://lore.kernel.org/all/CA+V-a8tfUgvzPyMe_FHuz=8mmC6dPHP7E=e+nCzOey04vCcAkg@mail.gmail.com/
> 
>> Ulf, before I send my new series (although it is not ready yet), would you
>> be OK with the bounce buffer idea?
>>
>>
>> Best regards,
>> Yann

