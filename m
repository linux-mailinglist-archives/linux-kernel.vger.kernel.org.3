Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307334FFB94
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 18:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236970AbiDMQpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 12:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbiDMQpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 12:45:45 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0538666FB8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 09:43:22 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23DG2xdD028178;
        Wed, 13 Apr 2022 16:42:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=tL2MhzTro4tIt4WMHaVUUqw+BRgkrRibowaMVcfuWqA=;
 b=N0+Fqh/O3fU71O2cSpIOeNpUBC5JO8v+rEMoyLlk5G8LqEGwEM/4K+uOKV+peRtP3QVR
 Pouctd1qH2FAvHpm3Uu/nA3HYT/xxTu5J3JvSVnZ2Y3tUXsyyh3ZX7TVVeU6Q+uwPFBW
 lF6eA3Y0H6zBbrUEb3okZI3xZ9dz1yJ7OaIfVuSg7ov/CLVcx+bjs7hpmf8UZ/SCSMOg
 oTCgYWo8Q2SLGX3sVmCZWWbXHHi3cfqjbbvzd/CLoEpjS/bhS5WqUQkOLDfwzY2WERwV
 47CcQWnVbxJ83Jh6tJmK+pC/grCRzwQbTvKX6w5fjIz59/03VmJzHpUJskwCfny7RXkG 8Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb21a255f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Apr 2022 16:42:55 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23DGPTtG020947;
        Wed, 13 Apr 2022 16:42:54 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fb0k4k9b0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Apr 2022 16:42:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C0Lxvk0EsSyrk6lfOBgGHK6pnuqc3+CgD9GehZ6KKmLbpbjfr8BlPxEUrGBDg/M6ySjjQilcBvdxFr2JU8Yen2swkH/3tfKoKLUrlStUUM+6yaHT/QUIkdO/l6CreZVolB85Dur33AbTWN8EQi6JhnIZQPzzp+IziXRWf+KudASPpUG+LNrMo3FxwigoIJGISgpdDXl3zANFmks42bL3+Ae5G0+uQzuOze78u1gZzg5EogfNQxtpWUFzFbk3utcu70Xrbx4VuQ/pwgK2FD/GoGQD/b965U55TF+IvoIcU+t3UCD+6y+zwVuEVK+F9lrgLvILoBi1h4hLV2Y1bZlVQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tL2MhzTro4tIt4WMHaVUUqw+BRgkrRibowaMVcfuWqA=;
 b=arBimql3e0M0bMnnbVrICHkWO7GBY6hEMIEU+spAFPw7Vc31a9NiLQAsbad6auFrPBV7E4CU5k6H6QQyMqpKf9ej1QcpcreYXhM/vw9TOAqnBkFxPpXoVtiwqyUuX9rkDON4N3jPT8dWFTlfamz3uXHUaSLG8grxyikZg2ulyK1OluAiR3X8e0YWJj/pR+581o5BGvz4YRJikG1ozygENQ6uwD4nM9NBECOF5XS1iDbWoAyfkimPWAPzsLlXFMentQFzBgu47VWycWZ3PAUSCPa1X6qi/9+7qr6AYagFxvneNTx5X3mbYatZlOR0Hqk9K8Hse9N0kY9rF9glmVi9Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tL2MhzTro4tIt4WMHaVUUqw+BRgkrRibowaMVcfuWqA=;
 b=ubF/HPNF88YPwCxNOoq8kUv9mf3meW/pN2wZjVeo9CJUz8ChZMEm+mOwH6qfaIckJ+SsxvIho0yXHPWycF+WtD8F4p3KbpENv6Belnd+W7TraLduhUUkm7+j6JO5LVTyKN4q937zZ6hi/xeHIEyo05/SAF6YmFo7xNcxKelceWQ=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by BYAPR10MB3560.namprd10.prod.outlook.com (2603:10b6:a03:124::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Wed, 13 Apr
 2022 16:42:51 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::65fa:78de:f4d:1a5c]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::65fa:78de:f4d:1a5c%3]) with mapi id 15.20.5144.030; Wed, 13 Apr 2022
 16:42:51 +0000
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
Subject: [PATCH v7 0/8] crash: Kernel handling of CPU and memory hot un/plug
Date:   Wed, 13 Apr 2022 12:42:29 -0400
Message-Id: <20220413164237.20845-1-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0024.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::29) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d1a45277-1894-4330-0e15-08da1d6ca65b
X-MS-TrafficTypeDiagnostic: BYAPR10MB3560:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB35603DB8D074E88A893644AC97EC9@BYAPR10MB3560.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V5jYPzv2YDItcL8OzDC64Idzro9DrNCatrRej+h4OJNFoNmakwX3OKBczOSP00P3Ot1YBMUwqhb/WuHJlGNwT3LwQGljOivOe/V1ullmLoY9NY442OEM9yGDzsI9n9YZRXYbybwf9o0Xndlu2n6Z0AHYo4cSVWYuXBb3UpJwwNc6Ehx0gLB0ZAYRHD78bd5ATj84YL2qXcajNwjU8hx7p/cegl6mq6NETEZiWnGIlWeVsaMWKwVMRxoPtIMFMy1+hrUkEs7W38abLEBDiw8lEb98MVBHlebaAZA0f2UoPed1OkmlSJyjHQ4K8pdkktQq30b7wmdSM9uH6pzslCW0U207L/0+6x7/dOx32kgjA0/y3Es2Q0eBe0CHX2Va8Ww65bJsr7bVPZ6q/NbiqPNVV6LVHcu0y0sjkkq01ih769YgJp46i+lUHSMOeA6Pg3WAY7HFj+HmUdxN5Z0H3pbJRTMszzX1xdfxIq0mtFb0ozowCQZZAqfYjLKWK6Zs05Osr73/ClcRGuu4bO8D9Xf2FC0AZo8VkVeRbdT+leJiHKvUy1l8DS17B8Xts5KBhWGmYHMyDSHvuT6OaKA/zFRJrLzRbHCeOIlmHzPtUjTe74hqhGJAOBYE3obmIx+L6H8NIYdlzVtJDSFfK3vly1hE+NuaiHonaKaDNFmzEvyM1pX841EUrP/m5Fmuz5+Fwvx2hoGL2ElXLs49Qnoqsto51oB69Okty7iW7IsvpHj78McBJaPZUtIOsQ9rxYQ0nfxrkrpVnB5PRY8EFDzpdAGkFfL9dwqm/d8aR9/q6S4WXeGVHMr8BNbt4AIlnId00pNw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6666004)(83380400001)(38350700002)(66556008)(36756003)(2906002)(2616005)(6512007)(86362001)(52116002)(6506007)(38100700002)(966005)(6486002)(508600001)(66476007)(186003)(26005)(107886003)(1076003)(66946007)(316002)(7416002)(5660300002)(4326008)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6gsVpolk//S5ywCA0Qj9+eNBN7htapAzVuQfqTZrqffz6zQeE/nhWWMmVf6N?=
 =?us-ascii?Q?M8axJTmbgoTyPLf36K8rIbN7LKPO1n4q2vOaO8Andf/XZ8TMvaNkpxagoTU5?=
 =?us-ascii?Q?rB4irHGKIqT+XJ/6RFy3m+9PPw7gL42k0+i8rZSMkwZfqVOczw5FGL1rPIgL?=
 =?us-ascii?Q?5H+9C4CK5SCn1sl4GT/Pkaf1w0SZ+5A7EcKW4L0M6ytAt5yP96Jg0jlhWtB9?=
 =?us-ascii?Q?Mq7x/+t4CvHiPiu7p3GZGFX6hDAXb0sRexqbRcOzxYbeLQKwrfWqxFLdRHWr?=
 =?us-ascii?Q?SVfdUxSrfATCavFBU1surTxJCssa4tnrnzwp/q1qfzqTyf+qLOysYISIOkKP?=
 =?us-ascii?Q?5EH5lpaNeep0sarRfVU0sM3Kn5C+eslXK4Pa8LGwFgzMQ2PyRJmabeaYm2i4?=
 =?us-ascii?Q?AQeC/S29XelgdwvT2+Xr4P01AHGjasaJdv+ueZrNHj5KAPd/Ayr/cn9dXS8n?=
 =?us-ascii?Q?pFQU0EAmijODXLUUPBVwQfIgCSuJW9XBFzxley+kdN4sIWfoQA/HvtLZdGFh?=
 =?us-ascii?Q?CDRDi9ahRa9kkoUnUnLOGFKicBk21mDxl25O5jsUYwAv6dFkLApUw4qXtsMI?=
 =?us-ascii?Q?ANYWBI2p2VFFzaC5Uqf5z4iIu27LUjmoZMXjgFAYodOnThTFkeujh3kEt/TG?=
 =?us-ascii?Q?wevu1bjGQ5j3kC5JVyvk91K2tcsRWUUmCWjQwqv5ZC3EMuFYXnXjzIMxSGtc?=
 =?us-ascii?Q?xd94MskjdNTiRmsreLJZAZgpodj5K4UuwRNLHa6Kjdp3/N3FFGRTRMKbB1oj?=
 =?us-ascii?Q?KsL2ThLOV9euMdtpj5Gn2ERY3bYfAfI648DGUQ/VLiCZ8e4U2UwEOlTywmz2?=
 =?us-ascii?Q?BgfIWFFNl5oj8Wy9LU6ajf3A/QX380a+hhcMsTsKoMx07Lpg3TJ4ZTZx/ey2?=
 =?us-ascii?Q?KJRkhsGf5jZfmc4ZjW5INUE9Qh/+fyqcKGE8lNaS7/aBbkwVeiNaLpJA6Ocl?=
 =?us-ascii?Q?DZys8HSKS9MnMBBCuVXrZ63DCauSS+XEuGLkg39uGW9Y36O1QlgqBlspbW8A?=
 =?us-ascii?Q?LiP0l0op0qXaafMFXQTVcoJ0FM1Q54fY68pEHcYiM9dCAzvL+YQqy7XZprMf?=
 =?us-ascii?Q?dw6EtqbsvnlzbRv1ksle4euWw7jX1YYIB6JOCW8jGc5te9eLWS/CMCaVlOkY?=
 =?us-ascii?Q?/xL/g0Vp6UWm4C3u3TxkwL21SJb2M8KHfyhOaUD37C+Sz6fsKGQhJ+EiDTOM?=
 =?us-ascii?Q?vzUMPBngGVo8Xp2vapCE5IlpEkU4iHjCKi+yXyVy3pAa4SksnEnJs6Swtjza?=
 =?us-ascii?Q?h8y8abSgydnAPOpaKBgZycRgCr9wEjrL7qc4KvZoJMsbo35HtskyXV11U6BV?=
 =?us-ascii?Q?u+bpjssP1Tb99PCO3qu007GnYr512Io9+D+NmIytqXGxf87GEFimvDOEKB/t?=
 =?us-ascii?Q?fNQiB6g1CNYNqRBXsdWHkaHgYDZXQ6GNMt3r/Jkb2vD1LATrDezoUtzr757A?=
 =?us-ascii?Q?qq4lS1O75sVtJg1QlnJy47BA7k0mRPGsWylyGMJQr3ZqIgLaWV/VnDvKDvNq?=
 =?us-ascii?Q?DfULqKwhBrmGxaqGvBsn3/JBcwBysrFk0n4DnC1q0XdNHSpvgQqtmw94hUc0?=
 =?us-ascii?Q?H6Uq/Pmyu1GBWPd5JKQBvAMNOUc3M6iwiRsJPJhBaNdvZaJAzGxrDU+/td91?=
 =?us-ascii?Q?Qk854DAhWzedkrxQrRmFnG87kaFfzerAezWtiSABuhArlQB4RpRw90w5gYZq?=
 =?us-ascii?Q?lVFd8XaIZK9pHCXTj94U95uImTBJwmHx2HQjEJmm8LT4PTBwMQgR2kgAKdAO?=
 =?us-ascii?Q?gt7mKiSNuHkXglPJnJAA1kmYohT/66s=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1a45277-1894-4330-0e15-08da1d6ca65b
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2022 16:42:51.3348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LgJLXQEfjs56xEHJ3DdqZEAFCQ2il6ahXlQkRxKuFQwHZnt5rpjv5JngFdOjFGOdEh1x7+9gKlx0v/lPd7YtbXTFK3PJg8KBILemvSzC/ik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3560
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-13_03:2022-04-13,2022-04-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204130085
X-Proofpoint-GUID: 9BjGuuxhwwAOdg4sF09Y9yH15CX2yKLH
X-Proofpoint-ORIG-GUID: 9BjGuuxhwwAOdg4sF09Y9yH15CX2yKLH
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the kdump service is loaded, if a CPU or memory is hot
un/plugged, the crash elfcorehdr (for x86), which describes the CPUs
and memory in the system, must also be updated, else the resulting
vmcore is inaccurate (eg. missing either CPU context or memory
regions).

The current solution utilizes udev to initiate an unload-then-reload
of the kdump image (e. kernel, initrd, boot_params, puratory and
elfcorehdr) by the userspace kexec utility. In previous posts I have
outlined the significant performance problems related to offloading
this activity to userspace.

This patchset introduces a generic crash hot un/plug handler that
registers with the CPU and memory notifiers. Upon CPU or memory
changes, this generic handler is invoked and performs important
housekeeping, for example obtaining the appropriate lock, and then
invokes an architecture specific handler to do the appropriate
updates.

In the case of x86_64, the arch specific handler generates a new
elfcorehdr, and overwrites the old one in memory. No involvement
with userspace needed.

To realize the benefits/test this patchset, one must make a couple
of minor changes to userspace:

 - Disable the udev rule for updating kdump on hot un/plug changes.
   Add the following as the first two lines to the udev rule file
   /usr/lib/udev/rules.d/98-kexec.rules:

# For x86_64, the kernel handles updates to crash elfcorehdr
CONST{arch}=="x86-64", GOTO="kdump_reload_end"

   These two lines will cause cpu and memory hot un/plug events
   to be skipped within this rule file.

 - Change to the kexec_file_load for loading the kdump kernel:
   Eg. on RHEL: in /usr/bin/kdumpctl, change to:
    standard_kexec_args="-p -d -s"
   which adds the -s to select kexec_file_load syscall.

This patchset supports kexec_load with a modified kexec userspace
utility, and a working changeset to the kexec userspace utility
is provided here (and to use, the above change to standard_kexec_args
would be, for example, to append --hotplug-size=131072 instead of -s).

 diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
 index 9826f6d..06adb7e 100644
 --- a/kexec/arch/i386/crashdump-x86.c
 +++ b/kexec/arch/i386/crashdump-x86.c
 @@ -48,6 +48,7 @@
  #include <x86/x86-linux.h>
  
  extern struct arch_options_t arch_options;
 +extern unsigned long long hotplug_size;
  
  static int get_kernel_page_offset(struct kexec_info *UNUSED(info),
  				  struct crash_elf_info *elf_info)
 @@ -975,6 +976,13 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
  	} else {
  		memsz = bufsz;
  	}
 +
 +    /* If hotplug support enabled, use that size */
 +    if (hotplug_size) {
 +        memsz = hotplug_size;
 +    }
 +
 +    info->elfcorehdr =
  	elfcorehdr = add_buffer(info, tmp, bufsz, memsz, align, min_base,
  							max_addr, -1);
  	dbgprintf("Created elf header segment at 0x%lx\n", elfcorehdr);
 diff --git a/kexec/kexec.c b/kexec/kexec.c
 index f63b36b..9569d9a 100644
 --- a/kexec/kexec.c
 +++ b/kexec/kexec.c
 @@ -58,6 +58,7 @@
  
  unsigned long long mem_min = 0;
  unsigned long long mem_max = ULONG_MAX;
 +unsigned long long hotplug_size = 0;
  static unsigned long kexec_flags = 0;
  /* Flags for kexec file (fd) based syscall */
  static unsigned long kexec_file_flags = 0;
 @@ -672,6 +673,12 @@ static void update_purgatory(struct kexec_info *info)
  		if (info->segment[i].mem == (void *)info->rhdr.rel_addr) {
  			continue;
  		}
 +        /* Don't include elfcorehdr in the checksum, if hotplug
 +         * support enabled.
 +         */
 +        if (hotplug_size && (info->segment[i].mem == (void *)info->elfcorehdr)) {
 +			continue;
 +		}
  		sha256_update(&ctx, info->segment[i].buf,
  			      info->segment[i].bufsz);
  		nullsz = info->segment[i].memsz - info->segment[i].bufsz;
 @@ -1504,6 +1511,17 @@ int main(int argc, char *argv[])
  		case OPT_PRINT_CKR_SIZE:
  			print_crashkernel_region_size();
  			return 0;
 +		case OPT_HOTPLUG_SIZE:
 +            /* Reserved the specified size for hotplug growth */
 +			hotplug_size = strtoul(optarg, &endptr, 0);
 +			if (*endptr) {
 +				fprintf(stderr,
 +					"Bad option value in --hotplug-size=%s\n",
 +					optarg);
 +				usage();
 +				return 1;
 +			}
 +			break;
  		default:
  			break;
  		}
 diff --git a/kexec/kexec.h b/kexec/kexec.h
 index 595dd68..b30dda4 100644
 --- a/kexec/kexec.h
 +++ b/kexec/kexec.h
 @@ -169,6 +169,7 @@ struct kexec_info {
  	int command_line_len;
  
  	int skip_checks;
 +    unsigned long elfcorehdr;
   };
  
  struct arch_map_entry {
 @@ -231,7 +232,8 @@ extern int file_types;
  #define OPT_PRINT_CKR_SIZE	262
  #define OPT_LOAD_LIVE_UPDATE	263
  #define OPT_EXEC_LIVE_UPDATE	264
 -#define OPT_MAX			265
 +#define OPT_HOTPLUG_SIZE	265
 +#define OPT_MAX			266
  #define KEXEC_OPTIONS \
  	{ "help",		0, 0, OPT_HELP }, \
  	{ "version",		0, 0, OPT_VERSION }, \
 @@ -258,6 +260,7 @@ extern int file_types;
  	{ "debug",		0, 0, OPT_DEBUG }, \
  	{ "status",		0, 0, OPT_STATUS }, \
  	{ "print-ckr-size",     0, 0, OPT_PRINT_CKR_SIZE }, \
 +	{ "hotplug-size",     2, 0, OPT_HOTPLUG_SIZE }, \
  
  #define KEXEC_OPT_STR "h?vdfixyluet:pscaS"
 

Regards,
eric
---
v7: 13apr2022
 - Resolved parameter usage to crash_hotplug_handler(), per Baoquan.

v6: 1apr2022
 https://lkml.org/lkml/2022/4/1/1203
 - Reword commit messages and some comment cleanup per Baoquan.
 - Changed elf_index to elfcorehdr_index for clarity.
 - Minor code changes per Baoquan.

v5: 3mar2022
 https://lkml.org/lkml/2022/3/3/674
 - Reworded description of CRASH_HOTPLUG_ELFCOREHDR_SZ, per
   David Hildenbrand.
 - Refactored slightly a few patches per Baoquan recommendation.

v4: 9feb2022
 https://lkml.org/lkml/2022/2/9/1406
 - Refactored patches per Baoquan suggestsions.
 - A few corrections, per Baoquan.

v3: 10jan2022
 https://lkml.org/lkml/2022/1/10/1212
 - Rebasing per Baoquan He request.
 - Changed memory notifier per David Hildenbrand.
 - Providing example kexec userspace change in cover letter.

RFC v2: 7dec2021
 https://lkml.org/lkml/2021/12/7/1088
 - Acting upon Baoquan He suggestion of removing elfcorehdr from
   the purgatory list of segments, removed purgatory code from
   patchset, and it is signficiantly simpler now.

RFC v1: 18nov2021
 https://lkml.org/lkml/2021/11/18/845
 - working patchset demonstrating kernel handling of hotplug
   updates to x86 elfcorehdr for kexec_file_load

RFC: 14dec2020
 https://lkml.org/lkml/2020/12/14/532
 - proposed concept of allowing kernel to handle hotplug update
   of elfcorehdr
---

Eric DeVolder (8):
  x86/crash: fix minor typo/bug in debug message
  x86/crash: Introduce new options to support cpu and memory hotplug
  crash: prototype change for crash_prepare_elf64_headers
  crash: add generic infrastructure for crash hotplug support
  kexec: exclude elfcorehdr from the segment digest
  kexec: exclude hot remove cpu from elfcorehdr notes
  x86/crash: Add x86 crash hotplug support for kexec_file_load
  x86/crash: Add x86 crash hotplug support for kexec_load

 arch/arm64/kernel/machine_kexec_file.c |   6 +-
 arch/powerpc/kexec/file_load_64.c      |   2 +-
 arch/x86/Kconfig                       |  26 +++++
 arch/x86/kernel/crash.c                | 146 ++++++++++++++++++++++++-
 include/linux/kexec.h                  |  21 +++-
 kernel/crash_core.c                    | 110 +++++++++++++++++++
 kernel/kexec_file.c                    |  15 ++-
 7 files changed, 316 insertions(+), 10 deletions(-)

-- 
2.27.0

