Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5C5759C25C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236133AbiHVPLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236127AbiHVPK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:10:27 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BC03E77E
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:07:32 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MF6ZuB003916;
        Mon, 22 Aug 2022 15:06:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=REs+vOdcX08KbQnFA8qoYOeziv/i0t2zz7oWXnhtum0=;
 b=LDZiYoCbmHDy0kwMaTr4QU1nCRIgcfcJTexujFfBm8QvP2dMNU/4LOdtkViptYO7Jeok
 UBQ7EK9Fa0z+Aoo4lXhLNKUnKQQxN4cmBtWdNzmp7Ehr0xexFGRhudHpnK0EQerQteMM
 oWp1XQlsfCJNVskabGIVe2+tJMaH1IlkNht2VVKny110V4RVG95zkZCVhz2Q46Alj9o4
 vU2l9DaGBFvHPZbdWhZzYmZkR8QV6GaCtZLk1lbl3JZ4wRj5wykQRV04ddmC2rKNM08w
 ZA2qc0Y3bSQIE+rQVK3Kx0ZVSEPzM1TaSj4zTPbApNzR8C6nwE/RQKJl7VPZvognfoYx OA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4c56800f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:06:39 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27ME4Nmp037786;
        Mon, 22 Aug 2022 15:06:37 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mkg3e04-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:06:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UnQ9/Zh6ahbgfWyX/EL2NHp+0mTn9HvOGvBtNtINViNOzZXWM5UbXvYipvGVR1V9cXnbTu/yqWF/OcZjVdtMP4IeRXQNfWucH5iJ0jkinVrMsBebA3Be+QiKjCln8foJ4QA3KxJ8v6nBYDDUk4Ia4XFaw+GW4uXkGlU9+pCn4GW0y+qhXBFMimxsagz3K/0iNKj9Kt1ZMgf/60HSIq9rZmyrstrhMWkP1Vgj9I0UsPQ56EqqUdaGVjh3eZISzpk/xZkYbS4Zo92MrKV44VY2CkBNZ5tKVZfeIx70u8fl4ASidwIJRVFm8vOxn5P2whiFeU3FNGKKqXqLd/HnFPcYvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=REs+vOdcX08KbQnFA8qoYOeziv/i0t2zz7oWXnhtum0=;
 b=Zi6HE9Prvn62QvorlJKo/571nhaH35kuEteo6rbPBhxd51k6Ie6lQFTfWAgn9GLrPFl+w2hUsE78sCb0M0BaeSYbx1egWDQw5aZMbqAxKnIT8gGRi8q5gZsO7jrhKZZdplE0HlK5Weq385eZSvvmbcqzXfQt/uGNZHiOAN17MDVELhH5tqwcjJAycAenpVmi4+i35ClxrVFsxgCzMSusB7zqMo3abr4+E12h3e7rcC1WtiExr0LChMXE/FzP+CvTkYR/IxFzUiNclSYj34a0fJPWQpCJRnK9dMohTTfVgkUeOP0fBp6gNSkQmNlcJDhIZqtU4Kjik9sC6kQXHqQryw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=REs+vOdcX08KbQnFA8qoYOeziv/i0t2zz7oWXnhtum0=;
 b=rhY6kcafUbRCvT9PzdomZ4gxZlqbboIGufqAXimdM7ICHmo+4XdqifJ3MtFQBB0Mn6lYNBQvb7btzbkJ4+/GBGFe0vPyMAmsersXXH7nca92nE59INBqUVByTG2VfxRS1MpkD4zwx5+kBf4K5prD1AM/Jd2F8gB+4eyRPyYncxc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM5PR10MB1433.namprd10.prod.outlook.com (2603:10b6:3:e::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.21; Mon, 22 Aug 2022 15:06:35 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3%5]) with mapi id 15.20.5546.023; Mon, 22 Aug 2022
 15:06:34 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v13 59/70] mm/mremap: use vma_find_intersection() instead of
 vma linked list
Thread-Topic: [PATCH v13 59/70] mm/mremap: use vma_find_intersection() instead
 of vma linked list
Thread-Index: AQHYtjjCs53hc0z9jUuba+iCfNFRGA==
Date:   Mon, 22 Aug 2022 15:06:31 +0000
Message-ID: <20220822150128.1562046-60-Liam.Howlett@oracle.com>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fbdd6af5-5521-4c06-4631-08da844fe79c
x-ms-traffictypediagnostic: DM5PR10MB1433:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qra0jhyqtz0esxhY+b0YTdcehzrxfXHlPqKhASuIlNtz4UaMRR7SXAKLctMOLD+rXWJdXTevYY9xaNZwYGu4bLml8MDKa026IS2UnIy7XrKYo3KVmuOX/c/FgHWehYNrO+o9z/k6lggklWA7ieDs/DP5znEqvPp2CBCeiOZOqB6+WctjwfUS0TqEuO7OlCOqfPaAX9JTw+IEtkg+m7DKhcZplKjO93e8WhX8ussp8fuqZ9v/nrdCkARC4ThPqiJn6wc6Nckkfq8KWYp6WRKh2LB6V0sj3IdRA7bYGwFDpCIA/aDjnSM7FIa1GMSpZaa5t524MGhJRHSZqpBzmhv2rWWf/84czRkoJSnvUEU31DjaXsZIum8Q8mUSmLEzvHY86ehQ8Y/o9Vd+/8qnosl/krVFAlmdkfmFAzzryleUyztlKLJulCW+nQ+SVdY2z7j2AOZKXJPMPM0nUECIKx0/+IzmKq6iuYbp+yI3fmyYNTQFVmVoTRl5riHJZSmN72QjxFKMuZhnYmjFL6E5jQVFHLyyMJmLaWTSbLJgEJyzY367C3AfZHpwBiSk454n/8Bl2/Ig3+lJ1nK2q9NMdm82T7eZHhVw5b1TJaRUOrWNrnPzxNTWAJOMWPqeCb3AVzdVNICfdVinzAsKuWhxjF0vP06ESAs9ERoIulft6we29wrDVYzIim6Pg2wFe1gtfKrO6vsMEXUYq6/ihXX9CpUfbEBo0a5EXMaLGD7z4lc8wKItfciXSTWxypRxdqbrNv38rPey7UTCEskbsUYfLfEqSQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(396003)(136003)(39860400002)(366004)(5660300002)(8936002)(38100700002)(122000001)(36756003)(41300700001)(44832011)(6486002)(6666004)(316002)(71200400001)(76116006)(91956017)(110136005)(8676002)(4326008)(64756008)(66446008)(66476007)(66556008)(66946007)(54906003)(478600001)(186003)(1076003)(6512007)(26005)(83380400001)(2616005)(6506007)(2906002)(38070700005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?VIdU1+TZaMT/B355h+XDb68xJmvlRvU5fmf4hQSpm7Q13oH2l6KMnans4s?=
 =?iso-8859-1?Q?gbWmcQxXEqVb+M5PU5yqt0frmT78YRDgz6sOAVulx698WKG0QqnT9qpmc9?=
 =?iso-8859-1?Q?XTou8HkdIszeRtMIhUoBgKF2P1BjQXYPsItfnwPVR0/nXEdoz4FFY1YD8t?=
 =?iso-8859-1?Q?G/ulOrRaxgjSym53V5lym4vnlpNgd7Yy3+WGMuIFm6z2zrsgYLpWD1B2IR?=
 =?iso-8859-1?Q?h8Ofc9R7FLaPoQN1OUFrqaQL/VuYnGPZDYCcbo8rEs1Hp9ie25O6InPuHr?=
 =?iso-8859-1?Q?/+TC0hE6SHncY5llFqRMEqP1yBieoYBHl1/7iCCTLeE12XaJMKV/Nfa9jo?=
 =?iso-8859-1?Q?3LJuW0mGaEW1nZhUlxOsNwuxCDxKvpywrKxg63OT8cSDy86lf/xnobH7xq?=
 =?iso-8859-1?Q?eJh75/7bmJOxkwQslWizMUgM32q3/aoGLEwSkglISVFPpz/L4it0h1kmI4?=
 =?iso-8859-1?Q?uat5um8uLTLZTjwrTPEKdsemoXd1p7dG1ACZJFbHXIDwARz6xrmot9RbTB?=
 =?iso-8859-1?Q?Eg0mH4dgJO6aJYOg2KkZ7XM1vvwmxB4NmRzkOsUjhJKIscDD0rVZHjdYFJ?=
 =?iso-8859-1?Q?PdkNDtgwBBX3Hw3gqDZH92VNLunrh7vwmw4uSDQ4wrnGtjAMfwxVwGnai+?=
 =?iso-8859-1?Q?VQpl4DFa1I0SUpyOLasEGJmFA67nhMq+VT3i47anA4GQYzMorcaGeQg0F1?=
 =?iso-8859-1?Q?AsSJzFdMPF+lppyNyhD8Ml6t0kmyKCrW7hM6rQ7o35h9XAk5mTmXqcF4M3?=
 =?iso-8859-1?Q?c+tQV8fAu4Pt/uaMXGB2vrzBpnZKFz1p21RNJaNDgvKZRtB2OdvZUFJZ32?=
 =?iso-8859-1?Q?90mmo0NjzfhgiVhT4jsRxSg0Yr0ZIHG8otYcTH4w5zLHhqh69lo5jUXwE1?=
 =?iso-8859-1?Q?vHzQKtMqHPTT2EV07WYItyfsknz6IyX730Wu82YgrSgspI6xi+W7kONsbD?=
 =?iso-8859-1?Q?CmUTXAnki8QqEZed2dbz4pTwral48k/PhppvCK11+fgwi26zq5uzUCSUNq?=
 =?iso-8859-1?Q?1LpwQXXNLwM+JFS55A8IY9D/95MUOgaRKr3CfXnIaz6bvVnv4HVWtwFvT4?=
 =?iso-8859-1?Q?W/5N0EkuucC1qTei+RYk/9ETylbQEr/KNrXgvkRTpYQN0oJAsrO1MZS0YD?=
 =?iso-8859-1?Q?o0xOhahY2kpavZDYbzIrDLExdJyG9d5lHq025NKd2Z9TEnu+6XrJg61Me5?=
 =?iso-8859-1?Q?cME4yrxV/Rs+ICasQ21IYfwpK1lxqLodgMHnE5wmbzFAyJRwA2g3TtUkh4?=
 =?iso-8859-1?Q?8Dd8cDjsDLB9COnhznbpPnW9cCQiD+VtncvVKgkI+lk0VKDxheHKgkfSNL?=
 =?iso-8859-1?Q?LF8ek6ImXsSqYS2lqz28jpvhZuZuGV0/BwpaRd/I4njWHluxePbLOu05xl?=
 =?iso-8859-1?Q?L7DvihqUm9OnwGN9ZLly2qZ1/k+GXjxTxNaKQHU2cqvf3hlLlFxHayInV0?=
 =?iso-8859-1?Q?HAm2rgOBECJXzl4qsYnotryoaJCKAJI8xB4zL0kzBXRH4p5t7HzoYHhEGx?=
 =?iso-8859-1?Q?OqUQsqdv0oiFg7E2/6PUcSjxlFBhDlf/jgUjxgcm78B5IUqWOKlRVk7y8L?=
 =?iso-8859-1?Q?2GGv2iOjn3lPLfYA/y2vHsrLaohZzR26MbscKLrYYh3oJzNi5ACN3Fkykd?=
 =?iso-8859-1?Q?qjkdTP3Lt5ujxArWo1xf4w4NqIPgUJNEZG6JMgXyxFYSwmvLV/DdFQTg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbdd6af5-5521-4c06-4631-08da844fe79c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 15:06:31.1753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qa94Yc8KFeAMUc11E0EOlTrQ1kd3ocUm82JP8ZEFUuuBwwjwyC+Um3bb54A10fCq+sMYkrMcC0i46taQqkB3Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1433
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_09,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208220065
X-Proofpoint-ORIG-GUID: ycOd0Iu3NNreDEWHaVPEgtTaSeiB-7yN
X-Proofpoint-GUID: ycOd0Iu3NNreDEWHaVPEgtTaSeiB-7yN
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

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/mremap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index e0fba9004246..8644ff278f02 100644
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
