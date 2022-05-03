Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2131519D7B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 12:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345860AbiEDLA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 07:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234997AbiEDLAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 07:00:53 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B1A1C13F;
        Wed,  4 May 2022 03:57:18 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 242KZ9w6019152;
        Tue, 3 May 2022 00:52:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=ZJ54LSEgX3njKu4hd3Ax1MbhaPmxQOdsn4N1D9vqEz8=;
 b=xP9nKxMFCLtCV+0Xz8C9DcLaZx+RkqoY8jIISJEc2UAWfnyWcMuBopQhjJBBexG8ZbAM
 6fKlGmFQPcgV6bCYXwXnSvN73ccbuPt9MKREmxVi/qWWV6+yJeB91Fpg8lCeWmizyIEl
 WkgUG+ysZumnQadiLuCNXOndLwdH6rlHu3sCax9vU3QuFeBTWHmbRKM9qRc1i21y62Pg
 ccsFIP8IYPthyQ9M4ZV+/WJZ/lB55ag5PDPvDdG4s1awU2MqMYqea9OyKE/HLVryC+ip
 yotFhtf6SCeFBRXZCEXAa8Qu5aSif7YsceWA+XonALSsmWko3JK+DLvfoTtWgLH1XQA0 0A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frw0amhjp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 May 2022 00:52:07 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2430oouA008900;
        Tue, 3 May 2022 00:52:06 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruj83xc4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 May 2022 00:52:06 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 2430plk2010389;
        Tue, 3 May 2022 00:52:05 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruj83x4g-33;
        Tue, 03 May 2022 00:52:05 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Wan Jiabing <wanjiabing@vivo.com>,
        linux-kernel@vger.kernel.org, Avri Altman <avri.altman@wdc.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Daejun Park <daejun7.park@samsung.com>,
        Can Guo <cang@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Bean Huo <beanhuo@micron.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-scsi@vger.kernel.org
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] scsi: ufs: Remove duplicate include in ufshcd
Date:   Mon,  2 May 2022 20:51:43 -0400
Message-Id: <165153836362.24053.10505996788821361568.b4-ty@oracle.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220426104509.621394-1-wanjiabing@vivo.com>
References: <20220426104509.621394-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: wsZ9qXf90RI_NRzkpvJm-14JBBO3tq9s
X-Proofpoint-ORIG-GUID: wsZ9qXf90RI_NRzkpvJm-14JBBO3tq9s
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Apr 2022 18:45:07 +0800, Wan Jiabing wrote:

> Fix following checkincludes warning:
> drivers/scsi/ufs/ufshcd.c: linux/nls.h is included more than once.
> 
> The include is in line 14. Remove the duplicated here.
> 
> 

Applied to 5.19/scsi-queue, thanks!

[1/1] scsi: ufs: Remove duplicate include in ufshcd
      https://git.kernel.org/mkp/scsi/c/8ad8edd2fbae

-- 
Martin K. Petersen	Oracle Linux Engineering
