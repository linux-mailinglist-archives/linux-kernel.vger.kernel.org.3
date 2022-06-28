Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D104D55D700
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232781AbiF1DZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 23:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231829AbiF1DZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 23:25:08 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786002528C;
        Mon, 27 Jun 2022 20:25:07 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25S25YCr031567;
        Tue, 28 Jun 2022 03:25:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=jqIqiRlnHrHUFTHbRk/o13cAhunM9tUGL0btrqSZqaA=;
 b=hzNTte200siMrFl2qbjsCM02hZYg6xp5HjOSIF3Q4T/6fH2q23co0VPo+uG0IF2iudKD
 biVuhmn0gA7CyTsWzCrEFNFI12ZNF3b2+ZrcsABQAthNxtPhxmRgCFDeIkbh9n0q5DTF
 9szpwBeybThI79fPlhOXbpgyeQ8ei4H+mFM779Ujop3sWvbaIsLFzbEVh3CHSfK0yOTC
 9a17HAcMmC2998Sfom9qRhcP7UZr5dOro1z6frT+QyWcWzQv6XwYnSV8D+4VD3L6tz74
 uR4nm1ko+MntDeNsue2WXmFA8bDaYXCz26fw7LQD9asPLrzFQBYlwWnQVbV0fWKH5Fip XQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gwrscctnh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jun 2022 03:25:00 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25S3F1Ob002535;
        Tue, 28 Jun 2022 03:24:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gwrt7jjmg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jun 2022 03:24:59 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 25S3NvqC016584;
        Tue, 28 Jun 2022 03:24:59 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gwrt7jjkg-8;
        Tue, 28 Jun 2022 03:24:59 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Jiang Jian <jiangjian@cdjrlc.com>, jejb@linux.ibm.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        kartilak@cisco.com, linux-kernel@vger.kernel.org,
        sebaddel@cisco.com, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] snic: Remove duplicate 'on' in two places.
Date:   Mon, 27 Jun 2022 23:24:46 -0400
Message-Id: <165638665786.7726.3656286553425657370.b4-ty@oracle.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220621150136.9264-1-jiangjian@cdjrlc.com>
References: <20220621150136.9264-1-jiangjian@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: LY9vobFENJWSsG7kdkbg1jnq4cZqujbw
X-Proofpoint-GUID: LY9vobFENJWSsG7kdkbg1jnq4cZqujbw
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jun 2022 23:01:36 +0800, Jiang Jian wrote:

> file: ./drivers/scsi/snic/snic_fwint.h
> line: 148
>  * Bit 3: Async event notifications on on tgt online/offline events.
> changed to
>  * Bit 3: Async event notifications on tgt online/offline events.
> 
> 
> [...]

Applied to 5.20/scsi-queue, thanks!

[1/1] snic: Remove duplicate 'on' in two places.
      https://git.kernel.org/mkp/scsi/c/e448c8508d74

-- 
Martin K. Petersen	Oracle Linux Engineering
