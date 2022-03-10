Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E17764D4E0C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 17:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240307AbiCJQBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 11:01:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240692AbiCJQBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 11:01:31 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D277F186417;
        Thu, 10 Mar 2022 08:00:22 -0800 (PST)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22AARWDr023835;
        Thu, 10 Mar 2022 16:59:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=vKPTWN7CzmrHazpB+G2p0y7Va4U2SZ7wiP4CcFo27L4=;
 b=mbLWETh9lhabuPovfTdTMzMya4arO2yMz1UXhe9GgnCEIWVwahrrAd6XpjR2upEjbrtO
 IA9he0LvVvqQeB+rE3E3Uyjny8PUlHGSeEu8sxPcnBqSuHTG50r6b8xxNqw3cwyvrJFb
 xcqGDkXXBvvtF2uZC9gFNOU7O6eoDAKgE0DENaNAHK3Lg0sQ8onyfXu32sikp3p56Gt5
 aYo27q4ipsZDOWfkJHbkRn83HHaJpsqO/8iKF+kbPFkTssiADh6JF3PwHayjPwlXMML/
 P+t/mK85RMlNYtYb3d78vlel950EFltAg0Qq2OHIE9WRERHJeFpVtqjWHuFbIdD9ZFyv 8Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ekymmt5sg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Mar 2022 16:59:31 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C558210002A;
        Thu, 10 Mar 2022 16:59:29 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B135A2309E5;
        Thu, 10 Mar 2022 16:59:29 +0100 (CET)
Received: from [10.211.5.119] (10.75.127.51) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Thu, 10 Mar
 2022 16:59:28 +0100
Message-ID: <b465353f-9291-f159-ba0b-4cd9577fc676@foss.st.com>
Date:   Thu, 10 Mar 2022 16:59:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/3] dt-bindings: mmc: mmci: add a property to disable DMA
 LLI
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ludovic Barre <ludovic.barre@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Marek Vasut <marex@denx.de>, <kernel@dh-electronics.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Grzegorz Szymaszek <gszymaszek@short.pl>
References: <20220304135134.47827-1-yann.gautier@foss.st.com>
 <20220304135134.47827-2-yann.gautier@foss.st.com>
 <CAPDyKFq_TsBLjW2WxC-Fvu6qDs9MJ1=QPo9gOLRykJ5p2pJbGw@mail.gmail.com>
From:   Yann Gautier <yann.gautier@foss.st.com>
In-Reply-To: <CAPDyKFq_TsBLjW2WxC-Fvu6qDs9MJ1=QPo9gOLRykJ5p2pJbGw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-10_06,2022-03-09_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/22 11:57, Ulf Hansson wrote:
> Hi Yann,
> 
> On Fri, 4 Mar 2022 at 14:52, Yann Gautier <yann.gautier@foss.st.com> wrote:
>>
>> On STMicroelectronics variant of PL18x, the DMA Linked Lists are supported
>> starting from revision v2 of the peripheral. But it has limitations,
>> as all the buffers should be aligned on block size (except the last one).
>> But this cannot be guaranteed with SDIO. We should then have a property
>> to disable the support of LLI.
> 
> Indeed, the buffer handling with SDIO is somewhat special, which also
> has been discussed several times on LKML before. In principle, we need
> the SDIO func drivers to respect buffer limitations that should be
> specified by the mmc host drivers. Quite similar to what we already
> have for block devices, like ->max_seg_size, ->max_seg, etc, that is
> set per mmc host.
> 
> I realize that implementing something like the above requires bigger
> changes, which is why mmc host drivers instead validates the sglists
> and the elements. In some cases that means returning an error code and
> in others it could mean falling back to a non-DMA based I/O mode.
> 
> For the stm32_sdmmc variant, it looks like the sglist validation is
> being managed in sdmmc_idma_validate_data() already. Can it be
> extended to cover this case too, rather than using a DT property?
> 
> Kind regards
> Uffe

Hi Ulf,

OK, I'll check what can be done for this. Patches 1 and 2 can be 
dropped, they will be reworked.
But patch 3 of this series could be taken, as not linked to LLI 
management. Should I push it again alone, or could you review it directly?

Best regards,
Yann

> 
>>
>> Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
>> ---
>>   Documentation/devicetree/bindings/mmc/arm,pl18x.yaml | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml b/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
>> index 1e69a5a42439..309a2c0426e5 100644
>> --- a/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
>> +++ b/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
>> @@ -145,6 +145,11 @@ properties:
>>         driver to sample the receive data (for example with a voltage switch
>>         transceiver).
>>
>> +  st,disable-dma-lli:
>> +    $ref: /schemas/types.yaml#/definitions/flag
>> +    description: ST Micro-specific property, disable DMA linked lists.
>> +      It is used for SDIO.
>> +
>>     st,cmd-gpios:
>>       maxItems: 1
>>       description:
>> --
>> 2.25.1
>>

