Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D3A597B62
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 04:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242704AbiHRCNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 22:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234593AbiHRCNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 22:13:32 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D9325C66;
        Wed, 17 Aug 2022 19:13:28 -0700 (PDT)
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27I1ahvN030283;
        Thu, 18 Aug 2022 02:13:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=cHVyU8JfsTU0pMTUu6qWY3zHmFM1CYLBe6Erj831UmE=;
 b=SQQ7Oy1uwtFjSVUgsgqbs4VmqsxerA5ojYrEKcb7pruKhHvnK58KiJIjuW7NYyF9vLQS
 nOo8A5VAZK7UXn1xmeOGpi+QrWK4s/BVwmqjXVDqtYvBHy1qU0bX34+oOWTdYceyHZdH
 q+a048vF4cKMwcxS5ZKTV+YWavuBP/w2RVPtAL1bwoMsrfJD6C15eA1xwAlyxKfnI3pw
 t5K6bzu+9f7gJO1uJSXNoJ2nxCaQacW5L56qLVjYsdg4zkWgThCTfxaIS30m1eiwVI8R
 RotCuTmZo+cr1Z9FWYKWTno0u3NGL1+YumOWi4+D/HKbRQlesfWlIpLGy118MidIvQk+ Hg== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3j1bwsr6yd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 02:13:20 +0000
Received: from p1wg14924.americas.hpqcorp.net (unknown [10.119.18.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 04D21801707;
        Thu, 18 Aug 2022 02:13:19 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 17 Aug 2022 14:13:19 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Wed, 17 Aug 2022 14:13:19 -1200
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 17 Aug 2022 14:13:19 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NyYyk2xeOEE1o20vE99mAykK+ljjocEB89WLzQ3sFdArbHVVo4vPAHPDY4ggrsPGt/f4jh4wdAS3+G00cEZPckidz19rFWQGJI+OwEOpdbGymv9cgw05GalCTPrdAGtNq8mDlVnuGFGnMXxhN55OqJMkExZcq4xSHDEBbSjTTi4cpnd/wQYlaHZDN879K+f3dB9LhV2rSoMqnUDZ3wD6X0cQXQ/smtFo8taFQKUEL2YLxUmH5Hjia9A8YtwDEiAk16c38rypUTkzyqRuxXkCdkSF1j1cEfjCVmbTC3rb1B8rq8IvwZHDVNvJi5FRPvAeX2ATYLfzfOb+yZIgj2j8/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cHVyU8JfsTU0pMTUu6qWY3zHmFM1CYLBe6Erj831UmE=;
 b=RO87gd8Ueaa08O7K++ezFVPMfYcWItJ9qx0p4hTU27hkfMihOP1w4ZcF1s2dfxXLdQPiekrn1xm+XuWUJOuZNkNbJnMtqbfRnUPCPWwpfg2rEXAnQGibjchdlH9n/mMhWTvhH7bk4pl8v2p3MuP5Ab/SECOOx1HCwGZE1kDz7uz/8AE2AIlgkxxvmxF8sOo21wboKs/EpSlx4NlrkOSYzxHBvqKpCSyel9v8qjV7yPJzrMhUJUcBztPOo+D1aMIwFPMGWy1r4AnFXf4bg/Pvey2adxADwmpkDX+K7hJSWsKbOmwaZiHWJ4LtdBOg+UlT90sXFtrYf+Zd3DEGkcWyQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c4::18)
 by PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:154::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Thu, 18 Aug
 2022 02:13:18 +0000
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::1cc2:4b7b:f4c5:fbb4]) by MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::1cc2:4b7b:f4c5:fbb4%5]) with mapi id 15.20.5525.011; Thu, 18 Aug 2022
 02:13:17 +0000
From:   "Elliott, Robert (Servers)" <elliott@hpe.com>
To:     Nayna <nayna@linux.vnet.ibm.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "ebiggers@kernel.org" <ebiggers@kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 00/10] crypto: Kconfig - simplify menus and help text
Thread-Topic: [PATCH v2 00/10] crypto: Kconfig - simplify menus and help text
Thread-Index: AQHYspAVhdnwrvKxPUuXHJ8Go7Hopq2z0aMAgAAQpQA=
Date:   Thu, 18 Aug 2022 02:13:17 +0000
Message-ID: <MW5PR84MB1842AF29C3DA6CDC5E51BEDFAB6D9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220815190608.47182-9-elliott@hpe.com>
 <20220817232057.73643-1-elliott@hpe.com>
 <e6e99e33-4279-690d-88b8-9e732551c17c@linux.vnet.ibm.com>
In-Reply-To: <e6e99e33-4279-690d-88b8-9e732551c17c@linux.vnet.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 34586a95-17f0-4de2-e8b6-08da80bf36f5
x-ms-traffictypediagnostic: PH7PR84MB1838:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vawchTTKI+1H2jlX/zQgLvSV9Mg+TMDIwc8RdlqIrujztDN9uim5TmZyv1BujmF+jWJa4xLkLAsJh28ewTOxgEgUBwTH1JF2xf7gG1wA+gZeBltG/JoFhwOcQ4YL0TVrB4NgjZAHwSWTmMFyoV06IX5M9kdLFvJpJGuITZhwzV/Qy4KVa85m4vBC4qZ4d7DctFlvYGl18EuZ9KFuFMHPTBgaJ/SnvscLCNk8Ec+mehRB1+BEf2EBcl7KimqKxGiPvmTpXn8DZAmlAlJ/YcmArYlXCaLCdUUZUzd+4epLdNHjpovcP73vm8+9C92qFDemiP1KLRgmyc4xiy/dh3M6XjVrqLDE9vsm7owJwMw/sqKXREdnT/ptWILhNEViEkxU5Qdq7embFNoHp3AulHWiopDQYt/NnGhV0fzIDWMUWPSXo75Wg99GfSREJopxKAPg4R6J4WzPJuepe4Mhgt3Dk8TxBJ2JJvwxtpoSWaUu6c6s+7EYJEY3wkk3SKWVpBRFEUmDa15HtVUbQAGYNowqo7AWURu/GhM8usjXI40VxciP/v08t8GUKBlO/rr0z5+hurFxQXHi2MwezBuO3bSjfp5rN6+cMIA3kAXF4yvM9zQ5FEkyGlQbel3lAq4e3DpY5lWSfYb2j6coUFg63ZpR8w2KNWlQyTdiyCtCIM26nSZ/GQfYDH3XicXGQb47XO3WIht8ocN7ZJONVwY07k6+wfVeY395q1wdy/f9OUvNuc/pmNVbqvDAzSWdkMpRebgbptYF5D0sjvxnSVqzINm6cg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(136003)(39860400002)(346002)(376002)(53546011)(71200400001)(55016003)(186003)(86362001)(6506007)(26005)(7696005)(9686003)(83380400001)(110136005)(316002)(76116006)(41300700001)(66476007)(66946007)(33656002)(66446008)(66556008)(52536014)(478600001)(5660300002)(2906002)(8676002)(38070700005)(64756008)(82960400001)(8936002)(122000001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NDlMMFAwNjNxSXpnbHlOZjVDNTFLZkw0OGIxK1NWbGtaVEJ3UFp4ek5PTnY5?=
 =?utf-8?B?aFNSbTZMUERhTXU0dXNQS1pkRzE5UDRLbmswNG5aUDVkY0F4Ylg5N2tOVFlY?=
 =?utf-8?B?NWxGMTFYSUM1eHJlNFZFaHpmVys1TjJTUS9Ea3JTZ2xtUUxTUTIzU1pxd2c0?=
 =?utf-8?B?S3p0N3JDY3JjMElBa04wQ05rYkNZRHJtZTNmQ2d2TUpqVFVMbWJHb09QY3pS?=
 =?utf-8?B?R0lJU3hqa3ppeUlPTUdYKzZKV3FMZ3F0Mk9mVFFWSC9IT1doTWZPYktKbzBD?=
 =?utf-8?B?WDhFZUlENDRGQ1RpQlNVdU1NYUdaYWc2aEpZbUk1QlRkOWVxQ1Mybjhodnh3?=
 =?utf-8?B?U3RlclVQemFwZjdWSjA1WUtSMnlUV1hhb2pRbHhEdWdhczR4VTNVU09Sb0lX?=
 =?utf-8?B?TnpuS0Z5ajJwUnVNTmE3clFwRnNWZ0pUY0R4TjYzd1MyOHdUcFdMZUpFaW9h?=
 =?utf-8?B?QVNUU1RmKytRT3J6S0FNclNqdzZUbm9MTWdzT2o4UEtrWHFRTjlMMHFROHg5?=
 =?utf-8?B?ZVNsdXpnc0o3UHE4UUN1TzJKNVJNczRudDNkUnNZWExMZ0QrZFF4aVZyK3BH?=
 =?utf-8?B?YW04M3U2ZFNSem1QMW1yaUx1OXJoV2tMQjRQbmZOK2VVZ3FadU1NZGIvV0Vp?=
 =?utf-8?B?OXlncUMxTmwrc21uaFZuZ0lwcjRUQjd1akNOei8wbkpjckFnelRjNjhzSVVj?=
 =?utf-8?B?QU9VNmZ2L2RlaW5JQ0g1T0lFMFRSWjY2NWlqdkR0Z0crbUN1em44b1l0eEln?=
 =?utf-8?B?WFFoRjQxWklZVEU3S0xtRWRIM2hQYjQzYWlDSFhHdlBOcExOOUJiaXhIc3c2?=
 =?utf-8?B?SVdZUkxUdUp2WVk5UzA5TXdBa2d2Y1EvbzJqYnNFdnBHR1JxTjd3ajVIb3JK?=
 =?utf-8?B?cGVJZDBhZ0lBcGRkbFdwZ3VESWpHaExyb1E5dnVuYTNXbjRLUGkvSTNxMzgv?=
 =?utf-8?B?ME5CMEJ6YmN3ZGF4VU1kV0ZaRkdtaDh3T3MySWlHT1I3QUhYYk82Tk0wVGph?=
 =?utf-8?B?b2Y2dEtVU2pnMkN0T2lRazQyZlhUN3RacURRS0NCVnNUL2dTaDFRR25nZUNz?=
 =?utf-8?B?cmwrd2EyNGdMc2hVbWx6RXZDTmMvMGdKS1UwazVncFJ6K01GcFBiNGJ4OEJm?=
 =?utf-8?B?VmsvSS81Ym1Cd3dmSnVhRzNvQURvaEJlbkpySUt5VVBlbFk3MmtERUhCVXIw?=
 =?utf-8?B?bzJ4MG1HbHNHemltMWRpcGpvZXg3WnRpZURaakVMRVRmamN2ajV6Yy9Rc1pl?=
 =?utf-8?B?RzJIZU5TWGFsdG5PWW82OHFTWVBEQUtqaVJXblRZVjlTWW9mTUZ4eUo0K3hY?=
 =?utf-8?B?aEtvb2VzN29lVHJGaTdhb3hsbXJndWM0bWxrVFU2cE1NZytCQ1JqZmVBT2dr?=
 =?utf-8?B?OEJPRngrRzUzK3pwQWVtejVsOXN5Q0pLdk5UeG5sdGhxVGxaYzhsTFRINE5C?=
 =?utf-8?B?amxOUDQ5NXpVcVlJV2crTEpwS3o4UmRKTVdjUHBPWTVxMlQ3RmIzSmJUR1ZL?=
 =?utf-8?B?SkNRaTFMNGVVUEVGbjhNckZWVnNSTVpMTmlMK2h3T2JuQTZwY3FBdDRwVE92?=
 =?utf-8?B?SDc2TGVkTVl3eWNDdytsbWxLL1Y1REFrUGlIUnBJRENaZ2xRSlg1WjUzenRF?=
 =?utf-8?B?M093K2tZU3RLdElZK0NWd1dvSFBCSmdYSEd6TzN5ZWVJb09vZ2Z3QUE2aDBI?=
 =?utf-8?B?eXFKcXc1MnFwYnFkd1lEMWVHK0cxUSs3VGd0a2hWOXZmcUhPZEhUamFDNU9R?=
 =?utf-8?B?VWZMa0pMaWRQazlPUndWM0dvUFRtVGx3NERJWWhSa1JEV1N6MGw4ZGdjUzNV?=
 =?utf-8?B?TXJkbGRmUzNrTXA0ZTBuWlNHbmk0YVozVy8raG5NVWYwVGh6ajRDZmQ2Zkgx?=
 =?utf-8?B?cmEvYmUyRmZ2NUFqNnlLM2o3Tm5zbWJCdmxXN0ZRSXlrYk5kUmpMd2xwYzli?=
 =?utf-8?B?UmlQeUJhRXdLQ1ZBZXYvMGRDQmM0bGlsTEJPOWVIa0YyQnBQQUlUSHFaSWpQ?=
 =?utf-8?B?MEJNYnM5SzNpREx6MVdHc2JiTEQzaU8wSnVXV05UalFNR1NHMTZ5MThqSlBs?=
 =?utf-8?B?Y21IQ3RDc29UWTNwVjEwK2FiUWZNL1hBUDV4SHptL002YmVsNmZiczJnNGxN?=
 =?utf-8?Q?9U/E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 34586a95-17f0-4de2-e8b6-08da80bf36f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2022 02:13:17.5228
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: utrPoAYx+1z0RO1u5wfaIDNTwyK4VXgbT2o/OS4m/Nf/CCQ+lD5k1b4FR4sWF/nH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR84MB1838
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: _5Jg_uED49S1YpWA9CiKkgp2tfWes9fL
X-Proofpoint-GUID: _5Jg_uED49S1YpWA9CiKkgp2tfWes9fL
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-17_17,2022-08-16_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 impostorscore=0 mlxlogscore=999 adultscore=0 lowpriorityscore=0
 clxscore=1011 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208180006
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE5heW5hIDxuYXluYUBsaW51
eC52bmV0LmlibS5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgQXVndXN0IDE3LCAyMDIyIDc6NDIg
UE0NCj4gVG86IEVsbGlvdHQsIFJvYmVydCAoU2VydmVycykgPGVsbGlvdHRAaHBlLmNvbT47DQo+
IGhlcmJlcnRAZ29uZG9yLmFwYW5hLm9yZy5hdTsgZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgZWJpZ2dl
cnNAa2VybmVsLm9yZzsNCj4gbGludXgtY3J5cHRvQHZnZXIua2VybmVsLm9yZzsgbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDAwLzEwXSBjcnlw
dG86IEtjb25maWcgLSBzaW1wbGlmeSBtZW51cyBhbmQgaGVscA0KPiB0ZXh0DQo+IA0KPiANCj4g
T24gOC8xNy8yMiAxOToyMCwgUm9iZXJ0IEVsbGlvdHQgd3JvdGU6DQo+ID4gSW1wcm92ZSB0aGUg
Im1ha2UgbWVudWNvbmZpZyIgZXhwZXJpZW5jZSB1bmRlciB0aGUNCj4gPiBDcnlwdG9ncmFwaGlj
IEFQSSBwYWdlLg0KPiA+DQo+ID4gVGhlIGZpcnN0IG9mIHR3byBwYXRjaCBzZXJpZXMuIFRoaXMg
c2VyaWVzIGV4dHJhY3RzIGFsbCB0aGUNCj4gPiBhcmNoaXRlY3R1cmUtc3BlY2lmaWMgZW50cmll
cyBmcm9tDQo+ID4gICAgICBjcnlwdG8vS2NvbmZpZw0KPiA+IGludG8NCj4gPiAgICAgIGFyY2gv
Ki9jcnlwdG8vS2NvbmZpZw0KPiA+DQo+ID4gQSBzdWJzZXF1ZW50IHNlcmllcyB3aWxsIHdvcmsg
b24gdGhlIGVudHJ5IHRpdGxlcyBhbmQgaGVscCB0ZXh0Lg0KPiA+DQo+ID4gVGVzdGVkIGJ5IHJ1
bm5pbmcgY29tbWFuZHMgbGlrZSB0aGVzZSBmb3IgYXJtLCBhcm02NCwgbWlwcywgcG93ZXJwYywN
Cj4gPiBzcGFyYywgczM5MCwgYW5kIHg4NjoNCj4gPiAgICAgIG1ha2UgQVJDSD1hcm0gTz1idWls
ZC1hcm0gYWxsbW9kY29uZmlnDQo+ID4gICAgICBjZCBidWlsZC1hcm0NCj4gPiAgICAgIG1ha2Ug
QVJDSD1hcm0gbWVudWNvbmZpZw0KPiA+ICAgICAgbWFrZSBBUkNIPWFybSBDUk9TU19DT01QSUxF
PWFybS1saW51eC1nbnUtIC1qIDU1DQo+ID4NCj4gPiBOb3RlczoNCj4gPiAxLiBwb3dlcnBjIGRv
ZXNuJ3QgYnVpbGQgZm9yIHJlYXNvbnMgdW5yZWxhdGVkIHRvIHRoaXMgc2VyaWVzLg0KPiANCj4g
RGlkIGl0IGJ1aWxkIHdpdGhvdXQgdGhpcyBwYXRjaHNldCA/IENhbiB5b3UgcGxlYXNlIHNoYXJl
IG1vcmUgZGV0YWlscw0KPiBvbiB0aGUgZXJyb3Igb3IgcmVhc29ucz8NCg0KSSBoYXZlbid0IHRy
aWVkIHdpdGhvdXQgdGhlIHBhdGNoc2V0LCBidXQgd2lsbCB0cnkgdGhhdCBvdXQsIGFuZCB3aWxs
DQphbHNvIHRyeSBkZWZjb25maWcgcmF0aGVyIHRoYW4gYWxsbW9kY29uZmlnLg0KDQpJJ20gdXNp
bmcgRmVkb3JhIDM2IG9uIHg4NiB3aXRoIGtlcm5lbCA1LjE5LXJjNy4NCg0KQWZ0ZXIgYnVpbGRp
bmcgaW5pdC9tYWluLm8sIHRoZSAiY2hlY2stbG9jYWwtZXhwb3J0IiBzY3JpcHQgaXMgY29tcGxh
aW5pbmcuDQooSSdsbCBlbWFpbCB5b3UgdGhlIGZ1bGwgbG9nIGZpbGUpDQoNCiAgcG93ZXJwYzY0
LWxpbnV4LWdudS1nY2MgLVdwLC1NTUQsaW5pdC8ubWFpbi5vLmQgLW5vc3RkaW5jIA0KCS1JLi4v
YXJjaC9wb3dlcnBjL2luY2x1ZGUgLUkuL2FyY2gvcG93ZXJwYy9pbmNsdWRlL2dlbmVyYXRlZA0K
CS1JLi4vaW5jbHVkZSAtSS4vaW5jbHVkZSANCgktSS4uL2FyY2gvcG93ZXJwYy9pbmNsdWRlL3Vh
cGkgLUkuL2FyY2gvcG93ZXJwYy9pbmNsdWRlL2dlbmVyYXRlZC91YXBpIA0KCS1JLi4vaW5jbHVk
ZS91YXBpIC1JLi9pbmNsdWRlL2dlbmVyYXRlZC91YXBpDQoJLWluY2x1ZGUgLi4vaW5jbHVkZS9s
aW51eC9jb21waWxlci12ZXJzaW9uLmggDQoJLWluY2x1ZGUgLi4vaW5jbHVkZS9saW51eC9rY29u
ZmlnLmgNCgktaW5jbHVkZSAuLi9pbmNsdWRlL2xpbnV4L2NvbXBpbGVyX3R5cGVzLmggDQoJLURf
X0tFUk5FTF9fIC1JIC4uL2FyY2gvcG93ZXJwYw0KCS1ESEFWRV9BU19BVEhJR0g9MSANCgktZm1h
Y3JvLXByZWZpeC1tYXA9Li4vPSAtV2FsbCAtV3VuZGVmIA0KCVsuLi5sb3RzIG9mIG9wdGlvbnMu
Li5dDQoJLUkgLi4vaW5pdCAtSSAuL2luaXQgIC1mZnVuY3Rpb24tc2VjdGlvbnMgLWZkYXRhLXNl
Y3Rpb25zICANCgktREtCVUlMRF9NT0RGSUxFPSciaW5pdC9tYWluIicgLURLQlVJTERfQkFTRU5B
TUU9JyJtYWluIicgDQoJLURLQlVJTERfTU9ETkFNRT0nIm1haW4iJyAtRF9fS0JVSUxEX01PRE5B
TUU9a21vZF9tYWluIA0KCS1jIC1vIGluaXQvbWFpbi5vIC4uL2luaXQvbWFpbi5jDQoNCiAgLi4v
c2NyaXB0cy9jaGVjay1sb2NhbC1leHBvcnQgaW5pdC9tYWluLm8NCiAgaWYgcG93ZXJwYzY0LWxp
bnV4LWdudS1ubSAtLXN5bnRoZXRpYyBpbml0L21haW4ubyAyPi9kZXYvbnVsbCB8IGdyZXAgLXEg
X19rc3ltdGFiOyB0aGVuIA0KCXBvd2VycGM2NC1saW51eC1nbnUtZ2NjIC1FIC1XYWxsIC1XdW5k
ZWYgDQoJWy4uLmxvdHMgb2Ygb3B0aW9ucy4uLl0NCgktREtCVUlMRF9NT0RGSUxFPSciaW5pdC9t
YWluIicNCgktREtCVUlMRF9CQVNFTkFNRT0nIm1haW4iJyANCgktREtCVUlMRF9NT0ROQU1FPSci
bWFpbiInDQoJLURfX0tCVUlMRF9NT0ROQU1FPWttb2RfbWFpbg0KCS4uL2luaXQvbWFpbi5jIHwg
DQoJc2NyaXB0cy9nZW5rc3ltcy9nZW5rc3ltcyAgIC1yIC9kZXYvbnVsbCA+PiBpbml0Ly5tYWlu
Lm8uY21kOyBmaQ0KICAgaWYgWyBpbml0L21haW4ubyAhPSAic2NyaXB0cy9tb2QvZW1wdHkubyIg
XTsgdGhlbiAuL3NjcmlwdHMvcmVjb3JkbWNvdW50ICAiaW5pdC9tYWluLm8iOyBmaTsNCkNhbm5v
dCBmaW5kIHN5bWJvbCBmb3Igc2VjdGlvbiA5MjogLnRleHQuZnJlZV9pbml0bWVtLg0KaW5pdC9t
YWluLm86IGZhaWxlZA0KbWFrZVsxXTogKioqIFsuLi9zY3JpcHRzL01ha2VmaWxlLmJ1aWxkOjI0
OTogaW5pdC9tYWluLm9dIEVycm9yIDENCm1ha2VbMV06ICoqKiBEZWxldGluZyBmaWxlICdpbml0
L21haW4ubycNCm1ha2U6ICoqKiBbLi4vTWFrZWZpbGU6MTg0MzogaW5pdF0gRXJyb3IgMg0KDQoN
Ck1vc3QgYXJjaGl0ZWN0dXJlcyBoYXZlIHRoYXQgZnVuY3Rpb24gaW4gaW5pdC5jLg0KcG93ZXJw
YyBhbmQgcmlzY3YgKHdoaWNoIEkgaGF2ZW4ndCB0cmllZCkgaGF2ZSB0aGF0IGluIGZpbGVzDQp3
aXRoIGRpZmZlcmVudCBuYW1lczoNCg0Kc291cmNlL2FyY2gvYXJtL21tL2luaXQuYzp2b2lkIGZy
ZWVfaW5pdG1lbSh2b2lkKQ0Kc291cmNlL2FyY2gvYXJtNjQvbW0vaW5pdC5jOnZvaWQgZnJlZV9p
bml0bWVtKHZvaWQpDQpzb3VyY2UvYXJjaC9jc2t5L21tL2luaXQuYzp2b2lkIGZyZWVfaW5pdG1l
bSh2b2lkKQ0Kc291cmNlL2FyY2gvaWE2NC9tbS9pbml0LmM6ZnJlZV9pbml0bWVtICh2b2lkKQ0K
c291cmNlL2FyY2gvbG9vbmdhcmNoL21tL2luaXQuYzp2b2lkIF9fcmVmIGZyZWVfaW5pdG1lbSh2
b2lkKQ0Kc291cmNlL2FyY2gvbTY4ay9tbS9pbml0LmM6dm9pZCBmcmVlX2luaXRtZW0odm9pZCkN
CnNvdXJjZS9hcmNoL21pcHMvbW0vaW5pdC5jOnZvaWQgX19yZWYgZnJlZV9pbml0bWVtKHZvaWQp
DQpzb3VyY2UvYXJjaC9wYXJpc2MvbW0vaW5pdC5jOnZvaWQgZnJlZV9pbml0bWVtKHZvaWQpDQpz
b3VyY2UvYXJjaC9wb3dlcnBjL21tL21lbS5jOnZvaWQgZnJlZV9pbml0bWVtKHZvaWQpDQpzb3Vy
Y2UvYXJjaC9yaXNjdi9rZXJuZWwvc2V0dXAuYzp2b2lkIGZyZWVfaW5pdG1lbSh2b2lkKQ0Kc291
cmNlL2FyY2gvczM5MC9tbS9pbml0LmM6dm9pZCBmcmVlX2luaXRtZW0odm9pZCkNCnNvdXJjZS9h
cmNoL3NwYXJjL21tL2luaXRfNjQuYzp2b2lkIGZyZWVfaW5pdG1lbSh2b2lkKQ0Kc291cmNlL2Fy
Y2gvdW0va2VybmVsL21lbS5jOnZvaWQgZnJlZV9pbml0bWVtKHZvaWQpDQpzb3VyY2UvYXJjaC94
ODYvbW0vaW5pdC5jOnZvaWQgX19yZWYgZnJlZV9pbml0bWVtKHZvaWQpDQpzb3VyY2UvaW5jbHVk
ZS9saW51eC9tbS5oOmV4dGVybiB2b2lkIGZyZWVfaW5pdG1lbSh2b2lkKTsNCnNvdXJjZS9pbml0
L21haW4uYzp2b2lkIF9fd2VhayBmcmVlX2luaXRtZW0odm9pZCkNCg0KPiBUaGFua3MgJiBSZWdh
cmRzLA0KPiANCj4gIMKgwqAgLSBOYXluYQ0KDQo=
