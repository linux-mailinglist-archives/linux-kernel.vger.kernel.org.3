Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47AA4DB3B7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 15:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352776AbiCPOxT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 16 Mar 2022 10:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356972AbiCPOxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 10:53:10 -0400
X-Greylist: delayed 350 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 16 Mar 2022 07:51:55 PDT
Received: from mail3.swissbit.com (mail3.swissbit.com [176.95.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C01975F4C6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 07:51:55 -0700 (PDT)
Received: from mail3.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id E48BB463677;
        Wed, 16 Mar 2022 15:46:02 +0100 (CET)
Received: from mail3.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id CC38F4619D1;
        Wed, 16 Mar 2022 15:46:02 +0100 (CET)
X-TM-AS-ERS: 10.149.2.84-127.5.254.253
X-TM-AS-SMTP: 1.0 ZXguc3dpc3NiaXQuY29t Y2xvZWhsZUBoeXBlcnN0b25lLmNvbQ==
X-DDEI-TLS-USAGE: Used
Received: from ex.swissbit.com (SBDEEX02.sbitdom.lan [10.149.2.84])
        by mail3.swissbit.com (Postfix) with ESMTPS;
        Wed, 16 Mar 2022 15:46:02 +0100 (CET)
Received: from sbdeex02.sbitdom.lan (10.149.2.84) by sbdeex02.sbitdom.lan
 (10.149.2.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 16 Mar
 2022 15:46:02 +0100
Received: from sbdeex02.sbitdom.lan ([fe80::e0eb:ade8:2d90:1f74]) by
 sbdeex02.sbitdom.lan ([fe80::e0eb:ade8:2d90:1f74%8]) with mapi id
 15.02.0986.022; Wed, 16 Mar 2022 15:46:02 +0100
From:   =?Windows-1252?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Avri Altman <Avri.Altman@wdc.com>,
        Michael Wu <michael@allwinnertech.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "porzio@gmail.com" <porzio@gmail.com>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        allwinner-opensource-support 
        <allwinner-opensource-support@allwinnertech.com>
Subject: Re: [PATCH] mmc: block: enable cache-flushing when mmc cache is on
Thread-Topic: [PATCH] mmc: block: enable cache-flushing when mmc cache is on
Thread-Index: AQHYNcu3WGf4zsUDOUapUgyqsaCvc6y+ZEOAgAAo/4CAAASLgIADKXiAgAAU4oCAAAVPgIAARzTm
Date:   Wed, 16 Mar 2022 14:46:02 +0000
Message-ID: <7ec0cf3e316a4ed9987962b4cbf01604@hyperstone.com>
References: <20220312044315.7994-1-michael@allwinnertech.com>
 <83edf9a1-1712-5388-a3fa-d685f1f581df@intel.com>
 <88e53cb9-791f-ee58-9be8-76ae9986e0e2@allwinnertech.com>
 <DM6PR04MB6575C3B87DFA920EDCD994CCFC0F9@DM6PR04MB6575.namprd04.prod.outlook.com>
 <32b29790-eb5c-dac0-1f91-aede38220914@allwinnertech.com>
 <DM6PR04MB6575A4A2A687A876EA5C04B7FC119@DM6PR04MB6575.namprd04.prod.outlook.com>,<312d724c-e43f-d766-49fb-9c5b10fe8b07@intel.com>
In-Reply-To: <312d724c-e43f-d766-49fb-9c5b10fe8b07@intel.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.154.1.4]
Content-Type: text/plain;
        charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-8.6.1018-26774.007
X-TMASE-Result: 10--9.729900-10.000000
X-TMASE-MatchedRID: LVkZzMT5mErUL3YCMmnG4vHkpkyUphL9dwX/SSKrKHjVjNsehGf0vQC7
        AZSleJMNLomIDFQh53DZZZGAG9uFDUY/tllaHgmN0oNxPV/0KMTVBDonH99+Vq/bdPGXvkG/Zng
        ixNorteDHyjn2xyeLrBUELlX2mE/eXlJqiTX99kKp3Btb1bH20MnlJe2gk8vIP4H+2nyK0FOK/P
        cAuVLj1ijPeL52ePwPS8AxUE03d7BYp62gPtNXt7/HywF9D+dAZR+OFNkbtdpAbza1VIHIZU7wF
        MoiPJlq4vM1YF6AJbYaC1V1wQ87fFZ0V5tYhzdWxEHRux+uk8jHUU+U0ACZwIT257H9q+85MsP+
        X06aRAtbjgTjpLMNveg6+HNjHuNbnqg/VrSZEiM=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: 18a9737a-b486-407a-8cc0-72a4f22bf289-0-0-200-0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>So we are not going to let the block layer know about SD cache?
>Or is it a separate change?

I have some code for this laying around, but as it requires reading, parsing and writing Function Registers,
in particular PEH, it's a lot of boilerplate code to get the functionality, but I'll clean it up and send a patch in the coming weeks.





From: Adrian Hunter <adrian.hunter@intel.com>
Sent: Wednesday, March 16, 2022 12:28 PM
To: Avri Altman; Michael Wu; ulf.hansson@linaro.org; beanhuo@micron.com; porzio@gmail.com
Cc: linux-mmc@vger.kernel.org; linux-kernel@vger.kernel.org; allwinner-opensource-support
Subject: Re: [PATCH] mmc: block: enable cache-flushing when mmc cache is on
    
On 16.3.2022 13.09, Avri Altman wrote:
>> Hi Avril & Adrian,
>> Thanks for your efforts. Could we have an agreement now --
>>
>> 1. enabling-cache and cmd23/reliable-write should be independent;
>>
>> Here's what I found in the spec JESD84-B51:
>>  > 6.6.31 Cache
>>  > Caching of data shall apply only for the single block
>>  > read/write(CMD17/24), pre-defined multiple block
>>  > read/write(CMD23+CMD18/25) and open ended multiple block
>>  > read/write(CMD18/25+CMD12) commands and excludes any other access
>>  > e.g., to the register space(e.g., CMD6).
>> Which means with CMD18/25+CMD12 (without using CMD23), the cache can
>> also be enabled. Maybe this could be an evidence of the independence
>> between enabling-cache and cmd23/reliable-write?
> Acked-by: Avri Altman <avri.altman@wdc.com>
> 
> Thanks,
> Avri
> 
>>
>> 2. We don't consider supporting SD in this change.
>>
>>  > On 14/03/2022 19:10, Avri Altman wrote:
>>  >> Here is what our SD system guys wrote:
>>  >> " In SD we don’t support reliable write and this eMMC driver may not
>>  >>    be utilizing the cache feature we added in SD5.0.
>>  >>   The method of cache flush is different between SD and eMMC."
>>  >>
>>  >> So adding SD seems to be out of scope of this change.
>>
>> Is there anything else I can do about this patch? Thanks again.

So we are not going to let the block layer know about SD cache?
Or is it a separate change?
    =
Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
Managing Director: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

