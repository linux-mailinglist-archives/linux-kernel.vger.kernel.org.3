Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F2B5AF9DA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 04:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiIGC2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 22:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiIGC2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 22:28:38 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22143915E9;
        Tue,  6 Sep 2022 19:28:38 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286Ld8Wk014578;
        Wed, 7 Sep 2022 02:28:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : mime-version :
 content-type; s=corp-2022-7-12;
 bh=TK2r5WsYXhV00MJj2nXZFkjMBR9MruAOWbBTHuLlIJc=;
 b=1fO0DV8t67R/lZWDyYhpJhRjWudosAd/JqcgbCR9wRla1UVDhZSyRWSuaS3x7ProavQC
 QZD44OjrtlS0E9iMNT9RxGXJmnvk2TyMsEP9I9VXzXAvcThfThZq+WTRQytL7H+3pp9N
 xrXn8g4cW/IyXmaUCA23XKlmr4c1OFfcvCiuQLoqax+VkW7l/qEs6TRDS520sFlj2rJW
 JLanqXkAYhZ4TkTUWuHqvu+eTAhKi77v+7sAh1qAZpSEdm3naDQvg0HWezddVIFdjpmf
 +Kb4ur5iJViClLlfpHDn54676BCptdbSOtCQV9/kMWjYRvrqEh8iGenmwEz/N+JmEbww Mw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbwh1fkcb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Sep 2022 02:28:28 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286NRPQ3030700;
        Wed, 7 Sep 2022 02:28:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc3qa5p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Sep 2022 02:28:28 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2872SRcE016472;
        Wed, 7 Sep 2022 02:28:27 GMT
Received: from ca-mkp.ca.oracle.com (dhcp-10-39-192-227.vpn.oracle.com [10.39.192.227])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3jbwc3qa59-1;
        Wed, 07 Sep 2022 02:28:27 +0000
To:     John Garry <john.garry@huawei.com>
Cc:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: Re: [PATCH 0/5] hisi_sas: Misc patches for next
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1k06fgbpa.fsf@ca-mkp.ca.oracle.com>
References: <1662378529-101489-1-git-send-email-john.garry@huawei.com>
Date:   Tue, 06 Sep 2022 22:28:26 -0400
In-Reply-To: <1662378529-101489-1-git-send-email-john.garry@huawei.com> (John
        Garry's message of "Mon, 5 Sep 2022 19:48:44 +0800")
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_11,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=962 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209070009
X-Proofpoint-GUID: yLV69ymai6807Jo__6e3pii8-sySCSJN
X-Proofpoint-ORIG-GUID: yLV69ymai6807Jo__6e3pii8-sySCSJN
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


John,

> This series contains some misc patches for next, broadly divided into two
> areas:
> - Revert hack to limit max HW sectors for v3 HW since we now that we a
>   proper solution in the core SCSI and DMA IOMMU code
> - Deal with SATA disks being lost during controller reset

Applied to 6.1/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
