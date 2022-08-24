Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19CC159FF70
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 18:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238657AbiHXQYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 12:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237076AbiHXQYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 12:24:49 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E4C1138;
        Wed, 24 Aug 2022 09:24:47 -0700 (PDT)
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27OGI7k6010864;
        Wed, 24 Aug 2022 16:24:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=GMbBZ3NNyTmW365D9ZbWGmYApa8GTvsTS0pPCMCISng=;
 b=n2oclNrWTAvHoxAFbELnpQm1jwyf+DC0Mfj2DeGp39KJi8bb6D9a8x8Zynh/6jUwQ78/
 z8esxZbziG3cCAh4If9mqL1eTzPpdw3Nbg5B2pGnB75LEHXu8YJL4RntQnLTUMq2L5TE
 pOGOUecKSZLPvfq8x+aUPBhNiKpp0ZH4vLLmKU+xNPWgs/HNKQJywsWQyo5XA2nSbfZT
 Yxpo+B++tcLiRQiBnxvaGJDFlYamwb2jqygxzeUZPJtrlwT0ANLrFU/9vNPv4JP+zf+s
 4uLnG1lm6NHljSjqv6zRIXdPJ/5gLY+c6xmTtpI7isi0OQa6GZGqBcg4C2ss9AX+To6R yw== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3j5qctg1r9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Aug 2022 16:24:38 +0000
Received: from p1wg14924.americas.hpqcorp.net (unknown [10.119.18.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id B51A0804CA9;
        Wed, 24 Aug 2022 16:24:37 +0000 (UTC)
Received: from p1wg14923.americas.hpqcorp.net (10.119.18.111) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 24 Aug 2022 04:24:37 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Wed, 24 Aug 2022 04:24:37 -1200
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 24 Aug 2022 04:24:37 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N0sOz4bA4qkBLkutaLz+l90kw6K+r9vlX1eUUW9rSWjCbbxWLtCTW9ac4qdAobuD/bKByP7yPsRBS6bkK4/QGgev+bNi8VBm+stbpc0gZ0SW/tsY8EOqG5PeAnLmyroJOrjFxH5z4hnBd1+myhatl9+tV25boSokuCUEn8hNIsPB1tPNlZNXj3wCvGx93M+g6YzPpAAO5QpD1Qz7ucQdc+9YWPYEJ8ZvoNJ2osVpXBSUMvVH/CaC9DXnHRU3uoxF10z88PMXvAOcKRTtgpp1lcMjvmb9PeCILvcU1DXGOmpaSiEWGzVDpf7vZWk4NMtxK4zU4q0uVU1eZB9JtEqKEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GMbBZ3NNyTmW365D9ZbWGmYApa8GTvsTS0pPCMCISng=;
 b=BgX0OxCuWPUsytc2TWAtI7jijFQ/qSp22KRxbxb4IW9vjiPqC9W0kkhOS8TaSAPYrSI1Sb83CIaCht184YxFCf+tLxit8mV82D/R3poSsHk9UCbOTkfSkt9+KaFoVJhYc0VlXAbE1TYmllAym2CBYKGLidvCkzyYT2kCgR2DwlSZp1Gs0oeE1mqLoC7SoWBazinVCgAfJkUR/NFGtAOPiQ2ftB6obB0x6fI0qTrUWwCFlXkdGdqzTjmXZ3LJqAkhYGBONKu1K4whnNUQcJWpHFgKTzwuMdqAZeEvtiEY1sH9ohNZl7ZR8LdH0tb+QVC6iYJss3TXn41rUeyNaj+qNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c4::18)
 by MW5PR84MB1716.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 24 Aug
 2022 16:24:36 +0000
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::1cc2:4b7b:f4c5:fbb4]) by MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::1cc2:4b7b:f4c5:fbb4%5]) with mapi id 15.20.5525.011; Wed, 24 Aug 2022
 16:24:36 +0000
From:   "Elliott, Robert (Servers)" <elliott@hpe.com>
To:     'Guanjun' <guanjun@linux.alibaba.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>
CC:     "zelin.deng@linux.alibaba.com" <zelin.deng@linux.alibaba.com>,
        "xuchun.shang@linux.alibaba.com" <xuchun.shang@linux.alibaba.com>,
        "artie.ding@linux.alibaba.com" <artie.ding@linux.alibaba.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 5/9] crypto/ycc: Add skcipher algorithm support
Thread-Topic: [PATCH v1 5/9] crypto/ycc: Add skcipher algorithm support
Thread-Index: AQHYt592LeYGvN6dxkWzbHNUpEGlNa2+OPpw
Date:   Wed, 24 Aug 2022 16:24:35 +0000
Message-ID: <MW5PR84MB1842B41754897B029B6949E5AB739@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
References: <1661334621-44413-1-git-send-email-guanjun@linux.alibaba.com>
 <1661334621-44413-6-git-send-email-guanjun@linux.alibaba.com>
In-Reply-To: <1661334621-44413-6-git-send-email-guanjun@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 742d481a-6c7b-4140-d99a-08da85ed2296
x-ms-traffictypediagnostic: MW5PR84MB1716:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xIuEDpUMTUGXQTQ1Z/6Sm6GGYrAF5zEs1uBgg9osHDFWMQojfnQflrRzCtE3jgb97z3H8MOwsSgtJU7J23ujmiIwPWr5eF1fKZOaQ7IfB7l8bdknExg69fVIuSzqE7c1W7NmkI+gc/l4Cf+qjZAUMqJRMvYa48npTjj71HecxSZlZ7bIWdMZoPBW8mmJWgSv5Q4206vJXkWWOjavk61VtCgKyAhwCDq6qwO8qdZOV3swpmfrZzP4or1DhmkrutThRVQUJ0/0H7dVfP6eouovzaFq6yS9jp/b+R2CZs/pIf83Z1nRf/I1V+IbV9EWc4XhOWSr6j5rf9tvVaCdwzbg5RzeXWV7YVCmmUiqgTns/ykPRSN3DUjCXcr7N0ZOXm+EQLmaMlUklP3qoXAScuvEpYx/BOJMLx94WYEL0T/OtfMzjlCQ12dQGHIoV1GLsV7aBNmB2yeXf315NE54eAoLsHdI4OgRCV7Q2Ug21y1YzFd8z6uOGi2CVjfXjc1OoLAmjfs52IrmAN/I+4yjM2yiJePMPlJcMb7mZmJtXYgsDlJhsVAO/XIFa/7tvXlev7A4eiagJzltry+yVei5ZEacRFfSN9UClglDd/DETSw2famyNHiBFUvjs5B2V501dNDrVxqdga+K9qZMV8n7LunZZEODjfx0/7so/NfaE8Qk90oY63tUGDCar+WEo4Jgd40OPC33In+Hd6zJKpbNmwArmblsbiFKrj+mYCT24SsvkdBC1fDPXO1LEFwLokBMOCSr9Tmnw4LGi23FNqDp2i2z7g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(396003)(39860400002)(136003)(366004)(7696005)(6506007)(71200400001)(53546011)(86362001)(478600001)(26005)(54906003)(110136005)(55016003)(9686003)(186003)(4744005)(76116006)(4326008)(66556008)(66446008)(64756008)(66476007)(8676002)(52536014)(122000001)(38100700002)(66946007)(83380400001)(38070700005)(316002)(41300700001)(5660300002)(2906002)(8936002)(82960400001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?o6IVN6eAzggXqwdfMHKrvow2GbJtimMzWd3g/hdTG9QBJhROBr9kIPorlMcs?=
 =?us-ascii?Q?4qt14AVOf42Z751kvi/nvtJzK+W5RdWFIm3UixntnebfObI1ZSi/Wwexp3YO?=
 =?us-ascii?Q?bUnNVafYXkXhPE8I3TMWfYLKMTn779eNGOfYvFcshnU69inojJjrIxhj4lFw?=
 =?us-ascii?Q?zfMlVQBvPtPB7ggtQTilI6JikaPa7KpZCyhh+ic5AXbt7YHTA0d/Fnf1H+cf?=
 =?us-ascii?Q?OL3rn3fLMYPGorxJ0hBF2zk5wvm5oh5NmxwDZZWOZbAaxNQwZ3itenvrHkgE?=
 =?us-ascii?Q?SUOO6gJ4eGC5Z/zcCVqhvtRF0b/n/aRgADD4AsasYb8H2QLdmihXS5x47diG?=
 =?us-ascii?Q?0kOe4mZCQfaUiyg6x8BshZj7mbwIiHFRpL7fW9dQV831/pS2WOSIl/2Z9GzR?=
 =?us-ascii?Q?ewSFtzZMvlTcTzjLG4VbMuY9boNjlfEfv74dJEZEUjjT1IWI8jElQdyFQ/Nl?=
 =?us-ascii?Q?GB3ncgcpZ1mx3GgpkctcTVcdujixvRM/m4g+yb7ZrOJSZk9EFDIWd+cp6zJ3?=
 =?us-ascii?Q?8N//5sbINwHWQBrhyoEMwZe/I7VCJFJCOuhkiYXo8JZ9bfVwFpvxikSXkoGM?=
 =?us-ascii?Q?XBwFtBvi6pfNfhB79YyBhrBTCpliLKaqRcSECRXAt6tl8ZyknyU2clsHprBt?=
 =?us-ascii?Q?Z1zk1ilQjlIgruywbHOO/YdO68V5KBDoi4pr4UgWj8V4tcvF5eSj/JzzF7Zc?=
 =?us-ascii?Q?CJKRg0tLUmtCuiFOdrG47I9EWTzYF5bHwcarrMh0Wdn52AG3txICTvF8LH24?=
 =?us-ascii?Q?z7BMPiBQU6KZ9L0wMdzEzQqSgJbZ3cFnemDALFpTquGYVE6/3KFLTZBxHzmS?=
 =?us-ascii?Q?VWWk7lJkoewCCUgGZbCd9rRbiYUwcVOrGNLVGT5pBo7hTcdq5GAGsq4yXpEw?=
 =?us-ascii?Q?mFsSCwf6PmvisZDrTqnqaownmr+EAMNeS3lvtoNpL6T6epZs82rhwAVZo/jo?=
 =?us-ascii?Q?iL0gVrAISUbgZFl/R50i8OpkM84fCvKh0kmRjf5MjDxkZPr2QoZemIY7XH75?=
 =?us-ascii?Q?1H5GzMplzRzrzFyz//U9eypWPOtTHhVUoNMRbtV/1bykBhMz5ZNXfXwajNPR?=
 =?us-ascii?Q?aoSdJpqN1yIvy54Fkf+ILIc9SqSQwEdscuPhgeblrQfQIxwcsOH/TLL9DyQP?=
 =?us-ascii?Q?DiO7oF03te0SIzGuUvzi1M5JcMORCw6ckb2KFYmvWzQJ1YBKA5FtGpDegZn6?=
 =?us-ascii?Q?5l/a0Fqm5gbD2r4D9+ex1JRYikXEkR/jgZwFxxM2dMUOzKM2pepIH0/xDLi8?=
 =?us-ascii?Q?tdi7zB3Ogi+T928iwvsxbgUTD+DH7MPPT676Co3GnGPDgc7ONOe7h8pl0akR?=
 =?us-ascii?Q?2isZ+lMDRjuP3aWdr1PdLbNCPvhWC4A2DBwsQzDPZulAd1+n7I3T7QWLAoqi?=
 =?us-ascii?Q?hCf78V5K5KpKd41V9nAZPUGQTl5+cJmxoyC+kJFFvtkpwB1W0CjuRj6Wqv5P?=
 =?us-ascii?Q?kHG+dmYJjwhGEPaIW2MWkw2E3jXtf9fhbJS1BZtnxbpduE3IE+Q7wxy1Vkc5?=
 =?us-ascii?Q?llQpUamTJNHgAR1nqj2RuFv2ncXI2vSQAeMckVifu+ca3LXALerrFe+Q5hiV?=
 =?us-ascii?Q?1Cc7kz4l4gU3qP0Oplo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 742d481a-6c7b-4140-d99a-08da85ed2296
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2022 16:24:35.9933
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DrX+z068LTJqxoZWrpxP3lLacCeDhhOF1HdT/7YDifihJ5e9ptUbzpxkobu3h4Fu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR84MB1716
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: z6TuYAqT4rigk7sxHR-QKHq9rS4GjaeA
X-Proofpoint-ORIG-GUID: z6TuYAqT4rigk7sxHR-QKHq9rS4GjaeA
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-24_09,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 mlxlogscore=909 clxscore=1015 impostorscore=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208240061
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: 'Guanjun' <guanjun@linux.alibaba.com>
> Sent: Wednesday, August 24, 2022 4:50 AM
> Subject: [PATCH v1 5/9] crypto/ycc: Add skcipher algorithm support
>=20
...

> +static struct skcipher_alg ycc_skciphers[] =3D {
> +	{
> +		.base =3D {
> +			.cra_name =3D "cbc(aes)",
> +			.cra_driver_name =3D "ycc_cbc(aes)",

In comparison, the aead driver puts the hardware driver name as a suffix,
not a prefix, and uses dashes rather than underscores and parenthesis:
> +			.cra_name =3D "gcm(aes)",
> +			.cra_driver_name =3D "gcm-aes-ycc",

and the pk driver uses a prefix with a dash:
> +		.cra_name =3D "rsa",
> +		.cra_driver_name =3D "ycc-rsa",

Although the existing drivers are wildly inconsistent, it would be nice
if this driver was at least consistent with itself. Suffixes with dashes
seem to be the most popular, so consider these formats:
  cbc-aes-ycc
  gcm-aes-ycc
  rsa-ycc


