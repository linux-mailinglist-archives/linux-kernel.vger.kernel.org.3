Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F5B55D659
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbiF1DZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 23:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbiF1DZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 23:25:04 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970F924F3D;
        Mon, 27 Jun 2022 20:25:03 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25S2CA6w027276;
        Tue, 28 Jun 2022 03:24:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=JT1y2aWskmj5rI1APKTGDKZdOE8O7MaEiczaBx1QVAA=;
 b=0lvjyL8hJzaU6wBRqmuFt0hUj6cU+ujls2FLULxkQ4bto6RWM8oDPDx2Xz9Imc2YQSrc
 m/f3dIIrq+tEyqIzYllPRPfC+vpgakjdZUftybyhd5srCfjyqf8BMeanXX3yMvaqdCn8
 op8gcEzfftb5aFUQEE1Nvwx+975qxs3JOyqnjSvEMysc4FgvzUrBsDyebDUXeGs0jMST
 FxQdK1HHeZvK191ofdmI9tomChgZ6OZL9OMhs37MaT4YzxlfUh4pCHK+BMHM2ojHc/RO
 9/BePQKgdEByXF7DVo3fuhqcNIhlgWEI9/HIdPZnnDTFoNW2dUknKyXCqkehIvlHNiKr DA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gwsyscrs2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jun 2022 03:24:56 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25S3F1E6002519;
        Tue, 28 Jun 2022 03:24:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gwrt7jjkp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jun 2022 03:24:56 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 25S3Nvq0016584;
        Tue, 28 Jun 2022 03:24:55 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gwrt7jjkg-2;
        Tue, 28 Jun 2022 03:24:55 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Zhang Jiaming <jiaming@nfschina.com>, jejb@linux.ibm.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        MPT-FusionLinux.pdl@broadcom.com,
        suganath-prabu.subramani@broadcom.com, sathya.prakash@broadcom.com,
        liqiong@nfschina.com, sreekanth.reddy@broadcom.com,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi: mpt3sas: Fix space and spelling mistake
Date:   Mon, 27 Jun 2022 23:24:40 -0400
Message-Id: <165638665783.7726.17096532634348166492.b4-ty@oracle.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220617101103.3162-1-jiaming@nfschina.com>
References: <20220617101103.3162-1-jiaming@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: o9N2i1ANfdJk0gc-E7eEJmlpYVudhMUb
X-Proofpoint-GUID: o9N2i1ANfdJk0gc-E7eEJmlpYVudhMUb
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jun 2022 18:11:03 +0800, Zhang Jiaming wrote:

> There is a splling mistake in _base_sas_ioc_info. Change 'cant' to 'can't'.
> There are 3 space mistakes. Remove blank space before ','.
> 
> 

Applied to 5.20/scsi-queue, thanks!

[1/1] scsi: mpt3sas: Fix space and spelling mistake
      https://git.kernel.org/mkp/scsi/c/efef34cb4545

-- 
Martin K. Petersen	Oracle Linux Engineering
