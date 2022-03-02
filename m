Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82B464C9D05
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 06:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239577AbiCBFOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 00:14:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239567AbiCBFOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 00:14:35 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71928B1527;
        Tue,  1 Mar 2022 21:13:49 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2222ZTui016801;
        Wed, 2 Mar 2022 05:13:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=I8Cvi+cPuQc47TPbs2QgHyjEqcva3j6D+kkqLW4QU98=;
 b=fpZJpurTTrGzrr/KKQI5E0qc5/JMx+DYudN7bkZxdmUfyKnk/3BWw9X9cI0aNRCO9xxN
 2W0eYzqchwKHphG/xgDZ7KF0N5oceE7tijPlCOOcKaH2ZMhR1Yk+IvJqWZGWx2eOjEty
 ACKN4v8dMqrcWskBpZ1nTq0m5KINb4NnDI/NNxK0QB6G2vAxRvxcDIRNrkyYtFI6zHhl
 2c529Ql9C0lf8bUMqJRigLDLHrFdT7BJ6RSCEr0Mx+nFv+yjjoIDINc5TiP3z4ulvmpS
 +Yqv/DZMr+p8v5/gfg7X3ZacCM0lmdqQT8gBUnMidDvigxDum+y5cF6tQkfufdgrK336 Ig== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ehdayu3fk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Mar 2022 05:13:40 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2225C0fL175174;
        Wed, 2 Mar 2022 05:13:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 3ef9ayxgpk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Mar 2022 05:13:39 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 2225DVPU178145;
        Wed, 2 Mar 2022 05:13:39 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by userp3030.oracle.com with ESMTP id 3ef9ayxgcv-8;
        Wed, 02 Mar 2022 05:13:39 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     John Garry <john.garry@huawei.com>, jejb@linux.ibm.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH 0/6] hisi_sas: Some misc updates
Date:   Wed,  2 Mar 2022 00:13:26 -0500
Message-Id: <164619702113.16127.16130590731146695188.b4-ty@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <1645703489-87194-1-git-send-email-john.garry@huawei.com>
References: <1645703489-87194-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: UQoZBqozYefv-XZJbxdL-DZAyzodcpYB
X-Proofpoint-ORIG-GUID: UQoZBqozYefv-XZJbxdL-DZAyzodcpYB
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Feb 2022 19:51:23 +0800, John Garry wrote:

> This series includes some updates as following:
> - better management of freeing PCI vectors
>   - hopefully the following series can make it soon so we may remove this
>     new code:
>     https://lore.kernel.org/linux-pci/20210607153916.1021016-1-zhengdejin5@gmail.com/T/#md27a594ac53b8e05abb2f22ec350137b9023ff18
> - Fix prot_mask module param permissions
> - Change phyup timeout to handle some special SATA disks
> - modify underflow handling to quickly identify faulty disks
> - debugfs hardening
> 
> [...]

Applied to 5.18/scsi-queue, thanks!

[1/6] scsi: hisi_sas: Change permission of parameter prot_mask
      https://git.kernel.org/mkp/scsi/c/c4e070457a93
[2/6] scsi: hisi_sas: Change hisi_sas_control_phy() phyup timeout
      https://git.kernel.org/mkp/scsi/c/512623de5239
[3/6] scsi: hisi_sas: Free irq vectors in order for v3 HW
      https://git.kernel.org/mkp/scsi/c/554fb72ee34f
[4/6] scsi: hisi_sas: Rename error labels in hisi_sas_v3_probe()
      https://git.kernel.org/mkp/scsi/c/86287065fac2
[5/6] scsi: hisi_sas: Limit users changing debugfs BIST count value
      https://git.kernel.org/mkp/scsi/c/286ce4c65fbd
[6/6] scsi: hisi_sas: Modify v3 HW SSP underflow error processing
      https://git.kernel.org/mkp/scsi/c/62413199cd6d

-- 
Martin K. Petersen	Oracle Linux Engineering
