Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D53581E20
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 05:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240326AbiG0DQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 23:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240296AbiG0DQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 23:16:22 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132EADF95;
        Tue, 26 Jul 2022 20:16:13 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26R2oK84009181;
        Wed, 27 Jul 2022 03:16:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2022-7-12;
 bh=v0JsU5gY8oQjUzpm6RnYGbDeKU4KlqHaXe00iCatyXI=;
 b=e1+ZNQmDpvHZ9uuzD6rWUz87Re4DQLu4S+/iTTCXjbwkHth2vdk9E74ywQMG2fWgF3T3
 InOuM5FwJy43tt958xCxLDBkR6Z1nFYyg+b8g1pvEcyh+g6JNQW544vuqP4k93Jz8V/H
 dU46o2e5/SE5sCU3qHfMSezRwXS5jkR9+sDkF0NIATkPkUZnfT2eEJtuaKMpVUwGUjzy
 GnWMud5KD5qG9+pN6RgVARm4PFNEbz41zUOQn2lRjbTRwF1a5mp4HVKa387RAb/XJb+W
 sBlPEmhD4LlXPAQIPq62ygDs0UCu3xaq5NejdpHANgbyvs0lScDhlPHPlsXlk3TverzW Ew== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg9anyu45-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jul 2022 03:16:04 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26R2avdB035387;
        Wed, 27 Jul 2022 03:16:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hh633p3wg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jul 2022 03:16:03 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26R3E0h0008228;
        Wed, 27 Jul 2022 03:16:02 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3hh633p3uc-4;
        Wed, 27 Jul 2022 03:16:02 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     John Garry <john.garry@huawei.com>, jejb@linux.ibm.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH 0/5] hisi_sas/libsas: Some misc patches
Date:   Tue, 26 Jul 2022 23:15:57 -0400
Message-Id: <165889172881.804.324470301794752070.b4-ty@oracle.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <1657823002-139010-1-git-send-email-john.garry@huawei.com>
References: <1657823002-139010-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-26_07,2022-07-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207270009
X-Proofpoint-ORIG-GUID: YaTfZg7r3-DOx02HckQYORisDMAnbP43
X-Proofpoint-GUID: YaTfZg7r3-DOx02HckQYORisDMAnbP43
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jul 2022 02:23:17 +0800, John Garry wrote:

> This is just some random patches which I have collected for the hisi_sas
> driver and libsas over the last cycle, described briefly as follows:
> - Remove some duplication in slave_configure_v3_hw()
> - Some DMA mapping API usage tidying
> - v3 HW SATA completion error processing improvement
> - For libsas, resume host when changing phy settings via sysfs - our test
>   guys seem to find it useful.
> 
> [...]

Applied to 5.20/scsi-queue, thanks!

[1/5] scsi: hisi_sas: Call hisi_sas_slave_configure() from slave_configure_v3_hw()
      https://git.kernel.org/mkp/scsi/c/eed9f513bf7f
[2/5] scsi: hisi_sas: Remove unnecessary variable to hold DMA map elements
      https://git.kernel.org/mkp/scsi/c/bc22f9c06c25
[3/5] scsi: hisi_sas: Relocate DMA unmap of SMP task
      https://git.kernel.org/mkp/scsi/c/f0902095a773
[4/5] scsi: hisi_sas: Modify v3 HW SATA completion error processing
      https://git.kernel.org/mkp/scsi/c/7e15334f5d25
[5/5] scsi: libsas: Resume SAS host for phy reset or enable via sysfs
      https://git.kernel.org/mkp/scsi/c/1e82e4627a79

-- 
Martin K. Petersen	Oracle Linux Engineering
