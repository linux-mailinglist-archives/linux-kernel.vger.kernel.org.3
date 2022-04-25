Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D573050DC4D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 11:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241011AbiDYJS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 05:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241559AbiDYJQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 05:16:59 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B52F321
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 02:13:51 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23P8dEd6030426;
        Mon, 25 Apr 2022 09:13:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=6X2jedQwijB4Kh0e2riYItaL9nIyj05CViCMzGahzWk=;
 b=PdJt77zs0jrYt5X4a5k+7M3MnYsAbWu5t+mzzaHVpgDSTGJwH8E+tV2zVEIcRpZUaB+0
 xjR/FCJm8tm9RbXXuIizJf1AJrXLYGXUZuMjSpdJfa/v/bMfRB8xcjQBwZ9w3QKhavb5
 u1pWkzhEZtnJT22NPcr+y3CPoYd7f5wPHS/zXy/K3TJNxgL6fbV2TC2VBLZ1M1eX2Q8T
 f7dTxEJlvQMuCxcs5Z0xF4+0lWBvCodxLN1CSYriy+eHIk+IoW0vRSL23jbI0XYu/i/T
 ARYaR23fUhtSGal2Rox0ak9PCcrpLmP3ndXiHsqpdcZrdZTkagkH3J+L6QCBvwwlPYeA Dw== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fnraugqb2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Apr 2022 09:13:49 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23P99NnW002691;
        Mon, 25 Apr 2022 09:13:47 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 3fm938t3aj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Apr 2022 09:13:47 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23P9DiQ220578720
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Apr 2022 09:13:44 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5537DAE055;
        Mon, 25 Apr 2022 09:13:44 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C8D2AE051;
        Mon, 25 Apr 2022 09:13:44 +0000 (GMT)
Received: from osiris (unknown [9.145.60.82])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 25 Apr 2022 09:13:43 +0000 (GMT)
Date:   Mon, 25 Apr 2022 11:13:42 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Sven Schnelle <svens@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] s390: disable -Warray-bounds
Message-ID: <YmZmRlvK1Ad2R4tW@osiris>
References: <20220422134308.1613610-1-svens@linux.ibm.com>
 <202204221052.85D0C427@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202204221052.85D0C427@keescook>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: kFHppHQ3132OF6_IEtMjIkGaIK8ytjbm
X-Proofpoint-GUID: kFHppHQ3132OF6_IEtMjIkGaIK8ytjbm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-25_05,2022-04-22_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 mlxscore=0 lowpriorityscore=0 clxscore=1011 priorityscore=1501 bulkscore=0
 impostorscore=0 mlxlogscore=381 adultscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204250040
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 10:54:09AM -0700, Kees Cook wrote:
> On Fri, Apr 22, 2022 at 03:43:08PM +0200, Sven Schnelle wrote:
> > gcc-12 shows a lot of array bound warnings on s390. This is caused
> > by our S390_lowcore macro:
> > 
> > which uses an hardcoded address of 0. Wrapping that with
> > absolute_pointer() works, but gcc no longer knows that a 12 bit
> > instruction is sufficient to access lowcore. So it emits instructions
> > like 'lghi %r1,0; l %rx,xxx(%r1)' instead of a single load/store
> > instruction. As s390 stores variables often read/written in lowcore,
> > this is considered problematic. Therefore disable -Warray-bounds on
> > s390 for now until there is a better real solution.
> > 
> > Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> 
> It looks like the source of this problem (the literal-values-treated-as-NULL)
> is gcc-12 specific. From the discussions, it sounded like Jacob was
> going to fix this "correctly" in gcc-13. It might be a good idea to make
> this version-checked? (i.e. only disable on gcc-12)

That makes sense, so we still get at least some coverage for compilers
< gcc 12; and also latest clang still seems to do the right thing.

Sven, could you either send an updated patch, or an addon patch,
please? Whatever you prefer.
