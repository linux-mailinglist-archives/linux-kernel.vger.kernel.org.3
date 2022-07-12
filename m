Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D839A571F92
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 17:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234148AbiGLPil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 11:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiGLPih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 11:38:37 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73DB795BA
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 08:38:36 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26CEtPQf014894;
        Tue, 12 Jul 2022 15:38:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=E6jAPpG8MMzP7tVEo9gHvU3CiPsFtSgKJ5FWrFG2bnA=;
 b=VWsMuU7sthLRo/hhNyMFThpjwYlKjZB95yFuSBO9Wis0mu0E8vx+Z4L+9HNMw1Sxpi2A
 XjYH4e3tkWOwudlPnDZHOk86AnC08yTPXoTpwM/0CVpFe8MwYs7XCyRKwl0g3QGIkKl5
 vQBbW9kpaRapq/EPYNwIoU6Y9g4b0kXtprGG/Ht9CObR73j6dv3ZfoPGg9By3u6QFCYP
 XnqG15aDrxMuk6YF39oPr8riobaFSaE4J+8yvSWZ8qIloA8kZoM2QGUTy+Su+7M1L0Je
 slpS5g5UOpOlZT+tPeCabp4G3mRVrctmQGFHJAp/TOGnjxhCc5XqzwAvriETwX0iL3KK Uw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71rfy8p4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 15:38:32 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26CFZKpK008074;
        Tue, 12 Jul 2022 15:38:30 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2172.outbound.protection.outlook.com [104.47.73.172])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h7043xk5p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 15:38:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FAN05vJDy/r+W4lZUUMoVB2xfij0MYOEd4BI77h5rxpY0C9voBeUWiI3kZBJXGPxMxICWEUEjAWLJ3Q2FGJWNWoUh75nHMnXgg0Rb2L1SbA7Nn4thLzPTbPzTudLzs+1wv3KqZ6e9H5cFLwHErSHkHlbDdRuPAqJiJ/8a7QEZ7UdA+hSx08W5aZ1mGyel+FVFA9xn4JOOVbkOIhBWojGc5Wj+Llzz032NWqSw5wBKb6m4Jux2+A7mtxN9lWGtoJOPBSzwxli5zByNv5uwJq4jo12o/WhrStzocSNd2TrQJB8WIHL9EAPJM9FJLBr1d7C1szt27U5xRPJnRgq2ZfJgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E6jAPpG8MMzP7tVEo9gHvU3CiPsFtSgKJ5FWrFG2bnA=;
 b=PEzjO0SKlgsqt/ELJjKGssvKVFXqYQV0llLI6wLBW6gGDME1Ttg9HbHlQruIzOhoW0nZraaWffahVYKhn/U5dT0XZoyvr7V6VInf39+gmPeKEDq7f4LECYmuIwYP9NnPsogdOSyYA5m1mb3c1OIb3JuoNklQHhK6Wbj3159eAn2cHKAWAs+xnl5cyZO8niSe/7p3siMHiym4RilLX74UuTJDJ6hz7rGVCw4FskA1UqC4FTPTWEwa31DrUF1JMp8Hax1ssrvlgpMFOZZ7e4FWVYHHZy9Ul6xDrgqWaTepylQPL4kqNJr9q466XiAjDhTWMs9gpdmxQsnsm8H68FToOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E6jAPpG8MMzP7tVEo9gHvU3CiPsFtSgKJ5FWrFG2bnA=;
 b=kZAm8kNxAPJ+YBChdXnYJ2El6F6J2Kp0Se8T1qe2BtK84j8uKJ1fN4syA0aleiF3qQXJnFDp4pbQX8IWPVaPZa7fZSnu7ly1mE4mQdjeDij0e9jR4NXEb+79cxUiU1F6yeKgC6UQ0n9rWMR8p4eGtek3AMyVn7L8cGBmV/gtL8o=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM5PR10MB1354.namprd10.prod.outlook.com (2603:10b6:3:e::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.16; Tue, 12 Jul 2022 15:38:28 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 15:38:28 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH Fix] maple_tree: Use metadata for mas_dead_leaves() walk
Thread-Topic: [PATCH Fix] maple_tree: Use metadata for mas_dead_leaves() walk
Thread-Index: AQHYlf8yENHdxXlZ40ahl3ktlIk6fK163tIA
Date:   Tue, 12 Jul 2022 15:38:28 +0000
Message-ID: <20220712153818.mtgozcaqngsyjl4q@revolver>
References: <20220712145342.4191649-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220712145342.4191649-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6fe1c29a-ad1c-488a-0542-08da641c9110
x-ms-traffictypediagnostic: DM5PR10MB1354:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: otEOD3DdMk87IuEF/uEjEeZRbro6NMZmw8f0LUCUIWjJ9Ty2fBWRrWtxJo5XBfLVEjaR1IaVW/cXnMW553ecrSwtL8deD+KxoK6oarT2uUg/K7yONtGlLaHm/XAzO0v6SNpo1MdSoqs8j0XJSCs6dKdpTYp/ffTJXvxK6zINKOKuYOadvy/rnuwSuMDqSXNJFvd2V2p9xh9XOQ5gRPGlNJX2P5GnEwazJ+HYWWIbgSL8Vbn/u21+GJ7KWwtBgsbh1e/9ohLn6/EkpVf28QHdrlwkRIIaQheu04JDLdiWZ65++LIZStQp9U0d+f7xnCdY7mKmbpgtcgxRCkt2jeuJgIG2wQJA1NWalBV2wxN75gLzItZP2iinhgvz5KWoP5XAGwvK8SVoeZSwNPDS6Vn6ADXuw14Om1uc4Z6Gr0VJ9vyOGxry6RZg/Tec4OluQhijIctTxKfDaHfK0EZJEZadlJOZ6zlAofwqD5BB6Y9vBs/PrnPw6hwJRAGk2uIu7Pmi+FRgxelFLSRFaH1HYIaMK6SwNXqLo7tKNVazHkQSJI9K5OMnLlhtoViBJuyAxXR16J1EUd5tPSvES0XpKt7cRA2hEIrx3PpSeK6TOreWEk6b65U5eFoGtxeGQTr28xAxxewbbHiFJbcdtCL4uCeVgYB/VYuOmd5JvOCFKGBzrrDnlcHD+QmxVp+AfAOab1irGPyu4X9hQAFCImnbn30JVS87sSO4O7XfXBRcGH1hJQ2S+UCsaNullF0imWxauIpNLuxmQqgYhNqQfYcpzps/VVgF0trQ9n3dPt6UfMlgpwu2h6HlaGGxTs9gCJWTsw5m
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(346002)(376002)(396003)(136003)(39860400002)(186003)(6512007)(83380400001)(9686003)(1076003)(6506007)(8936002)(2906002)(38070700005)(122000001)(26005)(86362001)(110136005)(71200400001)(8676002)(66446008)(38100700002)(33716001)(64756008)(91956017)(478600001)(5660300002)(66476007)(316002)(44832011)(6486002)(66946007)(66556008)(41300700001)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hGMjfnuTIJoNV8Mmd+mAl84ZCzdRZ3MbeYB/BDXuo5XFkfXj5vGTk/DbXB28?=
 =?us-ascii?Q?QNarcE3UB2ORORt1ZyOIiZN0NsiLJOVrGjHTBFAX8FWIyJSmzntJk3AiEcdc?=
 =?us-ascii?Q?TZt7wFTuzAhrQh35MIsfwh1Tr2YCgV8/I4rxc2yHmFf+hZYG8BP+O6a0u/Qy?=
 =?us-ascii?Q?VYBiltCKGH3boPK6KWlhjER+MjrW1ORwjWq5eYX6XGw+vgNCgI5Rf6/POiCA?=
 =?us-ascii?Q?MbURcenvO8x/BW+u0P2GQffaOJ13wkPkbLtS0gogcX0XBYAmhON+oRAP2YAE?=
 =?us-ascii?Q?C9Wjoj0Rp36cCrXb6ewt2qXk7qUPrO+l7tQV3Dhc5lKvAA77dDVOMtPWdW/s?=
 =?us-ascii?Q?yhkop0Drr1QrVEnoacm5nKl0+ML3ki/Rx/FwePbWGkbfjLER+UxsCx/Za6Lf?=
 =?us-ascii?Q?VBnTKuWtQwxfUXMFiodjrweyiswQ6W6VFsLLCqB+Mx0ew7nHUOHrt+qiLMdK?=
 =?us-ascii?Q?F3H+UlKlfAphfphuyzYAW56p/ow4XZJYoAg5VLqZ2+U0FN87cERdi19FnlOU?=
 =?us-ascii?Q?CEwHaEtAuMsDvcMApJJTGLhubEm8WJ5fkVw8gbMZ/Zi9o7Ie/VtbWc6U50bT?=
 =?us-ascii?Q?FCo/rTlm0ChP5hg0CgWmUJoTFiMogAKleg4WZUX8s9xtnJ2iP2W514gwiBUh?=
 =?us-ascii?Q?xzdTm7Q/uDom/vK/ZK/5PpBieIyfJv4t/JRuG7bGLFka9u2lZ0J7TeVCR2Oa?=
 =?us-ascii?Q?2E00YdBJxnFIOnfNzPU2/UJauiWl+UpdrN8PYcDnatmTGunr8l6uemh6G5KY?=
 =?us-ascii?Q?cTt9y+Lfewog5ZepUXeRT1YfMXAJp7xhTFiSsMmnlJ7oYlQincQFjR1P2fRg?=
 =?us-ascii?Q?QllW7G+CPIUOOx2j7zeDzrVsn3x6ys8HE9ExeM/FhC4dNv6eIDF7tiMnvv9m?=
 =?us-ascii?Q?CNITI02nF3UnXeB6kRAw1BRan10s7QBgY4zegkjWzi/6HGCrse/ZfLIsOfge?=
 =?us-ascii?Q?DLyq7PRYW5BTQSJjNY1JlMrNLzTTuRSAxcbzMvhuQM8wlvisU6GIH7wia/3i?=
 =?us-ascii?Q?Ol/skPddp6+DjkBhVXGRsmSVo+nsdBHMfHhG7hXUItCclr5VK4YA4gvKKstC?=
 =?us-ascii?Q?9tp9KO+HATVvwDUV2TKvEXTCi+reehOry43XSMyPYWN5ZUYx7SDmnDxVWZh+?=
 =?us-ascii?Q?pWLwfTm/Vs7QPrMWxE8tEcTg/u673cgCUThMO6MrgChMIbWNdkTH98puUQYf?=
 =?us-ascii?Q?oXNCRy1/cJnB51j100GyUWCEcWCIAIjjFns+rAmuoKsmiSzdUMrI7JhWQl2J?=
 =?us-ascii?Q?4xIt8XLXCf/TGf9sZswhT6HrE5QdlF+1Tv6bxuAH5CRmDTlw+wFZUZicvgYk?=
 =?us-ascii?Q?363QjK8mft3fhzLRnOV6vXHBr2qYBUeg/6f3ga93Cd781WLpeJk6ruLJGDjE?=
 =?us-ascii?Q?5BbR/SIQ1wOE+54pK4ogyBU3EWooiAP5HkJqzBW1ONF+m2OlwbNLQDHYpDgh?=
 =?us-ascii?Q?HoaPKwfr1YTmxtfNqsvpnPpNmZrbR4kfnVIMKf8NKF+54fBKYzp/SUXb2Yky?=
 =?us-ascii?Q?8ZqN9WuhhXLAb/dRwLlylyuM67jdPteDOXY/9S4Lll+ye45DJGqwmpGiywaA?=
 =?us-ascii?Q?17hbrtHKjdtLzqe6GOmJMaJJEPbKC2OZpF5Z/tsCIuuCeVZOZX8d0QMJeKvV?=
 =?us-ascii?Q?YA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7FF0AE6FF690FF4380F05BBBE46C0696@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fe1c29a-ad1c-488a-0542-08da641c9110
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2022 15:38:28.1798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rN0ftOQrEBfNrXGPmjbFbEctoECwtifo0dF71B5Jw/BipJFBR2vAx6Y+arwQ269xPcYitbzFSNzitk4btDUtMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1354
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-12_10:2022-07-12,2022-07-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 mlxscore=0
 suspectscore=0 adultscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207120061
X-Proofpoint-GUID: 0dBzPNr5ln_G-e5LRYvxbUhz_U8fH5ku
X-Proofpoint-ORIG-GUID: 0dBzPNr5ln_G-e5LRYvxbUhz_U8fH5ku
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please do not apply this patch.  More testing is needed.  Again, sorry
for the noise.

* Liam R. Howlett <Liam.Howlett@oracle.com> [220712 10:53]:
> When walking the dead leaves, use the nodes metadata for the end of the
> node.  This avoids needing to use tricks for BE/LE unions.
>=20
> Fixes: d0aac5e48048 (Maple Tree: add new data structure)
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
>  lib/maple_tree.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>=20
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 14e9ab14c1da..c661fda37665 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -5390,15 +5390,12 @@ unsigned char mas_dead_leaves(struct ma_state *ma=
s, void __rcu **slots)
>  	enum maple_type type;
>  	void *entry;
>  	int offset;
> +	unsigned end =3D mas_data_end(mas);
> =20
> -	for (offset =3D 0; offset < mt_slot_count(mas->node); offset++) {
> +	for (offset =3D 0; offset <=3D end; offset++) {
>  		entry =3D mas_slot_locked(mas, slots, offset);
>  		type =3D mte_node_type(entry);
>  		node =3D mte_to_node(entry);
> -		/* Use both node and type to catch LE & BE metadata */
> -		if (!node || !type)
> -			break;
> -
>  		mte_set_node_dead(entry);
>  		smp_wmb(); /* Needed for RCU */
>  		node->type =3D type;
> --=20
> 2.35.1=
