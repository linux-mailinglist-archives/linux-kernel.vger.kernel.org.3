Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1C455378C4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 12:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234671AbiE3JJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 05:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232422AbiE3JJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 05:09:47 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C0D45675C
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 02:09:47 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24U6wBOD026011;
        Mon, 30 May 2022 04:08:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=0nnOuY1I043AVIcqJp6idornjjCkVFno4tKetd4mjcg=;
 b=dcA8nd8emnmbSgN94gyFjds6JYlgsnV6WPdItTZqAGW1hPixBmwHDADeSUanEUz6SNHw
 X1CCccxXaGjE9DuhMsr1knSgyhYapF9Tz9VAa8ek7kqD8JHQSD0pVX1OKvTdpUqjKlZj
 mV5pUr8mhzidTHu7V56T67OqLxSJ7VQmJCAopr8Pe6j15RuAqOYRbxZBwerg3NFZXIcg
 2k5OFeUelpgCIEOVqNNmzh8L//7uzyUXTIw6sz3dG5xXPWx4pXkTOeY7Y9pfCNEevvvH
 0ioGmUifskKoDYMkHHUtuloND6a0ecd1PQO+o+TC6Yy/T3VhrkMMdqn/b/jxhHEc9YIb PQ== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3gbh51hk07-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 30 May 2022 04:08:48 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 30 May
 2022 10:08:46 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Mon, 30 May 2022 10:08:46 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id CB8C7468;
        Mon, 30 May 2022 09:08:46 +0000 (UTC)
Date:   Mon, 30 May 2022 09:08:46 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Takashi Iwai <tiwai@suse.de>
CC:     Vitaly Rodionov <vitalyr@opensource.cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 00/17] ALSA: hda: cirrus: Add initial DSP support and
 firmware loading
Message-ID: <20220530090846.GS38351@ediswmail.ad.cirrus.com>
References: <20220525131638.5512-1-vitalyr@opensource.cirrus.com>
 <871qwf0x8t.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <871qwf0x8t.wl-tiwai@suse.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: Mw2lI25xkuV3lPWIZ9LW5Vkodbz5fSRr
X-Proofpoint-ORIG-GUID: Mw2lI25xkuV3lPWIZ9LW5Vkodbz5fSRr
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2022 at 06:13:38PM +0200, Takashi Iwai wrote:
> On Wed, 25 May 2022 15:16:21 +0200,
> Vitaly Rodionov wrote:
> The idea to add / delete controls by the control element change
> doesn't sound good; as already mentioned in my reply to the previous
> patch set, the change of the control elements can be triggered too
> easily by any normal users who have the access to the sound devices.
> It means thousands of additions and removals per second could be
> attacked by any user.
> 

This I am a little less sure how we handle. I mean arn't there
already a few ways to do this? Both the existing ASoC wm_adsp
stuff, and the topology stuff (used on all new Intel platforms,
so very widely deployed) let you create controls by loading a
firmware file. Also within ALSA itself can't user-space create
user ALSA controls? Is there some rate limiting on that? How is
this issue tackled there?

> Moreover, the new controls with TLV controls don't look following the
> standard TLV syntax (type-length-value).  My previous questions about
> the TLV usages are still unanswered, so I'm not sure what impact this
> would have, though.  At least, alsactl behavior must be checked
> beforehand. If this is really device-specific (non-)TLV usages, it has
> to be clearly documented.
> 

The TLV stuff should be completely removed once my latest
comments have been updated. I don't think we need this for the
amps and I would also rather keep the usage to a minimum until
one of us finally gets around to resolving the large control
issues in a way that is more acceptable to everyone (likely
with a new IOCTL).

Thanks,
Charles
