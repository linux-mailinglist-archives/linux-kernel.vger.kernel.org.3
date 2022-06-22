Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5FC5556ECB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 01:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376880AbiFVXEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 19:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233622AbiFVXEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 19:04:23 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04EDD3BA72;
        Wed, 22 Jun 2022 16:04:19 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25MFx9RJ005129;
        Wed, 22 Jun 2022 16:04:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=date : from : to :
 cc : subject : in-reply-to : message-id : references : mime-version :
 content-type; s=pfpt0220; bh=Vret8gLknIlhome6Bj5k2433lbzdAz5ReX4y6f/lSS8=;
 b=KXsL1gE/1qUqt5IN/s71ZtD7QOpGGwK9x7roJJJkeXsUMM9yFbaKYhPXtP8j1EOojk36
 kLHznkFFHI4lIIdnrDNRkiWQWINQSDo+dvA8AWCQRxVgoJ7kihNGki0bRATL9HbKj7v9
 V8QwjNAhw4U6YwuZ+Wt5Us+EGZs8j1esy1+fJ0Xj/8NAV01rCc/fp7C7bb9yEYqpyfpA
 QqWAjYUB5i4PeYvkcrJ2kafXcOI2N6FNEj8oJf5tfbJL9YQC+ThmU8nUOlkTpHF/1oLB
 s/7AhD9ZZcJfhagu7j1Wz0Yf0jbDL84M4ZwQOCOpXkEJjOt1SrnkEOaPPNH0JDnHzWgj yg== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3guye7v1gs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 22 Jun 2022 16:04:02 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 22 Jun
 2022 16:04:00 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 22 Jun 2022 16:04:00 -0700
Received: from mvluser05.qlc.com (unknown [10.112.10.135])
        by maili.marvell.com (Postfix) with ESMTP id D36E63F70DC;
        Wed, 22 Jun 2022 16:03:50 -0700 (PDT)
Received: from localhost (aeasi@localhost)
        by mvluser05.qlc.com (8.14.4/8.14.4/Submit) with ESMTP id 25MN3nEA021837;
        Wed, 22 Jun 2022 16:03:49 -0700
X-Authentication-Warning: mvluser05.qlc.com: aeasi owned process doing -bs
Date:   Wed, 22 Jun 2022 16:03:49 -0700
From:   Arun Easi <aeasi@marvell.com>
X-X-Sender: aeasi@mvluser05.qlc.com
To:     Tony Battersby <tonyb@cybernetics.com>
CC:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Saurav Kashyap <skashyap@marvell.com>,
        Nilesh Javali <njavali@marvell.com>,
        <GR-QLogic-Storage-Upstream@marvell.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <regressions@lists.linux.dev>
Subject: Re: [EXT] Re: [REGRESSION] qla2xxx: tape drive not removed after
 unplug FC cable
In-Reply-To: <d41671b4-8d29-b940-da37-b8dbe81f4d72@cybernetics.com>
Message-ID: <alpine.LRH.2.21.9999.2206221557150.4730@mvluser05.qlc.com>
References: <baef87c3-5dad-3b47-44c1-6914bfc90108@cybernetics.com>
 <alpine.LRH.2.21.9999.2205271524460.4730@mvluser05.qlc.com>
 <5bcb5963-9da0-fd59-45c5-d27af02e7748@leemhuis.info>
 <178e4e7a-64fc-a442-cdda-45100eaebda0@cybernetics.com>
 <alpine.LRH.2.21.9999.2206211156470.4730@mvluser05.qlc.com>
 <d41671b4-8d29-b940-da37-b8dbe81f4d72@cybernetics.com>
User-Agent: Alpine 2.21.9999 (LRH 334 2019-03-29)
MIME-Version: 1.0
Content-Type: multipart/mixed;
        boundary="1879738122-1333578364-1655939030=:4730"
X-Proofpoint-GUID: M9G7T-WcRHLfZ2tM46pAgif6uF0_ZHqW
X-Proofpoint-ORIG-GUID: M9G7T-WcRHLfZ2tM46pAgif6uF0_ZHqW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-22_08,2022-06-22_03,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--1879738122-1333578364-1655939030=:4730
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT

Hi Tony,

On Wed, 22 Jun 2022, 7:56am, Tony Battersby wrote:

> On 6/21/22 18:05, Arun Easi wrote:
> > Thanks for the info. Just to reiterate, you've reported two issues (though 
> > this log was showing only 1 of them).
> >
> > Issue 1 - Tape device never disappears when removed
> > Issue 2 - When a direct connected tape 1 was replaced with tape 2, tape 2 
> >           was not discovered.
> >
> > For Issue-2, please try the attached patch. This may not be the final fix, 
> > but wanted to check if that would fix the issue for you.
> >
> > For Issue-1, the behavior was intentional, though that behavior needs 
> > refinement. These tape drives support something called FC sequence level 
> > error recovery (added in FCP-2), which can make tape I/Os survive even 
> > across a short cable pull. This is not a simple retry of the I/O, rather a 
> > retry done at the FC sequence level that gives the IO a better chance of
> > revival. In other words, the said patch that caused regression, while 
> > introduces an incorrect reporting of the state of the device, makes backup 
> > more resilient.
> >
> > Now, onto the behavior when device state is reported immediately. What we 
> > have observed, at least with one tape drive from a major vendor, is that, 
> > across a device loss and device back case with both the events reported to 
> > upper layers, the backup operation was getting failed. This is due to a 
> > REPORT LUNS command being issued during device reappearance reporting 
> > (fc_remote_port_add -> SCSI scan), which the tape drive was not expecting 
> > and caused the backup to fail.
> >
> > I know that some tape drives do not support multiple commands to it at the 
> > same time, but not sure if that is still the norm these days.
> >
> > So, perhaps one way to make the behavior better, is to either report the 
> > disappearing device a bit delayed or have intelligence added in SCSI scan 
> > to detect ongoing tape IO operations and delay/avoid the REPORT LUNs. 
> > Former is a more contained (in the LLD) fix.
> >
> > Regards,
> > -Arun
> 
> Your patch does fix Issue-2 for me.  For Issue-1, it would be fine with
> me if qla2xxx reported device removal to the upper level a bit delayed,
> as you said.
> 

Thanks for testing and verifying the patch. We will post the patch 
upstream after due testing.

Regards,
-Arun
--1879738122-1333578364-1655939030=:4730--
