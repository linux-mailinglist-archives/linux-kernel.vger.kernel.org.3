Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32F37492AFA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 17:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347789AbiARQRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 11:17:19 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:30554 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347583AbiARQRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 11:17:02 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20I6vO3X001618;
        Tue, 18 Jan 2022 10:16:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=fShaulMOHUWz8tEKI+rd+K1ckl8jtOigfm2wqjfeUcU=;
 b=ei9xBm9i+mZNGvTSvs5qadq5EFNq+G27HHCfEFLoPIwE35VfHp/H8WfBVzw8LZQx+48n
 yfF54jRpf0HfaYXBYvmGZjq/VDmSSZ+0DdlTVn8gjXH51iY0ZXxtvgiwOHCjn3HMhw0a
 tEj+5CtINNcVplv1FrLOlz3GP3S+XoX9G71ZKpSDECOXepptLI4DSA60hNFYh9sXZShm
 iyWTvlEdRAZlrCrreztM/Ni2immjXk0HBonP0TFR98xI63eWUN6uAObbkyHb5xHFSRTC
 vAwUygH66WVrMl0pmViImtLPX4iM5sgNu2wQgBITqIV3Dj+e6ChDPFKy5bAmOZ32em8h +A== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3dn8k2sca8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 18 Jan 2022 10:16:53 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 18 Jan
 2022 16:16:51 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Tue, 18 Jan 2022 16:16:51 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id A32C27C;
        Tue, 18 Jan 2022 16:16:51 +0000 (UTC)
Date:   Tue, 18 Jan 2022 16:16:51 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Rob Herring <robh@kernel.org>
CC:     Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>
Subject: Re: ChipIdea USB regression
Message-ID: <20220118161651.GO18506@ediswmail.ad.cirrus.com>
References: <20220114105620.GK18506@ediswmail.ad.cirrus.com>
 <20220114111800.GL18506@ediswmail.ad.cirrus.com>
 <CAL_JsqKWMLi69kXp0fcdqLD039eSPwi=NPkPpOWKy=va1+YXow@mail.gmail.com>
 <20220117092656.GM18506@ediswmail.ad.cirrus.com>
 <20220117095559.GN18506@ediswmail.ad.cirrus.com>
 <CAL_Jsq+x-q_xOctCCVmzNSwGbWa_uipJ84xa1NCZnjhWSn1vVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+x-q_xOctCCVmzNSwGbWa_uipJ84xa1NCZnjhWSn1vVg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: NFuhysMocACvjf6yPN9y8teefl0L9bl4
X-Proofpoint-ORIG-GUID: NFuhysMocACvjf6yPN9y8teefl0L9bl4
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2022 at 08:39:55AM -0600, Rob Herring wrote:
> On Mon, Jan 17, 2022 at 3:56 AM Charles Keepax > <ckeepax@opensource.cirrus.com> wrote:
> > On Mon, Jan 17, 2022 at 09:26:56AM +0000, Charles Keepax wrote:
> > > On Sat, Jan 15, 2022 at 09:55:23AM -0600, Rob Herring wrote:
> > > > On Fri, Jan 14, 2022 at 5:18 AM Charles Keepax > > > > <ckeepax@opensource.cirrus.com> wrote:
> > Ah ok it seems that flag is only currently used by the pinctrl
> > subsystem, didn't realise that was quite so new and not used
> > anywhere. I guess we probably need to add something to the
> > platform device code to use that flag too, if that is the way we
> > want to run with this.
> 
> I pushed a patch[1] for kernel-ci to test if you want to give it a try, too.

Awesome thanks. This seems to fix the issue on my system and
doesn't obviously cause any new issues.

Tested-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
