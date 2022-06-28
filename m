Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44DE155D538
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232805AbiF1DZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 23:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232013AbiF1DZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 23:25:29 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE327252B0;
        Mon, 27 Jun 2022 20:25:08 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25S1g5tu031568;
        Tue, 28 Jun 2022 03:25:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=lwlP9jh3OiX6/OdiNWhehQGkgI3HQREBx2Pl1wl+Pbw=;
 b=MZq2I4guXHJbBsEJW6w3PQHWPQA53ZpoUZwxenKjiOA7/v04+2iV/AlcXGdKlwmCU2p+
 rvDc6CGQQABBXtDweaEuMwtWz/+A7nwziQ48NkadY8z2u3WW+845ulflkzqeIhu2pwtq
 uNmi7EyzMl0Eb9/vYKAzr/raAPHywm0kcZYV6A4KUDHUgIlXXZWBLfYPqsTLspxTQjwG
 3n2hrRgFk5GWzEIQQ/ayl6bHHHMuXH5HXInvKXUIK3j2qcVpwoKfFZEPoxaR8dCQvwz6
 iDelE6IkbRTHuXC1qumQdLUldxkLHqfPYNqnLRsSHRycQXB+4V2ldiyTvlMm0Iaf2IWm Mg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gwrscctnq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jun 2022 03:25:03 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25S3F2lX002584;
        Tue, 28 Jun 2022 03:25:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gwrt7jjnj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jun 2022 03:25:02 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 25S3NvqM016584;
        Tue, 28 Jun 2022 03:25:02 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gwrt7jjkg-13;
        Tue, 28 Jun 2022 03:25:02 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Ren Yu <renyu@nfschina.com>, jejb@linux.ibm.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        yuzhe@nfschina.com, liqiong@nfschina.com, qixu@nfschina.com,
        linux-kernel@vger.kernel.org, hukun@nfschina.com,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH] drivers:scsi: fix typo in comment
Date:   Mon, 27 Jun 2022 23:24:51 -0400
Message-Id: <165638665783.7726.13830190614996871126.b4-ty@oracle.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220617081557.9009-1-renyu@nfschina.com>
References: <20220617081557.9009-1-renyu@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: kA-KUwm-Kyk_alJRcS6Z-fFc3BDpaQu7
X-Proofpoint-GUID: kA-KUwm-Kyk_alJRcS6Z-fFc3BDpaQu7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jun 2022 16:15:57 +0800, Ren Yu wrote:

> Spelling mistakes in comment,non-succesfull -> non-successful.
> 
> 

Applied to 5.20/scsi-queue, thanks!

[1/1] drivers:scsi: fix typo in comment
      https://git.kernel.org/mkp/scsi/c/13d2d3428768

-- 
Martin K. Petersen	Oracle Linux Engineering
