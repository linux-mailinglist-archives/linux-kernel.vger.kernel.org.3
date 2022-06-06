Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48DC253EA57
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233077AbiFFJbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 05:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233057AbiFFJbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 05:31:00 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A541D681C
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 02:30:59 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2565KdFF012652;
        Mon, 6 Jun 2022 04:30:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=dSUqhCTZXHV3N+XZL5p1hy3iq3wKm8e7EJunKldfbbA=;
 b=nb6u/4JYc1CXIX4SlLnBuHHK3INE0YuQqALVJ5alQ8rushYfooq6oVaxZcoEMp3jsiuY
 Ya/f8a0PMgVsHEP5ISLxem7t6fybq7OSbeesDkXeDQFwmR6VVNdjmEOB3MZ3LWxmlZjn
 QT7uOv1DAzkgS8YmeAMnfAqIJYV0dB/3UCYaTNONdYVfMNVcxcbciKggptAkxgABdert
 KJChcotRsjuRE36hspqIxqoW9BYGjMh7+K3Atf+A5y2x5me1XH/EUol8IfOJ0SzzrtjS
 mX/lX7eDOsfHCUtsLscTD8OTjXEQ+mTuVudCfSLX3H8xfrsifLccPK6ERR19kVrKY1lA Ug== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3gg3tq1p30-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 06 Jun 2022 04:30:02 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 6 Jun
 2022 10:30:00 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Mon, 6 Jun 2022 10:30:00 +0100
Received: from [10.0.2.15] (AUSNPC0LSNW1.ad.cirrus.com [198.90.251.45])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id F0C22B10;
        Mon,  6 Jun 2022 09:29:59 +0000 (UTC)
Subject: Re: [PATCH v1 1/1] ASoC: madera: Replace kernel.h with the necessary
 inclusions
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
CC:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
References: <20220603170707.48728-1-andriy.shevchenko@linux.intel.com>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
Message-ID: <1b5ba014-44ca-e753-141a-d8ff5fd248bb@opensource.cirrus.com>
Date:   Mon, 6 Jun 2022 10:29:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220603170707.48728-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: YCcBa_HjJdfFg4ONq-SqjxXb_0YSvico
X-Proofpoint-GUID: YCcBa_HjJdfFg4ONq-SqjxXb_0YSvico
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/06/2022 18:07, Andy Shevchenko wrote:
> When kernel.h is used in the headers it adds a lot into dependency hell,
> especially when there are circular dependencies are involved.
> 
> Replace kernel.h inclusion with the list of what is really being used.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Reviewed-by: Richard Fitzgerald <rf@opensource.cirrus.com>
