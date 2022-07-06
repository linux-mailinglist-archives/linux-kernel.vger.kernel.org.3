Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D5A567B23
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 02:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbiGFAfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 20:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiGFAft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 20:35:49 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633E9A447
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 17:35:48 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 265KwsYC001747;
        Wed, 6 Jul 2022 00:35:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2021-07-09;
 bh=fENrfAXjmwrJrGB1l/vpS+dfDOSXV95lX1im9CR734o=;
 b=Ea7VwumlklvzqieeA5ISxjiu8R1cVADGc1HGIKmoHbaV4wMxEAjdv9btAqjm4usTW3Zm
 Q1u0mHzF2eRdrSxN/I+EQYGfBXA33Ohl0I8bcmzS5LFQgTl6MkvEU4h/YvOqE5NdwV1W
 Efs0tHilp5pAewTj9BvWBZHQS4KPhFzLTvjb9x/X8f3YrvGEnZBvuCo6AtcqlZn9W/LC
 pM9wP38QE4d5mqEiq5/+kS9RIXi2RnWfLTHx81kpl7SKUUmJ4x2RxbocRYYddY7zwN7t
 C9GoN0uikNRitmeg4ILhZtFnkhWjX9K78zf/KGMSmVzeKoDWv7UTJXNvKQ5MkskhTuxi Aw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4uby0haf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jul 2022 00:35:36 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2660BbXB032416;
        Wed, 6 Jul 2022 00:35:36 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h4ud7my94-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jul 2022 00:35:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B3dtntN2+/9o3YRLBMRN81CtHzGMZMFfI1NE+oxBueW6JZEHvt9gmopjY2tSgmWzsMMt2m+LM+Oaa5Ad9+/MPc5R8bpN5is8lHWm7dn9H7fsgq4HHfYM1FBdjalo/n7I1vmwbQEPp1Y10eGInyk6+xqdPQf85hGHCjY4G5WimvttfeNpW1UF5MPXQ2XmMWR1psPRPo2y0a+gSLZ5EnfwUskQZGoBQz8tXdRscWg9BlH7yKMa7dkZrMsbvDo3FccgTaq1qjZXarfGlENG0cGjhWokDXC72E4afS+cAD5x9PxjwAimtv+ebFScvnFxlrHHoqX23INXhkvrRyOU1vLUjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fENrfAXjmwrJrGB1l/vpS+dfDOSXV95lX1im9CR734o=;
 b=bK17VtPSbov/RBHFabXzINJoquxQGlRNtBMK7FXGdbAhOisdUOGu+8blEvP4MExpLqjcxENxylyK0gkulAa9S/JMlYDKe5rjz910VfhTFb4+fui7pfyh5IUQMeY6P02iSE4zGHV4yzrPU/E4CNqp4EWvSDAuqffeXmFsXnLbj6QE99Ni64P2XgStvvdRK8gddSStYqW8aEgySyaKlgfL7IVgluDueO4jfa6FEARphk7sqrgTZO/DXeWMXvNBGSpHoHoALwVaVdmDfYmp8plAzGJlMWn47+dU1s682pbpXFPyB65064Ls2KZopIooxsukdcGK5OM8ZSo0oD5pivdMdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fENrfAXjmwrJrGB1l/vpS+dfDOSXV95lX1im9CR734o=;
 b=iT2u513c5Yw9r/bgWcVy61nBfhjL31JYmw4vgPpgiqAIGJd0D0K3f570aUtq9GfphfgyeAcqR5OXmY2aqSj+iFCEUmnQNjzclr5eLXtm5bC7pSvpT+qUGMvlKkf1QCoFhKbL3LffT4fUOIgQkKciMpfkUkKBHTNfGw05EGNqZrc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4421.namprd10.prod.outlook.com (2603:10b6:510:33::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Wed, 6 Jul
 2022 00:35:33 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::6cb8:8ff0:385f:1c54]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::6cb8:8ff0:385f:1c54%3]) with mapi id 15.20.5395.022; Wed, 6 Jul 2022
 00:35:33 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH] mm/mmap: Fix copy_vma() new_vma check
Thread-Topic: [PATCH] mm/mmap: Fix copy_vma() new_vma check
Thread-Index: AQHYkNBN5b9h95VVwE+7V6rX9Clfdg==
Date:   Wed, 6 Jul 2022 00:35:33 +0000
Message-ID: <20220706003522.1827240-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fc8412aa-0486-469c-26f8-08da5ee77032
x-ms-traffictypediagnostic: PH0PR10MB4421:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oR2FKQk8E0zQ7tI9lETsUqydv2AKNzIaVd5OECJNgvMIDWlF5fcKAt4clMVLzAoG5zgbdl3G/8kJyN2ZpT3KVn78C5fKxjkAopj6C3khbd6uvy0Bq7D1Exscq8mbF9NjsaFX79U3T2jDgxMxoCG7Cofd/BNJRwBEg77JPz6gSZB42TRCRIQV1UdriG5wF0nl8u1p5iqRfPaTOg5DgmqcfyXi0PUfsqqLhih6LwH9lHtobCFuGbaWYlH12kwp/wJ90hB1OmigZCxTMihTxMEOu/Osu3Ek4fQUo0ljzeQ2KK+9H9N1KVs9dMg2rk2EWDEhZQd6NVWekwG3abW7QJcmw6W8BVdlEccjOMHNen+ej1E2w0ylr9kx/bT/oPqad9ui28Vmp8/lKbyvnYQoheU3AGNtnLLrZLt3lNw4Xus1VmeryG673gvONLa3xghPvX+0bo+eSqFNdPE+V6lJzvwSkKTp3SWOx/l4pVBMun7v297RGgW9BuX+LEzTwkIHsMbzxmJk6CcRcvpwP+Naz8zUQjDkzaOlIv8E2YG8s3WKs1qpiIisLu+qAHMvMq+F0/+GfygcfPm9dOJJLDJ2fws5XNT1Yg08yfN/tnaJot5a32a9x60T5yLM39VzAtBu2Gd3DfpeRUdbt4ik3MQWbRc8nJ3uN2feNJnpiZyQrEqFgIbE+y3VYey/JjK1nRfH0g1pdGrn0/NmCnMj8XORbfCKaGsyf5wnjosvM37Q/IBvoq+INGlUOPmPkpJ1bsoImd9oeInvjJGKeBhZzNWIEHeGRnul6oZnmcC1gjNVYQYliOtL6p+9WmCjeY29EWrR1HkG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(136003)(396003)(39860400002)(366004)(122000001)(2616005)(186003)(1076003)(38070700005)(38100700002)(4744005)(83380400001)(8936002)(5660300002)(44832011)(6512007)(36756003)(2906002)(26005)(6486002)(8676002)(41300700001)(66446008)(4326008)(71200400001)(6506007)(66476007)(76116006)(66556008)(86362001)(316002)(64756008)(110136005)(478600001)(66946007)(91956017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?jokZuDg2zRxlUz2hE7WXOAnzDHPass4ESkXAw9hepzMnHlpDCZBOaCDvDt?=
 =?iso-8859-1?Q?9jQHdqOqTVhF/AM/23eag19IgHlfVuJs+rfU+yjo0pSsnCz7UG4rzKi5QV?=
 =?iso-8859-1?Q?+GFQnbH83MDKbzlz5l+F7xvP8XF2dPmWEJaGvFIqfIZz4ACtdRR/YKpvPi?=
 =?iso-8859-1?Q?5ofamYg58yNGirC1rCDUQlOAa1pcYztH+asrK8IVpnRFuigTgp1InqeVms?=
 =?iso-8859-1?Q?uw5CDAeJ24GqVgjD7b2EhiFjfY1lnxAHxeyjckkKmX85xCt9lMHV/vhftU?=
 =?iso-8859-1?Q?LV+bXJAakHB3hcNyZpXtSxsd9kivVxEMw+Nw1RynptApPJUOmuooBfb3//?=
 =?iso-8859-1?Q?jdYaGZWSl3kbiyH+lI6NwofuHwXYnnyih35EaNznNBsmCO+thnqMTd+x2l?=
 =?iso-8859-1?Q?UvlaDk1COGJVNSPeMCGeH0RrGBpDz4F/PPmO5IS8r9t+aXDALXN/Eg4fz0?=
 =?iso-8859-1?Q?szH6uBE6UTMArzh3VNktXGVGFrKMY6ouAdFGlFkpEpcYh6VS2yQQF0a4fP?=
 =?iso-8859-1?Q?6hZ1JU0UDC2TpmuJ7fOnKficw4oyx2X7FgiZMQmwnzraEdhwwd9FmgFnN6?=
 =?iso-8859-1?Q?B0h8oiiiN6QowtKd7z2AglQ4NVrjzOj53QQYK7eV8OUK3Jb+4P872dtjOB?=
 =?iso-8859-1?Q?guIeXkkckpvy4RsYVKzJkGyquo7MShfSKeEptuBZiii/kpLdQqVrt37x5K?=
 =?iso-8859-1?Q?MwS4ziecsGPTUTFmu9JLPVypHxZ7Nza4magGIUkN/qEIOdToJq+maV+ZTd?=
 =?iso-8859-1?Q?9x3IoRu6WouhA8KoHbk9FMAP2UN8ZcXZFtd420yBAiRH6r2CetC489WlQS?=
 =?iso-8859-1?Q?LdvSKJg/63jL9Gl1N8v0AEZwxyW8eyeKsvYxCOsU/Yk72QjykIjVw9LMAS?=
 =?iso-8859-1?Q?rjZFuLHxeALmknT4Tt1Im0xCJTArMGq1nnzxONbIJ+hQPcExD7ypUb7AG+?=
 =?iso-8859-1?Q?v005d46uE5syzA43Nh5RbN81RyKrRhaE4jZPpTpT7iXExfTwCbvUw6myRU?=
 =?iso-8859-1?Q?VRF+ApJ+o/mTWJVYpcxnePByWY7IMYj80oHanh6/m8ky1RX8EBzhgSANvQ?=
 =?iso-8859-1?Q?W9f9M5mwjmEQhg3QmRqwFbx1ODjW0LxtT7xmGVYKBFqB9b0YdyGFG2lS8p?=
 =?iso-8859-1?Q?hziXY/b+d/oj9+dElf7VsWb/h4Inl/k856kgpnh6iK0pe8JL4XLGZvnIkt?=
 =?iso-8859-1?Q?/3M/6BEX5QF0jdu9IlQ/gm3P61TY0yzskZoyetcg/IxkuadNGPDQSqH45z?=
 =?iso-8859-1?Q?BtpLDQLQKY4j1sTK1N7x3zeW55KQ3EWpunbAJ481jw/nfQ1AmSbXjDNxEO?=
 =?iso-8859-1?Q?eZadVBAPPsotPL1uow1xQTwyHlJ/qChmtbTr46WISdyRrDOgLx+Y3B0MP0?=
 =?iso-8859-1?Q?LFxH9H96W/gJmdaM1fzeNgn3tJkJ8zGJpt3/oV7d9MrfckaKRIhZul6PQw?=
 =?iso-8859-1?Q?vxyyX7graAw3P6gWSgimzx+obvHK2n5OT2Dd4ayIqw694c8lTJzWLbevSU?=
 =?iso-8859-1?Q?YFWTPDpgyXh1huNJU1PoD1qWPYpTUjIsMd5eKxxqFoxsLdhsou3E2P8w/P?=
 =?iso-8859-1?Q?lAl7Yp1BzwkBtTCdHdY4QgPzhjMfT1a9LoYhgRjIQ/kE+GXYfbpfhDtwYY?=
 =?iso-8859-1?Q?ukmhYP/i6KDKSKVOIQiLExLijc3fGe2rAk+KvqZYd/d0z+IMc7/BewlQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc8412aa-0486-469c-26f8-08da5ee77032
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2022 00:35:33.8981
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ILVhqPyEeFYu+vwU6vbJi+M3oUFRXIkC/q/+u1TT1SThdA69IhWMwzVsun/88HV2W12XSYG2mF5UqrYt3t/LsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4421
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-05_20:2022-06-28,2022-07-05 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 spamscore=0 suspectscore=0 adultscore=0 mlxlogscore=979
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207050102
X-Proofpoint-ORIG-GUID: 0Fs9YtK6oCClNoSIrOe5nAJvC6pk_kk1
X-Proofpoint-GUID: 0Fs9YtK6oCClNoSIrOe5nAJvC6pk_kk1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When checking new_vma limits to ensure they are not within where the
copy of the vma will be placed, ensure new_vma is not NULL.

Fixes: ded0cf440d9b (mm: remove the vma linked list)
Reported-by: Yu Zhao <yuzhao@google.com>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index dacc01b0126a..9eb663cde5c7 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3293,7 +3293,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct=
 **vmap,
 	}
=20
 	new_vma =3D find_vma_prev(mm, addr, &prev);
-	if (new_vma->vm_start < addr + len)
+	if (new_vma && new_vma->vm_start < addr + len)
 		return NULL;	/* should never get here */
=20
 	new_vma =3D vma_merge(mm, prev, addr, addr + len, vma->vm_flags,
--=20
2.35.1
