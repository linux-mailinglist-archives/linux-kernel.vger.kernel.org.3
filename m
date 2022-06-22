Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E7055406A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 04:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356242AbiFVCKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 22:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356159AbiFVCKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 22:10:32 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD31338AD;
        Tue, 21 Jun 2022 19:10:32 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25M0J87t011411;
        Wed, 22 Jun 2022 02:10:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=oXSee4iT7qQ+pJvlSsNvU9u13UlTq+8lSOruPEuQFtI=;
 b=twmmd22VCEmKfeO+EN0oTMxqoxRTiZ29kF/AOkcFqJK2JoRifBiGVOo/alfY51yA9uot
 2a6X3CQdoHU2/FycvKYkiLhrGLLwZZG/LZbf6i/Qb05cmChntnr+pcFb+CRma81tIJqt
 cZUDiYlImhlK1O22/7ufqadJ3xLWpuhEiWrljPUD0Jyr7qXjwc5DezZtx7CFM0qqM6ft
 hpOQ/d3U56QVmRU3C1smWdqCljAPI6bwDdLtYT4vuynrGroVHDe/6XFXO7wKoQVwhpqe
 KF4raPU8OKfA/quqwgGT3d6AWYLLR3TytYDpxQV+JOOBrVtpb2smO7grdqef8jNZFYdJ Ow== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs6kf72tx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Jun 2022 02:10:20 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25M26XoM037974;
        Wed, 22 Jun 2022 02:10:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gtd9usx41-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Jun 2022 02:10:19 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 25M29Biq002724;
        Wed, 22 Jun 2022 02:10:19 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gtd9usx36-3;
        Wed, 22 Jun 2022 02:10:18 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     jejb@linux.ibm.com, John Garry <john.garry@huawei.com>,
        jinpu.wang@cloud.ionos.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        damien.lemoal@opensource.wdc.com, linux-scsi@vger.kernel.org,
        Ajish.Koshy@microchip.com, hare@suse.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] pm8001 driver improvements
Date:   Tue, 21 Jun 2022 22:10:13 -0400
Message-Id: <165586371837.21830.8658237744694865778.b4-ty@oracle.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <1654879602-33497-1-git-send-email-john.garry@huawei.com>
References: <1654879602-33497-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Fzy8DxTiGqm-AQ0-XQYTzsPG-ZEhcshT
X-Proofpoint-GUID: Fzy8DxTiGqm-AQ0-XQYTzsPG-ZEhcshT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Jun 2022 00:46:38 +0800, John Garry wrote:

> This small series includes the following:
> - Rework how some shost values are set
> - Fix a longstanding bug that the driver attempts to use tags before they
>   are configured
> - Stop using {set, clear}_bit()
> - Expose HW queues
> 
> [...]

Applied to 5.20/scsi-queue, thanks!

[1/4] scsi: pm8001: Rework shost initial values
      https://git.kernel.org/mkp/scsi/c/35a7e9dbff9a
[2/4] scsi: pm8001: Setup tags before using them
      https://git.kernel.org/mkp/scsi/c/98132d842d4d
[3/4] scsi: pm8001: Use non-atomic bitmap ops for tag alloc + free
      https://git.kernel.org/mkp/scsi/c/940f5efa6316
[4/4] scsi: pm8001: Expose HW queues for pm80xx hw
      https://git.kernel.org/mkp/scsi/c/42f22fe36d51

-- 
Martin K. Petersen	Oracle Linux Engineering
