Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66FD252A179
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 14:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346046AbiEQM0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 08:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346023AbiEQM0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 08:26:40 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D4011A2C
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 05:26:39 -0700 (PDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24HBs8mM012663;
        Tue, 17 May 2022 12:26:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=0p47A6V3sGWvxdv1vYqNV7nUV8jGltXcLQJbJQb3bDk=;
 b=Q2U9b0rIoW5qcK3vu5nKUsqB8bGN3RnB9JuVS2cAACX+naMO9vNKTFjKLmPOd578F4HW
 Bw+5i8F1w1KRxFA9MBRH5hfI+2sx6XVr4NQWu8mjx0yd3kBfmlm3QbR8ZQbE8kvCuGrA
 goUtAJk7rHJ8jl/hLRM8eW4jlEpjVwr0UP3r1LUckDl35hiNctfMQpwx6vJrL61p0VU5
 FPE7Bk4iVoSMJGAZLrYaQAMGwRMw0oQYBlper/wc73Rta1cUkgu1wfdUhl4i5wgPBVeI
 V0tSDqYmmGtg0bfqXjrfnWwitncZasBmfQOMLpouW54c2UBs2H7c0uarjS15HjxiUIUg 1A== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g4b870rrc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 May 2022 12:26:21 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24HCMXJR030567;
        Tue, 17 May 2022 12:26:19 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma05fra.de.ibm.com with ESMTP id 3g24293b9q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 May 2022 12:26:18 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24HCQF5o54591800
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 May 2022 12:26:15 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CB99AAE051;
        Tue, 17 May 2022 12:26:15 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 84D21AE056;
        Tue, 17 May 2022 12:26:15 +0000 (GMT)
Received: from osiris (unknown [9.145.73.41])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 17 May 2022 12:26:15 +0000 (GMT)
Date:   Tue, 17 May 2022 14:26:14 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Liam Howlett <liam.howlett@oracle.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mapletree-vs-khugepaged
Message-ID: <YoOUZnmsCkq5JkCl@osiris>
References: <20220428172040.GA3623323@roeck-us.net>
 <YmvVkKXJWBoGqWFx@osiris>
 <yt9dk0apbicu.fsf@linux.ibm.com>
 <20220513165955.mkg5wvfi4dwpzoer@revolver>
 <YoOMsmq24FWsWWyr@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoOMsmq24FWsWWyr@osiris>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qlzJMFlKMSGqO5xBqFsHsyFwHH3mafkT
X-Proofpoint-ORIG-GUID: qlzJMFlKMSGqO5xBqFsHsyFwHH3mafkT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-17_02,2022-05-17_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 mlxlogscore=809 priorityscore=1501 spamscore=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205170073
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 01:53:22PM +0200, Heiko Carstens wrote:
> On Fri, May 13, 2022 at 05:00:31PM +0000, Liam Howlett wrote:
> > * Sven Schnelle <svens@linux.ibm.com> [220513 10:46]:
> > > Heiko Carstens <hca@linux.ibm.com> writes:
> > > > FWIW, same on s390 - linux-next is completely broken. Note: I didn't
> > > > bisect, but given that the call trace, and even the failing address
> > > > match, I'm quite confident it is the same reason.
> > > IS that issue supposed to be fixed? git bisect pointed me to
> > > 
> > > # bad: [76535d42eb53485775a8c54ea85725812b75543f] Merge branch
> > >   'mm-everything' of
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> > > 
> > > which isn't really helpful.
> > > 
> > > Anything we could help with debugging this?
> > 
> > I tested the maple tree on top of the s390 as it was the same crash and
> > it was okay.  I haven't tested the mm-everything branch though.  Can you
> > test mm-unstable?
> > 
> > I'll continue setting up a sparc VM for testing here and test
> > mm-everything on that and the s390
> 
> So due to reports here I did some sort of "special bisect": with today's
> linux-next I did a hard reset to commit 562340595cbb ("Merge branch
> 'for-next/kspp' of
> git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git"),

Forgot to mention: this is the last merge commit before the akpm
trees were merged, which again come last in linux-next.

> started a bisect on Andrew's tree between mm-stable and mm-unstable, and
> merged whatever commit was about to be bisected into 562340595cbb.
> 
> This lead finally to commit f1297d3a2cb7 ("mm/mmap: reorganize munmap to
> use maple states") as "first bad commit".
> 
> So given that we are shortly before the merge window and linux-next is
> completely broken for s390, how do we proceed? Right now I have no idea if
> there is anything else in linux-next that would break s390 because of this.
> 
> Even though I'm sure you won't like to hear this, but I'd appreciate if
> this code could be removed from linux-next again.
