Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B4351B639
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 04:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240290AbiEEDAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 23:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240161AbiEEDAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 23:00:08 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5493313DC8;
        Wed,  4 May 2022 19:56:30 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 242Nnl5h025194;
        Tue, 3 May 2022 00:51:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=DZRyLUARGbpvjj9KLE8couN5sqcicCf2H9NcWm/lQeo=;
 b=tZUt5C97u62nlPQz4nVrqHZ99oviz+0sWlquG9KEV6KSJmIUy7eSIdQ/28AriRhAzaN+
 gw8yF2P3QrRDDyKv4DbXCzeGh8NjzWjAlxZn61P5AA/0qj+LvSzbUFUw4FJvzcIHw1ym
 dRJnANaLmjX9gZUAP6SDTnFDHGA2AwKJTwd+qnnNBRpLi7LQI7SxVadtIVNjVwSAOUDa
 CVgd8/v544Tf34CEQcRppFk5Jj6jSoxgyhjjqi3cWC9mal5SNH0LbI6WKh0yOh4zDOGP
 M+5c9kvpAA5/avqRKNKFVJzS4QjOhBrLm2Paw8ZFG+pYjWE2h08auytyp9jscz0cbXSr yg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruw2cnx5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 May 2022 00:51:50 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2430oo10008891;
        Tue, 3 May 2022 00:51:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruj83x5k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 May 2022 00:51:49 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 2430plj4010389;
        Tue, 3 May 2022 00:51:49 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruj83x4g-4;
        Tue, 03 May 2022 00:51:49 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Haowen Bai <baihaowen@meizu.com>, jejb@linux.ibm.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi: fnic: remove redundant NULL check
Date:   Mon,  2 May 2022 20:51:14 -0400
Message-Id: <165153836360.24053.10929907009827872411.b4-ty@oracle.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <1647309219-12772-1-git-send-email-baihaowen@meizu.com>
References: <1647309219-12772-1-git-send-email-baihaowen@meizu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: dTvflSWKDBRWbpLhG3m55XEtZwl1Pw43
X-Proofpoint-ORIG-GUID: dTvflSWKDBRWbpLhG3m55XEtZwl1Pw43
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Mar 2022 09:53:39 +0800, Haowen Bai wrote:

> Fix below warnings reported by coccicheck:
> drivers/scsi/fnic/fnic_debugfs.c:90:2-7: WARNING: NULL check before some freeing functions is not needed.
> 
> 

Applied to 5.19/scsi-queue, thanks!

[1/1] scsi: fnic: remove redundant NULL check
      https://git.kernel.org/mkp/scsi/c/1dcd96c4d0b7

-- 
Martin K. Petersen	Oracle Linux Engineering
