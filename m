Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 129C84DBA31
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 22:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358187AbiCPVe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 17:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245675AbiCPVez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 17:34:55 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A48F17A99;
        Wed, 16 Mar 2022 14:33:39 -0700 (PDT)
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22GLKf3N018208;
        Wed, 16 Mar 2022 21:33:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=8L+MQUD5FouCvzVFzKKcrj2HfCJI7cTYwKDh3vDs/F0=;
 b=F6T4sKMIdCxiOXY8obMYpZPbpmlFVeXVP5JSjxcLpSkF7Mdg516EUWMwinTIwQUPddEj
 AIu6wMnn9Ol1CUsoJjr+WrMggS+WSTcLuefJX+g4BeXynCQCXS2umw7jBkc1p1gIYbJx
 uxp6CsDWOMDOmVClYFxx1KIrIvJWfpR5yrAxFrugmVQKcjVDea4kPYHdvz+dRavyBYl8
 JeueCHpfKImnoNoMWU1DtwUbFQ6lrp/j8R4QHGZbsAAs/Q8PTpMZp0E5OzPH9i12nlIB
 Rj9ngBOlAB/HiVLYesNIWPUS4/iduw6fTJPsZ9ID37YjKbG/tEH/zsS4Zxeq/k8m71G0 kQ== 
Received: from g4t3427.houston.hpe.com (g4t3427.houston.hpe.com [15.241.140.73])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3euqq1g3hk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Mar 2022 21:33:28 +0000
Received: from G1W8106.americas.hpqcorp.net (g1w8106.austin.hp.com [16.193.72.61])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g4t3427.houston.hpe.com (Postfix) with ESMTPS id AF2495E;
        Wed, 16 Mar 2022 21:33:27 +0000 (UTC)
Received: from G4W9332.americas.hpqcorp.net (16.208.32.118) by
 G1W8106.americas.hpqcorp.net (16.193.72.61) with Microsoft SMTP Server (TLS)
 id 15.0.1497.23; Wed, 16 Mar 2022 21:33:27 +0000
Received: from G9W9210.americas.hpqcorp.net (2002:10dc:429b::10dc:429b) by
 G4W9332.americas.hpqcorp.net (2002:10d0:2076::10d0:2076) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Wed, 16 Mar 2022 21:33:27 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (15.241.52.12) by
 G9W9210.americas.hpqcorp.net (16.220.66.155) with Microsoft SMTP Server (TLS)
 id 15.0.1497.23 via Frontend Transport; Wed, 16 Mar 2022 21:33:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Smy6MV86aIX7pb6Z06yE4ZledNoRHcXfbIB0NXRV1QUf9t05JrMcUN8/quUquMo39dXJBqzkj1THsoispkY07txRz9gPe3XtHMsk1XWX01s4PFJdOw78WIdBCayw1FakbLWIK1vVZ2Inic+/ckKAcy6M7o1tO4yovDpA3+vEksqP8vY0aukFFTcoKkAIInQOwJfs2tO1O3dRrcQ6oVt2fWb+YQl0A8yqt/hZknkpoxAa/fm6PPjMDgKhct7M1i5EGTL3yrgdUDoGvfGaz/lva9KwhazYQJE3QdCqJvsl7wEj0VmKCGGYCxPuOdfgQwV7lqD9B5w4O72Z7wp6YJLW4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mc41fq7l7e5jhhzHb9Xs1kVcHXzL8MJnKMN4R29iKdM=;
 b=KSBuGKHSm1r9QhwqD0Gex2o9X5wpExu1ELg5qOWIjlmcsUEVoe8zZiivnQec3eCGRAnNplBKxmQJHoM0AuUy+1TKcSMQnMhJ7RMrMipsMugRLuXdGa7jo9a//FGRhw1mNPmKB9URboPg/2Oaagsh/5Da6uecsVYR4Y8WTzBKqbXEl2/LSGxde8oWCkp6k8E0kSVUIPqIRS+YI8TXywK9bygMa9M5vKk7nw0DLE78eKjH8Y+qpnJDZhG2S5ic+wRTwv6MGBdXXRm7Ag2wZ984vwwWPrWN3oe6P3X40MG3S/x+PLRYK1LgK5P5j/+l50Tz1WuSmNQ5wyadkUpgizwxpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:172::21)
 by DM4PR84MB1854.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4d::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5061.26; Wed, 16 Mar 2022 21:33:24 +0000
Received: from PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::e40c:dff1:1884:c484]) by PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::e40c:dff1:1884:c484%8]) with mapi id 15.20.5081.014; Wed, 16 Mar 2022
 21:33:24 +0000
From:   "Hawkins, Nick" <nick.hawkins@hpe.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "Verdun, Jean-Marie" <verdun@hpe.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 08/10] dt-bindings: arm: Add HPE GXP CPU Init
Thread-Topic: [PATCH v3 08/10] dt-bindings: arm: Add HPE GXP CPU Init
Thread-Index: AQHYNLgmgjlRp98tMUex3hJRm/r4lKy5+liAgAiWMPA=
Date:   Wed, 16 Mar 2022 21:33:24 +0000
Message-ID: <PH0PR84MB1718FF3B171B631A4B8DBAD688119@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220310195229.109477-1-nick.hawkins@hpe.com>
 <20220310195229.109477-8-nick.hawkins@hpe.com>
 <679cb1a3-28fb-7031-ecc7-5f60266bcf7c@canonical.com>
In-Reply-To: <679cb1a3-28fb-7031-ecc7-5f60266bcf7c@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2133f7aa-bcba-4202-5ae4-08da07949a28
x-ms-traffictypediagnostic: DM4PR84MB1854:EE_
x-microsoft-antispam-prvs: <DM4PR84MB18548533AC2B9656204E0D1888119@DM4PR84MB1854.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gxmi5XZ9tnsOGEeEji4JA1U7Oz0WhLDwzFJDIQwX9bPIS1tBSVfX1GC6rGhiYYvQv3kbVjGX/mMfXSIXeC7wtmcxEw/v3dyspvalBysc+/i589rBsZUwU5UIU2p0HTHrwcrnu2pS/GnkjDjGyeli1EGAPLK8A4hOlF5jjQkvnuYcxxzcUb6vvCqgmu2Z8PJfNodR2dKDH2xNxj+YdLka81LACuFSGTJwCsY6QjorLWUAgCozCz2XkSF3WO/DvgbtuxDhK9A0G9XYpeje+qt/dGx/4sLgg/ygggzOyTOiL2LuadxR0UvwX+jHSb5TSvVnVZTVgp40gJmc9tW0kE2SAzhxiic+YW/7hBz1i2BtFhjL4khKuulBK2JrTW5lT0cHdIXQYm0TL2mxotBe0p81bGJzbRXUyvA6kfjoPksDp0ibI6R6hqHcxEAYO5fqfFn9lan2JirASms+Ssp36CWt+Xcza7op0nDOQNHxdTWR7JsNwlb3JV7vCnC6eyLLCsWcTM5MW7YN2GjJzhgb6Y6msbD0lwh3o2HC65I+qA4LVWs6vLT2lGRoRmqq7tBAvmb+M+Skl9EcyK1jeCXNnkzlvQe9nBauuoHi1PRqGiOoadraojU1SuTfuUqUoE0puY99XHTakv9g+/bWW8P+eud2oEQZOd4YrHTACOvSoVKiMfiyWrx+w6mGlzmG2gOth8iWWqsfnszfYDHqsIkwAUqzOINh8emGF+2eXZBSi3zbcr9sMh+TyWQyp3NHRH1L7hQ53hOp7uEng6tyaD6SRoY7M8EGokkA6hq1k4yTLwPdpaWObdZ+Rcrn5vpZmUqPXiewOKIa0ymg3VLfZ+TWDQZ/Rg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(82960400001)(86362001)(2906002)(5660300002)(9686003)(6506007)(7696005)(53546011)(52536014)(26005)(33656002)(186003)(66946007)(55236004)(4326008)(66556008)(64756008)(38070700005)(66476007)(8676002)(66446008)(38100700002)(8936002)(76116006)(110136005)(508600001)(71200400001)(54906003)(316002)(6636002)(55016003)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eXFUTzAzbjMwSnU2Q0lvOHk5YlBoL0hRci8yZFhJSnVjR2lyWXJPQ3JHcy9q?=
 =?utf-8?B?emd0YTN5bmhSTThOUnNaMG8vaTN1aWdtNzlBOTdDd3FGWk9nWnhyUlllcW5T?=
 =?utf-8?B?SlZkbXhSTkZIYlRPb1o2V1lJeVVsbkkxaTdzcTF1WTA2dDBzNEVGVDNramVp?=
 =?utf-8?B?ZHAyZkRqSWVyU0RkclZocVlhZS9tUjZhTjJabE5VejY5SVpneEVaSldYd205?=
 =?utf-8?B?OHZOR05wWGtOTHZ0OGN2TW9OdXgwcE1zTkVoaGIybjhPVXFXME0yRGtGbVRp?=
 =?utf-8?B?N0k1RVlsdm9LTnRIbTV6Si96a1lBdURSd3Z0WS9zUmJNalNOZUZ4ckZkMmY3?=
 =?utf-8?B?R1dlWTlVYVB4OWNyakVDU1FIK1lPN3gzZG1kU3FSZVhteFQ0UXF6WktGVVZq?=
 =?utf-8?B?U1R2c1ZHdC9hRU5GR3RicVlOUDNnQ1o1ejlyamQzNGFSNklKaFNWUGNueHNj?=
 =?utf-8?B?MkYvTnVQbzhiT2VlTkpNam1uQmpZY1NuR1ZKcXNDSFdFVlFPVGFFTi9XYTNj?=
 =?utf-8?B?SkxWTHhPa1ZNM1pWRVNrLzVGK0VNVkxlcjlFWGk4OVJTeFpjNmR0YVZQaTY4?=
 =?utf-8?B?UVY3TEdBQStqSUdEZmhjd1F5V2d4SjNvcEJMZWpTdVNxMVMwVk9FNDAxN2Qv?=
 =?utf-8?B?VjFzZnFudDQyMU92YUJWbGRHRlJiZDM1VmJyNFREcW1ZbWZmbnhHbHZ2UWxj?=
 =?utf-8?B?R2FhSzZSNDRtKzNnaDlSeVZPQnFvL2JjYU1ZWS9oM0pTeXloN3BFdUIzK2Zj?=
 =?utf-8?B?R0Q5bXEwOVVnaGdWMFcrQXVXeGRXVnRzVDdudDQ5Q0lmTHM0b25ic1hWdUZL?=
 =?utf-8?B?NUFSNDIxemhRejJSL1lDb2NsZDFWZkpXdk0rOWxWYjVuTVRIak53MDhoWUJk?=
 =?utf-8?B?U2FkOHVhK1U3WHNKN2NuRDVTRjVSVjNhVm9DVHhjVXdhZFRJMzVDdDdNNi9P?=
 =?utf-8?B?UlhkWUhUR242Y1JWdHBhbWVsWldrZVdENXI4d0tkWFd5b0pHMmFOYmlyS2FQ?=
 =?utf-8?B?VGtOVFNMR0l2b3pwTHNyNFU1UFVlTFdLY3BFSUpoNFdVYlJqZGZZZE85UTRO?=
 =?utf-8?B?Y21QWTZ1djh6czMrS0VrbnM5Rk5Tb3gvcUN1NEQ4QWZCUjFKWFNnMnZwaUln?=
 =?utf-8?B?SUUveUpkT1JYSlY3eDJmSVp6OVBOeXVKTURIUklRZ3BLK3VpMk5BNURmR3pR?=
 =?utf-8?B?MGdnQkQzY082OGtnYnJkbGphN0tBQUxiUklUNjJnN2hCNE9ucExhQndwQVB5?=
 =?utf-8?B?bXZmeHZWOGRFRkZSNnNVU28zSXBMdFlIN05yMXdNWGl5U1kxUU5OUmYwdnRD?=
 =?utf-8?B?SlhuL3pFUEdFbGQ5cTZHRUpicEFEVjExbzV1SXJyajl5QUUrOFlKYmZIZCtP?=
 =?utf-8?B?ZDY5elZJVHpUaWkwbWxKN0pRZ0gwdVEvRXU3UkM2alY5TzIrNmlDa3hnNHN6?=
 =?utf-8?B?QkJrTXNVWDloTkEwcHJYTXpvc253UUNZZjgzU1AzUFkydHZHTVQvVVdiZG5k?=
 =?utf-8?B?RTlTTFVDYU04NjVHQUl2SU9IMXB5cTZnSlJyb1JhbEhuZkpKMk9rdWFYKy9H?=
 =?utf-8?B?N001QnBqZTMxY0MzZWl2Mkg2ZG5oSWs5bTZyMlE5Zm5STFFRUWZLMUtyRkw1?=
 =?utf-8?B?RDdrSm1RWmx4UFhkbHMrMk1Fclc3WEdRbnR4UHB0bjk2Q3BidlJlMUNxT081?=
 =?utf-8?B?OE9wY2orT0ZGWEdQbzZOemt5dGZxOFlwNEJRamZVU3pmUTZUWlZLc3FiRXFh?=
 =?utf-8?B?VTg4TFYwU05qRjNLQVJvT3dSZUxHOWZUOGZ3UU1Xd1loSitMTEJmcXViTTZz?=
 =?utf-8?B?cnRhUkRaL3pqMXNOK0hHbXVrT3Yyd0Y3cEhBYmtEMmd1VTJoQUZ6dGxDZFQ0?=
 =?utf-8?B?Tm9tVnpOU3VtNUxvS3o0L2UrN285T055djYyUGpEVlpxaFpqZHRQM09XWE5V?=
 =?utf-8?Q?DrNO44++w08Ybzzm3PTp6D8+Lomf81uo?=
Content-Type: text/plain; charset="utf-8"
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2133f7aa-bcba-4202-5ae4-08da07949a28
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2022 21:33:24.7674
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2LCWis+wJBaqryjjoAkIrAD32atUreBROXVL8LFs9FeHmi3O6iamNZ385oYW7p9n88JeN/ApWhkuTubk/1yAaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR84MB1854
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: Stqpbvf6IpUtgDOep3Rb4ChGL4SIu6WC
X-Proofpoint-GUID: Stqpbvf6IpUtgDOep3Rb4ChGL4SIu6WC
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-16_09,2022-03-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1011
 mlxscore=0 bulkscore=0 spamscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203160129
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBLcnp5c3p0b2YgS296bG93c2tp
IFttYWlsdG86a3J6eXN6dG9mLmtvemxvd3NraUBjYW5vbmljYWwuY29tXSANClNlbnQ6IEZyaWRh
eSwgTWFyY2ggMTEsIDIwMjIgNDoyMiBBTQ0KVG86IEhhd2tpbnMsIE5pY2sgPG5pY2suaGF3a2lu
c0BocGUuY29tPj47IFZlcmR1biwgSmVhbi1NYXJpZSA8dmVyZHVuQGhwZS5jb20+Pg0KQ2M6IFJv
YiBIZXJyaW5nIDxyb2JoK2R0QGtlcm5lbC5vcmc+PjsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNClN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMg
MDgvMTBdIGR0LWJpbmRpbmdzOiBhcm06IEFkZCBIUEUgR1hQIENQVSBJbml0DQoNCk9uIDEwLzAz
LzIwMjIgMjA6NTIsIG5pY2suaGF3a2luc0BocGUuY29tIHdyb3RlOg0KPj4gRnJvbTogTmljayBI
YXdraW5zIDxuaWNrLmhhd2tpbnNAaHBlLmNvbT4+DQo+PiANCj4+IFRoaXMgYWRkcyBzdXBwb3J0
IGZvciB0aGUgaHBlLGd4cC1jcHUtaW5pdCBiaW5kaW5nLg0KPj4gV2l0aCB0aGUgSFBFIEdYUCBp
bml0aWFsaXphdGlvbiBpdCBpcyBuZWNlc3NhcnkgdG8gaGF2ZSBhY2Nlc3MgdG8gdGhpcyANCj4+
IHJlZ2lzdGVyIGZvciBpdCB0byBib290Lg0KPj4gDQo+PiBTaWduZWQtb2ZmLWJ5OiBOaWNrIEhh
d2tpbnMgPG5pY2suaGF3a2luc0BocGUuY29tPj4NCj4+IC0tLQ0KPj4gIC4uLi9jcHUtZW5hYmxl
LW1ldGhvZC9ocGUsZ3hwLWNwdS1pbml0LnlhbWwgICB8IDMxICsrKysrKysrKysrKysrKysrKysN
Cj4+ICAxIGZpbGUgY2hhbmdlZCwgMzEgaW5zZXJ0aW9ucygrKQ0KPj4gIGNyZWF0ZSBtb2RlIDEw
MDY0NCANCj4+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vY3B1LWVuYWJs
ZS1tZXRob2QvaHBlLGd4cC1jcHUtaW4NCj4+IGl0LnlhbWwNCj4+IA0KPj4gZGlmZiAtLWdpdCAN
Cj4+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9jcHUtZW5hYmxlLW1l
dGhvZC9ocGUsZ3hwLWNwdS0NCj4+IGluaXQueWFtbCANCj4+IGIvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2FybS9jcHUtZW5hYmxlLW1ldGhvZC9ocGUsZ3hwLWNwdS0NCj4+IGlu
aXQueWFtbA0KPj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4+IGluZGV4IDAwMDAwMDAwMDAwMC4u
YTE3YzNmY2M1NDIxDQo+PiAtLS0gL2Rldi9udWxsDQo+PiArKysgYi9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvYXJtL2NwdS1lbmFibGUtbWV0aG9kL2hwZSxneHAtDQo+PiArKysg
Y3B1LWluaXQueWFtbA0KPj4gQEAgLTAsMCArMSwzMSBAQA0KPj4gKyMgU1BEWC1MaWNlbnNlLUlk
ZW50aWZpZXI6IChHUEwtMi4wLW9ubHkgT1IgQlNELTItQ2xhdXNlKSAlWUFNTCAxLjINCj4+ICst
LS0NCj4+ICskaWQ6IA0KPj4gK0lOVkFMSUQgVVJJIFJFTU9WRUQNCj4+ICtibGUtbWV0aG9kL2hw
ZSxneHAtY3B1LWluaXQueWFtbCpfXztJdyEhTnB4UiExMTBnZkdEWXFKS0VIaWlKQ1hjQXhrSkoN
Cj4+ICt1djYySnlra09OMXhYTi1HZHY2cDRobjZmbTd5OFdIQ3k2dzJHU0Z0JA0KPj4gKyRzY2hl
bWE6IA0KPj4gK0lOVkFMSUQgVVJJIFJFTU9WRUQNCj4+ICthbWwqX187SXchIU5weFIhMTEwZ2ZH
RFlxSktFSGlpSkNYY0F4a0pKdXY2Mkp5a2tPTjF4WE4tR2R2NnA0aG42Zm03eTgNCj4+ICtXSEN5
MjVncGpKMCQNCj4+ICsNCj4+ICt0aXRsZTogSW5pdGlhbGl6ZSBHWFAgQ1BVDQoNCj4gUGxlYXNl
IGV4cGxhaW4gd2hhdCdzIHRoaXMuIFRoZSBiaW5kaW5ncyBkZXNjcmliZSB0aGUgaGFyZHdhcmUg
YW5kIEkgY2Fubm90IGdldCB3aGF0IGlzIHRoaXMgaGVyZSBhYm91dC4gSXMgaXQgYSBDUFUgZW5h
YmxlIG1ldGhvZCAobGlrZSBpbiBjcHVzLnlhbWwpPyBJcyBpdCBzb21lIHBvd2VyIG1hbmFnZW1l
bnQgYmxvY2s/DQoNClRoaXMgd2FzIGludGVuZGVkIHRvIGJlIGEgYmluZGluZyB0aGF0IHdvdWxk
IHByb3ZpZGUgdGhlIG5lY2Vzc2FyeSByZWdpc3RlciB0byBib290IHRoZSBhc2ljLiBJIGhhdmUg
bm93IG1vdmVkIHRoaXMgZnVuY3Rpb25hbGl0eSBpbnRvIG91ciBib290bG9hZGVyLiBUaHVzIHRo
aXMgYmluZGluZyBpcyBubyBsb25nZXIgbmVlZGVkIGFuZCB3aWxsIGJlIHJlbW92ZWQgZnJvbSBz
dWJzZXF1ZW50IHZlcnNpb25zIG9mIHRoaXMgcGF0Y2ggc2VyaWVzLg0KDQpUaGFua3MsDQoNCi1O
aWNrDQo=
