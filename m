Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7257348A258
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 23:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345204AbiAJWFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 17:05:10 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:35276 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345176AbiAJWFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 17:05:01 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20AJlXia026175;
        Mon, 10 Jan 2022 22:04:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=4in3AMt3jaCUmPeKg8seTKw1eAv3x+yzF7EJj+rf53M=;
 b=PFaMcr7OaVJA5SF6f2IHSpRInJe/i2XPc9t+zcMKs1FaQlkYG/9PwswIjLk+GnBBvwZH
 XuBeA5W5raaPTduuf53zX+3ytT/y6gekP+6mx4nG4nFFNpy7EQsue4mqAs1ncyeUlcJT
 Dht+TINdfGLFSdYErZgbIy1t2ejKHBCBuW7lLK1j7BOu02aBF5yqKXk2oldo1BcyLUES
 SnYOwHY3LP6kTky53kBNi2ammVrnePTzvdCnaOyMN2TDI36Lg3qcQlzDT26kfoTfoSYq
 xpDgMpn1HkVGRZ/Jh19nS3/n2WBMvTgu5KqSYEouk8cO0dyiB8u2lkbPJZv2629a1WF4 /Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgjtg9svw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 22:04:56 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20ALtvFV138983;
        Mon, 10 Jan 2022 22:04:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 3df2e3vqyn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 22:04:55 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 20AM4iCG174082;
        Mon, 10 Jan 2022 22:04:55 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by aserp3020.oracle.com with ESMTP id 3df2e3vqp8-10;
        Mon, 10 Jan 2022 22:04:54 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        kashyap.desai@broadcom.com, linux-scsi@vger.kernel.org,
        jejb@linux.ibm.com, sumit.saxena@broadcom.com,
        sathya.prakash@broadcom.com, sreekanth.reddy@broadcom.com,
        mpi3mr-linuxdrv.pdl@broadcom.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] scsi: mpi3mr: Fix formatting problems in some kernel-doc comments
Date:   Mon, 10 Jan 2022 17:04:42 -0500
Message-Id: <164182835585.13635.8928543266313865543.b4-ty@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211231082350.19315-1-yang.lee@linux.alibaba.com>
References: <20211231082350.19315-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: I6zea8lgF9fdojf7dHMGCrY_oq1XVq7S
X-Proofpoint-ORIG-GUID: I6zea8lgF9fdojf7dHMGCrY_oq1XVq7S
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Dec 2021 16:23:50 +0800, Yang Li wrote:

> Remove some warnings found by running scripts/kernel-doc,
> which is caused by using 'make W=1'.
> drivers/scsi/mpi3mr/mpi3mr_fw.c:2188: warning: Function parameter or
> member 'reason_code' not described in 'mpi3mr_check_rh_fault_ioc'
> drivers/scsi/mpi3mr/mpi3mr_fw.c:3650: warning: Excess function parameter
> 'init_type' description in 'mpi3mr_init_ioc'
> drivers/scsi/mpi3mr/mpi3mr_fw.c:4177: warning: bad line
> 
> [...]

Applied to 5.17/scsi-queue, thanks!

[1/1] scsi: mpi3mr: Fix formatting problems in some kernel-doc comments
      https://git.kernel.org/mkp/scsi/c/3bb3c24e268a

-- 
Martin K. Petersen	Oracle Linux Engineering
