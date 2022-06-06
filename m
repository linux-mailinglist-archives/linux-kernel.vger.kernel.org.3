Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B467653F104
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 22:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234942AbiFFUv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 16:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234881AbiFFUuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 16:50:18 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F1158E58
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 13:41:39 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 256Ivt9C017195;
        Mon, 6 Jun 2022 20:39:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=VxXLKjeuUfXGFnmu/XOWoPvkEANkl+2Tw+Bidk8Tj9Y=;
 b=Xe7c8DqePAoVnBDcNlMSpEmF7VrLvL8V2NqtgEEyYKJ1/RhYYzoZ9jBPL1TMUPgvtLcU
 ya+zd1V+gJuS3IALo9rx3Chb+NFH0Cie85cX7fjgwvleMT2Y7iBtgwjkUrAIzxAQDiqR
 jxEOsu8FDQDeLeCKDK8qaCTNTab8QG/s1T6LgThgCGAIZ354cR0/jIgkGwxvroob9M9o
 PuKd9Ql5FUvyMlzIECGwHSp3HUuTGrpT5XXeY8oCYENmiSTBwoekfXREUaYv8/E6yJXl
 XetVxNhwT7kR3xQyogIFbOstMJSZ3k8vZc6O6yFEKVOf+HUmmxVEDINTiiaXbAo37sSr uQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ggvxmtg0r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jun 2022 20:39:18 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 256KF7HU001111;
        Mon, 6 Jun 2022 20:39:18 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gfwu91d57-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jun 2022 20:39:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CXDOTteAVzsx6S0zE5kqtXJH2JtmH9ak1Utrxw57MXuKrH4aad3wf1zMV0Jj+WyNzlbwC09QtdVRuLGVDG/xCI56+srs09w/WmulAXIcDGNV3mPhPY4mEfuQggvTKJ/CdIRF8uj/fpiUjU4O7bZ9splJfrSi7GasDTpZ5NphOPL0HYwRE5tnf2NFresR10wlcetfYdS1WTqj8WRSdauMMFGf9y5fVQc0Q73IjWL++MD1KaKpqkDuaqMjDrlaGSl5QA9VWLyMWbCq3IxvNXX2M3571EwOCUYr6eJRRD2GFsEm8pULbJDlvJkID7JNibi0zoL3KO+0YbI5lscFWkuJkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VxXLKjeuUfXGFnmu/XOWoPvkEANkl+2Tw+Bidk8Tj9Y=;
 b=mIQavfGx2027J9PwMrW7fn+b17oTif26ldTcyw19w2Kb9LeaByC6c/TqvxpihTbydYA91+SeG66mp6wLzFu2ifWBVUG/6q2RE9UA7v1Fmh3ZanNwQs/EN7y+YzKHggZ95kE37NJbCd7JA1aWJAZ1fqMPyMcImH/IrG9tKLrNFdut1neQ3NukTd2/5DMhfqrhUnXJWn+tWPDfDHDlZQ0rzvBHvBFI1xbgTD/MXKsy+WyPTsCbbvBPuGt2lRv7SK8j0h/Ds0VjT3IwTc/uqpjET+jrwGIOAK4rOkyXEVVRpZH28IdJ46LZ5BEq+giU921cXWHYGsBgeFk8OiwvUeOliA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VxXLKjeuUfXGFnmu/XOWoPvkEANkl+2Tw+Bidk8Tj9Y=;
 b=wpoQbO3DfTyVuMfbz1XC1HF7+2AlWmIAjotous26vGD5U5z6knl+w+h7iBoc5q/byX3Jez3E0jTr1rui7CCaToW8iIWz4wyE3Hv5/HZzpSFsudgm0h+UMWdxpYw7wJrkz1gMObKRwluk9r4eXozgno4IkXFrj6837oVDdGrPhto=
Received: from DM8PR10MB5416.namprd10.prod.outlook.com (2603:10b6:8:3f::19) by
 DM6PR10MB3691.namprd10.prod.outlook.com (2603:10b6:5:157::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.13; Mon, 6 Jun 2022 20:39:15 +0000
Received: from DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::49dc:6a95:a2d5:fc08]) by DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::49dc:6a95:a2d5:fc08%5]) with mapi id 15.20.5314.018; Mon, 6 Jun 2022
 20:39:15 +0000
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, mingo@kernel.org, luto@kernel.org,
        tglx@linutronix.de, bp@alien8.de, peterz@infradead.org,
        ak@linux.intel.com, arnd@arndb.de, jgg@nvidia.com,
        jon.grimm@amd.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, joao.m.martins@oracle.com,
        ankur.a.arora@oracle.com
Subject: [PATCH v3 21/21] x86/cpu/intel: set X86_FEATURE_MOVNT_SLOW for Skylake
Date:   Mon,  6 Jun 2022 20:37:25 +0000
Message-Id: <20220606203725.1313715-17-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220606202109.1306034-1-ankur.a.arora@oracle.com>
References: <20220606202109.1306034-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0176.namprd13.prod.outlook.com
 (2603:10b6:806:28::31) To DM8PR10MB5416.namprd10.prod.outlook.com
 (2603:10b6:8:3f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60fac332-1480-4ec5-aa42-08da47fc9f42
X-MS-TrafficTypeDiagnostic: DM6PR10MB3691:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB36917CFC47B6DA91179BEBB9CEA29@DM6PR10MB3691.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vAm0C1H42b1Ohuv+nCsbadx4fH3djyClnbZtSDdU/S8LQZ6gIMIy0u+RxBce1sxHeDknBDM5ieMOX2e/+3RmuR8kE3E12zrZ/m9h8J90VSU8tzsbfxOlz4VfcbK7xJRRn/gFPGpP6qCliZVRLlQRPmtUlwk+MzMAbBsmnd1HSYhsQtrxkSpI/0nAywufLwLxX7mQNcNiMifmx3ZHGfXks1srY9FeAxwB8YOrVq7rhi6HO2avDQFpGs0HziAi2ho69vJ4PFDvykRDEW8g3YaD5XGX1rqWuwxdeg2AxPMIH3TT3LMxFc58UvLE1Dwbo04gRlqMOwvNkDxJOPm5kkRAcczpNWW9ZAyjkHF2zO548A1215MIDKJgVVOpcnQRYRo1Tj3L0X2+MUxZlSCiQn7ugUTJBxuq0bfO0qxWX9G17unhGFqI4ZTm42Nu7KhKVIijhEE2WKA8WinYRHGhkYLXYjivqqXPJDFOvZVtMBFrIPHh/GJ6q1r4NDT7u92cVLRTQtrZ4M9dWNTXBz2NSBHaufh+JB/nHhM72FYY87aTgt90E1larNqDYOER1jpnW4KhnF8AYmr5bUvVwwjGYMYNvqz0wiRZd7h8CD8P0g8KQA0FT5NtlYAoGYgHNsGM6zioS2JC++EiVwb4u8WTimuyw0JnWz/jOnLBjc0o+05lsMl5QhaylxQL3zy4SODVmzL87pzcg417cMHLQrPIQ785eQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR10MB5416.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(5660300002)(2616005)(508600001)(8676002)(66556008)(7416002)(36756003)(107886003)(8936002)(186003)(26005)(316002)(1076003)(83380400001)(6512007)(66476007)(38100700002)(38350700002)(6506007)(66946007)(52116002)(6486002)(86362001)(4326008)(6666004)(103116003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2vYNDn78uWcO+ivRCCEFMFf9ZMV8f12zzpfHRko3VmsN6D+YEUaB4AWnp3gW?=
 =?us-ascii?Q?3iVJ4v3Pf9f+VM7EY5N1x10Lpm/RnnjmSQXZQd1Fbe2jKhkDXVC9cuuZ4be+?=
 =?us-ascii?Q?wnQUkPNrXg2/J6ZZy5+ibyOlfWcP4Bkf/XJVvf+5ZMUCxG8OCi9SjO6l+opk?=
 =?us-ascii?Q?QbY4+1Q1tijbiCIMlEkT8vTXrBVWNvKpiaCIwy4XnbozTf3Mrivv+YdtASdZ?=
 =?us-ascii?Q?RQ+FpiMX2TTaglg4tIkVul4BCdxt4ohYH1WjAQYyf1EMQaUOUgZVj4hUY+iL?=
 =?us-ascii?Q?H8/Lq85E3No1qQHRftTU9+rWfNbWDqIhym3pjknVrXxZ30E1IxyG7cv1mrRi?=
 =?us-ascii?Q?1cM9UpZMbJB1qoX7i+yTMfh8aHtX0cHzbXFNoyzYKPmfPqIFWHt+j3IplMpZ?=
 =?us-ascii?Q?+uOUEiaMdJYhikY7BHXlD13YwGfjHb5L+xJX9GDQJ84R/9OGmI3jJ9ySNmG9?=
 =?us-ascii?Q?HmF2xZoeWkisJrg+pr5v2GXzFtdJ6f293xtEf7kLEXh4SaabDvpaxO/feIcN?=
 =?us-ascii?Q?v+hMa21hbUawXBF8dho7uD+8k6+fLzbtZMNWmGJER0Jakb2Q0u+jwn6GLXQI?=
 =?us-ascii?Q?+d+EDMOkjP9j/4dtvpULO3SpvdaiDxmBO1R3kSNqkUE+WxEjgETBiVjcRssu?=
 =?us-ascii?Q?xfvRtcngJAy5HiYNV7lq4EuBj5GESiHwI0jUxbmqILNKjFSkzrucBKCcCgrB?=
 =?us-ascii?Q?QDGu4yphI2ehUKgVRkL9aaY9D46rhCTrFSYj2VvTPTXwJIkp/b4cvtRSz5PF?=
 =?us-ascii?Q?6rDUEd4fUuQ8gMxOTAvwnIl+q+DuFBaEma6JJxQqeCf/FLroT4F0qhauCCZ2?=
 =?us-ascii?Q?PHgoJ2sm2kowNDh/ZW1yCJEHvfI9pK1sthPaPZWb4Tc2zBKjQzGQsvdVVeD3?=
 =?us-ascii?Q?+hJcniZ0Shtuq6glh0ShlM3sVsifRPX7xyv3pbqqiLUCWanz7/dcjrw2WJ2B?=
 =?us-ascii?Q?u8XfQwdT+QVoUyL6P3703f4yjUd0d3KghUinyouaDPoWTyAbZeffVypd9FuR?=
 =?us-ascii?Q?tere6A7tsV+h6dCbLPLHlbRwUUHHKkdcsblvOQ4UyeaCSq3oBqXVAPTg0B8W?=
 =?us-ascii?Q?YF4NMxRdOYis+3PDmKZw8W28WEx6n1LWJ3Am2/mT0QBdZjskmzwwsMGzyS0p?=
 =?us-ascii?Q?AvWukaYGotiAC/L3QtWEGS6m1LdjVd07BewkwxU2sqEvTOUFoFsZFNbOLH2u?=
 =?us-ascii?Q?u4eqPAf9GJPEoNwZMIPWBk6PAiEsHOWxfJuYAVbd6I46aPdQzORPeD4em/X4?=
 =?us-ascii?Q?KqMdpKLmm0AhElpb8gX+7vSy/yNFUx/JMpWFdYVGW/w4QFD28UULcFTVpQhH?=
 =?us-ascii?Q?Frz2jefGhKLuxtZw2SEbBmckD1hbc9tARoGKWLWoynudNbJTKkRNiA+lvtLS?=
 =?us-ascii?Q?eyRMM2dWUbqUgu24gi3jHUTNhJqv0BXK+rhCGPLEnNdd1yqXFr/WwSnWtKzC?=
 =?us-ascii?Q?1LVJ4znO+pj1PF6/dwGZkC7sq1fa/fAVum10dccGqKzfcsEOVI+hJb76K09a?=
 =?us-ascii?Q?raq++KRejELced1KlQA93L7X5GsUf9f7SM320Lrd3M3Aqu6tqWeBE7Hm0/N+?=
 =?us-ascii?Q?fDe1IvHyuAXYyTVe5GYjbsbz6pXcMXcrUvPoNpMsezdBDztWGUdiBIP8aAo6?=
 =?us-ascii?Q?KQdgRwQh4coAhUVktcIIy+SaQHnv9lVtGdkyX8JON0qKewoV59s9LUmJOM1i?=
 =?us-ascii?Q?tOXOawWSqQWqIb5KP4AssMqqAICWU4ozfG1P870aXynlrlHUYIY1DpDRGQt9?=
 =?us-ascii?Q?oLNdCVsAbWH/mTneGdon9ZXOHWXHX6o=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60fac332-1480-4ec5-aa42-08da47fc9f42
X-MS-Exchange-CrossTenant-AuthSource: DM8PR10MB5416.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 20:39:15.6560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UjWT5pp78c7/X4sDWovwmWoOV2luxq0g/ZWiKFypxSv4xiXOp3yV81YTXkUOVASPV4BJPCM0nYYeNRS6ytwSBDeIMOKjn1SXwaMjNJllDQU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3691
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-06_06:2022-06-02,2022-06-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206060081
X-Proofpoint-GUID: KLPhswKR-ToVuUfvVO86phz6Mj6nJJeR
X-Proofpoint-ORIG-GUID: KLPhswKR-ToVuUfvVO86phz6Mj6nJJeR
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

System:           Oracle X8-2 (2 nodes * 26 cores/node * 2 threads/core)
Processor:        Intel Xeon Platinum 8270CL (Skylakex, 6:85:7)
Memory:           3TB evenly split between nodes
Microcode:        0x5002f01
scaling_governor: performance
LLC size:         36MB for each node
intel_pstate/no_turbo: 1

$ for i in 2 8 32 128 512; do
	perf bench mem memset -f x86-64-movnt -s ${i}MB
  done
  # Running 'mem/memset' benchmark:
  # function 'x86-64-movnt' (movnt-based memset() in arch/x86/lib/memset_64.S)
  # Copying 2MB bytes ...
         6.361971 GB/sec
  # Copying 8MB bytes ...
         6.300403 GB/sec
  # Copying 32MB bytes ...
         6.288992 GB/sec
  # Copying 128MB bytes ...
         6.328793 GB/sec
  # Copying 512MB bytes ...
         6.324471 GB/sec

 # Performance comparison of 'perf bench mem memset -l 1' for x86-64-stosb
 # (X86_FEATURE_ERMS) and x86-64-movnt:

              x86-64-stosb (5 runs)     x86-64-movnt (5 runs)      speedup
              -----------------------   -----------------------    -------
     size            BW   (   pstdev)          BW   (   pstdev)

     16MB      20.38 GB/s ( +- 2.58%)     6.25 GB/s ( +- 0.41%)   -69.28%
    128MB       6.52 GB/s ( +- 0.14%)     6.31 GB/s ( +- 0.47%)    -3.22%
   1024MB       6.48 GB/s ( +- 0.31%)     6.24 GB/s ( +- 0.00%)    -3.70%
   4096MB       6.51 GB/s ( +- 0.01%)     6.27 GB/s ( +- 0.42%)    -3.68%

Comparing perf stats for size=4096MB:

$ perf stat -r 5 --all-user -e ... perf bench mem memset -l 1 -s 4096MB -f x86-64-stosb
 # Running 'mem/memset' benchmark:
 # function 'x86-64-stosb' (movsb-based memset() in arch/x86/lib/memset_64.S)
 # Copying 4096MB bytes ...
       6.516972 GB/sec       (+- 0.01%)

 Performance counter stats for 'perf bench mem memset -l 1 -s 4096MB -f x86-64-stosb' (5 runs):

     3,357,373,317      cpu-cycles                #    1.133 GHz                      ( +-  0.01% )  (29.38%)
       165,063,710      instructions              #    0.05  insn per cycle           ( +-  1.54% )  (35.29%)
           358,997      cache-references          #    0.121 M/sec                    ( +-  0.89% )  (35.32%)
           205,420      cache-misses              #   57.221 % of all cache refs      ( +-  3.61% )  (35.36%)
         6,117,673      branch-instructions       #    2.065 M/sec                    ( +-  1.48% )  (35.38%)
            58,309      branch-misses             #    0.95% of all branches          ( +-  1.30% )  (35.39%)
        31,329,466      bus-cycles                #   10.575 M/sec                    ( +-  0.03% )  (23.56%)
        68,543,766      L1-dcache-load-misses     #  157.03% of all L1-dcache accesses  ( +-  0.02% )  (23.53%)
        43,648,909      L1-dcache-loads           #   14.734 M/sec                    ( +-  0.50% )  (23.50%)
           137,498      LLC-loads                 #    0.046 M/sec                    ( +-  0.21% )  (23.49%)
            12,308      LLC-load-misses           #    8.95% of all LL-cache accesses  ( +-  2.52% )  (23.49%)
            26,335      LLC-stores                #    0.009 M/sec                    ( +-  5.65% )  (11.75%)
            25,008      LLC-store-misses          #    0.008 M/sec                    ( +-  3.42% )  (11.75%)

          2.962842 +- 0.000162 seconds time elapsed  ( +-  0.01% )

$ perf stat -r 5 --all-user -e ... perf bench mem memset -l 1 -s 4096MB -f x86-64-movnt
 # Running 'mem/memset' benchmark:
 # function 'x86-64-movnt' (movnt-based memset() in arch/x86/lib/memset_64.S)
 # Copying 4096MB bytes ...
       6.283420 GB/sec      (+- 0.01%)

  Performance counter stats for 'perf bench mem memset -l 1 -s 4096MB -f x86-64-movnt' (5 runs):

     4,462,272,094      cpu-cycles                #    1.322 GHz                      ( +-  0.30% )  (29.38%)
     1,633,675,881      instructions              #    0.37  insn per cycle           ( +-  0.21% )  (35.28%)
           283,627      cache-references          #    0.084 M/sec                    ( +-  0.58% )  (35.31%)
            28,824      cache-misses              #   10.163 % of all cache refs      ( +- 20.67% )  (35.34%)
       139,719,697      branch-instructions       #   41.407 M/sec                    ( +-  0.16% )  (35.35%)
            58,062      branch-misses             #    0.04% of all branches          ( +-  1.49% )  (35.36%)
        41,760,350      bus-cycles                #   12.376 M/sec                    ( +-  0.05% )  (23.55%)
           303,300      L1-dcache-load-misses     #    0.69% of all L1-dcache accesses  ( +-  2.08% )  (23.53%)
        43,769,498      L1-dcache-loads           #   12.972 M/sec                    ( +-  0.54% )  (23.52%)
            99,570      LLC-loads                 #    0.030 M/sec                    ( +-  1.06% )  (23.52%)
             1,966      LLC-load-misses           #    1.97% of all LL-cache accesses  ( +-  6.17% )  (23.52%)
               129      LLC-stores                #    0.038 K/sec                    ( +- 27.85% )  (11.75%)
                 7      LLC-store-misses          #    0.002 K/sec                    ( +- 47.82% )  (11.75%)

           3.37465 +- 0.00474 seconds time elapsed  ( +-  0.14% )

It's unclear if using MOVNT is a net negative on Skylake. For bulk stores
MOVNT is slightly slower than REP;STOSB, but from the L1-dcache-load-misses
stats (L1D.REPLACEMENT), it does elide the write-allocate and thus helps
with cache efficiency.

However, we err on the side of caution and set X86_FEATURE_MOVNT_SLOW
on Skylake.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/x86/kernel/cpu/bugs.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 16e293654d34..ee7206f03d15 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -97,7 +97,21 @@ DEFINE_STATIC_KEY_FALSE(switch_mm_cond_l1d_flush);
 void check_movnt_quirks(struct cpuinfo_x86 *c)
 {
 #ifdef CONFIG_X86_64
-
+	if (c->x86_vendor == X86_VENDOR_INTEL) {
+		if (c->x86 == 6) {
+			switch (c->x86_model) {
+			case INTEL_FAM6_SKYLAKE_L:
+				fallthrough;
+			case INTEL_FAM6_SKYLAKE:
+				fallthrough;
+			case INTEL_FAM6_SKYLAKE_X:
+				set_cpu_cap(c, X86_FEATURE_MOVNT_SLOW);
+				break;
+			default:
+				break;
+			}
+		}
+	}
 #endif
 }
 
-- 
2.31.1

