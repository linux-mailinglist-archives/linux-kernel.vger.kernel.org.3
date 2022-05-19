Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4C6F52D636
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 16:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239855AbiESOgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 10:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239932AbiESOgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 10:36:12 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E932D1FA
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 07:36:11 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24JDGI0x007800;
        Thu, 19 May 2022 14:35:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=21Rq4hXP7vfFh9S7HGJkzN8beqV4EqAJHCI9SrqaRa8=;
 b=g55i95dqavvb8dq0CfS9beAb8qeQPpC463L0TE1m0h7kYkqX4WHpGOnecS1GsFtQbahU
 Kygq9vFd/ECAaqzVH8bKLwhPyT9pXGhtBCLsl9JZwdUjy4DcwMTAM1nK01D24USRu8IO
 Dq4KmsJrzlGbgjW8tXQxu/ZvVH5lS4BviK4PjnKbymR1nO619giRRX0tYBfE2eJrnU/E
 g4mI59VbVg9TT4NmSbOeJLxsgqV8PjxMnlOPubLJKf8ZbPIEIVO4cqM2Dwmpe2jM5l+r
 7yhVUZIBOc7mwZEw8uNQj92lZGwHBWz3wn0Mq5wrJcpop/C+j1gYNY98PQOoRhZXEK0u eQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g22ucc414-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 May 2022 14:35:53 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24JEQ3Ih024069;
        Thu, 19 May 2022 14:35:50 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g22vavwv2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 May 2022 14:35:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RpI6gJRsVLb5qo23d4v0icEIKG9ygjDel9jfOinz1MCku43M8lZw8wSmll2ywVRwV2haVIq5MkQKoIiRe0t/iF8tQ4NeEArTsPPKsy0ixVUFKUBpfTKIyM2VWEddCqujeEiIjs+jZytu4jnoQ2LRkEhSNwTU/kHa0DjtxETjKmrh000FBDNJctloAkOc6SyHvbhQVNxY32dBT0uFPwNMp8UIcE4orkg0fARjsFTdg2SxY6ciSH0BMvyhMbgTek/puoD3OEQBicbaMhmjUH58OCYmV+vpi65w7d2IBjPMxlIsdVwxjSA6sm3ZueVXTyrflCo/nrXrzjGMOqNGM+umHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=21Rq4hXP7vfFh9S7HGJkzN8beqV4EqAJHCI9SrqaRa8=;
 b=No6LU5ZcguLMEYjXgI5L4fEXspV0A30APzDi3IXIDNgdhMq38McHgxa0E0E99tdwRCjTcVqo2k7nFFcqpkOAHSQ8kxVF7VX1gmb80ew9IedLgyCc3/yyCbr4TjCutpAQZt/R1QCFVDPfm0/Qb1F0d2051swWg4iyev2o8UzhjMINgIRwf5x1q6eCXnQbdoVoUfE+vTiRlSfthxyOFqbpiWMXFEqPqsaxMyPwQoNE5YBw5EqRHVl+3pPhWmJsaco9Fp07VcfFhV7HFpmhNO6Hf9WgBUTPN1kQbBqupz6J9wL2Kf3DyGmoD/Fvb4+VFNAVXoCWcoSNTILN5SJxH2/uyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=21Rq4hXP7vfFh9S7HGJkzN8beqV4EqAJHCI9SrqaRa8=;
 b=morb+GhoB9i9ABa8+sB6MpCtCL/h6JeVrdMDeIHdBHnE+ic8PNOdhCclOKQ5mgCmaf2theFseVQR0qs+jm/JM8uqECEyYqHYFDorSIhodUF7KakbvwV1++hVZFAJdsGlr1wl/aRsMUX095ZfhNo7r37XpSAellj52poWUhMyEmY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MWHPR10MB1999.namprd10.prod.outlook.com (2603:10b6:300:10a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Thu, 19 May
 2022 14:35:48 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::e1df:2e42:6674:313e]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::e1df:2e42:6674:313e%7]) with mapi id 15.20.5273.016; Thu, 19 May 2022
 14:35:48 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Heiko Carstens <hca@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mapletree-vs-khugepaged
Thread-Topic: [PATCH] mapletree-vs-khugepaged
Thread-Index: AQHYWyROtMkVxK19R0i3Z444SV9CtK0GzcYAgBYshMGAACVRAIAF84YAgAAsdgCAAyWOgA==
Date:   Thu, 19 May 2022 14:35:48 +0000
Message-ID: <20220519143541.dfzgoubmkboc6kk4@revolver>
References: <20220428172040.GA3623323@roeck-us.net> <YmvVkKXJWBoGqWFx@osiris>
 <yt9dk0apbicu.fsf@linux.ibm.com> <20220513165955.mkg5wvfi4dwpzoer@revolver>
 <YoOMsmq24FWsWWyr@osiris> <b18d5338-0031-a813-2825-207bea1b84cb@roeck-us.net>
In-Reply-To: <b18d5338-0031-a813-2825-207bea1b84cb@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e66c6e73-8fb2-4f9c-1273-08da39a4ddfa
x-ms-traffictypediagnostic: MWHPR10MB1999:EE_
x-microsoft-antispam-prvs: <MWHPR10MB1999238BB4AB0CD41EFAF65DFDD09@MWHPR10MB1999.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zHC8Kud8YZrX0TJKieMxn0EL7/TBH0mfYKEHgXMBmdZY5gNcVF+Uq2i/1YYT35ZBMv//V/yDBDXQRBZCDvQedAfBTlYMKqBXcRuZSJCPw01m8w+hbMnHRftGsPWvzVZxblUQ58BzTz1VERhLCannPoZtmFA3iB3OPmD5co7Kj/OfgJrfpLrziPiJy2f5CDoBKn5UzypG9yd7v3iYWNWWOG3SXZduogR6eN702YY5wVXs77xeuh0nUa9aIsoXjzE6DhxUHSfbrwlSd2UO8deVZgcNs8Rn8Jn+ObE3jdhlYQT6a9BOPOYWibILbCaM0UTQU9phej0qPVhKEGRLy60lBH5/swxR/wXqRM/CRHbQz+tqtfT47HjYDd4jUhKyHBxnQTiACzh0x6QwUKqnujVklpxLuIS3ivjI9j2XLfJlAKxUPNWMWj6/rkDpp28XYjVVB+WeSI+tNXODjTd6GrpG90eqbg5Q2SueQtEtwbkGP6U23Fxp2ESGS1wVM92eyf3r2GJwK7P/ykct1G6NPZuDm2sM8IJb1qkmXKbv7XCLJU/e4jxkObmG2dWmwQqHqEeiOXnVT/Csieo+qOvo43WE2zYW6Eb+yhArjP2kBfYm9vVX2YoCtHkYRWAFocHylIo3p1VPTiEL/8Md5ZDVugyXgIvQ3gd1VvpHTfK3ED7hhum9GcSr/IPskkePbYiPKaP3tc+NsVv2QvaSg/5fGVy3Lw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(5660300002)(316002)(8936002)(38070700005)(66946007)(8676002)(33716001)(2906002)(1076003)(44832011)(4326008)(186003)(66556008)(66446008)(76116006)(54906003)(6916009)(26005)(71200400001)(9686003)(66476007)(122000001)(6512007)(6506007)(86362001)(4744005)(91956017)(64756008)(38100700002)(83380400001)(508600001)(6486002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IHky1v5Ym2DLuho2uwbJfrFYfKIh6RUlcyIfmwy+0s04K0NcDcdLrlMYMjSP?=
 =?us-ascii?Q?8J2fzsGMilvRggOF+OCzdlbJGje9xO/djokL2TQ4xLsj4I+21uUwg9iQ4Opn?=
 =?us-ascii?Q?036QP21p7GFMOahyWPSWDGAUyBh/M8tofTXpTSGxm2nmuRuL1lz1C4huwRlz?=
 =?us-ascii?Q?hSdo1gxDsU9SpAN3Hsqeakcz6Ovn/RN1NqHMcl++Sm4DnCzeds+2l19qriW+?=
 =?us-ascii?Q?BQsKJbgD0lL7C60u7Mm5JOaGIdCrBTatG65l2jmnjIkpuPFO030456c5RwZO?=
 =?us-ascii?Q?PpRFgp0QybHl3rKfv2FdYzlVqL6cj582Qxadnjh9SqoAyknLyozTcBKSRx8d?=
 =?us-ascii?Q?3N7tg90E327rUpjeeAZ05fVP4xnX7jSjVCU1VK4ggIGyofluQNOtpr5PKm/z?=
 =?us-ascii?Q?wa6+rnFdb0HfAATfxcNLviX2KVTOaXHkpcUe4K/gJmO/qIxFJxUT1GB6iwp3?=
 =?us-ascii?Q?vWlmxZZ6uq8ZUkURFJ7LF1PPHKCx3l5rgGMNoag1J7ulJlxqwTbXJ1/cPB96?=
 =?us-ascii?Q?Y7jXXq44xHJmO/q63yCckSNE2adcNtbgqqoRRCK0rxaZlk+2KkWmaN2Mabg9?=
 =?us-ascii?Q?mRET6EAXu0Cuuv19VG6WvlA39FPsJV/1PXkDcpc2+JFMGPe4g2+xYPQicJ7E?=
 =?us-ascii?Q?C/TL6TsFlG/rp6KguA2NAFpSubTDJoORLv3LC8IeyeNFk8NqIuQcdCNVqxQe?=
 =?us-ascii?Q?2FEJdUn4nz0wYpupgnh8BAmdF8E5UkkdL3uAX8Y3psI+BaEMFgQInhgGn0XI?=
 =?us-ascii?Q?xhDZ+Z+qWlHmYaCbnyCDZxrpqtlOSDBlQzU3p7dlnf8YnJ2B/DqmRYMxAPC7?=
 =?us-ascii?Q?2P7wzxRgQQ+r7fmavOhLabXpsPsq8wgBAnRhIBqbl31SExa/8Vy/PfnGKciG?=
 =?us-ascii?Q?iH96VtcpFyz7gLPHOTRNlCXcbRp09VUU7EP+eqpGuJblgShDsdiX/QhKCS+W?=
 =?us-ascii?Q?CZns5gLnben974sVzQOu/YjBPf7wlJa+V71okxwbEhroUONMCXfAJ1rioYI4?=
 =?us-ascii?Q?Hzi23qM+HgjtlcmyH8FSQASwJ107xtQPmGDeSrASFBUVbuUE0sLTcJIM3t5C?=
 =?us-ascii?Q?Mm5v+tYH217FcMp8Hiugg0Rw/yRN9INoC1jb/+6KLjV2Z04+/i2APkEtL5Qy?=
 =?us-ascii?Q?fYRgutei/sKjg294qEeQoj9p2gQBO22IaTA93pYP+nLw6k33kjWKqu6jU64N?=
 =?us-ascii?Q?Lkj5CDtDMdrWo5+jkInKy7ZIZr0vCkqBF1yXrA54ixteY+oxvtj8Ft9q8BSv?=
 =?us-ascii?Q?9mk9Ll1RQqY/V4NQz4IbO1PdO4HzdQgLKXAOaB76MYtHl/iKxDZvIFQPbjMO?=
 =?us-ascii?Q?q2oyc859pUDWqmlbrNsoxfeDsX/MZEyxTRjd1N0s/0V2pbHKZVWqk24Kzrhk?=
 =?us-ascii?Q?dP10Fhs385KUEJSvj2ErONFnMIvoiyVwRFMPf32rkrBp7mdlTucJCsTF1lVu?=
 =?us-ascii?Q?ZevAPh0K5U+CF1fOKxsk2S81QT/OWq8v00oRk+9HDOpLq0hfbNFYWQo4UmOG?=
 =?us-ascii?Q?wGWgKaR/AQW3ys4WPSVes2RM1GE7pubDmUn/Sd98JOs+r6rnpwaYDTxrNBEY?=
 =?us-ascii?Q?VTmy7ZXJYzvP+4tpGoATmQsLQc+dsnHy9D24/FyH+XOF0CE386Aif792K4UC?=
 =?us-ascii?Q?b5pjxXzs/J09tAHCLi6Ox2dq5rCrIf/SiwyBkQapb52NbuCBWPNIwdOiqGPV?=
 =?us-ascii?Q?nnFcK3Xit6BQ7F6K3bAnTlWW604RWSVdnK9NjbxcLNpRjkg8m1SnML4GuSrz?=
 =?us-ascii?Q?L/PwejMelzICRjnWVq/H/3Gy2MXmpxU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C9DDF514E0ABA74CA29FAEB469499FEC@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e66c6e73-8fb2-4f9c-1273-08da39a4ddfa
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2022 14:35:48.7763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: graejK7h6p0zlM+7DDh/pkFbmrjgpmScylhaQ1/RYoe/MYjM+hraVDZuvWxG5qgDn1zHfzwK6lYhCYFBmeTa9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1999
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-19_04:2022-05-19,2022-05-19 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 phishscore=0 suspectscore=0 mlxlogscore=679 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205190085
X-Proofpoint-GUID: yNVPGZve6BkWrPdw3Ruzb-6YYgVM3T7d
X-Proofpoint-ORIG-GUID: yNVPGZve6BkWrPdw3Ruzb-6YYgVM3T7d
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Guenter Roeck <linux@roeck-us.net> [220517 10:32]:

...
>=20
> Another bisect result, boot failures with nommu targets (arm:mps2-an385,
> m68k:mcf5208evb). Bisect log is the same for both.
...
> # first bad commit: [bd773a78705fb58eeadd80e5b31739df4c83c559] nommu: rem=
ove uses of VMA linked list

I cannot reproduce this on my side, even with that specific commit.  Can
you point me to the failure log, config file, etc?  Do you still see
this with the fixes I've sent recently?

Thanks,
Liam=
