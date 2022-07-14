Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B140657425F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 06:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234230AbiGNEXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 00:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234214AbiGNEXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 00:23:10 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B08627CC6;
        Wed, 13 Jul 2022 21:22:45 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26E3n4sB032737;
        Thu, 14 Jul 2022 04:22:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=bOpt1fwzjbQHFzEsTbc0D3zHimElkrL89TMk2o1Sox0=;
 b=GLvP6Us6tiEeULXszlhwrs7bx/83hixzQQjRNW9J1YkK3gxdJ2sUn1+VQ+MN//bwK2u+
 wreK3S1s285RJgjsZx6DrF5eELlwtJSOuLmQvNbgla9z5zMDaPizlet4WvZtweS8qI6W
 DaRr5R+HSJy9gR6C4cbsI3c7Jn/tLlvgVVVEcyjtJdcZ4cNi/c6HVcwgKoyayzwI8EkU
 B2Gb4zSgbVFce+yhKtqVrM9MTulXLgcbAnK9+YWEfZMYqKjcGbrUttnrsgnHtXVdC4kQ
 KO+PWj69vwGXi209vndr0DBYLO3b/ocUJn3vD72vIV17ZA9ayLlgjg/HchZXN4vIud18 EQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71sgubx3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jul 2022 04:22:38 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26E4ApYo040463;
        Thu, 14 Jul 2022 04:22:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h70451jpt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jul 2022 04:22:36 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 26E4MWBr023864;
        Thu, 14 Jul 2022 04:22:36 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h70451jnc-7;
        Thu, 14 Jul 2022 04:22:36 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     linux-scsi@vger.kernel.org, lizhijian@fujitsu.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, Finn Thain <fthain@linux-m68k.org>
Subject: Re: [PATCH] scsi: Shorten too long warning messages
Date:   Thu, 14 Jul 2022 00:22:27 -0400
Message-Id: <165777182483.7272.5019493555825629981.b4-ty@oracle.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220630024516.1571209-1-lizhijian@fujitsu.com>
References: <20220630024516.1571209-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: R_YWl10UVi6OYsB9eyCCVdV41JbwTzki
X-Proofpoint-ORIG-GUID: R_YWl10UVi6OYsB9eyCCVdV41JbwTzki
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Jun 2022 02:38:11 +0000, lizhijian@fujitsu.com wrote:

> sdev_printk will only accept messages less than 128 bytes. So shorten
> the messages exceeding 128 bytes avoid getting a incomplete sentence like:
> [  475.156955] sd 9:0:0:0: Warning! Received an indication that the LUN assignments on this target have changed. The Linux SCSI layer does not automatical
> 
> 

Applied to 5.20/scsi-queue, thanks!

[1/1] scsi: Shorten too long warning messages
      https://git.kernel.org/mkp/scsi/c/a2417db3679c

-- 
Martin K. Petersen	Oracle Linux Engineering
