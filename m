Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5EF252B938
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 13:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235892AbiERLy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 07:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235810AbiERLyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 07:54:50 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190AE49C86;
        Wed, 18 May 2022 04:54:48 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24IBlL3S016293;
        Wed, 18 May 2022 11:54:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=Ap+lBzAtoKjwarN7fWcNP0poXNCXF3aQkSAGGC9mrNQ=;
 b=NZ7uR6yZYJ6e74NjpaNPrJrrcRrB/09ejn0/ApE2z6qFILFvQiQKg7xT0PoI09hY3cvT
 zJAGWDEMwIcgmMn+/DofYRip5ICBEclD2b36drlRFtlkBkoz/VkK/sgMvNrPhJCIu5J4
 Vm6nBwp9sRM/lZQit0tD+L6cajsFoHk29x72dc03eZgw8bwLrvIZTjXDVDTwb+UjI2hK
 BHQRqdtD8Aw9CgJUQQQcIqRgXHFCTxwA9AwG20f0CcuEGiO30fEHHbbwkUZWqMF20Clg
 BhwPRTv3KYEN9nuIWYf1uqe4qQU9roJuq4XU40sc5iOPozf/TO8cqyksh6rdD5WxI9kG Xg== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g508103x6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 May 2022 11:54:46 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24IBqsiq002923;
        Wed, 18 May 2022 11:54:45 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma02fra.de.ibm.com with ESMTP id 3g2428mjfk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 May 2022 11:54:44 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24IBsfIl48628084
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 May 2022 11:54:41 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AADF852057;
        Wed, 18 May 2022 11:54:41 +0000 (GMT)
Received: from osiris (unknown [9.145.54.247])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 5B02A5204E;
        Wed, 18 May 2022 11:54:41 +0000 (GMT)
Date:   Wed, 18 May 2022 13:54:39 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Steffen Eiden <seiden@linux.ibm.com>
Cc:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Nico Boehr <nrb@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390: Add attestation query information
Message-ID: <YoTefxTetgGrfKym@osiris>
References: <20220518095113.982955-1-seiden@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518095113.982955-1-seiden@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TKogau4XcC4SsuoX52VFtJzUpFkxKPIy
X-Proofpoint-ORIG-GUID: TKogau4XcC4SsuoX52VFtJzUpFkxKPIy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-18_04,2022-05-17_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 spamscore=0 impostorscore=0 mlxscore=0 bulkscore=0 clxscore=1015
 phishscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=538
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205180065
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 09:51:13AM +0000, Steffen Eiden wrote:
> We have information about the supported attestation header version
> and paf (=  plaintext attestation flag) bits.
> Let's expose it via the sysfs files.
> 
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> ---
>  arch/s390/boot/uv.c        |  2 ++
>  arch/s390/include/asm/uv.h |  7 ++++++-
>  arch/s390/kernel/uv.c      | 20 ++++++++++++++++++++
>  3 files changed, 28 insertions(+), 1 deletion(-)

Please write in the cover-letter *why* this is needed.
