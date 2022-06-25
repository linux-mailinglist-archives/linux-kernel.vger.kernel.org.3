Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F2C55A595
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 02:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbiFYAjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 20:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbiFYAjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 20:39:16 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16CE77043
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 17:39:15 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25ONIpYT025463;
        Sat, 25 Jun 2022 00:39:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=7zoBdZXuH2o3ycCQyJIs3bANs0z3tHUpTJqyjqoEwfs=;
 b=nwwNpWF5Eauvi5QDxb94o4/dGciXvnU+gKmjG5cYvwhyyac77ABOsBLEscoCvuNtOauH
 tpFJzKDhZFcQI5rnKsfNVg3almeHVnSC6k1he5jia7PbOytMq4jfoT+fMRR6QGy9jeEA
 Ff7NRXVQodelPtwjfj0ld8IGeRMkd6NgKJ33123ORbqLEzAiMDOFGpHKWJoCCwupsw/1
 0d4jw4SMaGoWssy1UtybyNVIqCj8MdqRNbHc0u7mDLTMlfa4r5Feot4E3zplwvy0OPEi
 ZVCJN37s6nrZ0lTyXY7B13uMV0SPIFLGDI2i4tW1VbVc1BT0IoA+y8vW36KyRwPK7N/j KQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs54cxtyf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 25 Jun 2022 00:39:09 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25P0a8O4008165;
        Sat, 25 Jun 2022 00:39:09 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gtkfxy1py-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 25 Jun 2022 00:39:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TXGAAlF/FjPUEGx0MSWYQ3KqJrlxw3h+rBsAgUMQmWkSS1EEh2D+I150N1bgKkmJxrsh530Orosi7rY4xT9kdMZpTww7ul/kew/oBmm4B4pVt/2p5uvV/O1Kf36osnlKIfTWOoYfDX95fpQA4rSDZWFVzqvbNo65cGwb2gr0jjBqRPJ8/7RrLk4kNK/i0Q64s/hH+sjE3dUy7XA2AJfZtIYV+GFHCCg0N3CV18tv0JSD3FcM8fN0Gacu3xxGC/X2oVPShj+pnLtHkepk27V+pe7LUripX1X3fDNnAg7ehsnI9lXF+PbU1mM7Kbz93jAQmxF8Iq/OrY71ho7WtncQNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7zoBdZXuH2o3ycCQyJIs3bANs0z3tHUpTJqyjqoEwfs=;
 b=by1SyPoGqf/fiYS/HHDy1TByHMmlZlImIpXA32LWh1PqaF8ZMJ38DF/9jHU3GQ+ucEJC7vn74Sabcvnmg5mrFOWu90GUGke/T+Ys8G1zNPTemUtrWHXUuuwQk7ekrIE/MvlIij+4H6fEOw1WsIWlLp4Fn5aol1tc1GUz4ZqQVCRxvkEO2BdS4qXzI8zCOIWWOxfjKDsiWLwLeVbNmlco4Lksk4QoYlVbUWgzZGmgDx7yEGmXtO7Yt/GQsXx/3+GNFWCfQRdIHUDQagfMd8WM68BZ1sxhQ5QeYrJXvCTxs4RzuWtUtgKhwfSR3H0ilp14fbHftVXbfxzW2bgsf9kQXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7zoBdZXuH2o3ycCQyJIs3bANs0z3tHUpTJqyjqoEwfs=;
 b=jE6JLOSe1PkAJLP6b+aqvyedTQ8349lKe/+eHiGt1NcSGd3fhfV8ppkDA35Bhy8Mo+H1qrV5DTMKY7FgwzcNzVWkByB7MPt6dUJ48WBESfEI3QEbA7Icc1GRjvjogJiOzAotlJMYbK0NijopP/q6C3vitfhLTYNMR/juAe+TAAw=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB5648.namprd10.prod.outlook.com (2603:10b6:a03:3e0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Sat, 25 Jun
 2022 00:39:07 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c%7]) with mapi id 15.20.5373.016; Sat, 25 Jun 2022
 00:39:07 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
Subject: [PATCH Fix 2/2] test_maple_tree: Add test for spanning store of
 entire range.
Thread-Topic: [PATCH Fix 2/2] test_maple_tree: Add test for spanning store of
 entire range.
Thread-Index: AQHYiCv6Xa6vSUkxRkqZD56U61zSiA==
Date:   Sat, 25 Jun 2022 00:39:07 +0000
Message-ID: <20220625003854.1230114-3-Liam.Howlett@oracle.com>
References: <20220625003854.1230114-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220625003854.1230114-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4f865f17-0ced-4dc2-b19f-08da56431d13
x-ms-traffictypediagnostic: SJ0PR10MB5648:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nVV2jxVy7v9CfsEVKgqOq0izXEBv+Gk6DaskE1F2u0Iv3sdGnISCvxZjos3Fc+Y/d0N3XZjTbXuKcEqBgITu25AukAe6phiF63w3MMkX/iO5s/jASlNu/EoOVen/Nq9D/bhrFgc78BfMG3GBu28OlP6Kc/XucPiVPXDJnbihG7IQbkd1euz7VX77uM00RtefkAAxUs1VsmaWgVIOhpioVffHttpuGAgGtnIgvAC8wMUPwfEwobFaakxhZNXywbXw1necWA1X0xTAwOXEuDRQxY/GFQRxu6kN3I5uRUqm+SzLqdcQtFH7HSeuwFIpsSxhLct3EQjp+x7EnsxhW74IWmpIWXK9/WLnbF/I4VdsllXq34l5w7xN4NvRERYmgRHyYcAutinO2pG1IorXMNnhKu/sM1j5LPhWl4ptWknyyi8Ik/D8FO3KBAbe0/OSo1DPNvEmdoQpb+bXT3PjdgZNvSGtsqgHqStFwKLlHTiFbWdAMC6d1gkv5HEzKq6Z5PYGRq4HTApvrNK36UDHrappHOp6EzpecbYisQcT2mpZWWFJFJi0PKrwZjMmtUTZA+swkkCLZSgqvhe6eF6I/Eh6LZNwtAemzdYQtDTeJrD8zXUNlaNqyPtZbLBH2DCl7DKxnJL3FqJxsBQy2GIsiadq76EQLIGz3k3z/3u/LquDcH5abZPxmFF9Dy95wedy2sGdpmX73BE6icgn4XcVpbHksy3TT5Y59GbhUPeEMrqKFOwJiVBijalwOnFqQJ9zDh3NXqGi4wl7Bg8uSr2NB9iR2aCySnvP94dH4bPhe6Wj9Wo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(366004)(39860400002)(376002)(346002)(186003)(8676002)(6486002)(38070700005)(478600001)(71200400001)(1076003)(6506007)(66476007)(66946007)(5660300002)(91956017)(66556008)(2616005)(26005)(66446008)(6512007)(110136005)(8936002)(44832011)(38100700002)(41300700001)(83380400001)(36756003)(316002)(76116006)(64756008)(2906002)(122000001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ml2YOl7DmypqVX2xxMNJhkK7PJm8Ppz6ZSk7s7dp3gcPD3W+UxE6wOsQCt?=
 =?iso-8859-1?Q?QPpJYr5ZVTcaC3cgy0aJn03akiYCeSqc9ykJya/NGrdIKUGMORNzZjPDhs?=
 =?iso-8859-1?Q?TZ4qQQAOQb1snTkmTg+78X5ig76YuHsFuinpDZg7VxJ4QRjJ9hV4ndtIHZ?=
 =?iso-8859-1?Q?SsPD3e6fveeUy+sYwAgj2p7aG+XptLnRf0FKBZKa0TpczbWImkAs3IAFfI?=
 =?iso-8859-1?Q?6awj3qen0RaloNnNPPKcIBrX3nMrcytcyl4AoBBgFhZP3Z2ilJUVKUAzf9?=
 =?iso-8859-1?Q?mcRm2EOtvevGK+krchLURHqN53HBCL+QQVgIJx2o7T67uPrEUbhIdgq/Eh?=
 =?iso-8859-1?Q?QAZZf2Z1cp0GRLkzXD6Pg4DqUTC5uwSgDz0UCkGegerUhB8htdSw4IGwMO?=
 =?iso-8859-1?Q?yEblyEB7REvCEvdLeUdPFP4D7ZPXIfKeH7KfpRN2haqS3QYgjAyKrPLU3S?=
 =?iso-8859-1?Q?sNuyLnpEPk2cb6sRTqPR9HGhVyS8f9A6ffis7hzdz3ma+23yavSKCkpaSb?=
 =?iso-8859-1?Q?9H9d67ghBtK0NsBODNCqPHV+I54+kedlMvMlZvPBUs7KoBzaFb89unn53b?=
 =?iso-8859-1?Q?K1PRIh3I/LLpQ5SHRF+XwO/zAmPRpmk66hwqvqG04mGrIe5GkPEaXzLWMY?=
 =?iso-8859-1?Q?tjfTpPjnmcyN/golsj/4DSERlFHn06yCct5gSRwpZ7zz1luhSH6uigyuLn?=
 =?iso-8859-1?Q?tzstW2IxGGnJ8IvvJUj6in/4TYa/Z4shc26rzIdwjN0kfPNLCRzMdMAEMp?=
 =?iso-8859-1?Q?0y7XO2tMh8cOi0WtFLMtSjL6V8pVdvGDNnSIi59UZbwstZeJefv3Xd6vOy?=
 =?iso-8859-1?Q?7dx8CE9zAmlUi1lrr2vk3w7BxJyYwE+vyzPN5lYnIvByoqGNAosclww6XO?=
 =?iso-8859-1?Q?mLXsZPLxqhignnNBQ5Wx952Oo8ep08UgLwzkcW4iHl3dEyhuhXj6IpbZaJ?=
 =?iso-8859-1?Q?zSvZf3cRjUeTGVURirwFH4UFWBCNw5aWHptxJaqB4mzPSt+GxzohYLdpDs?=
 =?iso-8859-1?Q?rjdqtatWQM+B29p8hy4Ab2qkAJsJUhds0rCO6/168getmn275VMzA1JZt+?=
 =?iso-8859-1?Q?4Y8Ttw1b4Ud0HQL4GdtgSTnPKLMvrVtGns1I9tpOAdKCJ4T5Cx1P0536b4?=
 =?iso-8859-1?Q?xCTn3W1FJL6mY5TbwlyqC9Nkkcu1P0BUR1A+poXJfmhFppDw7iHb6hrts9?=
 =?iso-8859-1?Q?uHwMTqX7Dc7wmisowMBL685ssZWeXjPnogq9fZLW8yOzELLymIJXB4CbRq?=
 =?iso-8859-1?Q?4suVKt5X9XZAsUQO2dMJxpcY8Ing25srLgOOS3a2cR6BpAywyNh/uRZfrn?=
 =?iso-8859-1?Q?oh6ylAGbybM42q7SL9un/hqJufhx3IrTAJibGsnx39GM8lDFnbF0HGln3G?=
 =?iso-8859-1?Q?95k3LR1DT3UTA7luO8+lgZcaCf3/MX+DjgwUvx4V7YltjFHk3fx9zA/1qC?=
 =?iso-8859-1?Q?2GzoVPTf38EeLXjttpoXhTOLlUt/lBr5vZq4DtNVCNeZlJ1kNZq2Cm2qTp?=
 =?iso-8859-1?Q?JFUANpg7VevRV4SNkXYHAWhnFSVx7DEPPAcHfGRL3vTWx+puDm3uarjn7w?=
 =?iso-8859-1?Q?3be0PMCVoAYUQm9nAvWrT9clazClD2DUG/ESxa/zR6VEV60YIu8eLN/1vr?=
 =?iso-8859-1?Q?xDU95vibyLo4n3gQeZo+U9gH/IkEJWlcXhDmHLEmOhQgkXi0JlN7z/hA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f865f17-0ced-4dc2-b19f-08da56431d13
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2022 00:39:07.2286
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9FGCykFeXVuQbUfM3Z6B+aoMqXBofPZJNfCYNUuXhTdl5dEjuS1LRt5lWhi3PS8hwSJ12r7GNyZLdr7csD6xJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5648
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-24_10:2022-06-24,2022-06-24 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206250000
X-Proofpoint-GUID: _B6_n7VDlJ4Vz8vPWscPueLP1oBxLeHG
X-Proofpoint-ORIG-GUID: _B6_n7VDlJ4Vz8vPWscPueLP1oBxLeHG
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Entire range store over an existing tree would cause an underflow in
mas_spanning_store() when the tree is multiple levels.  Add a testcase
to ensure it doesn't happen again.

Fixes: 51282228cdd4 (lib/test_maple_tree: add testing for maple tree)
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/test_maple_tree.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
index 9fc0618f4ae7..8de5705b7b9b 100644
--- a/lib/test_maple_tree.c
+++ b/lib/test_maple_tree.c
@@ -35676,6 +35676,19 @@ static noinline void check_spanning_write(struct m=
aple_tree *mt)
 	mtree_unlock(mt);
 	mtree_destroy(mt);
=20
+	for (i =3D 1; i <=3D max; i++)
+		mtree_test_store_range(mt, i * 10, i * 10 + 5, &i);
+
+	mtree_lock(mt);
+	mas_set_range(&mas, 9, 50006); /* Will expand to 0 - ULONG_MAX */
+	mas_store_gfp(&mas, NULL, GFP_KERNEL);
+	mas_set(&mas, 1205);
+	MT_BUG_ON(mt, mas_walk(&mas) !=3D NULL);
+	mtree_unlock(mt);
+	mt_dump(mt);
+	mt_validate(mt);
+	mtree_destroy(mt);
+
 	/* Test spanning store that requires a right cousin rebalance */
 	mt_init_flags(mt, MT_FLAGS_ALLOC_RANGE);
 	for (i =3D 0; i <=3D max; i++)
--=20
2.35.1
