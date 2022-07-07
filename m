Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B26956ADF2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 23:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236912AbiGGVrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 17:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236585AbiGGVro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 17:47:44 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9418333E10;
        Thu,  7 Jul 2022 14:47:43 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 267KCYii015405;
        Thu, 7 Jul 2022 21:47:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=JjQ0l5P4/brIqoEehikrzY4jsz+xuJ+ncd6CB5T056A=;
 b=vxyw9oocedBKCfeRculAZnLaIqbRm+S4mOJLQWj/xthcGSz7C5/iK1tIt/rMjWYBsrAy
 MvZSLmS06EGKYkTWJ2qVxNFz48+wpcZWwBRwoLK1Kx/f32joJyFEda52Gv/SMNPEShSg
 Lsqam/0BLao7Cv0739Vc0IHUAXjZSEMb6SU9JrTEjKp7VXq9v8AvwaAw/5QbU3WhcZHk
 dm64uGkG/5+5T7t85lCKsKXXETnyuY1zgjNnG4wgz/nxU+/LYCE6M+YTRFprSzuHlBmU
 7VaIj+cZW2hrSg770RWqjWDTo9Zw/LpNrMftW5XbtzJvIR2FMMa3IT5wQ9goXdQLuL4k 9w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4ubyxbm6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Jul 2022 21:47:34 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 267LjMi3030312;
        Thu, 7 Jul 2022 21:47:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h4ud7c5f2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Jul 2022 21:47:33 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 267LlRsg033607;
        Thu, 7 Jul 2022 21:47:33 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h4ud7c5ag-5;
        Thu, 07 Jul 2022 21:47:32 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        jejb@linux.ibm.com, alim.akhtar@samsung.com,
        Stanley Chu <stanley.chu@mediatek.com>, bvanassche@acm.org,
        avri.altman@wdc.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        cc.chou@mediatek.com, eddie.huang@mediatek.com,
        powen.kao@mediatek.com, qilin.tan@mediatek.com,
        chaotian.jing@mediatek.com, lin.gui@mediatek.com,
        alice.chao@mediatek.com, tun-yu.yu@mediatek.com,
        peter.wang@mediatek.com, mason.zhang@mediatek.com,
        jiajie.hao@mediatek.com, chun-hung.wu@mediatek.com
Subject: Re: [PATCH v2 0/8] Provide features and fixes in MediaTek UFS platform
Date:   Thu,  7 Jul 2022 17:47:24 -0400
Message-Id: <165723020283.18731.6922062576024151133.b4-ty@oracle.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220623035052.18802-1-stanley.chu@mediatek.com>
References: <20220623035052.18802-1-stanley.chu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: WaJzllHnZVE28Ea29Dxb7gFx-V1O-QCq
X-Proofpoint-GUID: WaJzllHnZVE28Ea29Dxb7gFx-V1O-QCq
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jun 2022 11:50:44 +0800, Stanley Chu wrote:

> This series provides some fixes and features in MediaTek UFS platform.
> Please consider this patch series for kernel v5.20.
> 
> Compared to v1:
> - Add one patch to fix invalid access to vccqx
> 
> Alice Chao (1):
>   scsi: ufs-mediatek: Fix invalid access to vccqx
> 
> [...]

Applied to 5.20/scsi-queue, thanks!

[1/8] scsi: ufs-mediatek: Fix build warnings
      https://git.kernel.org/mkp/scsi/c/e7bf1d50063c
[2/8] scsi: ufs-mediatek: Always add delays for VCC operations
      https://git.kernel.org/mkp/scsi/c/981b4ac04c2f
[3/8] scsi: ufs-mediatek: Prevent host hang by setting CLK_CG early
      https://git.kernel.org/mkp/scsi/c/2bae03a6ac98
[4/8] scsi: ufs-mediatek: Add stage information for ref-clk control
      https://git.kernel.org/mkp/scsi/c/f53f19135765
[5/8] scsi: ufs-mediatek: Disable reset confirm feature by UniPro
      https://git.kernel.org/mkp/scsi/c/4918694ccd69
[6/8] scsi: ufs-mediatek: Support host power control
      https://git.kernel.org/mkp/scsi/c/2cf5cb2bb131
[7/8] scsi: ufs-mediatek: Support performance boosting
      https://git.kernel.org/mkp/scsi/c/c64c487d9533
[8/8] scsi: ufs-mediatek: Fix invalid access to vccqx
      https://git.kernel.org/mkp/scsi/c/df1ea242e3d7

-- 
Martin K. Petersen	Oracle Linux Engineering
