Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 266A74DB81F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 19:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357762AbiCPSt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 14:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232577AbiCPStY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 14:49:24 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B20565CB;
        Wed, 16 Mar 2022 11:48:10 -0700 (PDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22GIQ1uJ024550;
        Wed, 16 Mar 2022 18:48:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=Bc5UTXniOXGnffoeibu0G8IOdtpFUj53TyMWiDJpWwc=;
 b=mOD6yJ7IXdbOvx8M9FFB6QvON/Iwn4rwwnzHchgdwowowKYacEVS641WR2wqDDumRF94
 1X7ZoKErEEgGAZBC1bEP9mZrYc5pkif1Mm1FE8xofHtniATd87WcrB2VpaBRdN3uC6nH
 n7DFypsGPqtOe0+KXgF5McNTDqC1Q7WLED9ZK2jBo7wZOh/wjH3Bwmt2XSsgkjgwPMmh
 SMjyLcpOtS8fF+5gLyTsmTfU3/eRSuU8Y5o4fyy+UwvpG/7YZ6r+Pa7biiCmsb6OR3Hk
 JgIN+FVaxrfRvis4I7aA8ArnnyzNnoSv6vE5kWncAs0mkYydm6FRKMSA9wMZeWvUBbQu ZA== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3eun5v0f6n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Mar 2022 18:48:07 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22GIX4j2012251;
        Wed, 16 Mar 2022 18:48:05 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 3et95wvygp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Mar 2022 18:48:04 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22GIm1LQ51839354
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Mar 2022 18:48:02 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CC6EF42041;
        Wed, 16 Mar 2022 18:48:01 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8A1724203F;
        Wed, 16 Mar 2022 18:48:01 +0000 (GMT)
Received: from osiris (unknown [9.145.69.99])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 16 Mar 2022 18:48:01 +0000 (GMT)
Date:   Wed, 16 Mar 2022 19:48:00 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     gor@linux.ibm.com, agordeev@linux.ibm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] s390/tape: Use bitwise instead of arithmetic operator
 for flags
Message-ID: <YjIw4BxjzFIZFk9S@osiris>
References: <1647334421-29989-1-git-send-email-baihaowen@meizu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1647334421-29989-1-git-send-email-baihaowen@meizu.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: o020Ic1ot9hjjZxDSoSHC2ohF2n9eWHP
X-Proofpoint-ORIG-GUID: o020Ic1ot9hjjZxDSoSHC2ohF2n9eWHP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-16_08,2022-03-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 adultscore=0 malwarescore=0 phishscore=0 mlxlogscore=675
 lowpriorityscore=0 impostorscore=0 mlxscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2202240000 definitions=main-2203160110
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 04:53:41PM +0800, Haowen Bai wrote:
> This silences the following coccinelle warning:
> drivers/s390/char/tape_34xx.c:360:38-39: WARNING: sum of probable bitmasks, consider |
> 
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> ---
>  drivers/s390/char/tape_34xx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks!
