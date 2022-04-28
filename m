Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F50A512E37
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 10:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344095AbiD1I3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 04:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344122AbiD1I27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 04:28:59 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECD6972DC
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 01:25:42 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23S85KIx014079;
        Thu, 28 Apr 2022 03:24:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=Pm7r4W1Cm//VcduQTiTK26jaLSZ7r2ZK0U6VdwqHIWA=;
 b=JHmoA1J4Uuq1Ef7gUpLGXwMVvmgOEVlK+pNeFhphAOhoHQ5abU/AgcnXFwHHhVSqtnrN
 xrO4FsZeAka+u1k4Ih6L8gsqOs/LBfk8tjmPpyxtT+AlFsu4AMGD+SSMGidnbZMPdpbp
 tj8BgLo/fgRXxEniXerGvObmR1mhzfBoQKOieQhds58/zs0Z1uS7TvAlgdQ4Mmlt08mr
 nMMvfa366girDwbc6fA2LdXC1VjpoegKVG/mA/5dFQWLaSvjOEDoy//8v1yb1vO+q0aQ
 bWdaJbTtKvgyI5rkrivN381EQv0D2Rd1fItidKO2CznKb+c70LAPDGgU2BdhzcHysW6k zg== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3fprt61uw4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 28 Apr 2022 03:24:57 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 28 Apr
 2022 09:24:56 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Thu, 28 Apr 2022 09:24:56 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 06E5446C;
        Thu, 28 Apr 2022 08:24:56 +0000 (UTC)
Date:   Thu, 28 Apr 2022 08:24:56 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Nicola Lunghi <nick83ola@gmail.com>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: wm8960: Add ACPI support
Message-ID: <20220428082456.GJ38351@ediswmail.ad.cirrus.com>
References: <20220427212916.40145-1-nick83ola@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220427212916.40145-1-nick83ola@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: 48N1y2DSeMR1C6Z9PycqBZyN_VANppph
X-Proofpoint-ORIG-GUID: 48N1y2DSeMR1C6Z9PycqBZyN_VANppph
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 10:29:16PM +0100, Nicola Lunghi wrote:
> HID made of either Wolfson/CirrusLogic PCI ID + 8960 identifier
> 
> This helps enumerate the Waveshare WM8960 WM8960 Hi-Fi Sound
> Card HAT on the Up2 platform.
> 
> The scripts at https://github.com/thesofproject/acpi-scripts
> can be used to add the ACPI initrd overlay.
> 
> This commit is similar to the commit:
> 960cdd50ca9f ("ASoC: wm8804: Add ACPI support")
> 
> Signed-off-by: Nicola Lunghi <nick83ola@gmail.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
