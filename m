Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E70955D1BF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234322AbiF1D0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 23:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbiF1DZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 23:25:34 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929CE25C4D;
        Mon, 27 Jun 2022 20:25:15 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25S0uqoE002157;
        Tue, 28 Jun 2022 03:25:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=mhRYrwrdEVUyJTZMUcSbnZcHfY2diOyWfIhBcpExmUI=;
 b=YeyrHQrYRXVwVBmcVCOK2kDO9TorNTA5VB4ajD3ADd2S20wc8G4MpDC6uGxcoWivkWh7
 gVqQ6QHubcRAha57TiqWNPi0F3dLeGt19UrxqdNR24DNJImJFPmHURUSB+4wwgewjpuQ
 n/vzJyE12TburwZbTZ20YNkzK0ArDMop5cscZDpKpQlYbTdbxGzxiFszhi8Pba04sQbc
 aZTOPbS4KPlhfDbEgZm0+avohuu1Njca92Q6yfrkqeZUD4oCvJGLn+Z+LkB6VVd7Mqxi
 cpx6L6MHxxkjDXegYXwuwPL14RMncUCcq78pFuVRy2PGpf30QFO5N3kyqg6rIQKofjSx Vw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gws52cuq3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jun 2022 03:25:03 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25S3F1p5002510;
        Tue, 28 Jun 2022 03:25:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gwrt7jjns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jun 2022 03:25:03 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 25S3NvqO016584;
        Tue, 28 Jun 2022 03:25:02 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gwrt7jjkg-14;
        Tue, 28 Jun 2022 03:25:02 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     matthias.bgg@gmail.com, stanley.chu@mediatek.com,
        jejb@linux.ibm.com, powen.kao@mediatek.com,
        Ren Zhijie <renzhijie2@huawei.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH -next] scsi: ufs: ufs-mediatek: Fix build error and type unmatch
Date:   Mon, 27 Jun 2022 23:24:52 -0400
Message-Id: <165638665782.7726.5510380683354329362.b4-ty@oracle.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220619115432.205504-1-renzhijie2@huawei.com>
References: <20220619115432.205504-1-renzhijie2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 3boWjZ63gARTFCZNv0ieh5AH9WDu0tt7
X-Proofpoint-GUID: 3boWjZ63gARTFCZNv0ieh5AH9WDu0tt7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Jun 2022 19:54:32 +0800, Ren Zhijie wrote:

> If CONFIG_PM_SLEEP is not set.
> 
> make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-, will be failed, like this:
> 
> drivers/ufs/host/ufs-mediatek.c: In function ‘ufs_mtk_vreg_fix_vcc’:
> drivers/ufs/host/ufs-mediatek.c:688:46: warning: format ‘%u’ expects argument of type ‘unsigned int’, but argument 4 has type ‘long unsigned int’ [-Wformat=]
>     snprintf(vcc_name, MAX_VCC_NAME, "vcc-opt%u", res.a1);
>                                              ~^   ~~~~~~
>                                              %lu
> drivers/ufs/host/ufs-mediatek.c: In function ‘ufs_mtk_system_suspend’:
> drivers/ufs/host/ufs-mediatek.c:1371:8: error: implicit declaration of function ‘ufshcd_system_suspend’; did you mean ‘ufs_mtk_system_suspend’? [-Werror=implicit-function-declaration]
>   ret = ufshcd_system_suspend(dev);
>         ^~~~~~~~~~~~~~~~~~~~~
>         ufs_mtk_system_suspend
> drivers/ufs/host/ufs-mediatek.c: In function ‘ufs_mtk_system_resume’:
> drivers/ufs/host/ufs-mediatek.c:1386:9: error: implicit declaration of function ‘ufshcd_system_resume’; did you mean ‘ufs_mtk_system_resume’? [-Werror=implicit-function-declaration]
>   return ufshcd_system_resume(dev);
>          ^~~~~~~~~~~~~~~~~~~~
>          ufs_mtk_system_resume
> cc1: some warnings being treated as errors
> 
> [...]

Applied to 5.20/scsi-queue, thanks!

[1/1] scsi: ufs: ufs-mediatek: Fix build error and type unmatch
      https://git.kernel.org/mkp/scsi/c/f54912b228a8

-- 
Martin K. Petersen	Oracle Linux Engineering
