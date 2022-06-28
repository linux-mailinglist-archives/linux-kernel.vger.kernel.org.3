Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F16655C75F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbiF1DZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 23:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbiF1DZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 23:25:07 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8931F25293;
        Mon, 27 Jun 2022 20:25:06 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25S19Mmn002132;
        Tue, 28 Jun 2022 03:24:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=blppps7k8ZjbGJQpYKrauvR4qoP4EtdLtYrKMmDDQqA=;
 b=GA4PLNTUuhyjlWrAoO9dMAndPfOYCgjiSzodusuJybLsx6n+8RSpVpwTgr5ricC/d4Qf
 yrjupKRRXm4FL0p1JoIcefMvZYpArCXXP9++2VpupcjoWhnrmmv+XXxRwMBZAYfsFZgn
 9SKMYyjQgx8Dcjwpx0Xli917pSqw5v8i3kiG3rtLou6tlcT75PwaML5HMzLt3EmOe/kh
 Ms267K2/OYWxalQryxYAbQrEXZ4ciTYiAVPR+pg6LxQ5FnaNtCSc+GQmWoXGK1vWOyKm
 W5DMgcTAdDUofUGaQiBYrSg0u++7zUhIG9iShIifNDqmM490rqQcCxTZv8gBM7615M0c +w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gws52cupu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jun 2022 03:24:57 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25S3F1i6002325;
        Tue, 28 Jun 2022 03:24:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gwrt7jjkt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jun 2022 03:24:56 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 25S3Nvq2016584;
        Tue, 28 Jun 2022 03:24:56 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gwrt7jjkg-3;
        Tue, 28 Jun 2022 03:24:56 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Jiang Jian <jiangjian@cdjrlc.com>, jejb@linux.ibm.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        aacraid@microsemi.com, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi: aacraid: Remove duplicate 'the' in two places.
Date:   Mon, 27 Jun 2022 23:24:41 -0400
Message-Id: <165638665785.7726.4115293391694345213.b4-ty@oracle.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220621142346.6429-1-jiangjian@cdjrlc.com>
References: <20220621142346.6429-1-jiangjian@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: RaHBc5reHQtTUnq6ljXtkH3YfpMLXYBx
X-Proofpoint-GUID: RaHBc5reHQtTUnq6ljXtkH3YfpMLXYBx
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jun 2022 22:23:46 +0800, Jiang Jian wrote:

> file: drivers/scsi/aacraid/aachba.c
> line: 1053
> * The LSB is the the end.
> chaned to
> * The LSB is the end.
> 
> 
> [...]

Applied to 5.20/scsi-queue, thanks!

[1/1] scsi: aacraid: Remove duplicate 'the' in two places.
      https://git.kernel.org/mkp/scsi/c/ebd676ff3b3f

-- 
Martin K. Petersen	Oracle Linux Engineering
