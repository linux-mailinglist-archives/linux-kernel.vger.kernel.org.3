Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F23155A8D30
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 07:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbiIAFNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 01:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232874AbiIAFNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 01:13:00 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5891286DD;
        Wed, 31 Aug 2022 22:13:00 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27VNnUjb017482;
        Thu, 1 Sep 2022 05:12:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2022-7-12;
 bh=Ihh/7yXcWMQKvsan1xQUebcsKKwZXUyymQawF0hemw0=;
 b=jHjvEvk2+LcviIudMwHJtWNhs6zhyMaJwz4KpY2q+vBv1C3/Pbz+XwnE4RLtlXW2cmYL
 y9AzzVuqurTv26Scj8SiNNhSvi9N7tkzUejX6FBSfWFwp633lTBAF5thjBp97lR55W5j
 rPUHWyZWkdvmclmMtLXDl3n8rinxzf0BW43UWK52c70fPeftx3bOKTMHefARbOep3zcv
 g6xwTXUk/+41EG2U3bH12sFCSCyx2Ag84LuyKAHbC1pYZ3RoCj+6GBUDVgSqMURjdTov
 djW5znFMA+R2uWmCRSf300J+WQfjSHeB/3g1WY1aOBOC0sUa+FFYwXz9/2xy7zITZzUB CA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j79v0u06d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Sep 2022 05:12:58 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2813NtuW033643;
        Thu, 1 Sep 2022 05:12:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ja6gr3g21-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Sep 2022 05:12:56 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2815CsXL008754;
        Thu, 1 Sep 2022 05:12:56 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3ja6gr3g0k-4;
        Thu, 01 Sep 2022 05:12:55 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     linux-scsi@vger.kernel.org,
        Colin Ian King <colin.i.king@gmail.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        MPT-FusionLinux.pdl@broadcom.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] scsi: message: fusion: remove redundant variable iocnum
Date:   Thu,  1 Sep 2022 01:12:48 -0400
Message-Id: <166200877446.26143.13066314512957622241.b4-ty@oracle.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220805113214.2339022-1-colin.i.king@gmail.com>
References: <20220805113214.2339022-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-01_02,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxscore=0 spamscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209010022
X-Proofpoint-GUID: btYVCzVNn1Ya5fqn7r8Yz6-hycqPQKzH
X-Proofpoint-ORIG-GUID: btYVCzVNn1Ya5fqn7r8Yz6-hycqPQKzH
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Aug 2022 12:32:14 +0100, Colin Ian King wrote:

> Variable iocnum is assigned a value that is never read, the assignment
> and hence the variable are redundant can be removed. Also update the
> the comment to reflect the correct name of the variable being updated.
> 
> Cleans up clang-scan warning:
> drivers/message/fusion/mptctl.c:641:8: warning: Although the value stored
> to 'iocnum' is used in the enclosing expression, the value is never
> actually read from 'iocnum' [deadcode.DeadStores]
> 
> [...]

Applied to 6.1/scsi-queue, thanks!

[1/1] scsi: message: fusion: remove redundant variable iocnum
      https://git.kernel.org/mkp/scsi/c/231159f33436

-- 
Martin K. Petersen	Oracle Linux Engineering
