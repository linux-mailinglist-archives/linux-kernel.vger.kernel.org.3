Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19BCC5234D4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 15:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244252AbiEKN6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 09:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241773AbiEKN6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 09:58:04 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E565459311
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 06:58:02 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24BCpef1022202;
        Wed, 11 May 2022 08:57:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=TN8RR9EaBO+hAhlVbIdyqpYrWj8bS16Ite1oDdSN+R8=;
 b=bCLVtnRDzVgxcm9i2sRIv2/xJQrZNM2POoWHfNHsHx1vuOXPWgFW9NaBliGQG5frp90j
 q1SF3UujTLuNaLc+0tmBzVJqvBVfLgO5xfbNuYTE1NoOANa8Jo3AO/ltIJxvgPzrk6l+
 1s8z9dG2jYhuA9LeZsrmd8+dzrWmigAr04KDQUKoeIN2dkeyhDhhgU9DvTsMLrKj4SAp
 76bct/3cAiANvHT7hiXtz7zkCox2vQEkZ3Fg3UBIIfNgWGjtKLQtgpOulV0pmUUn569B
 y5rouiGSpv4gwf7CnjFbmzrTQg5fbEZ3iSSujUKxu2+xF6rWM+8q6DfgFrFAzpWYwnXe 1A== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3fwn6nx1fd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 11 May 2022 08:57:08 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 11 May
 2022 14:57:07 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Wed, 11 May 2022 14:57:07 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 047F9B10;
        Wed, 11 May 2022 13:57:07 +0000 (UTC)
Date:   Wed, 11 May 2022 13:57:07 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Takashi Iwai <tiwai@suse.de>
CC:     Vitaly Rodionov <vitalyr@opensource.cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: Re: [PATCH v2 10/26] ALSA: hda: hda_cs_dsp_ctl: Add Library to
 support CS_DSP ALSA controls
Message-ID: <20220511135707.GH38351@ediswmail.ad.cirrus.com>
References: <20220509214703.4482-1-vitalyr@opensource.cirrus.com>
 <20220509214703.4482-11-vitalyr@opensource.cirrus.com>
 <s5hzgjofacn.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <s5hzgjofacn.wl-tiwai@suse.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: b3RPXGFwwriDeFA5r8doCCs5lwSCDkNo
X-Proofpoint-GUID: b3RPXGFwwriDeFA5r8doCCs5lwSCDkNo
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 03:49:12PM +0200, Takashi Iwai wrote:
> On Mon, 09 May 2022 23:46:47 +0200,
> Vitaly Rodionov wrote:
> > 
> > From: Stefan Binding <sbinding@opensource.cirrus.com>
> > 
> > The cs35l41 part contains a DSP which is able to run firmware.
> > The cs_dsp library can be used to control the DSP.
> > These controls can be exposed to userspace using ALSA controls.
> > This library adds apis to be able to interface between
> > cs_dsp and hda drivers and expose the relevant controls as
> > ALSA controls.
> 
> Hmm, quite lots of things aren't explained here.
> 
> First off, as far as I see, the control elements that are implemented
> in this patch are pretty unique, they don't follow the standard way.
> Admittedly, ASoC core (ab)uses the TLV read/write for the arbitrary
> data bytes, and this seems following that instead.  If so, it needs
> more clear explanation in the comments add/or commit logs.
> 

Hm... yes I think we should be very clear on if the TLV support
is needed here. This should only be needed if the firmware has
controls (and we need to use those controls) over 512 bytes, and
most firmwares don't. Can we check this and remove the TLV
support if we can? We probably don't want to add more users of
that stuff if we can help it.

Thanks,
Charles
