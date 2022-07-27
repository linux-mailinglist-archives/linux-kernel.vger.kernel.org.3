Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED7F5835BD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 01:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233194AbiG0XnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 19:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbiG0XnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 19:43:21 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9280E53D3D;
        Wed, 27 Jul 2022 16:43:19 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26RNO8U0013562;
        Wed, 27 Jul 2022 23:42:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=7mYZt52WbTvH92iWP6U/JS2AiRz9HhKcnTpEU6zy6+Q=;
 b=TQBsqRii9Nqp3xmZ53oGgz5MMCvw4j1pMsqaAdlZSfywrvx04DbEYUAfZyxSn7zyZVhG
 NRZbLMJ7es83D0lfpUrdlULb+Itjn7qd9dkhwZALJsNeJCXR3RWBU6Qqkqt5b5gfhlW7
 aYBZzSJ2NaDNAROqeq97kgSW/R2G7/D/tiMujGq7FtoXRN5wM5L+vtU4h0cbooLDpaA4
 5jxSqMkG0WJ3DqAhgzGOB2ryU+ORrP7k078ZVawHPZzLrdeduFbWDDn7bQqDQDyezYUH
 BARc+f7dccHwpcWlViTNv/cXYHpsy6eTINesGgneK9k0nwlX4eb77r++p+cHynFJkoDB jg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg9a9k5uv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jul 2022 23:42:58 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26RMc7hV006282;
        Wed, 27 Jul 2022 23:42:57 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hh65dn7wq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jul 2022 23:42:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dVfCK+ZAh9g6UqAMIUt8zZqTB6R+IV5lbi3Cbbj/VHKK4GwvdpBhHABmxBSPf97sJUTJJUx8gSWts/fzfLrbUJVSl1N0GW0TlU6ZR5X2K0tIaXffg0TUXQKXmet6ouq09zyuuRPYPtwjLG1olpWPlwMkQxSwY6fVr0Y/UEBpVxv/pXZl4xmGxncGYqFdHh3xsAnU4km/UzpnMhAZofGVQYe5myAjTxWU0MKhl58SCrC/+sfph1nOhTYh5zTFaM6yflgJ3vJmGUeGn0bD9ct2eecJYCW3g1loTmfYgV+8TpGujPuQS3NXWl6Z77bTOiGQBsURhPpzy21qIOTXHahYlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7mYZt52WbTvH92iWP6U/JS2AiRz9HhKcnTpEU6zy6+Q=;
 b=NoZO6Zo66xPbketAUAGCYgx0pqWFetUwGTnOWxIPQi++be6uAtXTV3Xj5tvji4V5L6CrYBtXiKRurv5CvN8AYkbF8yp1TMdjz7vFAPtEdWzKhmy6Y+jIU+lQIh/4NSi4N+qPutqhf4wNPUD/UTZdl/A40kLASP7HHHa1u4gfILSy1UQdYRLyJ7D7zflKJ2McUhAUjNOUyWrc5MJZQ2kqlfHA2SzAJt4pAXRtg/Q1wbl7C1A08lkg+9d9RkShAo2jEKlGGk2MeLS/4qFzkP3QLT0dsRVvU4//RJfX9/COBhH1FKpOeupdeAgpgoR1c0OKq2txiOvpj7d+Qz/uCfVTeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7mYZt52WbTvH92iWP6U/JS2AiRz9HhKcnTpEU6zy6+Q=;
 b=v54SqirIS48JnE1RFiZ1WjAu+cp0z/J/BgEMcqYXG0i/Jbt4t57PeE3E6VgwqmUWpnGO0H8SqdlqC712mtnjqKhxOEmzIO815mj0dbQv7J2waMAYXIND+bfwuam6FEVwSyU5z20meFxuUYDCqQo+YoCi/Y4Yz+Sh/luSEIpnxFk=
Received: from SJ0PR10MB4479.namprd10.prod.outlook.com (2603:10b6:a03:2af::22)
 by CO1PR10MB4498.namprd10.prod.outlook.com (2603:10b6:303:6c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.6; Wed, 27 Jul
 2022 23:42:55 +0000
Received: from SJ0PR10MB4479.namprd10.prod.outlook.com
 ([fe80::99fa:2dc7:6a0e:fccc]) by SJ0PR10MB4479.namprd10.prod.outlook.com
 ([fe80::99fa:2dc7:6a0e:fccc%4]) with mapi id 15.20.5482.006; Wed, 27 Jul 2022
 23:42:55 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     glider@google.com, elver@google.com, dvyukov@google.com,
        cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org
Subject: [RFC PATCH] mm/kfence: Introduce kernel parameter for selective usage of kfence.
Date:   Thu, 28 Jul 2022 09:42:41 +1000
Message-Id: <20220727234241.1423357-1-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0028.ausprd01.prod.outlook.com
 (2603:10c6:10:eb::15) To SJ0PR10MB4479.namprd10.prod.outlook.com
 (2603:10b6:a03:2af::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6443b14-eadd-4a0e-2a6b-08da7029ba67
X-MS-TrafficTypeDiagnostic: CO1PR10MB4498:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UDxyzp3GMkY0n62eoEKyhUd1KGe0/sa3OrnFyKvFJ387vinz+/dcEbhdUHxpUHkCd6Nrmp5mq5ewGM34k4V0UG9lfBi2a6Hc+7NiFhd/O8B2PF1L4HumCyxNNGQqOiu+vVuvAme9/r7Cahy/nH3rIgGIyfGHZ86xUVUMZYCpkQWPbWlelGUojYqqLuFmTr28XFyJ6mnDS8weh0ys+3oHAJ/RWI7+zl5WrEdLHoE8YhnI2c16wwrPa85By0HZlp0aZMalIt6v6J94sSrl7vmgS+Y27lMFdnLtwRy5K+TnGapPX3KJqCTp7aOp5ePbeG0WLJ4DCW3KBFYbmPtI8Z/NqQZOPauOoY5dBDElLQxePnb7nG5by7D7hNJiFb/XMkr//JPSC+FT4PASjNehyoF07N/ixwLPHXNiK8/SLm3CR2Kj+b01HoJ5RzSkYETEf9jOF+YRC1P/qov7wlMtFVK67iO3+cIRzWUl5+cwHYRHf2WSB71XRPlq/ZIcLaCoHaTML3y8nvghZlNK0pdHSTz7egcvqZuqGpNoNMpnYle4OyK1qmBXGiAzSsiZXu4kk2+F8hXZ0FP5LSG8A8zeV3pEVq5XVFAyduivviT0tnshjqAVD3LBTGMrNoxaD/UHnTYVPgnA28hb8bym9jebEW8CWqKWA/3d/0fAPL7VIQFWbL9mCNHOeeL0IqP8sk0FzFjbbQESHfvS7meM8h/+4wz38tOW7W+9l3/1QVrseS6jud3m7fPpnpaG8tLGdKeyeS7VqnFYOipdx5GqCI2ZZ+7c842SukEz7BAICAwr51pjH8ECMpEd7NuNzg8vKL1Wg2zK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4479.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(39860400002)(136003)(376002)(346002)(396003)(36756003)(38100700002)(921005)(2616005)(316002)(6506007)(38350700002)(66476007)(66946007)(4326008)(8676002)(66556008)(6486002)(1076003)(478600001)(26005)(8936002)(6512007)(5660300002)(52116002)(7416002)(2906002)(103116003)(86362001)(83380400001)(6666004)(41300700001)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nTHyaF4dQoOt+qtZaUo7ROd2/2QSaXjuc7cmr5G0mp0ZMOESdbIBdEC7krVF?=
 =?us-ascii?Q?wk8YRu5g7D0m/Ckj0458Hct+deq2rulnct2uwxDHt23UtsrzxNCizcA3XbKX?=
 =?us-ascii?Q?80rOyCtNXl1FxFlkH46HyPEwBidOYRAzu6ZAbmSqLDvcfAMiPm/mhdvHFbZS?=
 =?us-ascii?Q?fNrA4ne2AAi4joN8GqB6s1D9Aavio2+wbpsx5eGOvIeQDMEbhZcLUyAxWpgq?=
 =?us-ascii?Q?aDmnIQvPaKQGT7BHxrXxgire2U+CzCta2mJTva2tnrlly1SFH1JZ/wuNQtc7?=
 =?us-ascii?Q?0BK83OYNKfoOtmXiWDYj6q+OX13kwoT6GcmcRAHjEZ3uVyrjI44jSu+wM+dU?=
 =?us-ascii?Q?+e3IVrgmC8vfGB7s/TVBIaNKyYKjC/4tG3qlMYMbOHLFLHU0S83zcTHSrmHA?=
 =?us-ascii?Q?mqPECdAqXIeBmC4hzbHw9WOPD6PwjMLK6vnq5mqSTCTE4WhcueUieSWU/1lM?=
 =?us-ascii?Q?sGiwdUOkR8qGOBSDsk0RgdunGJZP9ZZidt9PJq/daVzM/4aOVpP3icbn25pr?=
 =?us-ascii?Q?YS0AZBJ/SVNRz+unGUJJHuZHP0UXyLPR/UgAYx3KSosY6yUYZTaVc8BOOSP9?=
 =?us-ascii?Q?qQZJGb+tyttHnh5+6+GFjWrZ5Hki9VWmbTn0k9HmGArCrwgNjWk/Nn8Lzyxx?=
 =?us-ascii?Q?NH8XCjhsf7MB3WikbhH6rduYf0D2qNTp5VHvY+d6J9b8cANQPQLlEp48LGZ8?=
 =?us-ascii?Q?mVPZaEFRgxoR4Z34VyfLnpy9DoBKvvwbVnxdnHk8RE7RXY7t+jWAnYhHrEBA?=
 =?us-ascii?Q?XlnXCfEAYRHX+JIpnNidA+9T6nzIAlmcc4CxJHNVc6/SbQl9I0x+9trrkyk5?=
 =?us-ascii?Q?1PvNnCnLI++I/xn7OMe5oqSdgorAhO8pBzlLa6+hch5uxin+eIYYOm5gKrAM?=
 =?us-ascii?Q?awEkv5nrN2BT9RzI5J9s7gP8sfL/Z9QHTRhQhugvNO2ufAKGFnodvI0JCGIs?=
 =?us-ascii?Q?+WF9c/Fa8niYtegnmtp6fquvV5n4rwYqRNT7AKKGVy9k0zboIDTq1g20GqIg?=
 =?us-ascii?Q?CnPO/GWVNhBWI1Sr+TfSnEOUWwI2gMlORYf18RfL0PT+1M90ZeeRbsItyjXm?=
 =?us-ascii?Q?bsg+HxqCV/GwfsPge8ZXJDhkccnhhXxBNeph2pEMKCJT/atgmfKg3OB1zSOR?=
 =?us-ascii?Q?SHNRF8lE4rvABGD7z0P/dCPKaLX/+1GE+28ykottacGzDWyzDCznThHCZptS?=
 =?us-ascii?Q?Xo3K/dGozhkDgSSnbL6huyZTXjyEdlXDx8ijTvhmSOnqmKQcuybuouz2L01K?=
 =?us-ascii?Q?9wB+whRhBCWKOra4/plUtGHqRgqNWLPPqlifMLG8ArH6h+HZcJxj02dC3O3d?=
 =?us-ascii?Q?sAfve4E1durjUmRx4kCVpGUfi9YA2mdkS/KwRwj72rkXgatPSdbZ7T5zA3sc?=
 =?us-ascii?Q?ADeOJSCCa4Rvqpk7lBnKj0IJDz4Sbfd9I94WZCqVhBhfCCH/dKEMy9GLZKRu?=
 =?us-ascii?Q?MIlxA0tX0SKWxiPdd2i8elcltq1Qz/3G4N+1ZRFIvigua6EvBHrgkl/dueYy?=
 =?us-ascii?Q?Aqd7vqJqsPUBexPqQsgx6oSbjr7ymWA0ThrxE2NMr/bFK7HqGQgVzTCjLjVR?=
 =?us-ascii?Q?TRxqPw0O2Th+1R1xDyWrHcyKF7DRSttb6S3dsgrc/08zs8z2BJ96XRuc2zor?=
 =?us-ascii?Q?UA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6443b14-eadd-4a0e-2a6b-08da7029ba67
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4479.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2022 23:42:55.1514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tvJ3JOYUpy7D3bzjjvE220wSwtYdxC5ME8J0/5ySksr2LCwPFb+iRJNo7JP5n9OjGbYhk2AxTAgyWMiONrILKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4498
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-27_08,2022-07-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 spamscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207270106
X-Proofpoint-GUID: 7QL3BF2K8nU0ttZaIBNtTXMBjoPs5KPp
X-Proofpoint-ORIG-GUID: 7QL3BF2K8nU0ttZaIBNtTXMBjoPs5KPp
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default kfence allocation can happen for any slub object, whose size
is up to PAGE_SIZE, as long as that allocation is the first allocation
after expiration of kfence sample interval. But in certain debugging
scenarios we may be interested in debugging corruptions involving
some specific slub objects like dentry or ext4_* etc. In such cases
limiting kfence for allocations involving only specific slub objects
will increase the probablity of catching the issue since kfence pool
will not be consumed by other slub objects.

This patch introduces a kernel parameter slub_kfence that can be used
to specify a comma separated list of slabs for which kfence allocations
will happen. Also introduce a sysfs parameter that can be used to re-enable
kfence for all slabs.

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
---

I am also working on getting kfence enabled for specific slabs using
/sys/kernel/slab/<slab_name>/kfence interface but in the meanwhile
I am sharing this RFC patch to get some early feedback. Especially
if this feature makes sense or if there is any better/existing way to
achieve similar end results.

 .../admin-guide/kernel-parameters.txt         |  5 ++
 include/linux/kfence.h                        |  1 +
 include/linux/slab.h                          |  6 ++
 mm/kfence/core.c                              | 86 +++++++++++++++++++
 mm/slub.c                                     | 47 ++++++++++
 5 files changed, 145 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 98e5cb91faab..d66f555df7ba 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5553,6 +5553,11 @@
 			last alloc / free. For more information see
 			Documentation/mm/slub.rst.
 
+	slub_kfence[=slabs][,slabs]]...]	[MM, SLUB]
+			Specifies the slabs for which kfence debug mechanism
+			can be used. For more information about kfence see
+			Documentation/dev-tools/kfence.rst.
+
 	slub_max_order= [MM, SLUB]
 			Determines the maximum allowed order for slabs.
 			A high setting may cause OOMs due to memory
diff --git a/include/linux/kfence.h b/include/linux/kfence.h
index 726857a4b680..140fc4fe87e1 100644
--- a/include/linux/kfence.h
+++ b/include/linux/kfence.h
@@ -125,6 +125,7 @@ static __always_inline void *kfence_alloc(struct kmem_cache *s, size_t size, gfp
 #endif
 	if (likely(atomic_read(&kfence_allocation_gate)))
 		return NULL;
+
 	return __kfence_alloc(s, size, flags);
 }
 
diff --git a/include/linux/slab.h b/include/linux/slab.h
index 0fefdf528e0d..b0def74d9fa1 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -119,6 +119,12 @@
  */
 #define SLAB_NO_USER_FLAGS	((slab_flags_t __force)0x10000000U)
 
+#ifdef CONFIG_KFENCE
+#define SLAB_KFENCE		((slab_flags_t __force)0x20000000U)
+#else
+#define SLAB_KFENCE		0
+#endif
+
 /* The following flags affect the page allocator grouping pages by mobility */
 /* Objects are reclaimable */
 #define SLAB_RECLAIM_ACCOUNT	((slab_flags_t __force)0x00020000U)
diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index c252081b11df..017ea87b495b 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -132,6 +132,8 @@ DEFINE_STATIC_KEY_FALSE(kfence_allocation_key);
 /* Gates the allocation, ensuring only one succeeds in a given period. */
 atomic_t kfence_allocation_gate = ATOMIC_INIT(1);
 
+/* Determines if kfence allocation happens only for selected slabs. */
+atomic_t kfence_global_alloc = ATOMIC_INIT(1);
 /*
  * A Counting Bloom filter of allocation coverage: limits currently covered
  * allocations of the same source filling up the pool.
@@ -1003,6 +1005,14 @@ void *__kfence_alloc(struct kmem_cache *s, size_t size, gfp_t flags)
 		return NULL;
 	}
 
+	/*
+	 * Skip allocation if kfence has been enable for selected slabs
+	 * and this slab is not one of the selected slabs.
+	 */
+	if (unlikely(!atomic_read(&kfence_global_alloc)
+		    && !(s->flags & SLAB_KFENCE)))
+		return NULL;
+
 	if (atomic_inc_return(&kfence_allocation_gate) > 1)
 		return NULL;
 #ifdef CONFIG_KFENCE_STATIC_KEYS
@@ -1156,3 +1166,79 @@ bool kfence_handle_page_fault(unsigned long addr, bool is_write, struct pt_regs
 
 	return kfence_unprotect(addr); /* Unprotect and let access proceed. */
 }
+
+#ifdef CONFIG_SYSFS
+static ssize_t kfence_global_alloc_enabled_show(struct kobject *kobj,
+					  struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%d\n", atomic_read(&kfence_global_alloc));
+}
+
+static ssize_t kfence_global_alloc_enabled_store(struct kobject *kobj,
+					   struct kobj_attribute *attr,
+					   const char *buf, size_t count)
+{
+	struct kmem_cache *s;
+	ssize_t ret;
+	int val;
+
+	ret = kstrtoint(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	if (val != 1)
+		return -EINVAL;
+
+	atomic_set(&kfence_global_alloc, val);
+
+	/*
+	 * If kfence is re-enabled for all slabs from sysfs, disable
+	 * slab specific usage of kfence.
+	 */
+	mutex_lock(&slab_mutex);
+	list_for_each_entry(s, &slab_caches, list)
+		if (s->flags & SLAB_KFENCE)
+			s->flags &= ~SLAB_KFENCE;
+	mutex_unlock(&slab_mutex);
+
+	return count;
+}
+
+static struct kobj_attribute kfence_global_alloc_enabled_attr =
+	__ATTR(kfence_global_alloc_enabled,
+	       0644,
+	       kfence_global_alloc_enabled_show,
+	       kfence_global_alloc_enabled_store);
+
+static struct attribute *kfence_attrs[] = {
+	&kfence_global_alloc_enabled_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group kfence_attr_group = {
+	.attrs = kfence_attrs,
+};
+
+static int __init kfence_init_sysfs(void)
+{
+	int err;
+	struct kobject *kfence_kobj;
+
+	kfence_kobj = kobject_create_and_add("kfence", mm_kobj);
+	if (!kfence_kobj) {
+		pr_err("failed to create kfence_global_alloc_enabled kobject\n");
+		return -ENOMEM;
+	}
+	err = sysfs_create_group(kfence_kobj, &kfence_attr_group);
+	if (err) {
+		pr_err("failed to register numa group\n");
+		goto delete_obj;
+	}
+	return 0;
+
+delete_obj:
+	kobject_put(kfence_kobj);
+	return err;
+}
+subsys_initcall(kfence_init_sysfs);
+#endif /* CONFIG_SYSFS */
diff --git a/mm/slub.c b/mm/slub.c
index 862dbd9af4f5..7ee67ba5097c 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -645,6 +645,7 @@ static slab_flags_t slub_debug;
 #endif
 
 static char *slub_debug_string;
+static char *slub_kfence_list;
 static int disable_higher_order_debug;
 
 /*
@@ -1589,6 +1590,27 @@ static int __init setup_slub_debug(char *str)
 
 __setup("slub_debug", setup_slub_debug);
 
+#ifdef CONFIG_KFENCE
+extern atomic_t kfence_global_alloc;
+
+static int __init setup_slub_kfence(char *str)
+{
+	if (*str++ != '=' || !*str)
+		return 1;
+
+	slub_kfence_list = str;
+
+	/*
+	 * Disable global kfence usage if specific slabs
+	 * were specified in bootargs.
+	 */
+	atomic_set(&kfence_global_alloc, 0);
+
+	return 1;
+}
+__setup("slub_kfence", setup_slub_kfence);
+#endif
+
 /*
  * kmem_cache_flags - apply debugging options to the cache
  * @object_size:	the size of an object without meta data
@@ -1653,6 +1675,31 @@ slab_flags_t kmem_cache_flags(unsigned int object_size,
 		}
 	}
 
+	/* Check if kfence has been enabled for this slab */
+	iter = slub_kfence_list;
+
+	while (iter && *iter) {
+		char *end, *glob;
+		size_t cmplen;
+
+		end = strchrnul(iter, ',');
+
+		glob = strnchr(iter, end - iter, '*');
+
+		if (glob)
+			cmplen = glob - iter;
+		else
+			cmplen = end - iter;
+
+		if (!strncmp(iter, name, cmplen))
+			flags |= SLAB_KFENCE;
+
+		if (!*end)
+			break;
+
+		iter = end + 1;
+	}
+
 	return flags | slub_debug_local;
 }
 #else /* !CONFIG_SLUB_DEBUG */
-- 
2.30.2

