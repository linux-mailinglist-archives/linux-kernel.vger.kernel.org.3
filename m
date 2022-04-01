Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1664A4EF9DF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 20:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351123AbiDASdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 14:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241786AbiDASd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 14:33:26 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1DFE1DEC1D
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 11:31:36 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 231FkuFM018350;
        Fri, 1 Apr 2022 18:31:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=dAeGNiKA+HbyG44g+OzDSGwKtiI8Fufm9FEebQ5F42Q=;
 b=WZOVK/M9BvHrA66rQctVSnPyXj40g9bxK0NQuonxLqtvPMwbWrCkNFUBxL1eM5oQ3sTJ
 nDDPCHImRw/WjsRnReIA7eBRCREnFPZJDhu06+DW67bqQ2MAdLWk8+C1dvXwsl773WTz
 VecZujfV8/4KMsOkf5L/AdWlXD7AqbRjuejCLnV07jr5Q8KFVF236wUZ4U4KOq4IOO9+
 hp9tY/bjM10YJzLexiT479LYGg160+yZ/W3m/2g/mehJA6WRCAmlC6F7hn1ctiPhQQm8
 zltr4R9KAwTYjrnPpFyhb+l7QziilVOON72PNYg0ONYg9vEMzshrxfvZlexLrmFNb0RE Jw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1ucu00tq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Apr 2022 18:31:15 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 231IBOhM011881;
        Fri, 1 Apr 2022 18:31:15 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f1s9690hk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Apr 2022 18:31:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WUaq0o9Xy3JvmzD52N8CuCoffKIU73rDzG/lHzuwW27f3mn74TwZI1GLedeixZwaVKHwwxgjGNVdaCzIOceSd7EdsGKkeXZCNU3nUylCWfu2RWK8nP4rH8UlpIs6wGVAv2Vzn45wzFpfmYDc2jvKpOzgjxKBBW96m194Cm6sRRWIIfuvTfqi7An472HXp6OvR94ATwZPN/y47Rt+ccwl29GB+X/QcL7u6/XTnbThQHSGLRVpOheujX5RYhhTCKcE4oOahr8MTHuSlAZfhMGvSvn7jpyoacXGYp66SMzr442n8D1pcypeZmdpnSy+cscREp7vI0JRKsmEtWMfiPAEsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dAeGNiKA+HbyG44g+OzDSGwKtiI8Fufm9FEebQ5F42Q=;
 b=Jegq29UXjkEpJETE9Tv6DRDhaFWbxeSOulQbL2HqX4axdQb8fex2kz9iWl24Hzfuik6acKBotWC6z95GpPpt66DbLna/N2ecpjpcZDNDG4siiAhipMtghPd33vvy8THmDVT+hZz2xt1hlDVJTifMPNo+bQg2TbH24MwqTUTb3jswSdUCp/E6tUYPUPsBz91Yz34i7IKgJR9Y6HcYu2WEW++2lJaQFPsWFSPhLBU4Jkd7FU+FA0yOpLW/Dr67dieHVWN9gYdrBDwz+sZIDlW35B9Bn1g56ROLp2czb8jvZibBxKP0ED0szT7IkFHYMBiy/Xoy1K4uTB/KSQHcd0GmTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dAeGNiKA+HbyG44g+OzDSGwKtiI8Fufm9FEebQ5F42Q=;
 b=ZIXZe56ekw3vmA8rQoYPbEh5Hj7gj3SWFAsnnPZJm/AGqCtxNJb7OhWUWiK09BKnwqTfBx+FXZ6fQCugNjRWoUsXERp5MiYRooK6Wb5/Hkfx7Ik5cJLqBCY3dW8lNHnC9Lx6FloO5pI+s5R+3Eu1kumw/4XdS9ZcIwF9AngP33c=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by BN0PR10MB5502.namprd10.prod.outlook.com (2603:10b6:408:149::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.25; Fri, 1 Apr
 2022 18:31:12 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::3188:fe86:1d6f:53ac]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::3188:fe86:1d6f:53ac%9]) with mapi id 15.20.5123.018; Fri, 1 Apr 2022
 18:31:12 +0000
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com,
        eric.devolder@oracle.com
Subject: [PATCH v6 6/8] kexec: exclude hot remove cpu from elfcorehdr notes
Date:   Fri,  1 Apr 2022 14:30:38 -0400
Message-Id: <20220401183040.1624-7-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220401183040.1624-1-eric.devolder@oracle.com>
References: <20220401183040.1624-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0701CA0042.namprd07.prod.outlook.com
 (2603:10b6:803:2d::16) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ccf74a89-192d-4deb-3891-08da140dcc9e
X-MS-TrafficTypeDiagnostic: BN0PR10MB5502:EE_
X-Microsoft-Antispam-PRVS: <BN0PR10MB55020F734B2282C9CBF5FDE297E09@BN0PR10MB5502.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BkGKqkKoozswSmFJZOvR3RlezpXMqMMQcrNcdwPivHn7oAsVdPmTHiQcXyZ1Bp4hF76se4ljpzLNRk4JPKJlIaBlfrjKveJIjfICb5nqjjI/M0Muyy7m/HxWUzAgkZgqqLLzU5BPBO2SDiEVb6hfSrPTXfyIKtiA16o04xsxRM5Ja+QUDWz0B2bib8pLUjvEC9RNcG9r7WQl7kJwzdzE7Yk5MQMuFaqdORnRd//dhhHZHtyB00JXUK4xaehdNs2u4pCHKE+wHoB9ZSYAYJaQ1lDvzC+oypNx1ITSUJie3qAFeZOvcRxhZpqgnw6mvspJa4WQDXN13ClAOae0m6MXVl1S9h2Xof4iaxHcDP8UMPBY+O1eCnI6XhAAF21gDw+kd7tzk7ul+vwVs4JensRFaWVZr7m+l1xLAeE/yUu1eqh0qCkCFHM5Z8v9Y1M9LDanCcqoDYLQLITR8TCwauSFjqizKa4zPPmiQ7G8Wc/afpNViEpEpOiaAnxigYNOkJi8PX0Zo9q/plFmW4pWREeCbXZ8M0otkzpIH3BEGosdXH0wxWnh/cEFCTwGSG/iBpr4niDpHRahDb8oMHF43qrpeSiq6V/S1iLygkydFXoCQ2zi0nX1lksjYu5c7goLcROuKAcMOHT/HarSlhemn95mMS8ag8aqGNf8hGpSdvTThdv+UGBvS/EKZtEA/utXbm4uQ/EVvE9A05UW0AUL9/YiuA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6666004)(2906002)(6506007)(6512007)(7416002)(107886003)(26005)(2616005)(36756003)(508600001)(52116002)(1076003)(6486002)(186003)(5660300002)(4326008)(66946007)(86362001)(66476007)(66556008)(8676002)(83380400001)(38350700002)(8936002)(38100700002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q4AdhhupmT37l3Rj1eiyPMDARf1VYyhnQwaJiya7ZXXNAOGCnmtdhiZxmDc2?=
 =?us-ascii?Q?YUSz0ZD0Y8o0creIIJ0ZepFGkksThSciMwfMduYk52DnFwYBD9FM8OMsgKZJ?=
 =?us-ascii?Q?2neSJ2H7KtbxLg5uTVId8lEfeAfyDxoRxhTkGWjZ5ZNg15XrbKSF1038AxTY?=
 =?us-ascii?Q?D+h02nx55dSgVRRhEEpJNdGqf2cSOZryP3f+PvdC+yuuJ1oy0bFM11N2Dhvr?=
 =?us-ascii?Q?vHbluxrIrFET+evOf60niI1omeZc60jK04kCyunUQrqqr35VTyUH11GSBpT5?=
 =?us-ascii?Q?yDIPIo1Qt8kOkGTpVtC4NypzSA1IXvJ0j1PjbULULIv8ySPkWbPFdySsTFJM?=
 =?us-ascii?Q?q5jhhlQayAv3B9Gpu20bE7mFDmBqOYypFUpLN0Sok5Bq1GA2v3c2FlqFi0Mk?=
 =?us-ascii?Q?kpcB7PVNKlKuianaU3/oTDqeewaDBi0yYXRGnHJBKjaZZJ+zXOX8LVoBbxMS?=
 =?us-ascii?Q?zGv1ct1zfMM0bAChTB6sNcoOkSGYGyDlcEgIsX6aPnQpOH9uxJMR9YONi7h8?=
 =?us-ascii?Q?XmG/DhnnEXhQ9qIb0IX4YA/+ZtXMfyBX9BcIxnieWFpvvE/uvtdp8ioreHkd?=
 =?us-ascii?Q?os2a8jc6RXGYUmcczhId60vgrE0aYlXV7XSfeTyN2KEPsXbZQz/VMoEz3dyK?=
 =?us-ascii?Q?6rQ4LSudaLq3vEgmTSRACrxnhCjlVKbIdxrK/blPZhMeI6+n5t3kzh6kJEXr?=
 =?us-ascii?Q?N5BMlSVc/iznORsqWNtzyU+b3tkL1lkRB0bac90IHZx57Oz9S4SLmlynr/ND?=
 =?us-ascii?Q?43sq6+RE4CEPcdnk6Xd+XsbCtHT5izP22u/QPv0oozkYETspKvACH6zZGPhl?=
 =?us-ascii?Q?7W0JHD6AOlRgVSMMqflNkxW3aBfIQlenPD7f7e0jPlY2XXagVgW1x/ZXsjyR?=
 =?us-ascii?Q?5MbwMjwcTWK8U7zjvKIPuMGJxeJCBqIvOXXpQeSpmT4iUxGfePssB1z0jlJE?=
 =?us-ascii?Q?MkRpfjkwnSmU3plvnOODo9byaO6HuwA+5G8fvLZjPh2qyJZnITtewoFNBs6z?=
 =?us-ascii?Q?ySbX9Uu5iU2YQ4b9rWaVgj1imfMbKMa41E8jgSyVi2atzP2E0iybkNThTPyL?=
 =?us-ascii?Q?UfeJjZllITbZCiGE75fSvvCWsMyLBunjqjuSdO4hZUnm7ntD6KHKCjWfvw53?=
 =?us-ascii?Q?fbHK+SGxLMtivHz1Afj3p//eYFsSBWv9+NjLGdYmzYbRqz1TmpJBywuwDjYm?=
 =?us-ascii?Q?+j7Cphi3uWsd2m0OcHaF5dzG6Hf1ly4ynce8CyzmLdHAIo7SmRaEpZdCwBOW?=
 =?us-ascii?Q?wTh18JKW6VF8BMZzFRg3+yflZz5eCjZ92j3Wum5cKxq+RkMHD8hWpRFYwrQ5?=
 =?us-ascii?Q?9sILnOEZvFuxfBlr+TINDqD1oPH3M20Z/R+xaR8FcsW7me1I1mWz/NEU1kIW?=
 =?us-ascii?Q?mULLOjBulaFH7uLlPz3W8r687hQVa5oYynnVEh6ISNZALOLDWdGRIf8jo6Ue?=
 =?us-ascii?Q?n1z0bA4gOTtaW1rOIqnqCqtFWJvkx2CPnapym78HRMw2xIdHCXJpZ06pLG0+?=
 =?us-ascii?Q?jh0a+Gtg1pDdfgIFodJGJ+LPbSJSrX4W8G3YCBb6zAqYoJKlsOICjfrkG4pS?=
 =?us-ascii?Q?jYsEe+6O5XgpVigVIAm86jMjZ6xVdO0WIni56FabbRBOp1dPmQcsTr9t6DoL?=
 =?us-ascii?Q?K11dtdDqWvK0ig1y0zrJqDscI+un4Tn7+8kqtSOrGsLPiQ82MgbBh/3jYw+M?=
 =?us-ascii?Q?YaQ1Af3wZtrO2O5q+7K25H3D65lV3rbnI0dQHeyj9CRMl5n/6tkq2yQxIEkV?=
 =?us-ascii?Q?haVrBcMQJXhaKKPpGBQeucHeNfP3R0s=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccf74a89-192d-4deb-3891-08da140dcc9e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2022 18:31:12.7804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uLBFzcXda4pz+VMk34am3KygcX2qtR6qyiu+dn/kXT7sXkHewMO+ZgOd8WCV7wkgblzgCMQ4JqCmX9z3eWn14pOGFzRAXGi6fBYAWGJx9aw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5502
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-01_05:2022-03-30,2022-04-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204010087
X-Proofpoint-ORIG-GUID: nPEpEN4ILchOlTnJK0kg1xS89H30O9Dh
X-Proofpoint-GUID: nPEpEN4ILchOlTnJK0kg1xS89H30O9Dh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to use of CPUHP_AP_ONLINE_DYN, upon CPU unplug, the CPU is
still in the for_each_present_cpu() list when within the
crash_hotplug_handler(). Thus the CPU must be explicitly excluded
when building the new list of CPUs.

This change identifies in crash_hotplug_handler() the CPU to be
excluded, and the check for excluding the CPU in
crash_prepare_elf64_headers().

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 kernel/crash_core.c | 10 ++++++++++
 kernel/kexec_file.c |  5 +++++
 2 files changed, 15 insertions(+)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 76959d440f71..d3fd51f2195c 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -522,6 +522,16 @@ static void crash_hotplug_handler(unsigned int hp_action,
 		/* Flag to differentiate between normal load and hotplug */
 		kexec_crash_image->hotplug_event = true;
 
+		/*
+		 * Due to use of CPUHP_AP_ONLINE_DYN, upon unplug and during
+		 * this callback, the CPU is still in the for_each_present_cpu()
+		 * list. Must explicitly look to exclude this CPU when building
+		 * new list.
+		 */
+		kexec_crash_image->offlinecpu =
+			(hp_action == KEXEC_CRASH_HP_REMOVE_CPU) ?
+				(unsigned int)a : ~0U;
+
 		/* Now invoke arch-specific update handler */
 		arch_crash_hotplug_handler(kexec_crash_image, hp_action, a, b);
 
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 94a459209111..9d5c4eea0179 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -1314,6 +1314,11 @@ int crash_prepare_elf64_headers(struct kimage *image, struct crash_mem *mem,
 
 	/* Prepare one phdr of type PT_NOTE for each present CPU */
 	for_each_present_cpu(cpu) {
+#ifdef CONFIG_CRASH_HOTPLUG
+		/* Skip the soon-to-be offlined cpu */
+		if (image->hotplug_event && (cpu == image->offlinecpu))
+			continue;
+#endif
 		phdr->p_type = PT_NOTE;
 		notes_addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpu));
 		phdr->p_offset = phdr->p_paddr = notes_addr;
-- 
2.27.0

