Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4062510199
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351977AbiDZPPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351943AbiDZPLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:11:50 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 731B7158F7B
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:08:12 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QDSu40018603;
        Tue, 26 Apr 2022 15:08:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=3pBJLhHwM0A2U3t4MwuSjK0HGrq8NrNzfnQpio4j0EY=;
 b=O+pCT4gcqRxd33u4U8pY5pwxSQa6u4nV34EIGK0GwTrzAtb3sqQvXZ1kHCsT2Bame5gR
 CUnE97iBuOy9cvrjstJMENMPn/fzsRUYCjvLToDTFmmrHEWoLuooKZNkU3PmEt48Jd6u
 XKPDl4p9oKDCp944A+dso/7bsaMkmtgexOLCJ8HgTZdVqI64hD3n2jS6NIOr+x+zfZqj
 OnEvADu7VDvBUQ3URCC3nH9N0BkUT3xNk5a4QjdVa2jjJo7PhWFa0aoKwqBE83j5Upsp
 Sf01w7kGzcvlUBMLnkNdY++xtAgAwQEOEDE39ocbvLxPXzqbT0XHvPVOG+Ad5ks0h0HU vQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb5jxeme-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:08:07 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23QF64Ij012558;
        Tue, 26 Apr 2022 15:08:06 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2046.outbound.protection.outlook.com [104.47.73.46])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w3gsed-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:08:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lDHg+or+41uFu2jCM/psy76tAhdOO1LKBrkqcbvSQB3RdS0DvNzn/gEekGClHIo7iNtazRzvoyp/T/e1krfDkTR6YWuK9J/+/aHtcTfYaUUSYHRyRxB63JQ9CnH1V4/3ZwaDSokDSXuZZ8M+1wt0mNyiuBZqSjp1CndVW/S6F9imJ9e03Vqd/oDvALRQwkAeUeQYoctKxLxzp6nXTCnxupBnIaZ6KKu5XwiEARj1pP5Moj3OfUQaUivXoHXShJHHuGzwcM4K+zy6EBvYRx/69TfkJ6ztrbbylFfx3O8phR2ommArhua/NDTYQFiiUP4Ck0akoGM3MgcRC1CxEwsKrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3pBJLhHwM0A2U3t4MwuSjK0HGrq8NrNzfnQpio4j0EY=;
 b=jA5rO/9Te7aUfVZjMzUNwr6gyM1kPdTeImMtACQPGT+a0Zkgg7Fl95lQVBvWb47BoiGQpQGhTKjr/a84ZAim+FBdnqakMYtzkcGYgMiQxMYARYRWHuyWQNo6KL0cgC49O7R6jzhDt237DQMJgc7Y09KD+ksYc+GVB25hLDMQCl+eqA2QsRhtIE/wMe602CUMB6yXjSz9AeTWsPUM1Ug/abAun7rIa1o5JxsL7JCwHIbV0ZSqIjk8q4wKwgo2WxetNkjItX2TbshT4gFIqltlJUiuppRks0nTQ9PwWF62ZKlL9WBT98jsXNKvrlz4IRCJAu+ISfRys9UOLSKGIKMZ4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3pBJLhHwM0A2U3t4MwuSjK0HGrq8NrNzfnQpio4j0EY=;
 b=CjQ3pRkHYWxEyzLYKp8JcsCOvmqbIt4brg6u2FYmhXdG8kN3lggWjEkVHNJtRwY9e/aa0+uw6lXwhi8zcS+z6NzPUpL9F0uhNdenQt8Hr5Z5YHri2w2WardcmE87mwE/MYe7RJSMj24UZDTZU7xpG359pOZvI6aetemYaf89Wbo=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS7PR10MB4925.namprd10.prod.outlook.com (2603:10b6:5:297::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Tue, 26 Apr
 2022 15:08:05 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 15:08:04 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
Subject: [PATCH v8 61/70] mm/msync: use vma_find() instead of vma linked list
Thread-Topic: [PATCH v8 61/70] mm/msync: use vma_find() instead of vma linked
 list
Thread-Index: AQHYWX9BI+lzw+xCq0iNc66lJVw+yQ==
Date:   Tue, 26 Apr 2022 15:06:50 +0000
Message-ID: <20220426150616.3937571-62-Liam.Howlett@oracle.com>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9e8814be-3aca-4f2c-e876-08da27969086
x-ms-traffictypediagnostic: DS7PR10MB4925:EE_
x-microsoft-antispam-prvs: <DS7PR10MB4925C0198D4CED67483EB10DFDFB9@DS7PR10MB4925.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QSaKG3GYCaK4by7HfjvhSANzVZFcAEYFpTov46fN6BDG1v3EzERMoX36WQxPOaiufmRoFSuy136Iq9HCNRFtnWf7GSUuJjD6YrBDpq5u+sowWOsIRDB7Xwh1KIUIzdZB4bkOfc4rM1T53X+1J0nkZaRqdTFwLLrPTZ9pJrCgSYqT9KZOvIIFVPB2IZQIB2J6AkVGUBFtpDJ/ORzTi9ng1AElpcBTiQFsE4YTddfx8IpsBIzipjWpKM+ZCwEeo+hsvRSl6qB6kGMFwTcB8bpfClEEv7ujrB1JJ5jdcDX/9+Mg92RfiES0zRPa+GPWczDtqstCTN+w+2tOUHq5Dl6/HnIzOAa0SMg47lpPhQ4uQlIYiJwKKQsMBRLql5Jd1WCzm2qDb7nWqiDbG4Lmz5Rv/60+zX9YIoaPj5ssAw4YDcNcd6iN7ncmFZNcRWclUo1CNH4yNZf2VBh+KjraFNx6rEeKrYHcAiY7Ha2Gjnn0ysxOEuqxAqvcwqiFYnIk+54Pnwwd1q5zQ1VG235JtcQVUuwV6pLIuUaColDxfbTV6smw+dKbCmjg/em+KsO/xObzlP17yqZIiDRV7AF0t+jEohCW++tIUp605sw7CaGsUtmTTaUoOwBo9FY8mRp3Ph/Aw8JmSCxdolJIswJXfhUQe1yLJw4DOzILSZvPZptmcQW82GEfvWCoFqJGlF579glydwpiyFd5Gy29E7hGYuoxjQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(6486002)(316002)(66556008)(508600001)(38070700005)(86362001)(8676002)(2616005)(6512007)(110136005)(71200400001)(76116006)(91956017)(66946007)(122000001)(6666004)(26005)(5660300002)(8936002)(6506007)(36756003)(83380400001)(4744005)(1076003)(2906002)(44832011)(186003)(66446008)(66476007)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?wP/KRx4shakKK1em6KzaGCVmES5kTqvSef5tZNUu0+F3v1fwye9bBwcz7b?=
 =?iso-8859-1?Q?rMMocYI97bTpc3eBngImT16YNHlYZ3gVzM2FwCjajj/uHpU2Aikh+4Q102?=
 =?iso-8859-1?Q?6k3hjfeB9bv497Y3Md8zgK7LdeFIseThW0N34y2Bb7Lql2OVmuaopK4T/x?=
 =?iso-8859-1?Q?b68WnTbC0KmyQpY2dIaqAwJUOfZ4gxVS0/SUw94Po3CqOCZr3lv3Pq7jSq?=
 =?iso-8859-1?Q?KCDrdF4cHd3htXx+qjjAOj/pqJbhmyB3M06ZOpSKdbvvzJAUEDdXMYh1Wa?=
 =?iso-8859-1?Q?1qjRNd+Gb1O96Hxhm7BFKt3VGHjRGrzf79DXpkXvhkP9mwIiT0M0NXXmhf?=
 =?iso-8859-1?Q?0FxEOYAiD9jrd/1raAjPuze8fSuuzH0ufypVghCqIw3kSeZTQnxnrzPCM3?=
 =?iso-8859-1?Q?tjq6m7s8YTclU215x2gznec33BeJN7g0A9gHg8b/Cj+DsdUhAJDX9JhG89?=
 =?iso-8859-1?Q?UOBYnISIfFEU2xetxHG/O8TuoF2626pDDHGWFLTT96Jj0lts0Gn7+oXHnm?=
 =?iso-8859-1?Q?ijKPHqsgi/tGYAf35PNz+2L8t/9Y/H8p09lEyHc20f97Zla21QfC2oStg5?=
 =?iso-8859-1?Q?Ai09Xt1DdJ+2wDi+7uD+QP8yiVWtpAazvXiL3c7pi8aCTU/zpNm7Mn1kH8?=
 =?iso-8859-1?Q?VI4aCWtUpGcgoeSCi1ci3hO8pD5lQEqkw+XkROk7RAw5UprnFN4w7/e8cj?=
 =?iso-8859-1?Q?jmF0xd2XXZXzUzKDyD/7xvWpIEnkcPSwBO+lJVhM01eU8ZCO4CGDSauma1?=
 =?iso-8859-1?Q?WAO3yFQBvBl5i0fnAu6w4AX/nxeL2U7OuhnWBD2unBCvYEvls4Ummk6Pca?=
 =?iso-8859-1?Q?O3rsQjkuvIuPgnoIqEOrD2UdId29A/9HPsI7gRpMp+6fYXr2ma5PZ0U2tg?=
 =?iso-8859-1?Q?bv99jsX8KoNO+GL9qHkXt04cd0N5RwxJVW0QfTDewgIV3FTXk7HGH4N/p7?=
 =?iso-8859-1?Q?SzDWLT0NgWQ7XM3nKfXiZPQGU20agPv7MRGPr6g9QfKX4xh32RED0d4Y3P?=
 =?iso-8859-1?Q?T8qVCo2qJ8yB03mL2kUJvaWHoiXcmpxhmIzvAfCK31LbrpRobkBsJ/a/fo?=
 =?iso-8859-1?Q?Epe3F6tJUpfZzy2O5eyeP+Mfzkreb7zuTH+ePCiOg3f7k86zTdMDcNzzQV?=
 =?iso-8859-1?Q?eUjIPhnBc/ZsGuv2R/RT/ebiu2EAz+x1OjGoSemiPFtRdYdKL+Bf2XpLrH?=
 =?iso-8859-1?Q?2e9lyiVdYBBfvOPZ71JfbS7hrtq4hzpSfBOsXNtS8xVvdTYshd7+/Oytjo?=
 =?iso-8859-1?Q?RCQJlWD56PsILuiq+ErARBm+PD0bBzXrKT/VQtpi9+938Hck/o2BAr3UDP?=
 =?iso-8859-1?Q?KNGs3+eFpIaTU+XRql5E55Uas54VrHeJYwbr4csPueyb/aBJMj7EH7MCwS?=
 =?iso-8859-1?Q?9UTMXTvk6pdJmCM5a8JXo8hq/bAWSB38jSlM0hGvfbbOgNpQqdjOa91okN?=
 =?iso-8859-1?Q?b0mFbjgKnlyEsz9jBqVix8hc7w/h3/9mpLzFKBLul7XjYqnc1JhK1qAKaG?=
 =?iso-8859-1?Q?jzgx7OfQcH3xED4HgA5EnbV+P+TLyBeXN9IczygNabh6pnUNBJM5qEVagI?=
 =?iso-8859-1?Q?AHq2boU+ufwsfPrKNPuHuooQ49d0QIIULN/yBbMjGnhAdoS0zJauQw1ni4?=
 =?iso-8859-1?Q?7cYXAqOpglB1gqWfMfDzzfUhIaK0vbJ1q8VN5u4aohoRxIa2a6RUflCrVU?=
 =?iso-8859-1?Q?o+2JyE3Gv8oQHJvztZnheLw9L51d6NyoHxL/QiAWfymKqUQb3c/TWQSO66?=
 =?iso-8859-1?Q?XIsLbdgBdQo03031rB17R0WotASjKzOEEjv2jTa4t3gWiakDIj+RF0yai+?=
 =?iso-8859-1?Q?iEfBX5UKJWgp/DzDYmWPf82g+9hQjQI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e8814be-3aca-4f2c-e876-08da27969086
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 15:06:50.6766
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3G/6dyJVNMmCjjL31keBEInRu85EI2d9Jk/Frwx5PqIEhMRSXC7YeQ/kjV1CSfBXhzulrBKYSHS8q0yg+F33cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4925
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-26_04:2022-04-26,2022-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=925
 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204260096
X-Proofpoint-GUID: AxcTrxnhM4b_b8x5egrIc1ZyUmPN1koo
X-Proofpoint-ORIG-GUID: AxcTrxnhM4b_b8x5egrIc1ZyUmPN1koo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/msync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/msync.c b/mm/msync.c
index 137d1c104f3e..ac4c9bfea2e7 100644
--- a/mm/msync.c
+++ b/mm/msync.c
@@ -104,7 +104,7 @@ SYSCALL_DEFINE3(msync, unsigned long, start, size_t, le=
n, int, flags)
 				error =3D 0;
 				goto out_unlock;
 			}
-			vma =3D vma->vm_next;
+			vma =3D find_vma(mm, vma->vm_end);
 		}
 	}
 out_unlock:
--=20
2.35.1
