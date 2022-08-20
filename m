Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB7859AC56
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 09:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239773AbiHTHoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 03:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243758AbiHTHo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 03:44:27 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B0444578;
        Sat, 20 Aug 2022 00:44:24 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27K74pZl023011;
        Sat, 20 Aug 2022 07:43:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=tin0lQUKUqfs9oonYfKGST3S12W1loLoanQzS9B47Tc=;
 b=g9ZnI3kDW56QX73uhD4O/YTjnc1v+Q8gWY5iusy8kGDQM3gSELSu0NK0QtBNTppGq7n2
 5J1OOq7yZtbcWzRaJWlGB514sqp8f3t9l/ao/431afE0P6w3E7I+2JKOLJHkXh4ECIHn
 pxdLZ8n+SjV0KXt/tsQ3pwXDa+ANW673pDKUVRUjd8/B/DS9MPR4ofJiI0iV1MdUzGiR
 zNm6SFSJHq8aM9Z0udgPJU+IiOCEu8Zr9IRYdLtTodRqnzhMBi+g9R9pF0lYtBp1zKiA
 FACUsVfqcjMp2Mrq0x4bWzKTJZHW35mr2ZfTpS3wlO4ujBwhUTrbUs+dsAyCQes/vJsd 9w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j2tvw0172-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 20 Aug 2022 07:43:03 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27K1X7lK018717;
        Sat, 20 Aug 2022 07:43:02 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j2p20vejv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 20 Aug 2022 07:43:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QClVJNwF5mkvkx/gapXOOcCiA10uZEY5pvolWm1yzA/MahPD2xtGzZq49mpN+wlPuiEvpfgg4lGOiLBaeVwaSM9mpcwAmX26H7demHwExNL9QWOtsJbsbNrkEivbNPLo3QYAt6QkoztbpjEPB6aJALk8SP3dgILso5erx24EjyaghG5kOqvOY8lAkDZxEhDjhXRuF4GBdBns0VONiXh0r4SQ7a5dOkbmA+ZS/emIkv8YptnSv+HbJgJL9FbwHr2+mTaAuC1TnN0ClikAiQ64v2B9azbNHb40Sql/L2gcLru8BYXi2ODV8iglX+4nMKuNNz8tbwI0+ZUYbQw5lhhf3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tin0lQUKUqfs9oonYfKGST3S12W1loLoanQzS9B47Tc=;
 b=ZctvuHsoPaOFYlDWxhQB9re9SG09DMRViI8b16X1D4P4pdNYDXN13HqFRDwTkp1kb8H3s9VtXx5sn5ogDWDrQsm3Z8mChgo4KxDD0acEYkUrn4hTyQLJnn5BBTSuSjAD4RC2B9zNPrenjPOoMnpG41wSJycsqhFfZSNmQldwWcR/wExSYA18ig+KHB7xiCv9+0CKEGLOPTXaH2j2GMDzpvmtAuRuq3UQldVhV1dqpk0sl8fViuU+WgwK9nDDVgKF1i6fQtkf8acRyLxb1NluL90cUc0H2JISq9XD2klhB8/PlHNnnr/GZko8RSCRkcuDPDZOPuUOeh5cyVbx2m/jOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tin0lQUKUqfs9oonYfKGST3S12W1loLoanQzS9B47Tc=;
 b=uUFkiPfn15LaOtEfY5agNGkoQ3MZ6X6NDudxJWWojLJ5wIytQ3I34Hl6LXJKlMuFaTqlI+76duF4KPcvFTa/hI8xX0Dnl7QagPnp0EmpgvSgig374wocLMdht3dJ/Lf2Je+evU8yEFr3BlB+gKHUicK7OlTjP6NWwfwOIo/unVs=
Received: from BYAPR10MB2663.namprd10.prod.outlook.com (2603:10b6:a02:a9::20)
 by DM6PR10MB4187.namprd10.prod.outlook.com (2603:10b6:5:210::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Sat, 20 Aug
 2022 07:42:58 +0000
Received: from BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::95ab:eb8e:a0a7:3f0d]) by BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::95ab:eb8e:a0a7:3f0d%5]) with mapi id 15.20.5546.016; Sat, 20 Aug 2022
 07:42:58 +0000
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     iommu@lists.linux.dev, x86@kernel.org,
        xen-devel@lists.xenproject.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, hch@infradead.org,
        sstabellini@kernel.org, linux@armlinux.org.uk,
        tsbogend@alpha.franken.de, jgross@suse.com,
        boris.ostrovsky@oracle.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com,
        m.szyprowski@samsung.com, konrad.wilk@oracle.com,
        robin.murphy@arm.com, hpa@zytor.com, oleksandr_tyshchenko@epam.com,
        joe.jin@oracle.com
Subject: [PATCH RFC v2 1/1] wiotlb: split buffer into 32-bit default and 64-bit extra zones
Date:   Sat, 20 Aug 2022 00:42:50 -0700
Message-Id: <20220820074250.5460-1-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0143.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::28) To BYAPR10MB2663.namprd10.prod.outlook.com
 (2603:10b6:a02:a9::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f28be58b-555d-4aa0-e319-08da827f9a13
X-MS-TrafficTypeDiagnostic: DM6PR10MB4187:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vbiBYvKZCN7XvX6Co5jks5gr0XIvb9AAn/vnoJXct9SlSVTUZnYLGjmXcTI5SlzdiWv+tIJLmoXbFMEehW6CcAJz7gcaydUXBoNUVNA7J+Biti2GeIvsHVj/uFb8dPnlNTMc8qWdHFJA5E1nH5QOhpfVHl1wTtV2y1pQ7HRy/NPB3jlGO6gECbT/S2qbtyHk+XjwGL1W7lnBxoG3JmafUjtuau3lRT6xrMxx1DHb/i2QNvMCaV+VuMiXTA1XQiC1Www+aBolsVqZz2+9AjRbXB9SwlDUP+cAFg1SxHvHI8XR6vxhk2oXUK8BO4Mn2TuA8zLh1BiZQ7q26nbuyUBQQZLsDepqxUTDsmMYUSTfXGlQx9ySW4L7W59khTNxlGB6Kt9UgdYsNOcH5OFF+QQT3T94WuWdzLlgP3nGL0V4fyELAMpl2h7vz7QsZJynfjYE29+Pcjm2E4oVlpE+rf/aTvfmo9W4lMqWiIO3+6cJF+Dq1wuMwFxmA3FRnHokls57qhXzmqXQY7CpUFTn39nUlRw0eC93UA5LNtel+qCp56JhHb+KC69ppRnt/R1Flevuk0YZGpovYMPagf7uqTmrGP4eFNgWn7gtiGhru8RSv7b5r9/X0BPSZMxUXcoKzoBDi0dbHpVT2f8lnIk6uExxbV74QyfkiklujfZO9DTL3JBiATF+38MvjW73KhIP2r8pbgZqVLadlcw+y0eVInL+AsjR7DDyFBu1wDMMzq4mpzs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2663.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(346002)(396003)(376002)(39860400002)(2616005)(316002)(1076003)(186003)(83380400001)(38100700002)(36756003)(6506007)(66946007)(4326008)(66556008)(966005)(66476007)(8676002)(2906002)(107886003)(6486002)(26005)(86362001)(41300700001)(478600001)(30864003)(6666004)(6512007)(7416002)(44832011)(5660300002)(8936002)(579004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ePGTHTZ2DDb33IkPnayF13/IJQ4N2dyBTSnoOA616APAETlYXGlyVGWUQuEu?=
 =?us-ascii?Q?TmFRSLVMv4g4oeT/ZGMqDayBS7qzFxKRhSVFSZRBaHH/+eb+PqmsPZJwbVqt?=
 =?us-ascii?Q?uS/YsjupLlJeIC7FnafhnJ+xQgr4dTAaHQVg/KxQzpwWqi5raYZX/SN5DYow?=
 =?us-ascii?Q?e4iE3P/dYv4DWOqr04vj2vfcuoXmb1pY7mLlPPpxDzj0S2Ca19oL6NfyQjJD?=
 =?us-ascii?Q?lyGDdx/iHAt+U8VoCx1UKsjqr4I06qAkkSAepXmlLX33JbVK75YrPX3tMXOR?=
 =?us-ascii?Q?Fy6LGqRxanixVRoskkmmCp0sa0sS+wjG8BCjMvW72iDAML8gVBrCj0m11bST?=
 =?us-ascii?Q?mfKF/A7OjH6NbYtfJ9rvIkX1DMeseNAy/Xs1Il8Q2u2GrJXB9KuT4Iic3Jko?=
 =?us-ascii?Q?C+V7YLwd9w/LMCkEbUzVdzBqOcdBWr5ybkloQcN6TvkhU6q2328VG3Bioekq?=
 =?us-ascii?Q?Ca1Yi7tCVcLKE0bsgTMdPaKdzJzJ2y7A2lDjc3g85aUlbpTgcYJdhbBmSKpn?=
 =?us-ascii?Q?M+Pt/Wj5qbR9UsyKfehppXd8L+UT4SZEBNW7gUFZR/GX8A8ZXIJ+SNCb7iiL?=
 =?us-ascii?Q?pP0Tv+OsLMuKjUWi+6NB5BV//U3cb6RcIuFRPuO8sr554rx54mDDb0fE01OO?=
 =?us-ascii?Q?IrUG+2giB5Ldx5Zrssvi1cqEgSjcaWvP3gjglJLECR5Dw0Mj/nenwlEfFg2w?=
 =?us-ascii?Q?PZvP5L2UQpbDH3dvaZu1W8ANlxsizC7pYeQFwp8sVVl23mr/3U3td+Xw2KlD?=
 =?us-ascii?Q?uw2/4ESk4sUA/bRfq+sjlzELYXZRcdX+iZnH3tEzdj6MFTjW8wCqM2lUYVsf?=
 =?us-ascii?Q?IVlCcnt+qo8t6uet1KVKHaWCUTNA59OUNF9swiSIOmWGARWW9zBqfmHdW8Ad?=
 =?us-ascii?Q?/sOiYujWldu59c2Zh8zxDy+63fBbNRoke/wdaL05RFcV/7vSARNsPm/jAFPQ?=
 =?us-ascii?Q?IBB/lIwezb7gyIb0hv5dvcxciIpBhvutOdgT6u3cIJTxvjWeUrkSLQLweyJW?=
 =?us-ascii?Q?B9Hj0dCjm10ZMPCBi0FxkAXwjuDg/QHvZXHAkGcxk2qtqtRdCw3qNTFNeG94?=
 =?us-ascii?Q?1pN2490MzeWfGmuEcdRPQ15xAVX/N/f/R7SDhT36x/DU7YlfQPEBjQecdizr?=
 =?us-ascii?Q?tpqNjyJxijuaZl4/y8bDL9y02lSaLmqygcuJrpbtV9RlAgy9A5+cdaEVZRLG?=
 =?us-ascii?Q?pl5ITDJhFzyAKln/XNoy1+ydYSND/DRopw0DN5vg1XZRgGy/rUC5XjsVE80Y?=
 =?us-ascii?Q?siwXEfR38orpso9uq9rvtySkQyc9uRENqqkKiKkGgAxixZtt/Vpq8VWHALF/?=
 =?us-ascii?Q?IWc2i4q9sAlV6NyCoPrwhhL7msk49tjo1uz87aXoeGqVjVd+mKiv6juHBezD?=
 =?us-ascii?Q?szj0uUzzp+UBZgJqHmtnJl1T2mklor/XGzuACr0+R7WzrNfDdXkosEGogSXD?=
 =?us-ascii?Q?Up2DYOhML/V+HrMdV8BSB6nsH7+hIltlmtWDkdE+8BsqR0C5saj8S7vhK94Y?=
 =?us-ascii?Q?/lvl2STFXYnESnV/EnQdN4nLcUAELHqNOzkd98nmxcO9iwJtqeoH5lqZOW+2?=
 =?us-ascii?Q?aanlC670+bBlvIoM9cPP+M5py1nlqXJ3AG0sTbjz?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f28be58b-555d-4aa0-e319-08da827f9a13
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2663.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2022 07:42:58.5517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WhuEpZ6DhyKSzsC/b3r6yjSlWM1wECtNLzyvup0VBn+frM9eCKFrVLm8skzwTKjzVifq3O3jboDvpobr8t8Pyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4187
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-20_04,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208200029
X-Proofpoint-ORIG-GUID: TBxk3MEueK5WB_bV19JdXaHvLVrBIkBO
X-Proofpoint-GUID: TBxk3MEueK5WB_bV19JdXaHvLVrBIkBO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I used to send out RFC v1 to introduce an extra io_tlb_mem (created with
SWIOTLB_ANY) in addition to the default io_tlb_mem (32-bit).  The
dev->dma_io_tlb_mem is set to either default or the extra io_tlb_mem,
depending on dma mask. However, that is not good for setting
dev->dma_io_tlb_mem at swiotlb layer transparently as suggested by
Christoph Hellwig.

https://lore.kernel.org/all/20220609005553.30954-1-dongli.zhang@oracle.com/

Therefore, this is another RFC v2 implementation following a different
direction. The core ideas are:

1. The swiotlb is splited into two zones, io_tlb_mem->zone[0] (32-bit) and
io_tlb_mem->zone[1] (64-bit).

struct io_tlb_mem {
	struct io_tlb_zone zone[SWIOTLB_NR];
	struct dentry *debugfs;
	bool late_alloc;
	bool force_bounce;
	bool for_alloc;
	bool has_extra;
};

struct io_tlb_zone {
	phys_addr_t start;
	phys_addr_t end;
	void *vaddr;
	unsigned long nslabs;
	unsigned long used;
	unsigned int nareas;
	unsigned int area_nslabs;
	struct io_tlb_area *areas;
	struct io_tlb_slot *slots;
};

2. By default, only io_tlb_mem->zone[0] is available. The
io_tlb_mem->zone[1] is allocated conditionally if:

- the "swiotlb=" is configured to allocate extra buffer, and
- the SWIOTLB_EXTRA is set in the flag (this is to make sure arch(s) other
  than x86/sev/xen will not enable it until it is fully tested by each
  arch, e.g., mips/powerpc). Currently it is enabled for x86 and xen.

3. During swiotlb map, whether zone[0] (32-bit) or zone[1] (64-bit
SWIOTLB_ANY)
is used depends on min_not_zero(*dev->dma_mask, dev->bus_dma_limit).

To test the RFC v2, here is the QEMU command line.

qemu-system-x86_64 -smp 8 -m 32G -enable-kvm -vnc :5 -hda disk.img \
-kernel path-to-linux/arch/x86_64/boot/bzImage \
-append "root=/dev/sda1 init=/sbin/init text console=ttyS0 loglevel=7 swiotlb=32768,4194304,force" \
-net nic -net user,hostfwd=tcp::5025-:22 \
-device nvme,drive=nvme01,serial=helloworld -drive file=test.qcow2,if=none,id=nvme01 \
-serial stdio

There is below in syslog. The extra 8GB buffer is allocated.

[    0.152251] software IO TLB: area num 8.
... ...
[    3.706088] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    3.707334] software IO TLB: mapped default [mem 0x00000000bbfd7000-0x00000000bffd7000] (64MB)
[    3.708585] software IO TLB: mapped extra [mem 0x000000061cc00000-0x000000081cc00000] (8192MB)

After the FIO is triggered over NVMe, the 64-bit buffer is used.

$ cat /sys/kernel/debug/swiotlb/io_tlb_nslabs_extra
4194304
$ cat /sys/kernel/debug/swiotlb/io_tlb_used_extra
327552

Would you mind helping if this is the right direction to go?

Thank you very much!

Cc: Konrad Wilk <konrad.wilk@oracle.com>
Cc: Joe Jin <joe.jin@oracle.com>
Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 arch/arm/xen/mm.c                      |   2 +-
 arch/mips/pci/pci-octeon.c             |   5 +-
 arch/x86/include/asm/xen/swiotlb-xen.h |   2 +-
 arch/x86/kernel/pci-dma.c              |   6 +-
 drivers/xen/swiotlb-xen.c              |  18 +-
 include/linux/swiotlb.h                |  73 +++--
 kernel/dma/swiotlb.c                   | 499 +++++++++++++++++++++------------
 7 files changed, 388 insertions(+), 217 deletions(-)

diff --git a/arch/arm/xen/mm.c b/arch/arm/xen/mm.c
index 3d826c0..4edfa42 100644
--- a/arch/arm/xen/mm.c
+++ b/arch/arm/xen/mm.c
@@ -125,7 +125,7 @@ static int __init xen_mm_init(void)
 		return 0;
 
 	/* we can work with the default swiotlb */
-	if (!io_tlb_default_mem.nslabs) {
+	if (!io_tlb_default_mem.zone[SWIOTLB_DF].nslabs) {
 		rc = swiotlb_init_late(swiotlb_size_or_default(),
 				       xen_swiotlb_gfp(), NULL);
 		if (rc < 0)
diff --git a/arch/mips/pci/pci-octeon.c b/arch/mips/pci/pci-octeon.c
index e457a18..0bf0859 100644
--- a/arch/mips/pci/pci-octeon.c
+++ b/arch/mips/pci/pci-octeon.c
@@ -654,6 +654,9 @@ static int __init octeon_pci_setup(void)
 		octeon_pci_mem_resource.end =
 			octeon_pci_mem_resource.start + (1ul << 30);
 	} else {
+		struct io_tlb_mem *mem = &io_tlb_default_mem;
+		struct io_tlb_zone *zone = &mem->zone[SWIOTLB_DF];
+
 		/* Remap the Octeon BAR 0 to map 128MB-(128MB+4KB) */
 		octeon_npi_write32(CVMX_NPI_PCI_CFG04, 128ul << 20);
 		octeon_npi_write32(CVMX_NPI_PCI_CFG05, 0);
@@ -664,7 +667,7 @@ static int __init octeon_pci_setup(void)
 
 		/* BAR1 movable regions contiguous to cover the swiotlb */
 		octeon_bar1_pci_phys =
-			io_tlb_default_mem.start & ~((1ull << 22) - 1);
+			zone->start & ~((1ull << 22) - 1);
 
 		for (index = 0; index < 32; index++) {
 			union cvmx_pci_bar1_indexx bar1_index;
diff --git a/arch/x86/include/asm/xen/swiotlb-xen.h b/arch/x86/include/asm/xen/swiotlb-xen.h
index 77a2d19..9476a9f 100644
--- a/arch/x86/include/asm/xen/swiotlb-xen.h
+++ b/arch/x86/include/asm/xen/swiotlb-xen.h
@@ -8,7 +8,7 @@
 static inline int pci_xen_swiotlb_init_late(void) { return -ENXIO; }
 #endif
 
-int xen_swiotlb_fixup(void *buf, unsigned long nslabs);
+int xen_swiotlb_fixup(void *buf, unsigned long nslabs, unsigned int flags);
 int xen_create_contiguous_region(phys_addr_t pstart, unsigned int order,
 				unsigned int address_bits,
 				dma_addr_t *dma_handle);
diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
index 30bbe4a..a8736e7 100644
--- a/arch/x86/kernel/pci-dma.c
+++ b/arch/x86/kernel/pci-dma.c
@@ -77,7 +77,7 @@ static void __init pci_xen_swiotlb_init(void)
 	if (!xen_initial_domain() && !x86_swiotlb_enable)
 		return;
 	x86_swiotlb_enable = true;
-	x86_swiotlb_flags |= SWIOTLB_ANY;
+	x86_swiotlb_flags |= SWIOTLB_ANY | SWIOTLB_EXTRA;
 	swiotlb_init_remap(true, x86_swiotlb_flags, xen_swiotlb_fixup);
 	dma_ops = &xen_swiotlb_dma_ops;
 	if (IS_ENABLED(CONFIG_PCI))
@@ -90,7 +90,7 @@ int pci_xen_swiotlb_init_late(void)
 		return 0;
 
 	/* we can work with the default swiotlb */
-	if (!io_tlb_default_mem.nslabs) {
+	if (!io_tlb_default_mem.zone[SWIOTLB_DF].nslabs) {
 		int rc = swiotlb_init_late(swiotlb_size_or_default(),
 					   GFP_KERNEL, xen_swiotlb_fixup);
 		if (rc < 0)
@@ -120,6 +120,8 @@ void __init pci_iommu_alloc(void)
 	gart_iommu_hole_init();
 	amd_iommu_detect();
 	detect_intel_iommu();
+
+	x86_swiotlb_flags |= SWIOTLB_EXTRA;
 	swiotlb_init(x86_swiotlb_enable, x86_swiotlb_flags);
 }
 
diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 67aa74d..3ff082b 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -38,7 +38,6 @@
 #include <asm/dma-mapping.h>
 
 #include <trace/events/swiotlb.h>
-#define MAX_DMA_BITS 32
 
 /*
  * Quick lookup value of the bus address of the IOTLB.
@@ -104,24 +103,32 @@ static int is_xen_swiotlb_buffer(struct device *dev, dma_addr_t dma_addr)
 }
 
 #ifdef CONFIG_X86
-int xen_swiotlb_fixup(void *buf, unsigned long nslabs)
+int xen_swiotlb_fixup(void *buf, unsigned long nslabs, unsigned int flags)
 {
 	int rc;
 	unsigned int order = get_order(IO_TLB_SEGSIZE << IO_TLB_SHIFT);
 	unsigned int i, dma_bits = order + PAGE_SHIFT;
 	dma_addr_t dma_handle;
 	phys_addr_t p = virt_to_phys(buf);
+	unsigned int max_dma_bits = 32;
 
 	BUILD_BUG_ON(IO_TLB_SEGSIZE & (IO_TLB_SEGSIZE - 1));
 	BUG_ON(nslabs % IO_TLB_SEGSIZE);
 
+#ifdef CONFIG_X86_64
+	if (flags & SWIOTLB_EXTRA) {
+		max_dma_bits = 64;
+		dma_bits = 64;
+	}
+#endif
+
 	i = 0;
 	do {
 		do {
 			rc = xen_create_contiguous_region(
 				p + (i << IO_TLB_SHIFT), order,
 				dma_bits, &dma_handle);
-		} while (rc && dma_bits++ < MAX_DMA_BITS);
+		} while (rc && dma_bits++ < max_dma_bits);
 		if (rc)
 			return rc;
 
@@ -381,7 +388,10 @@ static void xen_swiotlb_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
 static int
 xen_swiotlb_dma_supported(struct device *hwdev, u64 mask)
 {
-	return xen_phys_to_dma(hwdev, io_tlb_default_mem.end - 1) <= mask;
+	struct io_tlb_mem *mem = &io_tlb_default_mem;
+	struct io_tlb_zone *zone = &mem->zone[SWIOTLB_DF];
+
+	return xen_phys_to_dma(hwdev, zone->end - 1) <= mask;
 }
 
 const struct dma_map_ops xen_swiotlb_dma_ops = {
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 35bc4e2..365e5d7 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -16,6 +16,11 @@
 #define SWIOTLB_VERBOSE	(1 << 0) /* verbose initialization */
 #define SWIOTLB_FORCE	(1 << 1) /* force bounce buffering */
 #define SWIOTLB_ANY	(1 << 2) /* allow any memory for the buffer */
+#define SWIOTLB_EXTRA	(1 << 3) /* allow extra buffer if supported */
+
+#define SWIOTLB_DF	0
+#define SWIOTLB_EX	1
+#define SWIOTLB_NR	2
 
 /*
  * Maximum allowable number of contiguous slabs to map,
@@ -36,9 +41,9 @@
 
 unsigned long swiotlb_size_or_default(void);
 void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
-	int (*remap)(void *tlb, unsigned long nslabs));
+	int (*remap)(void *tlb, unsigned long nslabs, unsigned int flags));
 int swiotlb_init_late(size_t size, gfp_t gfp_mask,
-	int (*remap)(void *tlb, unsigned long nslabs));
+	int (*remap)(void *tlb, unsigned long nslabs, unsigned int flags));
 extern void __init swiotlb_update_mem_attributes(void);
 
 phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t phys,
@@ -62,54 +67,78 @@ dma_addr_t swiotlb_map(struct device *dev, phys_addr_t phys,
 #ifdef CONFIG_SWIOTLB
 
 /**
- * struct io_tlb_mem - IO TLB Memory Pool Descriptor
+ * struct io_tlb_zone - IO TLB Memory Zone Descriptor
  *
- * @start:	The start address of the swiotlb memory pool. Used to do a quick
+ * @start:	The start address of the swiotlb memory zone. Used to do a quick
  *		range check to see if the memory was in fact allocated by this
  *		API.
- * @end:	The end address of the swiotlb memory pool. Used to do a quick
+ * @end:	The end address of the swiotlb memory zone. Used to do a quick
  *		range check to see if the memory was in fact allocated by this
  *		API.
- * @vaddr:	The vaddr of the swiotlb memory pool. The swiotlb memory pool
+ * @vaddr:	The vaddr of the swiotlb memory zone. The swiotlb memory zone
  *		may be remapped in the memory encrypted case and store virtual
  *		address for bounce buffer operation.
  * @nslabs:	The number of IO TLB blocks (in groups of 64) between @start and
  *		@end. For default swiotlb, this is command line adjustable via
  *		setup_io_tlb_npages.
  * @used:	The number of used IO TLB block.
- * @list:	The free list describing the number of free entries available
- *		from each index.
- * @orig_addr:	The original address corresponding to a mapped entry.
- * @alloc_size:	Size of the allocated buffer.
- * @debugfs:	The dentry to debugfs.
- * @late_alloc:	%true if allocated using the page allocator
- * @force_bounce: %true if swiotlb bouncing is forced
- * @for_alloc:  %true if the pool is used for memory allocation
- * @nareas:  The area number in the pool.
- * @area_nslabs: The slot number in the area.
+ * @nareas:	The area number in the zone.
+ * @area_nslabs:The slot number in the area.
+ * @area:	The IO TLB memory area descriptor.
+ * @slots:	The data to track memory allocation.
  */
-struct io_tlb_mem {
+struct io_tlb_zone {
 	phys_addr_t start;
 	phys_addr_t end;
 	void *vaddr;
 	unsigned long nslabs;
 	unsigned long used;
-	struct dentry *debugfs;
-	bool late_alloc;
-	bool force_bounce;
-	bool for_alloc;
 	unsigned int nareas;
 	unsigned int area_nslabs;
 	struct io_tlb_area *areas;
 	struct io_tlb_slot *slots;
 };
+
+/**
+ * struct io_tlb_mem - IO TLB Memory Pool Descriptor
+ *
+ * @zone:	IO TLB memory zone descriptor.
+ * @debugfs:	The dentry to debugfs.
+ * @late_alloc:	%true if allocated using the page allocator.
+ * @force_bounce: %true if swiotlb bouncing is forced.
+ * @for_alloc:	%true if the pool is used for memory allocation.
+ * @has_extra:	%true if the extra zone (e.g., 64-bit) is available.
+ */
+struct io_tlb_mem {
+	struct io_tlb_zone zone[SWIOTLB_NR];
+	struct dentry *debugfs;
+	bool late_alloc;
+	bool force_bounce;
+	bool for_alloc;
+	bool has_extra;
+};
 extern struct io_tlb_mem io_tlb_default_mem;
 
 static inline bool is_swiotlb_buffer(struct device *dev, phys_addr_t paddr)
 {
 	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
+	struct io_tlb_zone *zone;
+	int end_zone;
+	int i;
+
+	if (!mem)
+		return false;
+
+	end_zone = mem->has_extra ? SWIOTLB_EX : SWIOTLB_DF;
 
-	return mem && paddr >= mem->start && paddr < mem->end;
+	for (i = end_zone ; i >= 0 ; i--) {
+		zone = &mem->zone[i];
+
+		if (paddr >= zone->start && paddr < zone->end)
+			return true;
+	}
+
+	return false;
 }
 
 static inline bool is_swiotlb_force_bounce(struct device *dev)
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index c5a9190..392f21b 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -76,6 +76,7 @@ struct io_tlb_slot {
 phys_addr_t swiotlb_unencrypted_base;
 
 static unsigned long default_nslabs = IO_TLB_DEFAULT_SIZE >> IO_TLB_SHIFT;
+static unsigned long extra_nslabs;
 static unsigned long default_nareas;
 
 /**
@@ -96,24 +97,24 @@ struct io_tlb_area {
 
 /*
  * Round up number of slabs to the next power of 2. The last area is going
- * be smaller than the rest if default_nslabs is not power of two.
+ * be smaller than the rest if *nslabs_ptr is not power of two.
  * The number of slot in an area should be a multiple of IO_TLB_SEGSIZE,
  * otherwise a segment may span two or more areas. It conflicts with free
  * contiguous slots tracking: free slots are treated contiguous no matter
  * whether they cross an area boundary.
  *
- * Return true if default_nslabs is rounded up.
+ * Return true if *nslabs_ptr is rounded up.
  */
-static bool round_up_default_nslabs(void)
+static bool round_up_nslabs_config(unsigned long *nslabs_ptr)
 {
 	if (!default_nareas)
 		return false;
 
-	if (default_nslabs < IO_TLB_SEGSIZE * default_nareas)
-		default_nslabs = IO_TLB_SEGSIZE * default_nareas;
-	else if (is_power_of_2(default_nslabs))
+	if (*nslabs_ptr < IO_TLB_SEGSIZE * default_nareas)
+		*nslabs_ptr = IO_TLB_SEGSIZE * default_nareas;
+	else if (is_power_of_2(*nslabs_ptr))
 		return false;
-	default_nslabs = roundup_pow_of_two(default_nslabs);
+	*nslabs_ptr = roundup_pow_of_two(*nslabs_ptr);
 	return true;
 }
 
@@ -128,9 +129,14 @@ static void swiotlb_adjust_nareas(unsigned int nareas)
 	default_nareas = nareas;
 
 	pr_info("area num %d.\n", nareas);
-	if (round_up_default_nslabs())
+
+	if (round_up_nslabs_config(&default_nslabs))
 		pr_info("SWIOTLB bounce buffer size roundup to %luMB",
 			(default_nslabs << IO_TLB_SHIFT) >> 20);
+
+	if (extra_nslabs && round_up_nslabs_config(&extra_nslabs))
+		pr_info("SWIOTLB extra bounce buffer size roundup to %luMB",
+			(extra_nslabs << IO_TLB_SHIFT) >> 20);
 }
 
 static int __init
@@ -144,6 +150,11 @@ static void swiotlb_adjust_nareas(unsigned int nareas)
 	if (*str == ',')
 		++str;
 	if (isdigit(*str))
+		extra_nslabs =
+			ALIGN(simple_strtoul(str, &str, 0), IO_TLB_SEGSIZE);
+	if (*str == ',')
+		++str;
+	if (isdigit(*str))
 		swiotlb_adjust_nareas(simple_strtoul(str, &str, 0));
 	if (*str == ',')
 		++str;
@@ -158,9 +169,11 @@ static void swiotlb_adjust_nareas(unsigned int nareas)
 
 unsigned int swiotlb_max_segment(void)
 {
-	if (!io_tlb_default_mem.nslabs)
+	struct io_tlb_zone *zone = &io_tlb_default_mem.zone[SWIOTLB_DF];
+
+	if (!zone->nslabs)
 		return 0;
-	return rounddown(io_tlb_default_mem.nslabs << IO_TLB_SHIFT, PAGE_SIZE);
+	return rounddown(zone->nslabs << IO_TLB_SHIFT, PAGE_SIZE);
 }
 EXPORT_SYMBOL_GPL(swiotlb_max_segment);
 
@@ -181,22 +194,49 @@ void __init swiotlb_adjust_size(unsigned long size)
 
 	size = ALIGN(size, IO_TLB_SIZE);
 	default_nslabs = ALIGN(size >> IO_TLB_SHIFT, IO_TLB_SEGSIZE);
-	if (round_up_default_nslabs())
+	if (round_up_nslabs_config(&default_nslabs))
 		size = default_nslabs << IO_TLB_SHIFT;
-	pr_info("SWIOTLB bounce buffer size adjusted to %luMB", size >> 20);
+	pr_info("SWIOTLB default bounce buffer size adjusted to %luMB",
+		size >> 20);
 }
 
 void swiotlb_print_info(void)
 {
 	struct io_tlb_mem *mem = &io_tlb_default_mem;
+	int nr_zone = mem->has_extra ? SWIOTLB_NR : SWIOTLB_NR - 1;
+	struct io_tlb_zone *zone;
+	int i;
 
-	if (!mem->nslabs) {
+	if (!mem->zone[SWIOTLB_DF].nslabs) {
 		pr_warn("No low mem\n");
 		return;
 	}
 
-	pr_info("mapped [mem %pa-%pa] (%luMB)\n", &mem->start, &mem->end,
-	       (mem->nslabs << IO_TLB_SHIFT) >> 20);
+	for (i = 0; i < nr_zone; i++) {
+		zone = &mem->zone[i];
+		pr_info("mapped %s [mem %pa-%pa] (%luMB)\n",
+			i == 0 ? "default" : "extra",
+			&zone->start, &zone->end,
+			(zone->nslabs << IO_TLB_SHIFT) >> 20);
+	}
+}
+
+static int swiotlb_zone_index(struct io_tlb_mem *mem, phys_addr_t paddr)
+{
+	struct io_tlb_zone *zone;
+	int end_zone;
+	int i;
+
+	end_zone = mem->has_extra ? SWIOTLB_EX : SWIOTLB_DF;
+
+	for (i = end_zone ; i >= 0 ; i--) {
+		zone = &mem->zone[i];
+
+		if (paddr >= zone->start && paddr < zone->end)
+			return i;
+	}
+
+	return -EINVAL;
 }
 
 static inline unsigned long io_tlb_offset(unsigned long val)
@@ -215,12 +255,13 @@ static inline unsigned long nr_slots(u64 val)
  * Isolation VMs).
  */
 #ifdef CONFIG_HAS_IOMEM
-static void *swiotlb_mem_remap(struct io_tlb_mem *mem, unsigned long bytes)
+static void *swiotlb_mem_remap(struct io_tlb_zone *zone,
+			       unsigned long bytes)
 {
 	void *vaddr = NULL;
 
 	if (swiotlb_unencrypted_base) {
-		phys_addr_t paddr = mem->start + swiotlb_unencrypted_base;
+		phys_addr_t paddr = zone->start + swiotlb_unencrypted_base;
 
 		vaddr = memremap(paddr, bytes, MEMREMAP_WB);
 		if (!vaddr)
@@ -231,7 +272,8 @@ static void *swiotlb_mem_remap(struct io_tlb_mem *mem, unsigned long bytes)
 	return vaddr;
 }
 #else
-static void *swiotlb_mem_remap(struct io_tlb_mem *mem, unsigned long bytes)
+static void *swiotlb_mem_remap(struct io_tlb_zone *zone,
+			       unsigned long bytes)
 {
 	return NULL;
 }
@@ -246,46 +288,53 @@ static void *swiotlb_mem_remap(struct io_tlb_mem *mem, unsigned long bytes)
 void __init swiotlb_update_mem_attributes(void)
 {
 	struct io_tlb_mem *mem = &io_tlb_default_mem;
+	int nr_zone = mem->has_extra ? SWIOTLB_NR : SWIOTLB_NR - 1;
 	void *vaddr;
 	unsigned long bytes;
+	int i;
 
-	if (!mem->nslabs || mem->late_alloc)
+	if (mem->late_alloc)
 		return;
-	vaddr = phys_to_virt(mem->start);
-	bytes = PAGE_ALIGN(mem->nslabs << IO_TLB_SHIFT);
-	set_memory_decrypted((unsigned long)vaddr, bytes >> PAGE_SHIFT);
 
-	mem->vaddr = swiotlb_mem_remap(mem, bytes);
-	if (!mem->vaddr)
-		mem->vaddr = vaddr;
+	for (i = 0; i < nr_zone; i++) {
+		struct io_tlb_zone *zone = &mem->zone[i];
+
+		if (!zone->nslabs)
+			continue;
+		vaddr = phys_to_virt(zone->start);
+		bytes = PAGE_ALIGN(zone->nslabs << IO_TLB_SHIFT);
+		set_memory_decrypted((unsigned long)vaddr, bytes >> PAGE_SHIFT);
+
+		zone->vaddr = swiotlb_mem_remap(zone, bytes);
+		if (!zone->vaddr)
+			zone->vaddr = vaddr;
+	}
 }
 
-static void swiotlb_init_io_tlb_mem(struct io_tlb_mem *mem, phys_addr_t start,
-		unsigned long nslabs, unsigned int flags,
-		bool late_alloc, unsigned int nareas)
+static void swiotlb_init_io_tlb_zone(struct io_tlb_zone *zone,
+				     phys_addr_t start,
+				     unsigned long nslabs,
+				     unsigned int nareas)
 {
 	void *vaddr = phys_to_virt(start);
 	unsigned long bytes = nslabs << IO_TLB_SHIFT, i;
 
-	mem->nslabs = nslabs;
-	mem->start = start;
-	mem->end = mem->start + bytes;
-	mem->late_alloc = late_alloc;
-	mem->nareas = nareas;
-	mem->area_nslabs = nslabs / mem->nareas;
-
-	mem->force_bounce = swiotlb_force_bounce || (flags & SWIOTLB_FORCE);
+	zone->nslabs = nslabs;
+	zone->start = start;
+	zone->end = zone->start + bytes;
+	zone->nareas = nareas;
+	zone->area_nslabs = nslabs / zone->nareas;
 
-	for (i = 0; i < mem->nareas; i++) {
-		spin_lock_init(&mem->areas[i].lock);
-		mem->areas[i].index = 0;
-		mem->areas[i].used = 0;
+	for (i = 0; i < zone->nareas; i++) {
+		spin_lock_init(&zone->areas[i].lock);
+		zone->areas[i].index = 0;
+		zone->areas[i].used = 0;
 	}
 
-	for (i = 0; i < mem->nslabs; i++) {
-		mem->slots[i].list = IO_TLB_SEGSIZE - io_tlb_offset(i);
-		mem->slots[i].orig_addr = INVALID_PHYS_ADDR;
-		mem->slots[i].alloc_size = 0;
+	for (i = 0; i < zone->nslabs; i++) {
+		zone->slots[i].list = IO_TLB_SEGSIZE - io_tlb_offset(i);
+		zone->slots[i].orig_addr = INVALID_PHYS_ADDR;
+		zone->slots[i].alloc_size = 0;
 	}
 
 	/*
@@ -296,44 +345,19 @@ static void swiotlb_init_io_tlb_mem(struct io_tlb_mem *mem, phys_addr_t start,
 		return;
 
 	memset(vaddr, 0, bytes);
-	mem->vaddr = vaddr;
+	zone->vaddr = vaddr;
 	return;
 }
 
-/*
- * Statically reserve bounce buffer space and initialize bounce buffer data
- * structures for the software IO TLB used to implement the DMA API.
- */
-void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
-		int (*remap)(void *tlb, unsigned long nslabs))
+void __init swiotlb_init_remap_zone(struct io_tlb_zone *zone,
+		unsigned long nslabs, unsigned int flags,
+		int (*remap)(void *tlb, unsigned long nslabs,
+			     unsigned int flags))
 {
-	struct io_tlb_mem *mem = &io_tlb_default_mem;
-	unsigned long nslabs;
 	size_t alloc_size;
 	size_t bytes;
 	void *tlb;
 
-	if (!addressing_limit && !swiotlb_force_bounce)
-		return;
-	if (swiotlb_force_disable)
-		return;
-
-	/*
-	 * default_nslabs maybe changed when adjust area number.
-	 * So allocate bounce buffer after adjusting area number.
-	 */
-	if (!default_nareas)
-		swiotlb_adjust_nareas(num_possible_cpus());
-
-	nslabs = default_nslabs;
-	if (nslabs < IO_TLB_MIN_SLABS)
-		panic("%s: nslabs = %lu too small\n", __func__, nslabs);
-
-	/*
-	 * By default allocate the bounce buffer memory from low memory, but
-	 * allow to pick a location everywhere for hypervisors with guest
-	 * memory encryption.
-	 */
 retry:
 	bytes = PAGE_ALIGN(nslabs << IO_TLB_SHIFT);
 	if (flags & SWIOTLB_ANY)
@@ -346,7 +370,7 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
 		return;
 	}
 
-	if (remap && remap(tlb, nslabs) < 0) {
+	if (remap && remap(tlb, nslabs, flags) < 0) {
 		memblock_free(tlb, PAGE_ALIGN(bytes));
 
 		nslabs = ALIGN(nslabs >> 1, IO_TLB_SEGSIZE);
@@ -356,19 +380,58 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
 		goto retry;
 	}
 
-	alloc_size = PAGE_ALIGN(array_size(sizeof(*mem->slots), nslabs));
-	mem->slots = memblock_alloc(alloc_size, PAGE_SIZE);
-	if (!mem->slots)
+	alloc_size = PAGE_ALIGN(array_size(sizeof(*zone->slots), nslabs));
+	zone->slots = memblock_alloc(alloc_size, PAGE_SIZE);
+	if (!zone->slots)
 		panic("%s: Failed to allocate %zu bytes align=0x%lx\n",
 		      __func__, alloc_size, PAGE_SIZE);
 
-	mem->areas = memblock_alloc(array_size(sizeof(struct io_tlb_area),
+	zone->areas = memblock_alloc(array_size(sizeof(struct io_tlb_area),
 		default_nareas), SMP_CACHE_BYTES);
-	if (!mem->areas)
-		panic("%s: Failed to allocate mem->areas.\n", __func__);
+	if (!zone->areas)
+		panic("%s: Failed to allocate zone->areas.\n", __func__);
+
+	swiotlb_init_io_tlb_zone(zone, __pa(tlb), nslabs, default_nareas);
+}
+
+/*
+ * Statically reserve bounce buffer space and initialize bounce buffer data
+ * structures for the software IO TLB used to implement the DMA API.
+ */
+void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
+		int (*remap)(void *tlb, unsigned long nslabs,
+			     unsigned int flags))
+{
+	struct io_tlb_mem *mem = &io_tlb_default_mem;
 
-	swiotlb_init_io_tlb_mem(mem, __pa(tlb), nslabs, flags, false,
-				default_nareas);
+	if (!addressing_limit && !swiotlb_force_bounce)
+		return;
+	if (swiotlb_force_disable)
+		return;
+
+	/*
+	 * Both default_nslabs and extra_nslabs maybe changed when adjust
+	 * area number.
+	 * So allocate bounce buffer after adjusting area number.
+	 */
+	if (!default_nareas)
+		swiotlb_adjust_nareas(num_possible_cpus());
+
+	if (default_nslabs < IO_TLB_MIN_SLABS)
+		panic("%s: default_nslabs = %lu too small\n", __func__,
+		      default_nslabs);
+
+	swiotlb_init_remap_zone(&mem->zone[SWIOTLB_DF], default_nslabs,
+				flags & ~SWIOTLB_EXTRA, remap);
+	if (extra_nslabs && (flags & SWIOTLB_EXTRA)) {
+		swiotlb_init_remap_zone(&mem->zone[SWIOTLB_EX],
+					extra_nslabs,
+					flags | SWIOTLB_ANY, remap);
+		mem->has_extra = true;
+	}
+
+	mem->late_alloc = false;
+	mem->force_bounce = swiotlb_force_bounce || (flags & SWIOTLB_FORCE);
 
 	if (flags & SWIOTLB_VERBOSE)
 		swiotlb_print_info();
@@ -385,9 +448,11 @@ void __init swiotlb_init(bool addressing_limit, unsigned int flags)
  * This should be just like above, but with some error catching.
  */
 int swiotlb_init_late(size_t size, gfp_t gfp_mask,
-		int (*remap)(void *tlb, unsigned long nslabs))
+		int (*remap)(void *tlb, unsigned long nslabs,
+			     unsigned int flags))
 {
 	struct io_tlb_mem *mem = &io_tlb_default_mem;
+	struct io_tlb_zone *zone = &mem->zone[SWIOTLB_DF];
 	unsigned long nslabs = ALIGN(size >> IO_TLB_SHIFT, IO_TLB_SEGSIZE);
 	unsigned char *vstart = NULL;
 	unsigned int order, area_order;
@@ -415,7 +480,7 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
 		return -ENOMEM;
 
 	if (remap)
-		rc = remap(vstart, nslabs);
+		rc = remap(vstart, nslabs, 0);
 	if (rc) {
 		free_pages((unsigned long)vstart, order);
 
@@ -434,28 +499,31 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
 	if (!default_nareas)
 		swiotlb_adjust_nareas(num_possible_cpus());
 
-	area_order = get_order(array_size(sizeof(*mem->areas),
+	area_order = get_order(array_size(sizeof(*zone->areas),
 		default_nareas));
-	mem->areas = (struct io_tlb_area *)
+	zone->areas = (struct io_tlb_area *)
 		__get_free_pages(GFP_KERNEL | __GFP_ZERO, area_order);
-	if (!mem->areas)
+	if (!zone->areas)
 		goto error_area;
 
-	mem->slots = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
-		get_order(array_size(sizeof(*mem->slots), nslabs)));
-	if (!mem->slots)
+	zone->slots = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
+		get_order(array_size(sizeof(*zone->slots), nslabs)));
+	if (!zone->slots)
 		goto error_slots;
 
 	set_memory_decrypted((unsigned long)vstart,
 			     (nslabs << IO_TLB_SHIFT) >> PAGE_SHIFT);
-	swiotlb_init_io_tlb_mem(mem, virt_to_phys(vstart), nslabs, 0, true,
-				default_nareas);
+	swiotlb_init_io_tlb_zone(zone, virt_to_phys(vstart), nslabs,
+				 default_nareas);
+
+	mem->late_alloc = true;
+	mem->force_bounce = swiotlb_force_bounce;
 
 	swiotlb_print_info();
 	return 0;
 
 error_slots:
-	free_pages((unsigned long)mem->areas, area_order);
+	free_pages((unsigned long)zone->areas, area_order);
 error_area:
 	free_pages((unsigned long)vstart, order);
 	return -ENOMEM;
@@ -464,33 +532,40 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
 void __init swiotlb_exit(void)
 {
 	struct io_tlb_mem *mem = &io_tlb_default_mem;
+	int nr_zone = mem->has_extra ? SWIOTLB_NR : SWIOTLB_NR - 1;
 	unsigned long tbl_vaddr;
 	size_t tbl_size, slots_size;
 	unsigned int area_order;
+	int i;
 
 	if (swiotlb_force_bounce)
 		return;
 
-	if (!mem->nslabs)
-		return;
+	for (i = 0 ; i < nr_zone ; i++) {
+		struct io_tlb_zone *zone = &mem->zone[i];
 
-	pr_info("tearing down default memory pool\n");
-	tbl_vaddr = (unsigned long)phys_to_virt(mem->start);
-	tbl_size = PAGE_ALIGN(mem->end - mem->start);
-	slots_size = PAGE_ALIGN(array_size(sizeof(*mem->slots), mem->nslabs));
-
-	set_memory_encrypted(tbl_vaddr, tbl_size >> PAGE_SHIFT);
-	if (mem->late_alloc) {
-		area_order = get_order(array_size(sizeof(*mem->areas),
-			mem->nareas));
-		free_pages((unsigned long)mem->areas, area_order);
-		free_pages(tbl_vaddr, get_order(tbl_size));
-		free_pages((unsigned long)mem->slots, get_order(slots_size));
-	} else {
-		memblock_free_late(__pa(mem->areas),
-			array_size(sizeof(*mem->areas), mem->nareas));
-		memblock_free_late(mem->start, tbl_size);
-		memblock_free_late(__pa(mem->slots), slots_size);
+		if (!zone->nslabs)
+			continue;
+
+		pr_info("tearing down %s memory pool\n",
+			i == 0 ? "default" : "extra");
+		tbl_vaddr = (unsigned long)phys_to_virt(zone->start);
+		tbl_size = PAGE_ALIGN(zone->end - zone->start);
+		slots_size = PAGE_ALIGN(array_size(sizeof(*zone->slots), zone->nslabs));
+
+		set_memory_encrypted(tbl_vaddr, tbl_size >> PAGE_SHIFT);
+		if (mem->late_alloc) {
+			area_order = get_order(array_size(sizeof(*zone->areas),
+					       zone->nareas));
+			free_pages((unsigned long)zone->areas, area_order);
+			free_pages(tbl_vaddr, get_order(tbl_size));
+			free_pages((unsigned long)zone->slots, get_order(slots_size));
+		} else {
+			memblock_free_late(__pa(zone->areas),
+				array_size(sizeof(*zone->areas), zone->nareas));
+			memblock_free_late(zone->start, tbl_size);
+			memblock_free_late(__pa(zone->slots), slots_size);
+		}
 	}
 
 	memset(mem, 0, sizeof(*mem));
@@ -507,15 +582,15 @@ static unsigned int swiotlb_align_offset(struct device *dev, u64 addr)
 /*
  * Bounce: copy the swiotlb buffer from or back to the original dma location
  */
-static void swiotlb_bounce(struct device *dev, phys_addr_t tlb_addr, size_t size,
+static void swiotlb_bounce(struct device *dev, struct io_tlb_zone *zone,
+			   phys_addr_t tlb_addr, size_t size,
 			   enum dma_data_direction dir)
 {
-	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
-	int index = (tlb_addr - mem->start) >> IO_TLB_SHIFT;
-	phys_addr_t orig_addr = mem->slots[index].orig_addr;
-	size_t alloc_size = mem->slots[index].alloc_size;
+	int index = (tlb_addr - zone->start) >> IO_TLB_SHIFT;
+	phys_addr_t orig_addr = zone->slots[index].orig_addr;
+	size_t alloc_size = zone->slots[index].alloc_size;
 	unsigned long pfn = PFN_DOWN(orig_addr);
-	unsigned char *vaddr = mem->vaddr + tlb_addr - mem->start;
+	unsigned char *vaddr = zone->vaddr + tlb_addr - zone->start;
 	unsigned int tlb_offset, orig_addr_offset;
 
 	if (orig_addr == INVALID_PHYS_ADDR)
@@ -579,7 +654,10 @@ static void swiotlb_bounce(struct device *dev, phys_addr_t tlb_addr, size_t size
 	}
 }
 
-#define slot_addr(start, idx)	((start) + ((idx) << IO_TLB_SHIFT))
+static inline phys_addr_t slot_addr(phys_addr_t start, phys_addr_t idx)
+{
+	return start + (idx << IO_TLB_SHIFT);
+}
 
 /*
  * Carefully handle integer overflow which can occur when boundary_mask == ~0UL.
@@ -591,9 +669,10 @@ static inline unsigned long get_max_slots(unsigned long boundary_mask)
 	return nr_slots(boundary_mask + 1);
 }
 
-static unsigned int wrap_area_index(struct io_tlb_mem *mem, unsigned int index)
+static unsigned int wrap_area_index(struct io_tlb_zone *zone,
+				    unsigned int index)
 {
-	if (index >= mem->area_nslabs)
+	if (index >= zone->area_nslabs)
 		return 0;
 	return index;
 }
@@ -602,15 +681,15 @@ static unsigned int wrap_area_index(struct io_tlb_mem *mem, unsigned int index)
  * Find a suitable number of IO TLB entries size that will fit this request and
  * allocate a buffer from that IO TLB pool.
  */
-static int swiotlb_do_find_slots(struct device *dev, int area_index,
+static int swiotlb_do_find_slots(struct device *dev,
+		struct io_tlb_zone *zone, int area_index,
 		phys_addr_t orig_addr, size_t alloc_size,
 		unsigned int alloc_align_mask)
 {
-	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
-	struct io_tlb_area *area = mem->areas + area_index;
+	struct io_tlb_area *area = zone->areas + area_index;
 	unsigned long boundary_mask = dma_get_seg_boundary(dev);
 	dma_addr_t tbl_dma_addr =
-		phys_to_dma_unencrypted(dev, mem->start) & boundary_mask;
+		phys_to_dma_unencrypted(dev, zone->start) & boundary_mask;
 	unsigned long max_slots = get_max_slots(boundary_mask);
 	unsigned int iotlb_align_mask =
 		dma_get_min_align_mask(dev) & ~(IO_TLB_SIZE - 1);
@@ -622,7 +701,7 @@ static int swiotlb_do_find_slots(struct device *dev, int area_index,
 	unsigned int slot_index;
 
 	BUG_ON(!nslots);
-	BUG_ON(area_index >= mem->nareas);
+	BUG_ON(area_index >= zone->nareas);
 
 	/*
 	 * For mappings with an alignment requirement don't bother looping to
@@ -635,11 +714,11 @@ static int swiotlb_do_find_slots(struct device *dev, int area_index,
 	stride = max(stride, (alloc_align_mask >> IO_TLB_SHIFT) + 1);
 
 	spin_lock_irqsave(&area->lock, flags);
-	if (unlikely(nslots > mem->area_nslabs - area->used))
+	if (unlikely(nslots > zone->area_nslabs - area->used))
 		goto not_found;
 
-	slot_base = area_index * mem->area_nslabs;
-	index = wrap = wrap_area_index(mem, ALIGN(area->index, stride));
+	slot_base = area_index * zone->area_nslabs;
+	index = wrap = wrap_area_index(zone, ALIGN(area->index, stride));
 
 	do {
 		slot_index = slot_base + index;
@@ -647,7 +726,7 @@ static int swiotlb_do_find_slots(struct device *dev, int area_index,
 		if (orig_addr &&
 		    (slot_addr(tbl_dma_addr, slot_index) &
 		     iotlb_align_mask) != (orig_addr & iotlb_align_mask)) {
-			index = wrap_area_index(mem, index + 1);
+			index = wrap_area_index(zone, index + 1);
 			continue;
 		}
 
@@ -659,10 +738,10 @@ static int swiotlb_do_find_slots(struct device *dev, int area_index,
 		if (!iommu_is_span_boundary(slot_index, nslots,
 					    nr_slots(tbl_dma_addr),
 					    max_slots)) {
-			if (mem->slots[slot_index].list >= nslots)
+			if (zone->slots[slot_index].list >= nslots)
 				goto found;
 		}
-		index = wrap_area_index(mem, index + stride);
+		index = wrap_area_index(zone, index + stride);
 	} while (index != wrap);
 
 not_found:
@@ -671,19 +750,19 @@ static int swiotlb_do_find_slots(struct device *dev, int area_index,
 
 found:
 	for (i = slot_index; i < slot_index + nslots; i++) {
-		mem->slots[i].list = 0;
-		mem->slots[i].alloc_size = alloc_size - (offset +
+		zone->slots[i].list = 0;
+		zone->slots[i].alloc_size = alloc_size - (offset +
 				((i - slot_index) << IO_TLB_SHIFT));
 	}
 	for (i = slot_index - 1;
 	     io_tlb_offset(i) != IO_TLB_SEGSIZE - 1 &&
-	     mem->slots[i].list; i--)
-		mem->slots[i].list = ++count;
+	     zone->slots[i].list; i--)
+		zone->slots[i].list = ++count;
 
 	/*
 	 * Update the indices to avoid searching in the next round.
 	 */
-	if (index + nslots < mem->area_nslabs)
+	if (index + nslots < zone->area_nslabs)
 		area->index = index + nslots;
 	else
 		area->index = 0;
@@ -692,32 +771,33 @@ static int swiotlb_do_find_slots(struct device *dev, int area_index,
 	return slot_index;
 }
 
-static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
+static int swiotlb_find_slots(struct device *dev,
+		struct io_tlb_zone *zone, phys_addr_t orig_addr,
 		size_t alloc_size, unsigned int alloc_align_mask)
 {
-	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
-	int start = raw_smp_processor_id() & (mem->nareas - 1);
+	int start = raw_smp_processor_id() & (zone->nareas - 1);
 	int i = start, index;
 
 	do {
-		index = swiotlb_do_find_slots(dev, i, orig_addr, alloc_size,
+		index = swiotlb_do_find_slots(dev, zone, i,
+					      orig_addr, alloc_size,
 					      alloc_align_mask);
 		if (index >= 0)
 			return index;
-		if (++i >= mem->nareas)
+		if (++i >= zone->nareas)
 			i = 0;
 	} while (i != start);
 
 	return -1;
 }
 
-static unsigned long mem_used(struct io_tlb_mem *mem)
+static unsigned long mem_used(struct io_tlb_zone *zone)
 {
 	int i;
 	unsigned long used = 0;
 
-	for (i = 0; i < mem->nareas; i++)
-		used += mem->areas[i].used;
+	for (i = 0; i < zone->nareas; i++)
+		used += zone->areas[i].used;
 	return used;
 }
 
@@ -728,11 +808,13 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 {
 	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
 	unsigned int offset = swiotlb_align_offset(dev, orig_addr);
+	struct io_tlb_zone *zone;
 	unsigned int i;
 	int index;
 	phys_addr_t tlb_addr;
+	unsigned long dma_mask;
 
-	if (!mem || !mem->nslabs)
+	if (!mem || !mem->zone[SWIOTLB_DF].nslabs)
 		panic("Can not allocate SWIOTLB buffer earlier and can't now provide you with the DMA bounce buffer");
 
 	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
@@ -744,13 +826,20 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 		return (phys_addr_t)DMA_MAPPING_ERROR;
 	}
 
-	index = swiotlb_find_slots(dev, orig_addr,
+	dma_mask = min_not_zero(*dev->dma_mask, dev->bus_dma_limit);
+	if (mem->has_extra && mem->zone[SWIOTLB_EX].nslabs &&
+	    dma_mask == DMA_BIT_MASK(64))
+		zone = &mem->zone[SWIOTLB_EX];
+	else
+		zone = &mem->zone[SWIOTLB_DF];
+
+	index = swiotlb_find_slots(dev, zone, orig_addr,
 				   alloc_size + offset, alloc_align_mask);
 	if (index == -1) {
 		if (!(attrs & DMA_ATTR_NO_WARN))
 			dev_warn_ratelimited(dev,
 	"swiotlb buffer is full (sz: %zd bytes), total %lu (slots), used %lu (slots)\n",
-				 alloc_size, mem->nslabs, mem_used(mem));
+				 alloc_size, zone->nslabs, mem_used(zone));
 		return (phys_addr_t)DMA_MAPPING_ERROR;
 	}
 
@@ -760,8 +849,8 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 	 * needed.
 	 */
 	for (i = 0; i < nr_slots(alloc_size + offset); i++)
-		mem->slots[index + i].orig_addr = slot_addr(orig_addr, i);
-	tlb_addr = slot_addr(mem->start, index) + offset;
+		zone->slots[index + i].orig_addr = slot_addr(orig_addr, i);
+	tlb_addr = slot_addr(zone->start, index) + offset;
 	/*
 	 * When dir == DMA_FROM_DEVICE we could omit the copy from the orig
 	 * to the tlb buffer, if we knew for sure the device will
@@ -769,19 +858,19 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 	 * unconditional bounce may prevent leaking swiotlb content (i.e.
 	 * kernel memory) to user-space.
 	 */
-	swiotlb_bounce(dev, tlb_addr, mapping_size, DMA_TO_DEVICE);
+	swiotlb_bounce(dev, zone, tlb_addr, mapping_size, DMA_TO_DEVICE);
 	return tlb_addr;
 }
 
-static void swiotlb_release_slots(struct device *dev, phys_addr_t tlb_addr)
+static void swiotlb_release_slots(struct device *dev,
+		struct io_tlb_zone *zone, phys_addr_t tlb_addr)
 {
-	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
 	unsigned long flags;
 	unsigned int offset = swiotlb_align_offset(dev, tlb_addr);
-	int index = (tlb_addr - offset - mem->start) >> IO_TLB_SHIFT;
-	int nslots = nr_slots(mem->slots[index].alloc_size + offset);
-	int aindex = index / mem->area_nslabs;
-	struct io_tlb_area *area = &mem->areas[aindex];
+	int index = (tlb_addr - offset - zone->start) >> IO_TLB_SHIFT;
+	int nslots = nr_slots(zone->slots[index].alloc_size + offset);
+	int aindex = index / zone->area_nslabs;
+	struct io_tlb_area *area = &zone->areas[aindex];
 	int count, i;
 
 	/*
@@ -790,11 +879,11 @@ static void swiotlb_release_slots(struct device *dev, phys_addr_t tlb_addr)
 	 * While returning the entries to the free list, we merge the entries
 	 * with slots below and above the pool being returned.
 	 */
-	BUG_ON(aindex >= mem->nareas);
+	BUG_ON(aindex >= zone->nareas);
 
 	spin_lock_irqsave(&area->lock, flags);
 	if (index + nslots < ALIGN(index + 1, IO_TLB_SEGSIZE))
-		count = mem->slots[index + nslots].list;
+		count = zone->slots[index + nslots].list;
 	else
 		count = 0;
 
@@ -803,9 +892,9 @@ static void swiotlb_release_slots(struct device *dev, phys_addr_t tlb_addr)
 	 * superceeding slots
 	 */
 	for (i = index + nslots - 1; i >= index; i--) {
-		mem->slots[i].list = ++count;
-		mem->slots[i].orig_addr = INVALID_PHYS_ADDR;
-		mem->slots[i].alloc_size = 0;
+		zone->slots[i].list = ++count;
+		zone->slots[i].orig_addr = INVALID_PHYS_ADDR;
+		zone->slots[i].alloc_size = 0;
 	}
 
 	/*
@@ -813,9 +902,9 @@ static void swiotlb_release_slots(struct device *dev, phys_addr_t tlb_addr)
 	 * available (non zero)
 	 */
 	for (i = index - 1;
-	     io_tlb_offset(i) != IO_TLB_SEGSIZE - 1 && mem->slots[i].list;
+	     io_tlb_offset(i) != IO_TLB_SEGSIZE - 1 && zone->slots[i].list;
 	     i--)
-		mem->slots[i].list = ++count;
+		zone->slots[i].list = ++count;
 	area->used -= nslots;
 	spin_unlock_irqrestore(&area->lock, flags);
 }
@@ -827,21 +916,30 @@ void swiotlb_tbl_unmap_single(struct device *dev, phys_addr_t tlb_addr,
 			      size_t mapping_size, enum dma_data_direction dir,
 			      unsigned long attrs)
 {
+	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
+	int zone_index = swiotlb_zone_index(mem, tlb_addr);
+	struct io_tlb_zone *zone = &mem->zone[zone_index];
+
 	/*
 	 * First, sync the memory before unmapping the entry
 	 */
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
 	    (dir == DMA_FROM_DEVICE || dir == DMA_BIDIRECTIONAL))
-		swiotlb_bounce(dev, tlb_addr, mapping_size, DMA_FROM_DEVICE);
+		swiotlb_bounce(dev, zone, tlb_addr, mapping_size,
+			       DMA_FROM_DEVICE);
 
-	swiotlb_release_slots(dev, tlb_addr);
+	swiotlb_release_slots(dev, zone, tlb_addr);
 }
 
 void swiotlb_sync_single_for_device(struct device *dev, phys_addr_t tlb_addr,
 		size_t size, enum dma_data_direction dir)
 {
+	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
+	int zone_index = swiotlb_zone_index(mem, tlb_addr);
+	struct io_tlb_zone *zone = &mem->zone[zone_index];
+
 	if (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL)
-		swiotlb_bounce(dev, tlb_addr, size, DMA_TO_DEVICE);
+		swiotlb_bounce(dev, zone, tlb_addr, size, DMA_TO_DEVICE);
 	else
 		BUG_ON(dir != DMA_FROM_DEVICE);
 }
@@ -849,8 +947,12 @@ void swiotlb_sync_single_for_device(struct device *dev, phys_addr_t tlb_addr,
 void swiotlb_sync_single_for_cpu(struct device *dev, phys_addr_t tlb_addr,
 		size_t size, enum dma_data_direction dir)
 {
+	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
+	int zone_index = swiotlb_zone_index(mem, tlb_addr);
+	struct io_tlb_zone *zone = &mem->zone[zone_index];
+
 	if (dir == DMA_FROM_DEVICE || dir == DMA_BIDIRECTIONAL)
-		swiotlb_bounce(dev, tlb_addr, size, DMA_FROM_DEVICE);
+		swiotlb_bounce(dev, zone, tlb_addr, size, DMA_FROM_DEVICE);
 	else
 		BUG_ON(dir != DMA_TO_DEVICE);
 }
@@ -908,13 +1010,14 @@ bool is_swiotlb_active(struct device *dev)
 {
 	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
 
-	return mem && mem->nslabs;
+	return mem && mem->zone[SWIOTLB_DF].nslabs;
 }
 EXPORT_SYMBOL_GPL(is_swiotlb_active);
 
 static int io_tlb_used_get(void *data, u64 *val)
 {
-	*val = mem_used(&io_tlb_default_mem);
+	struct io_tlb_zone *zone = (struct io_tlb_zone *) data;
+	*val = mem_used(zone);
 	return 0;
 }
 DEFINE_DEBUGFS_ATTRIBUTE(fops_io_tlb_used, io_tlb_used_get, NULL, "%llu\n");
@@ -922,13 +1025,26 @@ static int io_tlb_used_get(void *data, u64 *val)
 static void swiotlb_create_debugfs_files(struct io_tlb_mem *mem,
 					 const char *dirname)
 {
+	struct io_tlb_zone *zone;
+
 	mem->debugfs = debugfs_create_dir(dirname, io_tlb_default_mem.debugfs);
-	if (!mem->nslabs)
-		return;
 
-	debugfs_create_ulong("io_tlb_nslabs", 0400, mem->debugfs, &mem->nslabs);
-	debugfs_create_file("io_tlb_used", 0400, mem->debugfs, NULL,
-			&fops_io_tlb_used);
+	zone = &mem->zone[SWIOTLB_DF];
+	if (zone->nslabs) {
+		debugfs_create_ulong("io_tlb_nslabs", 0400,
+				    mem->debugfs, &zone->nslabs);
+		debugfs_create_file("io_tlb_used", 0400, mem->debugfs,
+				    zone, &fops_io_tlb_used);
+	}
+
+	if (mem->has_extra) {
+		zone = &mem->zone[SWIOTLB_EX];
+
+		debugfs_create_ulong("io_tlb_nslabs_extra", 0400,
+				     mem->debugfs, &zone->nslabs);
+		debugfs_create_file("io_tlb_used_extra", 0400,
+				    mem->debugfs, zone, &fops_io_tlb_used);
+	}
 }
 
 static int __init __maybe_unused swiotlb_create_default_debugfs(void)
@@ -946,17 +1062,20 @@ static int __init __maybe_unused swiotlb_create_default_debugfs(void)
 struct page *swiotlb_alloc(struct device *dev, size_t size)
 {
 	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
+	struct io_tlb_zone *zone;
 	phys_addr_t tlb_addr;
 	int index;
 
 	if (!mem)
 		return NULL;
 
-	index = swiotlb_find_slots(dev, 0, size, 0);
+	zone = &mem->zone[SWIOTLB_DF];
+
+	index = swiotlb_find_slots(dev, zone, 0, size, 0);
 	if (index == -1)
 		return NULL;
 
-	tlb_addr = slot_addr(mem->start, index);
+	tlb_addr = slot_addr(zone->start, index);
 
 	return pfn_to_page(PFN_DOWN(tlb_addr));
 }
@@ -964,11 +1083,14 @@ struct page *swiotlb_alloc(struct device *dev, size_t size)
 bool swiotlb_free(struct device *dev, struct page *page, size_t size)
 {
 	phys_addr_t tlb_addr = page_to_phys(page);
+	struct io_tlb_mem *mem = &dev->dma_io_tlb_mem;
+	int zone_index = swiotlb_zone_index(mem, tlb_addr);
+	struct io_tlb_zone *zone = mem->zone[zone_index];
 
 	if (!is_swiotlb_buffer(dev, tlb_addr))
 		return false;
 
-	swiotlb_release_slots(dev, tlb_addr);
+	swiotlb_release_slots(dev, zone, tlb_addr);
 
 	return true;
 }
@@ -977,6 +1099,7 @@ static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
 				    struct device *dev)
 {
 	struct io_tlb_mem *mem = rmem->priv;
+	struct io_tlb_zone *zone;
 	unsigned long nslabs = rmem->size >> IO_TLB_SHIFT;
 
 	/* Set Per-device io tlb area to one */
@@ -992,25 +1115,29 @@ static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
 		if (!mem)
 			return -ENOMEM;
 
-		mem->slots = kcalloc(nslabs, sizeof(*mem->slots), GFP_KERNEL);
-		if (!mem->slots) {
+		zone = &mem->zone[SWIOTLB_DF];
+
+		zone->slots = kcalloc(nslabs, sizeof(*zone->slots), GFP_KERNEL);
+		if (!zone->slots) {
 			kfree(mem);
 			return -ENOMEM;
 		}
 
-		mem->areas = kcalloc(nareas, sizeof(*mem->areas),
+		zone->areas = kcalloc(nareas, sizeof(*zone->areas),
 				GFP_KERNEL);
-		if (!mem->areas) {
-			kfree(mem->slots);
+		if (!zone->areas) {
+			kfree(zone->slots);
 			kfree(mem);
 			return -ENOMEM;
 		}
 
 		set_memory_decrypted((unsigned long)phys_to_virt(rmem->base),
 				     rmem->size >> PAGE_SHIFT);
-		swiotlb_init_io_tlb_mem(mem, rmem->base, nslabs, SWIOTLB_FORCE,
-					false, nareas);
+		swiotlb_init_io_tlb_zone(zone, rmem->base, nslabs, nareas);
 		mem->for_alloc = true;
+		mem->has_extra = false;
+		mem->late_alloc = false;
+		mem->force_bounce = flags & SWIOTLB_FORCE;
 
 		rmem->priv = mem;
 
-- 
1.8.3.1

