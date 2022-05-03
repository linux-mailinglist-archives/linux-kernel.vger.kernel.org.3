Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1DB51D0DE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 07:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389268AbiEFFsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 01:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389259AbiEFFsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 01:48:21 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF7E5A5AC;
        Thu,  5 May 2022 22:44:38 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 242MkbAg018676;
        Tue, 3 May 2022 00:52:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=/yMc+68rWG/3heF7y7WQjy5vXUZ3ILi1SV6zf9lxjCs=;
 b=G6ut9T7quCoMvq6y5pCHeAfonD12JyxulfH22wtz1tKaZSmEutY+SDDcv3W6w3fShihF
 MHkaTkjhWf+MALC+MqfLZ+1rvolJgVoJzkFq6Z2OQF6P2FI9ivjbBq9Gok37WtOwuRZi
 iJ4Xwcm0R0J7P/xl3EfjRTVlLlxpLMF2f5BrWqg+iA1ljnqYZEMm+aKXK6XQ/+OIChv+
 VLWp7SCjZu8JZYBCrM7Xtkg5RF9DeIK0peiltn9F/pBrQdZq3H0ZSkllKCdfxOVNsHFb
 1RmXc2h5vrgVyfT7+X06KSolb0daBs2JlxDVput8ucqGS71bky1pGF1bwm6nrEWMRLwX Nw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frwnt4kxa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 May 2022 00:52:07 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2430oobc008887;
        Tue, 3 May 2022 00:52:06 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruj83xcb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 May 2022 00:52:06 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 2430plk4010389;
        Tue, 3 May 2022 00:52:06 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruj83x4g-34;
        Tue, 03 May 2022 00:52:05 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     GR-QLogic-Storage-Upstream@marvell.com,
        Xiaomeng Tong <xiam0nd.tong@gmail.com>, jejb@linux.ibm.com,
        skashyap@marvell.com, jhasan@marvell.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [RESEND][PATCH] qedf: remove an unneeded NULL check on list iterator
Date:   Mon,  2 May 2022 20:51:44 -0400
Message-Id: <165153836362.24053.12346613816767008308.b4-ty@oracle.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220405004055.24312-1-xiam0nd.tong@gmail.com>
References: <20220405004055.24312-1-xiam0nd.tong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: rSAztyxMg1cpFyDVEJEZ96yiVuUg8b84
X-Proofpoint-GUID: rSAztyxMg1cpFyDVEJEZ96yiVuUg8b84
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Apr 2022 08:40:55 +0800, Xiaomeng Tong wrote:

> The list iterator 'fcport' is always non-NULL so it doesn't need to be
> checked. Thus just remove the unnecessary NULL check. Also remove the
> unnecessary initializer because the list iterator is always initialized.
> And adjust the position of blank lines.
> 
> 

Applied to 5.19/scsi-queue, thanks!

[1/1] qedf: remove an unneeded NULL check on list iterator
      https://git.kernel.org/mkp/scsi/c/505420bd5543

-- 
Martin K. Petersen	Oracle Linux Engineering
