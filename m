Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFFD74AD0BE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 06:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347184AbiBHFcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 00:32:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347057AbiBHEw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 23:52:29 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A46C0401E5;
        Mon,  7 Feb 2022 20:52:28 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2184L2K0011035;
        Tue, 8 Feb 2022 04:52:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=WcCgwvEKi86M+NQtAEe06ujA2Pl3TBAZI3CX+Ny1qxU=;
 b=sAq34I5MaXWqTcH/oZ9LGscj4ueJUKTcWb8dZGViddZrzJ9drzXKsKxQej5Md65mSbSz
 yS0wKk760sr3EjdFUGUlXXDBrbBrnqunoGlbzGyu8++dAVyXaDb4mmYdIT5G9LOizl6z
 frWW1Zt9OKIn6/6V5R0QMBtKdv+mspM+i9lwg5WdmUc38StujBUuG68AE6Sag/iYKWU7
 xoWsCh0bzWm+Z3WdbJpTsuRmUZ8IPaHOC5U8XuLk9FJRIQB/M4MGPN/anMuZvZWyDdM0
 4ClJC6DhmcWkWbF0UAGdb0OSMwjgcLm4c4IbFkQniZmikGrgOWe9XEm4RJPwRlwlhKAq MA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e3hdsr357-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Feb 2022 04:52:21 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2184q1uX088368;
        Tue, 8 Feb 2022 04:52:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 3e1jppsrxe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Feb 2022 04:52:20 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 2184qKhr089147;
        Tue, 8 Feb 2022 04:52:20 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by userp3020.oracle.com with ESMTP id 3e1jppsrvr-1;
        Tue, 08 Feb 2022 04:52:20 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Cai Huoqing <cai.huoqing@linux.dev>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Saurav Kashyap <skashyap@marvell.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-scsi@vger.kernel.org, GR-QLogic-Storage-Upstream@marvell.com,
        Javed Hasan <jhasan@marvell.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: bnx2fc: Fix typo in comments
Date:   Mon,  7 Feb 2022 23:52:12 -0500
Message-Id: <164429583887.16454.3574990930026643354.b4-ty@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220128063101.6953-1-cai.huoqing@linux.dev>
References: <20220128063101.6953-1-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: hqlWlVeTGVp3cDhZGCYjclQhR5cmZZ_-
X-Proofpoint-ORIG-GUID: hqlWlVeTGVp3cDhZGCYjclQhR5cmZZ_-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jan 2022 14:31:01 +0800, Cai Huoqing wrote:

> Replace 'Offlaod' with 'Offload'.
> 
> 

Applied to 5.18/scsi-queue, thanks!

[1/1] scsi: bnx2fc: Fix typo in comments
      https://git.kernel.org/mkp/scsi/c/dd84a4b0fe17

-- 
Martin K. Petersen	Oracle Linux Engineering
