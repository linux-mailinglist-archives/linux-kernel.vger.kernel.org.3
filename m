Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF48656ADF0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 23:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236741AbiGGVrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 17:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236591AbiGGVrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 17:47:37 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2863B326ED;
        Thu,  7 Jul 2022 14:47:37 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 267KCGNv013690;
        Thu, 7 Jul 2022 21:47:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=r4GA/e2Ds6r8ycLNrqQ+4ZUXJuV3tf2p3MJjCha7Ka4=;
 b=mXolM6ITF+wSr8T3cc3oEiw6LTAn+Qdv26yZk06Kc+N2WUyAF+1qeDOUsXaE+FQ0FDwU
 o66AzbcGbjet2hPtALH/cy7seoC7grQC1Nq+hvMAu/wvgGtcbids+DceCrkyQ8UZPX+I
 zr0uwZf9EYbWn/Xiv4/Nw9hZyfxzSQPRxYZo6Zls2RYo02dazVI353XacooftxpQ3NQE
 b/fA5zrIa5+ysXZrCRYmRRF9AK7adAl+mU9Q9mNiebmqpulUSdCAvG5DLXasXnHumaEC
 bfiprym4CBVK1fsWB9gxmImEJQ3CRs+V22oVzP+b2IyUgCnQVauhKv3NOzTwFs10hUqE og== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4ubyehr2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Jul 2022 21:47:32 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 267LjMi2030312;
        Thu, 7 Jul 2022 21:47:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h4ud7c5e4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Jul 2022 21:47:31 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 267LlRse033607;
        Thu, 7 Jul 2022 21:47:30 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h4ud7c5ag-4;
        Thu, 07 Jul 2022 21:47:30 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     linux-scsi@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-kernel@vger.kernel.org, Doug Gilbert <dgilbert@interlog.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-ide@vger.kernel.org
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v4 0/3] scsi: ufs: minor cleanups
Date:   Thu,  7 Jul 2022 17:47:23 -0400
Message-Id: <165723020282.18731.7951148837837594639.b4-ty@oracle.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220623102432.108059-1-krzysztof.kozlowski@linaro.org>
References: <20220623102432.108059-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: CTdfMFP-qeyHuiIHr95vnzGvt_8PZ_U-
X-Proofpoint-GUID: CTdfMFP-qeyHuiIHr95vnzGvt_8PZ_U-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jun 2022 12:24:29 +0200, Krzysztof Kozlowski wrote:

> Changes since v3
> ================
> 1. Patch 3: make array static const, correct language in commit msg (Bart).
> 2. Add Rb tags.
> 
> Changes since v2
> ================
> 1. More whitespace cleanups.
> 
> [...]

Applied to 5.20/scsi-queue, thanks!

[2/3] scsi: ufs: ufshcd-pltfrm: constify pointed data
      https://git.kernel.org/mkp/scsi/c/a48aac5dfc1b
[3/3] scsi: ufs: ufshcd: constify pointed data
      https://git.kernel.org/mkp/scsi/c/35d11ec239e0

-- 
Martin K. Petersen	Oracle Linux Engineering
