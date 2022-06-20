Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 719FE551428
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 11:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238746AbiFTJUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 05:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240695AbiFTJUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 05:20:01 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6173F10FE0;
        Mon, 20 Jun 2022 02:19:27 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25K7lUEc017255;
        Mon, 20 Jun 2022 09:19:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=FzeBKmN39vXTAfSSfM90CNWpQANatZcaEcbUjiMYvSY=;
 b=MoVF/j1Vl2smv+UDh8BEPve9GWjKd2hYdcL18pUziEHs3Pxs8jkxXRRv4nphDNkkaqT9
 wR75xqc5prUdv2CVOG6difjPSR0Ns7QfPI3EizNp5O9Sq87t/BC3XsA2AAo7F9F68ERS
 LNrqZ7dSSdL+RyobLnxKCpWC99fex5hkbniuy8VN++J1S3zEGH0c+tRxx5hmXGAxJwvP
 5xVAMLvvizD1yvIkjJioOpY+Tmwkv9d2ZAJR4vBWC3Fn8B6E2ZMH0wW8t1sh/s8KZRU7
 2Vsx8/i+iEacDp3F7rI1iuP22Lc3K777lf6fLiOBIbZ8QpRTQyilM1YFcyGHl5yr3kHT 3A== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gsr0uc6c1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jun 2022 09:19:24 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25K95B8V012320;
        Mon, 20 Jun 2022 09:19:22 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04fra.de.ibm.com with ESMTP id 3gs6b8ss58-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jun 2022 09:19:21 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25K9JJAl21430570
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jun 2022 09:19:19 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E6B0511C054;
        Mon, 20 Jun 2022 09:19:18 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 14CF711C04A;
        Mon, 20 Jun 2022 09:19:18 +0000 (GMT)
Received: from osiris (unknown [9.145.85.139])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 20 Jun 2022 09:19:18 +0000 (GMT)
Date:   Mon, 20 Jun 2022 11:19:16 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Christian Borntraeger <borntraeger@linux.ibm.com>
Cc:     Juergen Gross <jgross@suse.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH] s390/kvm: avoid hypfs error message
Message-ID: <YrA7lHb38Sj74+4U@osiris>
References: <20220607123314.10255-1-jgross@suse.com>
 <5431f626-9bd3-ed54-9889-aafbba9ca3e0@suse.com>
 <9ef06123-b44f-b009-5bf5-60ad27bbede7@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9ef06123-b44f-b009-5bf5-60ad27bbede7@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DShGIKbkWfWtWuKs20pnR-ESL0UlFJZJ
X-Proofpoint-ORIG-GUID: DShGIKbkWfWtWuKs20pnR-ESL0UlFJZJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-20_05,2022-06-17_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=872 lowpriorityscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 clxscore=1011 spamscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206200043
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 09:18:37AM +0200, Christian Borntraeger wrote:
> Am 20.06.22 um 08:03 schrieb Juergen Gross:
> > Ping?
> > 
> > On 07.06.22 14:33, Juergen Gross wrote:
> > > When booting under KVM the following error messages are issued:
> > > 
> > > hypfs.7f5705: The hardware system does not support hypfs
> > > hypfs.7a79f0: Initialization of hypfs failed with rc=-61
> > > 
> > > While being documented, they can easily be avoided by bailing out of
> > > hypfs_init() early in case of running as a KVM guest.
> > > 
> > > Signed-off-by: Juergen Gross <jgross@suse.com>
> > > ---
> > >   arch/s390/hypfs/inode.c | 3 +++
> > >   1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/arch/s390/hypfs/inode.c b/arch/s390/hypfs/inode.c
> > > index 5c97f48cea91..bdf078f3c641 100644
> > > --- a/arch/s390/hypfs/inode.c
> > > +++ b/arch/s390/hypfs/inode.c
> > > @@ -464,6 +464,9 @@ static int __init hypfs_init(void)
> > >   {
> > >       int rc;
> > > +    if (MACHINE_IS_KVM)
> > > +        return -ENODATA;
> > > +
> > >       hypfs_dbfs_init();
> > >       if (hypfs_diag_init()) {
> 
> In case KVM implements hypfs this check would then be wrong.
> Question to people on CC/TO.
> Would it be an option to still check with KVM but avoid the error message.
> So basically changing hypfs_diag_init and fail_dbfs_exit to check
> for KVM on error?
> Or is this worse?

I'd say just move the pr_err("Initialization of hypfs failed with...")
one label above to fail_hypfs_diag_exit. Then we still get the message
that the hardware system doesn't support hypfs, which seems to be
wanted, and the error message only appears for an error.

Even though I personally dislike printing everything to the console
this seems to be what is/was preferred. So let's keep that.
