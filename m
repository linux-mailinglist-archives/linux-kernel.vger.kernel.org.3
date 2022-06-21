Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D97FC553BE0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 22:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354408AbiFUUro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 16:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354343AbiFUUrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 16:47:22 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D34823BC4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 13:47:20 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LJ6sTZ009744;
        Tue, 21 Jun 2022 20:47:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=+vJ7RQkQqygDBSNCGfb1IJXhT8kb0wC2bvyxlLq/nNg=;
 b=HhhaQK5fVZD2SoIiPA/vntrUcwr9ykFj00YjdEKuE943a3wDSKYO/Gt0/4BwXWN+IGiT
 +2f7DEzG+8qZfni7QIO+UWlBH1GAE25MpGqSXYueb7yO0FqotqQEiRRBxdIdRI7b+H8G
 DC6DaceEmJVz52yg6vvDpIIU7kVQbuX1uVUraicA/kicKHyP7C6wDAQAPA+NOEUtQFBg
 KPBAj+5ZqjLE30EFumU0Z7b+EhB43C7vAiM3+wMUMJckEbm9aEGI3UE9pYx4UhPEqe1p
 BsGo/OQq9Ux8iIGxHNW6YWlvniV0cUfVfkadH/dOo7teVjapnq+c6yd941IlYTxAWXsn 4g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs78txpc7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:04 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25LKeWLb031602;
        Tue, 21 Jun 2022 20:47:03 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gtd9ujxx7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GVRpE20EojACVMCSdouBrSXvgahNt1VQIyhv8Lhj1EaxXEdOJAg1VzaRSo/2DrpOcYbHJj+R3MqKISEGUznrEV4yYu3tmONAqnJWYb7uNlcQ+qowWgjh57UBmmA0Rd6WGfTU+3+M9554QEclWNR5vjiOEBeROiA5q/FJ/wzgBtOegaE853hBTglzFQaaKZHRkWNuAsUmDn5pYpDYihgHIQaK8SWge74U9S95i9caPAAPazqy6DzmSiC3mR9JXsn1/VzSctu/MW3HlLjkShWFes/nPCkRJNEd0RphU/24WIEHYGdi/JRVfM5u6iFnUAuO2TrcdovgzC7qmIHLizAPaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+vJ7RQkQqygDBSNCGfb1IJXhT8kb0wC2bvyxlLq/nNg=;
 b=IErgmQB2oZ5EBN/sAwL0ykd+xy54y775ya28nAB4dxijrwQ8tZM1YaFny8c2gN5ESKOI01T8sZB6HacghCdZK0ADRUzghgm2sjLexDFrbyZvccTWcjyzKKNnn1wVsoQzXQatlM8P6c5dDBFbjy4VRPiUbVMDXnAcUJfeLloiyYlTNEZF9Yka2r1F6N0EdaTzCzAyWrnDFQoO/9meJMfBQUyoGE5E+bST3YsJXb9J9pvpUpGNoD2cAy6CDXsILx/erd5H1cD3E7xYLK3OM049FG9s3D926mdUBsRt4vGpFTU+qYGeLbnzD4ChLNUvLQYgGimgxvfKTYFr02ZL/BH1ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+vJ7RQkQqygDBSNCGfb1IJXhT8kb0wC2bvyxlLq/nNg=;
 b=uOnG+tBLEkXfSmOX+NTzzmpnM03TJ2H0m6JhpyZJsX5Mv1UpTQ/bAPwKyFquVUr8tM+Q7DBe5yys3DTX2hAScnd9iatC53TcW0sCKJPuUZCZvijG441hmU9E+dMIzTNbnamao0TdoSRPJ6eMKvOw3vJ5cMIm97OWa/4GxZ7BuxY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB3085.namprd10.prod.outlook.com (2603:10b6:805:da::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Tue, 21 Jun
 2022 20:46:55 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 20:46:55 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon @ lists . linux . dev" <damon@lists.linux.dev>,
        SeongJae Park <sj@kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v10 08/69] mm: start tracking VMAs with maple tree
Thread-Topic: [PATCH v10 08/69] mm: start tracking VMAs with maple tree
Thread-Index: AQHYhbAKGdByOHS/8EGdiCUunvrkIw==
Date:   Tue, 21 Jun 2022 20:46:53 +0000
Message-ID: <20220621204632.3370049-9-Liam.Howlett@oracle.com>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2976add8-0391-4c94-08e5-08da53c72d85
x-ms-traffictypediagnostic: SN6PR10MB3085:EE_
x-microsoft-antispam-prvs: <SN6PR10MB30852A79B98A9BDFDF666BA5FDB39@SN6PR10MB3085.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zpV6nBYbujdi3jV/ImVVtiP85Q0uL/gUbScjwpuPyskl9m/2ksrKwKqiSpgKq5MWW8JyIJZda5v3g6bXYcvplMtD8EFVf78g9OPJZJJLaazj9xLT3OwtbPG3FKXLMjR3idHk9aa5qjOoX1YRzydGkpZT6dL4p2GcZfsr60OS4PUNL66mO3L/d7hkdGWRL+F9ZVGOcCDXRngn6f1jGkBroMjIzhevfbWfB/ZVYeH37BJUDDYpa4K5E7yQt5A0IEVC1VDb5bn898C0kWrWa4TVdcDySeYuABWWXUxR/eWrjVI41We+IGkhLgTye3xzfjW1oHm7aiv2/Iuj1hY5g4cHLtkzvAbqvI7GNPzdWS4u6GcCKCGaSul6vbo/N12031JJg0xIVYQSdpeG6uj9m71Jck3wyx/em1joBRQ0LUE69GrJk1lxYGp6fvWXCehKDLRqiqK6alQo/wjx0nNLGIp99Sarzw9KJ0Tm6wubZVWoEXZZD6j3/SwZErnaRJf//AuXQ9cTfGpnvxcVUAuJJTGHRFoEARU7XpPHh+1gW1D1ZcKfiqYXvo1DAfYUu8xUaOsKAyk64ZBkePc31ZMUZ9FHOFHutHNNG4KgTe8Fkr56jO+wUknLc8tu+3bwwmzm4V3cw7kcmHO+WnepJ3oCIbGu8nJEZzcHtMbAejWT/aa63WR1e5SiD2Y2tTm2/Ux76pU/w1FWl+Rjb2/KDlU2slyhV21pizetzNTaIjB1hjXn4SdGTeUOA4pT9bi3qOVABN1gebiDiDKPtcAgJkSZsRpIIeCYFMNL8xJdOroMnGAe1rM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(376002)(39860400002)(346002)(136003)(2616005)(66446008)(6486002)(76116006)(66556008)(966005)(36756003)(64756008)(83380400001)(478600001)(66476007)(1076003)(71200400001)(316002)(186003)(44832011)(5660300002)(8676002)(66946007)(6506007)(2906002)(30864003)(41300700001)(26005)(86362001)(91956017)(6512007)(38070700005)(38100700002)(122000001)(110136005)(8936002)(559001)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Tu8jvHWca7phVgwLngU6q+FBQz/Df1srbVQmbibMQRV0513oK2sP3OM+3o?=
 =?iso-8859-1?Q?d7BgrOsw2dKWOxJU9GBJSHApMnxBrlpk1CIcPTvzFYA5ILJHg8WdK+Id71?=
 =?iso-8859-1?Q?r3RWBLTl2sVmCh+rfmaPOc3S1tNpq0NfEV/FFPBs4JOE3sSWLDTmS/9fWm?=
 =?iso-8859-1?Q?gXQD6MEA/Ru9h9Y1IjZZhd7aoUwFSTQuhvkJ6UjsbAu1whY8RYyI3ZGm1l?=
 =?iso-8859-1?Q?VN7D6s7reOsIjA3IQ4I2fW2vnSTQ/7W8G/L4H2IIqO9jJkKJYk7YdmWrxT?=
 =?iso-8859-1?Q?rOK/quHZcNyTQhABGFvQDLaKHQExe/PlVRPma92fqQT11vH9eQnMnbAsof?=
 =?iso-8859-1?Q?/YXRfx3sKwv3dU6/d5vVy8NYTvvXwyTgTDhHPxu0rI3T20DrZjoDy8dK1H?=
 =?iso-8859-1?Q?rfrJ38v3QFNksXRpY1HFfdHhPlB3bK7u0A1D+ahwBeGev08NeWU6ki6Zr2?=
 =?iso-8859-1?Q?Ebgi8yqXNNBsu1iZEksV9vdAf8FBOXFC3s1PRGjLhVaRfILJiB+VUDM4O6?=
 =?iso-8859-1?Q?g1S4DFwO5GFM0Liyh5d07wzH1sxpo3mxdZJjPJMXKWZF9/0dEMffAt8BPc?=
 =?iso-8859-1?Q?llo4ZVJZuVprhwaGBdM7NtcMaHdAmYa3BnKiOG8r9bbq3Czmwj79ktStwO?=
 =?iso-8859-1?Q?TU3SbGC7m8RakpiLr66muAobKBxR0aNrMNLqRtXQ4zLW9h6ckF1mpiaq5n?=
 =?iso-8859-1?Q?jbxDUO4+a6Ki/Sfve6K+4H8AMpYxm3cGwvFjcehF4KGw9BPIJbMgtFSjM1?=
 =?iso-8859-1?Q?eDoQFH5ZtNlzJ/AH7C54Uqyl5gl0Yzu8/zrREXOwf3dRc/GMZs4CR4Fu08?=
 =?iso-8859-1?Q?mfYtD7L/S+ZK7F4m6dt66cftAkYRq7ncr08Wv7HJvfVIQk00RKKreoHcGy?=
 =?iso-8859-1?Q?0siL8/VaDbykD77Guk224IF6eSbYO9bLpVUibc6PDiUXA+XhIyv/NwXBY8?=
 =?iso-8859-1?Q?O1iQuEjYHCpLDr+tMDmv097yxM53denu2dpGBcRNwzE+Luiw/8Ez5Xmd5n?=
 =?iso-8859-1?Q?OLPjbHEn34BLgGavWj+MSp9GOk5b7rENgUsYkCZxUW31dWxasqlqO7VZfL?=
 =?iso-8859-1?Q?prqKKwNhGAHqOFzTjsTurTMXuoIy34KYs5CHl6NVaKqzEReoctiFG7WYOi?=
 =?iso-8859-1?Q?AOiWXE/CyE7Prn6PW7wXxPoT6luPbIsE5XK56xrj5guOEDO6UXAUItn75q?=
 =?iso-8859-1?Q?AmI4Ze8cZt4NtWxBkGKE6z42h0C3fxuE2cknAS+IWjKMlF0U7QkwDr6jOI?=
 =?iso-8859-1?Q?+L4aSmpUYM5AJ1+b6A+IaZlz4wwoA+wMaF9+5XEPaG1RZJ6CZkNN1gvstA?=
 =?iso-8859-1?Q?SRolfvYxpouHmSnqBWF8obH2Srhn1szH77TE8gYdvceDHUqDXDGoOtZlkw?=
 =?iso-8859-1?Q?IozknVFXnvx7JYo8m52B8U1ljbljkfVYCy5QPVoheOYidJVMVg4vVWIrB/?=
 =?iso-8859-1?Q?q4OALWrqZ6PWGx/wZbZl6sSNv9tMDNMeMXW6ZVsdAIXwN8jvwAdop5MesI?=
 =?iso-8859-1?Q?yLHNw/XBp+ToLw/egD0RjzaMseVS6fM9I2XG0xsjMCdkwyrCRtB/X0sieY?=
 =?iso-8859-1?Q?S5/Ln/F7bbeu9ZZK76xleHchCQ5ebhR4sOybgrYYgZM+Hhmw5S/QK21Asi?=
 =?iso-8859-1?Q?8kLLvr60p5QsNyqCGPUylvoDFZkWZCtGwkGxVHibi412f8tc9Tm5hEaus8?=
 =?iso-8859-1?Q?bbAqxzdeWB2XlFn+SPCRdMmovg7ad28WGpdNcIBeGZ9fTVE/lp26hwn9SH?=
 =?iso-8859-1?Q?joWGXmCsnOjRbuCIntJfOeiv9Mig4GUiUDm2TDGTEu67AsWncYZAF2085n?=
 =?iso-8859-1?Q?jyTzXs7JkyVZcc9vmZkBfFFWEawt2B4=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2976add8-0391-4c94-08e5-08da53c72d85
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 20:46:53.9731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pEZBbGC13Tlj3LLe+Adnw9lVqyOuUDYwq+P+DQdswR7p1RTCf9wcW62mQC78wHGZsJV+CpJhrcL7VtWsDyfy6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3085
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-21_09:2022-06-21,2022-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206210087
X-Proofpoint-GUID: h3Oe44CZNL2NM5sXAxjenel8lenHJsRb
X-Proofpoint-ORIG-GUID: h3Oe44CZNL2NM5sXAxjenel8lenHJsRb
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

Start tracking the VMAs with the new maple tree structure in parallel with
the rb_tree.  Add debug and trace events for maple tree operations and
duplicate the rb_tree that is created on forks into the maple tree.

The maple tree is added to the mm_struct including the mm_init struct,
added support in required mm/mmap functions, added tracking in kernel/fork
for process forking, and used to find the unmapped_area and checked
against what the rbtree finds.

This also moves the mmap_lock() in exit_mmap() since the oom reaper call
does walk the VMAs.  Otherwise lockdep will be unhappy if oom happens.

Link: https://lkml.kernel.org/r/20220504010716.661115-10-Liam.Howlett@oracl=
e.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: SeongJae Park <sj@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 arch/x86/kernel/tboot.c     |   1 +
 drivers/firmware/efi/efi.c  |   1 +
 include/linux/mm.h          |   5 +
 include/linux/mm_types.h    |   3 +
 include/trace/events/mmap.h |  73 ++++++++
 kernel/fork.c               |  20 ++-
 mm/init-mm.c                |   2 +
 mm/mmap.c                   | 320 +++++++++++++++++++++++++++++++++---
 mm/nommu.c                  |  13 ++
 9 files changed, 412 insertions(+), 26 deletions(-)

diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c
index 0c1154a1c403..71c54ad3868a 100644
--- a/arch/x86/kernel/tboot.c
+++ b/arch/x86/kernel/tboot.c
@@ -97,6 +97,7 @@ void __init tboot_probe(void)
 static pgd_t *tboot_pg_dir;
 static struct mm_struct tboot_mm =3D {
 	.mm_rb          =3D RB_ROOT,
+	.mm_mt          =3D MTREE_INIT_EXT(mm_mt, MM_MT_FLAGS, tboot_mm.mmap_lock=
),
 	.pgd            =3D swapper_pg_dir,
 	.mm_users       =3D ATOMIC_INIT(2),
 	.mm_count       =3D ATOMIC_INIT(1),
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 860534bcfdac..1eddef189d68 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -58,6 +58,7 @@ static unsigned long __initdata rt_prop =3D EFI_INVALID_T=
ABLE_ADDR;
=20
 struct mm_struct efi_mm =3D {
 	.mm_rb			=3D RB_ROOT,
+	.mm_mt			=3D MTREE_INIT_EXT(mm_mt, MM_MT_FLAGS, efi_mm.mmap_lock),
 	.mm_users		=3D ATOMIC_INIT(2),
 	.mm_count		=3D ATOMIC_INIT(1),
 	.write_protect_seq      =3D SEQCNT_ZERO(efi_mm.write_protect_seq),
diff --git a/include/linux/mm.h b/include/linux/mm.h
index bc8f326be0ce..810b3dd929e4 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2581,6 +2581,8 @@ extern bool arch_has_descending_max_zone_pfns(void);
 /* nommu.c */
 extern atomic_long_t mmap_pages_allocated;
 extern int nommu_shrink_inode_mappings(struct inode *, size_t, size_t);
+/* mmap.c */
+void vma_mas_store(struct vm_area_struct *vma, struct ma_state *mas);
=20
 /* interval_tree.c */
 void vma_interval_tree_insert(struct vm_area_struct *node,
@@ -2644,6 +2646,9 @@ extern struct vm_area_struct *copy_vma(struct vm_area=
_struct **,
 	bool *need_rmap_locks);
 extern void exit_mmap(struct mm_struct *);
=20
+void vma_mas_store(struct vm_area_struct *vma, struct ma_state *mas);
+void vma_mas_remove(struct vm_area_struct *vma, struct ma_state *mas);
+
 static inline int check_data_rlimit(unsigned long rlim,
 				    unsigned long new,
 				    unsigned long start,
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index c29ab4c0cd5c..254c30def2b2 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -9,6 +9,7 @@
 #include <linux/list.h>
 #include <linux/spinlock.h>
 #include <linux/rbtree.h>
+#include <linux/maple_tree.h>
 #include <linux/rwsem.h>
 #include <linux/completion.h>
 #include <linux/cpumask.h>
@@ -481,6 +482,7 @@ struct kioctx_table;
 struct mm_struct {
 	struct {
 		struct vm_area_struct *mmap;		/* list of VMAs */
+		struct maple_tree mm_mt;
 		struct rb_root mm_rb;
 		u64 vmacache_seqnum;                   /* per-thread vmacache */
 #ifdef CONFIG_MMU
@@ -676,6 +678,7 @@ struct mm_struct {
 	unsigned long cpu_bitmap[];
 };
=20
+#define MM_MT_FLAGS	(MT_FLAGS_ALLOC_RANGE | MT_FLAGS_LOCK_EXTERN)
 extern struct mm_struct init_mm;
=20
 /* Pointer magic because the dynamic array size confuses some compilers. *=
/
diff --git a/include/trace/events/mmap.h b/include/trace/events/mmap.h
index 4661f7ba07c0..216de5f03621 100644
--- a/include/trace/events/mmap.h
+++ b/include/trace/events/mmap.h
@@ -42,6 +42,79 @@ TRACE_EVENT(vm_unmapped_area,
 		__entry->low_limit, __entry->high_limit, __entry->align_mask,
 		__entry->align_offset)
 );
+
+TRACE_EVENT(vma_mas_szero,
+	TP_PROTO(struct maple_tree *mt, unsigned long start,
+		 unsigned long end),
+
+	TP_ARGS(mt, start, end),
+
+	TP_STRUCT__entry(
+			__field(struct maple_tree *, mt)
+			__field(unsigned long, start)
+			__field(unsigned long, end)
+	),
+
+	TP_fast_assign(
+			__entry->mt		=3D mt;
+			__entry->start		=3D start;
+			__entry->end		=3D end;
+	),
+
+	TP_printk("mt_mod %p, (NULL), SNULL, %lu, %lu,",
+		  __entry->mt,
+		  (unsigned long) __entry->start,
+		  (unsigned long) __entry->end
+	)
+);
+
+TRACE_EVENT(vma_store,
+	TP_PROTO(struct maple_tree *mt, struct vm_area_struct *vma),
+
+	TP_ARGS(mt, vma),
+
+	TP_STRUCT__entry(
+			__field(struct maple_tree *, mt)
+			__field(struct vm_area_struct *, vma)
+			__field(unsigned long, vm_start)
+			__field(unsigned long, vm_end)
+	),
+
+	TP_fast_assign(
+			__entry->mt		=3D mt;
+			__entry->vma		=3D vma;
+			__entry->vm_start	=3D vma->vm_start;
+			__entry->vm_end		=3D vma->vm_end - 1;
+	),
+
+	TP_printk("mt_mod %p, (%p), STORE, %lu, %lu,",
+		  __entry->mt, __entry->vma,
+		  (unsigned long) __entry->vm_start,
+		  (unsigned long) __entry->vm_end
+	)
+);
+
+
+TRACE_EVENT(exit_mmap,
+	TP_PROTO(struct mm_struct *mm),
+
+	TP_ARGS(mm),
+
+	TP_STRUCT__entry(
+			__field(struct mm_struct *, mm)
+			__field(struct maple_tree *, mt)
+	),
+
+	TP_fast_assign(
+		       __entry->mm		=3D mm;
+		       __entry->mt		=3D &mm->mm_mt;
+	),
+
+	TP_printk("mt_mod %p, DESTROY\n",
+		  __entry->mt
+	)
+);
+
 #endif
=20
 /* This part must be outside protection */
diff --git a/kernel/fork.c b/kernel/fork.c
index 9d44f2d46c69..1840da0732f6 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -585,6 +585,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *=
mm,
 	int retval;
 	unsigned long charge;
 	LIST_HEAD(uf);
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	uprobe_start_dup_mmap();
 	if (mmap_write_lock_killable(oldmm)) {
@@ -614,6 +615,10 @@ static __latent_entropy int dup_mmap(struct mm_struct =
*mm,
 		goto out;
 	khugepaged_fork(mm, oldmm);
=20
+	retval =3D mas_expected_entries(&mas, oldmm->map_count);
+	if (retval)
+		goto out;
+
 	prev =3D NULL;
 	for (mpnt =3D oldmm->mmap; mpnt; mpnt =3D mpnt->vm_next) {
 		struct file *file;
@@ -629,7 +634,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *=
mm,
 		 */
 		if (fatal_signal_pending(current)) {
 			retval =3D -EINTR;
-			goto out;
+			goto loop_out;
 		}
 		if (mpnt->vm_flags & VM_ACCOUNT) {
 			unsigned long len =3D vma_pages(mpnt);
@@ -694,6 +699,11 @@ static __latent_entropy int dup_mmap(struct mm_struct =
*mm,
 		rb_link =3D &tmp->vm_rb.rb_right;
 		rb_parent =3D &tmp->vm_rb;
=20
+		/* Link the vma into the MT */
+		mas.index =3D tmp->vm_start;
+		mas.last =3D tmp->vm_end - 1;
+		mas_store(&mas, tmp);
+
 		mm->map_count++;
 		if (!(tmp->vm_flags & VM_WIPEONFORK))
 			retval =3D copy_page_range(tmp, mpnt);
@@ -702,10 +712,12 @@ static __latent_entropy int dup_mmap(struct mm_struct=
 *mm,
 			tmp->vm_ops->open(tmp);
=20
 		if (retval)
-			goto out;
+			goto loop_out;
 	}
 	/* a new mm has just been created */
 	retval =3D arch_dup_mmap(oldmm, mm);
+loop_out:
+	mas_destroy(&mas);
 out:
 	mmap_write_unlock(mm);
 	flush_tlb_mm(oldmm);
@@ -721,7 +733,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *=
mm,
 fail_nomem:
 	retval =3D -ENOMEM;
 	vm_unacct_memory(charge);
-	goto out;
+	goto loop_out;
 }
=20
 static inline int mm_alloc_pgd(struct mm_struct *mm)
@@ -1111,6 +1123,8 @@ static struct mm_struct *mm_init(struct mm_struct *mm=
, struct task_struct *p,
 {
 	mm->mmap =3D NULL;
 	mm->mm_rb =3D RB_ROOT;
+	mt_init_flags(&mm->mm_mt, MM_MT_FLAGS);
+	mt_set_external_lock(&mm->mm_mt, &mm->mmap_lock);
 	mm->vmacache_seqnum =3D 0;
 	atomic_set(&mm->mm_users, 1);
 	atomic_set(&mm->mm_count, 1);
diff --git a/mm/init-mm.c b/mm/init-mm.c
index fbe7844d0912..b912b0f2eced 100644
--- a/mm/init-mm.c
+++ b/mm/init-mm.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/mm_types.h>
 #include <linux/rbtree.h>
+#include <linux/maple_tree.h>
 #include <linux/rwsem.h>
 #include <linux/spinlock.h>
 #include <linux/list.h>
@@ -29,6 +30,7 @@
  */
 struct mm_struct init_mm =3D {
 	.mm_rb		=3D RB_ROOT,
+	.mm_mt		=3D MTREE_INIT_EXT(mm_mt, MM_MT_FLAGS, init_mm.mmap_lock),
 	.pgd		=3D swapper_pg_dir,
 	.mm_users	=3D ATOMIC_INIT(2),
 	.mm_count	=3D ATOMIC_INIT(1),
diff --git a/mm/mmap.c b/mm/mmap.c
index 61e6135c54ef..9c75bd3b78ba 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -381,7 +381,70 @@ static int browse_rb(struct mm_struct *mm)
 	}
 	return bug ? -1 : i;
 }
+#if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
+extern void mt_validate(struct maple_tree *mt);
+extern void mt_dump(const struct maple_tree *mt);
=20
+/* Validate the maple tree */
+static void validate_mm_mt(struct mm_struct *mm)
+{
+	struct maple_tree *mt =3D &mm->mm_mt;
+	struct vm_area_struct *vma_mt, *vma =3D mm->mmap;
+
+	MA_STATE(mas, mt, 0, 0);
+	mas_for_each(&mas, vma_mt, ULONG_MAX) {
+		if (xa_is_zero(vma_mt))
+			continue;
+
+		if (!vma)
+			break;
+
+		if ((vma !=3D vma_mt) ||
+		    (vma->vm_start !=3D vma_mt->vm_start) ||
+		    (vma->vm_end !=3D vma_mt->vm_end) ||
+		    (vma->vm_start !=3D mas.index) ||
+		    (vma->vm_end - 1 !=3D mas.last)) {
+			pr_emerg("issue in %s\n", current->comm);
+			dump_stack();
+#ifdef CONFIG_DEBUG_VM
+			dump_vma(vma_mt);
+			pr_emerg("and next in rb\n");
+			dump_vma(vma->vm_next);
+#endif
+			pr_emerg("mt piv: %px %lu - %lu\n", vma_mt,
+				 mas.index, mas.last);
+			pr_emerg("mt vma: %px %lu - %lu\n", vma_mt,
+				 vma_mt->vm_start, vma_mt->vm_end);
+			pr_emerg("rb vma: %px %lu - %lu\n", vma,
+				 vma->vm_start, vma->vm_end);
+			pr_emerg("rb->next =3D %px %lu - %lu\n", vma->vm_next,
+					vma->vm_next->vm_start, vma->vm_next->vm_end);
+
+			mt_dump(mas.tree);
+			if (vma_mt->vm_end !=3D mas.last + 1) {
+				pr_err("vma: %px vma_mt %lu-%lu\tmt %lu-%lu\n",
+						mm, vma_mt->vm_start, vma_mt->vm_end,
+						mas.index, mas.last);
+				mt_dump(mas.tree);
+			}
+			VM_BUG_ON_MM(vma_mt->vm_end !=3D mas.last + 1, mm);
+			if (vma_mt->vm_start !=3D mas.index) {
+				pr_err("vma: %px vma_mt %px %lu - %lu doesn't match\n",
+						mm, vma_mt, vma_mt->vm_start, vma_mt->vm_end);
+				mt_dump(mas.tree);
+			}
+			VM_BUG_ON_MM(vma_mt->vm_start !=3D mas.index, mm);
+		}
+		VM_BUG_ON(vma !=3D vma_mt);
+		vma =3D vma->vm_next;
+
+	}
+	VM_BUG_ON(vma);
+	mt_validate(&mm->mm_mt);
+}
+#else
+#define validate_mm_mt(root) do { } while (0)
+#endif
 static void validate_mm_rb(struct rb_root *root, struct vm_area_struct *ig=
nore)
 {
 	struct rb_node *nd;
@@ -436,6 +499,7 @@ static void validate_mm(struct mm_struct *mm)
 }
 #else
 #define validate_mm_rb(root, ignore) do { } while (0)
+#define validate_mm_mt(root) do { } while (0)
 #define validate_mm(mm) do { } while (0)
 #endif
=20
@@ -680,6 +744,56 @@ static void __vma_link_file(struct vm_area_struct *vma=
)
 	}
 }
=20
+/*
+ * vma_mas_store() - Store a VMA in the maple tree.
+ * @vma: The vm_area_struct
+ * @mas: The maple state
+ *
+ * Efficient way to store a VMA in the maple tree when the @mas has alread=
y
+ * walked to the correct location.
+ *
+ * Note: the end address is inclusive in the maple tree.
+ */
+void vma_mas_store(struct vm_area_struct *vma, struct ma_state *mas)
+{
+	trace_vma_store(mas->tree, vma);
+	mas_set_range(mas, vma->vm_start, vma->vm_end - 1);
+	mas_store_prealloc(mas, vma);
+}
+
+/*
+ * vma_mas_remove() - Remove a VMA from the maple tree.
+ * @vma: The vm_area_struct
+ * @mas: The maple state
+ *
+ * Efficient way to remove a VMA from the maple tree when the @mas has alr=
eady
+ * been established and points to the correct location.
+ * Note: the end address is inclusive in the maple tree.
+ */
+void vma_mas_remove(struct vm_area_struct *vma, struct ma_state *mas)
+{
+	trace_vma_mas_szero(mas->tree, vma->vm_start, vma->vm_end - 1);
+	mas->index =3D vma->vm_start;
+	mas->last =3D vma->vm_end - 1;
+	mas_store_prealloc(mas, NULL);
+}
+
+/*
+ * vma_mas_szero() - Set a given range to zero.  Used when modifying a
+ * vm_area_struct start or end.
+ *
+ * @mm: The struct_mm
+ * @start: The start address to zero
+ * @end: The end address to zero.
+ */
+static inline void vma_mas_szero(struct ma_state *mas, unsigned long start=
,
+				unsigned long end)
+{
+	trace_vma_mas_szero(mas->tree, start, end - 1);
+	mas_set_range(mas, start, end - 1);
+	mas_store_prealloc(mas, NULL);
+}
+
 static void
 __vma_link(struct mm_struct *mm, struct vm_area_struct *vma,
 	struct vm_area_struct *prev, struct rb_node **rb_link,
@@ -689,17 +803,22 @@ __vma_link(struct mm_struct *mm, struct vm_area_struc=
t *vma,
 	__vma_link_rb(mm, vma, rb_link, rb_parent);
 }
=20
-static void vma_link(struct mm_struct *mm, struct vm_area_struct *vma,
+static int vma_link(struct mm_struct *mm, struct vm_area_struct *vma,
 			struct vm_area_struct *prev, struct rb_node **rb_link,
 			struct rb_node *rb_parent)
 {
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
 	struct address_space *mapping =3D NULL;
=20
+	if (mas_preallocate(&mas, vma, GFP_KERNEL))
+		return -ENOMEM;
+
 	if (vma->vm_file) {
 		mapping =3D vma->vm_file->f_mapping;
 		i_mmap_lock_write(mapping);
 	}
=20
+	vma_mas_store(vma, &mas);
 	__vma_link(mm, vma, prev, rb_link, rb_parent);
 	__vma_link_file(vma);
=20
@@ -708,13 +827,15 @@ static void vma_link(struct mm_struct *mm, struct vm_=
area_struct *vma,
=20
 	mm->map_count++;
 	validate_mm(mm);
+	return 0;
 }
=20
 /*
  * Helper for vma_adjust() in the split_vma insert case: insert a vma into=
 the
  * mm's list and rbtree.  It has already been inserted into the interval t=
ree.
  */
-static void __insert_vm_struct(struct mm_struct *mm, struct vm_area_struct=
 *vma)
+static void __insert_vm_struct(struct mm_struct *mm, struct ma_state *mas,
+			       struct vm_area_struct *vma)
 {
 	struct vm_area_struct *prev;
 	struct rb_node **rb_link, *rb_parent;
@@ -722,7 +843,10 @@ static void __insert_vm_struct(struct mm_struct *mm, s=
truct vm_area_struct *vma)
 	if (find_vma_links(mm, vma->vm_start, vma->vm_end,
 			   &prev, &rb_link, &rb_parent))
 		BUG();
-	__vma_link(mm, vma, prev, rb_link, rb_parent);
+
+	vma_mas_store(vma, mas);
+	__vma_link_list(mm, vma, prev);
+	__vma_link_rb(mm, vma, rb_link, rb_parent);
 	mm->map_count++;
 }
=20
@@ -756,10 +880,13 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned=
 long start,
 	bool start_changed =3D false, end_changed =3D false;
 	long adjust_next =3D 0;
 	int remove_next =3D 0;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	struct vm_area_struct *exporter =3D NULL, *importer =3D NULL;
=20
-	if (next && !insert) {
-		struct vm_area_struct *exporter =3D NULL, *importer =3D NULL;
+	validate_mm(mm);
+	validate_mm_mt(mm);
=20
+	if (next && !insert) {
 		if (end >=3D next->vm_end) {
 			/*
 			 * vma expands, overlapping all the next, and
@@ -842,6 +969,12 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned =
long start,
 again:
 	vma_adjust_trans_huge(orig_vma, start, end, adjust_next);
=20
+	if (mas_preallocate(&mas, vma, GFP_KERNEL)) {
+		if (exporter && exporter->anon_vma)
+			unlink_anon_vmas(importer);
+		return -ENOMEM;
+	}
+
 	if (file) {
 		mapping =3D file->f_mapping;
 		root =3D &mapping->i_mmap;
@@ -882,17 +1015,28 @@ int __vma_adjust(struct vm_area_struct *vma, unsigne=
d long start,
 	}
=20
 	if (start !=3D vma->vm_start) {
+		unsigned long old_start =3D vma->vm_start;
 		vma->vm_start =3D start;
+		if (old_start < start)
+			vma_mas_szero(&mas, old_start, start);
 		start_changed =3D true;
 	}
 	if (end !=3D vma->vm_end) {
+		unsigned long old_end =3D vma->vm_end;
 		vma->vm_end =3D end;
+		if (old_end > end)
+			vma_mas_szero(&mas, end, old_end);
 		end_changed =3D true;
 	}
+
+	if (end_changed || start_changed)
+		vma_mas_store(vma, &mas);
+
 	vma->vm_pgoff =3D pgoff;
 	if (adjust_next) {
 		next->vm_start +=3D adjust_next;
 		next->vm_pgoff +=3D adjust_next >> PAGE_SHIFT;
+		vma_mas_store(next, &mas);
 	}
=20
 	if (file) {
@@ -906,6 +1050,8 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned =
long start,
 		/*
 		 * vma_merge has merged next into vma, and needs
 		 * us to remove next before dropping the locks.
+		 * Since we have expanded over this vma, the maple tree will
+		 * have overwritten by storing the value
 		 */
 		if (remove_next !=3D 3)
 			__vma_unlink(mm, next, next);
@@ -928,7 +1074,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned =
long start,
 		 * us to insert it before dropping the locks
 		 * (it may either follow vma or precede it).
 		 */
-		__insert_vm_struct(mm, insert);
+		__insert_vm_struct(mm, &mas, insert);
 	} else {
 		if (start_changed)
 			vma_gap_update(vma);
@@ -1025,6 +1171,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned=
 long start,
 		uprobe_mmap(insert);
=20
 	validate_mm(mm);
+	validate_mm_mt(mm);
=20
 	return 0;
 }
@@ -1178,6 +1325,7 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm=
,
 	struct vm_area_struct *area, *next;
 	int err;
=20
+	validate_mm_mt(mm);
 	/*
 	 * We later require that vma->vm_flags =3D=3D vm_flags,
 	 * so this tests vma->vm_flags & VM_SPECIAL, too.
@@ -1253,6 +1401,7 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm=
,
 		khugepaged_enter_vma(area, vm_flags);
 		return area;
 	}
+	validate_mm_mt(mm);
=20
 	return NULL;
 }
@@ -1732,6 +1881,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 	struct rb_node **rb_link, *rb_parent;
 	unsigned long charged =3D 0;
=20
+	validate_mm_mt(mm);
 	/* Check against address space limit. */
 	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT)) {
 		unsigned long nr_pages;
@@ -1846,7 +1996,13 @@ unsigned long mmap_region(struct file *file, unsigne=
d long addr,
 			goto free_vma;
 	}
=20
-	vma_link(mm, vma, prev, rb_link, rb_parent);
+	if (vma_link(mm, vma, prev, rb_link, rb_parent)) {
+		error =3D -ENOMEM;
+		if (file)
+			goto unmap_and_free_vma;
+		else
+			goto free_vma;
+	}
=20
 	/*
 	 * vma_merge() calls khugepaged_enter_vma() either, the below
@@ -1886,6 +2042,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
=20
 	vma_set_page_prot(vma);
=20
+	validate_mm_mt(mm);
 	return addr;
=20
 unmap_and_free_vma:
@@ -1902,6 +2059,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 unacct_error:
 	if (charged)
 		vm_unacct_memory(charged);
+	validate_mm_mt(mm);
 	return error;
 }
=20
@@ -1918,12 +2076,19 @@ static unsigned long unmapped_area(struct vm_unmapp=
ed_area_info *info)
 	struct mm_struct *mm =3D current->mm;
 	struct vm_area_struct *vma;
 	unsigned long length, low_limit, high_limit, gap_start, gap_end;
+	unsigned long gap;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	/* Adjust search length to account for worst case alignment overhead */
 	length =3D info->length + info->align_mask;
 	if (length < info->length)
 		return -ENOMEM;
=20
+	mas_empty_area(&mas, info->low_limit, info->high_limit - 1,
+			   length);
+	gap =3D mas.index;
+	gap +=3D (info->align_offset - gap) & info->align_mask;
+
 	/* Adjust search limits by the desired length */
 	if (info->high_limit < length)
 		return -ENOMEM;
@@ -2005,20 +2170,31 @@ static unsigned long unmapped_area(struct vm_unmapp=
ed_area_info *info)
=20
 	VM_BUG_ON(gap_start + info->length > info->high_limit);
 	VM_BUG_ON(gap_start + info->length > gap_end);
+
+	VM_BUG_ON(gap !=3D gap_start);
 	return gap_start;
 }
=20
 static unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *i=
nfo)
 {
 	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *vma;
+	struct vm_area_struct *vma =3D NULL;
 	unsigned long length, low_limit, high_limit, gap_start, gap_end;
+	unsigned long gap;
+
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	validate_mm_mt(mm);
=20
 	/* Adjust search length to account for worst case alignment overhead */
 	length =3D info->length + info->align_mask;
 	if (length < info->length)
 		return -ENOMEM;
=20
+	mas_empty_area_rev(&mas, info->low_limit, info->high_limit - 1,
+		   length);
+	gap =3D mas.last + 1 - info->length;
+	gap -=3D (gap - info->align_offset) & info->align_mask;
+
 	/*
 	 * Adjust search limits by the desired length.
 	 * See implementation comment at top of unmapped_area().
@@ -2104,6 +2280,32 @@ static unsigned long unmapped_area_topdown(struct vm=
_unmapped_area_info *info)
=20
 	VM_BUG_ON(gap_end < info->low_limit);
 	VM_BUG_ON(gap_end < gap_start);
+
+	if (gap !=3D gap_end) {
+		pr_err("%s: %px Gap was found: mt %lu gap_end %lu\n", __func__,
+		       mm, gap, gap_end);
+		pr_err("window was %lu - %lu size %lu\n", info->high_limit,
+		       info->low_limit, length);
+		pr_err("mas.min %lu max %lu mas.last %lu\n", mas.min, mas.max,
+		       mas.last);
+		pr_err("mas.index %lu align mask %lu offset %lu\n", mas.index,
+		       info->align_mask, info->align_offset);
+		pr_err("rb_find_vma find on %lu =3D> %px (%px)\n", mas.index,
+		       find_vma(mm, mas.index), vma);
+#if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
+		mt_dump(&mm->mm_mt);
+#endif
+		{
+			struct vm_area_struct *dv =3D mm->mmap;
+
+			while (dv) {
+				printk("vma %px %lu-%lu\n", dv, dv->vm_start, dv->vm_end);
+				dv =3D dv->vm_next;
+			}
+		}
+		VM_BUG_ON(gap !=3D gap_end);
+	}
+
 	return gap_end;
 }
=20
@@ -2326,7 +2528,6 @@ struct vm_area_struct *find_vma(struct mm_struct *mm,=
 unsigned long addr)
 		vmacache_update(addr, vma);
 	return vma;
 }
-
 EXPORT_SYMBOL(find_vma);
=20
 /*
@@ -2399,7 +2600,9 @@ int expand_upwards(struct vm_area_struct *vma, unsign=
ed long address)
 	struct vm_area_struct *next;
 	unsigned long gap_addr;
 	int error =3D 0;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
+	validate_mm_mt(mm);
 	if (!(vma->vm_flags & VM_GROWSUP))
 		return -EFAULT;
=20
@@ -2423,9 +2626,14 @@ int expand_upwards(struct vm_area_struct *vma, unsig=
ned long address)
 		/* Check that both stack segments have the same anon_vma? */
 	}
=20
+	if (mas_preallocate(&mas, vma, GFP_KERNEL))
+		return -ENOMEM;
+
 	/* We must make sure the anon_vma is allocated. */
-	if (unlikely(anon_vma_prepare(vma)))
+	if (unlikely(anon_vma_prepare(vma))) {
+		mas_destroy(&mas);
 		return -ENOMEM;
+	}
=20
 	/*
 	 * vma->vm_start/vm_end cannot change under us because the caller
@@ -2462,6 +2670,8 @@ int expand_upwards(struct vm_area_struct *vma, unsign=
ed long address)
 				vm_stat_account(mm, vma->vm_flags, grow);
 				anon_vma_interval_tree_pre_update_vma(vma);
 				vma->vm_end =3D address;
+				/* Overwrite old entry in mtree. */
+				vma_mas_store(vma, &mas);
 				anon_vma_interval_tree_post_update_vma(vma);
 				if (vma->vm_next)
 					vma_gap_update(vma->vm_next);
@@ -2476,6 +2686,8 @@ int expand_upwards(struct vm_area_struct *vma, unsign=
ed long address)
 	anon_vma_unlock_write(vma->anon_vma);
 	khugepaged_enter_vma(vma, vma->vm_flags);
 	validate_mm(mm);
+	validate_mm_mt(mm);
+	mas_destroy(&mas);
 	return error;
 }
 #endif /* CONFIG_STACK_GROWSUP || CONFIG_IA64 */
@@ -2489,7 +2701,9 @@ int expand_downwards(struct vm_area_struct *vma,
 	struct mm_struct *mm =3D vma->vm_mm;
 	struct vm_area_struct *prev;
 	int error =3D 0;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
+	validate_mm(mm);
 	address &=3D PAGE_MASK;
 	if (address < mmap_min_addr)
 		return -EPERM;
@@ -2503,9 +2717,14 @@ int expand_downwards(struct vm_area_struct *vma,
 			return -ENOMEM;
 	}
=20
+	if (mas_preallocate(&mas, vma, GFP_KERNEL))
+		return -ENOMEM;
+
 	/* We must make sure the anon_vma is allocated. */
-	if (unlikely(anon_vma_prepare(vma)))
+	if (unlikely(anon_vma_prepare(vma))) {
+		mas_destroy(&mas);
 		return -ENOMEM;
+	}
=20
 	/*
 	 * vma->vm_start/vm_end cannot change under us because the caller
@@ -2543,6 +2762,8 @@ int expand_downwards(struct vm_area_struct *vma,
 				anon_vma_interval_tree_pre_update_vma(vma);
 				vma->vm_start =3D address;
 				vma->vm_pgoff -=3D grow;
+				/* Overwrite old entry in mtree. */
+				vma_mas_store(vma, &mas);
 				anon_vma_interval_tree_post_update_vma(vma);
 				vma_gap_update(vma);
 				spin_unlock(&mm->page_table_lock);
@@ -2554,6 +2775,7 @@ int expand_downwards(struct vm_area_struct *vma,
 	anon_vma_unlock_write(vma->anon_vma);
 	khugepaged_enter_vma(vma, vma->vm_flags);
 	validate_mm(mm);
+	mas_destroy(&mas);
 	return error;
 }
=20
@@ -2676,14 +2898,17 @@ static void unmap_region(struct mm_struct *mm,
  * vma list as we go..
  */
 static bool
-detach_vmas_to_be_unmapped(struct mm_struct *mm, struct vm_area_struct *vm=
a,
-	struct vm_area_struct *prev, unsigned long end)
+detach_vmas_to_be_unmapped(struct mm_struct *mm, struct ma_state *mas,
+	struct vm_area_struct *vma, struct vm_area_struct *prev,
+	unsigned long end)
 {
 	struct vm_area_struct **insertion_point;
 	struct vm_area_struct *tail_vma =3D NULL;
=20
 	insertion_point =3D (prev ? &prev->vm_next : &mm->mmap);
 	vma->vm_prev =3D NULL;
+	mas_set_range(mas, vma->vm_start, end - 1);
+	mas_store_prealloc(mas, NULL);
 	do {
 		vma_rb_erase(vma, &mm->mm_rb);
 		if (vma->vm_flags & VM_LOCKED)
@@ -2724,6 +2949,7 @@ int __split_vma(struct mm_struct *mm, struct vm_area_=
struct *vma,
 {
 	struct vm_area_struct *new;
 	int err;
+	validate_mm_mt(mm);
=20
 	if (vma->vm_ops && vma->vm_ops->may_split) {
 		err =3D vma->vm_ops->may_split(vma, addr);
@@ -2776,6 +3002,7 @@ int __split_vma(struct mm_struct *mm, struct vm_area_=
struct *vma,
 	mpol_put(vma_policy(new));
  out_free_vma:
 	vm_area_free(new);
+	validate_mm_mt(mm);
 	return err;
 }
=20
@@ -2802,6 +3029,8 @@ int __do_munmap(struct mm_struct *mm, unsigned long s=
tart, size_t len,
 {
 	unsigned long end;
 	struct vm_area_struct *vma, *prev, *last;
+	int error =3D -ENOMEM;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	if ((offset_in_page(start)) || start > TASK_SIZE || len > TASK_SIZE-start=
)
 		return -EINVAL;
@@ -2822,6 +3051,9 @@ int __do_munmap(struct mm_struct *mm, unsigned long s=
tart, size_t len,
 	vma =3D find_vma_intersection(mm, start, end);
 	if (!vma)
 		return 0;
+
+	if (mas_preallocate(&mas, vma, GFP_KERNEL))
+		return -ENOMEM;
 	prev =3D vma->vm_prev;
=20
 	/*
@@ -2832,7 +3064,6 @@ int __do_munmap(struct mm_struct *mm, unsigned long s=
tart, size_t len,
 	 * places tmp vma above, and higher split_vma places tmp vma below.
 	 */
 	if (start > vma->vm_start) {
-		int error;
=20
 		/*
 		 * Make sure that map_count on return from munmap() will
@@ -2840,20 +3071,20 @@ int __do_munmap(struct mm_struct *mm, unsigned long=
 start, size_t len,
 		 * its limit temporarily, to help free resources as expected.
 		 */
 		if (end < vma->vm_end && mm->map_count >=3D sysctl_max_map_count)
-			return -ENOMEM;
+			goto map_count_exceeded;
=20
 		error =3D __split_vma(mm, vma, start, 0);
 		if (error)
-			return error;
+			goto split_failed;
 		prev =3D vma;
 	}
=20
 	/* Does it split the last one? */
 	last =3D find_vma(mm, end);
 	if (last && end > last->vm_start) {
-		int error =3D __split_vma(mm, last, end, 1);
+		error =3D __split_vma(mm, last, end, 1);
 		if (error)
-			return error;
+			goto split_failed;
 	}
 	vma =3D vma_next(mm, prev);
=20
@@ -2867,13 +3098,13 @@ int __do_munmap(struct mm_struct *mm, unsigned long=
 start, size_t len,
 		 * split, despite we could. This is unlikely enough
 		 * failure that it's not worth optimizing it for.
 		 */
-		int error =3D userfaultfd_unmap_prep(vma, start, end, uf);
+		error =3D userfaultfd_unmap_prep(vma, start, end, uf);
 		if (error)
-			return error;
+			goto userfaultfd_error;
 	}
=20
 	/* Detach vmas from rbtree */
-	if (!detach_vmas_to_be_unmapped(mm, vma, prev, end))
+	if (!detach_vmas_to_be_unmapped(mm, &mas, vma, prev, end))
 		downgrade =3D false;
=20
 	if (downgrade)
@@ -2885,6 +3116,12 @@ int __do_munmap(struct mm_struct *mm, unsigned long =
start, size_t len,
 	remove_vma_list(mm, vma);
=20
 	return downgrade ? 1 : 0;
+
+map_count_exceeded:
+split_failed:
+userfaultfd_error:
+	mas_destroy(&mas);
+	return error;
 }
=20
 int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
@@ -3024,6 +3261,7 @@ static int do_brk_flags(unsigned long addr, unsigned =
long len, unsigned long fla
 	pgoff_t pgoff =3D addr >> PAGE_SHIFT;
 	int error;
 	unsigned long mapped_addr;
+	validate_mm_mt(mm);
=20
 	/* Until we need other flags, refuse anything except VM_EXEC. */
 	if ((flags & (~VM_EXEC)) !=3D 0)
@@ -3073,7 +3311,9 @@ static int do_brk_flags(unsigned long addr, unsigned =
long len, unsigned long fla
 	vma->vm_pgoff =3D pgoff;
 	vma->vm_flags =3D flags;
 	vma->vm_page_prot =3D vm_get_page_prot(flags);
-	vma_link(mm, vma, prev, rb_link, rb_parent);
+	if(vma_link(mm, vma, prev, rb_link, rb_parent))
+		goto no_vma_link;
+
 out:
 	perf_event_mmap(vma);
 	mm->total_vm +=3D len >> PAGE_SHIFT;
@@ -3081,7 +3321,12 @@ static int do_brk_flags(unsigned long addr, unsigned=
 long len, unsigned long fla
 	if (flags & VM_LOCKED)
 		mm->locked_vm +=3D (len >> PAGE_SHIFT);
 	vma->vm_flags |=3D VM_SOFTDIRTY;
+	validate_mm_mt(mm);
 	return 0;
+
+no_vma_link:
+	vm_area_free(vma);
+	return -ENOMEM;
 }
=20
 int vm_brk_flags(unsigned long addr, unsigned long request, unsigned long =
flags)
@@ -3170,6 +3415,9 @@ void exit_mmap(struct mm_struct *mm)
 		vma =3D remove_vma(vma);
 		cond_resched();
 	}
+
+	trace_exit_mmap(mm);
+	__mt_destroy(&mm->mm_mt);
 	mm->mmap =3D NULL;
 	mmap_write_unlock(mm);
 	vm_unacct_memory(nr_accounted);
@@ -3183,10 +3431,25 @@ int insert_vm_struct(struct mm_struct *mm, struct v=
m_area_struct *vma)
 {
 	struct vm_area_struct *prev;
 	struct rb_node **rb_link, *rb_parent;
+	unsigned long start =3D vma->vm_start;
+	struct vm_area_struct *overlap =3D NULL;
=20
 	if (find_vma_links(mm, vma->vm_start, vma->vm_end,
 			   &prev, &rb_link, &rb_parent))
 		return -ENOMEM;
+
+	overlap =3D mt_find(&mm->mm_mt, &start, vma->vm_end - 1);
+	if (overlap) {
+
+		pr_err("Found vma ending at %lu\n", start - 1);
+		pr_err("vma : %lu =3D> %lu-%lu\n", (unsigned long)overlap,
+				overlap->vm_start, overlap->vm_end - 1);
+#if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
+		mt_dump(&mm->mm_mt);
+#endif
+		BUG();
+	}
+
 	if ((vma->vm_flags & VM_ACCOUNT) &&
 	     security_vm_enough_memory_mm(mm, vma_pages(vma)))
 		return -ENOMEM;
@@ -3208,7 +3471,9 @@ int insert_vm_struct(struct mm_struct *mm, struct vm_=
area_struct *vma)
 		vma->vm_pgoff =3D vma->vm_start >> PAGE_SHIFT;
 	}
=20
-	vma_link(mm, vma, prev, rb_link, rb_parent);
+	if (vma_link(mm, vma, prev, rb_link, rb_parent))
+		return -ENOMEM;
+
 	return 0;
 }
=20
@@ -3226,7 +3491,9 @@ struct vm_area_struct *copy_vma(struct vm_area_struct=
 **vmap,
 	struct vm_area_struct *new_vma, *prev;
 	struct rb_node **rb_link, *rb_parent;
 	bool faulted_in_anon_vma =3D true;
+	unsigned long index =3D addr;
=20
+	validate_mm_mt(mm);
 	/*
 	 * If anonymous vma has not yet been faulted, update new pgoff
 	 * to match new location, to increase its chance of merging.
@@ -3238,6 +3505,8 @@ struct vm_area_struct *copy_vma(struct vm_area_struct=
 **vmap,
=20
 	if (find_vma_links(mm, addr, addr + len, &prev, &rb_link, &rb_parent))
 		return NULL;	/* should never get here */
+	if (mt_find(&mm->mm_mt, &index, addr+len - 1))
+		BUG();
 	new_vma =3D vma_merge(mm, prev, addr, addr + len, vma->vm_flags,
 			    vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
 			    vma->vm_userfaultfd_ctx, anon_vma_name(vma));
@@ -3281,6 +3550,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct=
 **vmap,
 		vma_link(mm, new_vma, prev, rb_link, rb_parent);
 		*need_rmap_locks =3D false;
 	}
+	validate_mm_mt(mm);
 	return new_vma;
=20
 out_free_mempol:
@@ -3288,6 +3558,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct=
 **vmap,
 out_free_vma:
 	vm_area_free(new_vma);
 out:
+	validate_mm_mt(mm);
 	return NULL;
 }
=20
@@ -3424,6 +3695,7 @@ static struct vm_area_struct *__install_special_mappi=
ng(
 	int ret;
 	struct vm_area_struct *vma;
=20
+	validate_mm_mt(mm);
 	vma =3D vm_area_alloc(mm);
 	if (unlikely(vma =3D=3D NULL))
 		return ERR_PTR(-ENOMEM);
@@ -3446,10 +3718,12 @@ static struct vm_area_struct *__install_special_map=
ping(
=20
 	perf_event_mmap(vma);
=20
+	validate_mm_mt(mm);
 	return vma;
=20
 out:
 	vm_area_free(vma);
+	validate_mm_mt(mm);
 	return ERR_PTR(ret);
 }
=20
diff --git a/mm/nommu.c b/mm/nommu.c
index 9d7afc2d959e..5af0b050eba8 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -545,6 +545,19 @@ static void put_nommu_region(struct vm_region *region)
 	__put_nommu_region(region);
 }
=20
+void vma_mas_store(struct vm_area_struct *vma, struct ma_state *mas)
+{
+	mas_set_range(mas, vma->vm_start, vma->vm_end - 1);
+	mas_store_prealloc(mas, vma);
+}
+
+void vma_mas_remove(struct vm_area_struct *vma, struct ma_state *mas)
+{
+	mas->index =3D vma->vm_start;
+	mas->last =3D vma->vm_end - 1;
+	mas_store_prealloc(mas, NULL);
+}
+
 /*
  * add a VMA into a process's mm_struct in the appropriate place in the li=
st
  * and tree and add to the address space's page tree also if not an anonym=
ous
--=20
2.35.1
