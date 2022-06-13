Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3B6954A231
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 00:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236676AbiFMWns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 18:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbiFMWnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 18:43:43 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1275122536
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 15:43:41 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25DJdWaP004207;
        Mon, 13 Jun 2022 22:43:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=duFNUrUorcMuGLyoEcBdIXA8PDdZ6B+0PW3Om2sQGPM=;
 b=eVgaxx5m7riOhjyrGR9SjjHM1a9HOVCoSwBVeu2PNnkH9VAnMyWvOd+iQ4jlUoerlTVe
 jqMmim5GywQ51pIr4joIRTiGovJBGM0FHEGyKZJ9lw26jwhiYsvIZiuTXbk4Gvw1zazz
 zDEnOF+5cqxoPXy8nzuPxfQ15nS+6TGjd1rOOGc8I8WHMYdYYOi+2JGVyk5Ka0/bJjO4
 E2piZEM7p/HJrOl/O8zDabbadcBjxFWJJJprxWVXE9WTw/rA/T9rPRpTFVNIj4jP1Zxc
 bPbiQhLBAPAp0eD2YXeMTgTUPVsNkoUH3Ew3p71wcaB7RrEMuWuEnAq6Ux3YRPBVpLi9 Ig== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmhu2mcry-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jun 2022 22:43:04 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25DMeaSj035945;
        Mon, 13 Jun 2022 22:43:03 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gpe86g49t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jun 2022 22:43:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G+L/hdFsYBLNI7T663WFtlfT29JAmTFwxwj9+a50ljlJ+ej1BPnK9/44uNYMBCrR84s9wGE0pqfml4S83GcOB0XeCKU7BstJm2Wuh8WXbcfg8gAJpTo+IBhCtc5ft0VFdsSVbpIDLAxrYWyDJ1tKj1Dq4SZ5xFyv4p1/1Geul0cAboOiZoVeCQ77yiE2cHuXIjWDNmdCugdcRmxInN38o4+rrUzmXWhQZIdonWuxIyr4/3mPh1tB50uTYwBu4i3vy0vQgUKNC1aidvTCvYulVwPbnX5CfZqThE/R6QSUFo7ba6MGRkVHihwPG2ECGxai5Mvtx31eUMhjASANaa47kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=duFNUrUorcMuGLyoEcBdIXA8PDdZ6B+0PW3Om2sQGPM=;
 b=Ul3HHMkkuty3/qKgqJ6Rxyi3FT00wOisNVXLr8y9eJPDa4l9ufnGbFxF2elIzh9+UKWFDnu3XmTHJoKv500tvYwssBTYOVJNobs03aJIwnIQnjE0x8vJn79l39jVg3w7FPsrOomaL/xSkdP7ZJzaCLOGvRx3tpFgL1WanTcSBM5Od/jiWX/jP+OsH8EM4s/68xx7sKghOHBDilDyw3cbzmpIgFhfLk0Tndj3wMAB/9uFu2xdyeAUgIxY4Ke5jU4M+Chq0229GKHP3or/dPGCjd0CvD+QQ+G1o75jFCmT/MGqc1eqJClZvqfeL23ESkzA9uFoz9RUGRAHD/Dfx7zzbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=duFNUrUorcMuGLyoEcBdIXA8PDdZ6B+0PW3Om2sQGPM=;
 b=ZEFZxG33/4+nrOkGH5+160t+EZ6gEn5lki+XNadsWRGVRbXrsgYL4CmmEQYE/KXTxGk4CGiBeYabPpyBrmH3MUOP0Ja05ucOL3mhe1Q8izhFINzpGCziNGAKnnU/3m7dyI21Q4sxTih829aZkI7fFyoKGvmtSc/GtObuOvbPaFg=
Received: from SJ0PR10MB4542.namprd10.prod.outlook.com (20.182.114.147) by
 MN2PR10MB3805.namprd10.prod.outlook.com (10.255.7.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.13; Mon, 13 Jun 2022 22:43:01 +0000
Received: from SJ0PR10MB4542.namprd10.prod.outlook.com
 ([fe80::2cca:c83a:81cc:18f]) by SJ0PR10MB4542.namprd10.prod.outlook.com
 ([fe80::2cca:c83a:81cc:18f%9]) with mapi id 15.20.5332.021; Mon, 13 Jun 2022
 22:43:01 +0000
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: [PATCH v9 0/7] crash: Kernel handling of CPU and memory hot un/plug
Date:   Mon, 13 Jun 2022 18:42:33 -0400
Message-Id: <20220613224240.79400-1-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM5PR15CA0041.namprd15.prod.outlook.com
 (2603:10b6:4:4b::27) To SJ0PR10MB4542.namprd10.prod.outlook.com
 (2603:10b6:a03:2da::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa76f770-d44d-4081-1f68-08da4d8e120c
X-MS-TrafficTypeDiagnostic: MN2PR10MB3805:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB3805115F92AA77A4374EB2AF97AB9@MN2PR10MB3805.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oyNv8WPfRdtAPX2Gz0qWRfkocbb35vqDApHUVOcohbWZhabRdXM8/M6xg2YP8naWSqLaQDYuXx3+a2eQCDYx2Z38gqZGkXqtl/7e3xSeAK+SmQ0Bj83+ddJ7MKjSL4/rly6Etl4g/h4FY4rTk30Kf6D5WV7Eyu5aWUiZNCVdYjly4UmIvox8Y0RqVN7PeZlO77Q3o4frYkewxxB8kGf4bqWyEQX8gU6XRk9U2SbeP8qVP9EW6ppXZVDZEN70D1L2QuKfVU1o8LHx0kZyoWTeEGjrasNXbZQne3jzxQLR4GLQJr+FUX9U6ESwiXDkmIb741oUvL120TZdxVYoPPrNdpR6UHvjzZ7r0/sjqG67223dIjp5mtIu98Py3JuctcikK34IGvbt6baIipl35lir3ymc2zWG8pAsZXY8nDGrljNp++65eWhKs/P47FpCVrDwwCGVjQqcsgkN230gqZX+duqtliALq9SkYw81KXeMcX5uA3KB7R5fmTWOoaL8Uwp8GhpJdeUlgnLQyhQ8ScjZnrk659WAmG8Hr2Y3JPZ7d7Y56O24kY6K6U2tjI8Xso0HmXhDLki0y/AfsDBaeojuOsLR8t2SSbSRDQBBKAwyPsLEjjoe1CDkjL0E8859Et87A3f6mR5Q7T2S+XTrTY/yCMo4bXu/vFmTAUHGv+vJjw6L1mC1vEBMZxTHZgHclHZMafn0lwaFytq9o/bWi6vvulEkqkUwTqyh5mwUZOzQDr4r+n5Fxyt2gg5/Rxlcwq+AWWi3k10BdzJgPUtnmeTQtDzshrHHTg5n809FAlfO9mmv9I665ox0QApRP5HpiK/7JKD89Ty2bMKIyG+KlxlEUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4542.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(66556008)(66476007)(8676002)(6666004)(2906002)(66946007)(4326008)(7416002)(186003)(5660300002)(6486002)(30864003)(83380400001)(8936002)(508600001)(26005)(38100700002)(52116002)(38350700002)(966005)(6512007)(2616005)(6506007)(86362001)(36756003)(316002)(107886003)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Szda6UJzkA2xAjxloMU5UoWrrEDHIwisMob+7mcT/45Wl2W5Wbr4aYpcC8Za?=
 =?us-ascii?Q?fyavXUpRprLOJDkn3ly34PL2BufYWu47fUCQYQNqaqSSdSqD13yDQFObSylP?=
 =?us-ascii?Q?NBdvDs3nY4gDCvnuCsEYTv6TtyRwBM3FlzBUcdBzw4YPb5nEKFEeBwtVY98j?=
 =?us-ascii?Q?jsCMPj2X3jcvUX0pHCwLLj+6+l1zlFFBy0QAySkqVVpuIQ7OtCTV43Bf/F5l?=
 =?us-ascii?Q?MzwUdDXB9mdiQwc+uNKXax5PZFZ+0Ozcb7Y9ENFsdYRHVjz/JLCNt7RxVcp/?=
 =?us-ascii?Q?2378bGlxRfBCt0yoG66kCP5xKWK+o5K0qklXSYS5H3I2B3eqDTbhmVrBQKAv?=
 =?us-ascii?Q?gjkD3rcRGlDqAbR/mHpgYcouxDyXUYNfw2asruT4/D2B5/A7fPqT7LnSE8cr?=
 =?us-ascii?Q?RGfvWAMIHLiLBy99cCNvgWTQbu3DLmxTPzYTyF4LvgKKG0M9ty5J0A0rMaei?=
 =?us-ascii?Q?kBuGcbNJGeeL6Dke7uUqjSxKhJYasDZ3fD67CsoCa/328XJIKdGGjOzhIijw?=
 =?us-ascii?Q?y2sQbbGPoBQq/SHLlVrDSqlReG2yuKO85bXN0XtUkVIsTwTXHaV2jxAdM2bN?=
 =?us-ascii?Q?4pGLkxsNLWKoCZfRfmjLe2RkimLn4FfrEGua686WIlctk6KeSs+0h+TKgnH1?=
 =?us-ascii?Q?7yI8INskOrKOtv3eR2GY16Zt4oMggHb+Q9eTMlny+wJAB04lBi+O04qh79Bc?=
 =?us-ascii?Q?1J8cl+mhFXGATs4nH8HrBT4E29nD7/0Y5e2GguqqC0/y2+JW8i3vT7hhQJOA?=
 =?us-ascii?Q?dvbCPBlOdb2xWAGz3TTPgzFaQZKFdw0H6EHQ96t1GG3AmW5QFNDpzBt72bCH?=
 =?us-ascii?Q?4sogf6am6PMAVUIxrXtjRRnCIQQD/q4iIE1xtEYnbzoO8wyFVWzNMuq6tG8f?=
 =?us-ascii?Q?MeeXpg4Lv5S2ChrHfcyV83beCnfJPkQIaEsztS5w2kS4Mr3+rmHfyV2SE1ca?=
 =?us-ascii?Q?YGFZnB/8z6DTIkbEZmoHTMDLmYHxun0cg2LycqIdi+/xZYaqSkojm5XFXpBe?=
 =?us-ascii?Q?u9E94wGAkBmyixlzvyb5TEKiXMEd7XGu+Ss0hkYh+aA/LUbgKAlTPKaThZRg?=
 =?us-ascii?Q?bI9ynSbFWHphNh4mdUW9TQpSl5LcUewxpBv0xtjchM7knL4h76WhoHxcCnxW?=
 =?us-ascii?Q?CdHVhCvSZ3RzdIOVHkW7E73znxkEOxd7xInMnMrmnKHcqDLvtLl7/vPoA17m?=
 =?us-ascii?Q?P14CD4lle1BZnGULHSMf+xCPeD4t6vm2uKF4+hKQ+IfC26JNmyb17uwhO6Q4?=
 =?us-ascii?Q?j4/cojQjq53x5R/DAcs/MED6P9yCmcsdySK9wJSmPABPKUnZsxyZILc6oEsD?=
 =?us-ascii?Q?IxKd7xbibWnG1tFD4f/Ul1U2Vrm6Aan6tCrX8SrbRJSDetkyyomMoSA0jkkS?=
 =?us-ascii?Q?GsaX/QvSN/65sGtaIAuUhtu9qH+soeFvYI7hX6XKAUK3fejS6BmVMwWi++J4?=
 =?us-ascii?Q?yUymA7wbKKZ2bWhPSAqx0fX7WXhIdAw6TG/jbGiPxyyMtefIkKoBKH8jZ6X3?=
 =?us-ascii?Q?egJt/CY8BRM9sSEbaQumkweMXOHKadpQaCzFIRXNj2x5WP86AUttZ7SdCMz5?=
 =?us-ascii?Q?u9+AnpX9W2bHWBYiw2Nm2JHDHXTVwgItLs1urGZGNNbG+o4g/SR9QfBYl8c9?=
 =?us-ascii?Q?kPvqmjF5c7aQxCrJa6B38h8PUkckQ67OGbOFR9HVnUOYYUdAmGdsVQv+x1wu?=
 =?us-ascii?Q?BA8tnVGZ9S1mdossXlke1KWnCC/x0RmoCFiwgffAKBmTdVueU/4CL+/pjYDD?=
 =?us-ascii?Q?m/wwMRxJwA5vmSq+tL5auT9kZXu/1c8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa76f770-d44d-4081-1f68-08da4d8e120c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4542.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 22:43:01.3432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: If0ZlK/BR6gCREe7W3KAy3noY17MNKhDb5OatxukKO1isvVfUiYF0xqP95h9nSc19F+YVy1xbxBk7HD7bTQzbUrgmmKSvUV3kMnoNLnWpIg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3805
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-13_09:2022-06-13,2022-06-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206130087
X-Proofpoint-GUID: ZeKYkXWzocWiGMND3eoEle8eaJt7Y8YA
X-Proofpoint-ORIG-GUID: ZeKYkXWzocWiGMND3eoEle8eaJt7Y8YA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

 - Prevent udev from updating kdump crash kernel on hot un/plug changes.
   Add the following as the first lines to the udev rule file
   /usr/lib/udev/rules.d/98-kexec.rules:

   # The kernel handles updates to crash elfcorehdr for cpu and memory changes
   SUBSYSTEM=="cpu", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
   SUBSYSTEM=="memory", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"

   These lines will cause cpu and memory hot un/plug events to be
   skipped within this rule file, if the kernel has these changes
   enabled.

 - Change to the kexec_file_load for loading the kdump kernel:
   Eg. on RHEL: in /usr/bin/kdumpctl, change to:
    standard_kexec_args="-p -d -s"
   which adds the -s to select kexec_file_load syscall.

This patchset supports kexec_load with a modified kexec userspace
utility, and a working changeset to the kexec userspace utility
is provided here (and to use, the above change to standard_kexec_args
would be, for example, to append --hotplug instead of -s).

  diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
  index 9826f6d..4ed395a 100644
  --- a/kexec/arch/i386/crashdump-x86.c
  +++ b/kexec/arch/i386/crashdump-x86.c
  @@ -48,6 +48,7 @@
   #include <x86/x86-linux.h>
   
   extern struct arch_options_t arch_options;
  +extern int do_hotplug;
   
   static int get_kernel_page_offset(struct kexec_info *UNUSED(info),
   				  struct crash_elf_info *elf_info)
  @@ -975,6 +976,14 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
   	} else {
   		memsz = bufsz;
   	}
  +
  +	/* If hotplug support enabled, use larger size to accomodate changes */
  +	if (do_hotplug) {
  +		long int nr_cpus = get_nr_cpus();
  +		memsz = (nr_cpus + CRASH_MAX_MEMORY_RANGES) * sizeof(Elf64_Phdr);
  +	}
  +
  +    info->elfcorehdr =
   	elfcorehdr = add_buffer(info, tmp, bufsz, memsz, align, min_base,
   							max_addr, -1);
   	dbgprintf("Created elf header segment at 0x%lx\n", elfcorehdr);
  diff --git a/kexec/crashdump-elf.c b/kexec/crashdump-elf.c
  index b8bb686..5e29f7a 100644
  --- a/kexec/crashdump-elf.c
  +++ b/kexec/crashdump-elf.c
  @@ -43,11 +43,7 @@ int FUNC(struct kexec_info *info,
   	int (*get_note_info)(int cpu, uint64_t *addr, uint64_t *len);
   	long int count_cpu;
   
  -	if (xen_present())
  -		nr_cpus = xen_get_nr_phys_cpus();
  -	else
  -		nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
  -
  +	nr_cpus = get_nr_cpus();
   	if (nr_cpus < 0) {
   		return -1;
   	}
  diff --git a/kexec/crashdump.h b/kexec/crashdump.h
  index 18bd691..28d3278 100644
  --- a/kexec/crashdump.h
  +++ b/kexec/crashdump.h
  @@ -57,7 +57,6 @@ unsigned long phys_to_virt(struct crash_elf_info *elf_info,
   			   unsigned long long paddr);
   
   unsigned long xen_architecture(struct crash_elf_info *elf_info);
  -int xen_get_nr_phys_cpus(void);
   int xen_get_note(int cpu, uint64_t *addr, uint64_t *len);
   int xen_get_crashkernel_region(uint64_t *start, uint64_t *end);
   
  diff --git a/kexec/kexec-xen.h b/kexec/kexec-xen.h
  index 70fb576..f54a2dd 100644
  --- a/kexec/kexec-xen.h
  +++ b/kexec/kexec-xen.h
  @@ -83,5 +83,6 @@ extern int __xc_interface_close(xc_interface *xch);
   #endif
   
   int xen_get_kexec_range(int range, uint64_t *start, uint64_t *end);
  +int xen_get_nr_phys_cpus(void);
   
   #endif /* KEXEC_XEN_H */
  diff --git a/kexec/kexec.c b/kexec/kexec.c
  index 829a6ea..3668b73 100644
  --- a/kexec/kexec.c
  +++ b/kexec/kexec.c
  @@ -58,6 +58,7 @@
   
   unsigned long long mem_min = 0;
   unsigned long long mem_max = ULONG_MAX;
  +int do_hotplug = 0;
   static unsigned long kexec_flags = 0;
   /* Flags for kexec file (fd) based syscall */
   static unsigned long kexec_file_flags = 0;
  @@ -489,6 +490,17 @@ static int add_backup_segments(struct kexec_info *info,
   	return 0;
   }
   
  +long int get_nr_cpus(void)
  +{
  +    long int nr_cpus;
  +
  +	if (xen_present())
  +		nr_cpus = xen_get_nr_phys_cpus();
  +	else
  +		nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
  +    return nr_cpus;
  +}
  +
   static char *slurp_fd(int fd, const char *filename, off_t size, off_t *nread)
   {
   	char *buf;
  @@ -672,6 +684,14 @@ static void update_purgatory(struct kexec_info *info)
   		if (info->segment[i].mem == (void *)info->rhdr.rel_addr) {
   			continue;
   		}
  +
  +		/* Don't include elfcorehdr in the checksum, if hotplug
  +		 * support enabled.
  +		 */
  +		if (do_hotplug && (info->segment[i].mem == (void *)info->elfcorehdr)) {
  +			continue;
  +		}
  +
   		sha256_update(&ctx, info->segment[i].buf,
   			      info->segment[i].bufsz);
   		nullsz = info->segment[i].memsz - info->segment[i].bufsz;
  @@ -1565,6 +1585,9 @@ int main(int argc, char *argv[])
   		case OPT_PRINT_CKR_SIZE:
   			print_crashkernel_region_size();
   			return 0;
  +		case OPT_HOTPLUG:
  +			do_hotplug = 1;
  +			break;
   		default:
   			break;
   		}
  diff --git a/kexec/kexec.h b/kexec/kexec.h
  index 0f97a97..b0428cc 100644
  --- a/kexec/kexec.h
  +++ b/kexec/kexec.h
  @@ -169,6 +169,7 @@ struct kexec_info {
   	int command_line_len;
   
   	int skip_checks;
  +	unsigned long elfcorehdr;
   };
   
   struct arch_map_entry {
  @@ -231,7 +232,8 @@ extern int file_types;
   #define OPT_PRINT_CKR_SIZE	262
   #define OPT_LOAD_LIVE_UPDATE	263
   #define OPT_EXEC_LIVE_UPDATE	264
  -#define OPT_MAX			265
  +#define OPT_HOTPLUG		265
  +#define OPT_MAX		266
   #define KEXEC_OPTIONS \
   	{ "help",		0, 0, OPT_HELP }, \
   	{ "version",		0, 0, OPT_VERSION }, \
  @@ -258,6 +260,7 @@ extern int file_types;
   	{ "debug",		0, 0, OPT_DEBUG }, \
   	{ "status",		0, 0, OPT_STATUS }, \
   	{ "print-ckr-size",     0, 0, OPT_PRINT_CKR_SIZE }, \
  +	{ "hotplug",		0, 0, OPT_HOTPLUG }, \
   
   #define KEXEC_OPT_STR "h?vdfixyluet:pscaS"
   
  @@ -290,6 +293,8 @@ extern unsigned long add_buffer_phys_virt(struct kexec_info *info,
   	int buf_end, int phys);
   extern void arch_reuse_initrd(void);
   
  +extern long int get_nr_cpus(void);
  +
   extern int ifdown(void);
   
   extern char purgatory[];

Regards,
eric
---

v9: 13jun2022
 - Rebased to 5.18.0
 - Per Sourabh, moved crash_prepare_elf64_headers() into common
   crash_core.c to avoid compile issues with kexec_load only path.
 - Per David Hildebrand, replaced mutex_trylock() with mutex_lock().
 - Changed the __weak arch_crash_handle_hotplug_event() to utilize
   WARN_ONCE() instead of WARN(). Fix some formatting issues.
 - Per Sourabh, introduced sysfs attribute crash_hotplug for memory
   and CPUs; for use by userspace (udev) to determine if the kernel
   performs crash hot un/plug support.
 - Per Sourabh, moved the code detecting the elfcorehdr segment from
   arch/x86 into crash_core:handle_hotplug_event() so both kexec_load
   and kexec_file_load can benefit.
 - Updated userspace kexec-tools kexec utility to reflect change to
   using CRASH_MAX_MEMORY_RANGES and get_nr_cpus().

v8: 5may2022
 https://lkml.org/lkml/2022/5/5/1133
 - Per Borislav Petkov, eliminated CONFIG_CRASH_HOTPLUG in favor
   of CONFIG_HOTPLUG_CPU || CONFIG_MEMORY_HOTPLUG, ie a new define
   is not needed. Also use of IS_ENABLED() rather than #ifdef's.
   Renamed crash_hotplug_handler() to handle_hotplug_event().
   And other corrections.
 - Per Baoquan, minimized the parameters to the arch_crash_
   handle_hotplug_event() to hp_action and cpu.
 - Introduce KEXEC_CRASH_HP_INVALID_CPU definition, per Baoquan.
 - Per Sourabh Jain, renamed and repurposed CRASH_HOTPLUG_ELFCOREHDR_SZ
   to CONFIG_CRASH_MAX_MEMORY_RANGES, mirroring kexec-tools change
   by David Hildebrand. Folded this patch into the x86
   kexec_file_load support patch.

v7: 13apr2022
 https://lkml.org/lkml/2022/4/13/850
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


Eric DeVolder (7):
  crash: move crash_prepare_elf64_headers
  crash: prototype change for crash_prepare_elf64_headers
  crash: add generic infrastructure for crash hotplug support
  kexec: exclude elfcorehdr from the segment digest
  kexec: exclude hot remove cpu from elfcorehdr notes
  crash: memory and cpu hotplug sysfs attributes
  x86/crash: Add x86 crash hotplug support

 .../admin-guide/mm/memory-hotplug.rst         |   8 +
 Documentation/core-api/cpu_hotplug.rst        |  18 ++
 arch/arm64/kernel/machine_kexec_file.c        |   6 +-
 arch/powerpc/kexec/file_load_64.c             |   2 +-
 arch/x86/Kconfig                              |  11 +
 arch/x86/kernel/crash.c                       | 119 ++++++++-
 drivers/base/cpu.c                            |  13 +
 drivers/base/memory.c                         |  13 +
 include/linux/crash_core.h                    |  12 +
 include/linux/kexec.h                         |  14 +-
 kernel/crash_core.c                           | 241 ++++++++++++++++++
 kernel/kexec_file.c                           | 105 +-------
 12 files changed, 456 insertions(+), 106 deletions(-)

-- 
2.31.1

