Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC7A5A2DA9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 19:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344935AbiHZRjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 13:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344798AbiHZRi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 13:38:56 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21606E2C54
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 10:38:54 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27QGUOQk006856;
        Fri, 26 Aug 2022 17:37:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=sITWZr9vk46+wmOamn5lc0oiEdvj6F+xBRDcuSObS8k=;
 b=r7fODzyegk4vv98/dn+hbK3Ih5honIz9fhm60vsWsTEhbbB2xG+6O7LbcBbL/XjXnMAT
 m1kYFRFhhcxXOgxxTBW53zeWvlG8nlEa9n+QvcA4UhfNM1r9S1lUaxURC9VqlgSe1W6G
 cf32pYHxKb5RxXz20LHF6BKvUDW1pXGqE1jflNAGa5Q1Zw4FEQiDty/PXgfS2NdQZuN/
 t9yu6eQAwUWgHweQHmYOQ3seiQ6/dCN1hTdAeRk8bMLu3lsPe6tPbeDLjQqpbVpgOxhY
 mu9FtfTTo96grgaodo6+5+r5zBXL7SAupX2VnEwVtrOWpa4SjPYr7gLOdazErUiRTXW1 wg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4w2429ew-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Aug 2022 17:37:22 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27QHSVUg029801;
        Fri, 26 Aug 2022 17:37:21 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j5n5r404j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Aug 2022 17:37:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OJnwUVyNthfNTOJRw1pLYm53CDsVx+iycciXcJ1PIFhsuBcIVnQxoAf8SkoTir4jADY5DvzvOx1CXZpQ7xBjZ9pI4mAyA6/Q8N1F81hbohJNH2yawm8GNUOGZspXizPJNW2lHaJZnraTwjKFpHh7V8XlCTp6aEqrgltaZRMCmnR0i43iyiPpT4k4f7sEo1V+b/Itr6WmXo9coM2ksBpdjk+DPtkoOuLRxj1+6WBZpvZVeD6ZMAlkgrsdk0wnJaASXfq5NSsmIoKMqBCsTcAu/zxFBC43Qz98nk+mJR9cxjfSQSLx8hnG/kNPut6mQrY5unxT4Tmbuk/t1IDUarIM4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sITWZr9vk46+wmOamn5lc0oiEdvj6F+xBRDcuSObS8k=;
 b=B+puIUIZ0HhkSf+ylmQaPTkGL3mvDVMIszHa03Ugc/XZUen7+xRnWZ09R8ae90LI98Di6jVhdEs72ankWPqLtmToO6B4p7euI8hNKoVznyheYuSW7SVREsuhntw4dcxqygRvCezthQYj8SbcQ8Mwnyque/ZQQBUGuo5t4ZbQDajbyDm8GlhaYHBxdwYs75nQ4dOIuOOp5kQtxF79Gi8dC/PA4nMrlBUbh3BNsrblw9pgG0/z365HpQBHM62gr+tzvxSLH9p/HVzanfpJ40pkl40Jz82eyk9hlSpAvfv3MEOQWMi8LlhgDidl/exTWuts0fg5C7RUArmTJ3rG8JxcIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sITWZr9vk46+wmOamn5lc0oiEdvj6F+xBRDcuSObS8k=;
 b=hNV5JJ9nXPjqY0SCa1mIjMFmVawZ4hnABC88TkbhmcYFePF/mBAWHWyuJxepBvVlKLhn0cWI0/RvAnnRvDTlfKdJe9Z+48gMvsshTwd5C+MYvK1skfR94sVLOt1LY5a/4U11YCsOCqFM5W/LV0e015ftBZeSnCRZuRmhsuwhRiE=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DM4PR10MB6231.namprd10.prod.outlook.com (2603:10b6:8:8e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Fri, 26 Aug
 2022 17:37:19 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::4d5c:c5e9:7d20:43c2]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::4d5c:c5e9:7d20:43c2%9]) with mapi id 15.20.5566.016; Fri, 26 Aug 2022
 17:37:19 +0000
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
Subject: [PATCH v11 4/7] kexec: exclude elfcorehdr from the segment digest
Date:   Fri, 26 Aug 2022 13:37:01 -0400
Message-Id: <20220826173704.1895-5-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220826173704.1895-1-eric.devolder@oracle.com>
References: <20220826173704.1895-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR20CA0006.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::19) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4973224-3e4d-4839-d660-08da8789a00b
X-MS-TrafficTypeDiagnostic: DM4PR10MB6231:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kS1ENaHqkg3Dsphhl8Y4qifhk9ocqOJImp4dMD/EusBI3IyFYKI77/Ql0x/UY7xxn0lkXMW8J0Qn0Hex/eLmfy8LduYK3FLWi7EKDhzFG1x3jM27oTjAloSAU3GCtr3FjROCTbrcnlmsuKAp4qMlK23uMEEROfrCGlXOojZKaxQRR6mrJtA3mqKTsZtgu9ztQWkZ4iIGVKmvUM8Qvbysm4zTFwq0O4+uUwQ1Hi6PlN0kyDH1QXKei1AEUosLVFR3S4k5FGBKnc/j4dVXkX0jWHvDItGQenxBvHQYeGC9XGUoaKiT5U78Up4Vcq1X6o/gkuFDbLS61sFeGatre5bRFwIXved8MYhNMvlBC9zWJMYJXpKKEWlNYyHuGwh8wjk/Ye2zz9Plg9R6mN5ilV0n+4YiiIoN4PNlwzsVh4l789h5DOM5ncPX7xJ6XjrTJREGz7suHDr4XLbacdqxhf53KsHS0d/sWmaem+En5wwGLggS1CATU4atkewWTwJcpYiDwKMNIwOlYjUNhim0U/dTBPr7pePitrQOizdUE8h+5l+vtCzsNCsMXywpjFqy/OeuXd5Y7DxNzXIgOBTFlexhmobLDlGhIA2siDsfkh6RudP5Mhl+HTtBxs2TB7KJAd1GAEjQP/DYxJmBbV/cO/BUjlQoegOdz+uu4UQxHdiUEphhByANTb28J8YV+FGcXqmL9iBaG1l8S1fiDbcqJkC4rw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(39860400002)(376002)(396003)(346002)(36756003)(5660300002)(86362001)(66476007)(2616005)(6666004)(316002)(4326008)(66556008)(66946007)(8676002)(8936002)(7416002)(2906002)(478600001)(38100700002)(6486002)(26005)(41300700001)(6512007)(107886003)(186003)(6506007)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1cQ0/eaMa6fmxq8jXMdp6/YUXTfRlPpZty/Y+WiiglimjEGFJisdVmsnM8Cm?=
 =?us-ascii?Q?j5whaaqxf8oOzJ0deV/Jt8D4nf4tSYXFtYDRKSY2QkFPj6bbhM/DqyGaR9T4?=
 =?us-ascii?Q?q3He8ZIa2fKp5sOSMhtr4HNHr4CeBprhHL90dHzzeo0s/PaKg8QhMt687sXu?=
 =?us-ascii?Q?YN/8Uc3YUcKZILtO19F5MvXKGZDLAU2WK2VvhLf6dnCJmWjKDOhP/IbJ1atB?=
 =?us-ascii?Q?FCDwuV79kd6PpA0CI5GeOlmhDcIugo1qIp8YHpR3qXhopx/OAiY3wU0osybd?=
 =?us-ascii?Q?y4Xhy1H+Sw1krL39K0GXAC3Z7x1CAAjf2fsDeochApMfYdxUlsnVxpoFllaN?=
 =?us-ascii?Q?g4PD5iOKNdwAljVw4ClR768t8xv2LReVhM5DSTMREfRpDauS9ZOPwfmMsKbw?=
 =?us-ascii?Q?y9SgxeGet/vdffgpfr99dT6KZYRYL/LKI9YZt0iIJtHHvFD0m9RiV8lzUgn4?=
 =?us-ascii?Q?7AsE2cPPkiMU60YoNe3H/kaPbSY3SVe0X7Njq3QF2u5+DMm3LlApRZBSt15H?=
 =?us-ascii?Q?WNW0/1oJ9dBEqfw6IF7ga8cTKuxzzy6sn0EblulySLdkfUvcdp79MvycHF8X?=
 =?us-ascii?Q?XDqVNxKQzUMF+6wu3W1mIT+lIOWvgagXZ+mbqvIkvDH29BKAFSoDqC2AH5Dw?=
 =?us-ascii?Q?vjySgPtXSBB/6XSMZATtonvFUkx8LosNVY+ZmPqHNoPxI6R9JzUOBp30n86j?=
 =?us-ascii?Q?jzmL/IJV6GoxEDlwSakwxfyiDDvy3i3AFnvfAaqwy/LIbeWHAlIO1uqdMdsY?=
 =?us-ascii?Q?y8cgrhP/Ja4GIAp0gX6XcO1J3HKspPJdtaqepoWylShtOW3poInwZM+98Evi?=
 =?us-ascii?Q?AI42QMx60XDKyU//3K+oN0p8mhdf3z2SJ7OCgZKeu6f4ApJdnPz0rNefeLii?=
 =?us-ascii?Q?AnBd6e0eH3p5Vb0usXc+X2qpxWUQT35D9fLJp/QfSUE7moOZK0nTZ0WHKCDe?=
 =?us-ascii?Q?6E9ZQlKT+WebsO4aCbMsptJTx39XO7HNXgOArLQhmHClOM02a9+RJYUQTXk6?=
 =?us-ascii?Q?BqBNlnaYnewrffgkSR5QEJr9lzGa+4C9ew/X9LLecZlrOcDJ5ZgxUSipMhEI?=
 =?us-ascii?Q?193D5+mQyFd+LdAjbN8lUwl2Hf5QQl23y+3ClOl17Hx60iTDZnnEEVVKqalh?=
 =?us-ascii?Q?R20ZNxgbmSGL/yMSKH6jrUEoVgoLTWl6heVI+uPuNbdOTIJU3qd7T++E1mt3?=
 =?us-ascii?Q?gyWqAAe1lq2I8d6/1SwlNaE3+9So2F7pAKNniyVRDDgy+wVtVfH7eLnkmnxk?=
 =?us-ascii?Q?LWXUBdY+0on24VzhhZELaIg7quH3Bp0Ed9brVZGt8JDU8Y7Q1nFMtDR3qVw7?=
 =?us-ascii?Q?ccMNYIYoUU99fDA94HQQTJ3PYDb4rtWKFp2UqEIhGSRSXsvEXiz8zXJKHCex?=
 =?us-ascii?Q?Di0jcGcvRdGzCqKkSo8xwU+o9a8CchafyCWs1dCH6xNCThSitAiCXEDF3AO7?=
 =?us-ascii?Q?ngB9aKgzdp9YbHDx33f/JBsa6XTlix5okmN5n/fI0M2UqNaBuB1xbnbYmNYl?=
 =?us-ascii?Q?D+9wU2dekvcinqlnrmaLDyZCBdV9U1Z/vrioI9cXickGZelcXs84hkHgTu7f?=
 =?us-ascii?Q?YR3kdnVmFU/aDUqED6HXABVzBG1K/sUkE3QGYkyQGHLWUjABuz/qJshU+NI5?=
 =?us-ascii?Q?jw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4973224-3e4d-4839-d660-08da8789a00b
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 17:37:19.3308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 605P08Qx0Qhg0t+o+f9n9w5W3/66DJ1KiiMOFQ2IS8eElquLX/vjxcg+A883/gBkXnRk3HnNGPJHCIlaLoOcOtZ1B6vFFC5ES6wSFyeAJkg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6231
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_10,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 mlxscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208260070
X-Proofpoint-ORIG-GUID: T5KEXjf8yQkQ1-kpUKhAp-UWHK2aaVjb
X-Proofpoint-GUID: T5KEXjf8yQkQ1-kpUKhAp-UWHK2aaVjb
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
index 8017eeb43036..d0c2661b3509 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -723,6 +723,12 @@ static int kexec_calculate_store_digests(struct kimage *image)
 	for (j = i = 0; i < image->nr_segments; i++) {
 		struct kexec_segment *ksegment;
 
+#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
+		/* Exclude elfcorehdr segment to allow future changes via hotplug */
+		if (image->elfcorehdr_index_valid && (j == image->elfcorehdr_index))
+			continue;
+#endif
+
 		ksegment = &image->segment[i];
 		/*
 		 * Skip purgatory as it will be modified once we put digest
-- 
2.31.1

