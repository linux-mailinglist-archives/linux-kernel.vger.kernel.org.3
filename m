Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCB85832DE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 21:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235121AbiG0TF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 15:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234588AbiG0TFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 15:05:30 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F92C21B0;
        Wed, 27 Jul 2022 11:33:11 -0700 (PDT)
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26RIJOCx007390;
        Wed, 27 Jul 2022 18:32:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=3l3dhi/mTkOBun/f/IG9bGZ8Z2L8UaVRukgncAGhZow=;
 b=DFbPq4wCQybQCUsyo0EOYLnW4RFBOIczBVY9o9MCTXuXxWDRLZD80mtQfMBeYNkKRuxP
 7lVXzButjYQyg5MLN9ubtEfAA3zYuU4P4oAzXsZcwsTg7KH6nHsZPS0YIwj1rO4bpSEE
 XCWd4CtGssY0HpHbXIjfvE96hIhKqR2V6vumCckfsWVYGGDRjUGHQKxpiaNjsgMdLl6c
 0iPgCjdwhHqkvJpcAxmsRmmMIG1Hu7j8j27sStofPJ2rZspg/Bc/vEVyjElvEv1aUwBe
 6AsEE9nco1q6Znt127+vSVYjIDkBtaKJmVIMAnOT/lCdNsDLyOKK4pgr64RKhqkOnLH0 ZQ== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3hk6ctja8c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Jul 2022 18:32:53 +0000
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id BE2F4132DE;
        Wed, 27 Jul 2022 18:32:52 +0000 (UTC)
Received: from p1wg14924.americas.hpqcorp.net (10.119.18.113) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 27 Jul 2022 06:32:52 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Wed, 27 Jul 2022 06:32:52 -1200
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 27 Jul 2022 18:32:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J4gSo6oDJbgYG1zi1mJEt3PgEeJhVgFkMrtEf7np/r6ZRBGPDLTl+AGjYkbgNl7OZTLjxQ3QdZmZ6/DWkUsf1r89T2ducMXs025P9bzx5aozxoP0aeAcN3KpgWdo6cQ2BcXIJvuRRYbyTF+4LnujdSQtf/jkLK99ZJjvuvTi4SjtInxwP8ZoO+URH6+HTRd9KFTzPJI+3IeDpJSwo9ATFi4c2Q1oE7yzxFg5yw+zjjPp2L7goxgJxihSfRwnRZ9LmKAwiqnR28Rdle6uwuBpHQlVjYDzCeN2SP/r+NEM++R/kGawNZfjKKvgdOZV+Vxi1fdi7FHODQGe7aSo5FaYIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3l3dhi/mTkOBun/f/IG9bGZ8Z2L8UaVRukgncAGhZow=;
 b=oBUBQgRhhfTuFM5uDX0oT2oljp43MgU9Lyokyv/PY0PXarJwv5XooYxrFAY+vhMD0D1LNSFlnUvZWmrV/3D2BO2qpFxGQPArIT3RO+4RZG8rQV7eaM22rJh8pZrBt5CfPksaSSvhpvUmI//B8lsTyF9vWcAR+nKaTiFvNTdqVkd4tj1mwmzPQCFHPmOP3J0xVWXeEJYGW5X1AUZcPJPOEwAgzAHWHp6cbIUHba1UTiVx3PsHB/SYRXRdSSZamOxo4i8f3ubAWnYMNte0umvQdPFy7HCWfICYIA4I1PLu0TkXEDQYGuwaaxMkK1+8kJNDFNpGia4sK/g9Y/4o/F5wng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4e::10) by
 MW5PR84MB1770.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.25; Wed, 27 Jul
 2022 18:32:50 +0000
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::4969:9f9f:21bc:9fc3]) by DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::4969:9f9f:21bc:9fc3%7]) with mapi id 15.20.5482.006; Wed, 27 Jul 2022
 18:32:50 +0000
From:   "Hawkins, Nick" <nick.hawkins@hpe.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     "broonie@kernel.org" <broonie@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "Verdun, Jean-Marie" <verdun@hpe.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "arnd@arndb.de" <arnd@arndb.de>, "joel@jms.id.au" <joel@jms.id.au>
Subject: RE: [PATCH v5 2/5] spi: dt-bindings: add documentation for
 hpe,gxp-spifi
Thread-Topic: [PATCH v5 2/5] spi: dt-bindings: add documentation for
 hpe,gxp-spifi
Thread-Index: AQHYodh/7b6+KaSQXEi7xOkWjj2eja2SbkkAgAAcIIA=
Date:   Wed, 27 Jul 2022 18:32:50 +0000
Message-ID: <DM4PR84MB1927058BCDEF9A45D7E44CC888979@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220727164736.48619-1-nick.hawkins@hpe.com>
 <20220727164736.48619-3-nick.hawkins@hpe.com>
 <0c3a95fb-a3ee-ba48-1f69-ae9db84cc856@linaro.org>
In-Reply-To: <0c3a95fb-a3ee-ba48-1f69-ae9db84cc856@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 282d79b2-f6ab-4556-9ffa-08da6ffe697f
x-ms-traffictypediagnostic: MW5PR84MB1770:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o5Z0GYfJylkXdcY3Zmy5isIH8F+PhxlH6odRizwfX4vcwurvqUYklC+F5Zn085Gt3DgQoOZUyxCkMF41gSX+TJTlbgM5Keb1TsQBYDRotSvDdDGstnrxCohCv91/0cCzC+utSeIsEukKB9GfLMET/KdtcMYaNrEB57GvhQiKWPwOCd9h2/8/dqGjWhj1BxM1pIVaqObg9f8lHUNzCvtT+rlStECL6ZyBKiPnZuLTKGdvgC2qVgjUAd6wGcw2k4sf5GjNxK7+U7r6VZ5lBTVYc/02/WDJE4ddLfJSJsNq+PEBk8lW1AIM6Izokn9g1zCRSiWV4mCX6wtBHg+idacbp+0A7gUP6hnEpX1rlCqAq1yKZgvWVGJ/IQP+G7KTaSurLxdTNWF3SU/RIW5hZA6h+1i2cp6t3SDTOXTRvXLFswx6EtXJaysdlo6hZkIQn2MAzlAheoK8zFS90VxXZHgwXCQVY4e9KEv2mti4kKQ8tt0EFCO4gfs7SZZXEjiiaHGnql86d8l+JtAAsErGVv1SU/hrddAliJQAtO0L9eGlPTh/9Q1YmSdIO8DY696zCILHMT6OLwABh4Iihs60OYetwbd5jyW14Mb9i1pX4fWbaxvpCUZMPnPGAgEUOgyHvnKYxCKXj/YphynhEPISl6aFdD/KQ1RPouxmwXwOA2owiz8P9tNmOBkUkzPlrdyNTq0w7CZSz8j2Vq+X/xcqTgYelsDOXzZCMRJvkteGDIyntS9Gj9uW5beDXMKgNaA6kkGkq5TbKTDKFMw8ehYacJjpXnBuaB+ALIHoq7mRXYnrew8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(376002)(39860400002)(346002)(366004)(136003)(396003)(66556008)(71200400001)(41300700001)(66476007)(8676002)(4326008)(478600001)(7416002)(64756008)(4744005)(76116006)(5660300002)(66946007)(66446008)(8936002)(52536014)(86362001)(55016003)(186003)(38070700005)(82960400001)(9686003)(26005)(54906003)(83380400001)(6506007)(38100700002)(7696005)(33656002)(6916009)(122000001)(316002)(55236004)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U2VpMlcxRVBJdzlEQTdxaGNCWlM1OEhHMlhBRTB1eXRZblBnUUhiRWdGVVMv?=
 =?utf-8?B?a3hwYUcvRHBpMWlCVkZlL2NqWFdRL2dMRTNtS3ZUa1FTcEZpM1l0V01HVWtj?=
 =?utf-8?B?S21BTzljcW5GaWw5cVV1R080c3lpbEdxWUgwenFzZ2U0ZEtlN1lXM3BiM3VE?=
 =?utf-8?B?eXlUYms1TzBtRUpjWlZxTEhERUZqTmdOVGxTRW5PYSs3cWdZTXo4WVgrcHFV?=
 =?utf-8?B?aVg2NElZSXV4OEVJVmRFNDNyc0ttRVU1NnVwcEEyaWxkT2RQaTN0YU1KZ28x?=
 =?utf-8?B?YklxKzZ2MzlmSFJDbWE2WHNzYytUblpqK3J2d0VUQmorZGNkVTIvOVlIVzMy?=
 =?utf-8?B?Wm9za1liZnU3UDJYVWsrRjAzWVYrSGNaWUJMNGZNZm9iTjQ5VXBUNTd1VlRj?=
 =?utf-8?B?a3VyUzNNZjVMMGNreEZSeXA4NnVCMG9CdUp0YXQxUU9VaElVek92cHdweDlZ?=
 =?utf-8?B?eDg0ejNGbTRhWStGekZxT1VhalVkVm1BVlZoVVBlNWtBRWJuM0g4dzlwSGQ2?=
 =?utf-8?B?cHB6R1FYaENxVVRaNHVMT0VNK2c3aXBYdFNLdGY2UmNQckpSNGpySW1LNC9C?=
 =?utf-8?B?RUJIcTFwRG5mTHVMdjhUWVYvaThRbXNYWTM1blVVKzdIcVQ3Ni9sV3hlSXlm?=
 =?utf-8?B?aS9rcmRyWjFnNkhjWW9yM2VWVlFES290KzBiMURKMkpNY0dNdURtSmp2N0Iw?=
 =?utf-8?B?TXNOTW5pV3F5YTBwRFM3QkdTOHM4NTZyTVVRZjVuVDRJNXc2QTh1SVhZQnJs?=
 =?utf-8?B?cmE2cWw2bkJLck8wSG9BbEdUa0pmNitrS2VXYk1RdzZjUWlyVzc4WE4xcWQ2?=
 =?utf-8?B?QUt0a0pFYXo2eVZMOXdpb3BNdk11OEFTeWt5elpqWDFvbFNweFpXYlY2UU93?=
 =?utf-8?B?YTkzZ0M4WW9udUo4cXhGZmF0M1JyR1ZGcndZQkk4cWNXVUhkcTM0SitpaHZY?=
 =?utf-8?B?V3JITG1zV0RlQWxVTFhtNis2QVVmcmZVNVlicG5xOTlNaXkrMmdDNytkVTJp?=
 =?utf-8?B?TFpMZFlJcmVERyt4RkdPd2s4bkI5bnNjRERPaXVlT2NhR0R5dENldi9lZjNG?=
 =?utf-8?B?UjRldkZxSzdoSHlHc1FJUjY4TlU1dVB3WlZxU1EzRjZVd3FGM3czMzVtY3pX?=
 =?utf-8?B?dWRmMHpGMkxCdzBROHZjdk1ZVjZMeUNDTExsbXVEYWkwdDZWeElxQktRajJ5?=
 =?utf-8?B?cUpKeFh5aGVZSEZFVy9JNWN1d3JOd3lJQ2JkN2FNUFNsRldrU2ZBM1FPRHk0?=
 =?utf-8?B?RWNjdzM0RUMxbFFoL251MkRwZG5aei9IMlljMTBHaUkwVVIyNmw5NStlQkZS?=
 =?utf-8?B?MnFUWWQzdUpaNFVSMHlnVHkwaTFyeUlXeXBCYlJrUFNkNERhdmFkS3pTZ09w?=
 =?utf-8?B?WHRsUW94RmpJS2xTL1V5N0lNeno3dlpzajUybVBDVXlISjBkekZpWTFtNjJn?=
 =?utf-8?B?SDdJLzFPejkrTERFdGpETUI1L2ZDaWFGK0VLdC90djNmTU5wNVR6bDNBWFdj?=
 =?utf-8?B?VWRER0FtbHROK1A2NncrQUpmSnhlZzVRNGRxZ1h1WitvbTZaZ29tVjBVVW16?=
 =?utf-8?B?WnhoVlZhMVhaNnZKNGpIZWdCTThubi9rSkk3cGFGbnR0U3NqNStRbWhrbHN5?=
 =?utf-8?B?TGJuaWFZUUxtWUlBNUx1N2xtcGRuaE5QVlk4aFJJUkRMSCtPZlhIbEQvcGZE?=
 =?utf-8?B?am05T2Q2YnUwd1ZnMkZKMGx5dHBhcmZYcFlsMzVJek10dkNqWjJCa3FFT0x0?=
 =?utf-8?B?WWNrZjF6WlNuak1QUFZNdENyYXFLanNpVGY4OGkvam1tSmljNVhyT3N1ZElr?=
 =?utf-8?B?dCtVT0lJRE9sK2l6dFFGZ0F2MlFMV2pQVjFGWUVLY2pRenJhV1N2TFplendM?=
 =?utf-8?B?SytPVkl2QSszbXZVZm1oOENWandaVzFJTUpES0pHQ3hFZ0pJdGFoNHE2WEoy?=
 =?utf-8?B?VHhoYXVPQ0RyajZYOThjQkRVMWN1QktneUpPYTJtTWx2eHFDS1JlNDNpOUpF?=
 =?utf-8?B?aUF0NnBuQnlCN2ozUklReTJldnFkTXR3OUdsV0xveW9xSlArdFJ0dVU4ZlJV?=
 =?utf-8?B?cDVZODZINUJ2Mzg3WkhTOWxEMU1qcXZEemd0ZzU2Q3JodVlzRHc4VUt0WmNh?=
 =?utf-8?Q?tfY+Kr0jwzhfX+wTS+otNWV8O?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 282d79b2-f6ab-4556-9ffa-08da6ffe697f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2022 18:32:50.8538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qRJKVDc4C1fDCeOipLkNk94uUTUYrAalkHDAEP67/15ByF2HU6RbQX4Mojo/vRpBkRTSeUEAaZgKwhW2XDdjOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR84MB1770
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: NkL8RWgrdmRtbErrAAjSb4zTtnzqySHa
X-Proofpoint-GUID: NkL8RWgrdmRtbErrAAjSb4zTtnzqySHa
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-27_07,2022-07-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 clxscore=1015 mlxlogscore=658 impostorscore=0
 malwarescore=0 adultscore=0 mlxscore=0 phishscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207270078
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+IEZyb206IE5pY2sgSGF3a2lucyA8bmljay5oYXdraW5zQGhwZS5jb20+DQo+ID4gDQo+ID4g
Q3JlYXRlIGRvY3VtZW50YXRpb24gZm9yIHRoZSBocGUsZ3hwLXNwaWZpIGJpbmRpbmcgdG8gc3Vw
cG9ydCBhY2Nlc3MgDQo+ID4gdG8gdGhlIFNQSSBwYXJ0cw0KPiA+IA0KPiA+IFNpZ25lZC1vZmYt
Ynk6IE5pY2sgSGF3a2lucyA8bmljay5oYXdraW5zQGhwZS5jb20+DQo+ID4gDQoNCj4gTm8gYmxh
bmsgbGluZXMgYmV0d2VlbiB0YWdzLg0KDQo+ID4gUmV2aWV3ZWQtYnk6IEtyenlzenRvZiBLb3ps
b3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4NCj4gPiANCj4gPiAtLS0NCg0K
QXBvbG9naWVzLCBJIHdpbGwgbWFrZSBzdXJlIGluIHRoZSBmdXR1cmUgdG8gYXZvaWQgdGhpcyBt
aXN0YWtlLiBJIHdpbGwgY29ycmVjdCB0aGlzIGluIHY2Lg0KDQpUaGFuayB5b3UgZm9yIGFsbCB5
b3VyIGZlZWRiYWNrLA0KDQotTmljayBIYXdraW5zDQo=
