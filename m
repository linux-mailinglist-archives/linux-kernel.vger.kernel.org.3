Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57ED64F80B0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 15:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343690AbiDGNhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 09:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343689AbiDGNhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 09:37:35 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA761109;
        Thu,  7 Apr 2022 06:35:22 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 237A6u7u024447;
        Thu, 7 Apr 2022 13:35:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=plnEtZF86isv65a8puHtZOzw2xcyhXCk0JU+ZyMN+9I=;
 b=z0acsNfFVSNApqvfkmPnwzZvZd5HN+GUBSDHeCYVaYbzUsYyzD0hoF0UP047fzRTHb+X
 y6R2qouRyKpMR4Xf9NIpCZJrFA31pq7B+QhA7Rx0ExTKIJzXln77KN+f+37YQuRZu47f
 WjZn78Aj9xA0cUmE4ev0o1MUos0blpLZzovbC+XHg1O4T5uPAqcOQzPKM3Afs8udgjDK
 O6KlpPrK65MCZZHizur7v6JLYief4Xre+kMU9kYumd/4ZfxzipMXQ8y15eQywr+Zv6lB
 BtoGzRzZsuIBRcXA6KzbasF1HJByLfsWOMo0DNcLHRGyQ2cpewXBTw7FmFWgBlwzw81w vQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6f1tc3qy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Apr 2022 13:35:21 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 237DLVn1036817;
        Thu, 7 Apr 2022 13:35:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f97uwtvqv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Apr 2022 13:35:20 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 237DZJLg032479;
        Thu, 7 Apr 2022 13:35:19 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f97uwtvpy-1;
        Thu, 07 Apr 2022 13:35:19 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     linux-scsi@vger.kernel.org
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] scsi: bnx2fc: Fix spelling mistake "mis-match" -> "mismatch"
Date:   Thu,  7 Apr 2022 09:35:00 -0400
Message-Id: <164929679002.15424.1799871728349449815.b4-ty@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220319231122.21476-1-colin.i.king@gmail.com>
References: <20220319231122.21476-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 5g9tPed7M2ZeAktsEZzpftQeYyNZ2ZyM
X-Proofpoint-GUID: 5g9tPed7M2ZeAktsEZzpftQeYyNZ2ZyM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Mar 2022 23:11:22 +0000, Colin Ian King wrote:

> There are a few spelling mistakes in some error messages. Fix them.
> 
> 

Applied to 5.18/scsi-fixes, thanks!

[1/1] scsi: bnx2fc: Fix spelling mistake "mis-match" -> "mismatch"
      https://git.kernel.org/mkp/scsi/c/7ff897b2a595

-- 
Martin K. Petersen	Oracle Linux Engineering
