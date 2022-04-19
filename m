Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8794507229
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 17:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354043AbiDSPyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 11:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235771AbiDSPx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 11:53:59 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A211DA6D
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 08:51:15 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23JFHrc9015013;
        Tue, 19 Apr 2022 15:51:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=fbcYcsGdx37m1YSSUSH9zWA01uOLKDwVV3zybB7Nrm0=;
 b=h2m0ollCAxE6VU29uUAxXphIDsNe0ywjtDL22K+/WVpduys+sopcuo4AaDoXcXPLyAV7
 FUN18O6H6ac+Vyrt+wm/WK31Sucv/XbfSCIj5S4TQvvJP0025wkMT9tzI7I21dDBa43g
 jFE7l50iJb1KZK9dln7C82GkF+5qCn164verqsvQRRx3RRP4610JUMJa2ZpCuep94vDs
 5XNiuRCvitdJoBH8Uakkxur5WPwVYXsp+l0BqjTDHD1n4wKuB2eStQVr2Q80B4dtFEHp
 /5RdLK8NYaaH5vzwR0gywsZI6V1SCuW7RxCu7NoTx4C4e41yLv/CSKuoV6XZPgNddGOO Pw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ffndtefp4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Apr 2022 15:51:05 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23JFk51g010974;
        Tue, 19 Apr 2022 15:51:05 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3ffm82mhsh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Apr 2022 15:51:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HxH2ZfAvGkw1KLGl6FOrevOvNvoyv7gYd1MCtZpY0DNveqpysl4vwPWzVCsP4L17PHcPjBX3u2FL92srGBMo6EgXgdMdElnQxRl2jf2iYtmR8HoavnMtfLNJ/o/iQDG7Q7DlbPJyrsVH6NcMgpmpRYKisR55g0Bv3hfrUw+ROd/2+HGkDgSb0Ng8mU0vMosg8p4N7XjBs+g9GYU9oqeUD/SAYCTHfeWCbk1i5fLokHQ5wcaYE8WITjoWwvPj1G9ATcQDSUgU962RgwhiAhaPWs1NwzSLRjmlmssk2euw946gC7zXGuqvmAEcQl16QeJkzIbFeI/w69hSBwS6h54sRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fbcYcsGdx37m1YSSUSH9zWA01uOLKDwVV3zybB7Nrm0=;
 b=fYQptUrhsx0n9c7nu5fdU2c9s6FWQPIV+uBxnHrh/1h6x9YTjvwu5wwpbjDgR3ZHbWBcHWSYM52qnSZmlhnWZokkYMtgIg6KDq2sfzMox7OXWb1A+QkxEOkbzyglxuAqqXvfvCzcsHZOxCE99a9H+CeOZtlwGsuKadUEh2rHCP72StXo2lYf4SgC7LD6kmEgOXGRNqATlpT+5plG2OnSNheizTwoWuGCDQHNR5hfuzu1XieaGs2n64rtBz3pGrxjXi2rDSknSimyr0KOgV8vTBF4Ed4gehMDICxaData9OWxnGBc5rq69YnJGIY32+FQO+0/xPdSkLmFRCZrCkrmzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fbcYcsGdx37m1YSSUSH9zWA01uOLKDwVV3zybB7Nrm0=;
 b=iGtVcRVVfdACrEV0m8i1N6NNK8pNZqxib/B+D3j/0xY3f7uCq4/TirgY4PQeIlZhXmHphI0//bihs1YMh13okfKAQX5v2Ffop1uDCE45jcjiGoecBpbMkzmOGVcAySZH1O+74dZqGo9CFnFh1x7ObIukpWP/n7GRgD3dFP31A3w=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MWHPR10MB2046.namprd10.prod.outlook.com (2603:10b6:300:10c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.25; Tue, 19 Apr
 2022 15:51:02 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5164.025; Tue, 19 Apr 2022
 15:51:02 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Yu Zhao <yuzhao@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 00/70] Introducing the Maple Tree
Thread-Topic: [PATCH v7 00/70] Introducing the Maple Tree
Thread-Index: AQHYSDE59w1vuFTbRUqY9YC4imYEkqzvB5KAgAB3GACAADJWgIAABQ6AgAAimYCAAMbngIABK32AgAA0VgCAALsBgIAARfaAgAR5x4A=
Date:   Tue, 19 Apr 2022 15:51:02 +0000
Message-ID: <20220419155055.qf52xpcftqb3r5nj@revolver>
References: <20220413235051.3a4eb7c86d31656c7aea250c@linux-foundation.org>
 <20220414135706.rcn7zr36s2hcd5re@revolver>
 <CAOUHufaw8tZrxuc6Sfxe+ES_MFHBqU_=O+X3b4rbYYrWYJRjkg@mail.gmail.com>
 <20220414171521.bgdvrirumd4atjhs@revolver>
 <20220414121911.8bb89fc3681b13af1566d79c@linux-foundation.org>
 <YlkaiUopM5HKWEdX@google.com> <20220416010259.4gbz5hgvm2lgr3sj@revolver>
 <CAOUHufZ8zPnpamkkpKK6KcSLTF91Eiba+S9VTX-ivhFrPQ_Cpw@mail.gmail.com>
 <20220416151923.ig5zavuptjsufm3d@revolver>
 <CAOUHufZewjQyMy1pHKxRkY82J5STPbUSJor7Q2aJgrkpZvU6bw@mail.gmail.com>
In-Reply-To: <CAOUHufZewjQyMy1pHKxRkY82J5STPbUSJor7Q2aJgrkpZvU6bw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fbf4702c-22c9-41b4-0ec0-08da221c6827
x-ms-traffictypediagnostic: MWHPR10MB2046:EE_
x-microsoft-antispam-prvs: <MWHPR10MB2046781EDEDF41BC33DD45B1FDF29@MWHPR10MB2046.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lm8ZkOxzNClyz0vSpFdjNm04JWs8dLVwpHCIzA/C4TWvrDsRT+ucf5+34duQ2CjTf2SzDoMlGITlMSbqhuzUP57bWd+TWsbdPWw8H0C8WbkNY/sntkRNRvpdL1mgNNL9ZivMDlHve/2Ifk9GwjpBx206dIbO65eNnCmsoCmOvmw0rThoDTUijSQ/y7qkEi0qy/z4tTe2nsax1RiNORY9AVrWHZj7ev8o42JOZMkbwIWu8UPTbMI1u/wiqYKpxlG1V75KF8DM6ohDfY+mM4kZlXJhwVozKhob/PzJuaUMu4A7LH9qHEtj5O8ncly1+1zKj3Atc6RJV76p9VEXrLBrobuIFCxUWmJigR3upeWQf5gEnqtyg7de644q7Cr2rIU4TULOx8T3eEN3y1KzFWV4dcMsbiUbAOusu9zyNnJOTGstmwqGGx892fBZBuoq1rQ86hi6hvcFF19f9S9IO4iE9nCxl7/wgGZWzWVreG0DPSA4vxS1mZI8EOWFGCTcquvJFXBQl+ANtEHyh+fNlAf1Y8uqDCyASrf2CzLj4ULQQ4mE1VPLwKFBEkFqIPHM69/Qu4CTaTih5K6OXUBEebfGXW93tF5LHa+O3gSmIu1w0uCW5yvu2bgU/L4qhViqbPFzyNhvLXm6gxifuhlzhGLEvuCy+Lycqu0ZDbGVY2P+M2mQuWKK5Vtny/RiI337zxddJ4CJXydIQDslRH2+7iftFg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(4744005)(6512007)(26005)(9686003)(6506007)(5660300002)(53546011)(54906003)(6916009)(1076003)(38100700002)(316002)(38070700005)(83380400001)(122000001)(33716001)(186003)(2906002)(8936002)(44832011)(508600001)(71200400001)(66556008)(66476007)(4326008)(8676002)(66446008)(64756008)(86362001)(66946007)(91956017)(6486002)(76116006)(99936003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EaoKTj8jkZJ70w+RYldD95V4OsU/SUxfuJflg1nRE9X7H96InilMUBzPNoIw?=
 =?us-ascii?Q?rGzk/YgSeDST8gslweLa/+l8dqptt0Z8jRAOz36xy4tif0ahBU78IppUaDFf?=
 =?us-ascii?Q?+Dx4+CcpYxQKp+T/ceLwHG9C/Z5A/6jzvMQ2XBoh+qa/4YKtGcgx8JLJUM1O?=
 =?us-ascii?Q?xzjzDRUiOdILdnd8KyoyTctMQ1DQcL2HVwL1fmmNb1m79K/UZyh3hG0893ka?=
 =?us-ascii?Q?ZHFEBGy9d9hS27LedlqTS7r6cmQnduMXPWllkdR0+JRN/VPhY+jUeG0gaJPr?=
 =?us-ascii?Q?bzYJVBllpw12YBsHzeccaQVvcqtKA+vEkdChgOlMiWr3nwu2/sUdRRfvsxRy?=
 =?us-ascii?Q?/okmdr6qgljNVsfnjqHWedjPK3doPVOw7Snx27q+CZM7LmaCuIipf25SC1Ep?=
 =?us-ascii?Q?ZQXBfSr85XhnahVO/u33s+BtrNkM7MJ3OysXiq4TRzbb0WSXtXIYFWo69573?=
 =?us-ascii?Q?SnBpQwstTadAYG3kv6tNVx8sRJ8fDcaHXXwmSbOC9F+FNbnTlUIUFW8YEjKq?=
 =?us-ascii?Q?Idqs43qr09kPDY0GKQ1wjETVaLD3oCwnHYJ5+oZ58vF/+EIJxfKjAtZjQCFf?=
 =?us-ascii?Q?Rqeq98JY9TM9SwKXh2G5TY+UYuq9mfkwWHQsFGx5N8H1DqY9fbFtWD6okGgR?=
 =?us-ascii?Q?70tfrUz+S+JN4JilBRhyVWGzpYkm6XQV/RPRF18PMN0qdImNRJLjuKDAcGDn?=
 =?us-ascii?Q?5IHNTEbTCBj9RSGjTmVeLIwANigUr/UQxwdGMaafCIhOHFa7FL3zVYyvEGH3?=
 =?us-ascii?Q?/ypcXGCN59EWKIWRUe3XdElyP0tNw98ULIwxBVRgmqShEVCcPPFfverv2J1P?=
 =?us-ascii?Q?tE/foWXnsfdxvT/Kj9ZVSyCuz5TIbB4IEBAykIl1LQtGa54QeLuOMQMMPD70?=
 =?us-ascii?Q?kqUm/gR30HXyqrp26qQUk2zV8XEObh+7uVS5WeVlcW5Jf0bsx53WsNAfFuhD?=
 =?us-ascii?Q?OcderpOWuR9PcNXwUSJvhxXXpqf03t4Or3p/dwyjPkN81EA4IPVXtoIEe3+X?=
 =?us-ascii?Q?Y3RdRe6A/LSfDMIiCTs+XO/yeb34Q91EhqhV7azJanR3RZBw5wVyYW3TamPO?=
 =?us-ascii?Q?4b/0BwmcfwtaQgQInkJ+kB2gMKJQhfUBD+PYazmQfwQDuARTmUCVa0c3ZDz2?=
 =?us-ascii?Q?NYVXAfn38trwtttNHubuGCxodT0kuxt+uUG/sscJHWe/IPT2/BvWPJxqb84U?=
 =?us-ascii?Q?VrhMAL3jnOSksKeIHx6QQu1HHVD8rwOzgCLemcTOSqk0FE/VFmaOX/uhf4PC?=
 =?us-ascii?Q?vUFgmXdRx06H8XxKUajlvwRya4zqPbKtIuMTvkQ6LR6qT5yeSAvB5qffRzvI?=
 =?us-ascii?Q?9gUn1q2d8errx9ty5KHXFLmd0rM1gFo4bGpd/6sTY4xTJ61P/t1pfAKtCOKB?=
 =?us-ascii?Q?jS6wg5XtCbx1zsTeUZnblN7oBNXtav7TGuQw9HD3XfOgmA1PITfEnOa7BCw9?=
 =?us-ascii?Q?Bocyt/SbNxYLE/4hB7/6WnFAXIzC/MFg0g4wEW4cZbHpp9vE6SgkEgGCTHMq?=
 =?us-ascii?Q?qhZYIsGfYBseikk5EQDdKjZwHx9k7k/gP+6GxenUeRpphmxTkG/Z9d7V9Kcn?=
 =?us-ascii?Q?qs1i5qwuUvXylFR1cnHTFPRjUdur+rrdbme+qD+f7+lYiOiZGV/DO0oQeE8W?=
 =?us-ascii?Q?QPA2YWi/bMKt7Ark31i52aPMR0kmuuuX2zEEt0rMrfPFkptr5/v6HQx3eWK2?=
 =?us-ascii?Q?jYCpfSkdM186HZIajM2FstrUuWofXFJUYo8uTkWZmf4SRg0ad+0Aud+0n1v1?=
 =?us-ascii?Q?Dw8ZjABGbRN+w9496wFTnVHEYHYPQAo=3D?=
Content-Type: multipart/mixed;
        boundary="_002_20220419155055qf52xpcftqb3r5njrevolver_"
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbf4702c-22c9-41b4-0ec0-08da221c6827
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2022 15:51:02.7540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tXwqnqwW+7ajPYPyYPBQpNYJwijnT753dk4iypeqOAWQXa/cutxq+LaYIQz5AM9ErfacZVHcbEViMj6hfS/UQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB2046
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-19_05:2022-04-15,2022-04-19 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204190090
X-Proofpoint-ORIG-GUID: D6-qLNFQVnQv1zxF9e8X79my5QwFqroX
X-Proofpoint-GUID: D6-qLNFQVnQv1zxF9e8X79my5QwFqroX
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--_002_20220419155055qf52xpcftqb3r5njrevolver_
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C120519E5A56D14DABEE5FDF793FD1E3@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable

* Yu Zhao <yuzhao@google.com> [220416 15:30]:
> On Sat, Apr 16, 2022 at 9:19 AM Liam Howlett <liam.howlett@oracle.com> wr=
ote:
> >
>=20
> <snipped>
>=20
> > How did you hit this issue?  Just on boot?
>=20
> I was hoping this is known to you or you have something I can verify for =
you.


Thanks, yes.  I believe that both crashes are the same root cause.  The
cause is that I was not cleaning up after the kmem bulk allocation
failure on my side.  Please test with this patch.

Thanks,
Liam



--_002_20220419155055qf52xpcftqb3r5njrevolver_
Content-Type: text/x-diff;
	name="0001-maple_tree-Clean-up-after-bulk-allocation-failure-in.patch"
Content-Description: 
 0001-maple_tree-Clean-up-after-bulk-allocation-failure-in.patch
Content-Disposition: attachment;
	filename="0001-maple_tree-Clean-up-after-bulk-allocation-failure-in.patch";
	size=2355; creation-date="Tue, 19 Apr 2022 15:51:02 GMT";
	modification-date="Tue, 19 Apr 2022 15:51:02 GMT"
Content-ID: <74F1DA3C52258649AFC056800150B482@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64

RnJvbSAxNDY5ZWNjOGM5ZWY2NjIwNjZlNTNkNGE0YTAwYzg0ZDk0ZWU5ZGM0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogIkxpYW0gUi4gSG93bGV0dCIgPExpYW0uSG93bGV0dEBvcmFj
bGUuY29tPg0KRGF0ZTogVHVlLCAxOSBBcHIgMjAyMiAxMTo0NzoxNSAtMDQwMA0KU3ViamVjdDog
W1BBVENIXSBtYXBsZV90cmVlOiBDbGVhbiB1cCBhZnRlciBidWxrIGFsbG9jYXRpb24gZmFpbHVy
ZSBpbg0KIG1hc19hbGxvY19ub2RlcygpDQoNClNpZ25lZC1vZmYtYnk6IExpYW0gUi4gSG93bGV0
dCA8TGlhbS5Ib3dsZXR0QG9yYWNsZS5jb20+DQotLS0NCiBsaWIvbWFwbGVfdHJlZS5jIHwgMjIg
KysrKysrKysrKysrKystLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCsp
LCA4IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvbGliL21hcGxlX3RyZWUuYyBiL2xpYi9t
YXBsZV90cmVlLmMNCmluZGV4IDYzOTNiZTlkOTIzMC4uM2M3OGU2M2VmYWVjIDEwMDY0NA0KLS0t
IGEvbGliL21hcGxlX3RyZWUuYw0KKysrIGIvbGliL21hcGxlX3RyZWUuYw0KQEAgLTEyMDYsNiAr
MTIwNiw4IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBtYXNfYWxsb2Nfbm9kZXMoc3RydWN0IG1hX3N0
YXRlICptYXMsIGdmcF90IGdmcCkNCiAJdW5zaWduZWQgbG9uZyBzdWNjZXNzID0gYWxsb2NhdGVk
Ow0KIAl1bnNpZ25lZCBpbnQgcmVxdWVzdGVkID0gbWFzX2FsbG9jX3JlcShtYXMpOw0KIAl1bnNp
Z25lZCBpbnQgY291bnQ7DQorCXZvaWQgKipzbG90cyA9IE5VTEw7DQorCXVuc2lnbmVkIGludCBt
YXhfcmVxID0gMDsNCiANCiAJaWYgKCFyZXF1ZXN0ZWQpDQogCQlyZXR1cm47DQpAQCAtMTIxNCw3
ICsxMjE2LDcgQEAgc3RhdGljIGlubGluZSB2b2lkIG1hc19hbGxvY19ub2RlcyhzdHJ1Y3QgbWFf
c3RhdGUgKm1hcywgZ2ZwX3QgZ2ZwKQ0KIAlpZiAoIWFsbG9jYXRlZCB8fCBtYXMtPmFsbG9jLT5u
b2RlX2NvdW50ID09IE1BUExFX0FMTE9DX1NMT1RTIC0gMSkgew0KIAkJbm9kZSA9IChzdHJ1Y3Qg
bWFwbGVfYWxsb2MgKiltdF9hbGxvY19vbmUoZ2ZwKTsNCiAJCWlmICghbm9kZSkNCi0JCQlnb3Rv
IG5vbWVtOw0KKwkJCWdvdG8gbm9tZW1fb25lOw0KIA0KIAkJaWYgKGFsbG9jYXRlZCkNCiAJCQlu
b2RlLT5zbG90WzBdID0gbWFzLT5hbGxvYzsNCkBAIC0xMjI2LDIwICsxMjI4LDIwIEBAIHN0YXRp
YyBpbmxpbmUgdm9pZCBtYXNfYWxsb2Nfbm9kZXMoc3RydWN0IG1hX3N0YXRlICptYXMsIGdmcF90
IGdmcCkNCiANCiAJbm9kZSA9IG1hcy0+YWxsb2M7DQogCXdoaWxlIChyZXF1ZXN0ZWQpIHsNCi0J
CXZvaWQgKipzbG90cyA9ICh2b2lkICoqKSZub2RlLT5zbG90Ow0KLQkJdW5zaWduZWQgaW50IG1h
eF9yZXEgPSBNQVBMRV9OT0RFX1NMT1RTIC0gMTsNCi0NCisJCW1heF9yZXEgPSBNQVBMRV9OT0RF
X1NMT1RTIC0gMTsNCiAJCWlmIChub2RlLT5zbG90WzBdKSB7DQogCQkJdW5zaWduZWQgaW50IG9m
ZnNldCA9IG5vZGUtPm5vZGVfY291bnQgKyAxOw0KIA0KIAkJCXNsb3RzID0gKHZvaWQgKiopJm5v
ZGUtPnNsb3Rbb2Zmc2V0XTsNCiAJCQltYXhfcmVxIC09IG9mZnNldDsNCisJCX0gZWxzZSB7DQor
CQkJc2xvdHMgPSAodm9pZCAqKikmbm9kZS0+c2xvdDsNCiAJCX0NCiANCi0JCWNvdW50ID0gbXRf
YWxsb2NfYnVsayhnZnAsIG1pbihyZXF1ZXN0ZWQsIG1heF9yZXEpLA0KLQkJCQkgICAgICBzbG90
cyk7DQorCQltYXhfcmVxID0gbWluKHJlcXVlc3RlZCwgbWF4X3JlcSk7DQorCQljb3VudCA9IG10
X2FsbG9jX2J1bGsoZ2ZwLCBtYXhfcmVxLCBzbG90cyk7DQogCQlpZiAoIWNvdW50KQ0KLQkJCWdv
dG8gbm9tZW07DQorCQkJZ290byBub21lbV9idWxrOw0KIA0KIAkJbm9kZS0+bm9kZV9jb3VudCAr
PSBjb3VudDsNCiAJCS8qIHplcm8gaW5kZXhlZC4gKi8NCkBAIC0xMjUzLDcgKzEyNTUsMTEgQEAg
c3RhdGljIGlubGluZSB2b2lkIG1hc19hbGxvY19ub2RlcyhzdHJ1Y3QgbWFfc3RhdGUgKm1hcywg
Z2ZwX3QgZ2ZwKQ0KIAl9DQogCW1hcy0+YWxsb2MtPnRvdGFsID0gc3VjY2VzczsNCiAJcmV0dXJu
Ow0KLW5vbWVtOg0KKw0KK25vbWVtX2J1bGs6DQorCS8qIENsZWFuIHVwIHBvdGVudGlhbCBmcmVl
ZCBhbGxvY2F0aW9ucyBvbiBidWxrIGZhaWx1cmUgKi8NCisJbWVtc2V0KHNsb3RzLCAwLCBtYXhf
cmVxICogc2l6ZW9mKHVuc2lnbmVkIGxvbmcpKTsNCitub21lbV9vbmU6DQogCW1hc19zZXRfYWxs
b2NfcmVxKG1hcywgcmVxdWVzdGVkKTsNCiAJaWYgKG1hcy0+YWxsb2MgJiYgISgoKHVuc2lnbmVk
IGxvbmcpbWFzLT5hbGxvYyAmIDB4MSkpKQ0KIAkJbWFzLT5hbGxvYy0+dG90YWwgPSBzdWNjZXNz
Ow0KLS0gDQoyLjM0LjENCg0K

--_002_20220419155055qf52xpcftqb3r5njrevolver_--
