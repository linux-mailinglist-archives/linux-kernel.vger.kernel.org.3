Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4965AF4E1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbiIFTyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiIFTuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:50:32 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93FA2716A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:50:08 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286IcnqT010459;
        Tue, 6 Sep 2022 19:49:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=v9FzOJKhc5Gt1l4N1U4c5il3FaMcmwWtp9+cwW5uW3I=;
 b=M7tfYITx5qhWgOswc5FiI8d9y5j7mRuGMKIKg5feoZLlECt60H2FEB9bTc2R3cBYyYTD
 Qc5JZ3O86iSJm7kzo0iRIqwC+JWam9fKQ6kQr/BBxk6DsZ4yZTIkRveikmbcs02YHOMN
 d2WBNPJ1Rrel0OF84Vfn3DwXphHGvgY85/LvK+yjbtblpZemo5zR+3VBG2+TS8T3jgMy
 8LZUTQ9TMclKZIq4aybMfyrEtw9+VgaB2V5zTycOLjVgxXvWuLXIkUW5xmayI7IomnaA
 /0iLXAx3vWIXMhvZ6oC1OFxlxKPbpf+3i5eiJIL6r8uSnlqp6wBCYeUKHCqm98PoCijo TA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbxhspxct-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:49:48 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286HF67O031251;
        Tue, 6 Sep 2022 19:49:47 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc3ahkd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:49:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fOz6B/lXkXoYgaZMU82i/4XlzizFn/nOzec5CvnGuKi2VPyxxU5+tqJVi80moI1hDbHGsCcYHvLUK5yI/x51bXhuSdLhyWjfH/VQcGfmKjfS89awodw+ikgKtfBcSaRGI7zCLMf6v7SUmstb3Yp4t5LGzicVOrsSnjztD3XXhT3ZKujxOMuyJXJu0Ld4msdgNcIvj/Nhk7n9WzgQ+pSM6pw/TX97iu+Sk7tmtJX7XVnT0suOL8SeMmbpgAaAw7p+yyyZS8if8MivtBDqlvPEVkSVuLryC9FkW8BQhO4Co2ucIu5KmedyPT1IbaSydtIOFTGRTIOANe1ttfrLw8BbzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v9FzOJKhc5Gt1l4N1U4c5il3FaMcmwWtp9+cwW5uW3I=;
 b=A/0mxaOSo04nEiBS9ffYsxzIph9il9QfT4tYDUKlsnyjThe1tYv5ONRGOVRs73C0Tp2mZeZ0NxgH/wntLseucNOHjpnHcQLaDkbH7nCp59FrXZRhu8ryajnJqhyY/kXCxQ07qDAlMdHs5Ak2ihMzvQx4S9CeHz4Kl533bSFhhlqWdB6bOCgDiRvpUZKVyzMzuH1YJq59n3YcOCujW5rkIoG5aoEKQaK6tzKsI0toIw+151xrelqG3c7QIwXaEhVEnCuVHo629RN/3KlY6tcIxHMgYKhGF0w8wrTbi+J3w1KaLUuPYTvrdVYqZprGbx7wOKBUr29MBhiS39FXjs7FqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v9FzOJKhc5Gt1l4N1U4c5il3FaMcmwWtp9+cwW5uW3I=;
 b=sKSvDmdpKlADniVoNDpg1Q5Xy2GovmfhwZ4XTdj6zvSssAnukj4f2zH74xEEAlw4NLGCz+xQtphoitwLnt5rn3xJcC6unxpKLI4zbKHUOTIV0xiha/I+6PteJdj+ybh82JebsXMUi8Yayfc6cXxPQysNRmh8FaCtYrQGVs4Fjgg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB4876.namprd10.prod.outlook.com (2603:10b6:610:c9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.15; Tue, 6 Sep
 2022 19:49:45 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223%5]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 19:49:45 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH v14 49/70] fork: use VMA iterator
Thread-Topic: [PATCH v14 49/70] fork: use VMA iterator
Thread-Index: AQHYwim1r/ntaYMtC02321DaPG78wg==
Date:   Tue, 6 Sep 2022 19:48:59 +0000
Message-ID: <20220906194824.2110408-50-Liam.Howlett@oracle.com>
References: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 87ff4e93-26bb-4943-be81-08da9040f2a2
x-ms-traffictypediagnostic: CH0PR10MB4876:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4ef5JqyE3YhLZsojAQCEFyhUbBUs59Gtc8JDA8be3T2TWT8pfl2ELSNRahoHuFFBEV8qgiBh5p8luA86Y/uar5sE8FUNXS0i+lFnzEgNBTZCJ+sstCFzBe7IMsp5fIcgofk9Nad1XjRoLPwnlCjSmctUJ+RlCdc2hh/aW6QboDSjDl5S24Oq+p7YtrWABYG4iTIqiDJIMgS3wUzMbSFub/91BL0+3HoLvA7hDBbMpD3fgoWovnvkPtJ9W0+WnrU8zssUVuUcSEKuAxDALY3AALhOa7vPcVvehC9zcRhfQmRqR6HnhuApYNe9Et2A0ff45I88bhHZnrtoOzA7CMDjVHjTebP2KCKXna7PkIdnUwocOomswLxOV6N7AIvQm9ToU0p0MoPu1FnPiHXJxNrWyO2s86Ix6m2+5Mao2dVyhuQw3qn8z1tUsf2RPOq7ipRRDVTU8fiP6nG/2GN0tEN1RXpx0Jo/EXIoZ8UXrR6ShbB0EEiaZRvOwvYUU+QJ7AUq9sT8gr3wwUX/C7/AOgVEUXmJvP5Ql4K1PcxHXKawYS85zp3ahi5Z4+6HLcgVzveztdQ32MiCbUWFwc+TXTdEAQ6XYrGmFL3Umukp1MRonwP3RPWbtU+C3hf+WRcW6jaG7zVHmNEZn8sIuthlYSOrsOfwSA9SeCwxxYSDM+uq+KxK7Ao1Ctegyio1rcJrbNTctM3+VksMlJ9MbcMISWZ6HaJnSwtwKMkOAPXd0Muqput3Jo+FTeiJysD8qRuXxOUf0o1vXtrrSiA9BEYl4SJvVw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(366004)(376002)(396003)(346002)(8936002)(6486002)(8676002)(4326008)(91956017)(122000001)(66946007)(66446008)(186003)(66476007)(76116006)(64756008)(66556008)(2616005)(38100700002)(38070700005)(478600001)(83380400001)(36756003)(1076003)(5660300002)(41300700001)(71200400001)(6666004)(44832011)(26005)(6506007)(54906003)(316002)(86362001)(2906002)(110136005)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?d5pK9Gy2tz8BEA0VdHHzGVUfHg2m8gEexeJ4OyS1AftJhUoxSFb6wGDPCH?=
 =?iso-8859-1?Q?LH51b+6dEj4AFRBEXQ9AYH7hMH5ajx+K4DNGZFlDdW/fXjIWhd62I4w60m?=
 =?iso-8859-1?Q?aKwUk8QbocTV7iHiibxIHbKWibgsiKAePsHRJgT4wJ/WHDhgi1p1qC5ESo?=
 =?iso-8859-1?Q?/88/KNnIfWDcqRsCovQ0mG08hv/02jEqeEebcSjQw/bHwIjaPHPL7J6LJr?=
 =?iso-8859-1?Q?TlsEElc+h9zdOVTdZ3VtF1+ZnLQPoaU5Rq/5Yz5lZaIr3NQk8CyrQ8xdHg?=
 =?iso-8859-1?Q?bvlIldTX7DsRu4+EpxwdvmUou6UUkSOfMc4BpO1Qrk7obsCv8Rtb4Qtssp?=
 =?iso-8859-1?Q?deyl3DP0+Esf/3EUqsmJKbNSr4PaWD/k1M3Jnb+LK8rlYWnpSUQEOiQ1lW?=
 =?iso-8859-1?Q?+bfTw1CFASCRrq1x6oDLD3AJakf79VAnJ1yNTh/PCOYKPHsLAeDESwgriv?=
 =?iso-8859-1?Q?RwMPLCOxbVKZMKuG8t6zarxWRCjP34D2aXgXbiwZW5PEgcbWlLYm+/AjpO?=
 =?iso-8859-1?Q?OmS74i30JpzkauqZJP4BnWr2MeGL5H22tknC71/N13lkgkdWMI0VIgr9xa?=
 =?iso-8859-1?Q?JVikA1nMatv0Vti2CB0/wHYVzmn9s62fZNKGdv6PWpZEybtULlXkPHLc/x?=
 =?iso-8859-1?Q?Rrv5sje3G4QpR2I7TtHVVNO4qaesz3LILqNdATTx0d7lGF+2bFnnoCzRx0?=
 =?iso-8859-1?Q?2spmBHZcqDNfhtpHWMGumviQI1tT7IPd7r6bjLNyruJRmPz2+6IZk+fgnC?=
 =?iso-8859-1?Q?Gy0xpkHXJX/EG4QoFJmbKf1ZJ9Wz3U6WXD3jvW2/WHvCdWVkm+1VBpjUla?=
 =?iso-8859-1?Q?55qAcwv6I632+NYhRxqBLZmWQ9vYp1JCSWdGW4Ov9Xoy34bgZ8R7lq4k43?=
 =?iso-8859-1?Q?9x1pyYZdRsd581PHP/KnYAzbAHPhFTE90eYnlGG1QQe96kymqVxZymHrUX?=
 =?iso-8859-1?Q?rTM/mP38aCGlRPw7CfJC7eoRaPnLF+KoaQ7iAWMS9HDuTizqcTOo8K0cvK?=
 =?iso-8859-1?Q?CvSeN+7ydoq0UlYpmLCbUPJAqHTxx+AATxV7j6tyjb8WUyN5w7mI/iD3FM?=
 =?iso-8859-1?Q?cwieBOUIiwn7PjlZH1e7c+PnGk8P0YDpAWZUpNb5RvEIcmBvq4eQn3RDK7?=
 =?iso-8859-1?Q?q2OvUpAXTRJH2ITp9f4mUAFN9vf9A2QsHiyFyMW2+t4r8IuNKg+qfy6vlD?=
 =?iso-8859-1?Q?qZWrwQ8BZ5FTbmnOzXw9srCPAbj7qXszRGmlPelmpBFc5qFRq/CeRmz54V?=
 =?iso-8859-1?Q?ewWiNTgAeBMTmSwtqSKypH3jwYA99VdSwaHpIIOkJjadkZLlxnMzS9COUv?=
 =?iso-8859-1?Q?0NR9MGv5w60a6/OcdwHQ4pko+g4nM2KdyRYJufoVOfZa9pDdr+3Ixycknn?=
 =?iso-8859-1?Q?GdedpnkpLapdREuDYF5mEj5Y/R0rjThIFsifSuN+WguA9cDvv3s5SQx60W?=
 =?iso-8859-1?Q?OduMzI+qiwfSDly4l/PvNK3RrRJIVX0RN22vu5HlU0CugqF82ULlVMkE7H?=
 =?iso-8859-1?Q?C/3YnQWlnlzNoyOrIktbcbCAJHiyeJxr5Zs/6ceb+rihJdOLUwXB0Fym88?=
 =?iso-8859-1?Q?w+zlAQ1w5l6BsNC6L6okDcDTqyUk6kzLn3BAK3LZ3iY1T1GfGy4qBJoHGa?=
 =?iso-8859-1?Q?rI+6UyUI4rOvSha0DnC9fHsGe4Qv5i0JbjTFMa6Na2w1Dhp7kVTmPHvw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87ff4e93-26bb-4943-be81-08da9040f2a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 19:48:59.6154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kBFf9tJegPJp4rJ2P42nM7PAbLZxIpiE4rfklD2a/AFvoWGXnNAQEKeHcyz31kpQF8PEHHpSMhBuDvkfPM8D1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4876
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209060091
X-Proofpoint-GUID: ELU7I8gwWIIcS7ggb4PeOSQJOIOdWb1v
X-Proofpoint-ORIG-GUID: ELU7I8gwWIIcS7ggb4PeOSQJOIOdWb1v
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

The VMA iterator is faster than the linked list and removing the linked
list will shrink the vm_area_struct.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
---
 kernel/fork.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 430f63cd7a37..49e4ab6f5208 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1301,13 +1301,16 @@ int replace_mm_exe_file(struct mm_struct *mm, struc=
t file *new_exe_file)
 	/* Forbid mm->exe_file change if old file still mapped. */
 	old_exe_file =3D get_mm_exe_file(mm);
 	if (old_exe_file) {
+		VMA_ITERATOR(vmi, mm, 0);
 		mmap_read_lock(mm);
-		for (vma =3D mm->mmap; vma && !ret; vma =3D vma->vm_next) {
+		for_each_vma(vmi, vma) {
 			if (!vma->vm_file)
 				continue;
 			if (path_equal(&vma->vm_file->f_path,
-				       &old_exe_file->f_path))
+				       &old_exe_file->f_path)) {
 				ret =3D -EBUSY;
+				break;
+			}
 		}
 		mmap_read_unlock(mm);
 		fput(old_exe_file);
--=20
2.35.1
