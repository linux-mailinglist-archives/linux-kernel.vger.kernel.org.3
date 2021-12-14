Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62D3A473C1F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 05:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbhLNElQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 23:41:16 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:37138 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229528AbhLNElB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 23:41:01 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BE2iCRh005519;
        Tue, 14 Dec 2021 04:40:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=SzZs7XgDeRMA0edwg2i6CHfW1XMdqNO/KmcAN4lwWZY=;
 b=KZiu7f84oNg2g9dy3nsDH09QPiJDHqzbJLWjfZ/YzO9G2WSVbNQL/Cc49TX4neQwTTFx
 zCpaMeTK/COC85nYMrqS7oddG2VKrcyZmbexZhDvxw1rYe6lyV4UuosVhVA+2gj3ZOjq
 NJC5tESfHFkAH9s/Dnl518M/znVCh/Guio3DW0hZoWifXpTBPL0FwPO9oP6wrsEiJWg5
 MPdqzN7qV2ARV2d4m8mlk5roy9qxyi7kDxoDcERJ1l/nZHLh0xmGPWBuvjOUChonlPEl
 QpGp/+/dRXjLeRkFUGQoMyn5HBgn1B0ICQUkWKEMWA8OscAsZNLBBKavU/h8/sVUg4CB aQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cx56u2asj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Dec 2021 04:40:58 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BE4ZXHT032388;
        Tue, 14 Dec 2021 04:40:57 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 3cvh3wp5c1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Dec 2021 04:40:57 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 1BE4aj9E034843;
        Tue, 14 Dec 2021 04:40:56 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by userp3030.oracle.com with ESMTP id 3cvh3wp5ab-5;
        Tue, 14 Dec 2021 04:40:56 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "supporter:QLOGIC QL41xxx ISCSI DRIVER" 
        <GR-QLogic-Storage-Upstream@marvell.com>,
        Manish Rangankar <mrangankar@marvell.com>,
        "open list:QLOGIC QL41xxx ISCSI DRIVER" <linux-scsi@vger.kernel.org>,
        Nilesh Javali <njavali@marvell.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: Re: [PATCH v2 0/2] SYSFS_FLAG_FW_SEL_BOOT formatting fixes
Date:   Mon, 13 Dec 2021 23:40:51 -0500
Message-Id: <163945683292.11687.11917660920609079321.b4-ty@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211130203813.12138-1-f.fainelli@gmail.com>
References: <20211130203813.12138-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: KTz-cqCY-RZ1dC8UU9k5aGdSck_Eipld
X-Proofpoint-GUID: KTz-cqCY-RZ1dC8UU9k5aGdSck_Eipld
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Nov 2021 12:38:11 -0800, Florian Fainelli wrote:

> This patch series aligns the formatting of SYSFS_FLAG_FW_SEL_BOOT
> between qedi and qla4xxx.
> 
> Changes in v2:
> 
> - fixed incorrect format in second hunk of qla4xxx
> 
> [...]

Applied to 5.17/scsi-queue, thanks!

[1/2] scsi: qedi: Fix SYSFS_FLAG_FW_SEL_BOOT formatting
      https://git.kernel.org/mkp/scsi/c/9f9b7fa946be
[2/2] scsi: qla4xxx: Format SYSFS_FLAG_FW_SEL_BOOT as byte
      https://git.kernel.org/mkp/scsi/c/74d801525385

-- 
Martin K. Petersen	Oracle Linux Engineering
