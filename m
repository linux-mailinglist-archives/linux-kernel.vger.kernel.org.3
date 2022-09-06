Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA4E65AF759
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 23:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbiIFVuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 17:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiIFVui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 17:50:38 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA7C8169D;
        Tue,  6 Sep 2022 14:50:36 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286JpqwO024241;
        Tue, 6 Sep 2022 14:50:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=date : from : to :
 cc : subject : in-reply-to : message-id : references : mime-version :
 content-type; s=pfpt0220; bh=jQU6reTeYH+IJprwVs9mmFbt7uN5byGxcZN1tT/HGfU=;
 b=SDsdukzkFs4WA8U76J3JkrWSz18SUTkwZdQngfzMlNc0P018ax1y/eLTgAaE7QV51TVp
 L+M3cYwBzEaVz4ajcCC3YWUjFQbLZq7mEVEwPo1iYeJz6gryonq7r07mJwdkpranSGLL
 m+kJrYxUIQ8ItKXIx47zXqXkx1COrqxzRX8k3gkrfrmbXXUVRa20te0omht8hLlHYJme
 VqA97QiNRQK7O0PwVW2Et1iwhFGLR22R84ivoCGKvXMNxl2L7bD8WtJ7tZm7WhdJnNxL
 VV7b6KHPuCTpXxAXGCm0rcoTb8F/r3+z9L5N/X8dSVeRhTF1NJCnXzF1+9bjUz/7iwMc Lg== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3jc6epua5j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 06 Sep 2022 14:50:34 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 6 Sep
 2022 14:50:31 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Tue, 6 Sep 2022 14:50:31 -0700
Received: from mvluser05.qlc.com (unknown [10.112.10.135])
        by maili.marvell.com (Postfix) with ESMTP id B1A9A3F7096;
        Tue,  6 Sep 2022 14:50:31 -0700 (PDT)
Received: from localhost (aeasi@localhost)
        by mvluser05.qlc.com (8.14.4/8.14.4/Submit) with ESMTP id 286LoVcH024613;
        Tue, 6 Sep 2022 14:50:31 -0700
X-Authentication-Warning: mvluser05.qlc.com: aeasi owned process doing -bs
Date:   Tue, 6 Sep 2022 14:50:30 -0700
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
In-Reply-To: <20220906174140.41b46a5f@gandalf.local.home>
Message-ID: <4f075c88-19b4-f0fd-a735-90a072c70879@marvell.com>
References: <YxdZ/9XOsWilvVSd@debian>
 <44fe9ca0-e1d7-1e4f-9fd8-0f48a84dca72@marvell.com>
 <CADVatmMsYk+tgJDASx2uoskLzY=b4m7SNo+3R6SXT=0vEnu+vA@mail.gmail.com>
 <20220906170346.52c3f592@gandalf.local.home>
 <e9f5eb5e-3830-d19b-dcb0-05f7a36fcb2d@marvell.com>
 <20220906174140.41b46a5f@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-ORIG-GUID: zfBspUCi02Zf9F2IFyByeMPkiCRqAJOK
X-Proofpoint-GUID: zfBspUCi02Zf9F2IFyByeMPkiCRqAJOK
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

On Tue, 6 Sep 2022, 2:41pm, Steven Rostedt wrote:

> On Tue, 6 Sep 2022 14:26:31 -0700
> Arun Easi <aeasi@marvell.com> wrote:
> 
> > Steve, I was thinking both the fixes stay at least for a short 
> > term the one in qla2xxx to avoid tree dependencies.
> > 
> > Since, the qla_def.h change goes as:
> > 
> > +#ifndef CONFIG_TRACING
> > +#ifndef trace_array_get_by_name
> > 
> > ..it should co-exist when the "#define trace_array_get_by_name" gets 
> > merged in include/linux/trace.h. BTW, I will send out the changes to 
> > trace.h today.
> > 
> > Other alternatives/suggestions welcome.
> 
> I doubt I'll have anything that conflicts with an update to
> include/linux/trace.h, as it is seldom modified.
> 
> Just sent a patch out that updates that file and I'll review it, and then
> you can push it through your tree.
> 

Sounds good. Thanks Steve.

Regards,
-Arun
