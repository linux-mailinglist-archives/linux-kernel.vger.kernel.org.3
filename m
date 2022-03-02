Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2CB4C9D09
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 06:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239649AbiCBFPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 00:15:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239555AbiCBFOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 00:14:41 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A18CB12EC;
        Tue,  1 Mar 2022 21:13:59 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2222fNJS014942;
        Wed, 2 Mar 2022 05:13:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=VCvbmaE9Y8xJeyRXM5RwRwoIfyYcdjQWRxq+128X92U=;
 b=Wytfhf9zeXck9POzPcfvbG7/TlMitFu2hKC+GEqvQndWixY2lvBTf5f6fO+HRTXxA3wP
 l7OTTtX23RWfxnohNAsOKZc7khw4K5YvDJRAMFxgJ/1IHW3EKkaZ6lkNIxKGui/8SWfG
 z6WhRmdOtRJdaOJtGr09ZxPUDHaWFsqw8hblK+O+Z3lYLiwMuYLFyBizxRqAqp0t35Fk
 nKvu6tAvtf2NrAP18gCUEdwvlPbjWZXFhcyRRzxVxLD+ZJrtt5UkmEatY+fk42vbiIYq
 Yvbl0T/0XwE5x6PhpH4wjifJoK5hWdWfjeT2OWKW9vp56GJGmRSFH3rLnk7vFwh6pCp1 WQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3eh15amp2p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Mar 2022 05:13:43 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2225C1QK175223;
        Wed, 2 Mar 2022 05:13:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 3ef9ayxgsm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Mar 2022 05:13:42 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 2225DVPY178145;
        Wed, 2 Mar 2022 05:13:42 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by userp3030.oracle.com with ESMTP id 3ef9ayxgcv-10;
        Wed, 02 Mar 2022 05:13:41 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Khazhismel Kumykov <khazhy@google.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, bvanassche@acm.org,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v2] scsi: docs: update notes about scsi_times_out
Date:   Wed,  2 Mar 2022 00:13:28 -0500
Message-Id: <164619702112.16127.16932201761407880759.b4-ty@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220219001601.3534043-1-khazhy@google.com>
References: <20220219001601.3534043-1-khazhy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: _22hVJYpTUmsgZM1uVpb5mpjmHqeb0sW
X-Proofpoint-GUID: _22hVJYpTUmsgZM1uVpb5mpjmHqeb0sW
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Feb 2022 16:16:01 -0800, Khazhismel Kumykov wrote:

> Most importantly: eh_timed_out() is not limited by scmd->allowed,
> and can reset timer forever.
> 
> Fixes: c829c394165f ("[SCSI] FC transport : Avoid device offline cases by stalling aborts until device unblocked")
> 
> 

Applied to 5.18/scsi-queue, thanks!

[1/1] scsi: docs: update notes about scsi_times_out
      https://git.kernel.org/mkp/scsi/c/5c139ce9e1c2

-- 
Martin K. Petersen	Oracle Linux Engineering
