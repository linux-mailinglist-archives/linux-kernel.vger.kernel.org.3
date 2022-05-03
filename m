Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49D2651961B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 05:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344415AbiEDDmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 23:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344366AbiEDDly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 23:41:54 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE0B27FE1;
        Tue,  3 May 2022 20:38:20 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 242MCRCl030007;
        Tue, 3 May 2022 00:51:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=co1HKWWIuvqZK5K23IbCWayVwEyZTYw1u2eKWn80D5Y=;
 b=FwFL/J/c9I5g3ahWu7vrXF2J/PeooBeLfKe7CpwYI22QQEOd0RDNh1BiiK+Wxj0TA9kP
 JtcfAa2EmSk6Oeknbvt5bzZK5iQe1er+/u8RGI7yT0rq+PCGb9jHaeTnq1MbTd6fEvhU
 1SNUdBqVZNlN5uRzQ5ryh3KGkA2dt05PDZCglyMz3snCRjyCW2+PVysTadMDhGsGhGLF
 QKYAjXIGSpx1fp1uEAX8gYO6ZKJ82K+Vcn7IBM/BHh4CbBuGERgVuR09syWTqs5FgQlI
 lII4nCw3ge0V6my7yXWyRtHeq8pmdnFiV8w52c9ooEo9jj6hoijolfmmpY64OGNzYdlx og== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruq0cp5k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 May 2022 00:51:57 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2430ooiZ008905;
        Tue, 3 May 2022 00:51:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruj83x8d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 May 2022 00:51:56 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 2430pljS010389;
        Tue, 3 May 2022 00:51:56 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruj83x4g-16;
        Tue, 03 May 2022 00:51:56 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     cgel.zte@gmail.com, james.smart@broadcom.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, jejb@linux.ibm.com,
        Zeal Robot <zealci@zte.com.cn>,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        linux-scsi@vger.kernel.org, dick.kennedy@broadcom.com
Subject: Re: [PATCH] scsi: lpfc: Remove unneeded variable
Date:   Mon,  2 May 2022 20:51:26 -0400
Message-Id: <165153836362.24053.10060021441010287017.b4-ty@oracle.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220419065750.2573861-1-deng.changcheng@zte.com.cn>
References: <20220419065750.2573861-1-deng.changcheng@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: zLpwvjFFXZwgsdli8mx19IOIUys6xj_-
X-Proofpoint-GUID: zLpwvjFFXZwgsdli8mx19IOIUys6xj_-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Apr 2022 06:57:50 +0000, cgel.zte@gmail.com wrote:

> From: Changcheng Deng <deng.changcheng@zte.com.cn>
> 
> Remove unneeded variable used to store return value.
> 
> 

Applied to 5.19/scsi-queue, thanks!

[1/1] scsi: lpfc: Remove unneeded variable
      https://git.kernel.org/mkp/scsi/c/a346f28ad231

-- 
Martin K. Petersen	Oracle Linux Engineering
