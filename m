Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9982553218D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 05:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbiEXD1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 23:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbiEXD1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 23:27:31 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56EA403E3;
        Mon, 23 May 2022 20:27:29 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24NMhkf4029163;
        Tue, 24 May 2022 03:27:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=l/odymUO5M8K1l+Ewemv04ZBuCG4Of1t6b1MX+PT3i8=;
 b=D2l9REEVk4vrwC63XPAbByNUrBmeBJ7a3/ZAijicyvcwsZ15VyEIyMBHspnq7h4EGpsE
 hNRffvIT2zfLxCUUyeW0Ibi9GLER0CqbHjQScmoQj2fIphWwpZ2uzEmnaebbekb7HD+2
 pXs2nIcFFZltEHD81XUnsb3oKntYI9sMmJM+nJj2s+K/TcV69eKm8ekBgZk5zefqsxaW
 Z004Yv406bWmJTuSaD3hQihYZpN/S7nvKdtltN8nyWJIDM1disrumqr0fg6WFebBvd8V
 HxNzrGXBtaO1Hn+eN4cT67I7bq7xBa2g0e4frBNAsvaLlsBSHdi8kJUCYIDkZhxf9I/s 4A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g6qps55gj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 May 2022 03:27:26 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24O3QNtU015138;
        Tue, 24 May 2022 03:27:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g6ph1y34s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 May 2022 03:27:24 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 24O3P61L012957;
        Tue, 24 May 2022 03:27:24 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g6ph1y349-2;
        Tue, 24 May 2022 03:27:24 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Michael Reed <mdr@sgi.com>,
        Colin Ian King <colin.i.king@gmail.com>,
        linux-scsi@vger.kernel.org,
        "James E . J . Bottomley" <jejb@linux.ibm.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] scsi: qla1280: remove redundant variable toke
Date:   Mon, 23 May 2022 23:27:20 -0400
Message-Id: <165336281522.11823.9616489955275081348.b4-ty@oracle.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220518102103.514701-1-colin.i.king@gmail.com>
References: <20220518102103.514701-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: rjHHylhZ5Yypw70MIU7yrA-GdfgOvaG2
X-Proofpoint-GUID: rjHHylhZ5Yypw70MIU7yrA-GdfgOvaG2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 May 2022 11:21:03 +0100, Colin Ian King wrote:

> Variable toke is being assigned a value that is never read. The variable
> is redundant, remove it.
> 
> Cleans up clang scan build warning:
> warning: Although the value stored to 'toke' is used in the enclosing
> expression, the value is never actually read from 'toke'
> [deadcode.DeadStores]
> 
> [...]

Applied to 5.19/scsi-queue, thanks!

[1/1] scsi: qla1280: remove redundant variable toke
      https://git.kernel.org/mkp/scsi/c/c10ba0c961d3

-- 
Martin K. Petersen	Oracle Linux Engineering
