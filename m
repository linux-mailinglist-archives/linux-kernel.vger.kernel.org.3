Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37DE057D32D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 20:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbiGUSTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 14:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbiGUSSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 14:18:53 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF988C74D
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 11:18:52 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26LIEnox025443;
        Thu, 21 Jul 2022 18:18:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=pvpzRPUcjzD+1hPbi9dDepImbson8+sv+CQittspkE4=;
 b=xwQuDq1dXCshEA43Ls3U76qK2PW+9crc9zlCzjTHicAQg3gnK9BuRzWmAsuHhPZsa62e
 dkGGZPNudwiV4ByPekwRxtGwmWjClQbWRDRPHbru2ncFVkuG4ugROuLdtcfrltfl9Rl7
 VO6t+1pZ4V4rgfA08byKlZ9bttkWXGpqGubx/NeYhuNpgC8T9cNHolYA1nB56da+Ul8a
 sllIIw49PZdwkb31wbXtwvyyyVppX5vnHQV1oNQzgQRoR202XDxDmYD8GAhMfZQvE0KY
 cPiA7wBq5TEQJ6tdLvuhugA1er/qpNc9pDWyL1p4rV6bz0JgFICi5gJDTV4TF80OREA8 Aw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbnvtne07-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jul 2022 18:18:25 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26LHlfTu022155;
        Thu, 21 Jul 2022 18:18:23 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1hu6mn6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jul 2022 18:18:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JTD3xnJR3E5ah76QRVSHVZXNg7T9KJSqbAHVtaIhwlwPWH/p+l6YbcjzlySUXJyW+BLugrMHrA23m6744WVWNTkCYaNryirJRQ9l3LI2SVnai8ugzQV05ZNNSuFl5ZmEs9ZCTcSUzm3pKo+6oje7BPGt3D3gDds/lk4BMx4lNotzz7KibtaQXy+fnKjMAJc1zqHI31Iwm9Y8dG/QgFncI09C/V6H/wqDUyqksq9B2xM5MFta3iAtls8jXujVewB6emWiej1OWS89oFqrXixS4oNwP9V2gTlbHIrpfbnK+tI5nBOF3b/OAAfMPNacIbMJtS9Hqfl1dX1nHl0emT9FWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pvpzRPUcjzD+1hPbi9dDepImbson8+sv+CQittspkE4=;
 b=B3zp9WELT5briH6MVp6a/Q9qNgL2ExKLPRM1uBuO29S1vk5SlJpBowfxVVNLDG4eo6Hu4y8oIDv/7bHN2swWuQSj/vZVqS3bvQUb7E6VZy9WwkKqFVM9QhNbCMx+tAGycOs5koqG43ocKI7QL3o3yNrtwFPssjYhAhB+S6FIXQ187aAJGpL0i1ijl3VpuQQVKPaShtmXJhIW3iqHxgcIKqZ5i5gLz7OAu3sDZkHH0p7sPTeRhIv8S598RYuUAPBR1YLsp5iatjz6GPpopCM5mUEgwJAuixcO4hytfX3+DlboG/s6ToWQL9sW9PmZcvvk0wl/jMWkgQZWd2SzWHUvUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pvpzRPUcjzD+1hPbi9dDepImbson8+sv+CQittspkE4=;
 b=vMdurqAiJei1nv3enDEYH06my3cUHDIe+zS//3MS3LCkOfdIBhm+rMDZb1uWN5gyypEmFqL6/fqq2gafB0fd8/pKCjjTuS8QCHO2Ja2WaPUDLa6cB3ZbUkhZxEnH5s4YFc0QJ8Yveake8XwQJxSaEqloYZflhZOpDkd0aSPxN0Q=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by BY5PR10MB3986.namprd10.prod.outlook.com (2603:10b6:a03:1fb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Thu, 21 Jul
 2022 18:18:21 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::747b:31f7:db5e:9e0d]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::747b:31f7:db5e:9e0d%3]) with mapi id 15.20.5458.019; Thu, 21 Jul 2022
 18:18:21 +0000
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
Subject: [PATCH v10 5/8] kexec: exclude elfcorehdr from the segment digest
Date:   Thu, 21 Jul 2022 14:17:44 -0400
Message-Id: <20220721181747.1640-6-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220721181747.1640-1-eric.devolder@oracle.com>
References: <20220721181747.1640-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0189.namprd03.prod.outlook.com
 (2603:10b6:5:3b6::14) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5560c573-2336-434e-307e-08da6b45648c
X-MS-TrafficTypeDiagnostic: BY5PR10MB3986:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XbuK0qSUeXInFsFneTjPtNXpBOMXfT7NDx9oagw4Lv/zGa0ZdDxAbGWp62nnvJnkAbEE55aJNVI1JySPbrP6lS+WOHAGSfTcFXIkTB7p4NhOmKdCn34m47gufeUz3BKP9vC+uKoBv2vnF6dk9ilin7rglEo+BF8v67V052dX+KvpDjeLxRgtaWRGM7HwQ7+VBy3iqXK6qgQbEJWm3K2pg7mImFBKo/rqltpNIzZ3CRn2+bGo7A3JGyixzir76CkhYdSVMBGIVdq/cZcx/aHBbTeKgBRX+Plyya5DjVMy1c29ygK7O9KczqNx+8i2pkNw+8os5yYb9kBVZQ0IoFVz0b+NyKzwSrV+7JED8E9q7yQr3doTjuGL9G8zFMmOJBFhSPhLCxGaDXCWGh8vxaklJcadJ85v115j/oSarMPKGiBwQHz0ilS3MU2EgUceMf5oiQUY10TMc3w+jNkkI+09fA6Rp9qqaZaKHUQQPWGz6YZEueGGLDLl1NwZBZpo1XWnU+kUT5uIhzd3bM4s2C5D5JA3fb9AkltzNFIyfsIMJzzjaWeF2/X4cE7lpn8Pdu1ViDpjQwFt4E5+KGjGQVNDJhIP9p9Ytyj5Ajjz3phq7SeHFRWTrftwG9GwNbeq7NZ2/Ii3COV8exZgTk6+HvJOUXq01klXi/NYLUm1Yaw7Qtqjgsdl5ZkhiqQDVig3oaLzCUm4fxzkxQNkqhbs6hl7AiqlaTDjeBggl3lCZ2g3aDnwmIraWj+9cT8E5fVR9CAkgx0I26HChIazv1TliUadoni+jbzudtVpa/N+n1IR7Y4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(396003)(376002)(366004)(346002)(6486002)(2906002)(6506007)(38100700002)(6666004)(38350700002)(66476007)(66946007)(52116002)(8676002)(86362001)(6512007)(66556008)(26005)(5660300002)(1076003)(107886003)(4326008)(8936002)(36756003)(316002)(186003)(478600001)(41300700001)(2616005)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aGZTePRUYx2edlOK12U6fbcw3OuBjTaki0WlzX9w3fjCNpXVT+xHzyklD9xl?=
 =?us-ascii?Q?mCt6hrs+J/CKHpXGnaocB9zZq/LO55ctGDs1pmj9sDSf3/OBB2ERyhAvLbin?=
 =?us-ascii?Q?8LyFgESdR8zZsjFKo6bCUeoYQZYVtXwPKUtgQhZwtCBPDF6tV8EVxPztWoui?=
 =?us-ascii?Q?jIhgsCqPLmNSkn/X/Pu515f4IPjKDjsJil6A0T/5m6xE2Q3aNiddo8FUIf0p?=
 =?us-ascii?Q?SOTt5YxaL5LPNfvcUJ+dfjtBvO79QtfQ+UjPGKTHBbbsKWZ7Db4B4VFo+taA?=
 =?us-ascii?Q?L3vOQ8GUtAASiBQVNu2n52e83v8hLPjikZLFs36p/+QCKN0+Onph9TgvNZSu?=
 =?us-ascii?Q?YVeIFhVlWoyRhFDFcC6oo1us1/fa9vsj2lFCyjEy1/tzft6YsMbDKpsBCWtx?=
 =?us-ascii?Q?2e2SJbbLTN9VFBPAVuEzJACQc6sBqnnaLMWDq0V7qo4G6F8hfqPt+NQq92ZP?=
 =?us-ascii?Q?85OPkf8CCkzyz4Bj4nAZtEsVr/HNhg04O0qOlDS1OdRvaYMBRIWURNn0VabS?=
 =?us-ascii?Q?U84UkeHaAYst8iJ78CYvDMAhC8kNbzE+ltUSIFPkSO/VFBmu4lEkvlNx6LTS?=
 =?us-ascii?Q?0bTDOkp+VzSh9NK32elygPQbp0TAWK4/JsO6fTspXB/FfzniZn1zELYwF9nl?=
 =?us-ascii?Q?U7+bLszOBA+p2+OZ5JugTyVaWPHRctJYXjuEfWmC05G9W6mGYXnjPMciuCx/?=
 =?us-ascii?Q?leId6YhqZ/vlJ3I23uaZHm9DjEVtVGiaNpiuftArAlr3T7RDf2JjuXvKESDC?=
 =?us-ascii?Q?+9tiPHLpy61CzwJ3wIctUKI2FnIAIbySIRq46XUDRLAUtx73kiv7zp5Wovyk?=
 =?us-ascii?Q?jrIdWHd8GpJWN7jsn7Lfxy8Rf4Lgubf0fTCUp35OrMPqpvb7CH4oeRCsfLlf?=
 =?us-ascii?Q?O3v4T+9/W0CRs8saUjhgwfgnUh6UY7tDG7AtuJIqN0iEaM2nRc6sTHgIE0rt?=
 =?us-ascii?Q?MXLcjA0kZYhpfesekjX8TlEtjBySEGqrkZl64DkU/w8/dKpnX6ZZFYjT/fCO?=
 =?us-ascii?Q?qAHumj08hm/TwqZas9xIggUgtWKQdufFgrMrakjPOJ+K/bX4JTwwSd4bnLaz?=
 =?us-ascii?Q?S9RiHVj7N8eH8l5yxFOXZP5Mc6HutRjQD7ne+xN4GWHcWTUNuSSurJL+aFPi?=
 =?us-ascii?Q?J27XhHMBWfaGpONiGPGJ7fi0lc5Yv7GBPINsIzfXEHwDJjki0ir+bN3XT9ze?=
 =?us-ascii?Q?0c/DvgKR+gKPsB4QyMCS7LZhVSOEFlx8+d2k/raGLxM51Da9/gkB7xO9P9ik?=
 =?us-ascii?Q?jUfFo9Nz+wMWmW3wY82hOU3IgDCD8nbvFr2v0bnVjv85BKdxthd6Whth5y92?=
 =?us-ascii?Q?OfObLdc3Y+BxkcB5JboJcFIo/OkqRgI/qK0mGIWbDZJuCK7znqqCfdy69482?=
 =?us-ascii?Q?F88zr1xgaZ/YufK1csKb4X/6RIIEzlJRgL+eu66s97EwCL53qVGYr/HnUe+I?=
 =?us-ascii?Q?JzqrSUr7aDyWcbfl/enbS0W+riFz1Ih3/aodDaTzXb1mKVclIG0mxQ/klnHJ?=
 =?us-ascii?Q?IKBG0fBzCfIcXSLHZzf1ZK58sICOIedhNzsL4CFgQezfg5H2tzyzVi91bbrf?=
 =?us-ascii?Q?xZ7d8VoYWda5RQOUR2118jiXs5btQPfVollpxD8RFr4D8tqxqY3bB4V0gODg?=
 =?us-ascii?Q?5A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5560c573-2336-434e-307e-08da6b45648c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 18:18:21.1889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zBD3Ysi1K6pqyxcVEwgO+VYOXD5KS9xA1hzflnpEiuduVbVfSzhfyLW1thj4cMV0Cvxw1jlQhYsXFpagYJnOh1QGm3a6Pm3V4T7xF8d5LFY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3986
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-21_25,2022-07-21_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207210074
X-Proofpoint-GUID: aT46Ck9HfJSFJ8lL8g2_0N1gwX7Npyr2
X-Proofpoint-ORIG-GUID: aT46Ck9HfJSFJ8lL8g2_0N1gwX7Npyr2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a crash kernel is loaded via the kexec_file_load syscall, the
kernel places the various segments (ie crash kernel, crash initrd,
boot_params, elfcorehdr, purgatory, etc) in memory. For those
architectures that utilize purgatory, a hash digest of the segments
is calculated for integrity checking. This digest is embedded into
the purgatory image prior to placing purgatory in memory.

Since hotplug events cause changes to the elfcorehdr, purgatory
integrity checking fails (at crash time, and no kdump created).
As a result, this change explicitly excludes the elfcorehdr segment
from the list of segments used to create the digest. By doing so,
this permits changes to the elfcorehdr in response to hotplug events,
without having to also reload purgatory due to the change to the
digest.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 kernel/kexec_file.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index fdad056d5938..73d81120c3eb 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -740,6 +740,12 @@ static int kexec_calculate_store_digests(struct kimage *image)
 	for (j = i = 0; i < image->nr_segments; i++) {
 		struct kexec_segment *ksegment;
 
+#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
+		/* This segment excluded to allow future changes via hotplug */
+		if (image->elfcorehdr_index_valid && (j == image->elfcorehdr_index))
+			continue;
+#endif
+
 		ksegment = &image->segment[i];
 		/*
 		 * Skip purgatory as it will be modified once we put digest
-- 
2.31.1

