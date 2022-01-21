Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F98A4960F9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 15:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381138AbiAUOcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 09:32:50 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:26636 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351048AbiAUOcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 09:32:47 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20L5gDLg030246;
        Fri, 21 Jan 2022 08:32:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 references : in-reply-to : subject : date : message-id : mime-version :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=JCEvGSRutgn1zFC3u9mSgqGgE4vlOvz4fCTu56u3JTw=;
 b=RsDflDrf0XKHqhNTAJC8VW6MOGUpJBRGBBh2UiiBPkQRMD3ueYK1Vcba06/BBum8ElR3
 fQZX7LJ/Am6NMoTGiiyfjPkv0dwb7w+OqITwLzR1mtACfXiz9Pwl5YBVoa/VhUyokQM0
 2nZLPinVN4ZAjNUcG8KqV5K2S423cMJJ1XPwILGeruJ+E1gHUPjwUAHu9jLUqK/Fly9q
 UcWGN2izxYj/WgkdaHEVABi/rW+rfJmQqLyxaJkFAzz4XiIUP+6DofZW548h7fPaPDna
 EsRoQty6yoHrf8OX5qrjJQJ/NhR1yOyz7ahoEhVRmCM9z3p7JgLCgTR6OPMZs+zgTgFD eA== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3dqhynrnt4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 21 Jan 2022 08:32:27 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 21 Jan
 2022 14:32:25 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Fri, 21 Jan 2022 14:32:25 +0000
Received: from LONN2DGDQ73 (unknown [198.90.238.138])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 7133F45D;
        Fri, 21 Jan 2022 14:32:24 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     'Takashi Iwai' <tiwai@suse.de>
CC:     <platform-driver-x86@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <linux-acpi@vger.kernel.org>,
        'Lucas Tanure' <tanureal@opensource.cirrus.com>,
        "'Rafael J . Wysocki'" <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>, 'Takashi Iwai' <tiwai@suse.com>,
        'Mark Gross' <markgross@kernel.org>,
        'Hans de Goede' <hdegoede@redhat.com>,
        'Mark Brown' <broonie@kernel.org>,
        <patches@opensource.cirrus.com>, <linux-spi@vger.kernel.org>,
        'Len Brown' <lenb@kernel.org>
References: <20220120134326.5295-1-sbinding@opensource.cirrus.com> <20220120134326.5295-9-sbinding@opensource.cirrus.com> <s5ha6fqtokp.wl-tiwai@suse.de>
In-Reply-To: <s5ha6fqtokp.wl-tiwai@suse.de>
Subject: RE: [PATCH v4 8/9] ALSA: hda/realtek: Add support for HP Laptops
Date:   Fri, 21 Jan 2022 14:32:24 +0000
Message-ID: <018c01d80ed3$b5a5a610$20f0f230$@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFrharyhx4ySa1JB46MXi1N1GyrjwJH3znKAcNcDSGtJkEkwA==
Content-Language: en-gb
X-Proofpoint-ORIG-GUID: sOEA562_2qwbgUYCx1ispTGtLe8T2Ttx
X-Proofpoint-GUID: sOEA562_2qwbgUYCx1ispTGtLe8T2Ttx
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Takashi,

> -----Original Message-----
> From: Alsa-devel <alsa-devel-bounces@alsa-project.org> On Behalf Of
> Takashi Iwai
> Sent: 20 January 2022 15:27
> To: Stefan Binding <sbinding@opensource.cirrus.com>
> Cc: platform-driver-x86@vger.kernel.org; alsa-devel@alsa-project.org;
linux-
> acpi@vger.kernel.org; Lucas Tanure <tanureal@opensource.cirrus.com>;
> Rafael J . Wysocki <rafael@kernel.org>; linux-kernel@vger.kernel.org;
> Takashi Iwai <tiwai@suse.com>; Mark Gross <markgross@kernel.org>; Hans
> de Goede <hdegoede@redhat.com>; Mark Brown <broonie@kernel.org>;
> patches@opensource.cirrus.com; linux-spi@vger.kernel.org; Len Brown
> <lenb@kernel.org>
> Subject: Re: [PATCH v4 8/9] ALSA: hda/realtek: Add support for HP Laptops
> 
> On Thu, 20 Jan 2022 14:43:25 +0100,
> Stefan Binding wrote:
> >
> > From: Lucas Tanure <tanureal@opensource.cirrus.com>
> >
> > Add support for two and four CS35L41 using the component
> > binding method
> >
> > Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
> > Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
> 
> I guess this patch won't be applicable until ACPI or other tree syncs
> with the latest Linus tree or sound git tree.  Must this patch be
> merged with other patches?

In order for these laptops to work correctly, it will need all of the
patches merged,
including both this change and the ACPI changes - without the ACPI changes,
some of the amps will not probe.

Thanks,
Stefan



