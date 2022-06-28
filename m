Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8F855E386
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344610AbiF1Mob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 08:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbiF1Mo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 08:44:29 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097BB193ED;
        Tue, 28 Jun 2022 05:44:29 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25SBtLRO010297;
        Tue, 28 Jun 2022 12:44:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=nvgifswP36snNXGbNtI2XGFO4WjgbHDRGzypVmWtBZM=;
 b=n23hdu43vyFW/0DoRBiT45k4izy4Z17v+N4S2Bh2wnAhFBbMQVuaqWqThtelyYuF+hbL
 st/yIs5OJ3m7Ir4zESq+t04f8/aJ2xjznCQHeVYjKwmwx6IEPC4twwPM8WxJrHBTdTV1
 spxfqifF79RdZxS/KR3WoKUBk8NSZMOJ+ONzz/dkjEAjMdMuAURvrYBBKmhWunSaKU1z
 1U0Q1sIV7+Mo9Fn1cGNWXT6UD1hUjBDkWbVOsn5dfxtoaVnR4WZd0WV31hpPTsMquOzt
 +tAPwDT3vJZYeLLk3tpEn06Tua/cJOQP4KMCxJSEvIJ51Wqhc3nmhDsBLA0UoInmxP8F lw== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gyxwrwqgb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jun 2022 12:44:16 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25SCbY2i025677;
        Tue, 28 Jun 2022 12:44:13 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3gwt08vueb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jun 2022 12:44:13 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25SCiAEU22675728
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jun 2022 12:44:10 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A4FB342041;
        Tue, 28 Jun 2022 12:44:10 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 19DE84203F;
        Tue, 28 Jun 2022 12:44:10 +0000 (GMT)
Received: from li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com (unknown [9.145.7.238])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 28 Jun 2022 12:44:10 +0000 (GMT)
Date:   Tue, 28 Jun 2022 14:44:08 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Jiang Jian <jiangjian@cdjrlc.com>
Cc:     hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, oberpar@linux.ibm.com, keescook@chromium.org,
        bjorn.andersson@linaro.org, liaoyu15@huawei.com,
        andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390/sclp: Fix typo in comments
Message-ID: <Yrr3mDLHJ9Xbr5G/@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
References: <20220622142713.14187-1-jiangjian@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622142713.14187-1-jiangjian@cdjrlc.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _rKlqQ5k95tw_9zh6WC6uE7Y5eK-Isv7
X-Proofpoint-ORIG-GUID: _rKlqQ5k95tw_9zh6WC6uE7Y5eK-Isv7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-28_06,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 phishscore=0 adultscore=0 mlxscore=0 spamscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=993 lowpriorityscore=0
 malwarescore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2204290000 definitions=main-2206280052
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 10:27:13PM +0800, Jiang Jian wrote:
> Remove the repeated word 'and' from comments
> 
> Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
> ---
>  drivers/s390/char/sclp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/char/sclp.c b/drivers/s390/char/sclp.c
> index cb2491761958..ae1d6ee382a5 100644
> --- a/drivers/s390/char/sclp.c
> +++ b/drivers/s390/char/sclp.c
> @@ -60,7 +60,7 @@ static LIST_HEAD(sclp_reg_list);
>  /* List of queued requests. */
>  static LIST_HEAD(sclp_req_queue);
>  
> -/* Data for read and and init requests. */
> +/* Data for read and init requests. */
>  static struct sclp_req sclp_read_req;
>  static struct sclp_req sclp_init_req;
>  static void *sclp_read_sccb;

Applied, thanks!
