Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59FCB57A669
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 20:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240095AbiGSSXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 14:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbiGSSW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 14:22:59 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38BB5C95A;
        Tue, 19 Jul 2022 11:22:58 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26JILZW4015729;
        Tue, 19 Jul 2022 18:22:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=p7ZfL372p62Nd8OeP/At/fzW4tY4F1hA/so2twznn8c=;
 b=UlcHwQJFn3UDflCOhV3whpd+Rpb99nFQ0udhlyYCjdiNvSLkVQvzICZTTESsA+mOqHp4
 L0M6ze8Mt/YnLcQHRe9GMPmZgHQmmER5W2xv/ayhDMh5FnB2uB2aQZKagOHpubunkbiQ
 c05DMO5niN8m9HpPDxMoTUggYFWbRsyAeLrqLB3lZ37IIUdFHg514nExAo+Sz7H+5II6
 VinhutZlfAD41hYShHH/dhyGfpsgJnyvkVPp78R7DU4F0UdGtu8xSktm7HXc+UMjL4aZ
 i6uVwMwLNMwoC41OFWZN4Bso5j1C8Wj9+fA3qmtYptf6uk3+IOe3xBig551+qFNFIRY7 Rg== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3he1auhhev-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Jul 2022 18:22:49 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26JIKrXO003754;
        Tue, 19 Jul 2022 18:22:47 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma02fra.de.ibm.com with ESMTP id 3hbmy8vku2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Jul 2022 18:22:47 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26JIKxUU22806964
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 18:20:59 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2397242041;
        Tue, 19 Jul 2022 18:22:44 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9EE9C42045;
        Tue, 19 Jul 2022 18:22:43 +0000 (GMT)
Received: from li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com (unknown [9.145.22.197])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 19 Jul 2022 18:22:43 +0000 (GMT)
Date:   Tue, 19 Jul 2022 20:22:38 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     svens@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        borntraeger@linux.ibm.com, baihaowen@meizu.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/tape: Fix comment typo
Message-ID: <Ytb2bqHq1D3EFXAB@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
References: <20220715053838.5005-1-wangborong@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220715053838.5005-1-wangborong@cdjrlc.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pGiSmfAWDxqQx15So2liKhxr3mlvwBES
X-Proofpoint-ORIG-GUID: pGiSmfAWDxqQx15So2liKhxr3mlvwBES
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_06,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 mlxscore=0 adultscore=0 suspectscore=0 bulkscore=0
 phishscore=0 spamscore=0 clxscore=1011 impostorscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207190076
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 01:38:38PM +0800, Jason Wang wrote:
> The double `that' is duplicated in line 551, remove one.
> 
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
> ---
>  drivers/s390/char/tape_34xx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/char/tape_34xx.c b/drivers/s390/char/tape_34xx.c
> index 38cc1565d6ae..751945fb6793 100644
> --- a/drivers/s390/char/tape_34xx.c
> +++ b/drivers/s390/char/tape_34xx.c
> @@ -548,7 +548,7 @@ tape_34xx_unit_check(struct tape_device *device, struct tape_request *request,
>  	case 0x2e:
>  		/*
>  		 * Not capable. This indicates either that the drive fails
> -		 * reading the format id mark or that that format specified
> +		 * reading the format id mark or that format specified
>  		 * is not supported by the drive.
>  		 */
>  		dev_warn (&device->cdev->dev, "The tape unit cannot process "

Applied, thanks!
