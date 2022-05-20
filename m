Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B996752E1A1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 03:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344325AbiETBKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 21:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344285AbiETBJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 21:09:45 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1043133277;
        Thu, 19 May 2022 18:09:34 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24K0IxNW005510;
        Fri, 20 May 2022 01:09:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=I56I1cKcx8EtQH9A94iklFo5Z0QHsE+PkcopdKYfep4=;
 b=uFkiqPKKr4x4b6P8suLtDvNVO89uPLvZRr2lBYhjx3EK8h9rHrDW2qA5GJi4Q5k5WGwL
 LluPEcnnLs/WLd0YY+ZiWGYB08i/beEtDA+VcBVp9daQjAqeBvX719djQjzu4wT3w1rp
 Is0EMX+RNt3XGf/ktJNqEM1YBFnP14fh2n8RW9FEXPpN0wkAbImnSqR0Z+EllsGUC+ov
 hVyRozY5Jm1ki9oIwThT7dQh5tlWY9IISG7D5sT0YF0iU8OKM0QrB6sZ2lqCi7OQCkG2
 wRZUHZvNpsb63dW9kqJv7HMMk1kx8Mrs1JUw+YTfQY+g3AZD1lMr1HlUDfq+EuYyaMcM Gg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g22ucddr7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 May 2022 01:09:31 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24K15nFe020165;
        Fri, 20 May 2022 01:09:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g37crytrj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 May 2022 01:09:30 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 24K19GKM030710;
        Fri, 20 May 2022 01:09:29 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g37crythd-10;
        Fri, 20 May 2022 01:09:29 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        megaraidlinux.pdl@broadcom.com,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-kernel@vger.kernel.org,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        dan.carpenter@oracle.com
Subject: Re: [PATCH] scsi: megaraid_sas: Remove redundant memset statement
Date:   Thu, 19 May 2022 21:09:09 -0400
Message-Id: <165300891231.11465.13139857766667126042.b4-ty@oracle.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220505143214.44908-1-harshit.m.mogalapalli@oracle.com>
References: <20220505143214.44908-1-harshit.m.mogalapalli@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: zQOEP5NxUbOFEDNb8ISN8e_lcfZZL12C
X-Proofpoint-ORIG-GUID: zQOEP5NxUbOFEDNb8ISN8e_lcfZZL12C
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 May 2022 07:32:13 -0700, Harshit Mogalapalli wrote:

> As memset of 'scmd->sense_buffer' is immediately followed by a memcpy
> where 'scmd->sense_buffer' is the destination, memset is redundant.
> 
> 

Applied to 5.19/scsi-queue, thanks!

[1/1] scsi: megaraid_sas: Remove redundant memset statement
      https://git.kernel.org/mkp/scsi/c/2f9e9a7b0ce3

-- 
Martin K. Petersen	Oracle Linux Engineering
