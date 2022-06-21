Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211B3553BDB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 22:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354729AbiFUUsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 16:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354392AbiFUUrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 16:47:39 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EAB52E9EB
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 13:47:26 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LJ5LR8018710;
        Tue, 21 Jun 2022 20:47:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=vwKDZlXMLcjdT6HGhktIKRl2aj+JQZ0QlCRqertCB24=;
 b=AgA3sYILHiSgwnaRKYJAsBieu1eEW6ktzyOxW41gQcUfBx/WXipBHoS7Bq6S+K0ZTnLq
 mr2MaNVuZj3pjR96IjfVWsw4TM38rZKtAFhbn0upVLxVgL7hdkFFnNedJXBGUiMvmJCa
 UGbr5XdibCoU36Y/EYvUdaIzCsAsJ0J3nZTWahvcpIGaiFKKr2AW4U09QpB1q6ijp1J6
 HFG4S3/fLcJdO/0H/8fLoeri3Vayw2dGkOMcvkpuunQ8gWD+a8spxUKqJ994UTNzmMr5
 Fie8GYrNzJIz+R8L4J3Amm0Q0CeNGAu6044jinO/shtX5lfzT3ti+QwpKx8Jy8faVOzp vQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs6asxpw1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:09 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25LKeUhY027847;
        Tue, 21 Jun 2022 20:47:08 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gth8wsp0s-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hToLmh9x245dwyg/HBUahiMziXMgqDeFCbdBVVAx/6KdqNbAU6cnGkIiBBAwg58k72q+ZXsX/2xyl+qmxIO4ujUMMB1+ES5QocxenW8eNcuHSY5LJu/nmV2pEaK7OUqxk2LOhX6HJOZzP2/h5pDVAlhv/6oEUYn+TKdy59lxEF/yO29g4mgvfn5WZy7zsVAEm5rMaot3Dl9mykPVNNqhFKor/pg9l/h0I4e7DrEPI0xyiFbfgYtTe3pQyquO6B/35hrHLEze+lEQ8bG+OSR8Zyfr2XmSrlqJf9zmZVWPzUlwa8B2/CFBanMTLEFJCz3M4c2ezki7qSoEn+q4tLMsNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vwKDZlXMLcjdT6HGhktIKRl2aj+JQZ0QlCRqertCB24=;
 b=L/MxCSaB6dl9FyIzeBAqe7Jh7WslwffHP67c0l93EPnVv7sluHxAkk73yKLWC4wOZrVnKJoInQT3hi56O8+Cvm3zFxagjMKOUoGAU0/HbwHeWis9OMjdJ5KLS6mY9wdEi1R7OdcA3xAbTMYUtWSRKhaN45Uy4JkRDBuWPw16pFvn3SXkcvKNp4/12NqT1CSexkmwZS1khqQtB+mHmZWqNDW44bhXZ8I76ngmzD3ZxT6X64/F06E6CRKIways2faL0rabcvRrnfYOLoXySvtU0O4P5Hv9h1i4394/BM+yGrw1lsl+UXXuyyGiW0wkhC2K3Ho1OfHZUXHTFApHHjF2sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vwKDZlXMLcjdT6HGhktIKRl2aj+JQZ0QlCRqertCB24=;
 b=u1O9za3Ien864NF10GTxFRCxdTWlgFvxqkcTkIavCXrt0uUUUPNzziYqXgdcVChofJnj7mIiLM0d3Emmw2/2DUBst0o6/w2ryIs5Eof4+jpFj+Nwy+mXs4HGEg9Fd1gYK7kmSOR9WisfuFK2IDhQ2H3+RqTi6Auoz1YHgl1BG0I=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB3085.namprd10.prod.outlook.com (2603:10b6:805:da::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Tue, 21 Jun
 2022 20:47:04 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 20:47:04 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon @ lists . linux . dev" <damon@lists.linux.dev>,
        SeongJae Park <sj@kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v10 16/69] proc: remove VMA rbtree use from nommu
Thread-Topic: [PATCH v10 16/69] proc: remove VMA rbtree use from nommu
Thread-Index: AQHYhbALi8I92wMw50CeOm7hyc7VXg==
Date:   Tue, 21 Jun 2022 20:46:56 +0000
Message-ID: <20220621204632.3370049-17-Liam.Howlett@oracle.com>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8a98c5cd-aa2e-4325-4c59-08da53c73314
x-ms-traffictypediagnostic: SN6PR10MB3085:EE_
x-microsoft-antispam-prvs: <SN6PR10MB30853AD51D0481783BA3740FFDB39@SN6PR10MB3085.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QoS7cl14829dpnP2n2HML/fPfemCDV1e+42tih9S3QWKVU986orN/YlmJxmAc8c1N7rIlYRX0FgiDBShr3ahMe2/PmUdu08g3TU6L0yqekmwcSxsrcbL/q2xyxTwi4UYpHxSt3xyHr9TkV7Af25qyBCQcgs6m7TWiHdmvDWNjh54lwXqySjgv8XibghHh2Q0MMS9lpIcsJRPro6OgY8zjW0l8vzVa+PLU1qRPG6y4ph4dCQ4KEIczJeG3dhp2S3fNMCht229lJzQESaV+GkcPmjtPcH0BwEH2d/QoWpgp0hJXcyDzuul0CVpur47OHpcB3E1ZIDvpF/TAqYa4uIuIAZwG+wCoMmfqljntXgQTzWYQqz0crraK9N3ZNZpZxZ5bMYaNINl4eCAERNWJvr+TOYB3Cb6HZ1eSaxBMK1B1n++htzDkoWOH0NUcxjv4JzIkkaZiYefSxeiqHyn0pyXYMPZKGhtcaa7tK8+U4+rQ2O/Ly2Tb+VheUtFI9MPxD1FMGFNy2roNHnO+JnNkehl1e5tdwRg8gQkxUUCWLgEt+Xfztoi32XJRc/GSmuoV4YChavjlI9VGj49KZPlMS2aMMZ2nCKZxUfITqiKZgAAhx4vVlaeQ4zEV7cgS/YBJocfo+3hfjd1iJsM6xadygQ81ZTrpg+xq9rMn8xuWiQ65rDGIJ4RF+kPdbyCH+HpeE+xXiV9fdBXfVq99u+OLlUvH5lc9dGW44g1PnfYhvLqja6al3gMy/yknZaG30XkH216FcqaCsTM+qggZTGzQqy59825VJWRg+NF8Iv3FCDpDog=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(376002)(39860400002)(346002)(136003)(2616005)(66446008)(6486002)(76116006)(66556008)(966005)(36756003)(64756008)(83380400001)(478600001)(66476007)(1076003)(71200400001)(316002)(186003)(44832011)(5660300002)(8676002)(66946007)(6506007)(2906002)(41300700001)(26005)(6666004)(86362001)(91956017)(6512007)(38070700005)(38100700002)(122000001)(110136005)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?45qNQ3+QxNKsgdw461hFdZ0WKI/+uC7PGfEqRunqbVr0H2w1/+MzUuGaCY?=
 =?iso-8859-1?Q?CygAu4fNw3cfKlhNIZFnsZf5DHvu0i1Ryglpfb6N07C74kz3lAN3O536jV?=
 =?iso-8859-1?Q?AtRKjFgTMzpoFh/f4YnmmfIBxYYmQ/acLdo/OqrxCXPWRzt/AdBT/nKs6A?=
 =?iso-8859-1?Q?r7MKKIjWS1t+WohvZhT4JhtPZ5ckn9OCeADbwVRNvxlbUG+cdt2AUu/yZC?=
 =?iso-8859-1?Q?8LWY6bqkMkwvznmHxXA7PrGeUWtQb2RfOFbAaHE/HqDMruOvr/aJter37b?=
 =?iso-8859-1?Q?7o1JoEjyLK56huq6oOI1a02bPJRFsilWxosAuh19hm59WWHHw+DwMEy1UT?=
 =?iso-8859-1?Q?0kOPBFqU2zybjiExIQwuk5NzdlZxVp1KyJ7H0FNb/xsE6K19FoI7q/twFw?=
 =?iso-8859-1?Q?M5qQkGd7Mvj5J9uDbvRiA+v6+RM/nNkitcG6B+KD4YW9P+V42Yz7hczEJ9?=
 =?iso-8859-1?Q?qe0LOkSaiV1jOXRnSf/m8xLVxGoaen9EpnuD7++VFvVMV8sj7J9vkERwed?=
 =?iso-8859-1?Q?ibtdO6LHDhjsJiCqbQgYD8KVIcKI4Wzy0q8wJ9XQji3qoRaZOXB8Nbtfrr?=
 =?iso-8859-1?Q?VsG5vVggZwDZP5vVLtOC0lexdQlzF41U5UzEB6xx6KMHYY/J77gKXEbrrv?=
 =?iso-8859-1?Q?huahTdrXRL8REobMxuk008lOatS0FoMJonj7HpFvs+90WwF9xX8zzsgGrv?=
 =?iso-8859-1?Q?5FYksBll0nKVGCcqVEvnBFLAb1yzDOdK/W3WC8UF297zjtWrWGVktyIghY?=
 =?iso-8859-1?Q?Gh57ksmoHjZmtfXb00jcp12lKQY3bH0DwohMSjzXR4EwBI3Eb/UNnJj9cd?=
 =?iso-8859-1?Q?+V2s8CLJFnN+lCRJqB15jEsaOz9r7WPdt+yPNiVD8j9E/UTyEScXSAUxjN?=
 =?iso-8859-1?Q?eVWuZndF2ZzsaOG1alZOSQfJJnSWK/ysbZkupgtvVn8A3j7E5BT7sD1nRf?=
 =?iso-8859-1?Q?o1+XmLBftHZScB6FT8SA/yDkVIgYmHRl66A3j82q9vYy7ZIZ3qee4ZyP9D?=
 =?iso-8859-1?Q?odtd9tSfGhPt4GqLHsRXxeKZRS9/3SuG0KSsvqyh3ZIbyMVOhkzZD2Hhwi?=
 =?iso-8859-1?Q?tbMVTJKTDqNCdw3CwqsOD2W2J9TXuZEuUX7UiadZwjch/rwGoIpMygx9jV?=
 =?iso-8859-1?Q?BBFL96lQ33KzDi4NNAjddrneqtP2H8cFwoPpzrcNgXz4+ujOkHDhMR7Un7?=
 =?iso-8859-1?Q?/lpse7/0GfXFalCWaOXPnCD8sCAEyUeMGmkPCqEMah9SeRCY+tVWcO+6bw?=
 =?iso-8859-1?Q?rX5UZh2NAHQkZ0vxcPqjeXstpTraNdrhXi6ogYd5cTkEMImm4qvDdrri3z?=
 =?iso-8859-1?Q?2c2ZZXGhsVqel+6fUZibW2acX49832v4tAGXMTam+CtDO70CtJamRxWUBE?=
 =?iso-8859-1?Q?ATn6LP9WFD6+z1YA0Klo5sHkI54GchGX/OwyOfqcd1AbukEelFVzWDBiM0?=
 =?iso-8859-1?Q?sEEJSynJ2Dusix6e3HSJF38jRt5mSBkbiEnqPYtxq3aEuGr1vytYua9rZ0?=
 =?iso-8859-1?Q?d3w8L7l0qqlXCPalIFztaBoVO5kJQYOvfj6UaPBtT86naTQLSQfnA9ILMO?=
 =?iso-8859-1?Q?m7KEK9+57sGQnbnKlOw8RfdzGRv/Cst+HlR3lQpCOJjYBa/F+U+2rXGpa7?=
 =?iso-8859-1?Q?yPSdq1g07/4OPw8CijEk60GXa1436iuigozo8BEoh7bghShgYJjy/W+5BU?=
 =?iso-8859-1?Q?OB3YdBr+PWeqdVkSrR94KFokrC7QaAqjhBQ46HZVvYa4a6+4BOsp1ye2FP?=
 =?iso-8859-1?Q?v29cNgyTbXHi0VJXSopJWF7LQjkPZ7IMl1iVAEVFHxFKNKPBUDgpNOuQG0?=
 =?iso-8859-1?Q?jygGr92alSG3/Xnjqip+hBlUedXW/gM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a98c5cd-aa2e-4325-4c59-08da53c73314
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 20:46:56.5355
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b/WwZz3GXq0O6m73376s0TlsY3wZ5W8nHy7a9N1qprpLQzhKjsQPsd+XtGHD+FwQ2Uau4TfZ6fS8YrMWzMEe3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3085
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-21_09:2022-06-21,2022-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206210087
X-Proofpoint-ORIG-GUID: BPfuOIwNZwmHxuu8HG7ciSbTia4b-iK8
X-Proofpoint-GUID: BPfuOIwNZwmHxuu8HG7ciSbTia4b-iK8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

These users of the rbtree should probably have been walks of the linked
list, but convert them to use walks of the maple tree.

Link: https://lkml.kernel.org/r/20220504011345.662299-1-Liam.Howlett@oracle=
.com
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: SeongJae Park <sj@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 fs/proc/task_nommu.c | 45 +++++++++++++++++++++-----------------------
 1 file changed, 21 insertions(+), 24 deletions(-)

diff --git a/fs/proc/task_nommu.c b/fs/proc/task_nommu.c
index a6d21fc0033c..2fd06f52b6a4 100644
--- a/fs/proc/task_nommu.c
+++ b/fs/proc/task_nommu.c
@@ -20,15 +20,13 @@
  */
 void task_mem(struct seq_file *m, struct mm_struct *mm)
 {
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
 	struct vm_region *region;
-	struct rb_node *p;
 	unsigned long bytes =3D 0, sbytes =3D 0, slack =3D 0, size;
-       =20
-	mmap_read_lock(mm);
-	for (p =3D rb_first(&mm->mm_rb); p; p =3D rb_next(p)) {
-		vma =3D rb_entry(p, struct vm_area_struct, vm_rb);
=20
+	mmap_read_lock(mm);
+	for_each_vma(vmi, vma) {
 		bytes +=3D kobjsize(vma);
=20
 		region =3D vma->vm_region;
@@ -82,15 +80,13 @@ void task_mem(struct seq_file *m, struct mm_struct *mm)
=20
 unsigned long task_vsize(struct mm_struct *mm)
 {
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
-	struct rb_node *p;
 	unsigned long vsize =3D 0;
=20
 	mmap_read_lock(mm);
-	for (p =3D rb_first(&mm->mm_rb); p; p =3D rb_next(p)) {
-		vma =3D rb_entry(p, struct vm_area_struct, vm_rb);
+	for_each_vma(vmi, vma)
 		vsize +=3D vma->vm_end - vma->vm_start;
-	}
 	mmap_read_unlock(mm);
 	return vsize;
 }
@@ -99,14 +95,13 @@ unsigned long task_statm(struct mm_struct *mm,
 			 unsigned long *shared, unsigned long *text,
 			 unsigned long *data, unsigned long *resident)
 {
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
 	struct vm_region *region;
-	struct rb_node *p;
 	unsigned long size =3D kobjsize(mm);
=20
 	mmap_read_lock(mm);
-	for (p =3D rb_first(&mm->mm_rb); p; p =3D rb_next(p)) {
-		vma =3D rb_entry(p, struct vm_area_struct, vm_rb);
+	for_each_vma(vmi, vma) {
 		size +=3D kobjsize(vma);
 		region =3D vma->vm_region;
 		if (region) {
@@ -190,17 +185,19 @@ static int nommu_vma_show(struct seq_file *m, struct =
vm_area_struct *vma)
  */
 static int show_map(struct seq_file *m, void *_p)
 {
-	struct rb_node *p =3D _p;
-
-	return nommu_vma_show(m, rb_entry(p, struct vm_area_struct, vm_rb));
+	return nommu_vma_show(m, _p);
 }
=20
 static void *m_start(struct seq_file *m, loff_t *pos)
 {
 	struct proc_maps_private *priv =3D m->private;
 	struct mm_struct *mm;
-	struct rb_node *p;
-	loff_t n =3D *pos;
+	struct vm_area_struct *vma;
+	unsigned long addr =3D *pos;
+
+	/* See m_next(). Zero at the start or after lseek. */
+	if (addr =3D=3D -1UL)
+		return NULL;
=20
 	/* pin the task and mm whilst we play with them */
 	priv->task =3D get_proc_task(priv->inode);
@@ -216,10 +213,10 @@ static void *m_start(struct seq_file *m, loff_t *pos)
 		return ERR_PTR(-EINTR);
 	}
=20
-	/* start from the Nth VMA */
-	for (p =3D rb_first(&mm->mm_rb); p; p =3D rb_next(p))
-		if (n-- =3D=3D 0)
-			return p;
+	/* start the next element from addr */
+	vma =3D find_vma(mm, addr);
+	if (vma)
+		return vma;
=20
 	mmap_read_unlock(mm);
 	mmput(mm);
@@ -242,10 +239,10 @@ static void m_stop(struct seq_file *m, void *_vml)
=20
 static void *m_next(struct seq_file *m, void *_p, loff_t *pos)
 {
-	struct rb_node *p =3D _p;
+	struct vm_area_struct *vma =3D _p;
=20
-	(*pos)++;
-	return p ? rb_next(p) : NULL;
+	*pos =3D vma->vm_end;
+	return find_vma(vma->vm_mm, vma->vm_end);
 }
=20
 static const struct seq_operations proc_pid_maps_ops =3D {
--=20
2.35.1
