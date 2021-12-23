Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1710747DE81
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 06:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236869AbhLWFJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 00:09:33 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:37662 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235176AbhLWFJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 00:09:31 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BN0FYxs006038;
        Thu, 23 Dec 2021 05:09:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=FDWwdngnvPH/Wvq/ezAVHj1XYTtbmZ3sfJ0Mbe+YuRE=;
 b=cJhGVdPGaEg8sCtNRVfBcoNS7BLj0sL267IbtQtHVCEecC0w9MLBbNOUKv51RkKn8qu8
 jsPGZZYB2N/S7lIIyWCgA6B1pXnzzhP3S7d9emqV1/aJBL8eM5UbWhwsCBFQXOx96ift
 00qX3HNJUItlsyRzfCTFKDLochILP1VvIXCCSSN54/5jitSCMEh8OHFkhjDEe6JBt3n5
 i7D9rLJK04ri5IF1gN5oF4WeWCju8uknIkQkmA/Hde4wh+9Q+IUJZcEyyoa2EhtIpH23
 /b/3C0Mx4lxGOcQh2Mn3OtfMSr/hePocmVITN6wemc4IRPPJa357RpgOxMEJfU1gnwBN nw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3d2udcfs3j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Dec 2021 05:09:26 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BN50vTK102222;
        Thu, 23 Dec 2021 05:09:25 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 3d17f68vdr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Dec 2021 05:09:25 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 1BN59OTc125399;
        Thu, 23 Dec 2021 05:09:24 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by aserp3020.oracle.com with ESMTP id 3d17f68vdd-1;
        Thu, 23 Dec 2021 05:09:24 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     linux-scsi@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        linux-kernel@vger.kernel.org, Nilesh Javali <njavali@marvell.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v3] qla2xxx: synchronize rport dev_loss_tmo setting
Date:   Thu, 23 Dec 2021 00:09:20 -0500
Message-Id: <164023594701.4594.3994093759396390802.b4-ty@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211214111139.52503-1-dwagner@suse.de>
References: <20211214111139.52503-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: NbFOlJI6VQrgrU3gI98Qz09y5mXlhsoM
X-Proofpoint-GUID: NbFOlJI6VQrgrU3gI98Qz09y5mXlhsoM
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Dec 2021 12:11:39 +0100, Daniel Wagner wrote:

> From: Hannes Reinecke <hare@suse.de>
> 
> Currently, the dev_loss_tmo setting is only ever used for SCSI
> devices. This patch reshuffles initialisation such that the SCSI
> remote ports are registered before the NVMe ones, allowing the
> dev_loss_tmo setting to be synchronized between SCSI and NVMe.
> 
> [...]

Applied to 5.17/scsi-queue, thanks!

[1/1] qla2xxx: synchronize rport dev_loss_tmo setting
      https://git.kernel.org/mkp/scsi/c/baea0e833f76

-- 
Martin K. Petersen	Oracle Linux Engineering
