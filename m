Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A51952E193
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 03:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344280AbiETBJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 21:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344238AbiETBJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 21:09:28 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18426129EE2;
        Thu, 19 May 2022 18:09:27 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24K0InVw015728;
        Fri, 20 May 2022 01:09:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=SZA4D5fb4zhb1fURFuh0/2y47Ul0fRkvE4KGE56d4DA=;
 b=FySo+CZFoeQDUwW2NzB3jKJw5L2d4QXUFStHzgwIBNe6czODs72+oVKF8o+sVIUcfweq
 /a6sVmg0L/k/KQ+Bu2KDaO/fxX4HQbdhK4k/Gt/7xnj8GuByofP8MmIlh66YPU/+u3lm
 GR3x3YZJdm6G+GYm4Pl5GQcevWiDSyIj8w5orGXnebRdy+LVzFgeSjHxO3iNiVEvRc3k
 H76IfTlGuGyPOY6VusiTc2+UHcde7wwtuOvMjchPiDDroeH8cTHImQeYQifxJ5WKaDSX
 hjBIhDZdGzvlCB2Lc09wHmrhuLWR3jb3A7l+geE5Apr/UXsI2X67uM8JcgrPEEJSy+yD Eg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g23726147-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 May 2022 01:09:24 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24K15nGg020186;
        Fri, 20 May 2022 01:09:23 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g37crytn0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 May 2022 01:09:23 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 24K19GKF030710;
        Fri, 20 May 2022 01:09:22 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g37crythd-6;
        Fri, 20 May 2022 01:09:22 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     linux-scsi@vger.kernel.org,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        Javed Hasan <jhasan@marvell.com>,
        Saurav Kashyap <skashyap@marvell.com>,
        Colin Ian King <colin.i.king@gmail.com>,
        GR-QLogic-Storage-Upstream@marvell.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: qedf: remove redundant variable op
Date:   Thu, 19 May 2022 21:09:05 -0400
Message-Id: <165300891232.11465.2010695834416245270.b4-ty@oracle.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220517092518.93159-1-colin.i.king@gmail.com>
References: <20220517092518.93159-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: psllGO-Rt0uEUHCVpQC5YSs9tzwSMfHV
X-Proofpoint-ORIG-GUID: psllGO-Rt0uEUHCVpQC5YSs9tzwSMfHV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 May 2022 10:25:18 +0100, Colin Ian King wrote:

> The variable op is assigned a value and is never read. The variable
> is not used and is redundant, remove it.
> 
> 

Applied to 5.19/scsi-queue, thanks!

[1/1] scsi: qedf: remove redundant variable op
      https://git.kernel.org/mkp/scsi/c/fc65df48c88e

-- 
Martin K. Petersen	Oracle Linux Engineering
