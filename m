Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B74D64C9D08
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 06:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239645AbiCBFO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 00:14:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239217AbiCBFOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 00:14:37 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7E5A9A71;
        Tue,  1 Mar 2022 21:13:54 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2222WJEl016204;
        Wed, 2 Mar 2022 05:13:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=QBPMhmjyb/CL8ity/XH1m9/c0P9RBmK4NufFlzeztsA=;
 b=0/FnlMCnhc1ioQTsyDpRnll7y4SYEd+FwFSQwxxjh1sI52ZWSWKjZZKk/Em/0r4hVtnG
 Dispch2JSbRbF2s7uHL0Ip0GHe1MNVJ5YW9rTe0x4cZr+Rpr7LK+x52MnXZr3E9wSelf
 PxhEGsIsaurj829stFbsFCTMRcSIXKDbUmkt8AijNuEWVRxuwKjmnr/nkjsBx5L0Ucel
 lrA0EdtaTjjv/HCFwWAf1YEgpiv/7X1em8iN5WxLztjGDkWKzhV3gVQHrPsdj4xSc4W/
 wadOIrbWEOPSZmG/arJ3VNTmP7Tm8LiNs1utq8Zk1MVMb4SMZJicILGNsGS/6n74TI2y rg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ehbk9b9vw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Mar 2022 05:13:42 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2225C1s4175243;
        Wed, 2 Mar 2022 05:13:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 3ef9ayxgr2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Mar 2022 05:13:41 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 2225DVPW178145;
        Wed, 2 Mar 2022 05:13:40 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by userp3030.oracle.com with ESMTP id 3ef9ayxgcv-9;
        Wed, 02 Mar 2022 05:13:40 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     John Garry <john.garry@huawei.com>, jejb@linux.ibm.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        damien.lemoal@opensource.wdc.com, linuxarm@huawei.com,
        chenxiang66@hisilicon.com
Subject: Re: [PATCH v2 0/2] scsi: libsas: Some minor improvements
Date:   Wed,  2 Mar 2022 00:13:27 -0500
Message-Id: <164619702113.16127.922169481838127408.b4-ty@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <1645786656-221630-1-git-send-email-john.garry@huawei.com>
References: <1645786656-221630-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: mkCTFRZ7cB30VdNvQ6TW3w2g3zfDBvpO
X-Proofpoint-ORIG-GUID: mkCTFRZ7cB30VdNvQ6TW3w2g3zfDBvpO
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Feb 2022 18:57:34 +0800, John Garry wrote:

> This is just a couple of small improvements which we had sitting on our
> dev branch. Please consider for 5.18.
> 
> Changes since v1:
> - add RB tag (thanks)
> - simplify C code in 2/2
> 
> [...]

Applied to 5.18/scsi-queue, thanks!

[1/2] scsi: libsas: Make sas_notify_{phy,port}_event() return void
      https://git.kernel.org/mkp/scsi/c/f1834fd1635b
[2/2] scsi: libsas: Use bool for queue_work() return code
      https://git.kernel.org/mkp/scsi/c/a2a59faa359a

-- 
Martin K. Petersen	Oracle Linux Engineering
