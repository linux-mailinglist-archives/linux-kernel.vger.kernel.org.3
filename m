Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECBAB4FFBA5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 18:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233492AbiDMQqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 12:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237024AbiDMQqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 12:46:11 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86BA968FB2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 09:43:40 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23DGRiu9018439;
        Wed, 13 Apr 2022 16:43:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=x3TulyQm3Ik2coGCKeCYOQNjm9LxJfcaSfr652uYxP8=;
 b=XIMkf2R44N0G2E9NC1v6Uyn70mAM23gUoYGxGRrvD+1xmMv2pBpThMd+bYzCCPVj9HeS
 kzNits6QGsJfwp97NBU6Nffo/T68dgBz7UEboWYYttz3CG44GGeJLFakSTqEHCN/Rhwu
 R2UiPmL0Nf48RDgMAnDPdMKspGIu8bGo/QNl2TqHtCdakbHEBeCxogHUpDvt5Ul7grIj
 0oTBMkHCIPC4JwS8GTfnv94d43MZJCdkhjIqbOpMKTF8cM3F6ufwbBHWr2+4GtiU8tWP
 2NPmHFSZtZz4u1xMTGMDFpbQSbiDaKTL/HG8GGVgCnBV8Hhqib8onknp/J9MDDzpENMm LQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb0r1jkf7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Apr 2022 16:43:17 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23DGPTcx020981;
        Wed, 13 Apr 2022 16:43:16 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fb0k4k9ma-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Apr 2022 16:43:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FEnGVNn9Gs88wf9fw6kNNM/m0s/l1PtDyEtIxPKxeUxndi1LErrM5DFFRw/GI2zABn+3Px36QjbobXsLAs+rEzIZ2zHi+NJnjPHeRIs4JNc423AJ/hX8IJYTsxq0LRfHRGxRpDN6HMt8S2PMSHPQNhvHZL3lJKWvnEOHna1hjo/us4w7W/M6+bmHw/z03LxF0Bf6IBQD6IPKyFV2m1m0SozPpeYcy09fR/HNLcLbAi3ezCR1WDu00eecFbdNMfAfDpSs/tO8elqMWiYvnsVHGlbu776mMA1rzLayP7t/asWH+e75u8dCvjZ15kjPH5MipY4MHncsPdWpY8hTAT4vKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x3TulyQm3Ik2coGCKeCYOQNjm9LxJfcaSfr652uYxP8=;
 b=aa+HBdCMdl061JU8kEC1Biyuwq0zgh8nJqn85Bv9uBkdpRjnDZK/XG3rnXUClzFAtP/t1Wx2SmlpQOal6Ct1eLV0I1w5LxQqGlzC1DcYxICpgR7FpzEyOnPz5k7RG1Ngbtfc0x5oZc6x67LUmWDT3jyWfMqiXmC0UnQXKpFufNJgHBJ8Sm7eDtY8P4nwB/uWKvn1+2nOZbG1TDQ5jMIQyKF5/zLsXAZeHvNE1A7usWNsMzKAJ+t9M0VVnW2QQtgrGPVT78wtGASghUcwbAmoID9+avGoB/KpDPV/aI5m4FsY3aUC1niY0JfutXOQ+wCLjiXfrPstEYVzjmbCz21cbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x3TulyQm3Ik2coGCKeCYOQNjm9LxJfcaSfr652uYxP8=;
 b=vThac6WCSUQV3il5iGVo5KYKTyxc8Nes3W+k451WAK3VXGhcGFqyKTG7/Bp20T/Y1J6bR3IBfP6MX48HgfIP/bTNH78ARNOurZTUsJPvBNlgCeE/8UtpKRWSJP0fMfyLL92LQlcqSKFHXBX0GdJVSUsRHjhRSLAgOtju0q4I0wM=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DM6PR10MB3562.namprd10.prod.outlook.com (2603:10b6:5:17e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Wed, 13 Apr
 2022 16:43:14 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::65fa:78de:f4d:1a5c]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::65fa:78de:f4d:1a5c%3]) with mapi id 15.20.5144.030; Wed, 13 Apr 2022
 16:43:14 +0000
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
Subject: [PATCH v7 8/8] x86/crash: Add x86 crash hotplug support for kexec_load
Date:   Wed, 13 Apr 2022 12:42:37 -0400
Message-Id: <20220413164237.20845-9-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220413164237.20845-1-eric.devolder@oracle.com>
References: <20220413164237.20845-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0024.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::29) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 738ad679-4d54-400f-c5e1-08da1d6cb445
X-MS-TrafficTypeDiagnostic: DM6PR10MB3562:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB3562859C82B761E13011803797EC9@DM6PR10MB3562.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MQiN4Xrn+ZgTB70H9yZwHiL1kemr7XzoxBhOTUI2UfVKaJcQBalgV4pE06V2Kxjf9jI748757scrsUJzzZRmUgclTyjfaZwyk3CP9jfbssCe7iG74h79wwo5zNdyVgKRfy69D1Cmvd1LHXLE1rAfESfoHfwD9doWjJNe1pNDzpQ9fvuRgc5DFO+p6VvfvgTolNNE2M9cgztmeyz2tpfGq1EKYwr86bxb504Z22V9SLU74/COyph9VZIsJ7fqFXBk5X3fMdP8HnUe5TzlfUhcMlijXexdDjcbJdC4VTsvQlEU9e07DiLNz4/u19NZ9rSgYoEQDM9JwHl8WxHdUi6zpeCzCfzvxahDdxL7TDvlBq5WQqI/Sggh3XZMRzNxpLzhWN7yX6OqpnRP8Rk7dVvCjCT2nVOQOEP6Xs8SBfYuRGGSUSzbmWX8C8TDFvne5Xv80+UIgjPGCS0FXcNUDTL89kweklhImBP+oMAHyJqEwzW8AYM60rojSzXRyPRrry9iqkyV/SsST+r52Ou0S8NheBMcOjDU4C20SyPD1f9WfIA0K6rAUuOO+tC/IEsQvWYcY1q1WDCNilZLHO+lHDqdq5qN6rWQ3XQzzyiDfxar2J/QRC4sY4Rz6S1OH5K26+cfoBstdS9MQKTRp1k6iJKShyUyjmp+QNee1wkXm8d72bmqt/xONGXvpWCL0tIoBl49N7PS5srOyO2YnRmUFCpK7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(86362001)(66476007)(66946007)(1076003)(66556008)(8676002)(8936002)(7416002)(52116002)(2906002)(6512007)(38100700002)(38350700002)(6666004)(6506007)(508600001)(316002)(5660300002)(2616005)(107886003)(36756003)(186003)(26005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2Xa86XEnbOaiB3ogIwK5KLBZV9PsRvkLIliJ7f/dPyhzt2MGW2bQO1vTRjqI?=
 =?us-ascii?Q?6DE2i2QWOTrLiB3w4eJAwvl7sTsFVJXWzFDWyqVFWAl9v+IhNPJoSiv1PK2r?=
 =?us-ascii?Q?TfnZcWogwY393LGn5fujMuKZ7kGimRN3FoiiggbZ5wHQnnzs+46rQtUcNhxn?=
 =?us-ascii?Q?tawF41oj+0YnZxTC9froSGXpWHZvSOvK2uij9xelvKaMGvsq3WU+HqjE23Zr?=
 =?us-ascii?Q?axvYyPhhtCW3W++KjksBIw70sb31D0i+w+UhZ4eNIMbRZO8lce8LcE60qS1n?=
 =?us-ascii?Q?bJoOlTYdpK6H+DryCVg76LCV3nl1uguCkUPgwPccdyW6AYPqgSYSmgcUVid4?=
 =?us-ascii?Q?xjSQ2itLfsltkJ787aVDYNihe/DVGSf3GVTqK5BdGP1lGg1bDxHtkuRsLcv/?=
 =?us-ascii?Q?Rp2NFya3OiZcQ2G7XfUmSOVlnZ6HImnzfom+CLg4cmeYtqs2Fpywd2HEY5TZ?=
 =?us-ascii?Q?ELYmEwU9A7hmD45RPsiZoKUPC7wCIvnbn9HjUegEUN1n8OZoe+IrqSgRsEBE?=
 =?us-ascii?Q?yZeUsjRrykBwl4hjzhbk5OdypzQVe1aNc5R3scJ3wZyyOFf0ZNWcaRk7XJC9?=
 =?us-ascii?Q?o/va1AB4Op4AzEKYfeF9y19CpAFk0T+FOww+dehN5+UOlZWxywOobY2ZietX?=
 =?us-ascii?Q?xMQtZp//zbVmV53zMIousBplx9oizSoV9Pmn6mRqgDM/mRJ92qFh/eXHW9LM?=
 =?us-ascii?Q?nDwIUpnyipUnZPeIvw+PtES4Ek03FuliNkWWJj10LGGlBg9fXfwfuSvdKCYJ?=
 =?us-ascii?Q?mZsEVOhE7rIW1C2lWbStqIkozH9Fufr6/GHAJ7aigX+1SFqa4xXpEStFR+rp?=
 =?us-ascii?Q?4B6NGjOpEZwJwL//daIDsYj1LUdMTD9SacREHLT90rvL2kAlLMKaU3RT9mgV?=
 =?us-ascii?Q?aYHFZvALr594ExTKG3Fx+XLdoFycgI0sPgdw840CyB+B6+JsqWuLo55RnN1l?=
 =?us-ascii?Q?hVPmWgUQMCFrni8g1yYt6UIdbcSfVB53tDaHh45AxktoNQkX6rXgaKCyhqLr?=
 =?us-ascii?Q?bDY42RmGEnT1nVhR7ZzrkGotpOtD+WMZxXatA892pp6+ejTv8ASrtKAE9POV?=
 =?us-ascii?Q?k8+6YRM3QMIxQa6BXLjtepM91BZYM8QKODxoVIa0dA3kVVooXnqx+NBdtV4u?=
 =?us-ascii?Q?cN05C2jZDN+3oaCJ03Lnn1+OKRdyfwhoIdbt6ZSVTCQY+7UPggLh6YUXk34l?=
 =?us-ascii?Q?qXipQqEWq/1BBBmuyYBeQQGVAOvJXS1TCq4sND9h+YoHoPKFz3Hqr+AfxjQY?=
 =?us-ascii?Q?6BxVDiGusWIenDthufeQVPj/33mHBjSB7mTuE6N7ntoWcrq7/84Bzih/qND6?=
 =?us-ascii?Q?DFl/wDXdr7CUT5ag4gSfbo3vDEWPBrgQGA+xsErF7AZBug/hVoFig38dw1o8?=
 =?us-ascii?Q?5PSCqMfmZHE9TDRNQYOdPLuMwlCfs06/ESem+79qxH3G1f3RndWU9S2qx0g9?=
 =?us-ascii?Q?tVVNg8r8r19TUVJC0Bp1NdyRf8TyODNTI/ZIn8vcUFn6NLNcgqWFeKu/YayU?=
 =?us-ascii?Q?aNdr8qIwJVelGdV9SxAjw8q6i5QVHrRiEMetHASwWLl401IptCvpxZ4ftRSf?=
 =?us-ascii?Q?97HQfKmIoxU+WKFi79bz/8UX1kGzrDdmgi9Rm8bXRRGkyjxiuWnWAf592gv3?=
 =?us-ascii?Q?6fR/puzZ7LFBzGTuUjOCBZUPeRiGRDrq0Y55WTCphAeTAgOtPaWLVFLJiN9P?=
 =?us-ascii?Q?aLM9DwI1QLypQWaR3uPwzzsHpxC4ZLTekLiDTenMMEo96YFtBP4N4MVrV+6n?=
 =?us-ascii?Q?o43vkeglrrhMLi5uM0x2qM1blOpjVDw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 738ad679-4d54-400f-c5e1-08da1d6cb445
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2022 16:43:14.6819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AKPVykerY6vNeflr24ZBzk7KRB4Wb70zNIk1nREXcLQFZpcOoGmEk3wyOjpksveh6r7ZdFb7jIVNTnvn5YgHmZaT0OD1FOLKY5NpqMHeQ98=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3562
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-13_03:2022-04-13,2022-04-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204130085
X-Proofpoint-GUID: c4AKapGgLogrlKJYropA2lvGsNRnRDte
X-Proofpoint-ORIG-GUID: c4AKapGgLogrlKJYropA2lvGsNRnRDte
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For kexec_file_load support, the loading of the crash kernel occurs
entirely within the kernel, and as such the elfcorehdr is readily
identified (so that it can be modified upon hotplug events).

This change enables support for kexec_load by identifying the
elfcorehdr segment in the arch_crash_hotplug_handler(), if it has
not already been identified.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/kernel/crash.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 47adf69c9f71..aa2d9680431a 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -485,6 +485,30 @@ void arch_crash_hotplug_handler(struct kimage *image,
 	void *elfbuf = NULL;
 	unsigned long mem, memsz;
 
+	/*
+	 * When the struct kimage is alloced, it is wiped to zero, so
+	 * the elfcorehdr_index_valid defaults to false. It is set on the
+	 * kexec_file_load path, or here for kexec_load, if not already
+	 * identified.
+	 */
+	if (!image->elfcorehdr_index_valid) {
+		unsigned int n;
+
+		for (n = 0; n < image->nr_segments; n++) {
+			mem = image->segment[n].mem;
+			memsz = image->segment[n].memsz;
+			ptr = map_crash_pages(mem, memsz);
+			if (ptr) {
+				/* The segment containing elfcorehdr */
+				if (memcmp(ptr, ELFMAG, SELFMAG) == 0) {
+					image->elfcorehdr_index = (int)n;
+					image->elfcorehdr_index_valid = true;
+				}
+			}
+			unmap_crash_pages((void **)&ptr);
+		}
+	}
+
 	if (!image->elfcorehdr_index_valid) {
 		pr_err("crash hp: unable to locate elfcorehdr segment");
 		goto out;
-- 
2.27.0

