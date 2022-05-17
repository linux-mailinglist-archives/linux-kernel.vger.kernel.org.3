Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD5952973F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 04:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238064AbiEQCRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 22:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233962AbiEQCQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 22:16:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5983CA7A;
        Mon, 16 May 2022 19:16:56 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24GLID38024438;
        Tue, 17 May 2022 02:16:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=smagVzCsCa5WwECZ+pvG381cQ8nXzfr3Ox/fBU577QY=;
 b=rS+Gk6o51G4nRQQgCfzPfFtNnC+4nhU7VXmZo7/MlFqL57Q+VxC/KiH+LCCoARbkdYJ7
 i9dkiFPfOOlaTOmTzYXRB5TQOVGsgFk0lWJiPtGb32WiJV0sq/OjX5wdbPPpRw6yO0Wu
 k0qslkTHSInHF/KERZbjFvQp909Vox2Tv/v6fBAC1mFMS9MJXqf6M4w1V1bkxAqxpU26
 UoediHhAQcdGa3cdrX8lgv7Yu3wi1kFAJ2oMK8quTmZxJSknaYS3niZIz0ELa1Dwhl3D
 AFT0+0vciU7P5t3b2sifiYERrwkkgVj18xho2yBWU8NiYDSUA/1mZRI4cImQfQk7BNzD KQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g22uc4tn6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 May 2022 02:16:46 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24H2G8tq019199;
        Tue, 17 May 2022 02:16:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g22v83hma-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 May 2022 02:16:45 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 24H2Ghw1019875;
        Tue, 17 May 2022 02:16:45 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g22v83hkf-4;
        Tue, 17 May 2022 02:16:45 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        jejb@linux.ibm.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        bjorn.andersson@linaro.org, quic_cang@quicinc.com,
        alim.akhtar@samsung.com, avri.altman@wdc.com,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, ahalaney@redhat.com,
        quic_asutoshd@quicinc.com, bvanassche@acm.org
Subject: Re: [PATCH v3 0/5] Qcom UFS driver updates
Date:   Mon, 16 May 2022 22:16:39 -0400
Message-Id: <165275376860.24722.11138816574291859503.b4-ty@oracle.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220504084212.11605-1-manivannan.sadhasivam@linaro.org>
References: <20220504084212.11605-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: qm932dHcubG1OkvVIrvchEhXbjh7X6O-
X-Proofpoint-ORIG-GUID: qm932dHcubG1OkvVIrvchEhXbjh7X6O-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 May 2022 14:12:07 +0530, Manivannan Sadhasivam wrote:

> This series has some cleanups and updates to the Qcom UFS driver. There
> is also a patch that removes the redundant wmb() from
> ufshcd_send_command() in ufshcd driver.
> 
> All these patches are tested on Qualcomm Robotics RB3 platform.
> 
> Thanks,
> Mani
> 
> [...]

Applied to 5.19/scsi-queue, thanks!

[1/5] scsi: ufs: qcom: Fix acquiring the optional reset control line
      https://git.kernel.org/mkp/scsi/c/223b17ed76eb
[2/5] scsi: ufs: qcom: Simplify handling of devm_phy_get()
      https://git.kernel.org/mkp/scsi/c/c9ed9a6c56af
[3/5] scsi: ufs: qcom: Add a readl() to make sure ref_clk gets enabled
      https://git.kernel.org/mkp/scsi/c/8eecddfca30e
[4/5] scsi: ufs: core: Remove redundant wmb() in ufshcd_send_command()
      https://git.kernel.org/mkp/scsi/c/23803bacaab4
[5/5] scsi: ufs: qcom: Enable RPM_AUTOSUSPEND for runtime PM
      https://git.kernel.org/mkp/scsi/c/6f21d9274c77

-- 
Martin K. Petersen	Oracle Linux Engineering
