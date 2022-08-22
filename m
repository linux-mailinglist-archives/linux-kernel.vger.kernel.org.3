Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2305859C225
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236093AbiHVPHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234252AbiHVPF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:05:27 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF79399DF
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:05:24 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MEkP1L022949;
        Mon, 22 Aug 2022 15:05:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Ly/x+Z71PR6/V1/LAOgomW/Iskrh4QTLMi9KoP34/2Y=;
 b=U2VzcSksaQDiGpHsFmKhiXwjdCX8YpYSJCysiVAtaEKJKj3dLl4P088YArZDhalTAkYg
 FjHF1nWEHy3Mo6LZN2ujlKXWvD6cg9bkjpD3vhPIurK4vs/AT1HAZpos1hHKajEi2Wx1
 061t58h8/Ti21CC8IqDua7E+6YDvpC52e/ZXUc6mImcepf2HEj/gSO6vhhf1m8u5g1mI
 IOqQnunK/Uy/yjj+3zl23GgwaZz9/3se8/gNopRyDfWS0GwsS8qjCu33ALIaA0q3JSWw
 26cEVcBPU0dGgV6gl4jAk9dZwm7E8YZ0I2wH+St3i4aYIFofr3CWF5kpznvnD1+D/xY/ 7Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4ar8gbgx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:05:15 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27ME4kbP025297;
        Mon, 22 Aug 2022 15:05:14 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mn1uanw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:05:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GoH6A3liUIMlB4t5fe013OrpQJHg+oUgcZU6qWR4Ans7gc/JGAqkEpXOEMtiVk58QwWvwOS4hAb2oq6gkzIWL4XNNFGUUyzJcVJah0oN8WvgDOWlqXjTChkuOuPnO+ANRW8ngw5t6AZAeV9qmTPF4p9uz4UAa2pY8Ci2pewcZrQy/eE6ge9F2jrgH9sfy+KYnDBGoJAyVtkIn9VsW1zX8R9LJMXmVMy5oGnktuLLWEAD+bT+zefna02jyvQbiPd6VIn7xFh4u1XmlBW6RP3PESiEzF5i8ubavY7S2JosgmsSvKzAd+XE93pqHVTnxkZGZPGq9lPbrAaHqaYsKcdmIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ly/x+Z71PR6/V1/LAOgomW/Iskrh4QTLMi9KoP34/2Y=;
 b=PEqjZ0i9EOapYWJAwHw/3QWRXJevxZ4e4+oJ12C/HcT/u4yiCOddm/emPAhcNnmhMAbV//fSsgE9YUX9NhTu+llzp2DOektXMnOv9DKmnLlO1IYqAuxE8X21snzWfdFW/LkryLYRNa6xSxMUCPQJ3DxzwR5wb3K+wAkEKZcS9KLgHJJHt/3LEIVuh5VN0vJQjEclBgKeoo0DQvVvdqdc3ne6D151UAhDXUkdn+eL+9LF7l+7Y9mqSxrltwfrbHniP/knpoc3BaUMbHTOgVrDrrvHnZdojpFhxfAXIzu1bHTNAYOD3gI+6TNqq18u1dCBSDUmuW6joLAwHbZyN6LuXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ly/x+Z71PR6/V1/LAOgomW/Iskrh4QTLMi9KoP34/2Y=;
 b=iPp2gNn0/PFLFqtHyeNjmFMqNp0F4vkzH16/fcxLea0c7ZNvoQtHX6apk1WCcm6DmXjbUDhm6rdMpIOP/H2e48dnqyu4FWILB1+nrDnnoXcsn0ypEClQ1H4bTYdGsvGvz/qXM+HT3J12jnJhVZ5mYoUkopL5e+tWQwgLNJOBU+g=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB5260.namprd10.prod.outlook.com (2603:10b6:610:c4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Mon, 22 Aug
 2022 15:05:13 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3%5]) with mapi id 15.20.5546.023; Mon, 22 Aug 2022
 15:05:13 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v13 26/70] mm: convert vma_lookup() to use mtree_load()
Thread-Topic: [PATCH v13 26/70] mm: convert vma_lookup() to use mtree_load()
Thread-Index: AQHYtjiUDMZ64sB6U02OUQ8yTW1q2Q==
Date:   Mon, 22 Aug 2022 15:05:13 +0000
Message-ID: <20220822150128.1562046-27-Liam.Howlett@oracle.com>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3292ff76-80ed-467c-a4c1-08da844fb6e0
x-ms-traffictypediagnostic: CH0PR10MB5260:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3tZeBYZZYlYfa4pT8BS9GjP+Rxv0bDRKJrq2T49zpmx6sjP4pyLpdEv25XnGxHJinnM7LgwH3eJTVumJc/CsI/k439mQlZnTjsM21UDfxCMYvKG5a7hh1QHtcxVtY9xa7qzNRb9WIh2MemsQOpz3re+Z513D79lYMofgHLnbX/TPvQnKLA4isRufQqhI3jom0vDLnOX3sBBO0zIA9Rw04dJpLznrKSdgozDWlL7cHwdBfuqMhNkpAoLXdgFFeiIySlb7je5f2d38zO4LdaSwiTxnKFUigRsj3DPQfMBfwgmq65s98d5gYasdPr9JD10RXBwG6ivR5MdY61o4hkn/EVxhav4Mi6Ff1UxOFGlZpFs6NO6on+ThgFkh+lgZsiyTLI840aQ2HER0rhmDdz6WhQSy2Aoxfjo4DVAqtanNGnBphGd1LwxGzuAqzbek5WCKH76tW2GOf3OOqdBingqtqI6HYPNpG+4aB5VtK/vSirQQL/2m/HJiKQI0nhpjY8PYqAxz3e3Gn1YQzc5ZtmU4nkLTM/SEjnxmTJUR/cLG5s7V/pmM0+B9AQGChc7EvJd2gRdwjNwVpjk2PN67AMAUYe6/Xcw73Tl2A+z+XYiNKXlfdBSGLM8uEJbjq0iVI37RTxdQe684P82Av+NUe3S2LjxaqjGVZyb5Cx5f9vFlvY+CpgQInc/hoaUWp71r8cbeL7KZaJNJ1+dKQs+JD7eFgIdnxJY8B3l7oZqE4YfX9bYrveVHVdH5NC1aT2z3yutFVl7IreGYp0k6pCACDMvn4Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(346002)(376002)(39860400002)(396003)(26005)(2906002)(86362001)(6506007)(1076003)(2616005)(6512007)(38100700002)(186003)(122000001)(83380400001)(38070700005)(54906003)(110136005)(8936002)(36756003)(71200400001)(316002)(6486002)(478600001)(91956017)(76116006)(4326008)(64756008)(66446008)(66476007)(66556008)(66946007)(8676002)(44832011)(4744005)(5660300002)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?DTFZ6XFKs86cIEajLg86+Q0FKDhuLrkpp6+NrnHX1E7x5IQF4nXmrPUWcZ?=
 =?iso-8859-1?Q?klkeY7/cwDb0wGZLbf+Fry8dP5AQdG2UTy+Q6cje6fBbzs+NEzSsT/pLg6?=
 =?iso-8859-1?Q?luTJOM0v1BaStsw9/DPCIAcxvTLr7XjVcRCHDryL3BmLFBFI6RG2Vk1AsG?=
 =?iso-8859-1?Q?L7EZVyhZ3P4dTPvnRDFd734xRtTLjUjthCnTIzpaAJDHtubp7mj4O9uUNc?=
 =?iso-8859-1?Q?4VoNfLN/09gGNXsRE/LukiaqowK1jSJursK/Kmz/Qh3ujlYW9lJVNTq0DP?=
 =?iso-8859-1?Q?Qy6AeRZdKO9r7wqwWQInK+7fn1xGaFM/C9va6lnKeNhyzou93emGxSufUv?=
 =?iso-8859-1?Q?+RX6Kak/q1AAgDH5qrKPXbzUrf1DclZB7dv/Z+y9b57goVi0w3Byecz/Wu?=
 =?iso-8859-1?Q?fsW2GaKaHRZXbCyirgQOleuy+iV/y4O9nfg/v2J+YdNXSX9SDMNhwJSUkf?=
 =?iso-8859-1?Q?2dFicCafuxbgCQMNNFnbZHZqLR+c3qDXLDs8VD7xFvB9CI/VJYVVyub62u?=
 =?iso-8859-1?Q?M4F3EWj9URimrNONEDlBx/ch2DHWQvCTyPl1HSdUyFcdTt9zsGHbOCPyCn?=
 =?iso-8859-1?Q?4PaJgb1/3T1SuKGZyh8oXPK3ZaFlY8e++k4nZM8E4WxJw0uuPDoHxngPBE?=
 =?iso-8859-1?Q?0g/WFZypXRhoX56nw3m5a4SL2m1vG9qDzjwRMb8W0M/EjBmxQZekaqxkRj?=
 =?iso-8859-1?Q?nSnB3rYlsRnUVN2HGZPz2e6Dac/kG0fV8ibJ8aPP5Kjwy437jvOtCHz3yL?=
 =?iso-8859-1?Q?Jj6fX7o9HEw80ud575NAnePk5nZapLaFCOUI3nu/phHYpDbMxO2ZL6i76i?=
 =?iso-8859-1?Q?vt+FIfEHthvbLROhvDKXupBKIE+sBaMLEtr7xH568sS2EUsCCvbKOpUCvg?=
 =?iso-8859-1?Q?On5Wb2tJsOfbfIgamm09ifG0368j6FIzKbVPixB7egjBCTH23lKu9IacbK?=
 =?iso-8859-1?Q?C0ZhzXkiSEUQMa4s+Ps/FBw7t8d7ut0uQqZXxh/3R9Jruvu9dJ1AY9wy42?=
 =?iso-8859-1?Q?u2+ZsmDE6ve65MaYMHunzUAbZQdgUpzzAOjMD+QU7r/y3rOzk6HUpZkRN0?=
 =?iso-8859-1?Q?0EQu2TFefXY5nt0YfaQU9m9N4GX5kYblTOByBbmJL7Zcb/FSS2Q1lWcsjZ?=
 =?iso-8859-1?Q?Wavy/vAoy8NIvlYfdlQdeg5Gbx65THsWx5f6ljlCg1FGjQh2JrZvqTR7cd?=
 =?iso-8859-1?Q?DD47ru5sajsb9Hj+g1tV/ViRPeC7cZakzrQf9wW3dBpGe8y/EaL1vbJY5f?=
 =?iso-8859-1?Q?OV+pKaZjNlAS4S+euumnpqxUmaeokKLdERETJIO9vYmp6rvCynb3ik5+FV?=
 =?iso-8859-1?Q?z9q7/WvP5IcS/KyqckgX/wzMUWF8zQUw2MRR4LvQYJeGkua7lDrNnN3nod?=
 =?iso-8859-1?Q?dWNS4UWqByaTuKnP+wOYf//Qn9qdzHLSYUInywPaf22wdaJH30pXzuK+Xu?=
 =?iso-8859-1?Q?RGLC6lUROpap/Z1g1BlqOZkx3huawN51p0CiT6XTyDqM627ErPjjW+Kta4?=
 =?iso-8859-1?Q?0cE27nyVOKaRCFxr1eXjOC8ZvysRE0wH/bcwFRBunMihCT1T/qnLHfmHtC?=
 =?iso-8859-1?Q?j6OrEkmdqzUoX+d64fvAvezYNEfd+WkV6cUGp4HvXutvwm3YPBSnetkHL1?=
 =?iso-8859-1?Q?ubbmQn5Af+3/a7Bc3R8OMk4g2MFiOQKALkJPCqkmkDiYP6od21S0Rpxw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3292ff76-80ed-467c-a4c1-08da844fb6e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 15:05:13.1336
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m/ZbbkNP4o/V27m2nJd4fYOwHI1xsNlmeUrQKOCrFfpGFkvq94FbxLP8oLNnm/w4RLuDbgU7JqN1TGdkshp6Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5260
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_09,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208220065
X-Proofpoint-ORIG-GUID: Gso8Ok9dLY2PvbNJoeCnkQVZHO2U9R1i
X-Proofpoint-GUID: Gso8Ok9dLY2PvbNJoeCnkQVZHO2U9R1i
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

Unlike the rbtree, the Maple Tree will return a NULL if there's nothing at
a particular address.

Since the previous commit dropped the vmacache, it is now possible to
consult the tree directly.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/mm.h | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 88e89f38825e..bc6b7ecf93bd 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2787,12 +2787,7 @@ struct vm_area_struct *find_vma_intersection(struct =
mm_struct *mm,
 static inline
 struct vm_area_struct *vma_lookup(struct mm_struct *mm, unsigned long addr=
)
 {
-	struct vm_area_struct *vma =3D find_vma(mm, addr);
-
-	if (vma && addr < vma->vm_start)
-		vma =3D NULL;
-
-	return vma;
+	return mtree_load(&mm->mm_mt, addr);
 }
=20
 static inline unsigned long vm_start_gap(struct vm_area_struct *vma)
--=20
2.35.1
