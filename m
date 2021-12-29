Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8350D481170
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 10:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239620AbhL2JzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 04:55:07 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:7208 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S239614AbhL2JzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 04:55:06 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BT6Ueaw008025;
        Wed, 29 Dec 2021 03:53:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=s5779NgSmZdidPeKYZafjjJtfgHumjhVoJekxPIdq7E=;
 b=DCdrYRyeVjgKSWN/snbvXK2mzwd3bEqoT1HJgQEiWOA0s5yoLOIe9NDwx+a1lW0iOOI3
 MyjHygKXlkdKg7/yXH4Uzmn3xiESfil5ogTyiTh3+pjvKKg8UE36bmrJjP4WK1zx9dN8
 +xqvibk6GD5uXhmFn9wgpVWqrSUJrdf/tdDOqkUp7DIYhbHAcdzWAZ5qrTPE6nxHd3+I
 9zggUTapT/Q+Xto8ocS5MA/VrQF6W9lzLDgtehqjfWLvmmKa3wjwoBPuxxIpZzVKzbtb
 7Q+s/6SQIDDPJrsDj6SRKijhk3dE8zx34MTKALo1HcLA0Gjn/pJkSMTxDpAhblEAzUqU Sw== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3d7ksg9hm9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 29 Dec 2021 03:53:48 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 29 Dec
 2021 09:53:46 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Wed, 29 Dec 2021 09:53:46 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id D68FB46C;
        Wed, 29 Dec 2021 09:53:45 +0000 (UTC)
Date:   Wed, 29 Dec 2021 09:53:45 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH v1 1/1] ASoC: madera: Replace kernel.h with the necessary
 inclusions
Message-ID: <20211229095345.GX18506@ediswmail.ad.cirrus.com>
References: <20211222164534.67636-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211222164534.67636-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: Ay8phJ6Y0cBy97KnS6b_yyWSsb3gnbEK
X-Proofpoint-ORIG-GUID: Ay8phJ6Y0cBy97KnS6b_yyWSsb3gnbEK
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 06:45:34PM +0200, Andy Shevchenko wrote:
> When kernel.h is used in the headers it adds a lot into dependency hell,
> especially when there are circular dependencies are involved.
> 
> Replace kernel.h inclusion with the list of what is really being used.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
