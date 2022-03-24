Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76DDC4E67E2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 18:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352313AbiCXRgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 13:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352303AbiCXRgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 13:36:06 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20162A144B;
        Thu, 24 Mar 2022 10:34:33 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22OHBIDD019495;
        Thu, 24 Mar 2022 17:34:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=1QWAxhtRVc+xqQaz3nDlFCz51cxO+yQIAX8ztjjM6DQ=;
 b=PPGs2BNnQiFA7duY6/9XkfeN7p+CW1pRnnkdiB7N4iBfElfnn7dBbmQBxxHgFuc+eWEV
 X6LgTf+75eX4UBGPn3zLnUMcRrvsS8MNsBt4P/JVA2kEfmAVVrX+ECbnN/roapq8k27D
 gGyeC5iiHCE0h2i21dnmHfuHhP4Nu8SZX7FEbK5CykjXGspzo30dvK5y90xjXYvyLYtc
 ho961KRd/bXX5xfcvC//Vgw9ps5ugH7d21i6gKV+j6EcNvvSAUdDBVWe9QAoJcl5xcKC
 kAFHveQtUqWF8P96I7tNsiLNTqoXZQhA+3mvTNZxoEhO2Iu2rhkIP5/bATP6SBl2PfB0 Lw== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3f0kawe1m2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Mar 2022 17:34:24 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22OHRERe005992;
        Thu, 24 Mar 2022 17:34:06 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 3ew6ej3eb0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Mar 2022 17:34:06 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22OHY33r15270214
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Mar 2022 17:34:03 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2A64A11C05E;
        Thu, 24 Mar 2022 17:34:03 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D426F11C04A;
        Thu, 24 Mar 2022 17:34:02 +0000 (GMT)
Received: from osiris (unknown [9.145.160.180])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 24 Mar 2022 17:34:02 +0000 (GMT)
Date:   Thu, 24 Mar 2022 18:34:01 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Yu Liao <liaoyu15@huawei.com>
Cc:     gor@linux.ibm.com, agordeev@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        liwei391@huawei.com
Subject: Re: [PATCH] s390: cleanup timer API use
Message-ID: <YjyriSRJY1mw04Jt@osiris>
References: <20220322030057.1243196-1-liaoyu15@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322030057.1243196-1-liaoyu15@huawei.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pt9D8vQT-vnDbWb2ciTWDtyy0syub9I7
X-Proofpoint-GUID: pt9D8vQT-vnDbWb2ciTWDtyy0syub9I7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-24_06,2022-03-24_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 mlxlogscore=619 priorityscore=1501 phishscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1011 spamscore=0 suspectscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203240097
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 11:00:57AM +0800, Yu Liao wrote:
> cleanup the s390's use of the timer API
> - del_timer() contains timer_pending() condition
> - mod_timer(timer, expires) is equivalent to:
> 
> 	del_timer(timer);
> 	timer->expires = expires;
> 	add_timer(timer);
> 
> If the timer is inactive it will be activated, using add_timer() on
> condition !timer_pending(&private->timer) is redundant.
> 
> Just cleanup, no logic change.
> 
> Signed-off-by: Yu Liao <liaoyu15@huawei.com>
> ---
>  drivers/s390/char/sclp.c       |  4 +---
>  drivers/s390/char/sclp_con.c   |  3 +--
>  drivers/s390/char/sclp_vt220.c |  6 ++----
>  drivers/s390/cio/device_fsm.c  | 12 +++---------
>  drivers/s390/cio/eadm_sch.c    | 12 +++---------
>  5 files changed, 10 insertions(+), 27 deletions(-)

Applied, thanks.
