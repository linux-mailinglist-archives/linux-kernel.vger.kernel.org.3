Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 213B857A666
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 20:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240084AbiGSSWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 14:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238753AbiGSSW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 14:22:28 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E7F5C952;
        Tue, 19 Jul 2022 11:22:27 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26JIKxk4011378;
        Tue, 19 Jul 2022 18:22:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=esNcen1q//zIxIJjMrVKyWCX2mgVPvnwZ/RGN1nIFJk=;
 b=bb3hsB2LiGWCoX0VyG4l7vPZNva6ExXJEPPQnJlMiCEIcgY40fmOw/3Oqr94+IqIXTwR
 M3Yad373SxPkaBgYV5DT+7sKWRnTIQcKxwLqdiuAK8BQ5AHhgY+48Q5g0fDq4mBAEJq0
 DzTlZjPiqkD060hRqd1ILO5YGtG3uIYjfTXar3bCDU/R++F/5JObuQd9sWB8+RChMeBD
 MlrpMHu3fYJngRe/RO9F4CkImDH24BlrTKtO20GgjXOfKmB0/6B45d9WpGma++bj3C71
 UEWxpTUz854r50sUtwVZCGXrwf7+c7yy3/PFeIzJsy2WSVRwfC8wIIjql9bU80kUIQyw Tg== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3he1p7gcr2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Jul 2022 18:22:23 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26JIKdBm025084;
        Tue, 19 Jul 2022 18:22:20 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04fra.de.ibm.com with ESMTP id 3hbmy8kdrg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Jul 2022 18:22:20 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26JIMHD914811610
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 18:22:17 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8CF3CA404D;
        Tue, 19 Jul 2022 18:22:17 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 15828A4040;
        Tue, 19 Jul 2022 18:22:17 +0000 (GMT)
Received: from li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com (unknown [9.145.22.197])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 19 Jul 2022 18:22:17 +0000 (GMT)
Date:   Tue, 19 Jul 2022 20:22:15 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     svens@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        borntraeger@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/delay: Fix comment typo
Message-ID: <Ytb2V3ay5qMY3yt+@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
References: <20220715043610.17229-1-wangborong@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220715043610.17229-1-wangborong@cdjrlc.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kDU3v2xJFrDX9GOH5B7d9ILDApvp4boP
X-Proofpoint-ORIG-GUID: kDU3v2xJFrDX9GOH5B7d9ILDApvp4boP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_06,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 mlxlogscore=857 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207190076
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 12:36:10PM +0800, Jason Wang wrote:
> The double `that' is duplicated in line 19, remove one.
> 
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
> ---
>  arch/s390/lib/delay.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/lib/delay.c b/arch/s390/lib/delay.c
> index f7f5adea8940..c32bc8f7c1fd 100644
> --- a/arch/s390/lib/delay.c
> +++ b/arch/s390/lib/delay.c
> @@ -16,7 +16,7 @@ void __delay(unsigned long loops)
>          /*
>           * To end the bloody studid and useless discussion about the
>           * BogoMips number I took the liberty to define the __delay
> -         * function in a way that that resulting BogoMips number will
> +         * function in a way that resulting BogoMips number will
>           * yield the megahertz number of the cpu. The important function
>           * is udelay and that is done using the tod clock. -- martin.
>           */

Applied, thanks!
