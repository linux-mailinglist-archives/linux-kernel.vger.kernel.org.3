Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F10D956ADE2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 23:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236901AbiGGVrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 17:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236590AbiGGVrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 17:47:33 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583AD30F63;
        Thu,  7 Jul 2022 14:47:33 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 267KCvae020796;
        Thu, 7 Jul 2022 21:47:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=2WCEGE5I0L1vEERnymb1HRBA5Khvt8GMY3yju0QIGWM=;
 b=dvQhvS3aT1RHtFk1kurATJHGEPj2pHt49JhihmJu7a5ht3r4t/JDsJXOq4GdykHR9h98
 RgLNR84YwvOud3QXjROaMAOnOLQ3jU9X+PLCSQWfgf6iOV7YBUHB2N8/BOV54JrpP/Op
 7EoNhDnh0YpcWgcwYkP3jLqR2fQ5t7QmNMLWu7Dfak2vCeNj7PPcejKC2j7eCf/IWQjN
 zLMROLVvO+6k3aks/HdQRICe7qE3e48GJuxSizbEZ0LPfJkputCfilFwmsZ/eIoN0YzJ
 jTZCexWgbdXrAmofrNSedXtOmxyq1WVS2pOza8rGycKK0jAir7UyRsimnyZp4+nkWQZU cA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4uby6gm2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Jul 2022 21:47:29 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 267LjM86030329;
        Thu, 7 Jul 2022 21:47:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h4ud7c5cs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Jul 2022 21:47:28 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 267LlRsa033607;
        Thu, 7 Jul 2022 21:47:28 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h4ud7c5ag-2;
        Thu, 07 Jul 2022 21:47:28 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Colin Ian King <colin.i.king@gmail.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: fcoe: remove redundant assignment to variable wlen
Date:   Thu,  7 Jul 2022 17:47:21 -0400
Message-Id: <165723020282.18731.5520881075463416870.b4-ty@oracle.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220623164710.76831-1-colin.i.king@gmail.com>
References: <20220623164710.76831-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: xtfs1sULxiGgq7mTGgv2D6BPCKS_tzM3
X-Proofpoint-GUID: xtfs1sULxiGgq7mTGgv2D6BPCKS_tzM3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jun 2022 17:47:10 +0100, Colin Ian King wrote:

> Variable wlen is being assigned a value that is never read, it is
> being re-assigned with a different value later on. The assignment
> is redundant and can be removed.
> 
> Cleans up clang scan build warning:
> drivers/scsi/fcoe/fcoe.c:1491:2: warning: Value stored to 'wlen'
> is never read [deadcode.DeadStores]
> 
> [...]

Applied to 5.20/scsi-queue, thanks!

[1/1] scsi: fcoe: remove redundant assignment to variable wlen
      https://git.kernel.org/mkp/scsi/c/07f0c8aff551

-- 
Martin K. Petersen	Oracle Linux Engineering
