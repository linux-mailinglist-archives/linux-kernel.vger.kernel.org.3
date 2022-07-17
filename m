Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF04577356
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 04:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233366AbiGQCtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 22:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233256AbiGQCtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 22:49:02 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40BA1EAD3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 19:47:33 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26GJ8OWp003733;
        Sun, 17 Jul 2022 02:47:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=4SPxAHmLj31ouRAlcX/JHknvMOStmgpaQQOju3HYq/Y=;
 b=0kvlXNmh1Zqb8O+cfsd1EOKLNXUzOv5KPYh7+PxoWMQSZBgirM4lX2DtrqeHF/EcH1nR
 rXBt2PFzRpqVP9QM7vDGrRTtWCmJjpeLJ+o6N0MbHj9VDsPEMSI8KzxGkZwnV2HthvP0
 ZoOPYi0Spgca7AdDmQbA+YcQhlPZlSslMEvpWhzD8yzOq6t+osxdO8PPsKNPWrWRLDp3
 UFD6ZW/d9A1MojCtsg2FbbjMBTxRdSfAMKSSoHhARhnHM8Xmyh7eIDT1CLb9FiBxoULy
 F9E85tf4Iber7ClZvVfX8/WvDIufsFNyECrK9HlGNNLgBeNXu64kx9SCsfs0S5mt9uiB Sg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbmxs0x25-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:47:28 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26GMYISJ036113;
        Sun, 17 Jul 2022 02:47:27 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1ejp6a8-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:47:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kSdeRPi3IN6488qFFm/s+KGetDY4HZksPtt2mok5cuuxm9yMFjMxSRQzseVgzQOJtGgbHWduzMieiZdWLOmCyVA5haqNKcfHz8r9/wEIwuhqezbwpvIrafF5E2FYm0E0ufPUCMTt79NFWGf2ArCRme981HxQXhJwNGa+Fqpk7MDiGy8eayNclQFXccHr7vN/WuMnh1fEZhBuB/8SNQvienbpgIV8d53bVhviVeUOMibt36qww7F6GDbUXdVTuHW8Q41oxRbdV+W+yBQHfyMFHoKgk9QTMuqji11+3CL8PAPTXVPPbHHFrLl4PwOSpLVHn02EjJrU7YoUKayaNgzQ4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4SPxAHmLj31ouRAlcX/JHknvMOStmgpaQQOju3HYq/Y=;
 b=FNMvBZtMe0eLv56X6WNdkA2Cln50HdvkvGhFxSXpBMTlTNKxckwH6bvKivfDgyJMTxO00ShKlpRkDwNNRakuKeEBa+EAd2FEN1AZDHnerRWTTIq6JRuBQLGKPJipAPbNZvtG8lu8D6o+GwflNrcjt19PbVP+pyPYpSyzZa4XHy4osvnwq6ceGH57Eagrg25TpxQ8UDTMjqsyO6JdK8OogC61iCTO2BT6NPSWxKxeqfzovjwzhZnDxfILsdWLZ3avOiU4F1o6XdpMtfqUiqpG1kuuhUfOoPSm027NB4OoKDfggW/VodkCUc4Esep1wqQNGUAfwyp+6sOFBUje6o6OVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4SPxAHmLj31ouRAlcX/JHknvMOStmgpaQQOju3HYq/Y=;
 b=u/UKh1LtrA96nNgqjfCjPmqgvuzf27/kY5LgGb5BA7yy71x2B/TUWsCEYBmrLiJ/U0B3HUomhDYZxk5z4EudxyLaxJdKGzdw/hLqXw4+n0X6V3t5cRDm/H7ByiYbN9K1pJe0jhz12ELwGQBWnogYDbCZpECDkBddYK952sGNb8Q=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB2799.namprd10.prod.outlook.com (2603:10b6:805:d9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20; Sun, 17 Jul
 2022 02:47:24 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.020; Sun, 17 Jul 2022
 02:47:24 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, Hugh Dickins <hughd@google.com>
Subject: [PATCH v11 36/69] xtensa: remove vma linked list walks
Thread-Topic: [PATCH v11 36/69] xtensa: remove vma linked list walks
Thread-Index: AQHYmYd2FJHhDZsqiUWjGtYrfGXkEg==
Date:   Sun, 17 Jul 2022 02:46:49 +0000
Message-ID: <20220717024615.2106835-37-Liam.Howlett@oracle.com>
References: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 736de655-2c13-4b62-0b94-08da679eade7
x-ms-traffictypediagnostic: SN6PR10MB2799:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: weK7LY/6hA59FM3D8ayrK74A7ddQMMPxRAgn8WhvF1sk4WHH1OcyOLcPdUAdLaiIPfE5MQjJvAO3MhalPV7ytuSocJ4d5aOLpXBPX6EJkFI7AowsjhtYr9N8r1l7Tawfw0Z4wqjcQNYvSD3ZNqY2RUPRVoFenSxx1ifEil9FnLx/jpanErFjalmcsQCDVA1CMLje11FuY6nT3zt7x7VYqQvh4JDrUXT3zJf/rAobz2yhb8fmEeoSTRlx+KrpNa0Frjc3GlfSgDuQ62dpldkv5z8q+tT/3mVv/0ZIlCBZ/F9niQIqOsK9LJkX4ZACTcx4nR5MqaUuGE8hTsE/0GI8Kt9e/Gai+uzizOMcWKcxTZ/hPvfd+qzQopTgicXi5AY9QHOfNtE8MiYTBaU/xVy0wkTf+JI7EQKb+Mfxvi6RKHNQzj6NqUZwO7/vG49UBr1kC1O0wsF638lWuM2yLqMJHnnI2dDQK1LYD8cxOKXJEiyv26ohY2gPpgg+esMdLYSjMGB8c9BuHzmJoqediy8n07o6/gzdbn2qP5AIPPIlr/t2FOOBFEl6wC6nx+VfYV17N2JyAJJD18HSSJlHQIajqvXafs6RP2KNXOm9IG3rg2jzZS9odtETgXb1MkioX7jPNpp8g5uenT6mcBL1yQsR5AGDJehsYLXmNznGiw778Wf8dw/v95Ze7vogarBaimUjHr7utf+ldUuiaq+wG1ymhs199cFSZSlTNeRbwONq2nAuKXlN08jQ1WAbMNqYhwM0qDv/GufojY+gG+RR/yh1ALYcUpy0tuw8mwnHYLdrTnxFffXUmnd9C9em2ezIkxLnZQiHv2TOwaFp1VMOon2+6zlE+kiD7Oqo9qYUTXNa3axXgA5C3joqAs0x3205lCEJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(346002)(396003)(136003)(366004)(83380400001)(66446008)(66556008)(64756008)(66946007)(8676002)(122000001)(1076003)(2616005)(66476007)(186003)(38100700002)(91956017)(38070700005)(478600001)(6486002)(8936002)(5660300002)(44832011)(26005)(6666004)(41300700001)(6512007)(71200400001)(966005)(6506007)(316002)(110136005)(36756003)(2906002)(76116006)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0QCvu/O+ojgwg4CEXdQ21/wVeRnhtIjxWOHHGAShcMhdIwImABn7/9u7eI?=
 =?iso-8859-1?Q?sFyY6Cg33Zsrh7jS2Hq9WA8yf4+8oWE2VqAxV4hFaQLHWLTldi0RirrsTR?=
 =?iso-8859-1?Q?fm22zF1MYzq8GHHWtD4dKqh1oU3g0VfwzxvSEE1MVEfjraoNLgq97vkw9w?=
 =?iso-8859-1?Q?Ak6AzpB64ST9i9s6HWl0eiJ6+hhmr3EcrdQ7DT1UfT6wO1Rv7xLiJeKf9I?=
 =?iso-8859-1?Q?WhG11ZM/puCp9OuvkvztrJ3kO6jB2W48GuTdl4yFX3GxdbHLcySLHMu5mE?=
 =?iso-8859-1?Q?P1XfMhlLoI60P8z0gdv3O5sakwWny0x+ZWFxOOml8GVm5g+Qs1Wuf/gjq1?=
 =?iso-8859-1?Q?sUEvTbAQbmt2Cce+RIr++tCZqHalaepJfwh1zqv7BdOXm16/E1j/zwfVLY?=
 =?iso-8859-1?Q?kMDftSGNBmoIbcgMehcKHoTJiGQZ+JSVEH4X3NtUuueu/1qxfMMHmEU2O6?=
 =?iso-8859-1?Q?a/4H9gzkB595AaokSBXVUt0Wgk0mKuQcVWRF49oSGaVW1NbOz4z31/KfIW?=
 =?iso-8859-1?Q?CkpWC9ubsGw6zcYjsfSsgG+gQzGG0MKS4sHdr0a7c1XCUGP9jmVHqj6s8w?=
 =?iso-8859-1?Q?aAu2eOmywW1qEOXavZPQ09bkqGl+5+Z7wBQAC6DcfzPmjBepFveaYppj9n?=
 =?iso-8859-1?Q?0r9iEzqcxmzglDi6uaWiQZ+XEUN1tt/1yTTXDk5wMb7DfX+ReXcp56masM?=
 =?iso-8859-1?Q?e+TUtFsOjSp1P2l/Z0DRaIavy28Y7uzY5gTsn+yWBnN76H8FLTxUiM5bpK?=
 =?iso-8859-1?Q?Lswub6sbXVVSByYEK3zinYEQunDIUaXLUg4Xy6A+OBEY6Fkahc15QooD/f?=
 =?iso-8859-1?Q?NXL6FkBZJcqhwAkTET2eyQkGXRquIDDJUgMVDSoLvzxeVMx+/grWrjCtGp?=
 =?iso-8859-1?Q?+vVqxP34alvkLgwbZBa56Dbu3TVABEIWp2JDqBhq0lP00rDlE4lwLgBe8D?=
 =?iso-8859-1?Q?IK1aohAWgcXkCb6dR2UYM2MtBIqu7xkiNtHjGuIQlGyHRxitDe7K5pRWdI?=
 =?iso-8859-1?Q?IJZNZDAEDREfppShL2rKLExG0nBLzDFUcg55Xr5fhjN3u5URcNuiWl1BEj?=
 =?iso-8859-1?Q?npColCpAv56JedZetE6jcyWxQekQTHalGwm5YGwbvb5lLKrWcu1I0n4bpU?=
 =?iso-8859-1?Q?1zWb+hvLdt3k9AokywKtye5agyNMkcbMZXcBmEULeP3ZOhArpEjgyXp+ac?=
 =?iso-8859-1?Q?4UUijemKO+KOV+U8pO5UIqcC+Io6h3ayPt5Rx7N+P11i0r7m/ZnQsOhVE4?=
 =?iso-8859-1?Q?obyILVzcle1mYcVf+y8ruGmCAQyhYGFMf0YtD9bMPWGYtqdvzGwreKYt4y?=
 =?iso-8859-1?Q?72Wb7fNKtDq+T7lBAChFsTluVZ3K1xKPT3Q+CyS5//zzdgpXA9YuS/OcGR?=
 =?iso-8859-1?Q?9lC3QiJVFZRxjPO877w0JFbOKC0TLZWF0BnZK/qdd8Hl++aw89Vp4jvjS0?=
 =?iso-8859-1?Q?nN+WNMmDjjWpI0kP4sxrQ6M+OfMj7YdftS58VrMNps47UPZ6QaRo4EOu8Q?=
 =?iso-8859-1?Q?ifN3LrQ0LpYA+EnMCZVLbNrWOkS+1dxoJl1ZPVxlueIDdk5amqFUhZTYgB?=
 =?iso-8859-1?Q?B+QPnUoMftrd8+LCBNCd3zdWq43MafCMzokpuIzLZTY0rEhazkeVH/yjoH?=
 =?iso-8859-1?Q?o2v2RDrWefLw+H51ElAWmgcPdlB7StVWPLpzznf2JIMD/V8Xevyd2TbQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 736de655-2c13-4b62-0b94-08da679eade7
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2022 02:46:49.5213
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: inbe44eJxs9Vvn0I+Tt7oEinf4jn7PGHyXOYu+bRyuTHO7zrf0l0jrAxv0sv70fxNYshSIosq1gBy1Byc/rdAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2799
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-17_01,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=932
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207170010
X-Proofpoint-GUID: jioDZuSOSTp7u9m97nrSrii49vmLuu5p
X-Proofpoint-ORIG-GUID: jioDZuSOSTp7u9m97nrSrii49vmLuu5p
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

Use the VMA iterator instead.  Since VMA can no longer be NULL in the
loop, then deal with out-of-memory outside the loop.  This means a
slightly longer run time in the failure case (-ENOMEM) - it will run to
the end of the VMAs before erroring instead of in the middle of the loop.

Link: https://lkml.kernel.org/r/20220504011345.662299-21-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-37-Liam.Howlett@orac=
le.com
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: SeongJae Park <sj@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 arch/xtensa/kernel/syscall.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/xtensa/kernel/syscall.c b/arch/xtensa/kernel/syscall.c
index 201356faa7e6..b3c2450d6f23 100644
--- a/arch/xtensa/kernel/syscall.c
+++ b/arch/xtensa/kernel/syscall.c
@@ -58,6 +58,7 @@ unsigned long arch_get_unmapped_area(struct file *filp, u=
nsigned long addr,
 		unsigned long len, unsigned long pgoff, unsigned long flags)
 {
 	struct vm_area_struct *vmm;
+	struct vma_iterator vmi;
=20
 	if (flags & MAP_FIXED) {
 		/* We do not accept a shared mapping if it would violate
@@ -79,15 +80,20 @@ unsigned long arch_get_unmapped_area(struct file *filp,=
 unsigned long addr,
 	else
 		addr =3D PAGE_ALIGN(addr);
=20
-	for (vmm =3D find_vma(current->mm, addr); ; vmm =3D vmm->vm_next) {
-		/* At this point:  (!vmm || addr < vmm->vm_end). */
-		if (TASK_SIZE - len < addr)
-			return -ENOMEM;
-		if (!vmm || addr + len <=3D vm_start_gap(vmm))
-			return addr;
+	vma_iter_init(&vmi, current->mm, addr);
+	for_each_vma(vmi, vmm) {
+		/* At this point:  (addr < vmm->vm_end). */
+		if (addr + len <=3D vm_start_gap(vmm))
+			break;
+
 		addr =3D vmm->vm_end;
 		if (flags & MAP_SHARED)
 			addr =3D COLOUR_ALIGN(addr, pgoff);
 	}
+
+	if (TASK_SIZE - len < addr)
+		return -ENOMEM;
+
+	return addr;
 }
 #endif
--=20
2.35.1
