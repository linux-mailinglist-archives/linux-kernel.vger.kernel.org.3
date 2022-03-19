Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E50E4DE5C4
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 04:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242051AbiCSD7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 23:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242040AbiCSD6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 23:58:50 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D108110DA56;
        Fri, 18 Mar 2022 20:57:28 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22J2ro5B012531;
        Sat, 19 Mar 2022 03:57:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=Msyo+xNQ+/2brjqxsHaiS1x3YoJCJy4TFJK18oiJBoQ=;
 b=lNBYpDtvWGsj6J7uJ8IOtHYH87PwfPsG3Kuy5sPQbdyh+Zk6JQIAIqSc4/g/exT8cRFE
 EtByyz1t+dT4kL3LNcwdBGZcMrbzyAoCXNpXJv9YDbEEBUHiii0+ZcplYTysU5w9EL+H
 mNhsE9x+/WoqVloJsGY0qq+bk159KteysO031EmuHG1Mc3HsROC0Jg/Z+U5AhMXIJYnQ
 WI2EQHn8DHIafYBVrr39MgEvzaMJdjDE2NwXJKPfsw28dqbZFTx216WwRhD+kRvHgNCH
 bPZ9v3Fk4HZhD16T8z1rmSCJDQOfjDJW+v/BLdY/Tkgq42Sd6sIrryNJfOiGxWwU/Yoc dQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ew6ss017b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 19 Mar 2022 03:57:22 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 22J3vFch007277;
        Sat, 19 Mar 2022 03:57:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3ew5kyshq7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 19 Mar 2022 03:57:21 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 22J3v5R2007126;
        Sat, 19 Mar 2022 03:57:21 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3ew5kyshmn-13;
        Sat, 19 Mar 2022 03:57:20 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     kashyap.desai@broadcom.com, Yang Li <yang.lee@linux.alibaba.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        jejb@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>,
        shivasharan.srikanteshwara@broadcom.com,
        megaraidlinux.pdl@broadcom.com, sumit.saxena@broadcom.com
Subject: Re: [PATCH -next v2] scsi: megasas: clean up some inconsistent indenting
Date:   Fri, 18 Mar 2022 23:57:03 -0400
Message-Id: <164766213030.31329.13079818808922373530.b4-ty@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220225011605.130927-1-yang.lee@linux.alibaba.com>
References: <20220225011605.130927-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: a-5HdJlwGoSJXYMEXQl8hHF9pnDXDXIE
X-Proofpoint-GUID: a-5HdJlwGoSJXYMEXQl8hHF9pnDXDXIE
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Feb 2022 09:16:05 +0800, Yang Li wrote:

> Eliminate the follow smatch warning:
> drivers/scsi/megaraid/megaraid_sas_fusion.c:5104 megasas_reset_fusion()
> warn: inconsistent indenting
> 
> 

Applied to 5.18/scsi-queue, thanks!

[1/1] scsi: megasas: clean up some inconsistent indenting
      https://git.kernel.org/mkp/scsi/c/7db304bd2a4f

-- 
Martin K. Petersen	Oracle Linux Engineering
