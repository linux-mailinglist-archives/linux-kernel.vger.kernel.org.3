Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C07957735E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 04:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233424AbiGQCuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 22:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233276AbiGQCtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 22:49:04 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77CE1CFD0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 19:47:35 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26GJ8glW009607;
        Sun, 17 Jul 2022 02:47:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=jEwSgLQTZcZTeoMs8f4vND+DNkMImNDsd8CCWIy917Q=;
 b=pY0nXY637isz2sTxGQnxaL+iInGtrtcZJ4juX6pR8sXKyK/LFI6xMzpRR16ztBreQGfo
 r+sB7Dc498TtUkjaAy6XOeCGy7xo+LMHyyfrQXqfeHsfPDaLDlazO/a08mufUDrlFOzD
 4gk5OTPoaR0ItW4kRk3v4TrlycssJg8f485SvrCiLMwXBjiuAC+g/aIRQvaJNSWwEfmk
 pKc8y2ROE57+AqGnmMNhlnbE4fSETetR0JdAB1IjL0Kl9y6HTDWfGsUiGYxd6j/NFjXe
 LxBdeSH3rwFiQQTmgLASav8ZZScFryyb9t9mlwvwJ+k0T5mm6Ugp+fhcgDHOHyzt95iE mA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbkrc0yna-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:47:29 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26GMYISL036113;
        Sun, 17 Jul 2022 02:47:28 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1ejp6a8-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:47:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g/zHBGkhgSzrj7sJcXC14RSEP2mGTfPuVNLmUxjX5L3tJmNnkj0ynnnBigVKLowNYHij61d0JhDEbi6xc6vm9SciyNEqG2u4ClW5JPCnWtoihn/lsuqu/29f5zPo3H0T/gIzNsmPg3EjlOka3jxlk5lv/LNUaHOLaQvgjOXnLczv0u70fdnwsubaVHLZpavIOeuAn0zE91dKEAANyz0Pp2Kg23RLyxsNeDiJOHe+NdScZgTlmvltLNTpPewIuSmtri0v9B1EStrLLphnCEONk202N8an2mt8M6wNEWEybyIyx13KNBY+M7cvLZyexP8JBsEJ5NPLZl46zuKrqTBF/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jEwSgLQTZcZTeoMs8f4vND+DNkMImNDsd8CCWIy917Q=;
 b=KgGvrTm+ylH5Q66AyXxD0nb4YzTij+9ZDtlfk7Q9eeki/8TboA0ZwYFaLcc2EQK8tMM55kmFWyl5RlA7CgzLxCpMz8udxQoMaqwUbo9wxMg8FFRk2F/RR052kynAHcxbjczY1icbP+DyKdRmiDwfBcSoGe1q+6ETyzoUxXr09jQ7RJgSvqf/RkSlnn+P5vCnDssjnZarvjn0DH0IXOf5X2HqLZIP8RkAGK2xOl8r69X+vpkQbI2f43BqjRRKEgS3A0FOoHdhzMv3Qjqgi7rPU/AoW8cy8WvqCV6ChWmxdkpbyr5zv1GdX2je+1rvZASdOVcQQJnS+cWgULkzhRwEhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEwSgLQTZcZTeoMs8f4vND+DNkMImNDsd8CCWIy917Q=;
 b=CjvWXDwCppxLJc5CKd21oU/pIoEuasovF80T+PD5nUcXt0q86kYYt18cNNg0UhI4VhInpXxeeu8YP+qEQ25Vtrfx1vJfDbPwicttYEh0r+acTG7u/SmBo5OxWMU+znuii0uUO5U/QEOAx2b/AHm/VxptMjfFR5c39zUTEjGHqx4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB2799.namprd10.prod.outlook.com (2603:10b6:805:d9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20; Sun, 17 Jul
 2022 02:47:26 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.020; Sun, 17 Jul 2022
 02:47:26 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, Hugh Dickins <hughd@google.com>
Subject: [PATCH v11 38/69] optee: remove vma linked list walk
Thread-Topic: [PATCH v11 38/69] optee: remove vma linked list walk
Thread-Index: AQHYmYd2+aLsK+TMHEO3WjT+LsCCwQ==
Date:   Sun, 17 Jul 2022 02:46:50 +0000
Message-ID: <20220717024615.2106835-39-Liam.Howlett@oracle.com>
References: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 99d5b615-eac2-4710-f5e8-08da679eaf3b
x-ms-traffictypediagnostic: SN6PR10MB2799:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9mzj+QFPV8CNEQiZ9kGxizx+kXAsj0jenCXvw8RVe0epUzlngdYFV0I7KlVyrHIecOxOSxYp5HeuBsO0rPwo1PUOe2jwUYNkKf7ZIcv3b6Jcue8egyXzWVwyI1cONl0eCHgQ8jTwsRuZuofC/0vD1DDQ+ojKVi79KobneSpPE/108BYnOqda+IMgpD8G5cgEGPoGLd4oCzA+JRyf5XMuWNrnuZyELIPvFW9T9iN16b8sXYUB8nV92FioBi6SDJ58641YA0LNXszLES2aGbJCmdi6yuNq+b+G4iD7TJrl6wXhAw++cGyv8AYOYoztTMpNxSNLkubT60a2d7Z/6mgzJ8f2nehUR/U+usbicaZRKc4eVzQhovaUQXrrrKb1Sl0qWf2igqY/1g5qeJb6kbdZvuylYa+3p8ytFKBatgHeQRIbxHfabSqYP+w4lM1OjsBjJRZ9NvrTqlKOqU7XdRo++8GG3aCOUHhuJdTVmGPJANBwtZL0THsojRhhSnwoPURJGLea9Y4J558CyLvA8bIoVpP9tVom1Zd5JF9bCh5FIG8fz3gVnIURRUWiFpNK3WOdI6WTUOA4NlO+xy9bh5ePdyqEIJHW4OigKZ33Gv4gvOdsHNdT2NNXTU0Br/vEwB8fQmRT6jiJNk5UyWZIhBI+s9vqzz/pTkEtyK8BKbMeYGzRFuN00xrqkdq/uOkEr3s4WMSN/IltrljzLyrmXWL0df30qKtqQHRri9TuVemtmXMWjyry0QaMjMI+LOIY9nScbzDdDQqH1r20kZnVwklPF/8Dv6cgioONAcFkSGNwGEu0tiVhkZsd1VLVjEqzfgnPAhRz7zvrirMaH8ZdsGjNj17UBF+DJIkAQCbpogNnJO7RGrdQyRfzLKgfdG/vQwxr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(346002)(396003)(136003)(366004)(83380400001)(66446008)(66556008)(64756008)(66946007)(8676002)(122000001)(1076003)(2616005)(66476007)(186003)(38100700002)(91956017)(38070700005)(478600001)(6486002)(8936002)(5660300002)(44832011)(26005)(6666004)(41300700001)(6512007)(71200400001)(966005)(6506007)(316002)(110136005)(36756003)(2906002)(76116006)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?OOONHetoYAxh3fAKLSqFxiNpbpNnIQfhQ7FdKueXXHb9cSOwT9WWvKqJnt?=
 =?iso-8859-1?Q?nI1Adgic8UAlD5Lmy8NipUSysz/lHjrSavWDC6BU22lqH0KgfV1lR6ABh3?=
 =?iso-8859-1?Q?FjBzljXmMUVQBG1lP8h4+akA/eFglL0FzFcnuCQG4qcauzwuJeccsL2VVF?=
 =?iso-8859-1?Q?Ngmy0LKhdjPp8Ao19cjRhjjctF7aXD2Xol6u3FlbRaR6SpQJdDfhtrSq3a?=
 =?iso-8859-1?Q?ZBTw8YvotAzR6HonpBBWJFzMlBNiZIfbn3htJ79MHuQHJZy13JG5nELs7P?=
 =?iso-8859-1?Q?utXzQzJCbUVT9Mh1pDI+PSMa5pnB6AGYW3M7hNj7JkCVu1hNpPVVKuWSAV?=
 =?iso-8859-1?Q?LGjeBYwe4X2GTiBXVhBOzsi500ZOD3b7JXV78AgsPvhCmNft4gmVRFCxYW?=
 =?iso-8859-1?Q?bOizNptBOJh6cds/AfARMhXISWp9F5xAQt+mQrVGteC1PL0wFE/SFLNY+R?=
 =?iso-8859-1?Q?g5+knLPBVwx/l5myQCAS+ZCfG+cg20EtAIW7X5ksnhg4kGO6K02MDG4DeZ?=
 =?iso-8859-1?Q?E9qVsUkvBvanrSrHjPmtagtg9nF7xf/TwKMToYQgtvtQtjjR21gI20lDcC?=
 =?iso-8859-1?Q?a71p7x0C8MTjqZFSB4fx++Ie8ihUabzelqrL8fwSKdx5yUudFC3Ryup0rY?=
 =?iso-8859-1?Q?IQjwyldvs0AOQqjtU76ZOqV0cg8IcYJCfIFsZhK7dZcFzSw9367TTy8abY?=
 =?iso-8859-1?Q?mwB8t0nkbwBy8gPhDJ4UNXKu2oXCAlNYlAKYWdpGs1bvhUWoRj2xc6LH0S?=
 =?iso-8859-1?Q?buHpdolV9RNXKENbpwLRfCCJcN/eN8gZnGJYPMeWKQsMbYP5z/o+GWI9Rw?=
 =?iso-8859-1?Q?qy4ARoZdQw0jUxzj9/sth2gJ4p8BhfgcqnStHoERD2tDRZE/odWrxPi6ny?=
 =?iso-8859-1?Q?xmhIp009udAEWJcKXzFMdK/smKm6fXhkbu/fRyVJV/xqWljn2iGRgy0EIk?=
 =?iso-8859-1?Q?bf8/J3+wjcWx06lMSjnfXcfD7UwrK5uWqQI85aQZlLo/dVLWuGDr/4wS4A?=
 =?iso-8859-1?Q?tGCoK9NKjt0uoFurqmukOe19Ijm0lWAecIc8m3j1VU3ca4TROfr0IgytXD?=
 =?iso-8859-1?Q?TbpU2I3gVaHcjyX4uF2ZDCZGrX+YMpR4NS3g6sQd4lFF52qjviXBaJOjg0?=
 =?iso-8859-1?Q?9VQefgVFEPp5KUqSLUX4yRV0QQwdaKKuUmp00OsMZs6bVQBmQgazQ3ZNqq?=
 =?iso-8859-1?Q?8k3DO1fjCsx1Po4XO7tjCyk4w6pRFZzM10SuU4jPjcJiyNZ7kqJDypwxeF?=
 =?iso-8859-1?Q?ghoPg0GX/63jraEhRuvuyq5QmGVw0P7nZ1G68S/a99jFBVa2V/pVKUD2tm?=
 =?iso-8859-1?Q?9SpL2CVFiBJvIdvJcVM6+rxUwy+dFoX68kQPUBkB76eY0N0OGWwpAmTJ/k?=
 =?iso-8859-1?Q?+oMPe6SY/l2/2WHwK2r+fsxI4Hz8R501BuGN44MDd5e+KXZzUA46+++LVN?=
 =?iso-8859-1?Q?gZVjw/OnL+YtxgWnb6w376ClSLPB19BZzFtB31ynDM+8S4ME6Ffsv8O6wC?=
 =?iso-8859-1?Q?qOhnhKa8l7loWlJ5e4/DQxHspUDV7iHjQODMvB2Gqh9QDvP9cgZoKPe3xU?=
 =?iso-8859-1?Q?BXit9oB518NmcDd1VzUhEG6BTVLaTzQKHDAPum/Tlyr6uVo6bU1OFZzWK2?=
 =?iso-8859-1?Q?c+bA5nF+qlKb+/iE7p1mlhmn6G5QT4C6r+IQSuyVEtzTfhszi3apyIzA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99d5b615-eac2-4710-f5e8-08da679eaf3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2022 02:46:50.1307
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k5pfXQfzNtJ1YMBZB3LcSik2T7N7VVMFDoCZXYedJnhQCKYgfoUaZRgfpH+Kr+YuxNf7+ZGa7Cf3AtEBP+TJtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2799
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-17_01,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207170010
X-Proofpoint-GUID: gjVSYBot5Ryrt7nfQPcKWEudEUKD3Clv
X-Proofpoint-ORIG-GUID: gjVSYBot5Ryrt7nfQPcKWEudEUKD3Clv
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Use the VMA iterator instead.  Change the calling convention of
__check_mem_type() to pass in the mm instead of the first vma in the
range.

Link: https://lkml.kernel.org/r/20220504011345.662299-23-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-39-Liam.Howlett@orac=
le.com
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
 drivers/tee/optee/call.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index 28f87cd8b3ed..290b1bb0e9cd 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -492,15 +492,18 @@ static bool is_normal_memory(pgprot_t p)
 #endif
 }
=20
-static int __check_mem_type(struct vm_area_struct *vma, unsigned long end)
+static int __check_mem_type(struct mm_struct *mm, unsigned long start,
+				unsigned long end)
 {
-	while (vma && is_normal_memory(vma->vm_page_prot)) {
-		if (vma->vm_end >=3D end)
-			return 0;
-		vma =3D vma->vm_next;
+	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, start);
+
+	for_each_vma_range(vmi, vma, end) {
+		if (!is_normal_memory(vma->vm_page_prot))
+			return -EINVAL;
 	}
=20
-	return -EINVAL;
+	return 0;
 }
=20
 int optee_check_mem_type(unsigned long start, size_t num_pages)
@@ -516,8 +519,7 @@ int optee_check_mem_type(unsigned long start, size_t nu=
m_pages)
 		return 0;
=20
 	mmap_read_lock(mm);
-	rc =3D __check_mem_type(find_vma(mm, start),
-			      start + num_pages * PAGE_SIZE);
+	rc =3D __check_mem_type(mm, start, start + num_pages * PAGE_SIZE);
 	mmap_read_unlock(mm);
=20
 	return rc;
--=20
2.35.1
