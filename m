Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4995651A0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 12:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234283AbiGDKCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 06:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234196AbiGDKCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 06:02:08 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA87DF05;
        Mon,  4 Jul 2022 03:01:04 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2648oLuv020555;
        Mon, 4 Jul 2022 10:01:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=2BzKSpXBmQpnt6fwkumhu99xLkXdqwcbfqXENMnF3b8=;
 b=gD3+22KHct1wurEPRIx8f/ad8CMD258WklUuINXHPUzcR4FmgLAvHXcd8R7Gj2YLP+uo
 9xTECXhPmdMct5hc3rCytk3cAC5GrEzYDoWLXCovTphZhJJYNOD8SoMIzZNOI0f4G9/o
 cvFbbPHkt3Sf2SMZqFWak0BDM8PS505JHngpzi+g9br4NCBB6hq8eEZA40Vmr/SSErdl
 jghNoZtQKa7t7ncpTNPhliU2AwuA0DPROnSLOtwSw5fiy9ldSZRCOq0J809inc60SU4C
 U4vrf8sOAtcECATsj8WCbkgUGrS91s8jFMyQUcTdPFXtGY/4F2Jt7mUx1glEfejvLmTO Lw== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3h3w22sjws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Jul 2022 10:01:02 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2649pohB001815;
        Mon, 4 Jul 2022 10:01:00 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 3h2dn8tgh6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Jul 2022 10:00:59 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2649xj0H18481618
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 4 Jul 2022 09:59:45 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C9403A4051;
        Mon,  4 Jul 2022 10:00:56 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5F859A404D;
        Mon,  4 Jul 2022 10:00:56 +0000 (GMT)
Received: from osiris (unknown [9.145.48.28])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon,  4 Jul 2022 10:00:56 +0000 (GMT)
Date:   Mon, 4 Jul 2022 12:00:54 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Christian Borntraeger <borntraeger@linux.ibm.com>
Cc:     Steffen Eiden <seiden@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, nrb@linux.ibm.com
Subject: Re: [PATCH 1/2] s390/hwcaps: Add HWCAP_UV
Message-ID: <YsK6ViBvm/330a0i@osiris>
References: <20220701100210.5482-1-seiden@linux.ibm.com>
 <20220701100210.5482-2-seiden@linux.ibm.com>
 <1a2a885b-d408-0426-8e8c-ad1c56f4c215@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a2a885b-d408-0426-8e8c-ad1c56f4c215@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _CBYNs-CUDOcOwZNJgfqgpFW7Gs4BYQI
X-Proofpoint-GUID: _CBYNs-CUDOcOwZNJgfqgpFW7Gs4BYQI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-04_08,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 bulkscore=0 adultscore=0
 mlxlogscore=666 mlxscore=0 suspectscore=0 spamscore=0 clxscore=1015
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2204290000 definitions=main-2207040040
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2022 at 12:10:18PM +0200, Christian Borntraeger wrote:
> Am 01.07.22 um 12:02 schrieb Steffen Eiden:
> > This patch adds a hardware capability for the Ultravisor.
> > This capability will be present if facility 158 is enabled.
> > 
> > Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> > ---
> >   arch/s390/include/asm/elf.h  | 2 ++
> >   arch/s390/kernel/processor.c | 5 +++++
> >   2 files changed, 7 insertions(+)
> > 
> > diff --git a/arch/s390/include/asm/elf.h b/arch/s390/include/asm/elf.h
> > index 70a30ae258b7..3a5e89ce4fd0 100644
> > --- a/arch/s390/include/asm/elf.h
> > +++ b/arch/s390/include/asm/elf.h
> > @@ -115,6 +115,7 @@ enum {
> >   	HWCAP_NR_NNPA		= 20,
> >   	HWCAP_NR_PCI_MIO	= 21,
> >   	HWCAP_NR_SIE		= 22,
> > +	HWCAP_NR_UV		= 23,
> >   	HWCAP_NR_MAX
> >   };
> 
> question for Heiko, Vasily, Alexander. This certainly works.
> An alternative implementation would be to separate module_cpu_feature_match
> from HWCAP. (so uv would not be shown in /proc/cpuinfo and it would be
> seen in the aux vector). I would imagine that we might have more drivers
> in the future that depend on a facility but this facility is not really
> useful for userspace to know.
> 
> See arch/s390/include/asm/cpufeature.h
>  * Restrict the set of exposed CPU features to ELF hardware capabilities for
>  * now.  Additional machine flags can be indicated by values larger than
>  * MAX_ELF_HWCAP_FEATURES.
> 
> Any preference from your side?

I mentioned already before this RFC that my preferred solution would
be to have a solution which extends the existing method to work (also)
with facility bits - haven't checked if all existing users could be
converted to facility bits, but making it more flexible would work
certainly.

If Steffen is willing to do that, that would be very welcome.
Otherwise I'll put that on my todo list.
