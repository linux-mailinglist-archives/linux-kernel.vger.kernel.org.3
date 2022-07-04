Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9EE7565425
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 13:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbiGDLxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 07:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbiGDLx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 07:53:29 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B671ADF28
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 04:53:28 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2645YF5s002060;
        Mon, 4 Jul 2022 06:53:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=DNyud5K4ghlezs6swnRJYIUdOSfX+uIaXXgVmZOwlxc=;
 b=L2Pi+D++f0ZwG1FT10P9rpV1fJQ+pww2wAVKuMETSBbP/mtFTZ9jcERsZgNnAm6K2vgL
 q4kd2ayFK3xxUbERUbfqVN6ZY4A/y6y8/P3K0YwnnT/WTYoNMiQLYkw0X1kkcJS1I17X
 A6H2QyiJsYOmDuJP539RHQm3s154KgrqBHZaK2DhE/yDG6Gpqwz448jmLwZXJ52kvegh
 RFs4giLoKW/hkEvbxoPKykheF35VHIji30/i03pdclK+Km/4TpWRDJEkEj9UokbxRnAV
 Eo6gO8YdFl6kOT3cz+pDv5ChtjOput2iez/uoqVFbpEiDpdfG2tw+W5nbts/QPQxNZ5s 7w== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3h2ke3j5qs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 04 Jul 2022 06:53:27 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 4 Jul
 2022 12:53:25 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Mon, 4 Jul 2022 12:53:25 +0100
Received: from [198.90.202.50] (unknown [198.90.202.50])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 001872A9;
        Mon,  4 Jul 2022 11:53:24 +0000 (UTC)
Message-ID: <3ff6da61-ce75-56cd-9cd9-7601d75ef74e@opensource.cirrus.com>
Date:   Mon, 4 Jul 2022 12:53:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] ALSA: hda: add CSC3551 support for UM5302TA
Content-Language: en-US
To:     He X <xw897002528@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
References: <20220703053225.2203-1-xw897002528@gmail.com>
 <f7876785-3895-7494-6d64-7ba64a5d290d@opensource.cirrus.com>
 <CAPG2z084-Kzc3mSF9iO-hWxUCvqmHpXZ1eyMNzGaG4tVfATqzw@mail.gmail.com>
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
In-Reply-To: <CAPG2z084-Kzc3mSF9iO-hWxUCvqmHpXZ1eyMNzGaG4tVfATqzw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 8kosGjRi-fvmIXt0vTi6WKuUaIBypGct
X-Proofpoint-GUID: 8kosGjRi-fvmIXt0vTi6WKuUaIBypGct
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/4/22 12:05, He X wrote:
>> Before accepting any new laptops to be supported, we would like to get
> the Firmware support merged first.
>
> You mean if the firmware is loaded, the ACPI will be fixed?

No. I mean that we are in the middle of merging the Firmware support in 
this driver,

so would like to wait for that to finish before accepting any other 
patch for this driver.

>
> But I have no idea where the firmware is. I can not find it in the
> audio driver. Any advice for that?
>
> Thanks
>
> He Wang
