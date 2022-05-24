Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D04533025
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 20:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240210AbiEXSL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 14:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233148AbiEXSLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 14:11:54 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1980B5DD17;
        Tue, 24 May 2022 11:11:53 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24OHnkRS022060;
        Tue, 24 May 2022 18:11:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=sDiCoU1tb8qI5R/9+PO5H+5ISQ8VZKiIEJs5g2Ya0qM=;
 b=V1S7Ax6b5E0DsA0YIzR+d+WJOYKHl+f7aiv4rFyiJ24GuefHRJL30Q02pR9z4qJJDjvf
 KC8lb8QPWrhZrWiUVuPUVfXxUPCFbBoKPsV8dHD1tL+x1QdubYnP/oitXxr7PPF3m+nD
 uGBQ5cHq+Pocl5FfKS/9JbYJeIzSvaXdinF1OTxkoMeB9ghRYJd0et6SiacFcuJDBEWS
 KKN/BM2R5e98mw66+Stn9wFomB9CBon6Tns2l3POCCueTog+ZkPE+SDUL92U+nbzMGev
 4ry9SSpCXVZYS5RHaBahVGcQM1VPA7pWo8LoUX2KSy0ZB46BZORGBlmLHGtOSz4Sdand iw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g93tar3g2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 May 2022 18:11:48 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24OHoOGa016620;
        Tue, 24 May 2022 18:11:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g93x50s5f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 May 2022 18:11:47 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 24OIAvn6039045;
        Tue, 24 May 2022 18:11:46 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g93x50s3r-7;
        Tue, 24 May 2022 18:11:46 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Julia Lawall <Julia.Lawall@inria.fr>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] scsi: pmcraid: fix typo in comment
Date:   Tue, 24 May 2022 14:11:39 -0400
Message-Id: <165341587530.22286.4829823913346627169.b4-ty@oracle.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220521111145.81697-89-Julia.Lawall@inria.fr>
References: <20220521111145.81697-89-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: rX5fqoezAtC4Iz_jiyCEv3zlLFiIrwfn
X-Proofpoint-ORIG-GUID: rX5fqoezAtC4Iz_jiyCEv3zlLFiIrwfn
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 May 2022 13:11:39 +0200, Julia Lawall wrote:

> Spelling mistake (triple letters) in comment.
> Detected with the help of Coccinelle.
> 
> 

Applied to 5.19/scsi-queue, thanks!

[1/1] scsi: pmcraid: fix typo in comment
      https://git.kernel.org/mkp/scsi/c/f6e2694ebb25

-- 
Martin K. Petersen	Oracle Linux Engineering
