Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3CE55CDFB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233205AbiF1DZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 23:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232078AbiF1DZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 23:25:29 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5055025293;
        Mon, 27 Jun 2022 20:25:13 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25S2XGe4031609;
        Tue, 28 Jun 2022 03:25:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=kSJT+QJx8jMx5c3S7XSloN29PWCmb4Z849RHrYsM+3w=;
 b=quAkqHUKUN5GvRDvvARL65jHBoxgUFAGtXW5bAZ1fR/TYgfF9QxbZxxHZ7QrIiP0PcqK
 auZUhMfOUTx1ucFj9+E6C+JHvloL3Hl8chlymqjDUJ8f61CB6F9dOd066QFUcye6Nf3p
 LEHjYODcwjWCQRKOBL0/LN5ZDOZiI4fm6DQ2GxfBNQZFFyFM4k88my4zZA7/futChkkc
 IulDKfDOh6iapXd/avvVTEIQd6yPryXxZcq7LmcsGk1dvF/Eq4yYKRhS/blTwfd57bCG
 p/QltXkTjqpxctHfVIQQa3FQK3JAtl5+m9WXX1UbDPLQkAauG2gRzaRX4ix4c/Na8Uri WA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gwrscctns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jun 2022 03:25:04 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25S3F1tk002522;
        Tue, 28 Jun 2022 03:25:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gwrt7jjp9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jun 2022 03:25:04 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 25S3NvqS016584;
        Tue, 28 Jun 2022 03:25:03 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gwrt7jjkg-16;
        Tue, 28 Jun 2022 03:25:03 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] ufs: core: fix typos in error messages
Date:   Mon, 27 Jun 2022 23:24:54 -0400
Message-Id: <165638665786.7726.10382926053807106409.b4-ty@oracle.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220621144653.62630-1-wsa+renesas@sang-engineering.com>
References: <20220621144653.62630-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: WTChrtkN_PrVrEZCWp3n0ciDfqm3IKQr
X-Proofpoint-GUID: WTChrtkN_PrVrEZCWp3n0ciDfqm3IKQr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jun 2022 16:46:53 +0200, Wolfram Sang wrote:

> Should be "retries" instead of "retires".
> 
> 

Applied to 5.20/scsi-queue, thanks!

[1/1] ufs: core: fix typos in error messages
      https://git.kernel.org/mkp/scsi/c/82ede9c19839

-- 
Martin K. Petersen	Oracle Linux Engineering
