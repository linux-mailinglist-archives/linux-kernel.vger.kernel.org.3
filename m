Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0347359AA74
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 03:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244345AbiHTBYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 21:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbiHTBYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 21:24:05 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D8B481C1;
        Fri, 19 Aug 2022 18:24:04 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27K1HPtG005160;
        Sat, 20 Aug 2022 01:23:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=28zxGg6Ec1jP/EGHMi+1N7+b7cVLBdqKokb5G0Vo6qc=;
 b=MbeYkUOLVKttQeCos32djRdjz9nF2G4vzrtx6kOQEbV8Kq1V7rRPwL4zu+bYLMbarwn1
 jynE/2N89yPfluIGR0tnji9Pgbvn6TUWpq5Gv+ak2SB0ChcfMxuuYQ9m9tYXJgbLNbeC
 6yaOjFNpuBV9KO5r44ZVuzuzdzK8866gGCmOMC+EIrACDOyLHQmN6zQtKFHTM/WRkVbs
 2g22sWg+ZV75RgDp8Y2heZoHh8dq/DA3bVEJ8vOUSxmuMEKTtZRrS3BGsYktOC7bWWF1
 Uj5Qzi1aDr8aOWGcFzIgsM0wp3XFEDIxoY3HGJ9QPFHdBSayAe35ZWMz9nZ55ydUGQMC pg== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j29w99w0a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 20 Aug 2022 01:23:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WjolTWCbRmmSKy2MdxNNvtTzFmywLDfYbyzK2ctiSdy91aYCd6cW2uoZdvunEqUyUlgKAhN2hjWkIXjvMzkix5+OYnq2YDSqvL9Dtp5BNUbCU7EcpGenIPYiamRXlDz4SsUK9n2Zc4PH3i2PoWyRRrD2wU06XrRFgD2a+8X7LFLAVcw236FQD3jQc3RMeOyZaX7TcbuVWdDn5354VsyvTK8y0Yhbn/A8gbr97QZ0jpRAfmiKQwT67/Y+4LebdhoFVe3pQabwUnosnxHQ7ufgCz4usi2Ulfs9JtAEDm7OfKqqMKGOOrV5IRpt/eH4wO2BzbmsQSDCvEmGrBj4dHsahw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=28zxGg6Ec1jP/EGHMi+1N7+b7cVLBdqKokb5G0Vo6qc=;
 b=QwgQg5S/NGGDFsXi0OdNWmig9qok/tFy/7KIys56ue9jfTscFGEigqUFrz4A8+Lp5r0JoOyED6cFaRyOZqxe22QvlzffhJkAWxMAEWajHzGGBfc3ytUtCHWAYGRlMoXNKFmBAPwCyU6VV6ol21nAlJ0dQU0FZv8t7skCPbGwXc6B72HB3QLLENRqMf6TWasi+BXg7UZWK8No7ShVOWTUZraNXcMwdYVUp7qMX5qlFGsyTY1fTKNT+6pWCGKG1dls2RX6efELpcr7iA9X09wLFbV1DJrHkUGRLVcaEs5kN+s+Oy1gBkBjZvK7vh/JJ9ap1sQYZ4EY8VAmt/T0Nu98ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SN6PR02MB4205.namprd02.prod.outlook.com (2603:10b6:805:35::17)
 by CY4PR02MB3349.namprd02.prod.outlook.com (2603:10b6:910:77::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Sat, 20 Aug
 2022 01:23:41 +0000
Received: from SN6PR02MB4205.namprd02.prod.outlook.com
 ([fe80::41a6:c2ff:ba0d:16ac]) by SN6PR02MB4205.namprd02.prod.outlook.com
 ([fe80::41a6:c2ff:ba0d:16ac%7]) with mapi id 15.20.5525.010; Sat, 20 Aug 2022
 01:23:41 +0000
From:   Brian Cain <bcain@quicinc.com>
To:     Baoquan He <bhe@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>
Subject: RE: [PATCH v2 05/11] hexagon: mm: Convert to GENERIC_IOREMAP
Thread-Topic: [PATCH v2 05/11] hexagon: mm: Convert to GENERIC_IOREMAP
Thread-Index: AQHYtCxIA7Q6PMhD9EKVwHth6is6Q622/lCg
Date:   Sat, 20 Aug 2022 01:23:41 +0000
Message-ID: <SN6PR02MB4205F782AC9A36E5CC5EBB0CB86F9@SN6PR02MB4205.namprd02.prod.outlook.com>
References: <20220820003125.353570-1-bhe@redhat.com>
 <20220820003125.353570-6-bhe@redhat.com>
In-Reply-To: <20220820003125.353570-6-bhe@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 82e1851e-c7ee-4ff9-d437-08da824a9e0a
x-ms-traffictypediagnostic: CY4PR02MB3349:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t+TP8cdJSyuhi1yvsQxwFYXEWPN86gFBk8ViZntpylSesm/4Z7EW5QoyAXkUXN4iQmqVNXFCMJaxMFFAvJP3MTl7wpMvc2jn8kb8gsaXn5jc7g1JB7IahwCTjbprUdQXvD6Zr2CfbByUTsBjYq6IYjodYPmUdZ8umGFIFob5qJP5SSUnhjA7F5qNumeriM5lM3UG7BusRR2/Dnz9ALYanSDtinha1gwlGaDPD38hjUbQxprvpDqTLsrgFemuOevgwm4OIDrld/f1B4iRGPepMB2MF250ZRhNTXJPE1FA0S3IcwFXV9toLI8Z72KkKx89SbUaMq6H20Ydv1gF0UavjJhH5Ax4NRmJojOwjuFWmYgsPa9PnYif127DodbeWTGyzn+++xcWlSYa2QRigwGPmqdH4cTzG2+QpBF5ZoxjTf2yW6TA9ikRLGZ77yBVd6ABZxeUyGFfwn6OIjqqHoG+hC2ZEdhbqe7fM2kVQ77xchO4qnX0is9lm1Ku4EbY+qWzmM5Jk3AOvCxOOKSr+6IZM2Ayi2PnC9rmAG32u59Avad6jID8l9iIeUcNwYR1hbefbY4bTYrOyQXE/CXrvJNbHrKdAhG3itOl1rghZB7gZrI1IWjLtCMw33z60eaOCvWTFgYBtOF6S1VHl/JwAm+WMtCUJ5pb/xInnssDJ1RzMLjfE00I+DfPbqTbg6Rd0aHAUDFvzSvEz9YHj02C97vPMEqbwstOv/cI4hmVv9dxrJEjS0WOPzJvzNeiT+G68aysh3//lH8LyHiklNgL85rQWkfPC0PAyF7cfOumbiOGZOk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR02MB4205.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(33656002)(64756008)(4326008)(86362001)(38100700002)(76116006)(316002)(8676002)(38070700005)(54906003)(66556008)(71200400001)(66446008)(186003)(66946007)(66476007)(5660300002)(2906002)(41300700001)(8936002)(6506007)(7696005)(55016003)(478600001)(9686003)(26005)(558084003)(83380400001)(122000001)(52536014)(110136005)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RDZA1YhvJO4djn9FTnDDtILJl3Gl8zWcbybk/szmTOEhZVRLasopg76OwnvR?=
 =?us-ascii?Q?+tM3ZKxAJLE4hi+4lwMTvUAU5myLiwkfU3Wyxa12zWn0TFJ/Tc4suaZEwecV?=
 =?us-ascii?Q?VGmjUhYgI+6VpHhP655170gl832PV5GMPn7Ic1SvYBzttcg1nLOAVg+SLdmR?=
 =?us-ascii?Q?JwsqgDVooy/CrWTZyp1P5t+6laBuCDC3Gpi4UBVkavByYrp0De2gUbuGy+wY?=
 =?us-ascii?Q?xoWAdx2xC6YA+XHWjl/xgSra9j1iNFH+jrAVVG8kutEmOquiA0UVz8ykwijB?=
 =?us-ascii?Q?ayYz+Gj1AfwpyfcBvUZOMNzIwLA4n489YR7pvRbIxKACDKNrokNk1cjcAQx9?=
 =?us-ascii?Q?HSdsOe0gfAF168bis9yOIeZipNukLkrYum/wdZumUk7F01Y066/9MqivoGcX?=
 =?us-ascii?Q?SWbTJfFkEMt55sKB6DdfEcNtYHx+XhB8GPTmYn0HnFgOTPZ7DkWYRzf2iyAX?=
 =?us-ascii?Q?LPgmL+ZK0lEj90EFgrCZlVG5fOeJ1Z8m1R1BcqJFjTsryGQtnrbdFsvrFlhs?=
 =?us-ascii?Q?cNC3SOt+Fp6VweRMncAVowRkIV+xttW3FP5OMkcEnRtQCKWsAC/sx3dqrvtb?=
 =?us-ascii?Q?vGxIV94q4oXSIWU7jkxb3mn19dhjAEJdUBi0FSJsQ4o7Tu/ee0ff5PAIeZiI?=
 =?us-ascii?Q?OxD8Mxa0QJhEyYZvUu1aShWSbw5jViatwCz3wlqzhWp0qgcEY6vqrfNehXF2?=
 =?us-ascii?Q?WxvN+3AKsOdlV61fghpAOL1VsuKQopTGUDKqDzqChL6LaS6Gv0mSlt7XzYMr?=
 =?us-ascii?Q?MS0kMKbmvepuVRxtnaF0e7avf2DMABN10wlYTqp8zv5469Q0cGUNjJwP2ZAx?=
 =?us-ascii?Q?JqC+khlN/LJOfjgDgNTEf7sbZFECRWQFA1TeiYCrpnVX20svcn17y7uwjB6J?=
 =?us-ascii?Q?0BGvFablhAA2ipIRyNdXyLwUp+p7bG64Eb0OEV/+eGPyLe4W06lMmOuAua1U?=
 =?us-ascii?Q?H5JydgeoUUXzvcir1+wKsIPxI1hc6Vagj03zJDoE7Rv/Muhmv78lfrCpxEs5?=
 =?us-ascii?Q?oN3SiFZRHW3ZRr0k3sY870C8mg1fwnc7fQUwBnNjliS3yAMw13xuSLBlWqm9?=
 =?us-ascii?Q?QBn2JJDWRpBD2uqK5bnmcyHDlmzQYO/nn3wbOQuVrfnKlkK6t2EvYAbgF+Ss?=
 =?us-ascii?Q?wWrmjnYSaHhO9BQvlMv57+pSkMZYzsUY0wa4FeSx0f1iTCUURxbY/wkaRBoc?=
 =?us-ascii?Q?7nPeRcD/OaWICCIF3QwAyuyPeuMBqxhRKh839RSp6e6L9kVDpCtVsF/7eFpb?=
 =?us-ascii?Q?sVvL8XqgkDYgeY4kLXl4Iq3FEJskspzjVgtY80FGdvoZSFbQXuBrk0hJ3xeq?=
 =?us-ascii?Q?uGfu5bLTdTOrto5DZDriMnaunLES9d4ocMTuG1MN1X3O2WJlDhAQIzE6j8wn?=
 =?us-ascii?Q?1y3M4m4DritouDSc/G8DYWKyt5kCCRRCpOUqeByneSMVn5xt0tZ0NrxaS/gX?=
 =?us-ascii?Q?bT0VpTCQVB15pT5vuOOKR6lI4CXHEpbebYc0VU6ox29FFhKh5A1JNz+n+Nrs?=
 =?us-ascii?Q?8F4Ju48Qgeeu+J92NIz1D6cbnehWL00KcOTrLC4dj78UclZdq6Q3KFNnweDl?=
 =?us-ascii?Q?/TWs3bH4oZZ+p2x3ewEg799jFfvAvW1G6WPfQGQV?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?sY2877qE3/HcMSs04AFEV2dQF30j8C2cxstDsMEcp9on+aE81mLiZDx6gdTs?=
 =?us-ascii?Q?HIID99xsCyflB5QUdTo9/HUMeSTZsmSQz5gXnB7N5JGx2Un4D+NdbvS1gLs7?=
 =?us-ascii?Q?ZzrvJ4irRa31y91daWHixbfpA6fgrgg1ENnkIyNEEeG5EtYR3rTiAGqdrkbI?=
 =?us-ascii?Q?qMmZryF61V7CCqKCzui+r5MgFF7CF8DF4Hx4RMYl5gotSxx/8z3Eq0eBKsdK?=
 =?us-ascii?Q?us12xD1Mwpr3cKaItyFf/ljTe1H2bQ39fBOG7mNWdchDoG9XGmkwsgi95eNO?=
 =?us-ascii?Q?X1zz5hW2RLgA0Cuu5fIIAdY4XQacZqSCMT9g3Buw7zPXgpqu/fV5cAPF/F85?=
 =?us-ascii?Q?CNTwy8nRHGJWtxruuYPzfB1JBTbew2aPBg5gzdXNdfPkJJSYkItp2zgJgX5q?=
 =?us-ascii?Q?bPYnjLIrRYNAEdSuA2j0ChYatDLZo4MjsnS21AsqAnMNGFgbIOMJ4ngBPtPw?=
 =?us-ascii?Q?0r5qhyQT4FpqmokUIim2Yi4o3yMJPnKnnnSRJFJsxufcqxb9+2hTRmly1293?=
 =?us-ascii?Q?OB0oMHH4OzB/3puxg9Yq63hxUfUj8bsv8rpouuqAGPNOnXHPijJAHuxSInOY?=
 =?us-ascii?Q?0OvwMMLyF0ZkA5Ea8sOK81EmRc+m1FvnFKt4FcV7HrsrSAXZgHM0BO2I4bOV?=
 =?us-ascii?Q?ncwdimeVixFtcNhUGunH7iOpZs+jg4yMd4/y6gVBmncyTiD4/GX79H8E3jia?=
 =?us-ascii?Q?G9TlOgOTLxU8oB1zth7NOytUtiMVbO4hoGGT97iftXC3fW0Mi9sG/N4CS/yX?=
 =?us-ascii?Q?yhho/lb8Zt0kte0dCh3CJv+nhVt4c3hG2JeufqB5bBxu3Hc/NexpmZ9B7dFH?=
 =?us-ascii?Q?yPjvMVgzBMbVdoQ0ZTZjFQixccFiRaY6jnGZ+OlCqc9nS7EplGVAhpMH9x8B?=
 =?us-ascii?Q?55U/9NKB/VWMFfL/nK5xkiCnPWYsC1tWteIjFJHOoBOr+aMUIrk/JVxtE5aw?=
 =?us-ascii?Q?sgJUn4vIWJqHQT9weQv+vQekXfSaYc7c4XrOJMZqJ/CyccMO8NqF4oVIrswi?=
 =?us-ascii?Q?Pue9BKjXQR7HJR+wozpERNdPionK5U8NoC0Z+Qb60zyTlD1hZspehJlTYLtn?=
 =?us-ascii?Q?kfyySDRtOP/AhVJuErYMw4OmQnF2DxGGaTi9WQd/Tl8TIqBmdjQDNkCz08Qw?=
 =?us-ascii?Q?R0zSWUMkQx7PzbXTisXJ25YvS8FSnlgS47JdnEbtMoa9WKHwqomnplqEs3rA?=
 =?us-ascii?Q?B0+Dxb3mxuXSuncZZEa+LveiuNlfzY/T/QvL6HaysXwFfGOhVljSQ4fgfxV+?=
 =?us-ascii?Q?1Veai5+/WRR3MawlZ7XA?=
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4205.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82e1851e-c7ee-4ff9-d437-08da824a9e0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2022 01:23:41.6578
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8FsHq+KFhq7XoEcmJfT508uf1JyEpTfDlY4fmqhb67A8JoA0HXkkNVODKoiCb5cpnkBB6d8aImwuqwgqdTxYzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB3349
X-Proofpoint-GUID: tqo6Vrc1n_dMr36mKB4COpe2BBcfPhKH
X-Proofpoint-ORIG-GUID: tqo6Vrc1n_dMr36mKB4COpe2BBcfPhKH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-19_13,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 mlxlogscore=508 phishscore=0
 suspectscore=0 clxscore=1011 mlxscore=0 spamscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208200004
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Baoquan He <bhe@redhat.com>
...
> With it, the old ioremap() and iounmap() can be perfectly removed
> since they are duplicated with the standard functions.
>=20
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Cc: Brian Cain <bcain@quicinc.com>
> Cc: linux-hexagon@vger.kernel.org
> ---

Acked-by: Brian Cain <bcain@quicinc.com>
