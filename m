Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC71A51C98D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 21:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385403AbiEETvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 15:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385483AbiEETvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 15:51:19 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFEB5EBE3
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 12:47:31 -0700 (PDT)
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 245FhOpo003652;
        Thu, 5 May 2022 19:47:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pps0720;
 bh=C3QEOZbwGY5sXGcx1EpjDtWP0ojZE1TLeKrfEOzEke0=;
 b=VF2gFtW6wqp/nmndXtcLTS/8b435NXPUh13SQhzacfCr3W3akrSKQapAdF64ArztphY4
 zbAWp8V6BzBtWiyqY17nbTIF1VFIq6KejA37pnMzhRafKZ99klqNW8HZ0T0cF0Vl/gpW
 jBw8pSyWNysnS6998PFZRzsnR15rNSGOAT0eMu4cWrs7OMHo5JqJEZ8voBiBkBoBbl0z
 ljEIRCzGNL88Pu/wv52ZwS5gfX+7BYHXArJbj4s4WYF5+7+6GchByksxNx73GYU18PCq
 ojIz7rCNYn4dYjaPBSDI8LIvD/oa0o41nf93PwMhP7JnuRmROKt2w5oHLO0h7GQ24FgS ZA== 
Received: from g4t3427.houston.hpe.com (g4t3427.houston.hpe.com [15.241.140.73])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3fvhfd2336-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 May 2022 19:47:00 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g4t3427.houston.hpe.com (Postfix) with ESMTP id 346D25E;
        Thu,  5 May 2022 19:46:59 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 7FB9E4D;
        Thu,  5 May 2022 19:46:58 +0000 (UTC)
Received: by dog.eag.rdlabs.hpecorp.net (Postfix, from userid 200934)
        id 275CF30193E67; Thu,  5 May 2022 14:46:58 -0500 (CDT)
From:   Steve Wahl <steve.wahl@hpe.com>
To:     Joerg Roedel <jroedel@suse.de>,
        Kyung Min Park <kyung.min.park@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Will Deacon <will@kernel.org>, iommu@lists.linux-foundation.org
Cc:     Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/vt-d: Increase DMAR_UNITS_SUPPORTED
Date:   Thu,  5 May 2022 14:46:58 -0500
Message-Id: <20220505194658.246121-1-steve.wahl@hpe.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ZiQt0AfFhekgODgw_TIdFOWhuDP_me1a
X-Proofpoint-GUID: ZiQt0AfFhekgODgw_TIdFOWhuDP_me1a
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-05_08,2022-05-05_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=999
 mlxscore=0 spamscore=0 malwarescore=0 impostorscore=0 phishscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205050131
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Increase DMAR_UNITS_SUPPORTED to support 64 sockets with 10 DMAR units
each, for a total of 640.

If the available hardware exceeds DMAR_UNITS_SUPPORTED (previously set
to MAX_IO_APICS, or 128), it causes these messages: "DMAR: Failed to
allocate seq_id", "DMAR: Parse DMAR table failure.", and "x2apic: IRQ
remapping doesn't support X2APIC mode x2apic disabled"; and the system
fails to boot.

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
Reviewed-by: Mike Travis <mike.travis@hpe.com>
---

Note that we could not find a reason for connecting
DMAR_UNITS_SUPPORTED to MAX_IO_APICS as was done previously.  Perhaps
it seemed like the two would continue to match on earlier processors.
There doesn't appear to be kernel code that assumes that the value of
one is related to the other.

 include/linux/dmar.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/dmar.h b/include/linux/dmar.h
index 45e903d84733..9d4867b8f42e 100644
--- a/include/linux/dmar.h
+++ b/include/linux/dmar.h
@@ -19,7 +19,7 @@
 struct acpi_dmar_header;
 
 #ifdef	CONFIG_X86
-# define	DMAR_UNITS_SUPPORTED	MAX_IO_APICS
+# define	DMAR_UNITS_SUPPORTED	640
 #else
 # define	DMAR_UNITS_SUPPORTED	64
 #endif
-- 
2.26.2

