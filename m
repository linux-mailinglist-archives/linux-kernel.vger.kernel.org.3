Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 105354DC3DA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 11:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbiCQKUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 06:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiCQKUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 06:20:07 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E5CCA0F5;
        Thu, 17 Mar 2022 03:18:47 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22H8AOCs004861;
        Thu, 17 Mar 2022 11:18:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=s0T2J+BUPfq3wtxoi9ptnx4PkAnuCrcogO563PL6A7E=;
 b=tqrYTAk4hJkdazLPqvrldMktXaVm9S42CGuzyXUR+l5dwYSKzFJXJcmWvCl3n/6Zd4oj
 nB68lSvlWf68oH7XFck5WhuVEOTLdPTjFNuJouxs2duli8lL5txwogER8/4avRbIF9gw
 dLJladdVvNk4eePFSSjp7XfbapW34ADQgrnjIwmEW8lYSQtXdYl26zgh10fJGGgPtien
 J3iHVDGmmZC6QAIer+Q+JtV2HW8DPlmS+6IqtxyQlSGOtmm7Kgwwzd7K8QymiRdJgZTb
 1U5eEf3EgbJEdQ9r6aWG0bJGyOcRT18cgI169NWPyrzeVCSjSDQQBM04laO0yP+kECcW oA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3et63jbvmh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Mar 2022 11:18:00 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AFA8910002A;
        Thu, 17 Mar 2022 11:17:58 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9B821215132;
        Thu, 17 Mar 2022 11:17:58 +0100 (CET)
Received: from [10.211.8.11] (10.75.127.47) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Thu, 17 Mar
 2022 11:17:57 +0100
Message-ID: <6bfade04-36b4-98c3-2796-ebeaa230f52e@foss.st.com>
Date:   Thu, 17 Mar 2022 11:17:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/3] dt-bindings: mmc: mmci: add a property to disable DMA
 LLI
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
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
 <0bc53018-fce4-4104-fa47-6e60d2367d69@foss.st.com>
 <CAPDyKFqgQZFH3LT1Z+G9N0MVfhFwoiUr9N2sKFaejTWcH+dNXg@mail.gmail.com>
From:   Yann Gautier <yann.gautier@foss.st.com>
In-Reply-To: <CAPDyKFqgQZFH3LT1Z+G9N0MVfhFwoiUr9N2sKFaejTWcH+dNXg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-17_03,2022-03-15_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/17/22 11:00, Ulf Hansson wrote:
> On Tue, 15 Mar 2022 at 09:26, Yann Gautier <yann.gautier@foss.st.com> wrote:
>>
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
> 

Hi Ulf,

> We already have a bounce buffer in mmci_pio_read(), but we need one in
> mmc_pio_write() too, which hasn't been implemented yet.

The idea is to keep using our internal DMA, and not switch to pio mode.

> 
>>
>> Ulf, before I send my new series (although it is not ready yet), would
>> you be OK with the bounce buffer idea?
> 
> Yes, that works for me.
I have patches almost ready, I'll send that soon.

> 
> On the other hand, it would be even better if we could specify the
> buffer limitations per mmc host instance, so upper layers (SDIO func
> drivers) could conform to these - and use better buffers, to achieve a
> better performance.

We've seen things that could be improved in the wifi driver. I'll check 
what could be done.

Best regards,
Yann
> 
>>
>>
>> Best regards,
>> Yann
> 
> Kind regards
> Uffe

