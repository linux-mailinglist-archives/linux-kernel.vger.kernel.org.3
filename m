Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE1C5690B0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 19:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233736AbiGFR3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 13:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232592AbiGFR3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 13:29:39 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E5124094;
        Wed,  6 Jul 2022 10:29:38 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 266Ba5bg030505;
        Wed, 6 Jul 2022 10:29:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=date : from : to :
 cc : subject : in-reply-to : message-id : references : mime-version :
 content-type : content-id; s=pfpt0220;
 bh=1aRcRc2MiqHaKIAzJ+cFeflVMoGoOhtzVjNSZGQzyA0=;
 b=T8jGquzAXqnVhdnLz/okNaGudB3WgCs7wcL1NssaOk1KgE44W6g9V31lQbGU9h4NjLLu
 vYKfe8eJDl0mWlu3OPGdinBn294OfrPfuewyOylTiG7qBlYz90Gfj8N9JvXXJeQPr1L9
 k24pm414FiwfQK2XNeAQVgE4XK+fwkM9FmxllpmS7wNpMImtCJEgbLpHUimYy6AZgvYx
 60n8hPlsuJ2QvXh6m/QcbDireUHBc1CuJloRb65b9waMnqp97AV8R0FJb4ewVw0wvwbx
 uxR6eMXGfLONibVdF8TVPqrlt3qydB+FuJdrv98vq4MqJe4IoxJJsjfK5JWLBNcEimuS 5g== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3h4yvr3fc1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 06 Jul 2022 10:29:23 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 6 Jul
 2022 10:29:22 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Wed, 6 Jul 2022 10:29:22 -0700
Received: from mvluser05.qlc.com (unknown [10.112.10.135])
        by maili.marvell.com (Postfix) with ESMTP id 0FB1B3F7085;
        Wed,  6 Jul 2022 10:29:22 -0700 (PDT)
Received: from localhost (aeasi@localhost)
        by mvluser05.qlc.com (8.14.4/8.14.4/Submit) with ESMTP id 266HTKTG022898;
        Wed, 6 Jul 2022 10:29:21 -0700
X-Authentication-Warning: mvluser05.qlc.com: aeasi owned process doing -bs
Date:   Wed, 6 Jul 2022 10:29:20 -0700
From:   Arun Easi <aeasi@marvell.com>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
CC:     Tony Battersby <tonyb@cybernetics.com>,
        Saurav Kashyap <skashyap@marvell.com>,
        Nilesh Javali <njavali@marvell.com>,
        <GR-QLogic-Storage-Upstream@marvell.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <regressions@lists.linux.dev>
Subject: Re: [EXT] Re: [REGRESSION] qla2xxx: tape drive not removed after
 unplug FC cable
In-Reply-To: <30feb08e-83d0-34e2-06bb-40f4960c8be4@leemhuis.info>
Message-ID: <3b2c7bd3-06e9-a11e-a44c-905540a2fa69@marvell.com>
References: <baef87c3-5dad-3b47-44c1-6914bfc90108@cybernetics.com>
 <alpine.LRH.2.21.9999.2205271524460.4730@mvluser05.qlc.com>
 <5bcb5963-9da0-fd59-45c5-d27af02e7748@leemhuis.info>
 <178e4e7a-64fc-a442-cdda-45100eaebda0@cybernetics.com>
 <alpine.LRH.2.21.9999.2206211156470.4730@mvluser05.qlc.com>
 <d41671b4-8d29-b940-da37-b8dbe81f4d72@cybernetics.com>
 <alpine.LRH.2.21.9999.2206221557150.4730@mvluser05.qlc.com>
 <30feb08e-83d0-34e2-06bb-40f4960c8be4@leemhuis.info>
MIME-Version: 1.0
Content-Type: multipart/mixed;
        boundary="1879738122-1102453863-1657064255=:3483"
Content-ID: <a5286f37-27ed-8a76-61ee-9530d32f91c0@marvell.com>
X-Proofpoint-GUID: zW8s8bgT1p6OHHGfv3a-T6yw7N02hK_H
X-Proofpoint-ORIG-GUID: zW8s8bgT1p6OHHGfv3a-T6yw7N02hK_H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-06_09,2022-06-28_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--1879738122-1102453863-1657064255=:3483
Content-Type: text/plain; charset="ISO-8859-7"
Content-Transfer-Encoding: 8BIT
Content-ID: <11e5aaee-c6cc-5cba-d062-ddb3962c129e@marvell.com>

Hi Thorsten,

On Mon, 4 Jul 2022, 5:06am, Thorsten Leemhuis wrote:

> On 23.06.22 01:03, Arun Easi wrote:
> > On Wed, 22 Jun 2022, 7:56am, Tony Battersby wrote:
> > 
> >> On 6/21/22 18:05, Arun Easi wrote:
> >>> Thanks for the info. Just to reiterate, you've reported two issues (though 
> >>> this log was showing only 1 of them).
> >>>
> >>> Issue 1 - Tape device never disappears when removed
> >>> Issue 2 - When a direct connected tape 1 was replaced with tape 2, tape 2 
> >>>           was not discovered.
> >>>
> >>> For Issue-2, please try the attached patch. This may not be the final fix, 
> >>> but wanted to check if that would fix the issue for you.
> >>>
> >>> For Issue-1, the behavior was intentional, though that behavior needs 
> >>> refinement. These tape drives support something called FC sequence level 
> >>> error recovery (added in FCP-2), which can make tape I/Os survive even 
> >>> across a short cable pull. This is not a simple retry of the I/O, rather a 
> >>> retry done at the FC sequence level that gives the IO a better chance of
> >>> revival. In other words, the said patch that caused regression, while 
> >>> introduces an incorrect reporting of the state of the device, makes backup 
> >>> more resilient.
> >>>
> >>> Now, onto the behavior when device state is reported immediately. What we 
> >>> have observed, at least with one tape drive from a major vendor, is that, 
> >>> across a device loss and device back case with both the events reported to 
> >>> upper layers, the backup operation was getting failed. This is due to a 
> >>> REPORT LUNS command being issued during device reappearance reporting 
> >>> (fc_remote_port_add -> SCSI scan), which the tape drive was not expecting 
> >>> and caused the backup to fail.
> >>>
> >>> I know that some tape drives do not support multiple commands to it at the 
> >>> same time, but not sure if that is still the norm these days.
> >>>
> >>> So, perhaps one way to make the behavior better, is to either report the 
> >>> disappearing device a bit delayed or have intelligence added in SCSI scan 
> >>> to detect ongoing tape IO operations and delay/avoid the REPORT LUNs. 
> >>> Former is a more contained (in the LLD) fix.
> >>>
> >>> Regards,
> >>> -Arun
> >>
> >> Your patch does fix Issue-2 for me.  For Issue-1, it would be fine with
> >> me if qla2xxx reported device removal to the upper level a bit delayed,
> >> as you said.
> >>
> > 
> > Thanks for testing and verifying the patch.
> 
> BTW, that patch should have 'Link:' tags pointing to all reports about
> this issue, e.g. the start of this thread.

Thanks, will add, I was not aware of this.

> 
> These tags are important, as they allow others to look into the
> backstory now and years from now. That is why they should be placed in
> cases like this, as Documentation/process/submitting-patches.rst and
> Documentation/process/5.Posting.rst explain in more detail.
> Additionally, my regression tracking bot ¡regzbot¢ relies on these tags
> to automatically connect reports with patches that are posted or
> committed to fix the reported issue. BTW, let me tell regzbot to monitor
> this thread:
> 
> > We will post the patch upstream after due testing.
> That was more than two weeks ago now and I didn't see any progress. Or
> did I miss it?

No, the fix is being prepared to be posted.

Regards,
-Arun
--1879738122-1102453863-1657064255=:3483--
