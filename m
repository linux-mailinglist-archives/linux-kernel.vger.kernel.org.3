Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 907A748A24C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 23:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345118AbiAJWEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 17:04:52 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:13776 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243312AbiAJWEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 17:04:51 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20AJlXpV026179;
        Mon, 10 Jan 2022 22:04:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=JhkSO05HsvHJ+ETnsw1m3NMvaTPt/WWzvrJP352yBoU=;
 b=JzDybG7UvAX+KOnHrjAFry7IDnvUgRCUT919ygCafgvdAN8THWDE0U2vwpumi3BKZCFe
 QU13pSgeJje5Kx0xTaaob8dIjHQkyWlf7r3CnFjqyHKgTsMGHGVGmjHAFnCpv6AMh5q3
 kVBHwSVWfwzik3hgXfm59FVM29rYfDPXTBHEpDoU1LU9NPsSlQPdl0iMXq0jIo13Ew/E
 ROGHJR6E5/GUPvCLApULVXQ3BWUiORfI8kdKyJJJH9+/SVTRhiOYymPpF1mFKgiZ+HXU
 TuXUsbsvRyqNm/kiBwtYvK9N30J3C+M3kBMOtaje+BRoezBGxiHOrqmlIqBll/t7uabg ng== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgjtg9svb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 22:04:47 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20ALtvGe138975;
        Mon, 10 Jan 2022 22:04:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 3df2e3vqrd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 22:04:46 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 20AM4iC0174082;
        Mon, 10 Jan 2022 22:04:45 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by aserp3020.oracle.com with ESMTP id 3df2e3vqp8-2;
        Mon, 10 Jan 2022 22:04:45 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     hare@suse.com, cgel.zte@gmail.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, jejb@linux.ibm.com,
        Zeal Robot <zealci@zte.com.cn>, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>
Subject: Re: [PATCH] drivers/scsi: remove redundant error variable
Date:   Mon, 10 Jan 2022 17:04:34 -0500
Message-Id: <164182835585.13635.17767533447859659177.b4-ty@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220104112452.601899-1-chi.minghao@zte.com.cn>
References: <20220104112452.601899-1-chi.minghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 0td0wzlFXVHRGLNSoH0ekHBspKOSfZXs
X-Proofpoint-ORIG-GUID: 0td0wzlFXVHRGLNSoH0ekHBspKOSfZXs
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jan 2022 11:24:52 +0000, cgel.zte@gmail.com wrote:

> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Return value from ahd_linux_queue_abort_cmd() directly instead
> of taking this in another redundant variable.
> 
> 

Applied to 5.17/scsi-queue, thanks!

[1/1] drivers/scsi: remove redundant error variable
      https://git.kernel.org/mkp/scsi/c/c3b48443ba7c

-- 
Martin K. Petersen	Oracle Linux Engineering
