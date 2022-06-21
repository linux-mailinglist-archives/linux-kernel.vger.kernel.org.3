Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 364F7553BD0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 22:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354441AbiFUUsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 16:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354379AbiFUUri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 16:47:38 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67FFF2CE2F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 13:47:23 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LJ1TDt009747;
        Tue, 21 Jun 2022 20:47:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=OS9S5jZ24zEy73Cm7uAUAFvZCXws3b/bjEo0HPBfB0w=;
 b=u2in5/fvhB2Rvm/Lk1OxU+3Xt+9bUIb7/O8oLqoZEtKXBPtSdXsRH1rsGTs3Sf8PN1f9
 K9CH/Q4b8LGD6KWPtJN85zdoNtRZB+ddBLZ71+GUm1dDFydQAXhWvCPfDN5saS8FWqA5
 tdbyXhDf/EfOQX44urCIQnQpFsngUh+wZqrSe5kIb3DpojAJD+QjK/J5yTSrrJO9oEtt
 1Xf9unT9thY3Jbj2Pa94IXRZow0Sn5DofQa/tJPvEqvriBPIxZv9MfWyZTvkbns7IB0P
 djeHL4l0JGHk7Vwe315Ltjwe521As3C2GtbxNAsdDFDEoX4Xz047Std0gg+Hodzy3Wfz vg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs78txpcb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:09 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25LKembo037937;
        Tue, 21 Jun 2022 20:47:08 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gtg5us8n9-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N72bP7mLQ1B0uD4w0/1W2gvrNAz95xWW8nagGJKhv152GUQApKv29uVWlc5Oz9NWOjrhdG4/Q9ohDCaM66tyeOajRctHDniUzTgF5Pp/Oxe+4HMzrn5QXeYlPcUE+q4VIvB/ZW0khy/FOxW89KRasp+NlvPngfNtr3H+lr01WZHIYtzTf51ivol59A7p37utE87G4GZd/3Lt2AfDhGYzt5B9Sxyal1NmG2AtmBy39Or1MhkcW+/smIO4W+Lgy65ZPXbrJULKbKj6MxeSRzhPIqFnItU5ZRApmNqsu/9J0dtCZii8fOriOg2q5S1kuUoC0V6OhpSIpp7+k3IpT24eyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OS9S5jZ24zEy73Cm7uAUAFvZCXws3b/bjEo0HPBfB0w=;
 b=nVETNmAV33aYLvBUiRGi1XUH2FHR2htWeanZzDMAioBWVviGIXb/m/33uWyg5aZs9zNA3shnwgTxl2saJnHxqzeG/fi0napHItOqgwnqmettE0B2q4q4DlhKTtSr5l6oCSBFPZikMnkFsBIcqll87y+V8wnSp8wTKRYiK6qZRs3vQwbl2pTsYtaFdkQ1L6oYMb4JBcVkjQaHgu6hgYuUFtxPnaS9JiEKu3rx9FzqJXxKWvU6upcbvTDYgCbnEEdXEkI2HwCLvOBGWitTthOagAsnljdIjTHkmM3Qq7xpezDkKAl4NTXFcIKXOH8FxPi0pQyylj4BDc4ainaw2Cc+1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OS9S5jZ24zEy73Cm7uAUAFvZCXws3b/bjEo0HPBfB0w=;
 b=VKVGsBd2PHtnBv0ZVzQnnyvgUV8EIMpee6Y8oud9m96pANx0mrkj5F0FpGN2CgUTJA73DqaOx9L5ZXBCrAN9vHP/CvMPoLDPYUwrxwqWMb1DQo1UlVtTQoCpbs5rscyGbVfuAMuXrvtCiIlIuSjP3etaNph4YgnuPC4R9RFrPo4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB3085.namprd10.prod.outlook.com (2603:10b6:805:da::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Tue, 21 Jun
 2022 20:47:05 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 20:47:05 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon @ lists . linux . dev" <damon@lists.linux.dev>,
        SeongJae Park <sj@kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v10 18/69] mmap: change zeroing of maple tree in
 __vma_adjust()
Thread-Topic: [PATCH v10 18/69] mmap: change zeroing of maple tree in
 __vma_adjust()
Thread-Index: AQHYhbAMfQa+lTz1nEmvqJTkctKA1g==
Date:   Tue, 21 Jun 2022 20:46:57 +0000
Message-ID: <20220621204632.3370049-19-Liam.Howlett@oracle.com>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6940f4cc-0580-4dda-bb46-08da53c73386
x-ms-traffictypediagnostic: SN6PR10MB3085:EE_
x-microsoft-antispam-prvs: <SN6PR10MB30857625DEB9991DC27A2289FDB39@SN6PR10MB3085.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: plD7vKGQLfC8sLTiFhq0eQx83+C49I8PyOzlnc1jbpD56tcNRFS0Dlk0xxqTgH5O+2fB5iqc31IXhaLLwUIsfduDR500LAMMhz9DojveQnzlcIXJuRdmRJYTQzTZQhw01xSI76dS/Rf7rrV1uxklOxU8c68A/WDb11d/t89UmKTYCq+toXkKnFiLuTfl6TaSnTdhQTEWMm7xnKnSkeglrfF2XcDA8OY9wsPTQHyQvHBH7H72prJyXIzqlnEJ8bgDqxw/TEoLImXkCa6EBxVQxiAbyGd4Yf7obnuhA12JUR8dUAByaL7H//DLLn488o6ph3KvHmnYnGw87ONoP0t9Xqo7N57jLfBhyqtc+Wyv8pTw0KoqR9/Omy05KqbA5n/AF/AcTqSzyg6dTi3fQSp/52m6W72xYZ14CWsR4VMAtn2+SvV3VpSvvo4n9Tg507JhWfpziafWDQ4Oec/vGV67qgmASPe6Nx4oMkxVhhYXQMpTP5UcYlxUSkq+3Bv3JYV5yb7s7zsG94Sd5oWUcnep3ZwekEDzgMBNemVUSEMQhk/c56BAN+HRxgfPY7HXOZS0fyy9nKl/0APbCCeRiQNIXKrORamvn6gzWsEELHgfpnKiHFe1yA3PEa8WzeLPfYZnRXlmdKYMCDlTLxHMPHLcK9T65PWqT34d9K/VwdOwHutJgWgcs7XQcS1fyc9JRFyCctDASx651fvbqfzNfA/eYuPnV7xJ6vMNFEe9Cf2rG/ehQwnw8Q/PIRVLeMSAm3mmpK3811UNOsM4Pnu6eu6Y4CQ8kK1YoLcFZ4OEy7mUds4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(376002)(39860400002)(346002)(136003)(2616005)(66446008)(6486002)(76116006)(66556008)(966005)(36756003)(64756008)(83380400001)(478600001)(66476007)(1076003)(71200400001)(316002)(186003)(44832011)(5660300002)(8676002)(66946007)(6506007)(2906002)(41300700001)(26005)(6666004)(86362001)(91956017)(6512007)(38070700005)(38100700002)(122000001)(110136005)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?w/xZsrZHIkEJs7YXERLS1n6hPbWcg4fseH6H/EoQHu86nGUz4lI7uFbnsb?=
 =?iso-8859-1?Q?hzReFnj4DdWZo4x1ThwyTImWtQFuVwMtIdATsc/ZeMr9ADV0kE1QtNKamF?=
 =?iso-8859-1?Q?QfBFizaEETw7oGAygwnmYVNyyPJ2p2h4Rs79ZuhVYZmezYQF38ewnilud6?=
 =?iso-8859-1?Q?3YPKgiUfkpGtiF7f1Q7HzwGLKC2i9fpbSgY8/wXr5vgYeXDhDkrq0T0RMf?=
 =?iso-8859-1?Q?NDR+M5fjtTnEdhtiRso2RxhlNx9MZuESYJ4KDEH5CHxXIv8kM/8rMgJIkA?=
 =?iso-8859-1?Q?iW9kPdqjybPq2uux/ab+iwdmuHQGs5k4a8p/pSO/xys9JkXXLjVOx0DHZl?=
 =?iso-8859-1?Q?VcbFH4O1RAmEnNbmss1QDPzCoqKNRqADiElXWa8xy2lfJKzWgos+cI5b+j?=
 =?iso-8859-1?Q?XKWnUgkvPwC7r91No5L8iIZr01aWrfuS+TH5uQ/tcok+IP048gH3WsTOQ5?=
 =?iso-8859-1?Q?YyGkmedgNmTchsspz2/J6BxbEsYztEs6ziURTs0e6OaiyQ9X0ScTDLm6kx?=
 =?iso-8859-1?Q?iffJUYOOO/OcHNBCtsabvJdzc8zTVAE0wpM3tSo75+8i5mNQPJJX9L2O9d?=
 =?iso-8859-1?Q?cZNFyS7mnm7Bm8Dz0BD8dfe7vnDmR02NLXu5A06Y5Ga8TsrfHKDsi6kfR4?=
 =?iso-8859-1?Q?T0sMcmpdHLqwkJbgDwv4z1DRreOPFayOaVKBTy5EsF15rTtQUTMZhm08T2?=
 =?iso-8859-1?Q?lovJyYkbeN8QnY9jqUCDZX2Dp30cKqKosabPj7HCdZ0WA946IkokF5Bla2?=
 =?iso-8859-1?Q?GaxMxHj9H/TL+DR541llE3g9/r0ir/0ZgWjFz43UAD2UElX4I8lBI3OrMx?=
 =?iso-8859-1?Q?DK1nEXX7C1AM8hWlO+ZrHtfbKizb6pu3ss74HqGd9i1kCjuNps98I9xyje?=
 =?iso-8859-1?Q?5nt7PofKI3rspWWYUO8OPnRRwHVk9qoRF7Yu2EpOWTFx1yZs8PT+FhVA8k?=
 =?iso-8859-1?Q?FXiCmcppdPc8JVaZaroJenh16hna5pCZQkxzoMGciytGKgdKqpe5jy9ZuB?=
 =?iso-8859-1?Q?QcjNu9hByxVWFevvgl4EPLrOCJQQd709rO8WLYUrO+yOXjwJ6CjcHuI2D/?=
 =?iso-8859-1?Q?A7JWHvJoZ62KonYuBWV9tQnaRWM4v6rBBETohow/Pr8dc9+PpfGbStwprE?=
 =?iso-8859-1?Q?r3dd7mw7WirkV1JF9Q2mYheAUzfsUlLUkK9xdye+UCrLpGZRhkzQXwda7S?=
 =?iso-8859-1?Q?OmgpmtwY9++KnL8pGEvfz3g5Ce4EKd2pYIoqEgQRy0rWGvEEkWQjuYeA8O?=
 =?iso-8859-1?Q?3Eu2xDzO1QBhT3t5UlqFMNOiQ/AwD5mwzvZpWoIqPvnjZcbTm3MNncHRh5?=
 =?iso-8859-1?Q?bdaU8pJ9c+FMRacB6lS3ZHZGf4PJ75yp8BmbEt+w3OwPZBuAt4puPblwAV?=
 =?iso-8859-1?Q?v2cZ7q28XjwAob+plWN5mj0m5ixMW7DpIar2lxiGSNfp3R4HX5vYR0ZgVC?=
 =?iso-8859-1?Q?teH3/mJQYb+vzLLAywiYdZA+18Y7wCyHkUItm3DyJ9AOFapOSvwZb+OHtj?=
 =?iso-8859-1?Q?288pWo9A3/UbKTUUti1ikYY3Czz/32aBnG//Z0LeTwUfX+vbQwUToZj1zf?=
 =?iso-8859-1?Q?dDpSi+sKJfxvxCiWYtBgNQ3QdX5FbXYaE3qJwpuRDTMHYtWlUyfuNx4UPI?=
 =?iso-8859-1?Q?DgUsHmUnkCjbk9BOHz8tOi2Bmo5N6kdDREjXDuDTFEzGCL9edpfkZmAW8J?=
 =?iso-8859-1?Q?Q3L1GPLqLhVN4iVQY7k5VF/gRpn83vFvgTizxzRiekGSaBa0vObAYshV4y?=
 =?iso-8859-1?Q?6c0uyCeFUXpH9p7DAycVxrUk3rxRbFeDgVzZ7ZdjB9l1sVEgsaqrCCjY5l?=
 =?iso-8859-1?Q?aeipIpT+royOoi0+9OOeS2MUL6KXTkI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6940f4cc-0580-4dda-bb46-08da53c73386
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 20:46:57.2229
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QtDWbbzzDW8s47QsqXa4NLalPjsQ2kbLPjcGrGfWFNo7p56D6iRFHcu6N0hqn7hwFP4iFrdThhezGRwZwacg2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3085
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-21_09:2022-06-21,2022-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=930 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206210087
X-Proofpoint-GUID: kf0bNjfGrEVrMP_t_pcbRs4Hd3D4mNMq
X-Proofpoint-ORIG-GUID: kf0bNjfGrEVrMP_t_pcbRs4Hd3D4mNMq
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

Only write to the maple tree if we are not inserting or the insert isn't
going to overwrite the area to clear.  This avoids spanning writes and
node coealescing when unnecessary.

The change requires a custom search for the linked list addition to find
the correct VMA for the prev link.

Link: https://lkml.kernel.org/r/20220504011345.662299-3-Liam.Howlett@oracle=
.com
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
 mm/mmap.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index da480836f9de..7d6b5bdbdd1d 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -613,11 +613,11 @@ static int vma_link(struct mm_struct *mm, struct vm_a=
rea_struct *vma,
  * mm's list and the mm tree.  It has already been inserted into the inter=
val tree.
  */
 static void __insert_vm_struct(struct mm_struct *mm, struct ma_state *mas,
-			       struct vm_area_struct *vma)
+		struct vm_area_struct *vma, unsigned long location)
 {
 	struct vm_area_struct *prev;
=20
-	mas_set(mas, vma->vm_start);
+	mas_set(mas, location);
 	prev =3D mas_prev(mas, 0);
 	vma_mas_store(vma, mas);
 	__vma_link_list(mm, vma, prev);
@@ -647,6 +647,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 	int remove_next =3D 0;
 	MA_STATE(mas, &mm->mm_mt, 0, 0);
 	struct vm_area_struct *exporter =3D NULL, *importer =3D NULL;
+	unsigned long ll_prev =3D vma->vm_start; /* linked list prev. */
=20
 	if (next && !insert) {
 		if (end >=3D next->vm_end) {
@@ -778,15 +779,27 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned=
 long start,
 	}
=20
 	if (start !=3D vma->vm_start) {
-		if (vma->vm_start < start)
+		if ((vma->vm_start < start) &&
+		    (!insert || (insert->vm_end !=3D start))) {
 			vma_mas_szero(&mas, vma->vm_start, start);
-		vma_changed =3D true;
+			VM_WARN_ON(insert && insert->vm_start > vma->vm_start);
+		} else {
+			vma_changed =3D true;
+		}
 		vma->vm_start =3D start;
 	}
 	if (end !=3D vma->vm_end) {
-		if (vma->vm_end > end)
-			vma_mas_szero(&mas, end, vma->vm_end);
-		vma_changed =3D true;
+		if (vma->vm_end > end) {
+			if (!insert || (insert->vm_start !=3D end)) {
+				vma_mas_szero(&mas, end, vma->vm_end);
+				VM_WARN_ON(insert &&
+					   insert->vm_end < vma->vm_end);
+			} else if (insert->vm_start =3D=3D end) {
+				ll_prev =3D vma->vm_end;
+			}
+		} else {
+			vma_changed =3D true;
+		}
 		vma->vm_end =3D end;
 		if (!next)
 			mm->highest_vm_end =3D vm_end_gap(vma);
@@ -821,7 +834,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 		 * us to insert it before dropping the locks
 		 * (it may either follow vma or precede it).
 		 */
-		__insert_vm_struct(mm, &mas, insert);
+		__insert_vm_struct(mm, &mas, insert, ll_prev);
 	}
=20
 	if (anon_vma) {
@@ -908,6 +921,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 	if (insert && file)
 		uprobe_mmap(insert);
=20
+	mas_destroy(&mas);
 	validate_mm(mm);
 	return 0;
 }
--=20
2.35.1
