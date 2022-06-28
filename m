Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE5FA55D466
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbiF1DZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 23:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbiF1DZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 23:25:05 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC6825291;
        Mon, 27 Jun 2022 20:25:04 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25S0uqoD002157;
        Tue, 28 Jun 2022 03:24:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=xf1JcHQpVhDIPQZtPrNBbWcxY0T+ujJplQxoR5/jLkM=;
 b=Qf3x5bfLp70/U0zGr8OoAYVKgMJkqFCA/DnlxtnL11ZoCXx/m3FfR+g4Ea9HzaIp8dgI
 Qy8IbBUA8H32H3/2IcDw0ARE+n0HKmrfNTvX9RMo3LTd4pxcoP5HZ5p0sZ6fNo091Ckc
 h6ODI5NV3UEopr7uC32Cx6VfP5Y/rHSWaB1H88HUstd1gYHwJ6qJ0rTf0JUnow6FuETD
 9NAEiOBCFUIhe0MxImtJ3gvgBH2nISKxW2+TutFFolTZ276MJCvVag+voF13UhfS1f85
 sPd2z53JdbUcn0MKHvLLQJixlqbaErgbbx5/eC+Iwoz0nbYiCiXkT/XK07NUut6Eck76 SA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gws52cupw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jun 2022 03:24:59 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25S3F1LF002385;
        Tue, 28 Jun 2022 03:24:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gwrt7jjmb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jun 2022 03:24:59 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 25S3NvqA016584;
        Tue, 28 Jun 2022 03:24:58 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gwrt7jjkg-7;
        Tue, 28 Jun 2022 03:24:58 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Jiang Jian <jiangjian@cdjrlc.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, target-devel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi: target: Remove duplicate 'the' in two places.
Date:   Mon, 27 Jun 2022 23:24:45 -0400
Message-Id: <165638665785.7726.3962528297159629240.b4-ty@oracle.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220621142012.4622-1-jiangjian@cdjrlc.com>
References: <20220621142012.4622-1-jiangjian@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: GsMWAj-Q0dtxs6jTfmIRzwrNovVx6FsR
X-Proofpoint-GUID: GsMWAj-Q0dtxs6jTfmIRzwrNovVx6FsR
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jun 2022 22:20:12 +0800, Jiang Jian wrote:

> file: drivers/target/target_core_alua.c
> line: 388
>  * the Target Port in question for the the incoming
> changed to
>  * the Target Port in question for the incoming
> 
> 
> [...]

Applied to 5.20/scsi-queue, thanks!

[1/1] scsi: target: Remove duplicate 'the' in two places.
      https://git.kernel.org/mkp/scsi/c/b73b14300e9f

-- 
Martin K. Petersen	Oracle Linux Engineering
