Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF439577359
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 04:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbiGQCr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 22:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232809AbiGQCqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 22:46:55 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864D51A049
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 19:46:54 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26GJ8ghp031747;
        Sun, 17 Jul 2022 02:46:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=vKEGZiDbjUS5TklmauQ38aP94SY7H8UcWJt3cZGC2p8=;
 b=vY7CM3kcuGXUW/TM5LXSNUfKoEOUYLvgKs/xdNH7sd+Wv6bc4MsJXQmGK03pLOV0n6t8
 4H2UKGnXiTwE6ux3Ev9dWsMuXgH506UV452nsegR0M9afLWskhAPZCroC3Qq/XE/RZuc
 KqVkH1Hes5ISI5v2SFDTlQ2hbtuuByKE96LhZyYd735RTU9gBnnZ3Fmn+MymSGJkUikg
 rvQ0lzvg5n01f3hUa/PKHVoHIXFFAODwGb1yKao7Kc03l2fCZUv2m0YUXACgeZAKg3If
 iMJC9NKfn+XdfMOWsn1GJwIfUTsKeWrZe+bVTYuh2OVjHwVe08PNMLSgIsMm4UoBxFmd 1Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbm428y7a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:46:45 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26GMYImV036151;
        Sun, 17 Jul 2022 02:46:44 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1ejp63m-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:46:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OYUjIJEAx+7Ctt0t3WXC8GL9SNpBDpBiMbOJ8eoJTJ+K+VTKzQKfvC3QvbIPB1COFAOOGhgerNo4Bvhnm0cJmVHAudJ1LRUFPT9n/XOGO9o5ecM2KhC6Nn096tSEZS3W4LEgxkzEgLG3MaICx3NPkO++DrPFUWZyemkQZS6DDVWCcybsQFT6q0mZS50Ww7qlhFBRgJeZa7z/LmJnJtExTDPdsLhRAze5eOyxgxJlEVI6dUdsQA1stzIeAVKgMWHu+22jQXExTdjZ5+ySzakY25NfwqrvZa0vBkuTK4RyfZXXOvvdNI46AAeIGUdcHoqMmTRqn5uCJxi7f958Yie0eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vKEGZiDbjUS5TklmauQ38aP94SY7H8UcWJt3cZGC2p8=;
 b=Kqn2RH4KnUz1XbwFPAbYNtKA5GDKXXLL7oHIYPBx3lOm8hi39VUiI77AVgL6328s5OoQ/jrAFgdoEweJxOa9uprqMkV0YSzZtLZm/wEDXJ1Z0wETqMXjVQlgQC2BATfFODkfN0Amd67y7/5753A7WBCofho8LgZm1NW13dgQFPil9riG48xB2MVsg8+0wNpjV/3er7Eg9zL1c/iQUylbG/cR+HZtBdx13BB7YsuVwLJW0k9EyuHXQpkcwvujnm2yQ93O7Sc2ibibg7Oi78Gj1VrRvMuIT/45aMX6KIAkv7hKzagCCOfX31VOgdzZOEr3pbfO3t0hZPS+NpineT/JKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vKEGZiDbjUS5TklmauQ38aP94SY7H8UcWJt3cZGC2p8=;
 b=Q2MXpwFIxzyk40kMnmQXqkkq8uhA5H5a1TbB5dyzkN7YiA9Ao05hHl14m/Nf5E3c5n/WhlQbx/7CPX127UlLBfoeIaoxTKZy+npgUw/Gru7ZaJAwJduzE7wmjL1P/+4ly4Ntld+xLWVsJ7ZS1i8taJCAaoo9ANpIfwrg14oyThM=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB2908.namprd10.prod.outlook.com (2603:10b6:5:6e::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17; Sun, 17 Jul
 2022 02:46:43 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.020; Sun, 17 Jul 2022
 02:46:43 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, Hugh Dickins <hughd@google.com>
Subject: [PATCH v11 13/69] mm/mmap: use maple tree for unmapped_area{_topdown}
Thread-Topic: [PATCH v11 13/69] mm/mmap: use maple tree for
 unmapped_area{_topdown}
Thread-Index: AQHYmYdxiaE/tsui0UGpTiejLjmaig==
Date:   Sun, 17 Jul 2022 02:46:40 +0000
Message-ID: <20220717024615.2106835-14-Liam.Howlett@oracle.com>
References: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bed0faa9-0e43-4f9e-ea09-08da679e9542
x-ms-traffictypediagnostic: DM6PR10MB2908:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eeGfpcxipRfgLPcBVudVv/ToOR0oAWPRIotv3EfWPXxcCxsTNKPkFN/2PHtXE+PrWjzy9umaY4mUhNkuex8kHqupbTgwBeIJrAPBlpzMQFIO5MKB8A9USG1+xPX67OosnbMeiyLtL3xIoI9GI6LOvCRoqKNPhh+fuOsV5kxreqjbIqqbVHoWQ+m6j5+ROTbtsXW9FHZN0WyrtsZeqRE+lkICwwFzxSyoWLHOpE+T1lKOjpXierR+p2tC9jqgBPIsUa90/8l9ZhDjqe4O/XWsSv0toBLWT9B4d+thc8Kw2omQvWRZaYvtL9sC8mf40ajL7iD3o4Hc5t6YQtPTCV8UOGa/fX2bDao3JLJLx/PkoMUwpHilaMp+j3uDCKsFygoZzBCxm1O/0BAFWSz5nRFciLzOtAPnuPcjQ/h8wLF6yrCxT+4xtV6tp+267Nma0kjLTWCYLIR4fVrz/7sfKrLRkUYyXfmjc/sUH2I/OGtBA1GEefeyk3LbqSMWaO1TjO/r8yncE641ETvQCTdFLg4mNb3OAAGCUlAaB1dn+56n7gQwKTnNGb28WbvGSg6IedecS75gueN/+pNCVlkXmc9xpp5UwlnXPLWhLcP8b3KjuNFhpFkns3N5zoRZ1CkbAFbqPlAHEp/eauDPlb81Ec2hTwSr2AS7O9lOHO45Hu03FyXrLhuFJiYNI1f8YbzGuDMZa8lIl+f8aXyXZAdYbQs458d5spnFnlsz/jBGIOcQIBQV81hWzFhtz/TVti+f1yY/gk5HYmzSB0Af1jomsZul/8RffhWSMUI2cS7xvRVIFYJbSp5mR8PHPuPyJIIeDwxlybmUe1lMaGJnezt4VAJeWw8rE2b2mwiu6RMubClpww1XxrBVoJp5TCbknDLTuG7uYifVybTyDxavDb+71zZ2dA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(376002)(396003)(136003)(366004)(5660300002)(122000001)(86362001)(38100700002)(38070700005)(6512007)(83380400001)(186003)(36756003)(1076003)(2616005)(6506007)(71200400001)(8676002)(110136005)(316002)(41300700001)(966005)(478600001)(26005)(91956017)(6486002)(66446008)(64756008)(66556008)(76116006)(66946007)(2906002)(44832011)(8936002)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?9x32tGTZAfr89PlCsWBcSFrp5SMV9IPV6hhsK8Xazn+qa+qlzX3IksJ+TM?=
 =?iso-8859-1?Q?ZWbfWM+hRq+mLgmtSAAro3u8aW8Vyb3GRC7aymbvg83Uk3soxnihMdED/8?=
 =?iso-8859-1?Q?iiySpcUJxquSgsc1Fg39QicriLgRTV2ByxN/XBywwZONxaW9lWfTA0TCry?=
 =?iso-8859-1?Q?B46JKZly4JSlOeGbiWY+TD7p/tI1KSB8SWF3sLq4hrUPNgBi8+lOfw1p9R?=
 =?iso-8859-1?Q?Gy8zE5o/g/nzQLvFYV0wA+UwN1jP8mlRExzf7tWdnN7NAtRhCjIhQf2rwA?=
 =?iso-8859-1?Q?ZnCQ76G2xfFeIVtKEdGFxi5tweU2lmEBJwF0dC9ONAIprDGpMe68TE85nu?=
 =?iso-8859-1?Q?tJ289aFWWaF1cTz7wQ51IijnmT3BQUps1TuQ2+RHy5PGLh9Y2GmRb0qrUO?=
 =?iso-8859-1?Q?XDoaho0w+uU7H6q2cE8wV8WjkF2Oc+zWbGRTClcFgfMPmTDEtpXO14p4Kp?=
 =?iso-8859-1?Q?Usz4z/2HbcRO+9cU2/NKPZS9dHc+H5YMO3cFclACUZKKGkmrnWTRfxICBO?=
 =?iso-8859-1?Q?SJ8BEsCchwMqJCOjyOzcHD0Nrd2q14HszLV4apjaZbNIfqWjb0VFoW0WTr?=
 =?iso-8859-1?Q?PH/dPXD/Ttk5Ptht9TrNvw4TrDUUPfAjyGjmPGSzNz8zPpWnOKbmhy4LOI?=
 =?iso-8859-1?Q?rK9/uonZsTZuLbdY/dVJv8m8r6UsAdKhyweYhu6DTmRhkTwTYb2oaKk/5r?=
 =?iso-8859-1?Q?IUg93NeWyw/ZsBAflVMlI8wYy1w8PqIQ8y5PTtsTIDJuIXhRESg5V9gIC/?=
 =?iso-8859-1?Q?y5JaBdyNe4bZN6xrr6Gwcf4dY4gizWjWRAIAFEk4DhOg5ZB5tiHYF0F74J?=
 =?iso-8859-1?Q?5IGlRQF/hw8iGjIjJhpnNlfTNX40xPeO75KeEkMOWZW/sQB2/iROam/wkP?=
 =?iso-8859-1?Q?6lWf0rX0YJHVARSgYh8ZHRXi7V1NHWkYZUG3EFOc+1IRx6UKN4lMf6lsX9?=
 =?iso-8859-1?Q?P8OpPKEe0nUnbUrmIUDh5jg8hqpH6cRA4EDHJoYZap1FS51LQmQkjxyYve?=
 =?iso-8859-1?Q?u7QjYT7KG0qPbVFIbiTZSoJSU8FN2sV0rqAHiDllAK/+VudF4LnHCGzGUm?=
 =?iso-8859-1?Q?ko4oGxBF71ZdnrhfjpNQQvTVrPeqKFW68rhlKA/+u49GBKo2Gt7HfwQWYa?=
 =?iso-8859-1?Q?18AEW8NpuUIvK+q76GBI0G6gW3v1g+UNlNv94FBh/2FB/GLwp1gQjDavge?=
 =?iso-8859-1?Q?h78W/S+AomraZRP6rlm3aeR7offRaHF99Pz6Or1Kzexb87FmYrhGqhawqF?=
 =?iso-8859-1?Q?M0C+F26+Vu7ERXLY5tS1RnL5jvJxnaiVibXunJ83sMkExoBon/OBlCo1gZ?=
 =?iso-8859-1?Q?dLGNby6Y1JoY7X4eq69iQOQUn4ODl2pwLNL33ArApRhlS/2fdzGpR6t3b8?=
 =?iso-8859-1?Q?ahohL6vbTwX/9qUisn+tblE1KeeOtmWnSgf+ZAC4JLYyUm2QzSe69liBth?=
 =?iso-8859-1?Q?/tkNcOr2JZDzlcvA8++le0snlJKR83CloLFp2kOKLR0MTH74wMSSUNVVxP?=
 =?iso-8859-1?Q?9ORDBW1h8mPVWcenjDWQ2537BrqSswN2LRQBglH1cKLXB8NFVP2nVfSNyx?=
 =?iso-8859-1?Q?i0q2CDnbuf4hvow8rxghII+GBBvSpe2PeV4H8p2FEnSI+twHhVbDKS7oUM?=
 =?iso-8859-1?Q?dycScaN6t6h7drB4v0Skvgfc1ZjuPK0K/wCQNbeC9H1HV6AHMi5gqaEw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bed0faa9-0e43-4f9e-ea09-08da679e9542
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2022 02:46:40.8969
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yCMA65TlrgpIRFoCf3ZzMKnip+Iiaje7MQrPQ1fQGiZqdSQm/Uch9Ay1awTjSQq1N6kfRTBgm8XtEbTbqO2t8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2908
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-17_01,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207170010
X-Proofpoint-ORIG-GUID: r9XWcWsZLMuFoFTMBQWyYOT9zThZhUR-
X-Proofpoint-GUID: r9XWcWsZLMuFoFTMBQWyYOT9zThZhUR-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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

Link: https://lkml.kernel.org/r/20220504010716.661115-15-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-14-Liam.Howlett@orac=
le.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: SeongJae Park <sj@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/mmap.c | 259 ++++++++----------------------------------------------
 1 file changed, 38 insertions(+), 221 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index dcf4887c0181..1d683631801c 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2061,250 +2061,67 @@ unsigned long mmap_region(struct file *file, unsig=
ned long addr,
 	return error;
 }
=20
+/**
+ * unmapped_area() - Find an area between the low_limit and the high_limit=
 with
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
+	if (mas_empty_area(&mas, info->low_limit, info->high_limit - 1,
+				  length))
 		return -ENOMEM;
-	high_limit =3D info->high_limit - length;
=20
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
-		return -ENOMEM;
-
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
+	VM_BUG_ON(gap + info->length > info->high_limit);
+	VM_BUG_ON(gap + info->length > mas.last);
+	return gap;
 }
=20
+/**
+ * unmapped_area_topdown() - Find an area between the low_limit and the
+ * high_limit with * the correct alignment and offset at the highest avail=
able
+ * address, all from @info. Note: current->mm is used for the search.
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
=20
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
-		pr_err("%s: %p Gap was found: mt %lu gap_end %lu\n", __func__,
-		       mm, gap, gap_end);
-		pr_err("window was %lu - %lu size %lu\n", info->high_limit,
-		       info->low_limit, length);
-		pr_err("mas.min %lu max %lu mas.last %lu\n", mas.min, mas.max,
-		       mas.last);
-		pr_err("mas.index %lu align mask %lu offset %lu\n", mas.index,
-		       info->align_mask, info->align_offset);
-		pr_err("rb_find_vma find on %lu =3D> %p (%p)\n", mas.index,
-		       find_vma(mm, mas.index), vma);
-#if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
-		mt_dump(&mm->mm_mt);
-#endif
-		{
-			struct vm_area_struct *dv =3D mm->mmap;
-
-			while (dv) {
-				pr_err("vma %p %lu-%lu\n", dv, dv->vm_start, dv->vm_end);
-				dv =3D dv->vm_next;
-			}
-		}
-		VM_BUG_ON(gap !=3D gap_end);
-	}
-
-	return gap_end;
+	gap =3D mas.last + 1 - info->length;
+	gap -=3D (gap - info->align_offset) & info->align_mask;
+	VM_BUG_ON(gap < info->low_limit);
+	VM_BUG_ON(gap < mas.index);
+	return gap;
 }
=20
 /*
--=20
2.35.1
