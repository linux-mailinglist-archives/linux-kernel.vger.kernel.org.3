Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 904184933ED
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 05:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351505AbiASEHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 23:07:19 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:1550 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351460AbiASEHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 23:07:00 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20INxWLW011214;
        Wed, 19 Jan 2022 04:06:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=H/cAXg9i+HBl0Bby3Ibthhy7WNclNRAVPonQ55u3FwA=;
 b=XrkBl4CazON7Z4h5mDCevYug26hzUmOkL5mbnb+B+zPz7dbAAf8izoo9o0Yfxcsi9EFa
 ra6+NlXu54eJeTHLVZBzxi1k25Bws5Pl9kExvWkEzXygOsST2nLr/nYt33Njtc6S/vw+
 FbVH2A4b0R8d7r4GvThe125jh7SucHZrlz3xHkg1WNFmAgC6/CJUTb/2jbGLANy5Ozv/
 PjCEp4Mi/ha2UJVMVhN5bDzaX6NSOIZOiesGpe2GpeyixjbKe2r78ZLaXwNo5wnWg8lI
 GW5ojDGSlPHc1PTe5e0WrkYpaSo4jcc3eCOFx3OkiCsJq5phegqdm9GfoQiLV4UWG/Cw BA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dnbrnuuek-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jan 2022 04:06:22 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20J42AnZ091612;
        Wed, 19 Jan 2022 04:06:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 3dkqqpnr97-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jan 2022 04:06:21 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 20J46HQ5110383;
        Wed, 19 Jan 2022 04:06:20 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by userp3020.oracle.com with ESMTP id 3dkqqpnr68-4;
        Wed, 19 Jan 2022 04:06:20 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     jejb@linux.ibm.com, Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        yokota@netlab.is.tsukuba.ac.jp
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi: nsp_cs: Check of ioremap return value
Date:   Tue, 18 Jan 2022 23:06:12 -0500
Message-Id: <164256513503.31841.14055206238562894525.b4-ty@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211230021137.1823352-1-jiasheng@iscas.ac.cn>
References: <20211230021137.1823352-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Fx2fiF4jQwsCq-XSdKEM-xYYqSI95i7q
X-Proofpoint-ORIG-GUID: Fx2fiF4jQwsCq-XSdKEM-xYYqSI95i7q
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Dec 2021 10:11:37 +0800, Jiasheng Jiang wrote:

> As the possible failure of the ioremap(), the 'data->MmioAddress' could
> be NULL.
> Therefore it should be better to check it in order to transfer the
> error.
> 
> 

Applied to 5.17/scsi-queue, thanks!

[1/1] scsi: nsp_cs: Check of ioremap return value
      https://git.kernel.org/mkp/scsi/c/2576e153cd98

-- 
Martin K. Petersen	Oracle Linux Engineering
