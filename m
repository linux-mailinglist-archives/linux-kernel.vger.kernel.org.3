Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C7A512B2D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 07:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243341AbiD1F6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 01:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243287AbiD1F6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 01:58:14 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344F37C786
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 22:54:58 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23S0pDSL025790;
        Thu, 28 Apr 2022 05:54:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=u8abtKVpp3wetyUrvExCT0QB/Yr4E5Fq3bnErhIbpIs=;
 b=TWjTkAyqh8D/jGb7Uha1gkRa7xW1RWkY4fM0ZaZNWeKtid52PzdvcHG1zpUkF/4mP6TU
 4gtgbgJPZ0snlaZJb0NvlvE1VrZsUiq5JelJPh5CQ+vUlrbPLt2S192PnL0SGUSpB6UX
 Ek8SmUPsmfWdPHZM9tX2i9Mtahs8m28DXGZbnQr/RjDn8Bsyc9BJ6oYkL3q6RS4p6tBm
 rpRIbkMMKoOpa+xtN4vDe5MSU5IZ0t2AaSqQG1dZxJbmwlQL86H6UPACJk6Eip1lfF00
 PyfXmFgk60uaEuhjgxltL5ri23NRYPTItOvvvmwJ+PKhPP2zRVpR2Fk3CsreGXciZHoN gQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb1mu1k4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Apr 2022 05:54:54 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23S5jAKA030640;
        Thu, 28 Apr 2022 05:54:53 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2040.outbound.protection.outlook.com [104.47.74.40])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w60tx6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Apr 2022 05:54:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BSadmBVDLFk6T3k/cshNVKolhTIdkkvEnCedmTB+padtBzOCWIhVO+dHGSaA3w/EeBcy0FEKkxcSqiLkgaTKr8YMg7DotX6TMo1aqo1/DgjI2hdLUng4S99RIsCHo3uCwOrDMuBG2IGd1RfiVbxOfThusljqV4UHqNW+Gav/z9w3zJArnq6bIepVu9viGWBhnEc6PGGFPvmZTjFk+rfsw8pwt+C0xzi+TGzqMNg6YbJ7X5NzBdNGT1ZPyyFskGSAcuo4OtUq++cU80bnVnH6dSh5Sg8NYvV63gBkN6D3BWm9W5tv8FgqLWdLmdBZbB0TQ9R2Ow4398Pf4zTYngyCLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u8abtKVpp3wetyUrvExCT0QB/Yr4E5Fq3bnErhIbpIs=;
 b=NdMmVFSwOFknhBcHLsBDAMmlbaGxAO3hi3Esq3thilhIIvWM0BraZPpN36sFh/R6AqDRi2r/gJEWEKODQzuJHmSSdqENsNFGc2SaLUtKe/dnMUFuYakuSk6qR0k9CfJBQ6k0yflHM3gt0yI3R1MIncsIxkG7pLYD/aeu75NmY7WUbv9lgDfXGGparerZ2Gwb0EkX/vJA/s/RjNqMFvGqRaDm3dDK7tSwlplPYn4AvDAWgi+XmVy5D1kLrBXXYA0atjN/dhWWbcTz+l3fNAZfkRkTB+Y45+arh3rUQTAFO0CIeR0QEX3kWLgMfxJiZ9w/0CiLh+6TWuoJwYcUqMnJmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u8abtKVpp3wetyUrvExCT0QB/Yr4E5Fq3bnErhIbpIs=;
 b=fxtTijxIauLitoW1jRgbtSU9PJpf6MjA101mehSOnFxwoCeS+kCk4FyTR6uALvj3TaRm+uBXlW3ijgpgSeKusOiBkVMrBl/xrRYTnHO5ifpx3hYy1ZO8jcBo4+RH0wlm2JTzglAFspvcueZn9eJF7UNlU+DdoIT7MFe503AgQ6c=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by MWHPR10MB1789.namprd10.prod.outlook.com (2603:10b6:301:8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Thu, 28 Apr
 2022 05:54:51 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::14ef:8202:73ba:29ec]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::14ef:8202:73ba:29ec%3]) with mapi id 15.20.5186.021; Thu, 28 Apr 2022
 05:54:51 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] kernfs: Introduce interface to access global kernfs_open_file_mutex.
Date:   Thu, 28 Apr 2022 15:54:30 +1000
Message-Id: <20220428055431.3826852-5-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220428055431.3826852-1-imran.f.khan@oracle.com>
References: <20220428055431.3826852-1-imran.f.khan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0016.ausprd01.prod.outlook.com
 (2603:10c6:10:e8::21) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6d4024e-b5e4-4769-94b7-08da28db9c61
X-MS-TrafficTypeDiagnostic: MWHPR10MB1789:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB17896B0297B67D690C724014B0FD9@MWHPR10MB1789.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TmW7J7OmSXSxAPThkKTbtB2jdhStu/akpN2i7xFvAq3z101ajfNkQ2ilHBYAA1sRemMBV7bIhT0FOT8OFdiJL3v9eEoHkxIDspIemZDxvjWC7jr11r1ITdA9aCL//WZUY7k3E9B45ElAWOzDTiv4Ij7oK6D4wS72nEGTVlvkkkxKtKZgZKuNg7GEBc4RzrffgcriP5lX4Vswe+ZYHw+OZBYG2xbnLMGBPyzPCl53kGCaIcBPnljlyxK9TpfIiBR0efaOoiX2oNNTlBOaz8FnFa7AUWhzGx3wHaatxmLzu5+0gkAwHEhmOz/shOjnv9noDO7umWNwDM2+TWWu1XH9eVVl0eRLaR9nUKhgnoXQz3PS/EtASqe3TGVcN8z0lYOxAHFZKths1VAwIfemAdme55GYm17H6LFrl+JURCDJsxM42WgjrybhrP5WqmAwz5xp/Im8iPnnK/HTeJvbhJaHcYey507p8LWbN/Qo7t1PxqPN/BOlnlznvgjZrD1tlL+X6eCavT5Y3CEGv+6m0pE0+FN6anXWe7ceainEswHPEH3yj1CiILI15FqJCjOlrKqfJiSaDq0AN+Ij6ZYpa76habdWQeqLLoUzLWcyKGSY3u+78a/eaQdJm3fwEMLFIMnvFOWFfefpfgIGtlIcH6hvVga3C5Xtwv39sib8U6DdZfmNFCMCnn/QnnuEL/r/Cy0grPZfUY2FcCZS+qyXY5cSnw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(5660300002)(2616005)(6666004)(66556008)(26005)(8936002)(66946007)(6512007)(508600001)(2906002)(38100700002)(38350700002)(86362001)(1076003)(52116002)(6486002)(4326008)(83380400001)(66476007)(8676002)(186003)(6506007)(36756003)(103116003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uVAyDoVrS2rzjnPHXcOWOidi+ZXgRqWK66Njl3PhQoVANydldeQFrRzSw78J?=
 =?us-ascii?Q?orVKBPq+2UO7TE9T9BCtDM4MVl7tu6TRD+iksN+Hpz5SUmsVhsGaaHIR6Xbv?=
 =?us-ascii?Q?O0+bov9HOYfLBEX4O3V8LugSz+JTYp2/97s1Wbp+ixLKOSWzAkWUblO4nPV+?=
 =?us-ascii?Q?6xnLLXX25eh6+TRQrWthV3qOplpBklzcJZmgxmyFiIhsnIL4Owv2q2YCgI+0?=
 =?us-ascii?Q?pgKr063+TJ3lk/O0UwIFcGL2a0SYJO/Tof7crgAtbjUQaQMUyJlUlCMsiR6m?=
 =?us-ascii?Q?LJkBIUudTIQ5Tv+f0d/8FGa4QbkbsrzNfFHJPnraJ7ElfiLs2MC8egI3GJez?=
 =?us-ascii?Q?xXgEokOqNu5m7ZAEIL5gY7JITM+pSNZlQ48XyOXYYuwJwGE4DtjBSeyCTPC/?=
 =?us-ascii?Q?XIRk6bRCrl/6PXY6at397AJl9YGe7HutmtAMY4xvEiOnq8cBJ5ORMIGLWomI?=
 =?us-ascii?Q?E0tL2SBXBC4Drvif2msim2VW3Q8k3YYvDdOet0qYO3yfF21VSDAmL8IS68T3?=
 =?us-ascii?Q?fvfWlrO/DVd7U4fDUdGlsLMAaJo5cR/j/paf0w/yqK+OfvAjAbsjtes8/FDL?=
 =?us-ascii?Q?ElGfoX98PY3Z+1rqqH4dyNtNauzN0FDK6ggviBKl4EPAMPN+RC1xp6qejMQ7?=
 =?us-ascii?Q?aNiLmnT11ztCUT/qb0yanH9G4yW3073I2zabvVG6qUD8wCr6cGDUCiGkoqR2?=
 =?us-ascii?Q?H6VZPSE5TfDfuzXKlngknez0SbmrlIxKnNjrHl2Z2UxlYISMqlSQuDpMPihB?=
 =?us-ascii?Q?vJHQI8aGFY97n6AgUIBDllfueo7xWGFAIRaKGgm8d6pjLgcyE50hABGYZsnn?=
 =?us-ascii?Q?Pjg8K8lixwNS518fGG1l8jZtAW8HApCnQOdvRN9QGNWHu/X8PfF8/SjHVCw6?=
 =?us-ascii?Q?/v3FFOI3hiZZ+SYOaJPocBVJrIvWlxbAMqnMnHvkolkR6wLVju4q8apS1B9C?=
 =?us-ascii?Q?SJxGiBcjJFg9Gaezn1LOY5IE1RgIOcSjJRAFzxo0newGhvddSk9wJfPMdy5v?=
 =?us-ascii?Q?NA4FvgNqxfpDv9k8zlBbBVoGiJHYJ6kUUkXCZqLxpbqMWhcyjNq+GDmhZtC4?=
 =?us-ascii?Q?ZazGGk/qeQc+1Xg48RCdmHgVDGCtrjVejAqKeZTqt4aeo6FP3fc9lgV/H2/h?=
 =?us-ascii?Q?cgbPNFVz0sb8WA7WiwPe8GSU6s/nU94CwolUUzqs8S8h3Z8s9YY344bPfdjx?=
 =?us-ascii?Q?wsrVMoBYsXcyqI5cJCoMc31wqWHxfzmSvW4la2kNvlydz8Qu7KmarEntwkCu?=
 =?us-ascii?Q?mTvJ7iGLv4IVYRggX+iCtheg0VBoeLOWun0WnsipPWWOiJc6HG/ayMyRVDWs?=
 =?us-ascii?Q?Ns8A99RJRSJ9qduI1kurx5vh+9ZgXsQ9m2Y8D36mtJv9jUj34CfJA6+c4LbI?=
 =?us-ascii?Q?gO/WRoKJMCd+N0HsJ8JD69Qo+vBgtIhbUH9/jBKxRSpLHj9OghBIdhZVVNj5?=
 =?us-ascii?Q?nA4gbn8UwITSkpdds9fJRyLPHoQCCGA52rVHsQF6e04WbNmMChEvlGyCf9NZ?=
 =?us-ascii?Q?ek02TFUr73HPwC1x/FbP0UsEqfS6t2B2FAGjFenO7qGGdwHffdyFR/3j+IlN?=
 =?us-ascii?Q?yOFV5dgx/WQmsAW/hhgTTzhM1eRu0hkbFsoJNYFGYegQRr8TH8Tkf1ZKG1NE?=
 =?us-ascii?Q?vVBFY1NKF2c5XI5900aZsb+vPWb+ZcVOBTCMTchZ0h5ikEUOA2gZpUKEZwlY?=
 =?us-ascii?Q?ZIohzvF6ATuxuIBvOU4TTLu4HONNGNRC3AtdabiMsmtA6xseU7TLUkUJ+RNl?=
 =?us-ascii?Q?wLO1HFHGMJ+a8JX/Kmr5JCme9gMnO8M=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6d4024e-b5e4-4769-94b7-08da28db9c61
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 05:54:51.4810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TDoYE9dTsABDrCPyXBED7M/Xo6dHmwYWj8MWOOveWt1sqi+J0uNXpyi5FL6qBrEDs1EsYffc8AIJnc326CvyFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1789
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-27_04:2022-04-27,2022-04-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=994
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204280035
X-Proofpoint-GUID: vc7PMfLYo3lUbZWX0xdsNu4rgjvmpdVE
X-Proofpoint-ORIG-GUID: vc7PMfLYo3lUbZWX0xdsNu4rgjvmpdVE
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows to change underlying mutex locking, without needing to change
the users of the lock. For example next patch modifies this interface to
use hashed mutexes in place of a single global kernfs_open_file_mutex.

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
---
 fs/kernfs/file.c | 50 +++++++++++++++++++++++++++++++++---------------
 1 file changed, 35 insertions(+), 15 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 96c8493003b6..7a60074ec0a0 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -49,6 +49,22 @@ struct kernfs_open_node {
 
 static LLIST_HEAD(kernfs_notify_list);
 
+static inline struct mutex *kernfs_open_file_mutex_ptr(struct kernfs_node *kn)
+{
+	return &kernfs_open_file_mutex;
+}
+
+static inline struct mutex *kernfs_open_file_mutex_lock(struct kernfs_node *kn)
+{
+	struct mutex *lock;
+
+	lock = kernfs_open_file_mutex_ptr(kn);
+
+	mutex_lock(lock);
+
+	return lock;
+}
+
 /*
  * Raw deref RCU protected kn->attr.open.
  * The caller guarantees that @on will not vanish in the middle of this
@@ -67,7 +83,7 @@ static struct kernfs_open_node *kernfs_deref_on_raw(struct kernfs_node *kn)
 static struct kernfs_open_node *kernfs_deref_on_protected(struct kernfs_node *kn)
 {
 	return rcu_dereference_protected(kn->attr.open,
-					 lockdep_is_held(&kernfs_open_file_mutex));
+				 lockdep_is_held(kernfs_open_file_mutex_ptr(kn)));
 }
 
 /*
@@ -78,7 +94,7 @@ static struct kernfs_open_node *kernfs_deref_on_protected(struct kernfs_node *kn
 static struct kernfs_open_node *kernfs_check_on_protected(struct kernfs_node *kn)
 {
 	return rcu_dereference_check(kn->attr.open,
-				      lockdep_is_held(&kernfs_open_file_mutex));
+				 lockdep_is_held(kernfs_open_file_mutex_ptr(kn)));
 }
 
 static struct kernfs_open_file *kernfs_of(struct file *file)
@@ -551,19 +567,20 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
 				struct kernfs_open_file *of)
 {
 	struct kernfs_open_node *on, *new_on = NULL;
+	struct mutex *mutex = NULL;
 
-	mutex_lock(&kernfs_open_file_mutex);
+	mutex = kernfs_open_file_mutex_lock(kn);
 	on = kernfs_deref_on_protected(kn);
 
 	if (on) {
 		list_add_tail(&of->list, &on->files);
-		mutex_unlock(&kernfs_open_file_mutex);
+		mutex_unlock(mutex);
 		return 0;
 	} else {
 		/* not there, initialize a new one */
 		new_on = kmalloc(sizeof(*new_on), GFP_KERNEL);
 		if (!new_on) {
-			mutex_unlock(&kernfs_open_file_mutex);
+			mutex_unlock(mutex);
 			return -ENOMEM;
 		}
 		atomic_set(&new_on->event, 1);
@@ -572,7 +589,7 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
 		list_add_tail(&of->list, &new_on->files);
 		rcu_assign_pointer(kn->attr.open, new_on);
 	}
-	mutex_unlock(&kernfs_open_file_mutex);
+	mutex_unlock(mutex);
 
 	return 0;
 }
@@ -594,12 +611,13 @@ static void kernfs_unlink_open_file(struct kernfs_node *kn,
 				 struct kernfs_open_file *of)
 {
 	struct kernfs_open_node *on;
+	struct mutex *mutex = NULL;
 
-	mutex_lock(&kernfs_open_file_mutex);
+	mutex = kernfs_open_file_mutex_lock(kn);
 
 	on = kernfs_deref_on_protected(kn);
 	if (!on) {
-		mutex_unlock(&kernfs_open_file_mutex);
+		mutex_unlock(mutex);
 		return;
 	}
 
@@ -611,7 +629,7 @@ static void kernfs_unlink_open_file(struct kernfs_node *kn,
 		kfree_rcu(on, rcu_head);
 	}
 
-	mutex_unlock(&kernfs_open_file_mutex);
+	mutex_unlock(mutex);
 }
 
 static int kernfs_fop_open(struct inode *inode, struct file *file)
@@ -753,7 +771,7 @@ static void kernfs_release_file(struct kernfs_node *kn,
 	 * here because drain path may be called from places which can
 	 * cause circular dependency.
 	 */
-	lockdep_assert_held(&kernfs_open_file_mutex);
+	lockdep_assert_held(kernfs_open_file_mutex_ptr(kn));
 
 	if (!of->released) {
 		/*
@@ -770,11 +788,12 @@ static int kernfs_fop_release(struct inode *inode, struct file *filp)
 {
 	struct kernfs_node *kn = inode->i_private;
 	struct kernfs_open_file *of = kernfs_of(filp);
+	struct mutex *mutex = NULL;
 
 	if (kn->flags & KERNFS_HAS_RELEASE) {
-		mutex_lock(&kernfs_open_file_mutex);
+		mutex = kernfs_open_file_mutex_lock(kn);
 		kernfs_release_file(kn, of);
-		mutex_unlock(&kernfs_open_file_mutex);
+		mutex_unlock(mutex);
 	}
 
 	kernfs_unlink_open_file(kn, of);
@@ -789,6 +808,7 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
 {
 	struct kernfs_open_node *on;
 	struct kernfs_open_file *of;
+	struct mutex *mutex = NULL;
 
 	if (!(kn->flags & (KERNFS_HAS_MMAP | KERNFS_HAS_RELEASE)))
 		return;
@@ -804,10 +824,10 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
 	if (!rcu_access_pointer(kn->attr.open))
 		return;
 
-	mutex_lock(&kernfs_open_file_mutex);
+	mutex = kernfs_open_file_mutex_lock(kn);
 	on = kernfs_check_on_protected(kn);
 	if (!on) {
-		mutex_unlock(&kernfs_open_file_mutex);
+		mutex_unlock(mutex);
 		return;
 	}
 
@@ -821,7 +841,7 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
 			kernfs_release_file(kn, of);
 	}
 
-	mutex_unlock(&kernfs_open_file_mutex);
+	mutex_unlock(mutex);
 }
 
 /*
-- 
2.30.2

