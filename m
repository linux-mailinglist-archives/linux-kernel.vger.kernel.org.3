Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1FE517CC4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 07:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbiECFF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 01:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbiECFFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 01:05:54 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13BB83EBB5;
        Mon,  2 May 2022 22:02:23 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2430TJqh004092;
        Tue, 3 May 2022 00:52:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=yFd4NJS8ZhexAsGkucoumLavXxhcMU4eu5Tb4OVqoxg=;
 b=wUeMbfXmPFimS/iBwXMhjP/qUgG/DEL6bb3NPUuPCziNvLgIp9X4veQeCAxjaRD0LRVT
 wZHlcI4vWRShFsq+W4wyf5Tuy8O4A6FIJKXrLLiqx2zUgazNjQ4l9peEY4WFl2vEHXn/
 Ltf29fXSNhNoNM9ckCKsKV3HZ1oiBkUQt1zulFYzbB3EPfdLEpKw0jm8mYJEqNNRW0MK
 IlofsfbymJkyukKQvevtSqPFfasigVxgFIcspq9SO9fSzDFtm/b/3FH6VADuLxdA25Ds
 s+Jbu7199tFlOskQq/Bb59T/2CTFHihb2yPYrjDtk6/DfmB5+8MUFF9sfcuNdGsvfujb yQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frw0amhje-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 May 2022 00:52:01 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2430oobu008895;
        Tue, 3 May 2022 00:52:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruj83x9s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 May 2022 00:51:59 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 2430plje010389;
        Tue, 3 May 2022 00:51:59 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruj83x4g-22;
        Tue, 03 May 2022 00:51:59 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        open list <linux-kernel@vger.kernel.org>,
        Nilesh Javali <njavali@marvell.com>,
        "open list:QLOGIC QLA2XXX FC-SCSI DRIVER" 
        <linux-scsi@vger.kernel.org>,
        "supporter:QLOGIC QLA2XXX FC-SCSI DRIVER" 
        <GR-QLogic-Storage-Upstream@marvell.com>,
        Guo Zhengkui <guozhengkui@vivo.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        zhengkui_guo@outlook.com
Subject: Re: [PATCH] qla2xxx: edif: remove unneeded variable
Date:   Mon,  2 May 2022 20:51:32 -0400
Message-Id: <165153836363.24053.11308117842867099296.b4-ty@oracle.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220426074334.9281-1-guozhengkui@vivo.com>
References: <20220426074334.9281-1-guozhengkui@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: LmUNEdavoshKYgzs-Dc4RUzoxPKAK1yT
X-Proofpoint-ORIG-GUID: LmUNEdavoshKYgzs-Dc4RUzoxPKAK1yT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Apr 2022 15:43:34 +0800, Guo Zhengkui wrote:

> Fix the following coccicheck warning:
> 
> drivers/scsi/qla2xxx/qla_edif.c:660:11-15: Unneeded variable: "rval".
> Return "0" on line 761.
> 
> 

Applied to 5.19/scsi-queue, thanks!

[1/1] qla2xxx: edif: remove unneeded variable
      https://git.kernel.org/mkp/scsi/c/1497e95e22c3

-- 
Martin K. Petersen	Oracle Linux Engineering
