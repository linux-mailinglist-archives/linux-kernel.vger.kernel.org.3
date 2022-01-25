Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E236849AC02
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 06:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240267AbiAYFw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 00:52:26 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:10646 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235594AbiAYFli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 00:41:38 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20P2BgAK001281;
        Tue, 25 Jan 2022 05:41:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=+Fr20GVm/K7O8IeAcez9wVqesaeXGvlF5UDdXX6OAEE=;
 b=e0N3fQJozMX5zHQ0/35n9NlWwrLU3KzBm24vbpI7vqiygMbFvPBh3LlJN+JcqtlDvare
 2ib0htEvmCvzkiOGXPNY1FDgGvHUEo1kPnMoOISqOqMH3Lp7GChiyKH8qDSJYiEyvt1j
 VypXGK9L0hsGJDJHKPgxOOe0PdCW+x6gAV/+LldjofPjQCEeCeLRFll2mVkwWWhOFhKG
 IN7MU3YRWL+q+RJBE4PzI0wUk3assNbeqI4BYn6AU75C2GMRbmGmTezswWKpZV6ZQWW+
 85p9khQQ/IszKo4t5C6HZBUsaro1bzliUPXRm6lZ9oa8eSPYgc6hHUZ/T5EV68wc6Xqz xg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsy9s1usx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 05:41:34 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20P5ePlE145387;
        Tue, 25 Jan 2022 05:41:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 3drbcn1st2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 05:41:33 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 20P5fW77149214;
        Tue, 25 Jan 2022 05:41:32 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by userp3020.oracle.com with ESMTP id 3drbcn1ss0-1;
        Tue, 25 Jan 2022 05:41:32 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Colin Ian King <colin.i.king@gmail.com>,
        linux-scsi@vger.kernel.org,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: 53c700: remove redundant assignment to pointer SCp
Date:   Tue, 25 Jan 2022 00:41:28 -0500
Message-Id: <164308927349.18787.18367431364523042445.b4-ty@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220123175530.110462-1-colin.i.king@gmail.com>
References: <20220123175530.110462-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: mAGfV7S2YYC876uXELITSjOycHJN4pxu
X-Proofpoint-ORIG-GUID: mAGfV7S2YYC876uXELITSjOycHJN4pxu
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Jan 2022 17:55:30 +0000, Colin Ian King wrote:

> Pointer SCp is being re-assigned the same value that it was initialized
> to a few lines earlier, the assignment is redundant and can be removed.
> 
> 

Applied to 5.17/scsi-fixes, thanks!

[1/1] scsi: 53c700: remove redundant assignment to pointer SCp
      https://git.kernel.org/mkp/scsi/c/efd7bb1d75cf

-- 
Martin K. Petersen	Oracle Linux Engineering
