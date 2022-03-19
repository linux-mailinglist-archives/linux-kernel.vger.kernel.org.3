Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA964DE5B9
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 04:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241397AbiCSD6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 23:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbiCSD6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 23:58:35 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A20E9956;
        Fri, 18 Mar 2022 20:57:16 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22J3BgIV000642;
        Sat, 19 Mar 2022 03:57:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=p4sN4qN9pWmB3yb4ixY/ci0/kjh1yq26mnWC9GVqkfw=;
 b=Xb4j0QpxUpmI1AN+X5OsY4ho7Y2x+5qPDXc/S8YEiGQmhh2q/l4ChunDSP4HaAoZ8w1p
 HR/YzK/Mj1aJiCPzJF9w9vFFwFV10DxT5X46ZIyb8Mx4BMgCAcGk+3Q4aikY7399NpSA
 vdhi7WLbM8PvpK9jiT32fsEuAPXBox1CYGUS7tHEDgTSMveCwnesM/ZXQOweAScGkeBe
 u53PFnveqHoXtKJfxo1bNAUjHD5U8CFec56fqTglcnSUrn2gx74soLUZyx99GzOMh7Ip
 Tk38DYB7NFOhrmpnuc2WjHPDdus606MzLb3bcatjLF7prNT5ItTlJR5lmsGZlc/6jX4f VA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ew72a8100-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 19 Mar 2022 03:57:07 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 22J3uwjI007048;
        Sat, 19 Mar 2022 03:57:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3ew5kyshn3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 19 Mar 2022 03:57:07 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 22J3v5Qe007126;
        Sat, 19 Mar 2022 03:57:06 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3ew5kyshmn-2;
        Sat, 19 Mar 2022 03:57:06 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        aacraid@microsemi.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, jejb@linux.ibm.com,
        linux-scsi@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] scsi: aacraid: Clean up some inconsistent indenting
Date:   Fri, 18 Mar 2022 23:56:52 -0400
Message-Id: <164766213030.31329.17782063202173129281.b4-ty@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220309005031.126504-1-jiapeng.chong@linux.alibaba.com>
References: <20220309005031.126504-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: W_i59zybDNEL2nCctDpkxNIoH7F8qV7m
X-Proofpoint-ORIG-GUID: W_i59zybDNEL2nCctDpkxNIoH7F8qV7m
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Mar 2022 08:50:31 +0800, Jiapeng Chong wrote:

> Eliminate the follow smatch warning:
> 
> drivers/scsi/aacraid/linit.c:867 aac_eh_tmf_hard_reset_fib() warn:
> inconsistent indenting.
> 
> 

Applied to 5.18/scsi-queue, thanks!

[1/1] scsi: aacraid: Clean up some inconsistent indenting
      https://git.kernel.org/mkp/scsi/c/f089ce7bb5ee

-- 
Martin K. Petersen	Oracle Linux Engineering
