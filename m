Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76448553C00
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 22:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354941AbiFUUwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 16:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354702AbiFUUs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 16:48:29 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8DAD2CE14
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 13:48:09 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LJ4NhK004714;
        Tue, 21 Jun 2022 20:47:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=cVKYn7Vs1jiLcwWgQG/nSt9siIwi5QmNeA3tQSL3YHg=;
 b=kIm/AVqJCeFRXG9yUb3uskhrcDM4blGol3/ycoNARyJdlr/9+gApARDOg3vRcIgD38SD
 KV0WS96m0BbuMEECYOVWiJ8yExd7wbOKEZk8QYg/pyA2RnjUfPfrBUJYVpEMhu+zulY0
 1BMxSUFqhb84zqHQaaS7I2ggnW8C4NEi0pRAnoPJm8FM+LdIixNxS1x+eKbWUbpdOqlV
 gnmfDpEQdet/SE7JEnPP/HjR/ARessJewk6IiTIC7eWpemUYHf3ryZXo4WhO0sqgRjYq
 Zd8OMCfLads/uljlZIW79HNnJXEFNMnvGbL5V49qwjDJgxUgKe+0Mw8pvLKZvvGRecv4 Yw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs54cpnx6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:56 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25LKeiYN001682;
        Tue, 21 Jun 2022 20:47:56 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gtf5cutt1-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TOfs0qN+BF/86jJejhZ2xOzgylQoya2vtVoFgySv5GIaUiEqXvFPeISJmVr6nJKVLIwBiBLmcJzL5MNeoTFEw8xVle5Cjf6A2W5REG0Vw5wELnEkme7G0Yib3PyjzxgOUiLmW+VhPSS+5/z2KymBcOilsynr3M94O+TC8kNxwQt52GvhGgWZWIoazImR3qArPSGOchNT2W8vIOMmnDxCpponrmtAvqgYTH+uSdEgTqVnU4hgssw7IqUPJ37AogeeTD5LpGripbIHdzIGRn8MiZ7UxZb3sZfqJ/zYc1NvkFCq9CuclCI5sZ8rif8GmLxO9ZnmauAYCdkppI08OuznzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cVKYn7Vs1jiLcwWgQG/nSt9siIwi5QmNeA3tQSL3YHg=;
 b=BXirXxJeS5GV3RmgmrhwAgAD9TXjycIMKE78SS1vU9bkNn72lLuw5H7oqUhS1vV6U1Ueu3JGDWDztqRAQo0sE0f0PTk5WXoCvp5n/LiYUMHNH+0sdNJzzN4Uuq3berem4A6HecDjPmVZkJr8JQraEq20FCjAaRa5SJM0vVP//HLmaS6c4EJiAiM+exTzieNAEehcurreLJScU1VvIV04Mcz+akgLa8bqC4eDwE+eZbYfsJ4nYdlMF6YAVuW84IbLMh8OTXLYC1aBrduwSwVdcQumC8x8uev52rSU8Ws1ulLCKmNWtFUGmPCgFwzaPsyGxO277yZf/JYkIEk0ic/QCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cVKYn7Vs1jiLcwWgQG/nSt9siIwi5QmNeA3tQSL3YHg=;
 b=yhAfaU7SIRpAIIkcb2WlSg08/C11eHR8gRRpzSFmEjhNzyxSyFAx3bnV4SrGCAouD+oddbsJtUVlPvwuwHzpBfeONxFHHl3Xrug2Ctr3A9nHXteipX6RI0ZSC0EjK3XaLtlO4CUy4AnhdkFdNCysHwiS6wkzWgLGzrXxjoWqvEE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS7PR10MB5392.namprd10.prod.outlook.com (2603:10b6:5:297::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Tue, 21 Jun
 2022 20:47:53 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 20:47:53 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon @ lists . linux . dev" <damon@lists.linux.dev>,
        SeongJae Park <sj@kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v10 51/69] mm/gup: use maple tree navigation instead of linked
 list
Thread-Topic: [PATCH v10 51/69] mm/gup: use maple tree navigation instead of
 linked list
Thread-Index: AQHYhbATc7O48YXCZkOvTgxYbcO79Q==
Date:   Tue, 21 Jun 2022 20:47:09 +0000
Message-ID: <20220621204632.3370049-52-Liam.Howlett@oracle.com>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dc5b3e27-b8e3-4a3c-c76e-08da53c74ff2
x-ms-traffictypediagnostic: DS7PR10MB5392:EE_
x-microsoft-antispam-prvs: <DS7PR10MB5392B280C0A367EA0985A8C5FDB39@DS7PR10MB5392.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pK1R+KwL3Gum4gtcAUdk5DTm8BSIrom+nucQqv9JPkmbAK6GTJN/yjVMSiVEAt3+kNPGPZXpY7JYwtz3F1+XTxiEzOlRORLiYXOkIki3OOPCIBbMCULOAWFy7KUfVxAbq1uXfdg97nfSbvWpiE5ODWvkCuCNejuopfsoV6Vwta863VU5/dVvdznoaPz0eEEgXum4pczDeJzaD0baQdE1p9PSxjrjgl82IeHYWL9Sw58ir/qWh+UaRKF15wrkOIN+2WxLK3jzmAud1i1fXdf7SYYPyYjbkxYKXDd0Tw94t9EM1a56gOsiJ0vOCcvA29Yi0py8yuZ/4SxMEX+AV4Oe5vFoGiI8r0DN5W+FP4j9ctamosDdaO7qkzrNhor4ewSh69l1jScXcSjd+TMNtKzwGxCUvRkGCKcmOkW4M2fEt7S38L7UiztRUVV6cqf4aTiVUsIODZmnjqE2IS1cM5cjmldCxNWY1ldwjzJpbUeFgVjF+HlealMjmOOteYQhvhNj7xGoqcyVff3ZbsRgQqQZvnH0QOpcXxR8uEqpZlT9ozrxRPyiPdhWO47sRilmALqmr9LVr66xX46O2BV2hhERPMsP429u1NuYAKiZ566P27zbeQVuKApFlAByCQ48YUm+P1lNETBhujWDpul3gSW4lEDr6K4EDhAQgokEs3gPigHNi6dN74dtz5JfHJbe+cp2sD9XyBFIoqDNpKUXXftQHtuQ1vqHeyAR9D+N2sH/npB7uAJXVnYmqmcrvEuhmJHMbtLM/y9LoKZ50a+4sduHKP4Ctfn02o3zm0NV00BMPtY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(366004)(376002)(346002)(136003)(41300700001)(6486002)(38070700005)(2616005)(186003)(86362001)(26005)(6512007)(38100700002)(122000001)(36756003)(1076003)(83380400001)(316002)(66446008)(66946007)(2906002)(64756008)(44832011)(6666004)(6506007)(8936002)(66556008)(76116006)(66476007)(966005)(478600001)(8676002)(91956017)(71200400001)(110136005)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?sbPZUq+hjoSrsofI1pG1qldzksICYNFZp2FjFMUcrx8UMMKnRHBlIzX2zi?=
 =?iso-8859-1?Q?akWQmQCMmxEggn5zRdmFRVH5aUHlQvZMQfhyJ5b3wzfwSEEWI0uz5bpL/z?=
 =?iso-8859-1?Q?D252Xht2Dk6eTyBjlQmzpOEO8wGEVirD2IPwbOzRlw/woq9VvX+3AIbVCz?=
 =?iso-8859-1?Q?EargYv3LS61v0A7rgWJfdeOz/y116bW01SOem1+bjjxgtIOCGe0AsAWX3n?=
 =?iso-8859-1?Q?gFP1pxDQr45DwZdo4utVpxry/bgMrsQ3ppwiJBjcTfPrIam/ViqTKdQmwT?=
 =?iso-8859-1?Q?+RSiZYGg2ZFZsDNR2QWBnclIZBgfxhI3WvIXx8gxEadrM+G9JBKrZOFv7g?=
 =?iso-8859-1?Q?D2+DvEp7CqqbgZamnEOesLLQZHdGMqerDKY2H8Pk3W4C4k2CDEObdRBsPO?=
 =?iso-8859-1?Q?UrXsReA2k6Eo+jsoJztCh+HMpFgpq3AlJzycyGbE/CZFrv6Z0P4KPOgi7V?=
 =?iso-8859-1?Q?8xxHcBjzgnWvz5vSgYLt4JFtj6662jwA6+qkhpWwn/3GuVEYUOw2V5z9co?=
 =?iso-8859-1?Q?5a3U9ZorNPQThx6xCiKw024Ra2s0Qu2QUqlx+aDEoELXoQF4PCJ6gW+toO?=
 =?iso-8859-1?Q?Vyp1+JOhGq0GRZ8C4lMKkz10G/6xiRl2/kpyeVFwr6atf2DFLXARTDUtLd?=
 =?iso-8859-1?Q?+85Jy3CV4a48gDMyA3iwTV2xshz1MvWo90uwo0y4XWHiZvrYAWZnZ4aoGu?=
 =?iso-8859-1?Q?70SryJJgW1Nuo/8wN6HvwgAhzar75Ex35BuTYFGvga8pRIEQn7ZakQqPrw?=
 =?iso-8859-1?Q?TNFZ2aUdr3CG1u6BagKx5oOU2YAra0TcJuPLmuU6ZPhSbri23kYfvKIH2f?=
 =?iso-8859-1?Q?DnCzeU34J7SH23I2ToDcECIh0EGJzM6sypzpiVu1ZislfgFad2rfdRLc/y?=
 =?iso-8859-1?Q?X6YFNEicb2ctOMDQXPT4od7Jrqn3OfUHU2PQPqdOlIa7GHWSvJUk5rxwzF?=
 =?iso-8859-1?Q?kzgN4CWSa+1vAZBnPptKjdyYr8erj2wYd3nWVBIO5ZV80HgjMz+7ethvVn?=
 =?iso-8859-1?Q?GXhzpxPeveWWf4UhIQKjj2NiWcBjVgPny4sDTsDDBD1HTw0lcOaL2eFS8e?=
 =?iso-8859-1?Q?L1hLxK+GOWAptXLRalD5yEIoPZEwV0/olZ1XntHCpELPN5g0giWWDXh2xt?=
 =?iso-8859-1?Q?OaHrV+GXjcq1y7EZ6SP15FatKq7yi/amzsosN0ZE2fy/e29KYHgBYGnBGO?=
 =?iso-8859-1?Q?evjvoTyV52RvGe/6aoIUXh8fOqB7C7X6kGFRnciURxGvWJRcZ1sSE65qaV?=
 =?iso-8859-1?Q?asFL53GRG+kavb2Eiv4AkcpRPCHn61StVEHM9wl7ireTK2oH0Q1xMyJttb?=
 =?iso-8859-1?Q?XJkw2FkGDZO6HdlLVEcyYXKrKfGvnIStEWFv4PDukLKetihZ8EyFWUr1O+?=
 =?iso-8859-1?Q?HiPhLnA3RjAOJbU5RwDl4RJsI/4Su7x/TlXnwsEv+FhO/StxxUmhnAtBz6?=
 =?iso-8859-1?Q?kvgGpu5kSTGW0aCQTTzM2LCxAhoESXI9+Lp7dyx8wjQvQdGErWcxvhQqyO?=
 =?iso-8859-1?Q?g1YuDvrNksN1tumHxCC6remM0ntCOrSKElpWxuW8fDDtIOCf9oaeEJGXf/?=
 =?iso-8859-1?Q?wdO+zw4It/LGFCepdI/g0VGEPNp7KvQQTurINl6sq/aGstlSbS6V5czAY7?=
 =?iso-8859-1?Q?iLOJ9at1y4U+udj7db/rAtxYdBNcj1MZ2xQywjfB1qfLyQyNgEMiQsQgvu?=
 =?iso-8859-1?Q?ksa+bvXUajTH+cOK9EqtK1hydZvq6ARMXSniD59eQksK3XdchpH5EO02lE?=
 =?iso-8859-1?Q?WaXvwIg1GYzYZq/mfmUbFKGuaIRr4/tWxte7LmqhZygiJDHLTu/oVHfm1W?=
 =?iso-8859-1?Q?c++fyiWXI7v0G6T8Jk/C4gJ1aTl7FKY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc5b3e27-b8e3-4a3c-c76e-08da53c74ff2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 20:47:09.5815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JOQlD37U1Fi+SV970swxDUWVRk6B0NYcyd5jdEm8nDvFPgYnoaY4NHKWpYaYFTVgN1NxuYbkQ3OnW4E8HOH7Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5392
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-21_09:2022-06-21,2022-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206210087
X-Proofpoint-GUID: Bkbc7qo0JcuhX2h22lrTz8Xlu1RsjDRv
X-Proofpoint-ORIG-GUID: Bkbc7qo0JcuhX2h22lrTz8Xlu1RsjDRv
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Use find_vma_intersection() to locate the VMAs in __mm_populate() instead
of using find_vma() and the linked list.

Link: https://lkml.kernel.org/r/20220504011345.662299-36-Liam.Howlett@oracl=
e.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: SeongJae Park <sj@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/gup.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 551264407624..3c1eeadf58a3 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1609,10 +1609,11 @@ int __mm_populate(unsigned long start, unsigned lon=
g len, int ignore_errors)
 		if (!locked) {
 			locked =3D 1;
 			mmap_read_lock(mm);
-			vma =3D find_vma(mm, nstart);
+			vma =3D find_vma_intersection(mm, nstart, end);
 		} else if (nstart >=3D vma->vm_end)
-			vma =3D vma->vm_next;
-		if (!vma || vma->vm_start >=3D end)
+			vma =3D find_vma_intersection(mm, vma->vm_end, end);
+
+		if (!vma)
 			break;
 		/*
 		 * Set [nstart; nend) to intersection of desired address
--=20
2.35.1
