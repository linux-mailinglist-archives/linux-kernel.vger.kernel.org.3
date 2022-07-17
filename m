Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C15D577367
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 04:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233697AbiGQCxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 22:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233593AbiGQCwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 22:52:25 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A4525EA1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 19:48:34 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26GJ8rr1005737;
        Sun, 17 Jul 2022 02:48:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=abMqZbLdf0WHt1xiMwAFRCe0AbMzYsXk9iJiduJWgO8=;
 b=aoGbOtHKGAc3Xv9gdmCu1XdPLqyhPPgc99KUMXGq7aC3mmacllQule58NWe48XCsyJ7P
 dUrQvIgTT5F8ai5IT6tXjF1s/ueeNy/jqlto2ERSqk2VEC5jx90pAMC5XuPpbWsTqIin
 Z+xhW/m3suWL11/rXNr7vfPjTMOSL0FsfVvEmcmlQL+e6MNwYiA7L/6k66XtoGPiMmnr
 iKYxiHU7AxHCa1fVasnXG37gl1r7gBSvGrAzJH/pPJVH8oKXKJaKRWcFLZP56vOLM59F
 Z8EbSaO8WBK0pgslw6/DJ0n7aFpcjszhXHXAAyiqeL32sVNYhF/4+pDj2li8w+ntOYyR 9Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbn7a0y22-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:48:20 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26GMXgi0012270;
        Sun, 17 Jul 2022 02:48:19 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1hq5j6m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:48:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g0bkavxr4vhu23ZUGoUyJNrWmwOtD8kHt/7ioE6NTBMBOOiOZeURVIK/d912c2mR6bGVzKMncQQl16X/4d6KeE3fPhIrVLHli9U7tcODgJgewYK4ulcUnOnBfvajJq9QFUOxJ2b02N4Tq0gQ/pLfEqqMTX4EgLRt8nxMQqzem8fsYVE5LLxBrxAwJdfcJawPAHHS9iwFD5y2LnpM2HUonuIJVyvTWm9Nvn15Dq6/WBZ1xmdVeXRu5EdQ0IqnLX8aTvEEpXsvJ0PpENRlzxDB+mR99lPwCPuuRzeD/0SWrdMjwMh++8F1vd5mjQClIjflbSVfYFvuQhuOIUp8S9Y/VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=abMqZbLdf0WHt1xiMwAFRCe0AbMzYsXk9iJiduJWgO8=;
 b=T6TajnZxLxdHqO8DMF17HHaPG91NA7DIB5lYzNHjopq9tNKwUS03xuigLgv+Vd7L8p8hbrk2YxWWzvO+2zRF87Ly7VeMbNNhYZMaP2LybTMwpqgizdtKPPO9W4WFWjxOgKqNEcjawKCpAy2KQrc4hhoPWervcU9YHhbA8zJpEt/BZxMgeSoYttzajhMGhld/pizJjxxs9GzB+ZM5zel6x+HLyQe+uB7ssF7fNKoR4SJDOEs6mc5ql7SJADNDOvHmYwV03j8AT3fZCEvT7Wh80Y5y5f94csvXP4m6d2Aj6YD2mTnizaQJfLPP1/r1lxpJF9epZBGk5n6K7TJMvPWWfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=abMqZbLdf0WHt1xiMwAFRCe0AbMzYsXk9iJiduJWgO8=;
 b=qG4hSHmE1iBS75wlrC7yxn8GoKrC2ZElZ4cl1/XlYFP9PKKJe1pyrYMSpksVBG97QTQXFXIerlFFFdAD+c+2t9Nw94eYeJMDYIWF+Ei2xOtDdwl9EBJ9xZd2cBgghnFjJCeLOceh9+UZrCmXB6ffAGE1NjMF5h1da26ISSbOJsA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY4PR1001MB2392.namprd10.prod.outlook.com (2603:10b6:910:43::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17; Sun, 17 Jul
 2022 02:48:07 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.020; Sun, 17 Jul 2022
 02:48:07 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, Hugh Dickins <hughd@google.com>
Subject: [PATCH v11 69/69] mm/mmap.c: pass in mapping to __vma_link_file()
Thread-Topic: [PATCH v11 69/69] mm/mmap.c: pass in mapping to
 __vma_link_file()
Thread-Index: AQHYmYd8g1a3sL2K60+mswEmDLQ+kQ==
Date:   Sun, 17 Jul 2022 02:46:59 +0000
Message-ID: <20220717024615.2106835-70-Liam.Howlett@oracle.com>
References: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b9ac6c83-4d76-4daf-0ccf-08da679ec751
x-ms-traffictypediagnostic: CY4PR1001MB2392:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zEZ53Z38CAtGrfjkK8u/5sBC8anM1LnSmJpj0tZ3KlwF0v1TYp267/nBCYYjlcgG7betvaLhWRzwaG8dYMJWj6jqDkoMkgEjsU9N9HJVQ/z/IrOW4iubUiTGWJL/CetK1ynY1XqpwQKH6/SJOIy58I2eM5t1RzEovsMqZLtBxtbvdmORpWvdWqrlXeAlo76uvPOkhrz1wMcKDn3zUWn+fFYUyckRLc/EBgs2E3OuGWqhbcHSdQzwy+wU+CAakdOY2EsQUmuz/r1JSxbswZO43r5LSOPNkQY5zgHi+lWz02QF/j08eMDvRJvY+QSnYfDnoV3Vp3ACPDs+h2FxyYbbSh7AltqxCQOfAvHcgYHgzF9sf+jXzE51PWwQFyEpYMcXrZ/jf53CfX7twr+rzCmTIhFxDWXWtqE2XgBDZrOUMuobl/jYvu5woFA6V095oZTMTZKN81NUB7jXgubSKMsAdW94fOO5oHIEEliD9nccODrJmbM/95Cnc/xbEmOqtNppg6Iz8RlHq631j++wnnuLuPM+XvvRNg+UGkjCIRM6l/mTlFwHXkrSxnmxg8Bu4Mh1IEdHvaghPQgv8/AgKjlWBxJwwu6Cudz2G2rrIH0t6JPmPaVN9l1agmTwRMRBWCN5+0YwaKD+5wrfk4knK3uSJo2fw0qqEeTtaKnPWoV0asvODRokqCm3Mdaq8+B9E5UWFhjrHFUeq4WChzRG+1MqjcTVG7I32kkiaXEamvSJIBM083DQuw7ifSG34fO0U9nqGIhY8PNwLlPet/JtwLJGZh3W2oy8jIKFyCZ7VkzUQNJ9Sb/6llZWs/ekoG58bC0Z9fG75uZHxeDbxavU4ZkUpA2rpFzoJGOK4PVr8cD8ZO9qi0OvhPof6UQQauPC+BfV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(366004)(136003)(39860400002)(396003)(376002)(8676002)(64756008)(66446008)(66556008)(44832011)(66476007)(5660300002)(38100700002)(8936002)(66946007)(2906002)(122000001)(86362001)(36756003)(38070700005)(91956017)(83380400001)(71200400001)(6486002)(478600001)(186003)(316002)(1076003)(76116006)(110136005)(6512007)(966005)(2616005)(6506007)(6666004)(41300700001)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?HAu8usdcJ77+PcdYE2sXtH4NqeTnjDRF9981EjG114pVS+Ysxq7DFc60yL?=
 =?iso-8859-1?Q?M8BfLOr4G3tyRHpFvAtoSMS+rPjf+UsOSHZ4i8fe9rsiDSDDu+sSRzuKIB?=
 =?iso-8859-1?Q?82PSvdsobtnIyv++Ps6Rgm3YeM43GzjakjOkYzyq0KZdyh6IfyKAcpdWWD?=
 =?iso-8859-1?Q?tO1ZHF2OSMYQEptaZojJ8rUwwd394Ljo2Z76/hwMFzVtNN8qKJGbp0r8kA?=
 =?iso-8859-1?Q?AMMmoMQcBPGU3jBS+YxhpzxFzlgKzKlcfR2xNy4zGVfX3vVf2isw4kXmJF?=
 =?iso-8859-1?Q?3v57SZ2OumwN9/fPdTfrqdacs/mp4C1KHLLFN2B6qG7CyvScu5faPQLW9Q?=
 =?iso-8859-1?Q?U3PyZ0p2O4Dd0eRzamzbz7s2fDiHuPr0A1zE3Kwe07c2oAFxjC0b5loWWM?=
 =?iso-8859-1?Q?cYoKEjTC3lTPYlI3OTCQdSJDU6h03UeSsdAPv1Or6UFjBvjogjZnJVsmMh?=
 =?iso-8859-1?Q?71mb6ox6g7LEhMTQ7gKt5FYsfBeT22sVbEXzMmqZ0MIlzuS0xbvIpE4/rZ?=
 =?iso-8859-1?Q?Be2sFCvV5+e48yWvoVbgSomHyR5vWPbXf91oZenYi7S76P73t9MHE9e2fX?=
 =?iso-8859-1?Q?gzZW57SdfDMZXuoD10lE8pOwEYhPmaLfvrdzV6EOSw2/mNS11Pgu3WQ3ET?=
 =?iso-8859-1?Q?d7N2luGfIy0Az3rXl7nT1d8iI2gWENbyjkVOTIPZzPpYAzfiAjMGXHaVZv?=
 =?iso-8859-1?Q?/rZsIP64ls3fkBEbkidSCIDaz6APvi5fpiaWj+leEpYJZrffVr2C8rN6vx?=
 =?iso-8859-1?Q?0kcO9LQSuy55xH/50Bl0BClPYrwXOta50j88tz7/g71W7/4800n44unThM?=
 =?iso-8859-1?Q?pU4F0cO6+07TZ+TLXERidIdKKROjLOzJqgYcnBkWPLdQnlWfY47MsUPJPF?=
 =?iso-8859-1?Q?hpYaWRUiSNd09feIGDDM122ww4TvBB9FaGwRZ/WrmrCL/3mNscRZ5qH9u5?=
 =?iso-8859-1?Q?FW/TDSUA/kqo1ZQBU0Cu0sWcoXfWF3s3Efu7CZ8t3GLJFFTF9DnWrABRPn?=
 =?iso-8859-1?Q?RTy+NoSqsyyiL5tSeLyGzZJaSNCpxtTCm8G1cHa8Uyz5IaSs9Mx/PMXjrE?=
 =?iso-8859-1?Q?8eYKFCD4kK3hRXeHxa4/f6jl1Rv6wAGXRQb+d8qQaX0SvQ3lvuCFHC9ZFt?=
 =?iso-8859-1?Q?ViFeuLDD2Zvqyos9Qgk1WDsiEmaqEM007RDOzYkfZ6Ipr7qqMM/RR25+38?=
 =?iso-8859-1?Q?O30BWan08+xxX5MHwN9Y+Uag+xB0PeTfzyOc5vlO+BpnHlJstg6ZduETf1?=
 =?iso-8859-1?Q?+W6kBknoSQh4Xng3rjYCzKww3AZfSYDqKIXomfgXiQcCdJRoRidSDsP1ps?=
 =?iso-8859-1?Q?RT0N7uoTfklA9Oazu6aEiRkYQ1IMkyZMI0DE7IMW8rwnIX2HH4U18PJdDo?=
 =?iso-8859-1?Q?D9EV8hsOqjG9fd+iRtpX945xJNoDOMwdQqsfI+FplmcXXihWzLNldQd7hq?=
 =?iso-8859-1?Q?KzV3spw5r/agIfxY49RejaU88vDX7QN1CdgimK81MgbTCypsDNHGR1WwF+?=
 =?iso-8859-1?Q?SgCIlaTu8XO+zBjQdS+BU0TnR21dufLqf5tlTZs1yUdzXp2IBHhAKSgcMm?=
 =?iso-8859-1?Q?mwNuWj9CEJDFq/I71fsS+s+ENmxOYTid+jGGS04Z9xPZIdZeYwHjJoPfSr?=
 =?iso-8859-1?Q?A/752tslZZ4f+inMskruaq7uI/550L2vs2ise8HaAKL1CsYWfchk1mUw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9ac6c83-4d76-4daf-0ccf-08da679ec751
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2022 02:46:59.5051
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uMyDt0vmIxrSl1FG9ioZZNn7ofqQK+TP2ikAgcwrDw54wGinvKwtX7BCA0T9We+yhiXRv1KCVGsn13sXqt7RwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2392
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-17_01,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207170011
X-Proofpoint-ORIG-GUID: YmOuFG259yccB19b06wMABH-b5KijmXe
X-Proofpoint-GUID: YmOuFG259yccB19b06wMABH-b5KijmXe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

__vma_link_file() resolves the mapping from the file, if there is one.
Pass through the mapping and check the vm_file externally since most
places already have the required information and check of vm_file.

Link: https://lkml.kernel.org/r/20220504011345.662299-54-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-70-Liam.Howlett@orac=
le.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: SeongJae Park <sj@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/mmap.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 1c35cd0ec4c7..d24a3a4b669a 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -246,6 +246,7 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 	if (brk < min_brk)
 		goto out;
=20
+
 	/*
 	 * Check against rlimit here. If this check is done later after the test
 	 * of oldbrk with newbrk then it can escape the test and let the data
@@ -322,7 +323,6 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 	if (populate)
 		mm_populate(oldbrk, newbrk - oldbrk);
 	return brk;
-
 out:
 	mmap_write_unlock(mm);
 	return origbrk;
@@ -454,21 +454,15 @@ static unsigned long count_vma_pages_range(struct mm_=
struct *mm,
 	return nr_pages;
 }
=20
-static void __vma_link_file(struct vm_area_struct *vma)
+static void __vma_link_file(struct vm_area_struct *vma,
+			    struct address_space *mapping)
 {
-	struct file *file;
-
-	file =3D vma->vm_file;
-	if (file) {
-		struct address_space *mapping =3D file->f_mapping;
-
-		if (vma->vm_flags & VM_SHARED)
-			mapping_allow_writable(mapping);
+	if (vma->vm_flags & VM_SHARED)
+		mapping_allow_writable(mapping);
=20
-		flush_dcache_mmap_lock(mapping);
-		vma_interval_tree_insert(vma, &mapping->i_mmap);
-		flush_dcache_mmap_unlock(mapping);
-	}
+	flush_dcache_mmap_lock(mapping);
+	vma_interval_tree_insert(vma, &mapping->i_mmap);
+	flush_dcache_mmap_unlock(mapping);
 }
=20
 /*
@@ -535,10 +529,11 @@ static int vma_link(struct mm_struct *mm, struct vm_a=
rea_struct *vma)
 	}
=20
 	vma_mas_store(vma, &mas);
-	__vma_link_file(vma);
=20
-	if (mapping)
+	if (mapping) {
+		__vma_link_file(vma, mapping);
 		i_mmap_unlock_write(mapping);
+	}
=20
 	mm->map_count++;
 	validate_mm(mm);
@@ -784,14 +779,14 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned=
 long start,
 			uprobe_munmap(next, next->vm_start, next->vm_end);
=20
 		i_mmap_lock_write(mapping);
-		if (insert) {
+		if (insert && insert->vm_file) {
 			/*
 			 * Put into interval tree now, so instantiated pages
 			 * are visible to arm/parisc __flush_dcache_page
 			 * throughout; but we cannot insert into address
 			 * space until vma start or end is updated.
 			 */
-			__vma_link_file(insert);
+			__vma_link_file(insert, insert->vm_file->f_mapping);
 		}
 	}
=20
@@ -3043,6 +3038,7 @@ static int do_brk_flags(struct ma_state *mas, struct =
vm_area_struct *vma,
 	struct mm_struct *mm =3D current->mm;
=20
 	validate_mm_mt(mm);
+
 	/*
 	 * Check against address space limits by the changed size
 	 * Note: This happens *after* clearing old mappings in some code paths.
@@ -3100,6 +3096,7 @@ static int do_brk_flags(struct ma_state *mas, struct =
vm_area_struct *vma,
 		goto mas_store_fail;
=20
 	mm->map_count++;
+
 out:
 	perf_event_mmap(vma);
 	mm->total_vm +=3D len >> PAGE_SHIFT;
--=20
2.35.1
