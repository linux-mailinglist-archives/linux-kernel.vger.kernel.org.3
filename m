Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E4159C258
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236345AbiHVPNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236064AbiHVPJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:09:25 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE973ECE4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:07:19 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MEirdl017906;
        Mon, 22 Aug 2022 15:06:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=6cmnwg/wEcogWjSH8cSd+LEpjSVagM/RJErgLubljtQ=;
 b=R1fGYPoe3XqDaA1kh/QAl9pD3yIPEiKQkz+sMlxdVt2/iJUWNHUCKdRxJsNK5Kh9DcCU
 e+wC1riB1CV8SRkEdCBeeUQ6DgDDxIMNyRGGBO4YrwPLAiielotrpUM0SwYfjl/aDXgH
 xINokl7dUq+953AtYyptp+dQwDNfOVPV3QiR1ATugGncWssGg0uoVh/xnVC61JlzG7cZ
 hxDnZvXhLNq+NpHUtDhus08hWCsbvHduMH7wiy7Rudt8BLBpa2oxvh2iGgGWdL6hbzIA
 f57C5VsDzbbzXwGN9JemV0Jl6AZkvj9Gfw4z0OTy+EybAS7U5gpvcPabcovTlQs0aCZO pQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4bkt04ah-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:06:37 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27ME4Nmn037786;
        Mon, 22 Aug 2022 15:06:36 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mkg3e04-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:06:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QXmbhYmL1eAq6NAJOLUAyr04zv4rS2NRKOBOdQFnfv49lS0AGSJCuUestBvIkSXgTvPWKv+SR9rU6Qz7oo+sIxugGMr2xDE+Joc23WStKBLybthIC2kcB7N94NC4S89xjy7YyjOIlEQl6ra/JUP/zMhssIg8kio4tEED2qyEOQ+I6UlK34Kq/Y9ADgYAwHi4qdZMrtCGqJFJEWygJmLkTIa1P0cuMp1o7eDyMzoijU9RFeUAyXHS+NL3dR4uFI7d3NA6camD9vBkjlaoR8YPlvYxfrwLEgNITyFBU5Mx09Dgycj4vyTPVKchZN1DIVtxBseQVavYuoLqShVJQeITDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6cmnwg/wEcogWjSH8cSd+LEpjSVagM/RJErgLubljtQ=;
 b=ZjDKyBAL4oF9EfsxpUjJinSBJ+AMjkces1F504QZkQ72dgDlwDpLtHgFW6rDESei4WBHtnBJkZ0Dr36lbrrRr87VfWlXR1MoW1/Oc/1nkAzLCWuFkxxBQVIpKN+p4TW/z3dBr/sdEpqBJS+BjBRck15ieeN11AkGoAXM412fAh+xaCJ5leZ7OiJf92Iw4QBVIvTe+nfJfBPcw5A9TgATYwXX9bIoSzmLpI8dVVKbmRRS2dCN8717ZTFg9Yf6rimqoGMs4K7KUORqefAqJD7/xkQtbBVJ5L84UZFfHlK3ObkVIUvFjlz3w2qL78tegMR014uVLk+x7k0VNqLRUFsmWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6cmnwg/wEcogWjSH8cSd+LEpjSVagM/RJErgLubljtQ=;
 b=Yz0lJQ0XEpsAr6D488DYDYzSnnA41dRxxrKJs41Ce7nhdIAGVBdnsOr+1pGEJtNmckhiewRAcKVp408DWxQuU5WLeSi9ClhK07ic/094Oe3cepvbo5lvyIVLWbJloFx7w83dJaSds6ViVikkSJacSvsqPMZXrvDxLYV8PgPt4mA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM5PR10MB1433.namprd10.prod.outlook.com (2603:10b6:3:e::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.21; Mon, 22 Aug 2022 15:06:32 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3%5]) with mapi id 15.20.5546.023; Mon, 22 Aug 2022
 15:06:32 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v13 54/70] mm/madvise: use vma_find() instead of vma linked
 list
Thread-Topic: [PATCH v13 54/70] mm/madvise: use vma_find() instead of vma
 linked list
Thread-Index: AQHYtjjBnXzG7rCBoEei7aSpZ5Ektg==
Date:   Mon, 22 Aug 2022 15:06:29 +0000
Message-ID: <20220822150128.1562046-55-Liam.Howlett@oracle.com>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 791f6519-f35f-42c4-203c-08da844fe64c
x-ms-traffictypediagnostic: DM5PR10MB1433:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4cgmvV5YNC7TQkJNcEyhV9f5aIDbTc/UjZnDDAyQAsqB0Hgvp+imJX5VwJE9QD+juTpH8TkGEbyKk4LwWiyuVaA2iSggtfeSyNlh7mCcUamj3e5Hf0DJVzj/cNRyxhHppWmcEKCG4QGYZprGcylCW+XYO+WtwYRRFuQE9F2HSkCDlAoCZQcP6viFBtUHU0Kt5M5VaDjebKCp4lt3Vp0mJj8Zs8A1LA4uVMw7n2mlZqeblsApsnC2SHjbgd7CjF4DcpEZSXFLUVm/ICJrYdvni9TZjo2pKbLiEw6lAD60U3/LtttCp9bCFcKL1rjvmqM55NptNaDBkWXI9HcIq7eSTx+NWUaFDmrlK2znZGSVFn2QEJDLEg1kYGUtY2pDfAkg9To6ff0WS5y5fRva67IPvDYgooy55eLxC5gcU+r9e9+Drn9H9Ki+rABS4LBBCCjJ2EBE+qqp3WNzrp9tvvET0QA6/ZfjzbeD17uGTKPCsHBNBverC+XYd/aws1wOh25HrX57zWMR4qDvsivxE7lXRKBDbr7w6dfLFH4/ohfYNbBMyE9gXnTlmUcsW7hK93sIgwE2De0v1AYnPkzwTxZJiGIGJAWx+1lXRbam1c5FtAWlSk09PrZXWl2N7JIDTum9KEd381DMoaRBKDGuSUVTSU6JUFLgBfWXXNTNkdYJ66OWl8vqIm4zLdwpsGkSZ31Rsv9Wfs6xJotBZyPh0ybYPIYEHLAgBdoy+prFzBFZo15vYdLDcldSZjiQE8Ec3+mncFjAeSHt/wmeqlXlWADKgQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(396003)(136003)(39860400002)(366004)(5660300002)(4744005)(8936002)(38100700002)(122000001)(36756003)(41300700001)(44832011)(6486002)(6666004)(316002)(71200400001)(76116006)(91956017)(110136005)(8676002)(4326008)(64756008)(66446008)(66476007)(66556008)(66946007)(54906003)(478600001)(186003)(1076003)(6512007)(26005)(83380400001)(2616005)(6506007)(2906002)(38070700005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?rSQh1pJ1fLahysjwrgtDQXVmAYTR4Z/Ye/mvQ0T/uWrXAyHUIyXj4A5ofV?=
 =?iso-8859-1?Q?1nEtNTpmblQT+MmQkFbVqW3rU44GjpwyJHiG5zXDHeQK8fWLWkdMKb1mSp?=
 =?iso-8859-1?Q?PTXxg62WR8g7kLAeTXCjZJD9fec8pz1laTB2NHHJLwRTlHsckavHVfRP21?=
 =?iso-8859-1?Q?Sc6yMiidV7b4QBjmI979QBvN+SVFxcgUb8dz2qP01oA0LKV0ZwSe0Rt5eu?=
 =?iso-8859-1?Q?ba5sk/VTkq5ySPvuA4B6NOFqh5N2SjVaGLHwmv9pKwTj4OnwtoHPuOylzF?=
 =?iso-8859-1?Q?QF5Jxo6+TJxfHIqvEhBTJ7T1AI9A5g2d+mAsJs3jRZbTQ+EZfzcer7JmER?=
 =?iso-8859-1?Q?GW/CanRV9fbKOSNnAxB3eal/9zakpTSJvUkNwMX5gQeBK1SyXd9FI56vmA?=
 =?iso-8859-1?Q?swm1KuHpcnHhDXPMpsxUAY44ZaKgGFRjfAf7G7xFURN/+6FU5hMZCqfqbM?=
 =?iso-8859-1?Q?zPlMKqB+8uXmHnLbmtkasm8FKTqsSexdwWUDlnG4XrDVU4652aGBjNvoj+?=
 =?iso-8859-1?Q?zzs08W7lNgu1+NOiPRooWPoEk/tXb1e59y/lxnZGkw/H5rS+Ekq/50pQOb?=
 =?iso-8859-1?Q?dUt+3IMnKOoF526klfeYrv4E0nSNLw7rDT4o663gntRAGc9MI2U/xs9O27?=
 =?iso-8859-1?Q?M0M/eBMiGfmGnc0NrxV1EE2Fs2qN1nTpzHawvJQuQk1NnpIsVEuzh7Il/k?=
 =?iso-8859-1?Q?jdB0gVI/E5I8kAerorfdzpyViX4Di9nhMhhAiYcGBCAhTbODxopcQWvv5v?=
 =?iso-8859-1?Q?e43Pia6CJGbKOzXNnod0L8fudVRxmhe2sV5/aGc1gge2i8lCCt2rMfEzh8?=
 =?iso-8859-1?Q?hPWtETcIBRweZQ+WeWCVF4l2PlPYb2owF7MgLPU2rfFEKfVbdS6yD/VrOC?=
 =?iso-8859-1?Q?PbKt1hKLphVCIQf/9233rOM2wZ+nUWxbEzAZHJkTihHyHuzQcIuVAELBqR?=
 =?iso-8859-1?Q?nZ+2v9OhuKKGxp6IDO+Ww94R7Q5BgJ+4Ar8q0DjgLCDKS1LAdXR1eV/HsT?=
 =?iso-8859-1?Q?MbIC/7dBAL91fKHiIywrsTQ7rL+9yIRVBukhPxX3WqUS1p/rA23ggiNMMX?=
 =?iso-8859-1?Q?58JMSyNpW5s2/qDku8Rpl96EAWjhV3q+LCs2qSZoV4QzGxZiTUdrTg7Hw4?=
 =?iso-8859-1?Q?HlCfJq20a87vJZ15WElEOWEaIgteF4DSrgP4Xic4ObsiiGHXsBAY8Z442D?=
 =?iso-8859-1?Q?iOXIdgR2ChVFGGvC+S01qsYtSpko0oDrue2YtT2CqiVe9BHUOsUArIOr0N?=
 =?iso-8859-1?Q?1IASHjEjvJKldiKYDVA80LK4nvp09XL5ynlOeBIQcb1LUpoVaMBbcPYAA7?=
 =?iso-8859-1?Q?YiGOLfIZ4ctMa3PZmHa42M0lQv9Xhon7zhOPv0ULOndeO8tBaemj6zlgcZ?=
 =?iso-8859-1?Q?XYrv/6zgECQx0PXjEIDtws5iZ7tHPh6Mll8xu+E+mhDwqogLUXjF8ot3df?=
 =?iso-8859-1?Q?Kqf9yecg+Kxbf61W0IybbKHQ3fjliDRVg+9P8Z3gHwiryP7FSIq1jnjlX1?=
 =?iso-8859-1?Q?tsFUC2LO8NtSPMYVDwfq4VzmoxQ8bMnA3B7p9LEWIbswgvqiKwSUHmJjUr?=
 =?iso-8859-1?Q?HhidUB7FupDn39ZfRQSrDBocQhaHAGmKCYKsh1mLjDoZr2I7TxYnCj8EM/?=
 =?iso-8859-1?Q?gIGTU3dy2Zj+BRfPvLYkHuaOSsWUeJKMMjEI5iHH+vtSGKcWMWSidp7A?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 791f6519-f35f-42c4-203c-08da844fe64c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 15:06:29.4411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CNqh0PeN9WKXqom6PHs32LhjGG2uGPzevkctoA0+wEudD9eWMp7S5YiCqmCtOyO+ivZuPkgRwLcQYNZuOktTAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1433
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_09,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208220065
X-Proofpoint-ORIG-GUID: -HMZdb7pOtwsbkMrRf3_OK5e_BNB-3SQ
X-Proofpoint-GUID: -HMZdb7pOtwsbkMrRf3_OK5e_BNB-3SQ
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

madvise_walk_vmas() no longer uses linked list.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/madvise.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index af97100a0727..682e1d161aef 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1242,7 +1242,7 @@ int madvise_walk_vmas(struct mm_struct *mm, unsigned =
long start,
 		if (start >=3D end)
 			break;
 		if (prev)
-			vma =3D prev->vm_next;
+			vma =3D find_vma(mm, prev->vm_end);
 		else	/* madvise_remove dropped mmap_lock */
 			vma =3D find_vma(mm, start);
 	}
--=20
2.35.1
