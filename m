Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53BC953302D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 20:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240239AbiEXSMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 14:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233792AbiEXSLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 14:11:54 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ECA15DD39;
        Tue, 24 May 2022 11:11:53 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24OHnEUb017393;
        Tue, 24 May 2022 18:11:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=WVRNFOcx71yJanhtYWmypv6vXZpbeMz3JSYrZKwI2xQ=;
 b=ycyUQ8utQ/DPKyTp2QGjK9DLkzE3q4y20x41SwnAtCKBMUoWKZQzPX/yosOv+daJcJK8
 g9JG8z7qvm1s0YJZ8qdL8I7DG1oCnD5uCI9bQ1qQMFIpVPf1V6A+rgebm1N6wsuWBYtv
 jLP805dB1dna/KqIAi7HDHDJYNsUjJHGjsGTSzMrCphabvAJ2yomX4Ir1XOf5okrFjpQ
 eOcyG7HE6Nu4JORdigEUOmeKhNj/5n9sDjS+jBWP+taJA2cHLsIyKLdPTdHgJikExC7S
 9Re0lpaSZyDBMMAxUi83arjeKHPpTomhAgoKTfOi7J8s1OrU91WSEFmUDDJH6FS2fI0t hg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g93tb83mv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 May 2022 18:11:47 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24OHoItO016357;
        Tue, 24 May 2022 18:11:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g93x50s58-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 May 2022 18:11:46 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 24OIAvn4039045;
        Tue, 24 May 2022 18:11:46 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g93x50s3r-6;
        Tue, 24 May 2022 18:11:46 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
        Julia Lawall <Julia.Lawall@inria.fr>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: Re: [PATCH] scsi: isci: fix typo in comment
Date:   Tue, 24 May 2022 14:11:38 -0400
Message-Id: <165341587530.22286.5046681097356225557.b4-ty@oracle.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220521111145.81697-91-Julia.Lawall@inria.fr>
References: <20220521111145.81697-91-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: AVIzh2KOk54HKcwLowqyoEzU3BigFGUh
X-Proofpoint-ORIG-GUID: AVIzh2KOk54HKcwLowqyoEzU3BigFGUh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 May 2022 13:11:41 +0200, Julia Lawall wrote:

> Spelling mistake (triple letters) in comment.
> Detected with the help of Coccinelle.
> 
> 

Applied to 5.19/scsi-queue, thanks!

[1/1] scsi: isci: fix typo in comment
      https://git.kernel.org/mkp/scsi/c/823ae99e09f7

-- 
Martin K. Petersen	Oracle Linux Engineering
