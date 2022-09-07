Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6195AF9E1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 04:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiIGCci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 22:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiIGCcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 22:32:35 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C793923DE;
        Tue,  6 Sep 2022 19:32:34 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286LcrYD018858;
        Wed, 7 Sep 2022 02:32:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : mime-version :
 content-type; s=corp-2022-7-12;
 bh=nVh+abXyaHKmmQ1QQVzma/X54ytI0p+XBKim185wOaU=;
 b=3NOiw3HGH6qYUETlx94kxsjIEKZvFijrpaxeyZfsB0Ti+Y6UNAzgUZlRf+j5oX/PSQj+
 1PQpcQ1UYszRkuhSM3Qyh244uFq3UHucJ/yDHSSpo2VftzyKnIi5D4lEi2iK2U28HzAx
 0WMHL2QCR6UjP4xkYqgU4+9eo9OrvTS2H9roFvXXQYmdmmZ+aZzx27xWKCpzQfim++WI
 rPKHrJ2mDu+Ho/I/VrNUr6/1zwL0GB3kklUZB6h6UeJWqoevtnlz/McxXDgS6ihi0Lpw
 cCSFBiXKlOFLQrvO2cGh4TWNi1IZRjqujjcvMHv5d/e/nNaC8Sblt6Vy3mEflL/pVhsz uA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbxhsqjvk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Sep 2022 02:32:31 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286NRPQr030700;
        Wed, 7 Sep 2022 02:32:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc3qcq7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Sep 2022 02:32:30 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2872WUiP023166;
        Wed, 7 Sep 2022 02:32:30 GMT
Received: from ca-mkp.ca.oracle.com (dhcp-10-39-192-227.vpn.oracle.com [10.39.192.227])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3jbwc3qcps-1;
        Wed, 07 Sep 2022 02:32:30 +0000
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] scsi: qla2xxx: Fix spelling mistake "definiton"
 -> "definition"
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1edwngbih.fsf@ca-mkp.ca.oracle.com>
References: <20220906140010.194273-1-colin.i.king@gmail.com>
Date:   Tue, 06 Sep 2022 22:32:28 -0400
In-Reply-To: <20220906140010.194273-1-colin.i.king@gmail.com> (Colin Ian
        King's message of "Tue, 6 Sep 2022 15:00:10 +0100")
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_11,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=996 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209070009
X-Proofpoint-GUID: zuKodQH_cxJLZIDqBWZ2ywMAKPRfFfXh
X-Proofpoint-ORIG-GUID: zuKodQH_cxJLZIDqBWZ2ywMAKPRfFfXh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Colin,

> There is a spelling mistake in a MODULE_PARM_DESC description. Fix it.

Applied to 6.1/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
