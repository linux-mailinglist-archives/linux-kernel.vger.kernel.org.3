Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40CBB5101A0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351911AbiDZPQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352153AbiDZPL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:11:59 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069CD161A7A
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:08:20 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QDT31J025784;
        Tue, 26 Apr 2022 15:08:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=43PmIHXr1k6YaZx/2S8DIG8p0YvkmeQ8F7gAhwrHArI=;
 b=OQh5AFzLAw5uMJwR571OgfpZr4Kv3B3LcMZLt4aXeRJedj3cKOUw4TgguRoDe6Te6NgF
 l47tY0bJIHzJ4uMLbqtJyh9gmVrGYzMT/pUg6A0nu5yeJZwTlhezB5AFdQfAYq0h21+c
 PsAVSJzZ0vloUImwWHhhvxRc1LdpTebzGlVf+re/jUuKUXUK/29svfEw2BVZ+ECxuDlh
 NdYvWKDZMCXcfiL5KUBM9/2HfO/kZw8Yj7m98wE4PDk1w25JunlkLlNrCqNGMNAk1mhB
 Cnu1M9b/ZG/3RNzRWashgiBukmltnM6XL6aHEx/mUjAJHcL3Lg9suyR+j5x7aScpiKpd fQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb1mpdky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:08:14 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23QF6UIM037839;
        Tue, 26 Apr 2022 15:08:12 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fp5yjkvb2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:08:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i6OAPzn0fczkkX0O93mK0VFEW/ZgD88z/yHPJVrYI14K7gTMKazYAq5/6t+ThJwb5dWasQEsdv53gMhijeAcn/g+y8Alp7yqz8PDxLOrGXnxy5UyTz6o2/sdpnUAQa7o9lC9veGe0METslrW/Go6zyT0uzehnjDZu0fkuXUY/98CIb3qsKrVinF9URXbnUkr6hwAL1D4MZqR+4aWwIGZkC+nnvIfy4hSzMjJkK42vcaV9wLOf0DLAEhuI+GJCE9VWCM3EKqkxeWAp9FymOo0mpQ8kzcuda3asY77XEGoKEMNRbeNEI/h6v/A9xhPwlmcdWt/8ruHxzbc7riXoVdAPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=43PmIHXr1k6YaZx/2S8DIG8p0YvkmeQ8F7gAhwrHArI=;
 b=GY6itruHojWlZYO+Uqv9SAautgiSEJLgrzsUzNrYhs5OzflPM6HnN2IuRO+RqbcH25t/TYmxhEmPl/R73bM21LLm2/HGdOQkCC6B97OFEPMYDHnVnYDqpjfErwblx171JqEraZOITdtaMPA8A+NTQQv/7RqOLJ4MigYxMndzatzHTXOuUb5RzlMMn3swNHs+I3bBxOswS9L0aihUwLLWLILKfmsSKVaYbxYygiVwBqJG+ObQbhYezBFeonAMkUCcbUrpWWkOZP04EeuN1S9g/CTKNBTts8VPvOMNPNnYumXNzhWfcXjov890Ojd1RaPOIRsObimgWY3UJj89tFIuFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=43PmIHXr1k6YaZx/2S8DIG8p0YvkmeQ8F7gAhwrHArI=;
 b=ycu+XtGjliK9uMNEsW2N7NR5qmiUVVVffsaaTS1BC4lFwH7a0VCIJSs8dtuLCx7bADcbVxy1tZCa1F1quOoNYvh9hJKWnJpCvKDp8JIM/LI6w/erAY64s1F54jJP6wFZSXIx8Hl60U93I/TzEzVlP1QpiCAsdJY6sY7Mj7B3s4A=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB3037.namprd10.prod.outlook.com (2603:10b6:805:dc::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.19; Tue, 26 Apr
 2022 15:08:10 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 15:08:10 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
Subject: [PATCH v8 69/70] mm/mmap: drop range_has_overlap() function
Thread-Topic: [PATCH v8 69/70] mm/mmap: drop range_has_overlap() function
Thread-Index: AQHYWX9DgCR1efvrWEGgkhRNVu3/sg==
Date:   Tue, 26 Apr 2022 15:06:53 +0000
Message-ID: <20220426150616.3937571-70-Liam.Howlett@oracle.com>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c7da9f81-7009-4acc-6384-08da279693dc
x-ms-traffictypediagnostic: SN6PR10MB3037:EE_
x-microsoft-antispam-prvs: <SN6PR10MB3037276339FA6EED246FA126FDFB9@SN6PR10MB3037.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jfL4x9c+4//faz2TjircQNtYSv97arOHmM6EPBC0MgJW2Y6UEORNjZhRS0g9eAL3OwWDq1BRM9W1e4EhUpxDtYziO8KGLSPnbmXSxQOnGDhRDs8Lm1psN2QvrPWYg9RgDy/+fjzdxLq1BAQ0V0/RlopFVrJr1Owt/5SFs9o9cFU8aZsRSDXLvAiZuSG7oIpBUSN3SdNso4TpwIEcB50EPucbXvj+X4K/DG5s7HHC+L4AGPspX+y2vak6GGXKl7hVh2zE7XImPmGXdpZJN8gvawd01OQBn9zD/eXqQaLkRn88cPvmh8emUoGoSbYemyxTAyWVPi8aXqkV5/jHRVJM7UtCp94Ycoq2Xu3AixkpK76csd8l/cMa2LS+1pralUIOfdq0HY804fhHZgYqENJCEvr2YrCC6VY8PH7TXuQoh6MGxonpZMlOe9ty9rkzVyqSEb/cv7ux0j7Ks6m4BtmKtI51yQX81jcCc4hQv1+l7CH+vAbBsMV+9cjw7EPOIlIsUqgUFKvrVbI9z7/ljQXmrAxUmUoll81XM5KVbDjBgHxaCAbPbL0VJyUb8FjATRFeD5Pv/mPv3ctNv3Xf+Ajo7WdaQ+87PAfLEMX42YCsTHnNAqxneilD6sWwFsui64oFrL1UaPI3cTDKMCX6dOfYsBPARCdJLZjuXh/6Iqt5RnP7LX3e9wF/8ljwSZGvOlD2bsJf87pKrxRQkp99P1ccRA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8676002)(64756008)(83380400001)(66556008)(66476007)(66446008)(66946007)(86362001)(122000001)(91956017)(76116006)(44832011)(2906002)(38070700005)(38100700002)(316002)(2616005)(186003)(1076003)(110136005)(5660300002)(6666004)(8936002)(6506007)(36756003)(508600001)(6486002)(6512007)(71200400001)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?dqec9hNAXzEy26AZPzaJ31nwI/nMq/f6FmqASkGPw/miDa2oEjetRFpP4l?=
 =?iso-8859-1?Q?xyKaiUQHrj2XqG4uGpTLMcy/r71TjFJoiJIIZESVlCsAPySQVof7PKXdg5?=
 =?iso-8859-1?Q?fcpFDSmlnLe0dmmqW3GLtCBTHIZJaPNwxSZtbK8OcWWI+3r68TWME/tg/S?=
 =?iso-8859-1?Q?qRl+HNG/MgTpdoBS7+xYz5x/jDGdHc42+mZUgvLkHF7av1VIJLiceRFyIw?=
 =?iso-8859-1?Q?v2a/AqcXhFON2tBNYBovhSzfm2doH/LDDkDx0YHCTEC60imTmY7gs27MC5?=
 =?iso-8859-1?Q?+X9Lhsk+fVbWh0T+dUeNZ0WBLObxkHA1uD7XjuL72qFVJ6vsz0Sub2/AKi?=
 =?iso-8859-1?Q?SRTi60CBFyE103yFUFvI54bmfTFvfEIjtTefKoGCqsKej0f+ASxijjt1t4?=
 =?iso-8859-1?Q?IOJADw2LWLlDdwRgyjMN4dfiRtlMHfARPD2A37fwq/TIqu+H/eJj6taGWp?=
 =?iso-8859-1?Q?s++5ahTe2tyrJHUHnC4QbTlHqmbIo8YgviOXQ0V75BC4qQWh4F86agT0va?=
 =?iso-8859-1?Q?v8Yes3a3ZSaWXBQbpPpxyLCYGStDl5L/vFceGdeQyU/X2Wj/LA4uuPSy3m?=
 =?iso-8859-1?Q?9S0qs1WcYXN6CoO5WLc7pI4C7BPyZfXJAgKSzQRuecpEK2R2Xx8ooInRkb?=
 =?iso-8859-1?Q?9DDOPee+IK6+prOjoIveIzrweawiK5YPReLlfzvkjLjjndx5wrvgTTrd91?=
 =?iso-8859-1?Q?YPSshVqNn09ls+2Lp8fXQTKyiOYaMJjdM8eTcSxS5/QEdc/j/EqUIB59C+?=
 =?iso-8859-1?Q?A0pd3x8lXNNZhpuLpgaRuqG6KvzIsy13nSzjxQqC4bV78fGX9tGzemkbMG?=
 =?iso-8859-1?Q?lTkGlpKjZ96Dbj7dLRTE3gQhvyRvI7tabeVkrW6C4RbFMrvj29wlEe3UmI?=
 =?iso-8859-1?Q?M7umih/x7drSsD3hITt94SQ3VtJYDgnaTmAt9MzwP+uAmz1gVoAG7WDv6D?=
 =?iso-8859-1?Q?gZtKZHstOhSmoDt/79HU+CkR6P8jnauJKUy07C0Ae8t/kZxNoIp2wwAOjz?=
 =?iso-8859-1?Q?wBULvmB/DasYVpyO0AqRqaxv5+6DCchlp27npYY69lez1bMkTywAX2piJ6?=
 =?iso-8859-1?Q?XwsowAIDP3xOpZnhXV9256o9C3U7dvOg0NFMkda7D8ZoggDh621D0MzzYh?=
 =?iso-8859-1?Q?1gADSZls/+9B2HP0LVARoPDlVIkkUYzUHK3RabBiUkGAsIMorFi22qEAnA?=
 =?iso-8859-1?Q?ZUOb6Pxz5J1WCXwj/ttC7a9NbSas6Njdl5GGMvgvkkbACBKxKZq+nHIrk6?=
 =?iso-8859-1?Q?shWS3kYVwz4G0pCpAtHOKW3qX32YoDqz/fJ5jEyCh16W/4tyddr0fnAmk5?=
 =?iso-8859-1?Q?/FXcZS2J1jjKa1fTpDbiwXL+pvBjOCc/W37PUCCJC+8ahn36twyILJUh8M?=
 =?iso-8859-1?Q?IFKhuUpZC/Z5DqJERF4rA8AjXEAmdDwaB5DuGLJj5TMzFkOvx4a6NWzKBq?=
 =?iso-8859-1?Q?/yK4aosgfUxAi6LlA6Us+WeYjCOrh2B/fLXyxpcLot4ZhEFDpkSFnBtfF/?=
 =?iso-8859-1?Q?qSckItmUTMjYAspbPOoQh/gEAJuT7LHh5flwsZi4aIC0HJv4o4/EqPg3TM?=
 =?iso-8859-1?Q?dDGZrqWzUvmdVwsekZJzxX0RP+HDyNkK6CH13rsR8RD4vH3GrXb8YMBM1k?=
 =?iso-8859-1?Q?/fycV8wv4/shDdl+D5faeajduiIIQL3FLhBmqhfFLcdnp9Yq435gFYujT+?=
 =?iso-8859-1?Q?c2rGKHOIHa6umRvRpTn6tjhLf9QRcZzUYPFyEc2PKR4HNolYCpEBR0UPgs?=
 =?iso-8859-1?Q?eZFbJ69CY9T8Q+RSXLuEJvp+LGYKYn9b9XQ5W/61Qh1X3wTrVFGLqBEHZq?=
 =?iso-8859-1?Q?TzAI1KaknQaAeV9MDohpapSEOZYixSo=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7da9f81-7009-4acc-6384-08da279693dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 15:06:53.8951
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T92OCH5Xfcn3D3U9nu5hv15Cdxz69D/BUS1qLQ7hB6UPft98AlqE8WdYKc56Pr1VZgKcZcRi/BEObmjAFsDTog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3037
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-26_04:2022-04-26,2022-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204260096
X-Proofpoint-GUID: odq0BKhqkbrDMzQ_rKgeTPh00bExZIEJ
X-Proofpoint-ORIG-GUID: odq0BKhqkbrDMzQ_rKgeTPh00bExZIEJ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Since there is no longer a linked list, the range_has_overlap() function
is identical to the find_vma_intersection() function.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/mmap.c | 28 +---------------------------
 1 file changed, 1 insertion(+), 27 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 50b616449c87..01985a0d664e 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -440,30 +440,6 @@ anon_vma_interval_tree_post_update_vma(struct vm_area_=
struct *vma)
 		anon_vma_interval_tree_insert(avc, &avc->anon_vma->rb_root);
 }
=20
-/*
- * range_has_overlap() - Check the @start - @end range for overlapping VMA=
s and
- * sets up a pointer to the previous VMA
- * @mm: the mm struct
- * @start: the start address of the range
- * @end: the end address of the range
- * @pprev: the pointer to the pointer of the previous VMA
- *
- * Returns: True if there is an overlapping VMA, false otherwise
- */
-static inline
-bool range_has_overlap(struct mm_struct *mm, unsigned long start,
-		       unsigned long end, struct vm_area_struct **pprev)
-{
-	struct vm_area_struct *existing;
-
-	MA_STATE(mas, &mm->mm_mt, start, start);
-	rcu_read_lock();
-	existing =3D mas_find(&mas, end - 1);
-	*pprev =3D mas_prev(&mas, 0);
-	rcu_read_unlock();
-	return existing ? true : false;
-}
-
 static unsigned long count_vma_pages_range(struct mm_struct *mm,
 		unsigned long addr, unsigned long end)
 {
@@ -3210,9 +3186,7 @@ void exit_mmap(struct mm_struct *mm)
  */
 int insert_vm_struct(struct mm_struct *mm, struct vm_area_struct *vma)
 {
-	struct vm_area_struct *prev;
-
-	if (range_has_overlap(mm, vma->vm_start, vma->vm_end, &prev))
+	if (find_vma_intersection(mm, vma->vm_start, vma->vm_end))
 		return -ENOMEM;
=20
 	if ((vma->vm_flags & VM_ACCOUNT) &&
--=20
2.35.1
