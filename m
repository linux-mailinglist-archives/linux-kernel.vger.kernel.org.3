Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8AB5A8D25
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 07:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232910AbiIAFNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 01:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232873AbiIAFM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 01:12:59 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8DB122BF8;
        Wed, 31 Aug 2022 22:12:58 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27VNmlGx028365;
        Thu, 1 Sep 2022 05:12:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2022-7-12;
 bh=auI1U2mCK3CRxt8ah235+ElBMl6DJuG8IrRNx3gKuhw=;
 b=RYlaBWD5OVAyFtrjbWtJ0G1bOdesisT389E0UPEN6ElBiMR5QNbU9TDuSNJyjZeYBNTO
 by757NUvXLfKuKZFl6AmcuzOiERLwZim0yl8O48LY2ZAFQicoA9HSFOglZeAi1/7VbR0
 iGaq+IfY4upczqwYEswKQPLi6XQyZ9YhSDU/WXy5PGvZQ+xLVFdiYeVM15m5Mbn6rwbL
 6wigMPl+MdVdWZez13rj7IcM85ZOfZ4ftGm1S144K5+/ons9oSefwXt9vAEEoK//33ni
 mFHr1UXkvuByLxGMKA/6kuR37HzplwoWNGGHj5YFMDxniXC1w+GvXCzAP0LlFZ+OuUiJ pw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j7a22b0uq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Sep 2022 05:12:56 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2813M9ii033664;
        Thu, 1 Sep 2022 05:12:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ja6gr3g1h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Sep 2022 05:12:55 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2815CsXJ008754;
        Thu, 1 Sep 2022 05:12:55 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3ja6gr3g0k-3;
        Thu, 01 Sep 2022 05:12:55 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     linux-scsi@vger.kernel.org,
        Colin Ian King <colin.i.king@gmail.com>,
        megaraidlinux.pdl@broadcom.com,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] scsi: megaraid: remove redundant assignment to variable mfiStatus
Date:   Thu,  1 Sep 2022 01:12:47 -0400
Message-Id: <166200877447.26143.1705682951642194017.b4-ty@oracle.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220805115042.2340400-1-colin.i.king@gmail.com>
References: <20220805115042.2340400-1-colin.i.king@gmail.com>
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
X-Proofpoint-GUID: LNEXKZcfp4FePChmJb0Nlq5iXaKsLgdY
X-Proofpoint-ORIG-GUID: LNEXKZcfp4FePChmJb0Nlq5iXaKsLgdY
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Aug 2022 12:50:42 +0100, Colin Ian King wrote:

> The variable mfiStatus is assigned a value but it is never read. The
> assignment is redundant and can be removed. Also remove { } as the
> return statement does not need to be in it's own code block.
> 
> Cleans up clang scan build warning:
> drivers/scsi/megaraid/megaraid_sas_base.c:4026:7: warning: Although the
> value stored to 'mfiStatus' is used in the enclosing expression, the
> value is never actually read from 'mfiStatus' [deadcode.DeadStores]
> 
> [...]

Applied to 6.1/scsi-queue, thanks!

[1/1] scsi: megaraid: remove redundant assignment to variable mfiStatus
      https://git.kernel.org/mkp/scsi/c/4e62671a9a49

-- 
Martin K. Petersen	Oracle Linux Engineering
