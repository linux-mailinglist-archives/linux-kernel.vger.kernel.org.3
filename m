Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17E4350EF77
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 06:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243732AbiDZEEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 00:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243682AbiDZED6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 00:03:58 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7063C11A14;
        Mon, 25 Apr 2022 21:00:52 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23Q2sGwi031281;
        Tue, 26 Apr 2022 04:00:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=I1l1aAzQRDINS4mBCzhN2uhZtzBK3Z60AQTHuPJJmTQ=;
 b=D+JiAAr228fN01F1MN8KjkG3zDfOn9QzGQIgQIkvLtfTtpqE5ObL4fzDFAj3tTmO0rTT
 lLsaQ8UGteDAiD4T8E48OFz71LDZxiS9jH9wogGbfY4PguYODplYYs5CxAAfUPpJCtjb
 3uXwNAXDgafWp9seskn3kvFkEtLRjD/GbRR5JbTZcvID4q0GyemB5qxxx8CYaVi4pOl/
 kz3xp2sVSd7ae29zwl3JkwFVJTys5/3bGLsr9T8sO1ftUmL5H2uPpSZLLNdaNmBe+pib
 80a5nn5t1ibAg3P5SRcmv7chrgSTHLsNeQW4lV39ZdAJcelc23rQVMREY68S3X7IA6TZ mg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmbb4mt4p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 04:00:47 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23Q40RKo029511;
        Tue, 26 Apr 2022 04:00:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fp5yj3v1h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 04:00:46 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 23Q40juR030030;
        Tue, 26 Apr 2022 04:00:46 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fp5yj3v10-2;
        Tue, 26 Apr 2022 04:00:46 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, jejb@linux.ibm.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Abaci Robot <abaci@linux.alibaba.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: pmcraid: Remove unneeded semicolon
Date:   Tue, 26 Apr 2022 00:00:41 -0400
Message-Id: <165094528687.21993.15636481212056184457.b4-ty@oracle.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220401030640.28246-1-jiapeng.chong@linux.alibaba.com>
References: <20220401030640.28246-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 2terqubOhzV6-tbLv1YnU-UpG6nYxl3C
X-Proofpoint-GUID: 2terqubOhzV6-tbLv1YnU-UpG6nYxl3C
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Apr 2022 11:06:40 +0800, Jiapeng Chong wrote:

> Fix the following coccicheck warnings:
> 
> ./drivers/scsi/pmcraid.c:4593:2-3: Unneeded semicolon.
> 
> 

Applied to 5.19/scsi-queue, thanks!

[1/1] scsi: pmcraid: Remove unneeded semicolon
      https://git.kernel.org/mkp/scsi/c/21a023ce397b

-- 
Martin K. Petersen	Oracle Linux Engineering
