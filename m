Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD4C55A596
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 02:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbiFYAjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 20:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbiFYAjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 20:39:16 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E0D766BF
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 17:39:15 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25ONIW39004524;
        Sat, 25 Jun 2022 00:39:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=4UMzl5xegahCBfulk6kGCoIXpW3odQRGQdWBPIlCNZg=;
 b=lPWsx32iOWJxdLNkeVgkw5k5zx+tIBBddy9eBVnOZTKCYE6Mpsj/SUexM3pDikz6f5Eq
 fNHFzKml+c9pt9jUmypdkkbpGEMoy8CSgLF2HpJcBv4GSWAAodQqU9cyqoDWMhmMykRm
 uHwJggLncEd1DgUpA5J+24DcGCFMmDpUHvrv5AHWljAP9iROuP85eWkIDwhrBELrSQ2S
 3KdV1S7bBe3KxXEPrQLdbyMk6DlJplZLU0Ty0g/hGEzS5DBqAeD0JG70q+iVrd5ZPPTH
 IgueYVbjeEQwZQGn3vfGut82ND4r97QfHS2hsffz6GGgIxGaLTq5WP2whmgpFCVNKWL6 Ng== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs5g2743u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 25 Jun 2022 00:39:09 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25P0a8O3008165;
        Sat, 25 Jun 2022 00:39:08 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gtkfxy1py-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 25 Jun 2022 00:39:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EHhQQdk1d2uUHp1HJP+GMsWN7vtDF20+34CBfgvKVL90k5H8GP6FnOHx/HGU/Z/sah57gGWCKl02NmeZCBMHki0STqPuuKIxRYpxTHhUzRegrfRBdbt7Jt2Dkch0O5TseI5A4NpeMzUUylNqEJUXeJAG7TLE/DjYiaAz0utUtAEEZVkvC9mfjpTxBJJb+R8CruzuLZ9PrQqpoCB9q3Q9L4+6bVcAJcxLMN184YYIi+j1AiTw80Fg3l4qL2VJAbNp4lW7+JfxQ+MmnJC0ZsgoK14YlK1mlxFdIFaYmtsrwW2tDDMz9FoB4hlalU99HVLZkgxvAG4A3AOVomw0AYzRwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4UMzl5xegahCBfulk6kGCoIXpW3odQRGQdWBPIlCNZg=;
 b=XYVGqwgpX14zLupiTpLLYcRZWhsArKRD7Y4DfwDxjFj3YgJQrHr7M3z7CBi3EOzsvdPWXqsUzvYpOONByJzRrYGIA6z1rOkDQHW52Jc8P78W3f7j43SO39aVwqagj0VhzorcCQERt401OUJLRYlRdxLQPJM8blNY6n72FoS0ayxXbIO9UnnEudaBaUt+nPH1m7Nq/4yTAp6WQsydMkzdFMxQN+n2UJFz9Sgoch9y87O66Yt28gfsmBQN7Ad5v4U6Ma8HRUPzHJOoXYe82TGnmlOUFkAveYDQg1cwW0Yb+EV+PJAI5AR3DROestbIibBz5eb+hWFvBKs8G9W64W+1aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4UMzl5xegahCBfulk6kGCoIXpW3odQRGQdWBPIlCNZg=;
 b=LNEP73gQBK0KvRp5a9xpDsUA1U3TGr6EUuDbqfec0G1QO/jfeUpNl2W0SkZL7IPotxWpyoJleLgCvDHAMGtKRY/I85NGWzLQVLgsDqCEpqj7PBKPPXX/L4FvduoDCsOLTuUEe1KCE6Lgyo7rReC3e2dfHeNaRzstMQH6EpO74S8=
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
Subject: [PATCH Fix 1/2] maple_tree: Fix underflow in mas_spanning_rebalance()
Thread-Topic: [PATCH Fix 1/2] maple_tree: Fix underflow in
 mas_spanning_rebalance()
Thread-Index: AQHYiCv6SNK0kdpIPk2bep1MbKldxA==
Date:   Sat, 25 Jun 2022 00:39:06 +0000
Message-ID: <20220625003854.1230114-2-Liam.Howlett@oracle.com>
References: <20220625003854.1230114-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220625003854.1230114-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 10619b9d-b504-4f3e-40c2-08da56431cc0
x-ms-traffictypediagnostic: SJ0PR10MB5648:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 78Eq+QcxmkEXeNjcu/9jeFM6z1Ef+3YW+kuxM2S7nQByDLChIunojzewZ9r3woMW6cjOPuqsgz8e8eGr1VhpmrThr0eNu3imS4XH3FC9w0eZPnqhX6zd9zKtCI5epSBWC7wX/83mbCPb7VQmPgbULWHvODBzgL0n5VfZCpI5FRS66BMO0nk1PN8/rkInnH52bu3uSrsoSlURnCDPA+FY6QmEpGmqFg78bTUjhZk/YbkyHHsRJ7d8e6CY/9ZQIw2Gbsue9mAMAQCQoOqi9HvdHuK3+ZKbrl3VOWToYd9UyBCZ/K4KNCU61XXdtXbFgLxw8by6EJ0DzH2lML052OiPNpq4hkONKpgQZjtH5e6qjCqfmp5R+yG6nrnidfeYJqzv+oJtgJCvLJz1gyUgbdrIcOfxPOJtJ4w1dIdMPgg3JXbGlRmP5qICPPUap8I4nurmvTwSaghI38YrkENOZuP7ltowGFE/+Ew/6CZ/KB7lH4dd18mKPM9dAtG+G+HDj99ySDf2GiJTMg6NneiYjPeJTZ9nW9LdxwqAF6L1z9NwbusE+LF3y58mJWuYCs2+419DKRw5CsczOgmY9Iwjl5GPJObwaYBt6ZxdGBGKQ9A5fr8RYuxhP2mU4tofAPygEZvulKm5NXUU8WhjmuKI4hc1NJMlYePgBjybCXdwhcsaz//aGZudZynf6IhlVV6piv6WSI1WpoOxBB0vIxJUZmf4t8kPC04pDv5t2xmtBMkbC/7IDnXyjVud80/Hpn1vr9qQHw1/8/YB6PPg8IjUx0JDh01LMan4f3glEceGPn94gT0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(366004)(39860400002)(376002)(346002)(186003)(8676002)(6486002)(38070700005)(478600001)(71200400001)(1076003)(6506007)(66476007)(66946007)(5660300002)(91956017)(66556008)(2616005)(26005)(66446008)(6512007)(110136005)(8936002)(44832011)(38100700002)(41300700001)(83380400001)(36756003)(316002)(76116006)(64756008)(2906002)(122000001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?pydsQp80OAg9O+8vZRpA0q4WBuCus/dVKXRyEHR9yVRBbgjlPG5FeIiIt5?=
 =?iso-8859-1?Q?MaolTpMDk7HVwZsJmwE5TE+Ht5o5xb0SeP3st3KT2OyW2APt1tDTt+UGUa?=
 =?iso-8859-1?Q?NwiXy6pvhOiX+1HSgsfVf4qVI1zks0lWCobTuI8UxJZ8YgIJJAMYxAZAYR?=
 =?iso-8859-1?Q?Y6LqASuGtnlVtIOSt0F+T3Vcue9xDa9MXuLmo4Dv+WSvO9zg67rFfkzPzC?=
 =?iso-8859-1?Q?RzbR1B/zxOykWX5VE+Wx2gI63jULPPG4qzJJqebZ/sFPTxWOjoS2LeHc+K?=
 =?iso-8859-1?Q?jnfgAUwMCCXj1x3vHCI/kd9K4RGhcXjXby9/IIT8XZUXNry8oYhlQ+0RjQ?=
 =?iso-8859-1?Q?tOu9Q0qkBUCmmvdPmDn42o+SlPevGRI+KH2Sk38RX9o6vZ8zCp63jnxTwV?=
 =?iso-8859-1?Q?3w6lsZseb5jmUVECTyfrzDOf30+qnvF2vXYnFayLe1zb5mgtVP1MKG+w4y?=
 =?iso-8859-1?Q?mflOrihrnLsyYkOPd18dI021sjxQsOnSXmxDKRGoIJU2l0h89wElp1EIqB?=
 =?iso-8859-1?Q?oCeQj6YB2Y9ybTxfNWVFGgjJQMMw6/T2LU/5e5lfrqAp67mhFQKPKF4nJP?=
 =?iso-8859-1?Q?I0lT5uFbYPvuY1VE+KpW6EyuATv4zWot8DFtKbeRi5WTqLBJMMkGSQGjr9?=
 =?iso-8859-1?Q?DavQh9lYdhOO74zN9uNtAKmh7KmAurM6bCrUcVca6o1V9RpRkm/LFoBadN?=
 =?iso-8859-1?Q?F52cRbayFx6LUV6s7T1EakuzRMIOh8gJtRJBhFIyYtg+qp4zRAjnFn3NSO?=
 =?iso-8859-1?Q?h++I4r5rbs5GfwGFR7pACrIOhH3gw/ogOt5K9/R/2VIsskzKukI+90KMXg?=
 =?iso-8859-1?Q?vZ/jZULOo48v65FlXrcL+QYNlx46iJlcU90TpCaRMW6EM7QWnKS2Zosnoa?=
 =?iso-8859-1?Q?DY6qPQk/lzT+6pfjdRFSyWSIkNYbwb3uyO8CX/Ci4rh++KfNvO/BvV1Yx3?=
 =?iso-8859-1?Q?vIlr+GXMN7ZnUPVgEJZmH9/no4dUn7TEukxj5nYfVVQleylXlTxAfPpTQx?=
 =?iso-8859-1?Q?SKb0VHNKA7+2HDoqKm1Z894asYtHn/E6/tgrNgYGuCjeZR9zGZfAOTcMZZ?=
 =?iso-8859-1?Q?mzbZL0VVMqQBX0CRpA3VxeM0j88HVmXRvgHcfvDB4gKBSsjlfJpXlS6ZhH?=
 =?iso-8859-1?Q?MdrIf8IYOZTV9+2eypr2EwXwT5rlrUvxxijvAmOQ1dWiU/Wx/9Hos9NO1Q?=
 =?iso-8859-1?Q?OFsmoxJTRxOO+z0C58bIaHEd8zcOEg2P+hgyY7xyrs7MOISlA6wwIWH/Fx?=
 =?iso-8859-1?Q?d7vE3akJVnYayTJh/tE8COeFoZTXT1qPUmGP4W/Wvv8yxmS6k5027bZ17U?=
 =?iso-8859-1?Q?fOQ2DhHOzUScvMy05I3v6fkICAAVZcb3EOTO7JLHBFqm2t2qRmQPs2pisd?=
 =?iso-8859-1?Q?JflsDCCFE3kOhnZmefTDkTQicH1UUijsGYrONvLhoElpbegAbEXrNf38TF?=
 =?iso-8859-1?Q?rngu67VbnqJ7lTXKYbprVcpBClVgs2/eyU6vmz+mMeypJqnYXwStHdNY0a?=
 =?iso-8859-1?Q?NkPDg538uiswC1Qiz0Pkg4GJvckMO7mvwU1u9+cpoZkjAclmnzCduPkB56?=
 =?iso-8859-1?Q?PibrQKogmbq3yRrHfrI+y3oy1e0cbDTaIN+flnBecjAGZaef2skyMdO3PP?=
 =?iso-8859-1?Q?k0pAx/FRfcjxENKWvOs9O2qje0oGqpcE7T6iOxJxqETHHBPaKWHx6u5A?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10619b9d-b504-4f3e-40c2-08da56431cc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2022 00:39:06.9161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iN0KLl/PN3aO/peYr8ZgU2QrY+RfYhrGKYvbfQcmm80MGrc3v2XPcvHMTUOJ3anSUfobm4JK59jap6HjhlyeLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5648
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-24_10:2022-06-24,2022-06-24 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206250000
X-Proofpoint-GUID: bUXb2WbTG_iUZkkKojb16305dLktggr5
X-Proofpoint-ORIG-GUID: bUXb2WbTG_iUZkkKojb16305dLktggr5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When rebalancing a spanning store that spans the entire address space,
the big node end is not expanded the extra position that
mas_spanning_rebalance() expects.  Fix this by expanding on such cases.
Also change mab_mas_cp() from assuming there are at least two entries to
ensure the correct metadata is written.

Fixes: f8acc5e9581e (Maple Tree: add new data structure)
Reported-by: Yu Zhao <yuzhao@google.com>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index a968948b3e3e..d8457122ca5d 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -1977,7 +1977,6 @@ static inline void mab_mas_cp(struct maple_big_node *=
b_node,
 		slots[mt_pivots[mt]] =3D NULL;
=20
 	i =3D mab_start;
-	pivots[j++] =3D b_node->pivot[i++];
 	do {
 		pivots[j++] =3D b_node->pivot[i++];
 	} while (i <=3D mab_end && likely(b_node->pivot[i]));
@@ -2970,7 +2969,7 @@ static int mas_spanning_rebalance(struct ma_state *ma=
s,
 	mast->free =3D &free;
 	mast->destroy =3D &destroy;
 	l_mas.node =3D r_mas.node =3D m_mas.node =3D MAS_NONE;
-	if (!mas_is_root_limits(mast->orig_l) &&
+	if (!(mast->orig_l->min && mast->orig_r->max =3D=3D ULONG_MAX) &&
 	    unlikely(mast->bn->b_end <=3D mt_min_slots[mast->bn->type]))
 		mast_spanning_rebalance(mast);
=20
@@ -4004,6 +4003,9 @@ static inline int mas_wr_spanning_store(struct ma_wr_=
state *wr_mas)
 	if (r_mas.offset <=3D r_wr_mas.node_end)
 		mas_mab_cp(&r_mas, r_mas.offset, r_wr_mas.node_end,
 			   &b_node, b_node.b_end + 1);
+	else
+		b_node.b_end++;
+
 	/* Stop spanning searches by searching for just index. */
 	l_mas.index =3D l_mas.last =3D mas->index;
=20
--=20
2.35.1
