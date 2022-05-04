Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56BC7519339
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 03:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235501AbiEDBMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 21:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244933AbiEDBLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 21:11:54 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0A943AD3
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 18:08:06 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 243Kx7f7030616;
        Wed, 4 May 2022 01:07:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=r6e6s5WXr/0VM1cmsRGte4ANabZETQpkMzEiSA6pKX8=;
 b=BD0k0IwVydk/bgG6XQ8qbSMMejgX+FUhgWErRYIIc/o4ROeRxK/eHA8YVz7qw19kwFq6
 /CiuOnG60jq5yu3gOqUL6yUekgOH17Jen18iHqiQRA4y9nLEzVmNVm93Xo+8787ZdHJ1
 zMEtP6sFciqn8eyLwqF14Ops0Rd2/JnST5FCLOs0xngcyQTVoKXJv7E3huSpsJAlsITQ
 jaUhPClQ92Nrk3Nm6eqxadvcE1AUHtC63GH+9fJvVNkFq2VD4oNjNdpCAll00ADF9QOe
 m4kKg9Ua7/Kvm+b5Kcw3KvIOC+kGfvPX7T2et8hiqi19lWTCOUf/Gne5aBkJHiHow688 gQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruq0f5uj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:07:59 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24416SvN039119;
        Wed, 4 May 2022 01:07:58 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fruj2wdr3-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:07:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mCS9WsJIqlt4Td/wyytcYLXsjPd6Iu1UEYO10HcEfu2A+/aPSHjXmGgI6GvbYL9w+H5imjJB3gH54G866BvBkgH57yNitP3ZEYQgWLHUT/IkDol8vpveEEP8hGrtV1qW2vRZsiqfkO36dGUdUSa4qNbc4I/pdYo496T/CwnWqSoZNUCAS8CdCw7lCxv6qclkxDlh6M/TcLI1Slo4Y6EScpcWV4loRqjs6vGCoJeo6waEW36pSrTm90D/pFoNLegVz8BqQ57/hMn2fP0jU4i0Qmj+1mJu+j+uUYyfCemhfSmeou1f89equtKTYPp+tcH6wTBIbUUOG0KEYD3LiQDwWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r6e6s5WXr/0VM1cmsRGte4ANabZETQpkMzEiSA6pKX8=;
 b=ZYMSBYpI6SJraiCvZ92/z96BrzbmJPASEI7AhANgE6eSmPqeeUSl3RKhzcEmfDD2eo9l0IVJdNyTn6KQDfFT1IkjWXMW4Hv6qFBwqXKOp81Ah+pD/vzdFf2tSZ2iRDdaiwXCSBVP/XGttkKgl4k0I0vWByQ1P1Pq2LTY+jfmeu0ltyH4JIEdPrlVBzkXKUaaYLlomPM6QaWkwfkS1ZML1q5UqNnZMTRIxnvRWu7iz7oCrCz4hELesguaHjUIjnFfxtIk0ZexvXIrInW7E3M7EvoSVhISMkhQa8x0SxV1GKTl0JvATKy35W2NHlMHNiVhy8I0N2mL9+mtSBXXYZ8o2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r6e6s5WXr/0VM1cmsRGte4ANabZETQpkMzEiSA6pKX8=;
 b=unLlcDrqUI5EJ8/SXcRzFzSBZrRUBU1pDqLVIJEZHZxSq5MfXcpISwc+IKRGoRdjZjJpfwKsGz0Dm6nRfRC+iWplBSvwViNzZv3neZhV0nfLHUEQeJnyQhdx0UDu3ljIxBI+rUcThorvs64XV8foXJ/8jGb5xpEWMg5B0Ep6OXU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH2PR10MB4214.namprd10.prod.outlook.com (2603:10b6:610:a6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Wed, 4 May
 2022 01:07:55 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5206.024; Wed, 4 May 2022
 01:07:55 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v9 13/69] mm/mmap: use maple tree for unmapped_area{_topdown}
Thread-Topic: [PATCH v9 13/69] mm/mmap: use maple tree for
 unmapped_area{_topdown}
Thread-Index: AQHYX1NiIkHH2uSNo0eVjc5j+stS2A==
Date:   Wed, 4 May 2022 01:07:53 +0000
Message-ID: <20220504010716.661115-15-Liam.Howlett@oracle.com>
References: <20220504010716.661115-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220504010716.661115-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 25fb8398-5ccb-4bcf-376f-08da2d6a85a1
x-ms-traffictypediagnostic: CH2PR10MB4214:EE_
x-microsoft-antispam-prvs: <CH2PR10MB42143586493739B4FF449ED3FDC39@CH2PR10MB4214.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rv55x2oLp1cYYLGlViBur6SCalfDCDyexa082INlNAWwBGoAJKFU0X5jsWU12KWXYGBWw1AOqXFbSD4HvTcjfBrM21CWPd3ncVOhVZxjLFvNMvLBkuFpvntWjVR+Nkw6McN2Z4c+fUSaCL/2NXphl/20iEglKiOSzBugumqTSW34mL7YVF3w7HUVx28tQTZKcGOUjNYiEE9fr+/BLEpwHropo5hxAfdvv7UOqJy0Cxs5uSD8Je8FjfRMv5FfAudmhlHfTHC47G7p10C5O/FLa5A/b4GkkiCW2j9Df3puyku+omP9cCHenVUN4w8zeZ1kd9E/XiiCyburLjHqmuAsc1otHJlj4MA4lkk70RjHs7yI9AgUcKNyQZhfXk09O986epfu8nQDM2p+wvryF2ezARIbuoFETyOskibyeydwTz+tdiXee/nBf8JeidxaPutAlWkYwXwI/y9Ghl6aK9QjGqITyfclwl48w+SJw9IXd3whXRXd6YktydcqwbUIJ6fVx7m7QAmXbhFR6LqZdEwm0qlZAhpto2OUzkgp0PmHdigtFHoC2YHilzDiET7EDtu2aiwQVzuwQNBFPph9sX7irb4Mq06K9OrYr7IiBRcjJ3QWlHooCHYS8o8NAQ9SgTz4RUr0tWg+COwRf/UEapQFaHhtmibUztQCzQaBuKekfQPwWgyWDyj/756xmOqaE0Zbsu3IESV3y9raj9PavCE18Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66446008)(64756008)(66946007)(66556008)(66476007)(8676002)(76116006)(83380400001)(2616005)(110136005)(186003)(1076003)(316002)(6512007)(86362001)(26005)(2906002)(6506007)(71200400001)(36756003)(5660300002)(44832011)(38100700002)(508600001)(8936002)(38070700005)(122000001)(6486002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ff7/Ewe55bcJPdO5ZwoX7xXfDLeObX6MR19Rp3cQPx0VUU2alE+bXyioV4?=
 =?iso-8859-1?Q?h9QgT2WuoohtXXxl0UNZKlEsyTXruO6li+BTSdD7wavK+AR9v+so94Nnuo?=
 =?iso-8859-1?Q?NJjc0GoJWGt8V2FyWvykm1ZbPH/EidVhoCltA4RrFcHhpwoKTBZc/dHfCb?=
 =?iso-8859-1?Q?We/WdL0/aWzcWHN3vHhm4OpH/6SnO6Kzw2rz3XbggGEgTTsTdqdx2D12HA?=
 =?iso-8859-1?Q?61VNbjgL5vwM2svG5CV/nw5YoEtRpoZYccQocSfYz0J8XBOclN4OGroCGR?=
 =?iso-8859-1?Q?JI25uZp8d7HD9+yI20p0JnDqP+1bfT9AVTOPkK1K9R6XgasePbjwgAIHit?=
 =?iso-8859-1?Q?P8TFMBuvA4OqYlm6xaQoh9YiMnVojZ8UjWVq6oaUrSuHR0jAmFIhPpauVV?=
 =?iso-8859-1?Q?LCIlTWtWrouiadU/IlNbqzm24Y+WQWviuUNAkClRa1ngjz3PyEHFgRyWI4?=
 =?iso-8859-1?Q?qn4tL5dTUEgOthabCHavPXDhc9+aFJLIFgWXoxY+CgQUy2KiZVQc0pF86H?=
 =?iso-8859-1?Q?Ls7OL1xqTUmRyjtHUlpatJwtfWG5RE1LY4OH6DzggU5d9/TFLSl5DIzWXY?=
 =?iso-8859-1?Q?nYncFX4psvSvN6AvFgPpGV6vesCvzd3z/i1fv8XXuMzoA6ub2uK6dIM2lo?=
 =?iso-8859-1?Q?rPQeApeU2tZ1bKXuTSWaNNSuxXV2vWOdggeD0aQebY0ZxxwjrMK9ouyjfn?=
 =?iso-8859-1?Q?plCA+wCBt1bta3y4gkCtNq4CGROrE4sXV+q8ooLYhb7iUo/oEzPT2pPrUD?=
 =?iso-8859-1?Q?O7Qx2cCUAfiqvgNenJspav6EuwcUFYahsTgWNN1C/bssNjEbyjMSiB5sX2?=
 =?iso-8859-1?Q?8rxDhfnEEr3iMn7qBA333RaLvHneaOPH6jOiiXB+hGd1zjI5Y0Y6JSfghy?=
 =?iso-8859-1?Q?ETqyw8CVuJKyTufrgy34PqHKtKaA7iRKP1e4IG1O7RRI/TtYcwprTOG7lg?=
 =?iso-8859-1?Q?/ek80gzzUsaBREKQVVRlzVSUFDdCgTGP9vlgqUaIs9eEWgve0JF6vpwwV8?=
 =?iso-8859-1?Q?uAMLLynMySL1NL4B0F4jmWFdRAZ6MYcfoUIr7hhtaNd6mbtYwZ04Im6ZU5?=
 =?iso-8859-1?Q?GUwku1I8gAjV3GvzNHhb5H++PURJIeZBEcXvh3TOD4rMzopS4X+Xwek4Go?=
 =?iso-8859-1?Q?k7GU0A01AAaBlgrbGxYJKAhSIegTULPZbb1epDM0sYBiRHe09+G26LqN2k?=
 =?iso-8859-1?Q?/y7OOz1IEen+kTmKdH3VuaV+QqSDzdhXxB3ZMRn0hr4gN3oi7QmeT7oFyB?=
 =?iso-8859-1?Q?47sdShloroVvLpK1NR5Ar7hcvuCTmO4gNKinoxV4w8LzqRufx9zG5Nnt95?=
 =?iso-8859-1?Q?NdcuF8+zh4dQLSjHXRRNki+CwtrA868qHWfw+MDTB3rdBMYbFyLpfxOyMA?=
 =?iso-8859-1?Q?9QjJqLe3QFWXqyAho+izItGkcBiVHI6UtWQ3wiDgXSABrjTcKE5TSi7kS9?=
 =?iso-8859-1?Q?aAtgGKQom782Bnd+MACh2JSCvERMY+xxtxM0M3uY4jFQcW34B42YnD6Py/?=
 =?iso-8859-1?Q?UwLiRhAyU5GbmlcA7azwZl/RSjbQZxu7w1EgCRej52hynkpTk2U3TmY07j?=
 =?iso-8859-1?Q?VjlLXXzrOrxe0xzSzPV2u/C78SiBztnq1ZtMGqGFQbRrLG3FWn+FoS+9Vm?=
 =?iso-8859-1?Q?lcRDqPupoiV1VWA5GS9/vUjNYWR+vo4jSJ/FpjCuF6oOlfSbtcvkAUAZJh?=
 =?iso-8859-1?Q?Y2vKDBndD9yehWWCOvjd0fraBel+VHUnAlZtXocvuY/WHBKNwpNLhT26LM?=
 =?iso-8859-1?Q?qh7hqZsfcGXxgNtjTOzTDC8mpJqXFhKfvRbHQ9c8VfmIZSSH6yTrKy8cON?=
 =?iso-8859-1?Q?qCrfXnjOeTcUmieSKUag8tPYHoCqJE0=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25fb8398-5ccb-4bcf-376f-08da2d6a85a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 01:07:54.0409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qY+J9tyD6iCb6z9wp6ocEM/DeSiynePHSwvhwbqzDXtui4uzuT49q2IoF6MnNyuW/X+uqcgMrEo1+XPPCGShGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4214
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-03_10:2022-05-02,2022-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 mlxscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205040005
X-Proofpoint-ORIG-GUID: XfrCLsIS3H-naSKtQmN4ZplzSl2cVqPt
X-Proofpoint-GUID: XfrCLsIS3H-naSKtQmN4ZplzSl2cVqPt
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

The maple tree code was added to find the unmapped area in a previous
commit and was checked against what the rbtree returned, but the actual
result was never used.  Start using the maple tree implementation and
remove the rbtree code.

Add kernel documentation comment for these functions.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 253 +++++++-----------------------------------------------
 1 file changed, 32 insertions(+), 221 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 7ab07c67da71..ecdedf5191c0 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2047,250 +2047,61 @@ unsigned long mmap_region(struct file *file, unsig=
ned long addr,
 	return error;
 }
=20
+/* unmapped_area() Find an area between the low_limit and the high_limit w=
ith
+ * the correct alignment and offset, all from @info. Note: current->mm is =
used
+ * for the search.
+ *
+ * @info: The unmapped area information including the range (low_limit -
+ * hight_limit), the alignment offset and mask.
+ *
+ * Return: A memory address or -ENOMEM.
+ */
 static unsigned long unmapped_area(struct vm_unmapped_area_info *info)
 {
-	/*
-	 * We implement the search by looking for an rbtree node that
-	 * immediately follows a suitable gap. That is,
-	 * - gap_start =3D vma->vm_prev->vm_end <=3D info->high_limit - length;
-	 * - gap_end   =3D vma->vm_start        >=3D info->low_limit  + length;
-	 * - gap_end - gap_start >=3D length
-	 */
+	unsigned long length, gap;
=20
-	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *vma;
-	unsigned long length, low_limit, high_limit, gap_start, gap_end;
-	unsigned long gap;
-	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	MA_STATE(mas, &current->mm->mm_mt, 0, 0);
=20
 	/* Adjust search length to account for worst case alignment overhead */
 	length =3D info->length + info->align_mask;
 	if (length < info->length)
 		return -ENOMEM;
=20
-	mas_empty_area(&mas, info->low_limit, info->high_limit - 1,
-			   length);
-	gap =3D mas.index;
-	gap +=3D (info->align_offset - gap) & info->align_mask;
-
-	/* Adjust search limits by the desired length */
-	if (info->high_limit < length)
-		return -ENOMEM;
-	high_limit =3D info->high_limit - length;
-
-	if (info->low_limit > high_limit)
-		return -ENOMEM;
-	low_limit =3D info->low_limit + length;
-
-	/* Check if rbtree root looks promising */
-	if (RB_EMPTY_ROOT(&mm->mm_rb))
-		goto check_highest;
-	vma =3D rb_entry(mm->mm_rb.rb_node, struct vm_area_struct, vm_rb);
-	if (vma->rb_subtree_gap < length)
-		goto check_highest;
-
-	while (true) {
-		/* Visit left subtree if it looks promising */
-		gap_end =3D vm_start_gap(vma);
-		if (gap_end >=3D low_limit && vma->vm_rb.rb_left) {
-			struct vm_area_struct *left =3D
-				rb_entry(vma->vm_rb.rb_left,
-					 struct vm_area_struct, vm_rb);
-			if (left->rb_subtree_gap >=3D length) {
-				vma =3D left;
-				continue;
-			}
-		}
-
-		gap_start =3D vma->vm_prev ? vm_end_gap(vma->vm_prev) : 0;
-check_current:
-		/* Check if current node has a suitable gap */
-		if (gap_start > high_limit)
-			return -ENOMEM;
-		if (gap_end >=3D low_limit &&
-		    gap_end > gap_start && gap_end - gap_start >=3D length)
-			goto found;
-
-		/* Visit right subtree if it looks promising */
-		if (vma->vm_rb.rb_right) {
-			struct vm_area_struct *right =3D
-				rb_entry(vma->vm_rb.rb_right,
-					 struct vm_area_struct, vm_rb);
-			if (right->rb_subtree_gap >=3D length) {
-				vma =3D right;
-				continue;
-			}
-		}
-
-		/* Go back up the rbtree to find next candidate node */
-		while (true) {
-			struct rb_node *prev =3D &vma->vm_rb;
-			if (!rb_parent(prev))
-				goto check_highest;
-			vma =3D rb_entry(rb_parent(prev),
-				       struct vm_area_struct, vm_rb);
-			if (prev =3D=3D vma->vm_rb.rb_left) {
-				gap_start =3D vm_end_gap(vma->vm_prev);
-				gap_end =3D vm_start_gap(vma);
-				goto check_current;
-			}
-		}
-	}
-
-check_highest:
-	/* Check highest gap, which does not precede any rbtree node */
-	gap_start =3D mm->highest_vm_end;
-	gap_end =3D ULONG_MAX;  /* Only for VM_BUG_ON below */
-	if (gap_start > high_limit)
+	if (mas_empty_area(&mas, info->low_limit, info->high_limit - 1,
+				  length))
 		return -ENOMEM;
=20
-found:
-	/* We found a suitable gap. Clip it with the original low_limit. */
-	if (gap_start < info->low_limit)
-		gap_start =3D info->low_limit;
-
-	/* Adjust gap address to the desired alignment */
-	gap_start +=3D (info->align_offset - gap_start) & info->align_mask;
-
-	VM_BUG_ON(gap_start + info->length > info->high_limit);
-	VM_BUG_ON(gap_start + info->length > gap_end);
-
-	VM_BUG_ON(gap !=3D gap_start);
-	return gap_start;
+	gap =3D mas.index;
+	gap +=3D (info->align_offset - gap) & info->align_mask;
+	return gap;
 }
=20
+/* unmapped_area_topdown() Find an area between the low_limit and the
+ * high_limit with * the correct alignment and offset at the highest avail=
able
+ * address, all from * @info. Note: current->mm is used for the search.
+ *
+ * @info: The unmapped area information including the range (low_limit -
+ * hight_limit), the alignment offset and mask.
+ *
+ * Return: A memory address or -ENOMEM.
+ */
 static unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *i=
nfo)
 {
-	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *vma =3D NULL;
-	unsigned long length, low_limit, high_limit, gap_start, gap_end;
-	unsigned long gap;
-
-	MA_STATE(mas, &mm->mm_mt, 0, 0);
-	validate_mm_mt(mm);
+	unsigned long length, gap;
=20
+	MA_STATE(mas, &current->mm->mm_mt, 0, 0);
 	/* Adjust search length to account for worst case alignment overhead */
 	length =3D info->length + info->align_mask;
 	if (length < info->length)
 		return -ENOMEM;
=20
-	mas_empty_area_rev(&mas, info->low_limit, info->high_limit - 1,
-		   length);
-	gap =3D mas.last + 1 - info->length;
-	gap -=3D (gap - info->align_offset) & info->align_mask;
-
-	/*
-	 * Adjust search limits by the desired length.
-	 * See implementation comment at top of unmapped_area().
-	 */
-	gap_end =3D info->high_limit;
-	if (gap_end < length)
-		return -ENOMEM;
-	high_limit =3D gap_end - length;
-
-	if (info->low_limit > high_limit)
+	if (mas_empty_area_rev(&mas, info->low_limit, info->high_limit - 1,
+				length))
 		return -ENOMEM;
-	low_limit =3D info->low_limit + length;
-
-	/* Check highest gap, which does not precede any rbtree node */
-	gap_start =3D mm->highest_vm_end;
-	if (gap_start <=3D high_limit)
-		goto found_highest;
-
-	/* Check if rbtree root looks promising */
-	if (RB_EMPTY_ROOT(&mm->mm_rb))
-		return -ENOMEM;
-	vma =3D rb_entry(mm->mm_rb.rb_node, struct vm_area_struct, vm_rb);
-	if (vma->rb_subtree_gap < length)
-		return -ENOMEM;
-
-	while (true) {
-		/* Visit right subtree if it looks promising */
-		gap_start =3D vma->vm_prev ? vm_end_gap(vma->vm_prev) : 0;
-		if (gap_start <=3D high_limit && vma->vm_rb.rb_right) {
-			struct vm_area_struct *right =3D
-				rb_entry(vma->vm_rb.rb_right,
-					 struct vm_area_struct, vm_rb);
-			if (right->rb_subtree_gap >=3D length) {
-				vma =3D right;
-				continue;
-			}
-		}
-
-check_current:
-		/* Check if current node has a suitable gap */
-		gap_end =3D vm_start_gap(vma);
-		if (gap_end < low_limit)
-			return -ENOMEM;
-		if (gap_start <=3D high_limit &&
-		    gap_end > gap_start && gap_end - gap_start >=3D length)
-			goto found;
-
-		/* Visit left subtree if it looks promising */
-		if (vma->vm_rb.rb_left) {
-			struct vm_area_struct *left =3D
-				rb_entry(vma->vm_rb.rb_left,
-					 struct vm_area_struct, vm_rb);
-			if (left->rb_subtree_gap >=3D length) {
-				vma =3D left;
-				continue;
-			}
-		}
-
-		/* Go back up the rbtree to find next candidate node */
-		while (true) {
-			struct rb_node *prev =3D &vma->vm_rb;
-			if (!rb_parent(prev))
-				return -ENOMEM;
-			vma =3D rb_entry(rb_parent(prev),
-				       struct vm_area_struct, vm_rb);
-			if (prev =3D=3D vma->vm_rb.rb_right) {
-				gap_start =3D vma->vm_prev ?
-					vm_end_gap(vma->vm_prev) : 0;
-				goto check_current;
-			}
-		}
-	}
-
-found:
-	/* We found a suitable gap. Clip it with the original high_limit. */
-	if (gap_end > info->high_limit)
-		gap_end =3D info->high_limit;
-
-found_highest:
-	/* Compute highest gap address at the desired alignment */
-	gap_end -=3D info->length;
-	gap_end -=3D (gap_end - info->align_offset) & info->align_mask;
-
-	VM_BUG_ON(gap_end < info->low_limit);
-	VM_BUG_ON(gap_end < gap_start);
-
-	if (gap !=3D gap_end) {
-		pr_err("%s: %px Gap was found: mt %lu gap_end %lu\n", __func__,
-		       mm, gap, gap_end);
-		pr_err("window was %lu - %lu size %lu\n", info->high_limit,
-		       info->low_limit, length);
-		pr_err("mas.min %lu max %lu mas.last %lu\n", mas.min, mas.max,
-		       mas.last);
-		pr_err("mas.index %lu align mask %lu offset %lu\n", mas.index,
-		       info->align_mask, info->align_offset);
-		pr_err("rb_find_vma find on %lu =3D> %px (%px)\n", mas.index,
-		       find_vma(mm, mas.index), vma);
-#if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
-		mt_dump(&mm->mm_mt);
-#endif
-		{
-			struct vm_area_struct *dv =3D mm->mmap;
=20
-			while (dv) {
-				printk("vma %px %lu-%lu\n", dv, dv->vm_start, dv->vm_end);
-				dv =3D dv->vm_next;
-			}
-		}
-		VM_BUG_ON(gap !=3D gap_end);
-	}
-
-	return gap_end;
+	gap =3D mas.last + 1 - info->length;
+	gap -=3D (gap - info->align_offset) & info->align_mask;
+	return gap;
 }
=20
 /*
--=20
2.35.1
