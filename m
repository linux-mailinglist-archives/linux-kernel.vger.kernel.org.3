Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4CA473C18
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 05:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbhLNElD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 23:41:03 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:36038 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229494AbhLNElA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 23:41:00 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BE27Fev004125;
        Tue, 14 Dec 2021 04:40:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=z0ThVWSgKUlbF/F2SfVqQjrTN5mLwW+O1zor5mCsvRA=;
 b=QvAu1X3Ky0jA4i+TUaH2f1NkUxTs2c1fIAQwTo0NJmTn3NQKoEfzyGV/Id3abCprmOlA
 pG5LS0/HOFCqMIAKQmgN1E+uOftI+sAD/QLgapD7IpxiPIvL3Dlwf6Xp7CNmFxyefJzZ
 2jPIhVbsYYM1X2JjcrmOj+hKz0UV8wPBhDX2GOOt1BTVh5s0cNQvMbZmbI4kgVAWWyrw
 fnPfMCWLKJTwbRw7KEHDbk4N8mtYq3d/c3WLz+jdZJZG82AAvVYsPWTgTXkO7VikuiPD
 Jj9nn7+2UWbJxGXgj5BBgZO+x77qkUEsyMpRqPoJXhQKw4GdNXGuORcXayrYZ/iMqpcs 1A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cx3py2mas-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Dec 2021 04:40:57 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BE4ZZgo032537;
        Tue, 14 Dec 2021 04:40:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 3cvh3wp5br-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Dec 2021 04:40:56 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 1BE4aj9C034843;
        Tue, 14 Dec 2021 04:40:55 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by userp3030.oracle.com with ESMTP id 3cvh3wp5ab-4;
        Tue, 14 Dec 2021 04:40:55 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Colin Ian King <colin.i.king@gmail.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: mptfusion: remove redundant variable r
Date:   Mon, 13 Dec 2021 23:40:50 -0500
Message-Id: <163945683293.11687.16694098276525847729.b4-ty@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211205225901.54362-1-colin.i.king@gmail.com>
References: <20211205225901.54362-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: nVRX3Sb5DHFXasz8ZYnRdWyv_uoCSXEE
X-Proofpoint-GUID: nVRX3Sb5DHFXasz8ZYnRdWyv_uoCSXEE
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Dec 2021 22:59:01 +0000, Colin Ian King wrote:

> Variable r is being assigned a value that is never read. The assignment
> is redundant and so is the variable, so remove these. Remove unnecessary
> the {} braces in the if statement too.
> 
> 

Applied to 5.17/scsi-queue, thanks!

[1/1] scsi: mptfusion: remove redundant variable r
      https://git.kernel.org/mkp/scsi/c/c27fd25db39b

-- 
Martin K. Petersen	Oracle Linux Engineering
