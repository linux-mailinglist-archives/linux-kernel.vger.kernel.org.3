Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72DC349063B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 11:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238747AbiAQKsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 05:48:31 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:43590 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233756AbiAQKs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 05:48:29 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20H7WQjK008705;
        Mon, 17 Jan 2022 04:47:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=message-id : date :
 mime-version : from : to : subject : references : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=NWU+5VvMON2Rs3VaV3OVIvcyV57zKDXnVQdpixkc4ME=;
 b=m0n8apO1JSgS/k1JNJDxtkZdWhVTpOkLbPl0S4mHw9PLQRYMNYViovBSyze51UXDlVAV
 Qdmw0YZX+AfhoTMQLe/YFauKADYEsu0uHwHqhOBVDke+H2l536mSYtT9OIZWznJr0+bf
 hz4mdYABM7LSSXOBP8HYhWpuwRgn6gca8F6nLoF8PxWPGCis+S8pzu32BjSvAnOK+bMl
 4Q/TjcUs27JGv4S56LFoIKliTIvyZ99kbV7T2ME8vGFRSqTKC+K/GLR6M1oWj4cJ8iyh
 S18yKp2QNmj8W+YMauaNTYg/C6miAwCamSZycYB4K0TJjTpi/wz9n8BaryQZKvcRdkRM RA== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3dkvj5a1rc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 17 Jan 2022 04:47:35 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 17 Jan
 2022 10:47:33 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Mon, 17 Jan 2022 10:47:33 +0000
Received: from [198.61.64.122] (unknown [198.61.64.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id B6133459;
        Mon, 17 Jan 2022 10:47:32 +0000 (UTC)
Message-ID: <605c6a69-0542-458c-2ea0-1ed26f6e28f5@opensource.cirrus.com>
Date:   Mon, 17 Jan 2022 10:47:32 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   <tanureal@opensource.cirrus.com>
To:     Takashi Iwai <tiwai@suse.de>, Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Mark Gross <markgross@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, moderated list:
        "SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ;
Illegal-Object: Syntax error in To: address found on vger.kernel.org:
        To:     ;
                        ^-missing semicolon to end mail group, extraneous tokens in mailbox, missing end of mailbox
Subject: Re: [PATCH 5/5] ACPI / scan: Create platform device for CLSA0100
References: <20220113170728.1953559-1-tanureal@opensource.cirrus.com>
 <20220113170728.1953559-5-tanureal@opensource.cirrus.com>
 <s5hee5a47et.wl-tiwai@suse.de>
 <CAJZ5v0ijGWNd9s-4mrFgK-QbPDhnj2K3DF+Z45t7ckV6ET0hpQ@mail.gmail.com>
 <55cb8127-65e2-4d56-5127-2722c5bfe11f@redhat.com>
 <s5hy23h32mq.wl-tiwai@suse.de>
In-Reply-To: <s5hy23h32mq.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: oMlFO-dp5RMipIYl8hGjZOMBWtcZMljS
X-Proofpoint-GUID: oMlFO-dp5RMipIYl8hGjZOMBWtcZMljS
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/15/22 6:59 AM, Takashi Iwai <tiwai@suse.de> wrote:
> On Fri, 14 Jan 2022 19:56:04 +0100,
> Hans de Goede wrote:
> >
> > Hi,
> >
> > On 1/14/22 18:51, Rafael J. Wysocki wrote:
> >> On Fri, Jan 14, 2022 at 5:19 PM Takashi Iwai <tiwai@suse.de> wrote:
> >>>
> >>> On Thu, 13 Jan 2022 18:07:28 +0100,
> >>> Lucas Tanure wrote:
> >>>>
> >>>> The ACPI device with CLSA0100 is a sound card with
> >>>> multiple instances of CS35L41 connected by I2C to
> >>>> the main CPU.
> >>>>
> >>>> We add an ID to the i2c_multi_instantiate_idsi list
> >>>> to enumerate all I2C slaves correctly.
> >>>>
> >>>> Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
> >>>
> >>> I think it's better to merge this from sound git tree together with
> >>> others in the patch set, presumably for rc1.
> >>>
> >>> It'd be great if ACPI people can take a review and give an ack/nack.
> >>
> >> Hans, what do you think?
> >
> > This patch (5/5) applies on top of:
> >
> > https://lore.kernel.org/linux-acpi/20211210154050.3713-1-sbinding@opensource.cirrus.com/
> >
> > Which still needs some work and which really should be merged
> > through the ACPI tree. IMHO it would be best to simply drop
> > this (5/5) from this series and move it to the v3 of the
> > series which I've linked to above.
> >
> > 1-4 can be merged through the alsa tree independently of 5/5 AFAIK.
> 
> OK, that's fine.
> 
> Lucas, could you submit v3 patches in the suggested way?
Yes, we will do that.
Thanks
> 
> 
> thanks,
> 
> Takashi
> 
