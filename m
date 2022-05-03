Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93246519DB0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 13:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348588AbiEDLQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 07:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348583AbiEDLQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 07:16:22 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A401570A;
        Wed,  4 May 2022 04:12:43 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 242MQhCd013665;
        Tue, 3 May 2022 00:51:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=sZdJgyADkeH3V7B3rM7EoeKb2SSRy28Z4nID5HsXg7Y=;
 b=AK/DVKeH3HlA7BlTqWeFFCnGrLuG3H/S6xyFVaIpqerQUDG9qsIA04ue2MwWz8igeODK
 7CDV3b+WLhc2YItuUp/BoNDZbOmzdkNv+oY6T9kdJvmkCvc44NAmn/2CuWwGPryZ7iOT
 86UOruexEcKulofqsymWP3YO/muuGjHZk4PLVXIZXP76bPQPkYSVfS0/9ZeX+RGrBTna
 ZOIhFRQcJZBD/qY8B+yuqqWwygffComRHkwsAJbow72qtPa2cPRFMMvEGg3pai7Q2YJI
 438RjuA7D0HwMt+hvKP/4G4LA9mjVH8709TXa113tbfH2OJGvOkBtIL3q8WmQCWR7KYW TA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frvqscnke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 May 2022 00:51:49 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2430ow5J009155;
        Tue, 3 May 2022 00:51:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruj83x5d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 May 2022 00:51:49 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 2430plj2010389;
        Tue, 3 May 2022 00:51:48 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruj83x4g-3;
        Tue, 03 May 2022 00:51:48 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     sudarsana.kalluru@qlogic.com, anil.gurumurthy@qlogic.com,
        Haowen Bai <baihaowen@meizu.com>, jejb@linux.ibm.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi: bfa: remove redundant NULL check
Date:   Mon,  2 May 2022 20:51:13 -0400
Message-Id: <165153836360.24053.2843259477177875270.b4-ty@oracle.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <1647309434-13936-1-git-send-email-baihaowen@meizu.com>
References: <1647309434-13936-1-git-send-email-baihaowen@meizu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: nBdh9Lcbqy45eL27iI1wMuEe7MLI9Z5d
X-Proofpoint-ORIG-GUID: nBdh9Lcbqy45eL27iI1wMuEe7MLI9Z5d
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Mar 2022 09:57:14 +0800, Haowen Bai wrote:

> Fix below warnings reported by coccicheck:
> drivers/scsi/bfa/bfad_debugfs.c:375:2-7: WARNING: NULL check before some freeing functions is not needed.
> 
> 

Applied to 5.19/scsi-queue, thanks!

[1/1] scsi: bfa: remove redundant NULL check
      https://git.kernel.org/mkp/scsi/c/8e897c84661e

-- 
Martin K. Petersen	Oracle Linux Engineering
