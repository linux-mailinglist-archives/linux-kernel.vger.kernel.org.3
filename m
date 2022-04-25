Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA9F50E08B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 14:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241912AbiDYMoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 08:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233100AbiDYMoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 08:44:07 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40795BF305
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 05:40:59 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23PBDYfe013133;
        Mon, 25 Apr 2022 07:40:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=nlr38uaIfr5f4RWN8hQmBrW8tEdm1U6DpwhcPJKbjIk=;
 b=EVV/WeXa1NA0Mz7s/6i5X/Nv3Zt9wSsdvDGGKuaXIYGH1qUwKGntX+d7HrwGv9whgfOu
 3TI8mapVZTLF+lwCQRk0Sn50IW+PMCsNJyp3HJp76JPHIV7134JVEsLTsq1/eHFptxq7
 VEo07JjQ8H28GtHmBX66dMeWxnmejiThx4zmEbv97qEtGQzqFvw14Ln4xAskpJIbbR/2
 9JWJ9RcjxrD4Cf7+27RHBLa2drQh0veId8rOkI8O7H+1Bq7n6til6Qc7tgfOFb59wh2u
 lIJHRjef/b4cW5hIurWg6xWJ5ZNB3k0JiAVp3Lsu2vuZfRxKKvc+S66DTvwW/cwHmrCS 3A== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3fmev31wvx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 25 Apr 2022 07:40:53 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 25 Apr
 2022 13:40:51 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Mon, 25 Apr 2022 13:40:51 +0100
Received: from [10.0.2.15] (AUSNPC0LSNW1.ad.cirrus.com [198.90.251.45])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 215C7478;
        Mon, 25 Apr 2022 12:40:50 +0000 (UTC)
Subject: Re: [PATCH 1/2] ASoC: soc.h: Introduce SOC_DOUBLE_R_S_EXT_TLV() macro
To:     Mark Brown <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Simon Trimmer <simont@opensource.cirrus.com>
References: <20220422160112.3026542-1-rf@opensource.cirrus.com>
 <20220422160112.3026542-2-rf@opensource.cirrus.com>
 <YmaTZEnMAsqtg2FO@sirena.org.uk>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
Message-ID: <b8881338-ae93-7255-6c3f-06e14c61cda7@opensource.cirrus.com>
Date:   Mon, 25 Apr 2022 13:40:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YmaTZEnMAsqtg2FO@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: aYKhTGTQ6zBMc2_AKG8TiGQcx1mIIHMV
X-Proofpoint-GUID: aYKhTGTQ6zBMc2_AKG8TiGQcx1mIIHMV
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 25/04/2022 13:26, Mark Brown wrote:
> On Fri, Apr 22, 2022 at 05:01:11PM +0100, Richard Fitzgerald wrote:
>> From: Simon Trimmer <simont@opensource.cirrus.com>
>>
>> A straightforward extension of the SOC_DOUBLE_R_S_TLV() macro that
>> allows the get and put functions to be customised.
>>
>> Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
>> ---
> 
> You've not provided a Signed-off-by for this so I can't do anything with
> it, please see Documentation/process/submitting-patches.rst for details
> on what this is and why it's important.
> 
Damn, sorry. Would be nice if checkpatch warned about that.
