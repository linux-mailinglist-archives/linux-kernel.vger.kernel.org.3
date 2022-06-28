Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2BE455D4D7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbiF1D0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 23:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbiF1DZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 23:25:32 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE95D255B4;
        Mon, 27 Jun 2022 20:25:13 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25S1RcSC026411;
        Tue, 28 Jun 2022 03:24:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=ox5pI0dqwysqglru5CQNaWew9ZwuC8UBAfkl4k/wQQs=;
 b=jnr6SfiHFOojTmPvz1w9sbvYoUiAXA1CmjhYMBbpcBkBmXTPpOVxVNN8FI7jDiHFWOEn
 YP2EEZlGwq0VXCiesvvI9hYjfxDqsvJknzUU/WHR95xM0fbBzjVW2Ou/4qfCQkLSoP52
 5Ak2gqfzpGH2osML9suj0KRoraxEjdo1t88OOyazmWCapQKCwi30e2Q72Sz3U9yM8J+1
 JgB6bcHlm+ETyUzOR4kwh8kqcdhI0bCYRDIejgoi0cD4a6b4bB40vJvkK95rkycYBm7D
 Rnx7UT6OGrgUNKEzU5Yt4YOOLMze/9gip53amtdExrwof7mvUklP0Iu/Cz2+q6DwhfhL Jw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gwsyscrs5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jun 2022 03:24:59 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25S3F37W002629;
        Tue, 28 Jun 2022 03:24:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gwrt7jjm7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jun 2022 03:24:58 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 25S3Nvq8016584;
        Tue, 28 Jun 2022 03:24:58 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gwrt7jjkg-6;
        Tue, 28 Jun 2022 03:24:58 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     willy@infradead.org, Jiang Jian <jiangjian@cdjrlc.com>,
        jejb@linux.ibm.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi: sym53c8xx_2: Remove duplicate 'with' in two places.
Date:   Mon, 27 Jun 2022 23:24:44 -0400
Message-Id: <165638665786.7726.17246600176789337258.b4-ty@oracle.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220621162631.25353-1-jiangjian@cdjrlc.com>
References: <20220621162631.25353-1-jiangjian@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Rzgm9yz12LBHNIXyjudRZ-4s29RQj7sb
X-Proofpoint-GUID: Rzgm9yz12LBHNIXyjudRZ-4s29RQj7sb
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jun 2022 00:26:31 +0800, Jiang Jian wrote:

> file: drivers/scsi/sym53c8xx_2/sym_hipd.c
> line: 3601
>   *  Gerard's alchemy:) that deals with with the data
> changed to
>   *  Gerard's alchemy:) that deals with the data
> 
> 
> [...]

Applied to 5.20/scsi-queue, thanks!

[1/1] scsi: sym53c8xx_2: Remove duplicate 'with' in two places.
      https://git.kernel.org/mkp/scsi/c/bc98b503b111

-- 
Martin K. Petersen	Oracle Linux Engineering
