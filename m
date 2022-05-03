Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6C1518BBA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 20:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240869AbiECSF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 14:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237720AbiECSFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 14:05:22 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A6DDEBE;
        Tue,  3 May 2022 11:01:48 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 242Nnl5g025194;
        Tue, 3 May 2022 00:51:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=BTvTUXunvVd80zWADpV28r/DalfnHZxRR5fejc1lQI8=;
 b=tf2aCXpC5Jjg91gWkismN1NCwvuE2k1wv6DD4gZbMaz2xWSBJx9EBVB37FrV/17dIKec
 /iAaXQtgonYMTBm5GywKJCMhMXRpnRuSk0etN/knTVX+LF+8E14RC66yFGz00Pkd9QoZ
 QlgL/tWk0tZRYfr2qRbRgD5R/iE3Qw40k4O0XoFIsRNzQiDy85I97MkdVQGbnRpRTf4D
 81xvjTxtGElKnWaRapqyCaJZdvXkxQqpvXv0sq7JSELogCLRKZng4JFXfD54Ox0g0BSn
 mN0fPAJpncTH5HGgrmLivNCR2N+I2NI1jsHY5jwjU17x3nqqgf46T4Z41WW0QUYv8whf eg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruw2cnx4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 May 2022 00:51:48 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2430oobn008895;
        Tue, 3 May 2022 00:51:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruj83x54-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 May 2022 00:51:48 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 2430plj0010389;
        Tue, 3 May 2022 00:51:48 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruj83x4g-2;
        Tue, 03 May 2022 00:51:47 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Haowen Bai <baihaowen@meizu.com>, jejb@linux.ibm.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi: aha1542: remove unneeded semicolon
Date:   Mon,  2 May 2022 20:51:12 -0400
Message-Id: <165153836360.24053.6220453924870674457.b4-ty@oracle.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <1647309865-15620-1-git-send-email-baihaowen@meizu.com>
References: <1647309865-15620-1-git-send-email-baihaowen@meizu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: o7E5SKF6TLd2mToeyjBoZy5oLq8HHcmN
X-Proofpoint-ORIG-GUID: o7E5SKF6TLd2mToeyjBoZy5oLq8HHcmN
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Mar 2022 10:04:25 +0800, Haowen Bai wrote:

> Fixes coccicheck warning:
> drivers/scsi/aha1542.c:553:2-3: Unneeded semicolon
> drivers/scsi/aha1542.c:582:2-3: Unneeded semicolon
> drivers/scsi/aha1542.c:605:2-3: Unneeded semicolon
> drivers/scsi/aha1542.c:306:2-3: Unneeded semicolon
> drivers/scsi/aha1542.c:348:3-4: Unneeded semicolon
> drivers/scsi/aha1542.c:412:2-3: Unneeded semicolon
> drivers/scsi/aha1542.c:640:2-3: Unneeded semicolon
> drivers/scsi/aha1542.c:658:2-3: Unneeded semicolon
> drivers/scsi/aha1542.c:677:2-3: Unneeded semicolon
> drivers/scsi/aha1542.c:538:2-3: Unneeded semicolon
> 
> [...]

Applied to 5.19/scsi-queue, thanks!

[1/1] scsi: aha1542: remove unneeded semicolon
      https://git.kernel.org/mkp/scsi/c/8c36b054df01

-- 
Martin K. Petersen	Oracle Linux Engineering
