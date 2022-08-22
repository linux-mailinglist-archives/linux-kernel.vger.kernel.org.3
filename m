Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9D359C242
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236155AbiHVPJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235929AbiHVPJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:09:14 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB273E753
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:07:12 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MEpmTk016597;
        Mon, 22 Aug 2022 15:06:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Ukqb2QQQRBNcHyQVxqkE6N3xK8UmeIbkvheRC3rRcP0=;
 b=fTjLB12+1VaMzAm38N5lFjTY5QwQdbj+hwBWio/URNEv1LB5MEv/awiQX1jTDlkJ8I8P
 NWcijt/2ec/P6E78kOQnG2ZMfe5OVIPnJKa34GL2qOpegXrN4rMvTMGx+K56t46eu85F
 wWv1PyEVT5pYJdNLDp+ct2XdmK7EvTaYe7Tf6OXU4VA5/Tueo6m6taT2kL94R2W4U6/K
 x7NudRAoy+FFJ8nbc+r1CQclthkPZ28SrMk2m86GRpmEflvghs/ckd5qunhKj6aXy3LN
 HMqS0oginGicfPahCRHL5Ms7A7hSpEEDZGhDbF17c/lhKeDb21YhUGBxeIBVWvD56w7j rg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4bx681hv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:06:28 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27ME4NZx026712;
        Mon, 22 Aug 2022 15:06:27 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2043.outbound.protection.outlook.com [104.47.51.43])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mm8bef2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:06:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sis4wwdelOHbon41vAs0IpQG4gB0QEwP2Ypz4q3ca5cEbRd73F2gHYh7gTd10/8moJ7fELTP+fKFkW9piS2Rh3GQ6Qxe/PtekSN5OnyADusjkH3pQ6IGEn19pzHp2vdNGgDcL+I2Q9JMW38dNTyiIRm6aMaNmX9szDSNZEkXp4MnARygY7ijYE+MoGE+e4gYPn7K6xhhT5X3q8akkOom0n+fjmawwSo8zNQFUIGEAuCM/MgfPkm2KlrIzo344fDwipe9QcPzSfXs02R27WglfCAPWo6NrMesEhN7VuFGPzXJimCSCySX4eACA3UXb/n6WnMYT+nMHVJDBzi4b9x6ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ukqb2QQQRBNcHyQVxqkE6N3xK8UmeIbkvheRC3rRcP0=;
 b=nhE2SWXwbVR1A7syt5h2uHy+slDfNC+Ob6qZuICGZXEjeKCn+eib7bJV3e9X3oCB47InbqixkFqQeo/WwEoH9yzUW34hKtUgml2YDHQqmbxusaPzwS2KD1mUYkJvEzKOkdNRsTs5F4LJdLZUbwWzJYo4GxmwlJ8+FnT4pbjm/B2sMMp7Y1ro9gZX7WcIisruNeZLnm7M86pWU87LWh13C658MU9nWXYXA9PBOMGA2/1HYEw6+IRlTM2pGsuaDZTcfvWpOb6Qb7oR9xCZqiMx5/0uFx07z9Ip/dAfBqCYs+FFs87/PVFx8UMEbmaZqrRFsXVSzwIW0eSOmYh1zjphfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ukqb2QQQRBNcHyQVxqkE6N3xK8UmeIbkvheRC3rRcP0=;
 b=I5ZKneKJE+pqsQxBv/ld6KDXJZGCweTXgMw4cm8ldzpdPfhULAvhiLfftYH1jCITmdNkusvJq/GsBwqdAEgzpBIk53ooa/eHCTthZr9E4eDd2uqS0+EcyDwVxcP6aWvmlrFHP1jsEgdoofapceRXhivgUf2lJopyxB72MBX6fEs=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ1PR10MB5931.namprd10.prod.outlook.com (2603:10b6:a03:48a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.19; Mon, 22 Aug
 2022 15:06:25 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3%5]) with mapi id 15.20.5546.023; Mon, 22 Aug 2022
 15:06:25 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v13 39/70] um: remove vma linked list walk
Thread-Topic: [PATCH v13 39/70] um: remove vma linked list walk
Thread-Index: AQHYtji/tVPsMgJFBEyolM/GuFFLzg==
Date:   Mon, 22 Aug 2022 15:06:24 +0000
Message-ID: <20220822150128.1562046-40-Liam.Howlett@oracle.com>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fa1152a8-a913-4a65-dcbc-08da844fe1e6
x-ms-traffictypediagnostic: SJ1PR10MB5931:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vRX65eBhQSaJDx6KuYuWQGHLP7p1ZJPrU16xkOtjB0nmOZaOxg+Q24Tq8LqtCjO4A62GIbUaxsXRxwlqtoQLn9w98gkOlSYheyZ4MUK7SrmuyAtszdDskxUC6Ct3goMizxrcawacT9jFVX8vb0N5N+kN6HbdLviFPFCy1h+9UkDrBZOPbfj5TBoMCbMwOiYe9A/F4fomeDBLYe/UbcHIegQcsOLkwlj+18V3JHKO4Y+q8VqPtyE8oy8SSGRmLAT0EVPTTZlPp4pfW27w/2eERFYQkE+5jX9HHTtFn3HL66/hU/thNtuZzSHMj6YYktbXiY0RAQOcaJWn7SYbgKoH5uH5PXtRdNTxZVh/aKQrzj4TravlAMgCSVpzy2WKd53V6MIA32hslGav6ngVVdAyHrYtlGVwRAj//e4Sct3z5HOCABKEiiaujAlCdBBcITuBjmXU8etUucbt6G1bzAV+QtTbbUdX4AAlsbmeGMVmiQ+bUvtLbWUtrC4KUkgEuldxKjeYRvfLkrrkhYQjjBZG1agTqeKcevHGizmbIPEHNEZ9uK3hmnjCqbih7Uy0SufqMkEqo5vYWlR2ZJsmOCQCW+GvtjfxIvxLLaBuN10ws5aAt22CVpiynVJFxeynFhLwPpMuc1K7z/nwle8PhVmmlsnMY5PR/RfKVb+O62ScR2TsZ2Tnnd8cCMtpf0Ut6zQncmt7Jrj9Zp8DnFn+U8C9C3+rLta6IdpUgUZMW/YkYKNdlG7CgweGC9XhwUDUQtTLHpcZaqQY54nPw7qSrHIqtQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(396003)(366004)(39860400002)(136003)(346002)(110136005)(83380400001)(6506007)(54906003)(6512007)(36756003)(6486002)(26005)(5660300002)(478600001)(41300700001)(107886003)(1076003)(186003)(66946007)(66556008)(66446008)(44832011)(4326008)(64756008)(86362001)(2906002)(8676002)(71200400001)(66476007)(38070700005)(2616005)(76116006)(122000001)(316002)(8936002)(91956017)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?mVTqB2o/Fz/TC5JtCLR3Cm+sHu9nYiyjzdDFwQDplA3yYWPLHF/3G93DYJ?=
 =?iso-8859-1?Q?A572FqDON2wfIxxUM4PjRVORXnQBBhWlmAWz/7xwBiKwA3kIC2UE/EyEaD?=
 =?iso-8859-1?Q?PPbRhcSTdmSNmb9icU1dvQj4D0Tu3Q7UwYYS3/eNjbzdPwsmwFcphfO/4T?=
 =?iso-8859-1?Q?b19yI7dzUvxMnSSRHuArpYgj/kDfbm+YQYRZWwcisywpc9tGYBuhtwJudA?=
 =?iso-8859-1?Q?TVyWvL5d/UgYCSPJl/i9L52DhqOnOc/SwdPy03OwpqyN+61OO2bPVefvyh?=
 =?iso-8859-1?Q?zvJhEwSwgfpsx515eMlhMJHxxxpyPPfLii9TbGGYWP6PU4PkISb+B02HkA?=
 =?iso-8859-1?Q?WW0Zd+H9iUj4strnWG9H4SAn1QRilW80GBRrVFx5U63tzOjlcy/co6K9eT?=
 =?iso-8859-1?Q?zMJtrWThE58iG3vttnEHNLpe7esjbbZoBhXS1nWj87AZhYh3jjCd3jUCOQ?=
 =?iso-8859-1?Q?5igqE+OQ7B6aaP6WEB/3BkBd8fLahrI/phmwkraMft/sw/1XjlCQ5aJpkS?=
 =?iso-8859-1?Q?PCJwsWJAhmFUafeuUXDZv9NilnjGMRylvH4A40opJM+eoC8FYxAiCR0s1j?=
 =?iso-8859-1?Q?yTOihXfnDdBRstHEvSJYjxhTNa2etT4gxwGTgAgf53UqtfrzzzPKQLwuwa?=
 =?iso-8859-1?Q?Y/XNgJ42nhrJEyyyBzOP3en0mEYOyfK9sMhgm4P6vdE5TSUm9CcPE26dHf?=
 =?iso-8859-1?Q?ZQIbyX9I6NXJaW9b0SeoisSS+TFweToPBGAhplsgPfCj2b9HIWW5TTX+kz?=
 =?iso-8859-1?Q?dfuDCiGh1Mi8laKn3Lb0NgUCQK8kUSWUnYOV+z9zS/uKcqyXFlekDutuw8?=
 =?iso-8859-1?Q?n1XWKdKwZ9kxHvKBZTEZF7cWRm5TcM2ooPLMPfLL3F6g3z5e4JPkkDzhjJ?=
 =?iso-8859-1?Q?BMKMg0jpO0XcnG7FRJzqzyIAjpP8SIbWbRx75XVtyJcJedH9zboRdZnvr+?=
 =?iso-8859-1?Q?/sb6wxAhqWD17w+nLgmAvzJBN3dzN1R/l2odj7fGl3MiWEWX1AfrCA167A?=
 =?iso-8859-1?Q?cduWznZzo9tT6gNt02KtkL6mcJQxksMrzg/zPJQXE0u8CDJpLtIvXRhWXf?=
 =?iso-8859-1?Q?EU3aOtBRIbKbK1N7CdIoQKdoOP+QAniP9h30+M+0SDzCLvr9doH3SfSIgm?=
 =?iso-8859-1?Q?wcxxA0huaVPF4UuIrRFlHsgtdIY4NNPFu1ZLrZtvZnD6dzblH+nR8Ti1BB?=
 =?iso-8859-1?Q?9b7kPUKD/lrfOJwUA/XVefInRi6MdVEPQEGKazRkUw+bi8TK+XhrJIWhz4?=
 =?iso-8859-1?Q?3mV2JnFZol3IlKNoBveOTRlfZvjy1TLKtCbpeotP62jVHUpILsQn4MMBEX?=
 =?iso-8859-1?Q?PA1gFMhnc3CvWmICq/JauZxeAa3deU8wAYQg6EsQ15ld8kEL1YCtktEY4a?=
 =?iso-8859-1?Q?KDQis8FpfLDYOkYTjafzJ2ThCnjvDmNltB4IAq4oTtdCcXDxsyOYVor9Gk?=
 =?iso-8859-1?Q?ZIu2LFTHHD+xsP92D0s17JfTzrnBI0BCASTixvD8jNfNxHAf4zLE3U0v9I?=
 =?iso-8859-1?Q?fwgl9Wd8F5QteuGrLEj9bKa3Dbdb2HLEvOYgRi/NJqF4zR2+nxcNNrkIQw?=
 =?iso-8859-1?Q?0QJCgrt8ZmaJ4EbqN1tUzaP2atJiFfNVom7AxmzKVGabV8uJ6VMpDQSKIG?=
 =?iso-8859-1?Q?ykCgR4uUkd6uPyGVUFOySUztpgGejLpdJ5/gdJv6VhIdthCdFOTD67rg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa1152a8-a913-4a65-dcbc-08da844fe1e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 15:06:24.9101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CokFvz4g2eRxKthyKWElzaNh3qPunvXPaFQ/33ucs/owAvi1RETk5wZCFIWQSvy1bI+ezIjnNx+QkTCcLIXVHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5931
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_09,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 adultscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208220065
X-Proofpoint-ORIG-GUID: 9ET0fjxrQEbJIdkGs9GV_7JrlyqUym5i
X-Proofpoint-GUID: 9ET0fjxrQEbJIdkGs9GV_7JrlyqUym5i
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

Use the VMA iterator instead.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 arch/um/kernel/tlb.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
index bc38f79ca3a3..ad449173a1a1 100644
--- a/arch/um/kernel/tlb.c
+++ b/arch/um/kernel/tlb.c
@@ -584,21 +584,19 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigne=
d long start,
=20
 void flush_tlb_mm(struct mm_struct *mm)
 {
-	struct vm_area_struct *vma =3D mm->mmap;
+	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
=20
-	while (vma !=3D NULL) {
+	for_each_vma(vmi, vma)
 		fix_range(mm, vma->vm_start, vma->vm_end, 0);
-		vma =3D vma->vm_next;
-	}
 }
=20
 void force_flush_all(void)
 {
 	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *vma =3D mm->mmap;
+	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
=20
-	while (vma !=3D NULL) {
+	for_each_vma(vmi, vma)
 		fix_range(mm, vma->vm_start, vma->vm_end, 1);
-		vma =3D vma->vm_next;
-	}
 }
--=20
2.35.1
