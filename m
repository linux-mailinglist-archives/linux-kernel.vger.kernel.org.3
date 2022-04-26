Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D24C51019D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241982AbiDZPPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351944AbiDZPLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:11:50 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8869415B955
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:08:13 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QDT2Pi015535;
        Tue, 26 Apr 2022 15:08:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Er0yPeVRdxb2gthVYE47IyHEi6JcGaaDNNd7OleHxwc=;
 b=yeH7FHaAdDoMOwZvKgw87L1TmoXWoMTyC0+e4r0Kk9GsVoTsUgv2vc61mzDZvC6kA5j0
 42sE+Fh5hM15pBaLtskMRFNVWYwT1+zWraAG5TK0mRVRQoWVx150Vt8I7BIhPkDTeqgR
 wjxaWRsPyOwwSSFzng0ReyMmgVWub6VP5/Cu7F8HYnTGORIh3Row+h/hMhx1V/QEphKE
 aMQFc2DH/x0WhB/G1ASkVAN6zUG400EOQttudmfxQBc7eofk+VPT2jsvKebtp3qSKuK5
 hw9K2wRLNGl9KShZikd0Oo+fqvlAIbTtWHpl/D523neUeSpYDrhsnJvY6dCDb8WSK0u2 1w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb9apbtm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:08:07 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23QF64Ii012558;
        Tue, 26 Apr 2022 15:08:06 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2046.outbound.protection.outlook.com [104.47.73.46])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w3gsed-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:08:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dBRiizi4oUVZBM5lVwfs3UzmkI+M9QRUt1mH2wEr88u8o4Wy++hfrWnE5MSPwKuw6r0xjLp1E0NbHnYSbUCyjvFTOEwfwOF18SeJvw6jj8nr9P0EjL3NsljM4NMuis9RCKL7x4Y8Uxm5eQfwIPyR7czWQCpe1y00aIutzn3KkMPUNz9kb6QwGqSMc36mL3H1chbJ35uHOgr+rSSphUxEEqWwKhb0n4wT2Ecg8yYwayiRqbW7IPaJvJxvpc5dT7UMgnyxUbyXhABFQJA+oVgd5A+YtlE1DqfA9nfQzStrAgJ2oAQ+t0jkM7cAIXIYfDBDZAjpFpJNhfni3oE5KxOKAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Er0yPeVRdxb2gthVYE47IyHEi6JcGaaDNNd7OleHxwc=;
 b=Z8PryBhh1aAxNR7iPACirZwkQlpztDJn87hU+S1kZpWUX6e03Y2nw0r0ePDKWQj2F1PBvu/gk7cSuMP/aATAE4OnINELLiL69PxYTXDzGaCtZ00zsjW2bl6bA2ODIqd+j0L7Eqc1M9+xZmCKdkcQkIiUt6sKWa7fx6GSfzrrivJEoYrFynoEX9nOTna3VkfF624N1u5g0dCASEVb3BkRcxRwhbjWf26geXV/c4PQHqGt+7LhH59Wk7taZe64PlLuNXnkKM+GwH8XZPGMkdNajlUJJLYY59heHuA1uP3ycdt9fd2ISPDlADFIc7Z+HIubvkCgK3UOzBTnqeEuo4R3kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Er0yPeVRdxb2gthVYE47IyHEi6JcGaaDNNd7OleHxwc=;
 b=y1syYsQiwazwxlPOBrpzYXvJF+oGgZgxdWN+2M09OeaPQlDyinKWogoqLbcyDGY9HPj5jxiaqXFGxpNl+WIzYA6XHaZ0/NJbgy1u9JZFBxCBMZdC+VfEBB2jmsN7gpnytgm+ONTXnhDMvKuuLdA1P+9sQpT5fSV3molov3qwYyg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS7PR10MB4925.namprd10.prod.outlook.com (2603:10b6:5:297::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Tue, 26 Apr
 2022 15:08:04 +0000
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
Subject: [PATCH v8 60/70] mm/mremap: use vma_find_intersection() instead of
 vma linked list
Thread-Topic: [PATCH v8 60/70] mm/mremap: use vma_find_intersection() instead
 of vma linked list
Thread-Index: AQHYWX9BPU4jlYRqzkaS2+VNV7TuxA==
Date:   Tue, 26 Apr 2022 15:06:50 +0000
Message-ID: <20220426150616.3937571-61-Liam.Howlett@oracle.com>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 24fefddf-efe3-4cb5-27c2-08da27969044
x-ms-traffictypediagnostic: DS7PR10MB4925:EE_
x-microsoft-antispam-prvs: <DS7PR10MB4925F86B892560160C850675FDFB9@DS7PR10MB4925.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PhpBmlio2Ngvu22/z7ESuk+c4yh9RUmNbGkwiHpBV2zEgfxwX8R6zu/wPbGA5lXTSQ2757RfsjFTOE8QGKjiK7KUgULB0YORGEgxQLTNgylamXof8G7vik+fAv3El75txkmGldcoeBrpLF3KrruR6CICFxUrKwYdLTrZfVsY6CYxaunjxMCPNQplbjXpVyXagk+vXVu3262IDQbigx8cGOKwcet++Tn3ATs9qt4ufGTBF4gw5f5FqWY/OWADDKzf5Y9kOmhqP2LcSV4DRsVOf98vZIM6M+xhsPC0NB+Afw9QLdh8QizAum7x2B7JRJLay561/Ubcf5TgWsA6uZ1OKca68ux7JB4gawcqV4BwvKxyY08H4v17BiUHIJnZT9N5xFMJxCkTidXUtqmMOw38jQFuJgPzeudWOCRl5sOltfdOU/0RWxtWg2HdUmnuiINHHaNFDq1S1XDUC2kLI19bkCGBW5OsqyGJHHy1MqoiHjO45tTU7pNYjqzbaW1iA1pxOY62ggHjoSgCxj6S1A8q1320XBUMLXK42Za9JuI1S7VgCETZ5NVBNMV+HtRA/+g8ZlvQ2b7WHW/lm9cGTXHSFer+Kl4sn+0XB5WFnRgrmSLadCg3AwlpfLamcwPG39BBsj0YfEJxFuFc3kNLvFfX2RHsSR65Q035D5QuXlJKpkjM7D1g8zHTasp6ca2Uq27yO6pHfI72B8znm/RK7PI8KQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(6486002)(316002)(66556008)(508600001)(38070700005)(86362001)(8676002)(2616005)(6512007)(110136005)(71200400001)(76116006)(91956017)(66946007)(122000001)(6666004)(26005)(5660300002)(8936002)(6506007)(36756003)(83380400001)(1076003)(2906002)(44832011)(186003)(66446008)(66476007)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?o58ywoDWPn9+N6d07EmAY0/INfABMmIq+sxh8UtpBDl9JFuAltnjjruX55?=
 =?iso-8859-1?Q?kcluuguJ/SYWi9SH+Hx/uznjwMeDIJYrWDQSknpVSbVQd1WpbrZ4h0ZHVM?=
 =?iso-8859-1?Q?4wWf/+M1uzTcvsAGDtwVJ7zPC+quU389zxvGwPgskZMPMbc2Osap76gZ8X?=
 =?iso-8859-1?Q?tqrwSIZ0rRDQSIoHbYlyFbdA8TouaaEemjm0VkeNxvG80BaHPsVy23ybVa?=
 =?iso-8859-1?Q?mDRn0nUArEuQhh2NX/L82gq79QBuWW2/QuXroObeUAW6OjK9aaaqxTK1w+?=
 =?iso-8859-1?Q?Ai26rEA1JP2j8ttnTup9s/9ebmKIJjDANNQupuonEl/vwo+foKGd4q/KZH?=
 =?iso-8859-1?Q?tD6b9sOLRepxdgFhH6yWO6LrvpuYA/D7KgTh/yH5JSROOyTv2/+DTX2gl5?=
 =?iso-8859-1?Q?Q4hYzRKjGY92CbAbJdn/yT8Fi6X5ukAmIgTMuubxzuVM45iC4Ofr1OJOv/?=
 =?iso-8859-1?Q?tr68KT3DkCr52m7LrJxNiaq3bCRrs3UNqHEpXNZRlzgg5bdgTrcxjjQbZS?=
 =?iso-8859-1?Q?jOElixoCqKhOn0MYxqiyEu2ejbN3dyrQPu2cvrTHrDm8Rh0ZsG7cx60A7c?=
 =?iso-8859-1?Q?xVS37apFEHYl4TWQgofdUHt5Kc5tahEi6lyq/by7GHt4Qoyj6mrx+CfMqw?=
 =?iso-8859-1?Q?yHw4p4OFej7jM9P9b98eVlvAg+ldU/nK8IEbD58eEHdpAX6rSqxtoSC9fC?=
 =?iso-8859-1?Q?LA4gLsip6QnwKajAXJYNebIBsoJxXWNdXBO6XFsye0WFavVS9c9/XNjGR6?=
 =?iso-8859-1?Q?Zwd6+cOcC9N2FxGyWGTE8WjVvNd5FYYmc8xp3zZolyfminNIWpBZQ5UnI+?=
 =?iso-8859-1?Q?+qcZ2Q2crQIOVQWS9CcPeop0vavmu3iHrp9xACUbgkia7BhzhG2gqzT8bk?=
 =?iso-8859-1?Q?J6WRxcr+XcNhOopJWHTFk0p4h7jEM9fPyWp6ZIZbzic3fL6bTgUBYL7Qht?=
 =?iso-8859-1?Q?4H1WLRosSh21iXUvG2bwVO1ngSCRa4o/kWxnICCV5BGMyWLCEZNl2GwYVr?=
 =?iso-8859-1?Q?wb7azlkQn4LQWFwJ4guoVRM9nghXA1LQnlhVkZTQ3Fxjaa19otfT7/NSqf?=
 =?iso-8859-1?Q?A7pas/MA1/ZKrHA/YGXOlhO2ZLH338ot2nB3Gus2BAtBL8vIiLTPOX4czD?=
 =?iso-8859-1?Q?ZrDYueyhPitkWTyXsPloAIFAP2OqjaIB41VzNPTp5AFohkFRQUOveCfWPM?=
 =?iso-8859-1?Q?cTZr24sQu3jFkBMi4bSxVaRMDiG2B6cEH9q33jNPZhG6EfnvC3Kp3aNNGA?=
 =?iso-8859-1?Q?NJLrbtJlyNHvOtqC6qT5JEUyCGAM2qaalUrhGfNiOnN629w1KdOWjij5Kk?=
 =?iso-8859-1?Q?1Ux1sFCxzvG73eRDQeOSHvVTgwIVs5xWAnoW2/ep0pYZ32ZPS+1sRpPnvi?=
 =?iso-8859-1?Q?podIyy11VBi6jxTtmBXUF3E7Cs8EcZL2OKZ/QTCgWi7SqCn52h2Wn3lzsv?=
 =?iso-8859-1?Q?V690PnZliml72GYo+9ngQb3IeJ6eFAZ98ZRG5UnPCQsS8+L4LbtWWttnXw?=
 =?iso-8859-1?Q?zGEPv8fGr5fUVxTHhYxWP6llAS9+z52K88ZSZBPbwD3M5Aw/3eulVq2ptd?=
 =?iso-8859-1?Q?zH9qC8dmfQATNspVZBq6rT6+XI5Fqp3UtAeftqFdkZTWd2shWyu4hFO1T3?=
 =?iso-8859-1?Q?4Np335iWa4ZZ0uCx1qXy3YH6mMv+SfE4LaI7acl+gmyDZB6n7QPEtfrRbx?=
 =?iso-8859-1?Q?ylskrv6T4CvjM5dF1wsCwD4lhlW53y0a7c6GUcZc7gPcSoEG2PA7ccNmk7?=
 =?iso-8859-1?Q?V6ZdLWeVbF4EJJIva/yyp1pc4u9PzaJup1hL8FZn3wbDCfzdAm1oebN9/E?=
 =?iso-8859-1?Q?fJnIX5Zo3NDfA/LH/dSKxOMDJyOwIlU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24fefddf-efe3-4cb5-27c2-08da27969044
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 15:06:50.3485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 80kTe78cEivGhuCtMEQQzSwAeuoHjJgwe78CXVyKboyTfGGoaQ9XiJMuSW5tGryCUpizTrLOCxRE4Ro6VNKQsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4925
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-26_04:2022-04-26,2022-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204260096
X-Proofpoint-ORIG-GUID: ibbe69ZBafH85dm0h_D3RgV2ZChwkEfx
X-Proofpoint-GUID: ibbe69ZBafH85dm0h_D3RgV2ZChwkEfx
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
 mm/mremap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 4495f69eccbe..c0d32330d435 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -716,7 +716,7 @@ static unsigned long move_vma(struct vm_area_struct *vm=
a,
 	if (excess) {
 		vma->vm_flags |=3D VM_ACCOUNT;
 		if (split)
-			vma->vm_next->vm_flags |=3D VM_ACCOUNT;
+			find_vma(mm, vma->vm_end)->vm_flags |=3D VM_ACCOUNT;
 	}
=20
 	return new_addr;
@@ -866,9 +866,10 @@ static unsigned long mremap_to(unsigned long addr, uns=
igned long old_len,
 static int vma_expandable(struct vm_area_struct *vma, unsigned long delta)
 {
 	unsigned long end =3D vma->vm_end + delta;
+
 	if (end < vma->vm_end) /* overflow */
 		return 0;
-	if (vma->vm_next && vma->vm_next->vm_start < end) /* intersection */
+	if (find_vma_intersection(vma->vm_mm, vma->vm_end, end))
 		return 0;
 	if (get_unmapped_area(NULL, vma->vm_start, end - vma->vm_start,
 			      0, MAP_FIXED) & ~PAGE_MASK)
--=20
2.35.1
