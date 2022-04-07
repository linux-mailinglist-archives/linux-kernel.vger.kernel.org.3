Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9DD84F80B5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 15:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343708AbiDGNhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 09:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343684AbiDGNhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 09:37:35 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D90B10C1;
        Thu,  7 Apr 2022 06:35:23 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 237A6w4R024455;
        Thu, 7 Apr 2022 13:35:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=5pnWjefEN5YEhfdfBhX8tGifU2QEgtV9zJecbDbCiIE=;
 b=BJMYB/rBX/FaPFyqQH+EZKShkQf37Gj0UQVAO0untzpbGgd93dyeLPP7SKoYDiGarzhT
 pNwLMrlSc1MgoCOytnfkF1f40SsuZGc5RJ1AoX19sV4Iw8mfq4KP60lEyFdjGir7j0xK
 UzwIcJR69Q8xs/7POG3aNju9aXfoFW/BpLpjhGrVNB/xxDlyhWWAdNSp750x1yzgB0j9
 6I3xhgz0QJ8fr35Tqhl6v0lfO4jUR1BAUtQsIRmG817TJ9LwFuq/0BTKguiUSp3MY9kt
 qv/kZP5cLW6Bfvd8vuXoS7PoJnGPYW2UGG5kSaHMB+AZhL3c2a+8OYUybyMIp5GoB+jM eg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6f1tc3r4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Apr 2022 13:35:23 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 237DLVWo036885;
        Thu, 7 Apr 2022 13:35:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f97uwtvrv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Apr 2022 13:35:21 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 237DZJLk032479;
        Thu, 7 Apr 2022 13:35:21 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f97uwtvpy-3;
        Thu, 07 Apr 2022 13:35:21 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     linux-scsi@vger.kernel.org
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] scsi: isci: host: Fix spelling mistake "doesnt" -> "doesn't"
Date:   Thu,  7 Apr 2022 09:35:02 -0400
Message-Id: <164929678999.15424.14180685273099205020.b4-ty@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220316235615.56683-1-colin.i.king@gmail.com>
References: <20220316235615.56683-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: xxm6UKRIVjNP0bs38aKRpbfCh57BSq-v
X-Proofpoint-GUID: xxm6UKRIVjNP0bs38aKRpbfCh57BSq-v
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Mar 2022 23:56:15 +0000, Colin Ian King wrote:

> There are a few spelling mistakes in dev_warn and dev_err messages.
> Fix these.
> 
> 

Applied to 5.18/scsi-fixes, thanks!

[1/1] scsi: isci: host: Fix spelling mistake "doesnt" -> "doesn't"
      https://git.kernel.org/mkp/scsi/c/fac952bb546a

-- 
Martin K. Petersen	Oracle Linux Engineering
