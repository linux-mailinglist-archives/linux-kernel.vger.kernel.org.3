Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB9D4B6184
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 04:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233819AbiBODT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 22:19:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiBODTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 22:19:51 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE1120194;
        Mon, 14 Feb 2022 19:19:42 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21F2QVt8001610;
        Tue, 15 Feb 2022 03:19:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=qRvvfBAi4GqpHyNUpNrfzYFP33nuCc6PWM+bhkMygO8=;
 b=uazAOWwQNka84g4kbaqeQnjnEFkY+BNWAn6JqSeZSmjOvrv4d9hqy7LY14dfKCx0APve
 t8elVfJjAmsBsJXR3S+KbXiejoUCooCvdDmEs7rcGbRxCPWJwMhEo4P3sH0Ud936MN7p
 T2qIVzt+/0d5nNULXTfZMSevGE0mS+aKPYiP60zmUzgwPAmXSYfhdujlGoo7bkHA7tXm
 V1/UryCCXX44nBrQkzCjgM3cBMA9WQVokddxXhBjlduh5DOby7L+m039huUt23fgIA2L
 kJqXznmbf56iFpfx/hroIfkNYAVk+VY2IsQsBrmQgrNVD0AYlusRqcbenm536ExzTcTD TA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e63p26hcr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 03:19:34 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21F3Gtpq058111;
        Tue, 15 Feb 2022 03:19:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 3e620wpgth-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 03:19:33 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 21F3JMPI064243;
        Tue, 15 Feb 2022 03:19:33 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by userp3030.oracle.com with ESMTP id 3e620wpgqq-9;
        Tue, 15 Feb 2022 03:19:32 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     jejb@linux.ibm.com, damien.lemoal@opensource.wdc.com,
        Yang Li <yang.lee@linux.alibaba.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>,
        jinpu.wang@cloud.ionos.com, linux-scsi@vger.kernel.org
Subject: Re: [PATCH -next v3] scsi: pm8001: clean up some inconsistent indentin
Date:   Mon, 14 Feb 2022 22:19:21 -0500
Message-Id: <164489513313.15031.18022734177726143464.b4-ty@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220208025500.29511-1-yang.lee@linux.alibaba.com>
References: <20220208025500.29511-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: hjATiPO3AlS6IovEBQu7SGxjlC3Wu4VC
X-Proofpoint-GUID: hjATiPO3AlS6IovEBQu7SGxjlC3Wu4VC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Feb 2022 10:55:00 +0800, Yang Li wrote:

> Eliminate the follow smatch warning:
> drivers/scsi/pm8001/pm8001_ctl.c:760 pm8001_update_flash() warn:
> inconsistent indenting
> 
> 

Applied to 5.18/scsi-queue, thanks!

[1/1] scsi: pm8001: clean up some inconsistent indentin
      https://git.kernel.org/mkp/scsi/c/106b7a2549b4

-- 
Martin K. Petersen	Oracle Linux Engineering
