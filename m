Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97F4C4704F7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 16:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbhLJPzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 10:55:35 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55590 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229664AbhLJPze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 10:55:34 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BAEwQL9030112;
        Fri, 10 Dec 2021 15:51:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=9h0Suuh6azozqVdctcYBsD9tvpl+/5c2N4TxjARfZRs=;
 b=ULN2IbSta6GAn4E50tuDd+gvtJlQlJt5R3ZdmXS22Gsb2BCCzGZ29SikXbM6T1zlvLxm
 XbQOCrN5Yd3BSUBG1o/n7sOx+oCVb2VuK09OolIyMtjjlNC9x+kicXtRd3VFZn9yl2eS
 zkHLGFp5QBIBuxADHg/HHdV9waafTp3I6ZqM1Hg7e5qw+PCCXRBYpewEkWiLbpHDFyix
 Ap7fTebC1rwW9G1f2fQ1PFDsW3AcOegeahjSbGd0T28RkAit/+azGTrCdi2T98Gh3dMC
 hzOv7EhWjqaWKqrnDh/tyeEohbom0ZbOf+k6GJwaB1JXxilu3k9CxuAKYl9AcsFd7KOl 1Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cv94ks3ex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Dec 2021 15:51:42 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BAF0D09006127;
        Fri, 10 Dec 2021 15:51:41 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cv94ks3dy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Dec 2021 15:51:41 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BAFl97A007836;
        Fri, 10 Dec 2021 15:51:39 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 3cqykk4hk6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Dec 2021 15:51:39 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BAFpbe530277910
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Dec 2021 15:51:37 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 35232AE056;
        Fri, 10 Dec 2021 15:51:37 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E8605AE053;
        Fri, 10 Dec 2021 15:51:36 +0000 (GMT)
Received: from osiris (unknown [9.145.166.74])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 10 Dec 2021 15:51:36 +0000 (GMT)
Date:   Fri, 10 Dec 2021 16:51:35 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     Jerome Marchand <jmarchan@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] recordmcount.pl: look for jgnop instruction as well as
 bcrl on s390
Message-ID: <YbN3h7cyC01adiwr@osiris>
References: <20211210093827.1623286-1-jmarchan@redhat.com>
 <alpine.LSU.2.21.2112101054070.5704@pobox.suse.cz>
 <YbMyvJ6gz7LvoXgE@osiris>
 <alpine.LSU.2.21.2112101310080.5704@pobox.suse.cz>
 <alpine.LSU.2.21.2112101321010.5704@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.2112101321010.5704@pobox.suse.cz>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RDcYcGxz1NDRpLRj_7PTHjkzrD_VCFDH
X-Proofpoint-ORIG-GUID: 9laksMIavGTMDEeb0dG4IaZciRsjeNYG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-10_05,2021-12-10_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 spamscore=0 suspectscore=0 impostorscore=0
 mlxlogscore=919 priorityscore=1501 mlxscore=0 bulkscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112100088
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 01:31:23PM +0100, Miroslav Benes wrote:
> > > Otherwise I would be surprised that this would make any difference.
> > 
> > How come? I mean, s390 does not define HAVE_C_RECORDMCOUNT which implies 
> > that recordmcount.pl is used (see scripts/Makefile.build and 
> > BUILD_C_RECORDMCOUNT definition in Makefile).
> 
> Ah, sorry, that was too quick.
> 
> I guess you want to say that recordmcount is not used at all and GCC 
> should do it. Because CONFIG_FTRACE_MCOUNT_USE_RECORDMCOUNT is not set, 
> since FTRACE_MCOUNT_USE_CC should be set.
> 
> What a maze.
> 
> But isn't -mrecord-mcount x86_64-only option?

No, it is (at least) also supported on s390. IIRC that was added with
gcc9. Anyway, this is not too important since the fix makes sense
anyway.
