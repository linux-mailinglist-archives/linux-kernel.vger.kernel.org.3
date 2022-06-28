Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9913855E2E7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbiF1DZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 23:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbiF1DZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 23:25:04 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13EEC2528F;
        Mon, 27 Jun 2022 20:25:04 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25S19Mmo002132;
        Tue, 28 Jun 2022 03:24:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=eFViyG9TphGlzAsNGsTUi3mz4HK3F5zSML2iW6OQlHA=;
 b=jHQF5njw6v3ID3mO8NjVyFCc8KYHYBJubmM34E1D+WltgeGh03ewdJsTtYle2aZEa6ZH
 Yx5Davb+f9jlax0m4UoQLkkapUm9iGvi/ADIQsRW7hi17riTuPX1tS0gPBjAg2AtJ5Sn
 8lxk8AelFMTB+S3Ui83tRBhlAp5EhPU0CcKFMJB7qLR4jnWKGFnk075rEquTUzXLQZHZ
 Slzc8ct3dl0BKIZqYECfqXdk6RI4UyYwg3YuXOPhYu/p7YLFKHzHLvaAYs6JTYh29FAo
 ak5vYV2AlnblXTRgUv4kRjFOBkaTVUgJpycnr3aci1k4Hbfyxr7TCwdc63jwMR/cy5Az 1g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gws52cupv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jun 2022 03:24:58 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25S3F3aA002641;
        Tue, 28 Jun 2022 03:24:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gwrt7jjm2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jun 2022 03:24:58 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 25S3Nvq6016584;
        Tue, 28 Jun 2022 03:24:57 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gwrt7jjkg-5;
        Tue, 28 Jun 2022 03:24:57 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Jiang Jian <jiangjian@cdjrlc.com>, sreekanth.reddy@broadcom.com,
        sathya.prakash@broadcom.com, suganath-prabu.subramani@broadcom.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, MPT-FusionLinux.pdl@broadcom.com,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi: message: fusion: drop unexpected word "the"
Date:   Mon, 27 Jun 2022 23:24:43 -0400
Message-Id: <165638665784.7726.11310058852426803660.b4-ty@oracle.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220621103119.91492-1-jiangjian@cdjrlc.com>
References: <20220621103119.91492-1-jiangjian@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: be9BQ_8ohoMVeL7-Tcn-qEXJEaO2ZApg
X-Proofpoint-GUID: be9BQ_8ohoMVeL7-Tcn-qEXJEaO2ZApg
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jun 2022 18:31:19 +0800, Jiang Jian wrote:

> there is an unexpected word "the" in the comments that need to be dropped
> 
> >-   *  Update the target negotiation parameters based on the the Inquiry
> >+   *  Update the target negotiation parameters based on the Inquiry
> 
> 

Applied to 5.20/scsi-queue, thanks!

[1/1] scsi: message: fusion: drop unexpected word "the"
      https://git.kernel.org/mkp/scsi/c/950d2867c1fb

-- 
Martin K. Petersen	Oracle Linux Engineering
