Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4B5A4842D6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 14:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233886AbiADNxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 08:53:44 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:45228 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233881AbiADNxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 08:53:44 -0500
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 204BGtgI030769;
        Tue, 4 Jan 2022 14:53:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : from : to
 : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=6DXfUuCUuY+kw2PWfLjIaZioIffccgRObgTavevXpBM=;
 b=h0uDtQ8N/c5HFekp/6UCxu5ruxb+Jyi01lZQubNaiCljLFoQYECbME5ByaiTKGQZCOM3
 RHIc8ypH84RblSjrwJLUkKftqJfBG1s5VVgs3q40Tvu3CqUXCf2zqpVhQ7d0tfaT0IaC
 AU6DM/SEGaRxie7DvYdh4X3uTg0Hbtefui30NnF9e34yeLFx7YupqG9t9CrDDb5Y2McX
 ZjBEnh2pyTSp1ovgNWYZxT6BRdGZprqNNWAZIvZk+qqcsfoAZrMfRHPl63NT2a8EPGV0
 MG9ee6lXnPsKEbjEC9pOwEy1uJqFIz3kUs4clYw+78oV6pbbC3A07NYchhA2oiH+GNlD 6w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3dcewm29cn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Jan 2022 14:53:36 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EDC9810002A;
        Tue,  4 Jan 2022 14:53:35 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E5583242426;
        Tue,  4 Jan 2022 14:53:35 +0100 (CET)
Received: from lmecxl0993.lme.st.com (10.75.127.49) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Tue, 4 Jan
 2022 14:53:35 +0100
Subject: Re: [PATCH] drm/stm: ltdc: support of new hardware version
From:   Philippe CORNU <philippe.cornu@foss.st.com>
To:     Yannick Fertre <yannick.fertre@foss.st.com>,
        Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20211203085618.11314-1-yannick.fertre@foss.st.com>
 <73ed4015-c707-53e5-394f-c74cd2f69df2@foss.st.com>
Message-ID: <a7cffc9a-1cf4-8900-22f8-fe2826198b3a@foss.st.com>
Date:   Tue, 4 Jan 2022 14:53:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <73ed4015-c707-53e5-394f-c74cd2f69df2@foss.st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-04_06,2022-01-04_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/14/21 11:19 AM, Philippe CORNU wrote:
> 
> 
> On 12/3/21 9:56 AM, Yannick Fertre wrote:
>> Add support of new hardware version 0x40100.
>>
>> Signed-off-by: Yannick Fertre <yannick.fertre@foss.st.com>
>> ---
>>   drivers/gpu/drm/stm/ltdc.c | 172 ++++++++++++++++++++++++++++++-------
>>   drivers/gpu/drm/stm/ltdc.h |   3 +-
>>   2 files changed, 145 insertions(+), 30 deletions(-)
>>
> 
> Hi Yannick,
> This looks great, many thanks for your patch.
> Acked-by: Philippe Cornu <philippe.cornu@foss.st.com>
> Philippe :-)

Applied on drm-misc-next.
Many thanks for your patch,
Philippe :-)
