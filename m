Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB0651CDC5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 02:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387507AbiEFATu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 20:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233532AbiEFATr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 20:19:47 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07995B3D1;
        Thu,  5 May 2022 17:16:06 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 242Ld6k2013502;
        Tue, 3 May 2022 00:51:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=qMfukqDxJCeLEZx8pzFBAxa56k8cLXeLrVnx1EULUvE=;
 b=GvG1eDzhLySRbBeBGWs6ZqMNgntIrEKu6hmWmIAL3cQcUNoTJZd7BYcwYalgy93l63rz
 Cd3W2pGNsoxEIFX6yS3Lzo0mwL7SakAvAH9RZNxx30vrgWFXSI2kUUFHml9ewZQqGClp
 6XUNvdxzxZQyq9A+XH9yDyp/VNIJDcUU+Z+wYKgyIEZtIGahseKhdiYA1eMLgJBFvr/3
 GD4gkw5BYCq3OH+WKNeySvkudt5qq68x3NXSQKEN0pghyeJevvjL/16RbO+6YwLVW9Bt
 kVX8uIFQZkvGTaiTdvw8aEwyaOOp3rX6Vb1kHLv2l8WQ/DyUwtkzx5Bdr5B2BjnVZbYP Rw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frvqscnkd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 May 2022 00:51:48 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2430orC4009030;
        Tue, 3 May 2022 00:51:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruj83x4t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 May 2022 00:51:48 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 2430pliw010389;
        Tue, 3 May 2022 00:51:47 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruj83x4g-1;
        Tue, 03 May 2022 00:51:47 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     jejb@linux.ibm.com,
        Alexander Vorwerk <alexander.vorwerk@stud.uni-goettingen.de>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] message: fusion: Remove unused variable retval
Date:   Mon,  2 May 2022 20:51:11 -0400
Message-Id: <165153836360.24053.15168505901409239431.b4-ty@oracle.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220317030325.30526-1-alexander.vorwerk@stud.uni-goettingen.de>
References: <20220317030325.30526-1-alexander.vorwerk@stud.uni-goettingen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: K_Gy5KSQkUWxQDVaVZL5raWUfSLw2q9f
X-Proofpoint-ORIG-GUID: K_Gy5KSQkUWxQDVaVZL5raWUfSLw2q9f
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Mar 2022 04:03:25 +0100, Alexander Vorwerk wrote:

> The following warning showed up when compiling with W=1.
> 
> drivers/message/fusion/mptctl.c: In function ‘mptctl_hp_hostinfo’:
> drivers/message/fusion/mptctl.c:2337:8: warning: variable ‘retval’ set but not used [-Wunused-but-set-variable]
>   int   retval;
> 
> Fixing by removing the variable.
> 
> [...]

Applied to 5.19/scsi-queue, thanks!

[1/1] message: fusion: Remove unused variable retval
      https://git.kernel.org/mkp/scsi/c/ce781c3f05cd

-- 
Martin K. Petersen	Oracle Linux Engineering
