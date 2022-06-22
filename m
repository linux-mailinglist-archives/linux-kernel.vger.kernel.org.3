Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F02BA554069
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 04:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356199AbiFVCKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 22:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232483AbiFVCKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 22:10:31 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11B9338AD;
        Tue, 21 Jun 2022 19:10:30 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25M0J8wm011432;
        Wed, 22 Jun 2022 02:10:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=pd/lIFKzWE4I7Kn7X/ukG84VnGOkmKLwAry+/UOI+8M=;
 b=r3F77uQb0ilQCCDUO4J7w4dNJ6iPxZ7EVMKlpFgMCyolLQqHLunkzXl6qEhZr+ghDqnT
 hIVDezfXHVNouRBiaYxst19ZYiybJVQiE1wkcKT8bP3I0VQ9EuUZg3tQlnV3miw7Vozn
 tCWmGLXDZVlDymgTzDSN3oMV5azQc+RBpLUlL9Y9yhhnhhsmEIoJzJYHzuWibRlI+72K
 eln4Dds8//hHuMG6W0WHrYFgo1538WA/WUxZj/2q+CTQF/nF3uA3nmkcXo/ZLEq1N0ln
 bhoy690ex9NUUNeZcMGKrLO/Vylwb7RmYmPPNahBMXJV1uQYtafE6ZXRuoC6yAOh5jqQ yA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs6kf72tv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Jun 2022 02:10:19 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25M26YLW038095;
        Wed, 22 Jun 2022 02:10:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gtd9usx3e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Jun 2022 02:10:18 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 25M29Bim002724;
        Wed, 22 Jun 2022 02:10:17 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gtd9usx36-1;
        Wed, 22 Jun 2022 02:10:17 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        bvanassche@acm.org, chanho61.park@samsung.com, beanhuo@micron.com,
        avri.altman@wdc.com, krzysztof.kozlowski+dt@linaro.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 1/3] ufs: host: ufs-exynos: remove unused defines
Date:   Tue, 21 Jun 2022 22:10:11 -0400
Message-Id: <165586371837.21830.10958074240808961453.b4-ty@oracle.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220615121204.16642-1-alim.akhtar@samsung.com>
References: <CGME20220615121508epcas5p3a42f8503bb6c6120cb4c0606109fe9c4@epcas5p3.samsung.com> <20220615121204.16642-1-alim.akhtar@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: CUCMVEMO4qv7lXOpeiMuW5vVaQr5o8nv
X-Proofpoint-GUID: CUCMVEMO4qv7lXOpeiMuW5vVaQr5o8nv
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jun 2022 17:42:02 +0530, Alim Akhtar wrote:

> Remove #defines as those are not used anywhere in the driver file
> 
> 

Applied to 5.20/scsi-queue, thanks!

[1/3] ufs: host: ufs-exynos: remove unused defines
      https://git.kernel.org/mkp/scsi/c/6c6806abd5bb
[2/3] ufs: host: ufs-exynos: use already existing define
      https://git.kernel.org/mkp/scsi/c/cb2bf7c6e544
[3/3] include: ufs: re-arrange addresses in increasing order
      https://git.kernel.org/mkp/scsi/c/c0d93b12f31c

-- 
Martin K. Petersen	Oracle Linux Engineering
