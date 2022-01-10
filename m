Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C04DA48A24D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 23:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345137AbiAJWEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 17:04:54 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:15024 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345088AbiAJWEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 17:04:51 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20AJlifk007280;
        Mon, 10 Jan 2022 22:04:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=j8kyLVJ/vcALmp+cjVYbWRecKIqzVpUx/AEGGzhoIcI=;
 b=GuJ6B5CUzWI7YA6wWS8Qdf7015IucHpocxsKxeCPRXhWAXCODzMVpnFu5cYbu9RMs1H8
 awpAGGynhlTqVV0zsBfWHFEVCpbAN3qwHUT6x8TcC/z6+sJApAiUECjyz4CuaPDpuHH1
 GSP2RrCf2XNe7EmEByv/TPK3qpoSzWPqIVi7Bqv+L+/4qkyOHp5DyDjzmoRS7gj3MU1z
 Ae8/bLUFRSZ/+ORz/EreJpOZqzGUBhLl0KdLHBq4Lm9+Lln0jykAC5OwWOmrvU+KXs7/
 tCmN7npHchR3X2vMKTXb0IelciZW1S+1JwHzPH+/ZUhmjuccVjIPfS6hbsSZXDT+pby3 TQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgkhx1m9v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 22:04:49 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20ALtvBF139021;
        Mon, 10 Jan 2022 22:04:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 3df2e3vqts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 22:04:49 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 20AM4iC4174082;
        Mon, 10 Jan 2022 22:04:48 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by aserp3020.oracle.com with ESMTP id 3df2e3vqp8-4;
        Mon, 10 Jan 2022 22:04:48 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     linux-scsi@vger.kernel.org,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        mpi3mr-linuxdrv.pdl@broadcom.com,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Colin Ian King <colin.i.king@gmail.com>,
        Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH][next] scsi: mpi3mr: Fix some spelling mistakes
Date:   Mon, 10 Jan 2022 17:04:36 -0500
Message-Id: <164182835584.13635.12442712390166966548.b4-ty@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211224175240.1348942-1-colin.i.king@gmail.com>
References: <20211224175240.1348942-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ipyCed42Z6D2TitqyNq8MOHdgtvgiKUw
X-Proofpoint-ORIG-GUID: ipyCed42Z6D2TitqyNq8MOHdgtvgiKUw
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Dec 2021 17:52:40 +0000, Colin Ian King wrote:

> There are some spelling mistakes in some literal strings. Fix them.
> 
> 

Applied to 5.17/scsi-queue, thanks!

[1/1] scsi: mpi3mr: Fix some spelling mistakes
      https://git.kernel.org/mkp/scsi/c/5867b8569e64

-- 
Martin K. Petersen	Oracle Linux Engineering
