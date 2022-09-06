Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFCE5AF6C1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 23:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiIFV0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 17:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiIFV0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 17:26:38 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640DDB517B;
        Tue,  6 Sep 2022 14:26:37 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286EKHq3026593;
        Tue, 6 Sep 2022 14:26:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=date : from : to :
 cc : subject : in-reply-to : message-id : references : mime-version :
 content-type; s=pfpt0220; bh=OTjnHPepJNwapVtBZoQl2SJwt6fD6Cr+0YUCTUwrH+o=;
 b=kpPzIBU5yqiRQ+iMiksiItIOiQYhtto30rgb82XE9u9NduwMDZRp27TCRCwqAIkffN+Z
 ne2KOvnLCQDuZQhT1Bs5zGLwt9p05FlyeMQURia+wCEeYX7PG+CN2esKZOCrmhDAsHPv
 lk4ZPvhjlMgnAXnf/kA8DEjqrUErZg0wvjrdQJo1OXZFp1eOcC7m9iwKsCi5DgK6LJK6
 +PoiSuxQ4CzTqoa671TPV2H8ydMpDq3zaplZY+tbAwB2hkF2huYpKYfG2HXLgNLrc5cP
 BXNoCzbc6YZbdK2oIoV62tCB6nEVJfol/yIbuhudBDPN8yKvPjavkrRH9DVCTpwkcPGu nw== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3jdxjekuq4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 06 Sep 2022 14:26:34 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 6 Sep
 2022 14:26:32 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 6 Sep 2022 14:26:32 -0700
Received: from mvluser05.qlc.com (unknown [10.112.10.135])
        by maili.marvell.com (Postfix) with ESMTP id 9E3DD3F70D3;
        Tue,  6 Sep 2022 14:26:32 -0700 (PDT)
Received: from localhost (aeasi@localhost)
        by mvluser05.qlc.com (8.14.4/8.14.4/Submit) with ESMTP id 286LQVT6024067;
        Tue, 6 Sep 2022 14:26:32 -0700
X-Authentication-Warning: mvluser05.qlc.com: aeasi owned process doing -bs
Date:   Tue, 6 Sep 2022 14:26:31 -0700
From:   Arun Easi <aeasi@marvell.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Nilesh Javali <njavali@marvell.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        <GR-QLogic-Storage-Upstream@marvell.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-next <linux-next@vger.kernel.org>
Subject: Re: [EXT] build failure of next-20220906 due to 8bfc149ba24c ("scsi:
 qla2xxx: Enhance driver tracing with separate tunable and more")
In-Reply-To: <20220906170346.52c3f592@gandalf.local.home>
Message-ID: <e9f5eb5e-3830-d19b-dcb0-05f7a36fcb2d@marvell.com>
References: <YxdZ/9XOsWilvVSd@debian>
 <44fe9ca0-e1d7-1e4f-9fd8-0f48a84dca72@marvell.com>
 <CADVatmMsYk+tgJDASx2uoskLzY=b4m7SNo+3R6SXT=0vEnu+vA@mail.gmail.com>
 <20220906170346.52c3f592@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-GUID: Xmult1u7VXTD-L5qnqYPqxtqIsR50XE5
X-Proofpoint-ORIG-GUID: Xmult1u7VXTD-L5qnqYPqxtqIsR50XE5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Sep 2022, 2:03pm, Steven Rostedt wrote:

> On Tue, 6 Sep 2022 21:57:10 +0100
> Sudip Mukherjee <sudipm.mukherjee@gmail.com> wrote:
> 
> > Thanks, that fixed the build for me. The patch did not apply directly
> > on next-20220906, so I had to modify it a little bit.
> > 
> > Tested-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> 
> Well, the change needs to go into include/linux/trace.h though.
> 

Steve, I was thinking both the fixes stay at least for a short 
term the one in qla2xxx to avoid tree dependencies.

Since, the qla_def.h change goes as:

+#ifndef CONFIG_TRACING
+#ifndef trace_array_get_by_name

..it should co-exist when the "#define trace_array_get_by_name" gets 
merged in include/linux/trace.h. BTW, I will send out the changes to 
trace.h today.

Other alternatives/suggestions welcome.

Regards,
-Arun
