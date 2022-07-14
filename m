Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A1A57425A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 06:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234627AbiGNEXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 00:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234107AbiGNEWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 00:22:55 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB3527FE2;
        Wed, 13 Jul 2022 21:22:43 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26E3mr4p020528;
        Thu, 14 Jul 2022 04:22:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=2Mckbs4YAYAcVLbjSRxivnepqiezCtzVZDxXf9+TgY8=;
 b=MgDY/2RCBJOlKQUwQa4vdM2H1IAGH2TjDi6hFj7U++yat/NdvKzi6JevQX7064Q7B2/M
 gCrkdw7k0eIZsvh9GNH/ZMPQXu6GA7KMettu2Y1+bJXsNKDqaECawGOr9f0cMjH9cAX6
 LXzOI5poG7hF2elCKa9ImRz6zKmSWK6Y8XUSjLYJbUHcazadKtrduB6LBbA6P4zwL7Eu
 TuZpLfVbpbOM6v+MTs2yhAu2GJhDpKvh2px/k8pK9WozQLMjLAntcbwqc2bIJQ0HW9pV
 Ghv71iZeh23ENiGUMZYTLhkzAjw3+m04DVeSYpa34whDTAHnW9Wds2hvVhnsgKaPMvjH bQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71xrkxsn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jul 2022 04:22:36 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26E4AegF039854;
        Thu, 14 Jul 2022 04:22:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h70451jpg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jul 2022 04:22:35 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 26E4MWBn023864;
        Thu, 14 Jul 2022 04:22:35 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h70451jnc-5;
        Thu, 14 Jul 2022 04:22:35 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     kashyap.desai@broadcom.com,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        jejb@linux.ibm.com, linux-kernel@vger.kernel.org,
        megaraidlinux.pdl@broadcom.com,
        shivasharan.srikanteshwara@broadcom.com, sumit.saxena@broadcom.com,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi: megaraid_sas: Clean up some inconsistent indenting
Date:   Thu, 14 Jul 2022 00:22:25 -0400
Message-Id: <165777182483.7272.9715366920278263861.b4-ty@oracle.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220630074152.29171-1-jiapeng.chong@linux.alibaba.com>
References: <20220630074152.29171-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 394KMuyQl3ON94uLJVUHnnUuWgv6mdps
X-Proofpoint-ORIG-GUID: 394KMuyQl3ON94uLJVUHnnUuWgv6mdps
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Jun 2022 15:41:52 +0800, Jiapeng Chong wrote:

> This was found by coccicheck:
> 
> drivers/scsi/megaraid/megaraid_sas_base.c:3950 process_fw_state_change_wq() warn: inconsistent indenting.
> 
> 

Applied to 5.20/scsi-queue, thanks!

[1/1] scsi: megaraid_sas: Clean up some inconsistent indenting
      https://git.kernel.org/mkp/scsi/c/acd1a2786c56

-- 
Martin K. Petersen	Oracle Linux Engineering
