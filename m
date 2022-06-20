Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68315514B6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 11:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239687AbiFTJsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 05:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239153AbiFTJr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 05:47:58 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE6AD73;
        Mon, 20 Jun 2022 02:47:54 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25K84ijV016693;
        Mon, 20 Jun 2022 09:47:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=Np/O7yFPUqiCUfl0PLi5bRkE4/j0Xw9+ugO+BGmcTvE=;
 b=Zo3NxBUJlQ3LllllOInjSaJqU5Hz6inLRxMcGJfdkXQ/p8EjN7AFO5KC5yX2tLIYHnHb
 1bW1ORq9cwDX8pyngREd0QP+l0khl4imzmoEF9VhxOUBafxJti2u4MHiZfTfNp5M1M/p
 V4jl3w04ccEtlfLHjppZKZDXSaEWgDbTRKEeaMA3T8WgRb7UBqNsOa4TE6wcPke7h33g
 0E6+GZ8QDJ52NAZC5RC0hu2OZ5KHVvJ3RB8Oy2ab/jHscXHC2VZRTIXvzNeSRRv0vLjo
 WwI/HoSCbcN7deAaroKNLjVqRr3LIF7kaFFETwmhiYOduc4G4TP2roiv57UBIGt2Hzn3 cQ== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gsrqt4a4r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jun 2022 09:47:51 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25K9ZK71028242;
        Mon, 20 Jun 2022 09:47:49 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3gs6b8t9cs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jun 2022 09:47:49 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25K9ljSB20054360
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jun 2022 09:47:45 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CCB25A405F;
        Mon, 20 Jun 2022 09:47:45 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7BB5BA4054;
        Mon, 20 Jun 2022 09:47:45 +0000 (GMT)
Received: from osiris (unknown [9.145.85.139])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 20 Jun 2022 09:47:45 +0000 (GMT)
Date:   Mon, 20 Jun 2022 11:47:44 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH v2] s390/kvm: avoid hypfs error message
Message-ID: <YrBCQDr01R2URj1I@osiris>
References: <20220620094534.18967-1-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220620094534.18967-1-jgross@suse.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: iYwO6U0Q9dTtKbx58AQqCs275ZS5QFup
X-Proofpoint-ORIG-GUID: iYwO6U0Q9dTtKbx58AQqCs275ZS5QFup
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-20_05,2022-06-17_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=606
 bulkscore=0 impostorscore=0 mlxscore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206200044
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 11:45:34AM +0200, Juergen Gross wrote:
> When booting under KVM the following error messages are issued:
> 
> hypfs.7f5705: The hardware system does not support hypfs
> hypfs.7a79f0: Initialization of hypfs failed with rc=-61
> 
> Demote the severity of first message from "error" to "info" and issue
> the second message only in other error cases.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
> V2:
> - don't bail out if KVM, but avoid error messages instead (Christian
>   Borntraeger)
> ---
>  arch/s390/hypfs/hypfs_diag.c | 2 +-
>  arch/s390/hypfs/inode.c      | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Acked-by: Heiko Carstens <hca@linux.ibm.com>
