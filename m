Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC09658237B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 11:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbiG0Jvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 05:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbiG0Jvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 05:51:33 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2AC220E2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 02:51:32 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26R4fJco006636;
        Wed, 27 Jul 2022 04:50:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=HM5eFBZGRCdHvLCsHt6IMA/yn3ZNWVn2pGGu0+bjhKQ=;
 b=aMLXa2610H3t15JJZd2/oDXNpeP6kE9XaYY4WUWkD7jAqFUL8YhzL6pZEdsRlj2hNeLL
 2RXlz3W2uU9DseKxZh70Bb+si4TnQUAtBtF3ccKUakKqDN6GOeIXfH9Am4GXcVnemosD
 0Elmh0RX2uA9isK78wK9QhclNP6XsnzdGDKOT4nqPr1a1uzb8CvYZ6+5DlfDi1zMFVls
 rH4ccCbad034zITNk2uFyMjOvPLmrX7B2HvDLVwLIC/u34YtbycLtUCOOHJYvaZZf79W
 TxvYCP2M8VHM59mbmAzbhKDUYnnKCV9j/bUUPn6sovp5P9+hP97i1EGcEZbIQ4hpE7ob kw== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3hgddp4q3u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Jul 2022 04:50:45 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Wed, 27 Jul
 2022 04:50:43 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1118.9 via Frontend Transport; Wed, 27 Jul 2022 04:50:43 -0500
Received: from [198.61.65.94] (unknown [198.61.65.94])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 3C4272D4;
        Wed, 27 Jul 2022 09:50:43 +0000 (UTC)
Message-ID: <b942ecbb-2334-cd9f-3569-a4dad1504d2b@opensource.cirrus.com>
Date:   Wed, 27 Jul 2022 10:50:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/2] Add support for CLSA0101
Content-Language: en-US
To:     Cameron Berkenpas <cam@neo-zeon.de>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
References: <20220726101131.68058-1-tanureal@opensource.cirrus.com>
 <91e34de4-1c85-073f-9c24-ce3133394fe6@neo-zeon.de>
From:   Lucas tanure <tanureal@opensource.cirrus.com>
In-Reply-To: <91e34de4-1c85-073f-9c24-ce3133394fe6@neo-zeon.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: thaaJHwGFhnlMKE2LYvvBLI2rIGxQiKo
X-Proofpoint-ORIG-GUID: thaaJHwGFhnlMKE2LYvvBLI2rIGxQiKo
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,PDS_OTHER_BAD_TLD,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/22 16:35, Cameron Berkenpas wrote:
> Hello,
> 
> I can confirm this does _not_ work.
> 
> More specifically, with these patches, the original behavior still occurs:
> 1. You get left channel audio from the right speaker only.
Hi, yes, I did forgot the scan and multi instantiate part.
I will send V2 with the fix.

> 2. No sound at all after resuming from sleep.
> 3. You get sound after resuming from hibernate, but only as described in 
> #1.
This is a different issue, that will be fixed in the future.

> 
> If you apply a patch like this: https://paste-bin.xyz/71355
> 
> You  get properly working audio until you put the laptop to sleep or 
> hibernate. Upon resuming from either state, you get no audio at all.
> 
> On 7/26/22 03:11, Lucas Tanure wrote:
>> Add Support for the CLSA0101 laptop, an Intel version of CLSA0100.
>> This patch has been tested using the CLSA0100, ensuring it
>> doesn't break the sound for it.
>> We appreciate it if someone with CLSA0101 could verify that this
>> the patch works for them.
>>
>> Lucas Tanure (2):
>>    ALSA: hda: cs35l41: Use the CS35L41 HDA internal define
>>    ALSA: hda: cs35l41: Support CLSA0101
>>
>>   sound/pci/hda/cs35l41_hda.c   | 67 +++++++++++++++++++++--------------
>>   sound/pci/hda/patch_realtek.c | 12 +++++++
>>   2 files changed, 53 insertions(+), 26 deletions(-)
>>
> 

