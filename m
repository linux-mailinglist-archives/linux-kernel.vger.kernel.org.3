Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35C8F50FCCE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 14:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349891AbiDZMWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 08:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243957AbiDZMWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 08:22:01 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CF81110
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 05:18:33 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QC0ddm005455;
        Tue, 26 Apr 2022 12:18:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=/9ndkcDfO8Lqxw/f7KbY/x0vThJhHsZ/6ZzRJOU8r2A=;
 b=obE8YqKM31eRCOTr9/D3uN6eIva+uLbdkwZYt1sAdALvNhOMgh2k7vKc04mnrxtcVgGr
 38hNc2VGRYJ7odL8hRbMK18GLLpb1rtGwQc9xhxAuML/GaHq+dwuuHNp5nhIS64uuvIA
 4FOOKWXLDK/pgZHI6x80s8D4f8UXxlk+W7yBQfY7wLek7d/OBOzimPbbQ7O/9ZSoOeGT
 soZ9hJRvvDqrkAg2y/3ELljztbkJlGdr83pLCK/bbffLdU5VCg9Rf2aIx/zU5lVEdtMa
 J3gDwmTzEkpnO9QAQy+Vx8xPON3aV3CfEc6GrTmgMDe6NoPfUQy/4E5OjNicKE6IBJ16 vQ== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fpbrbe7qe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 12:18:31 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23QCCk7Q019210;
        Tue, 26 Apr 2022 12:18:30 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04fra.de.ibm.com with ESMTP id 3fm938uds0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 12:18:29 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23QCIQxA51708396
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 12:18:26 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C398B52052;
        Tue, 26 Apr 2022 12:18:26 +0000 (GMT)
Received: from osiris (unknown [9.145.90.170])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 7B75E5204F;
        Tue, 26 Apr 2022 12:18:26 +0000 (GMT)
Date:   Tue, 26 Apr 2022 14:18:25 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] s390: disable -Warray-bounds
Message-ID: <YmfjEeUqYoWS2rL2@osiris>
References: <20220425121742.3222133-1-svens@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425121742.3222133-1-svens@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5tlhAAZOwVaz2tLbTf9Ll4uYGey5aYDK
X-Proofpoint-ORIG-GUID: 5tlhAAZOwVaz2tLbTf9Ll4uYGey5aYDK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-26_02,2022-04-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=469
 priorityscore=1501 bulkscore=0 phishscore=0 lowpriorityscore=0
 adultscore=0 suspectscore=0 impostorscore=0 clxscore=1015 spamscore=0
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204260078
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 02:17:42PM +0200, Sven Schnelle wrote:
> gcc-12 shows a lot of array bound warnings on s390. This is caused
> by our S390_lowcore macro:
> 
> which uses an hardcoded address of 0. Wrapping that with
> absolute_pointer() works, but gcc no longer knows that a 12 bit
> instruction is sufficient to access lowcore. So it emits instructions
> like 'lghi %r1,0; l %rx,xxx(%r1)' instead of a single load/store
> instruction. As s390 stores variables often read/written in lowcore,
> this is considered problematic. Therefore disable -Warray-bounds on
> s390 when gcc-12 is used until there is a better real solution.
> 
> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> ---
> Changes in v2:
> - only remove -Warray-bounds for gcc-12
> 
>  arch/s390/Makefile | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Applied, thanks!
