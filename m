Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8427346D756
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 16:48:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236305AbhLHPwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 10:52:03 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33582 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233975AbhLHPwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 10:52:02 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B8FMjpn023097;
        Wed, 8 Dec 2021 15:48:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=Yh5eGB8GsYd4R2z2efaB6/Wl8ArXQGzj5FaHadAAabI=;
 b=fUNMzleoV2eu1CKxDIbJelNiEvw61twkZyvJslZeBKsXDl17Dl+eGOsJV2gbduQ+YMVn
 KP51ZAmUK4iZSocZAfu9mjT3YzrnYYSaZ0c2cEmWmn5tFGyxNB9guHuu6hTRvtIzXUBz
 46uM2kh4NBd/9zy7nP24b9pFXgfrmLEXiRQjBgFqHPe3DpU7hQSfHgvDD6Dv5ptPHbG3
 omivY7V5Q7PDRa5PlUGkPYFalLj0moEHVLGHSVCqraR1o5UNAphwmiOax31+vR5FDYdc
 0IlYn3IRSdjLjg7hIFatvoIbtlPa8CN6rNu9JjaiRlZf0ZvZ+7Q/7AYa6e3xkvSahkuG OA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ctya08gam-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Dec 2021 15:48:15 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B8Fk2T2020964;
        Wed, 8 Dec 2021 15:48:15 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ctya08g9u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Dec 2021 15:48:15 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B8Fbs6P008928;
        Wed, 8 Dec 2021 15:48:12 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04fra.de.ibm.com with ESMTP id 3cqyy9yy64-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Dec 2021 15:48:12 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B8Fm92e27918816
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Dec 2021 15:48:09 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 916A64204C;
        Wed,  8 Dec 2021 15:48:09 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4F27C4203F;
        Wed,  8 Dec 2021 15:48:09 +0000 (GMT)
Received: from osiris (unknown [9.145.37.164])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  8 Dec 2021 15:48:09 +0000 (GMT)
Date:   Wed, 8 Dec 2021 16:48:07 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Jerome Marchand <jmarchan@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        =?utf-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ftrace: disable preemption when recursion locked in
 arch/s390/kernel/ftrace.c
Message-ID: <YbDTt/VGOfQqXmff@osiris>
References: <20211208151503.1510381-1-jmarchan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208151503.1510381-1-jmarchan@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ROvdP0JvnStDJ8Jy4mf16XiXrwu5FbWQ
X-Proofpoint-ORIG-GUID: KDIyKoI9rnHp6OujVccR_5_rHkKKeV3X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-08_06,2021-12-08_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 spamscore=0 bulkscore=0 malwarescore=0 mlxlogscore=350 mlxscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112080095
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 04:15:03PM +0100, Jerome Marchand wrote:
> It looks like commit ce5e48036c9e76a2 ("ftrace: disable preemption
> when recursion locked") missed a spot in kprobe_ftrace_handler() in
> arch/s390/kernel/ftrace.c.
> Removes the superfluous preempt_disable/enable_notrace() there too.
> 
> Fixes: ce5e48036c9e76a2 ("ftrace: disable preemption when recursion locked")
> Signed-off-by: Jerome Marchand <jmarchan@redhat.com>
> ---
>  arch/s390/kernel/ftrace.c | 2 --
>  1 file changed, 2 deletions(-)

Applied to s390 tree. Thanks!
