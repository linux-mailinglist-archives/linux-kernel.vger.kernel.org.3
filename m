Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD435A8D33
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 07:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbiIAFNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 01:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232915AbiIAFND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 01:13:03 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91CE4122BE1;
        Wed, 31 Aug 2022 22:13:02 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27VNn73J030499;
        Thu, 1 Sep 2022 05:12:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2022-7-12;
 bh=WqhqCJivsAXcHICOEwzIv0vOs5NnWBBEpwe77+sdMtY=;
 b=AoRNBdNtcWdo0+qfDQMlmacDgNE4tzXgqKBVrK/D/h1t0oO6t239G2ybQ75AuAay7wmb
 4dmPFgLg4iMQcePwfqXoshKCNNDdpPYFOaSp5WLf8lONUjLOHGJ9uH0tNlq3kOf6xwYF
 VCe+H+f8T3upRhSDmHdJb3RmSQ2/NK0Q0v5KoHUPpAtKRIhQGbdvW+LyWaDsC9DNT4kL
 1sLcJFl/k4LZENrjt7+MKITdVK9qJtd1gsdmmWAFAo4987Gkv+yr3xa9OV0CQQsXmN8B
 36avn4AlopArMlXuGh090NoHNGpGl+VounuqcP/oGsqQeWTiFA2bzMr80bOweJY274qU bQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j7a22b0ur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Sep 2022 05:12:57 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2812Ylst033799;
        Thu, 1 Sep 2022 05:12:57 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ja6gr3g2d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Sep 2022 05:12:57 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2815CsXN008754;
        Thu, 1 Sep 2022 05:12:56 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3ja6gr3g0k-5;
        Thu, 01 Sep 2022 05:12:56 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     =?UTF-8?q?Kai=20M=C3=A4kisara?= <Kai.Makisara@kolumbus.fi>,
        linux-scsi@vger.kernel.org,
        Colin Ian King <colin.i.king@gmail.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] scsi: st: remove redundant variable pointer stp
Date:   Thu,  1 Sep 2022 01:12:49 -0400
Message-Id: <166200877449.26143.10151427977661548145.b4-ty@oracle.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220805115652.2340991-1-colin.i.king@gmail.com>
References: <20220805115652.2340991-1-colin.i.king@gmail.com>
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
X-Proofpoint-GUID: JQZTPMQxxw9a8FpAYuE_TdVcnSPPTQ81
X-Proofpoint-ORIG-GUID: JQZTPMQxxw9a8FpAYuE_TdVcnSPPTQ81
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Aug 2022 12:56:52 +0100, Colin Ian King wrote:

> Variable stp is assigned a value that is never read, the assignment
> and the variable stp are redundant and can be removed.
> 
> Cleans up clang scan build warning:
> drivers/scsi/st.c:4253:7: warning: Although the value stored to 'stp'
> is used in the enclosing expression, the value is never actually
> read from 'stp' [deadcode.DeadStores]
> 
> [...]

Applied to 6.1/scsi-queue, thanks!

[1/1] scsi: st: remove redundant variable pointer stp
      https://git.kernel.org/mkp/scsi/c/f0ee639adb78

-- 
Martin K. Petersen	Oracle Linux Engineering
