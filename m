Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86D2C495DE6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 11:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbiAUKnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 05:43:01 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42432 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229828AbiAUKnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 05:43:00 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20L8GmQr024140;
        Fri, 21 Jan 2022 10:42:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=wjVmRjY5/HzxdiRMhpvDS0AZ7vpcmpFq4APogwzM44M=;
 b=YOXUpSmCOxppQ8pQ4uXI4jz8t8DuwvHt3I4gYhn4yeVX1IkQmSs1Rzj53NQhxxukWGHT
 4JQnYG2vdCOyz5UVVdg0EN56zO3gKURKNHs6vnv4AHjYsbNQG9cwyXUIYnttZ8tALkOu
 SLcIEkJdwYK4F/wOiqYX2WhBMFYLvlZXX7jE8ym0iZTDbF2PGENNLDWcue1i5wsNc+zu
 zL6g9hwaJZmUGML7WSydb4QIkLDtjrFNmqAFtDX/NeDLIzCvJ+oK31Byirnge79eCeJN
 Gmfci/ytc+Nqae5YcxF5OgGImQq3HbCUa0qEE+LQM9BE/p2DkEN8i8ch5ndgy9VhEFVZ 8A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dqs6ajqrt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jan 2022 10:42:35 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20LAceWw005204;
        Fri, 21 Jan 2022 10:42:35 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dqs6ajqra-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jan 2022 10:42:34 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20LAW10x031503;
        Fri, 21 Jan 2022 10:42:32 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 3dqjm7bhqs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jan 2022 10:42:32 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20LAgUDd43712814
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jan 2022 10:42:30 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ECA005204E;
        Fri, 21 Jan 2022 10:42:29 +0000 (GMT)
Received: from osiris (unknown [9.145.74.142])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 8BB505204F;
        Fri, 21 Jan 2022 10:42:29 +0000 (GMT)
Date:   Fri, 21 Jan 2022 11:42:28 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     Yinan Liu <yinan@linux.alibaba.com>, rostedt@goodmis.org,
        peterz@infradead.org, mark-pk.tsai@mediatek.com, mingo@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v8] scripts: ftrace - move the sort-processing in
 ftrace_init
Message-ID: <YeqOFHNfxKcNXNrn@osiris>
References: <20210911135043.16014-1-yinan@linux.alibaba.com>
 <20211212113358.34208-1-yinan@linux.alibaba.com>
 <20211212113358.34208-2-yinan@linux.alibaba.com>
 <yt9dee51ctfn.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yt9dee51ctfn.fsf@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gtxIhXYXAhCiHTikDPYHtmSUd5jpv1Et
X-Proofpoint-ORIG-GUID: VAHo_vQOnqovOfPpRUnkvV2z8CpKyE9P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-21_06,2022-01-21_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 impostorscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2201210070
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 10:46:36AM +0100, Sven Schnelle wrote:
> Hi Yinan,
> 
> Yinan Liu <yinan@linux.alibaba.com> writes:
> 
> > When the kernel starts, the initialization of ftrace takes
> > up a portion of the time (approximately 6~8ms) to sort mcount
> > addresses. We can save this time by moving mcount-sorting to
> > compile time.
> >
> > Signed-off-by: Yinan Liu <yinan@linux.alibaba.com>
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > ---
> >  kernel/trace/ftrace.c   |  11 +++-
> >  scripts/Makefile        |   6 +-
> >  scripts/link-vmlinux.sh |   6 +-
> >  scripts/sorttable.c     |   2 +
> >  scripts/sorttable.h     | 120 +++++++++++++++++++++++++++++++++++++++-
> >  5 files changed, 137 insertions(+), 8 deletions(-)
> 
> while i like the idea, this unfortunately breaks ftrace on s390. The
> reason for that is that the compiler generates relocation entries for
> all the addresses in __mcount_loc. During boot, the s390 decompressor
> iterates through all the relocations and overwrites the nicely
> sorted list between __start_mcount_loc and __stop_mcount_loc with
> the unsorted list because the relocations entries are not adjusted.
> 
> Of course we could just disable that option, but that would make us
> different compared to x86 which i don't like. Adding code to sort the
> relocation would of course also fix that, but i don't think it is a good
> idea to rely on the order of relocations.
> 
> Any thoughts how a fix could look like, and whether that could also be a
> problem on other architectures?

Sven, thanks for figuring this out. Can you confirm that reverting
commit 72b3942a173c ("scripts: ftrace - move the sort-processing in
ftrace_init") fixes the problem?

This really should be addressed before rc1 is out, otherwise s390 is
broken if somebody enables ftrace.
Where "broken" translates to random crashes as soon as ftrace is
enabled, which again is nowadays quite common.
