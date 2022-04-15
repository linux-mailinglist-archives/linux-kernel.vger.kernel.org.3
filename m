Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C910502C70
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 17:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354915AbiDOPT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 11:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233750AbiDOPTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 11:19:24 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B143BD7E7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 08:16:56 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23FF0ENf029741;
        Fri, 15 Apr 2022 15:16:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=c5bl9qSBbW0FlU030S10qqgrD76TVgpvjHMkIwwCQDY=;
 b=U5B0E+HHvA+KhALZjmYJWniRgMyWPHEjPRpB1f325j1KdK8xdpsGFZGnmUzGIIhMx5Au
 2sgZlpth715E5yfLWxSMuPfMTKukLuUP6vYy1jRYzDtTLEpdq39xD4i37c9br8wpKaYY
 nZoNVKk05IlFSNREJj73A67fOC0vvL+j9gZMU+drUyRQjTwRC4p3tHNWBRYBI/Il14dh
 FR42C6doqbYuBOszVWlXZtVrNJPFJaYjqC3CpxudUKiAWnNLHNX5PpH/p3iRXFXCT5XP
 Xto7I2Q3HroZ0udl+K8GAK2PdlXHig+WfWoQ48bP6gX1PKyf/aNOELwNMofvtDa28P/R pA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb0jdewec-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Apr 2022 15:16:30 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23FFBYu5012568;
        Fri, 15 Apr 2022 15:16:29 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2169.outbound.protection.outlook.com [104.47.73.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fb0k5ry7r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Apr 2022 15:16:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cxhI6I3lj6I3+llxrv8uP6fcaR1vdAp9rqZpl+wC2tTLQBZnSPSGs3BYfhiEcSE5Tj8RLtULZZX0ll2np6FH3+ptPlqP67IHAONVIN6FiIwXDvIkJlA5auGGd8SQKgwS1g0kB5BP2B6PtqkQqzui9BqE5KCT0VZbRQZANTSx16503+wWPblmDhOKOf6Xxog3bWtaLslqCj1PTwRDufNbFlggLnOBGWtLoybJ+SZ3KrA6myzwdBGR0GJsqd3ADXxp9LD43sDaVWXgwvb7X59uSsZa6KCe6V5Hr/odJac6K1tBa7IU36VV2xInrD8NXrepaFY/XGGaHLX/cdNj7minPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c5bl9qSBbW0FlU030S10qqgrD76TVgpvjHMkIwwCQDY=;
 b=Cc1deu8rm2wY7/850F8lXj10vrlvdX/Cs5GQO2tKt+tj+S4U7cCXKtE7nkUhfrHbwgIViGny5rO12AAmn7S0RcolK+1hd9h43VN2N599/rXJ/9FKhFYZwBr66EXUCNIHxNFaMuK6e3kkqT0ZxIKrmQ7yFJCPblroem+TkDunzt39jfNwjER0MiASaE0YtitE36VOgqTPte710oslAdeXCCpbR5q6XQRo1S4W0EjNuPMDOcYcBqkV+12NkUnZjNIH+befSAi9UOlXCKxx/UZtu353NnMkYn782abw4ESGGaBvzPYt2SpTZWSGWPO9fIZRfh9WhYMIQfNt8SvNvhTWpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c5bl9qSBbW0FlU030S10qqgrD76TVgpvjHMkIwwCQDY=;
 b=mvV5yKbzt/3hTXwo3lsmY+1/A3/NXhGigpu7jTzE6jt6wfM7NKgdKUS7Ur3KG9qhS4+z3aW1h4k+zKE4Ra3qid+Sr1YLBl2ba2a382ERGnw9UKQhMm7jrx24E2320SAwadjs36kSVWT+GkrL6ZrseIOTh8UbIp57uIvV5NjBoaE=
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by PH7PR10MB5854.namprd10.prod.outlook.com (2603:10b6:510:127::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Fri, 15 Apr
 2022 15:16:27 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::1ccb:ce96:8c51:478c]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::1ccb:ce96:8c51:478c%6]) with mapi id 15.20.5164.020; Fri, 15 Apr 2022
 15:16:27 +0000
From:   Ross Philipson <ross.philipson@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        luto@amacapital.net, dave.hansen@linux.intel.com,
        kanth.ghatraju@oracle.com, trenchboot-devel@googlegroups.com
Subject: [PATCH 2/2] x86: Check return values from early_ioremap calls
Date:   Fri, 15 Apr 2022 11:10:01 -0400
Message-Id: <1650035401-22855-3-git-send-email-ross.philipson@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1650035401-22855-1-git-send-email-ross.philipson@oracle.com>
References: <1650035401-22855-1-git-send-email-ross.philipson@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0071.namprd03.prod.outlook.com
 (2603:10b6:a03:331::16) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 050bf248-ee49-4b83-a79f-08da1ef2e941
X-MS-TrafficTypeDiagnostic: PH7PR10MB5854:EE_
X-Microsoft-Antispam-PRVS: <PH7PR10MB5854982536536101A40A7DD6E6EE9@PH7PR10MB5854.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oNT0sMwDKnWX0wpLUeJHujE5ZGkzu49FuNaPaj8LYnsAhELk6c+k4yKI9f4k6eCQVIMo0VZYHKA0v8bZPK3wCn81GVWcBb+HIu4zP5JnEXrUgBu7C1X6FjIAl8CrXrSp3clvOporQRxhrJrPnOlN/ICezM88c+hnemg+a7DP/oeXfvFR38Yr2cgLB2z4hZAJ6apO5zgPZXIcXg7RDFtwhnO4Xm5eSm0m3MhsyATbWhCiYJArMZ3r5T/dkW0IrHFglOS+2J49LjU0S9M3KUgH7C/tivQNmq1RaVU7H0Wkd/N7xwlOdV5uAAi9CYqliO9EYgFKLed5dyg+9/kApmiYMeWHoVs6P3H8zLrgZ6TvMAjggdX1FgO1gN3baDH1Cvkk+RqoEfFAoeU2tmNsdPs7rAH4hKg/0Wyv5e3iKijWpNZR6sBkyVHZgIctKTl8HL6YS6R3sMcgFII/mD0IyhcCaL/I50rpSKM27lA5pfG6XR8AfRAe/c15cfuIDjPu4bt9alT3/6C5eA5YBKtOzgGcN32nU296BidfK5nLBbrb33fCaKBKw6KkPQEyKiz++Hvz168mGetdBR617/Zi9Q/Md+0EMVJssPcnnuZOavQg65A6Qge+pBpch1ff0IFR84UMoV3Kt01zzCn2IW2HFehp3JXDDyZhYBvV5C1NnU/dru9/5N9hSWnyf9XTJGL4JrE0Ds9F4YonYB6I/qEQCJBssw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(52116002)(7416002)(6666004)(8936002)(508600001)(44832011)(86362001)(38350700002)(38100700002)(6486002)(2906002)(83380400001)(26005)(6512007)(36756003)(316002)(186003)(4326008)(8676002)(66556008)(66946007)(66476007)(2616005)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XCupZZsr3BYZiuBKnvjKMcF+WAK4Ai65D6lisPXx4YSKzxN2QpsbXFmadTjv?=
 =?us-ascii?Q?0q7ZRE8Ffwo8ip5dtYARnIC8VAEG/SMnaR7gigQ7NJHgADs0ywIhOSf+DkYS?=
 =?us-ascii?Q?/elDSxKDxIVk6DjiyszuANehORL5NEdiVMqA5BW9B0pDhAl7W6LVS0D8Mg/a?=
 =?us-ascii?Q?vauwePT+sq0lAj43ugC3s2xrO9RBUu+2PmKnvspRSChEZ+DgHgynONgJermg?=
 =?us-ascii?Q?5JymjjKoLLaMK8ueNiC+6ZasMFr6tQPXbQdSwq3sRx0bMH+JWN4OYmCFABMa?=
 =?us-ascii?Q?R0QRUSPM/XYVNGiJtBcvpKXtoMFpWKpc3g9N/RM7DIN19s0KTXxTCsbNWVdn?=
 =?us-ascii?Q?mRLU3keH97XXIPPtV/sCebkLmXgD/MK1TPoKFIaXdb1LgAk8zaP2Ra/XkxP0?=
 =?us-ascii?Q?s0ptkFdvPJMsA1zlwYIge7hEwWLNKlkhDUN1UNJWKhViMDm7zmldsE02XaB9?=
 =?us-ascii?Q?8MoIDDTpaiQw6N6JZ1buiHslDVdPugYar/2RbcYygF1hySZgdfxzl1xXyBoP?=
 =?us-ascii?Q?THmIifYe3f7QkhWpf4x+IR9l1hB/TqLzMaa27EOeu+I/nFiYx2auITEwHAWb?=
 =?us-ascii?Q?sff0BnddB5taIXeBGwUGtbNRArO/+mAOJF2IgEz3EGz9ta3bGi727YnnlcpP?=
 =?us-ascii?Q?FjEEhfVHDzKDJce33D0MsJgJJkYf495YeKpkalAvx69A3S7/vY8e1sLhSKwA?=
 =?us-ascii?Q?m14UGPLbSMRxLQL1Hrd3ZK3GjEWZ1aJmevtvW51hcT7BRWG1+uzW3iyRFboT?=
 =?us-ascii?Q?jqJXJS95AyoXhBSgVIhKLjQp5tT48Wworl/7RJtS38LZyBjOGff2W9YTSqgK?=
 =?us-ascii?Q?qINZVwg/mmaoXjqKnHcfvhEXc3+BvcDgaGRlt8ueTQIn+UGyXGVuTC1Tx5lx?=
 =?us-ascii?Q?a+Hupj83zfS4sCswsyXHB1QyMtmNl3DlhngXzH4RowQ4lsemLPELus0Uonru?=
 =?us-ascii?Q?MC9ADu0bK9dGzkIFw/cWfgPwLwxNXwp6udD37pvUccGsMeNWxtCrwkKAC7iV?=
 =?us-ascii?Q?AgEvnuCF+XyRP9hCt25t2pHrtABZPdL3O7Sqmmv0GeE/IS6bUFXEJ0iEhaeB?=
 =?us-ascii?Q?WuJLKsPZn5zAjPd2CPSGdKuhpz/hRpffQ7rlsJX5rUswKrTFcL/wF7I5/XA5?=
 =?us-ascii?Q?Nm1bygOTjRPaNBO66NXy5wTj/81yvyn9cQGXbvDQdWp6XvHEiBcvCbhUCtTp?=
 =?us-ascii?Q?kIqWR99cQ9XYPd7nYk6bhbZKJw78rHV2OYbOQAeW230tcLBr6XYUiruFz+DU?=
 =?us-ascii?Q?8PrQbD9Fp9JP6vAdWnajr6fifRLL6wdPbkB/pbSiB4omzTatM0dsMiEHHwAG?=
 =?us-ascii?Q?QLrsjXYe/hbltXhVuvNpqezd9cKNhFeHjYfU9j74soxl88TWBYxWUpX8mlOp?=
 =?us-ascii?Q?y0T3mc7gcxVrtPHOB3hHPipPeVtyxNf4KHzBiND1FObVbk1KFS3XmgveeXjc?=
 =?us-ascii?Q?iPVZVTaITsWkdwPNh5TgCHPak4O4um+krYL3ZR7O0g1U/XxViFoNDcglUFC1?=
 =?us-ascii?Q?sjfA3tFj1GuehIp3wfPdylwdIbuGVnbkOswsN6YcKZyUYSI2nmiCXo7bDRsG?=
 =?us-ascii?Q?QuY9AqrSdjx2tno4Yr2HC46MawX0O6YYXgxUJlAVFJgZ9fyLD/6/1gWoXqbn?=
 =?us-ascii?Q?19Finwg/bDjAqkM3SdxVXhZuSsg2fyflXXa1J2hlL1JMrDqJgQ0cDdeURabH?=
 =?us-ascii?Q?4HWXkr6outssDBP1KbsEJmyS0X1MmFj5uH0z1ihdFfzFCQW33zO6XDipYbbA?=
 =?us-ascii?Q?O+RtdlmFvwvMDZcoIL4m7geydMCIUJ4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 050bf248-ee49-4b83-a79f-08da1ef2e941
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2022 15:16:27.2221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BbpbsWgNSLm9lYfEWXrRPyQ1nWY385Ze5ts/9SLR5DYGVwIYz9wDg/AUUugZ5kdLXLSVCQdBufCRfGziaNCvtmQ9SESAHKLY42K1l3QD0kI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5854
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-15_01:2022-04-14,2022-04-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 mlxscore=0
 bulkscore=0 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204150090
X-Proofpoint-ORIG-GUID: wmmEQ_nyM3YdpkJeuJbgJsTcMGKg5EVO
X-Proofpoint-GUID: wmmEQ_nyM3YdpkJeuJbgJsTcMGKg5EVO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a number of places where early_ioremap is called
but the return pointer is not checked for NULL. The call
can result in a NULL being returned so the checks must
be added.

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 arch/x86/kernel/apic/x2apic_uv_x.c | 2 ++
 arch/x86/kernel/early_printk.c     | 2 ++
 arch/x86/kernel/vsmp_64.c          | 3 +++
 3 files changed, 7 insertions(+)

diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index f5a48e6..7a64287 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -75,6 +75,8 @@ static unsigned long __init uv_early_read_mmr(unsigned long addr)
 	unsigned long val, *mmr;
 
 	mmr = early_ioremap(UV_LOCAL_MMR_BASE | addr, sizeof(*mmr));
+	if (!mmr)
+		panic("UV: error: failed to ioremap MMR\n");
 	val = *mmr;
 	early_iounmap(mmr, sizeof(*mmr));
 
diff --git a/arch/x86/kernel/early_printk.c b/arch/x86/kernel/early_printk.c
index 68b3892..35b228d 100644
--- a/arch/x86/kernel/early_printk.c
+++ b/arch/x86/kernel/early_printk.c
@@ -290,6 +290,8 @@ static __init void early_pci_serial_init(char *s)
 		/* WARNING! assuming the address is always in the first 4G */
 		early_serial_base =
 			(unsigned long)early_ioremap(bar0 & 0xfffffff0, 0x10);
+		if (!early_serial_base)
+			panic("early_serial: failed to ioremap MMIO BAR\n");
 		write_pci_config(bus, slot, func, PCI_COMMAND,
 						cmdreg|PCI_COMMAND_MEMORY);
 	}
diff --git a/arch/x86/kernel/vsmp_64.c b/arch/x86/kernel/vsmp_64.c
index 796cfaa..39769f4 100644
--- a/arch/x86/kernel/vsmp_64.c
+++ b/arch/x86/kernel/vsmp_64.c
@@ -32,6 +32,9 @@ static void __init set_vsmp_ctl(void)
 	/* set vSMP magic bits to indicate vSMP capable kernel */
 	cfg = read_pci_config(0, 0x1f, 0, PCI_BASE_ADDRESS_0);
 	address = early_ioremap(cfg, 8);
+	if (WARN_ON(!address))
+		return;
+
 	cap = readl(address);
 	ctl = readl(address + 4);
 	printk(KERN_INFO "vSMP CTL: capabilities:0x%08x  control:0x%08x\n",
-- 
1.8.3.1

