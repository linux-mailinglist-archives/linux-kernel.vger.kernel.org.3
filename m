Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5617E4C61F4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 04:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232993AbiB1Do3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 22:44:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232987AbiB1Do0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 22:44:26 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213A03EB86;
        Sun, 27 Feb 2022 19:43:45 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21RMe1Es029547;
        Mon, 28 Feb 2022 03:43:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=pzQ4voSkjB4og5ReiQe7/SL59Nbsej1Cce7b8lDEcbA=;
 b=VpAuBHfrU2eedUNl97QvXqIRa6IRVmvNRbc6zO+WvVzGUvatZ20ZSMTfAPFr2VaociRK
 WLzGbDmUeVcnRbBa6i4hMGyKnEtm8TzlIXWX2LJqMbHgjcCoUS2N7vnlzwB2in8q6+2f
 y3FzZmpvhoZ16e3iA67id3nBEG8he9PcncZ3ryA5AK4lS/9P3vcBn1Vwm5Pg62Rnca+i
 ZsspsG6YuSiRtgvqiZfvkuZH1InxdQUtaI1RYF9rOEK28LTYTqbzZ9a5ljdtuxq1aMz5
 gShpNld8OrC2hIri4Ex+2tSSK8u2OCuDHqjou8bsHdtSuOCSqo2f8xNDsBe6eD8BoUUa tA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3efbttayf2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Feb 2022 03:43:35 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21S3b9h4157681;
        Mon, 28 Feb 2022 03:43:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 3efa8bxnwr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Feb 2022 03:43:35 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 21S3hPw4165853;
        Mon, 28 Feb 2022 03:43:34 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by aserp3030.oracle.com with ESMTP id 3efa8bxnt3-10;
        Mon, 28 Feb 2022 03:43:34 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Yang Li <yang.lee@linux.alibaba.com>, jejb@linux.ibm.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Abaci Robot <abaci@linux.alibaba.com>,
        linux-scsi@vger.kernel.org, john.garry@huawei.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] scsi: hisi_sas: Remove unnecessary print function dev_err()
Date:   Sun, 27 Feb 2022 22:43:24 -0500
Message-Id: <164601967777.4503.17661718587183450666.b4-ty@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220215020524.44268-1-yang.lee@linux.alibaba.com>
References: <20220215020524.44268-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: RZOZSHQrq0lcDxtJG5mY5lQkY26VYhuj
X-Proofpoint-ORIG-GUID: RZOZSHQrq0lcDxtJG5mY5lQkY26VYhuj
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Feb 2022 10:05:24 +0800, Yang Li wrote:

> The print function dev_err() is redundant because platform_get_irq()
> already prints an error.
> 
> Eliminate the follow coccicheck warnings:
> ./drivers/scsi/hisi_sas/hisi_sas_v1_hw.c:1661:3-10: line 1661 is
> redundant because platform_get_irq() already prints an error
> ./drivers/scsi/hisi_sas/hisi_sas_v1_hw.c:1642:4-11: line 1642 is
> redundant because platform_get_irq() already prints an error
> ./drivers/scsi/hisi_sas/hisi_sas_v1_hw.c:1679:3-10: line 1679 is
> redundant because platform_get_irq() already prints an error
> 
> [...]

Applied to 5.18/scsi-queue, thanks!

[1/1] scsi: hisi_sas: Remove unnecessary print function dev_err()
      https://git.kernel.org/mkp/scsi/c/07dd40b3078f

-- 
Martin K. Petersen	Oracle Linux Engineering
