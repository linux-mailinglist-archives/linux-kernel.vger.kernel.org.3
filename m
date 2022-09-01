Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C6A5A8D2B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 07:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232937AbiIAFNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 01:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232827AbiIAFM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 01:12:59 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC5F122BE1;
        Wed, 31 Aug 2022 22:12:58 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27VNn5Tw016997;
        Thu, 1 Sep 2022 05:12:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2022-7-12;
 bh=O1rTWc95qla9ACT3vDf9rrTQA7761nQelZKcZJvDqZs=;
 b=Gq2/m5MpslqQljrWQ2Cz5uSdCH9abo8qjLC4lP1aTShSi4HebMqz4cOj7RQd7rspPyJX
 MjWmB4j/C6qtshFu+9xibISRMMOhI+Ep/YgJhEm5GNfJ5J3PT6KXvTHQ4U3/KR2AbJk2
 /hfHGMSf0oz/Ti4iqnqAap2B50wVf/HWguzVt1cKN+cfhhK/7g81zAdM1ADJBVQHe4vV
 dT/OHSKUDd3Sqkb7/VXyVDYNY0xJLF2n23foNI9c147/x+JCFcPCFoQ0ZOCqAEn71obt
 WMmizsf+4Qb7OPcNICv4xnBT3BUuyh4HVn+YIib1aCKbRh3hdI9DWuK2SZFG8eD/7iiJ QQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j7bttb0be-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Sep 2022 05:12:56 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2813QKXv033605;
        Thu, 1 Sep 2022 05:12:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ja6gr3g16-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Sep 2022 05:12:55 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2815CsXH008754;
        Thu, 1 Sep 2022 05:12:54 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3ja6gr3g0k-2;
        Thu, 01 Sep 2022 05:12:54 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Colin Ian King <colin.i.king@gmail.com>,
        linux-scsi@vger.kernel.org,
        "James E . J . Bottomley" <jejb@linux.ibm.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] scsi: initio: remove redundant assignment to pointer scb
Date:   Thu,  1 Sep 2022 01:12:46 -0400
Message-Id: <166200877447.26143.13707974682721049195.b4-ty@oracle.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220805114100.2339637-1-colin.i.king@gmail.com>
References: <20220805114100.2339637-1-colin.i.king@gmail.com>
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
X-Proofpoint-ORIG-GUID: ZCGkfeKf2R_cTCYuY8zwfH2irHjwxaDh
X-Proofpoint-GUID: ZCGkfeKf2R_cTCYuY8zwfH2irHjwxaDh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Aug 2022 12:41:00 +0100, Colin Ian King wrote:

> The variable scb is assigned a value but it is never read. The assignment
> is redundant and can be removed. Also replace the != NULL check with the
> more usual non-null check idiom.
> 
> Cleans up clang scan build warning:
> drivers/scsi/initio.c:1169:9: warning: Although the value stored to 'scb'
> is used in the enclosing expression, the value is never actually read
> from 'scb' [deadcode.DeadStores]
> 
> [...]

Applied to 6.1/scsi-queue, thanks!

[1/1] scsi: initio: remove redundant assignment to pointer scb
      https://git.kernel.org/mkp/scsi/c/3fa5975b07e9

-- 
Martin K. Petersen	Oracle Linux Engineering
