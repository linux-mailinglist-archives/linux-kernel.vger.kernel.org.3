Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE7C64CD71B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 16:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240062AbiCDPHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 10:07:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbiCDPHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 10:07:30 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9C21BE132;
        Fri,  4 Mar 2022 07:06:42 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2247SMLb025160;
        Fri, 4 Mar 2022 09:05:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=hHITQXFDQDnRVWlkIt1+iWr/oKBoaKdy+qjH2sz4sAM=;
 b=IsJ8rhNcxyRTNptJtHGf/XKlRes2VmKvXjN4MiC3hXgjc+SCQAGlcP7wFPe5Qiu/cI/d
 lLT+tZo+wdUn+yZM8sTE0XtZBI71J5pJVBNUoIvQhgwFZAOFDZ0y6g0XLn7Nox3FWbsE
 4sDx6JOQH4xHyBsiUYnoKsyMK2yu9A+h41AcllIp3YGJDFC7AiVOOmYFMRJhO+BN/skR
 1f7XFo4WlzsCgJeC+Syi4Wt1UyNLeQBGYlAkTqjNMEkZoqyE5Z/526UyTGgQqfXw9ed7
 ZO5EewpTc/AlXUh3V7gE+UzYM6R7mbdAUB36kKMt1upplO/JrjgKJ3z+UhVIzgZUpAqw Dw== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3ek4j1s3c6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 04 Mar 2022 09:05:57 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 4 Mar
 2022 15:05:55 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Fri, 4 Mar 2022 15:05:55 +0000
Received: from [198.61.65.198] (unknown [198.61.65.198])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 27CBE7C;
        Fri,  4 Mar 2022 15:05:55 +0000 (UTC)
Message-ID: <f4e04900-1451-0b6a-e4c1-cc51cafe9309@opensource.cirrus.com>
Date:   Fri, 4 Mar 2022 15:05:54 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 15/20] hda: cs35l41: Remove unnecessary log
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220303173059.269657-1-tanureal@opensource.cirrus.com>
 <20220303173059.269657-16-tanureal@opensource.cirrus.com>
 <YiD/0ZMcSGVRTZxx@sirena.org.uk>
From:   Lucas tanure <tanureal@opensource.cirrus.com>
In-Reply-To: <YiD/0ZMcSGVRTZxx@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: g_vDq3ATg4q1fK_fIDlsb4DJAWr8jJmS
X-Proofpoint-ORIG-GUID: g_vDq3ATg4q1fK_fIDlsb4DJAWr8jJmS
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/3/22 17:50, Mark Brown wrote:
> On Thu, Mar 03, 2022 at 05:30:54PM +0000, Lucas Tanure wrote:
> 
>> If regmap fails would fail during probe of the device.
> 
> I'm pretty sure circumstances could arise which would break things at
> runtime.
Yes, so instead of not logging that, we can log the last regmap access 
per switch case, instead of all of them.
