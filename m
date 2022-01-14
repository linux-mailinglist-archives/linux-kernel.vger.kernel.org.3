Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD7B48EB27
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 14:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241311AbiANN64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 08:58:56 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:19910 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230472AbiANN6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 08:58:55 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20ECqaIR015310;
        Fri, 14 Jan 2022 13:58:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=8Ss7jIjUAtCDaRBtippkpozrWEvmHDl/JhyDyJGbN1w=;
 b=WYRB2xjtBidYFV9Vsrz0IzZ9e/wqwyz36pLVOiXTadxVd/Lm6i0UKVYZNe3u3ZNV71qX
 y7MmgXT6wcwsNiaRs5lH2J9oBMAlZwWswl3uibScoLUqyFslc1M+MwuchPUXvFdIdQxr
 kZfZ78YX/68fn9sIKJxk6xcL0KmtmQnCBJrNtAqfeiU/a8WId6x+nwlm3nHklAwLmBzM
 JeXRi9zLmdbPH5YyO8C8MTLz5QCwCa1B0Dk4Dh9MNBWfwrhnPLNo6zxXSEnH9PvaDXFA
 O6y1u5PBig9OfYp+v/git0lGcyRB90ktnUjS1i24nx4Cxt+9TrVbjMcMXjOZkVkav7Vf rg== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dk9jm967c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jan 2022 13:58:54 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20EDqqcv013936;
        Fri, 14 Jan 2022 13:58:53 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 3df1vjxvhq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jan 2022 13:58:53 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20EDwnBl40567290
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Jan 2022 13:58:49 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CA59542049;
        Fri, 14 Jan 2022 13:58:49 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 70EAB42041;
        Fri, 14 Jan 2022 13:58:49 +0000 (GMT)
Received: from osiris (unknown [9.145.31.113])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 14 Jan 2022 13:58:49 +0000 (GMT)
Date:   Fri, 14 Jan 2022 14:58:48 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Nico Boehr <nrb@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/uaccess: introduce bit field for OAC specifier
Message-ID: <YeGBmPBJ8NMi0Rkp@osiris>
References: <20220111100003.743116-1-scgl@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111100003.743116-1-scgl@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Y_oe6mtqmdvkYVOfVGNymPteTTRnXQyi
X-Proofpoint-GUID: Y_oe6mtqmdvkYVOfVGNymPteTTRnXQyi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-14_05,2022-01-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0
 malwarescore=0 mlxlogscore=709 mlxscore=0 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201140090
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 11:00:03AM +0100, Janis Schoetterl-Glausch wrote:
> From: Nico Boehr <nrb@linux.ibm.com>
> 
> Previously, we've used  magic values to specify the OAC
> (operand-access control) for mvcos.
> 
> Instead we introduce a bit field for it.
> 
> When using a bit field, we cannot use an immediate value with K
> constraint anymore, since GCC older than 10 doesn't recognize
> the bit field union as a compile time constant.
> To make things work with older compilers,
> load the OAC value through a register.
> 
> Bloat-o-meter reports a slight increase in kernel size with this change:
> Total: Before=15692135, After=15693015, chg +0.01%
> 
> Signed-off-by: Nico Boehr <nrb@linux.ibm.com>
> Co-developed-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
> Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
> ---
>  arch/s390/include/asm/uaccess.h | 120 ++++++++++++++++++++------------
>  arch/s390/lib/uaccess.c         |  24 +++++--
>  2 files changed, 95 insertions(+), 49 deletions(-)

Applied with a couple of indentation + whitespace fixes.

Thanks!
