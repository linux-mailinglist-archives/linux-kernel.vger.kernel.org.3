Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D580A4D8FD6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 23:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239990AbiCNWtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 18:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiCNWtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 18:49:31 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B30DF87
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 15:48:20 -0700 (PDT)
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22EL4nBq031093;
        Mon, 14 Mar 2022 22:48:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=pps0720;
 bh=SShXG4SVKjCGHUhJmzQhkK4Hbzhr8vmDL7gV0ix8YBc=;
 b=Udh+RQ8KNHZE0/2AO9WGz1aRSZK3jV2NHb9qeDeFDfB/e2BlUnJrsxQY0UARpoPw5p3D
 cfuL4gAqYMqq4xX02jZkYq/o2zmo9Wi1VkWgWEUDex/T9PMdDniIV8UFbrvfOx2xLjo0
 fgB7g/2RSzkM/b24e6abPNTJc7Zkl+y2miSAVA/FT5gkXCRaCl/0+KTKUO2VWAldsFaG
 HwQ2fXH+6ZLSFrQT9B1b+fEI+iXfnz0/UtsuDCpVnaJ2Hkvpn4Q20gbo1jG3VeGVU18J
 0o8KL1KmVnKFAotxosNOq2Ru4Mgv3x9Y8f3BvszvfGGrJ7vRMqlAytY0z2uGQ3IGQdIG ww== 
Received: from g2t2352.austin.hpe.com (g2t2352.austin.hpe.com [15.233.44.25])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3et922aqcn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Mar 2022 22:48:01 +0000
Received: from G2W6310.americas.hpqcorp.net (g2w6310.austin.hp.com [16.197.64.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g2t2352.austin.hpe.com (Postfix) with ESMTPS id 97D4962;
        Mon, 14 Mar 2022 22:47:59 +0000 (UTC)
Received: from G1W8108.americas.hpqcorp.net (2002:10c1:483c::10c1:483c) by
 G2W6310.americas.hpqcorp.net (2002:10c5:4034::10c5:4034) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Mon, 14 Mar 2022 22:47:59 +0000
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (15.241.52.12) by
 G1W8108.americas.hpqcorp.net (16.193.72.60) with Microsoft SMTP Server (TLS)
 id 15.0.1497.23 via Frontend Transport; Mon, 14 Mar 2022 22:47:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lcnADffy5PzEJGiVvajBe4+8N38/y0AbPHJ7TyvcyJVt96+yoWiYcyN3AGyxHJpGvkvVK2eIeLxJ8KRTJxYoC7f71W0/h+ut/EF5x4zUrm8tTq2q3MH4k+tJW5vp1k8Yum/JHEnQ5OR8iyAOZwTbpqLPrluV1sy1C3EstOws9n4OuZSZdTZ0xGnToETLy+Rt16pOTANSrp8ox4+9OahvbmdO0uauU01x8uPl0Iwtw3hbnLdj3bX32wYslPWuFUmYBLl6ziq5OHm40CJT7WI1amoB58erjEFRVfqastwD7fBOdTHEi7bqjqHq65KjO4WGyJXtn01BB8UCc7RRttAiuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SShXG4SVKjCGHUhJmzQhkK4Hbzhr8vmDL7gV0ix8YBc=;
 b=Z39KMMVlpM8SWvK/BdMvuRJRwjpTtGWmxnPrtds/gKJ/MpVtN75h3E0Vdv/ewYn1BFGS0mytBUZKSzUFVJ6rJ7hadcAjykPnFhD2ifz0QEGmDw6uRrcE6/NQa1HQQwa+11Q2HHnbpmbOb8d23Ayeb710wQ50kN4R6mvS9zHQO/D92c/b0cEc8yY42nGjn3ANIlt24aGE/fKLgEelvJwUEyflkcK9JoeDGgutTm1KiiQBWY6eKSwHkDUGtDSkz03DDy919ju0waFAm4VUnLZ9HqKupedJEq0ti/zWRCI8j2mfdAYfbXdePkrKX0XQeurieZWuYPkZAVvGjhVi71e+yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4f::17) by
 SJ0PR84MB1484.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:432::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.28; Mon, 14 Mar
 2022 22:47:57 +0000
Received: from DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::f9a2:fe09:a133:e21e]) by DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::f9a2:fe09:a133:e21e%7]) with mapi id 15.20.5061.028; Mon, 14 Mar 2022
 22:47:57 +0000
From:   "Verdun, Jean-Marie" <verdun@hpe.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        "Hawkins, Nick" <nick.hawkins@hpe.com>
CC:     Russell King <linux@armlinux.org.uk>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Olof Johansson <olof@lixom.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [v1] arch: arm: configs: gxp_defconfig
Thread-Topic: [PATCH] [v1] arch: arm: configs: gxp_defconfig
Thread-Index: AQHYI2Pt+fLVSCbpEEG4Jh+m/2IR7ayWuYMAgCh1fQA=
Date:   Mon, 14 Mar 2022 22:47:57 +0000
Message-ID: <9FE3F625-39FC-4ED7-A2CC-567EF0181886@hpe.com>
References: <nick.hawkins@hpe.com>
 <20220216183704.42084-1-nick.hawkins@hpe.com>
 <CAK8P3a2Ryjr738XgLsGQngvc7j=Kk620LMjWpu-_HiwdK_fX4Q@mail.gmail.com>
In-Reply-To: <CAK8P3a2Ryjr738XgLsGQngvc7j=Kk620LMjWpu-_HiwdK_fX4Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7de6534e-03bd-49fd-c475-08da060caf51
x-ms-traffictypediagnostic: SJ0PR84MB1484:EE_
x-microsoft-antispam-prvs: <SJ0PR84MB14846B8530787D90E56442DFD60F9@SJ0PR84MB1484.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YGX5zPAekaTHovhLjcbkf7uNAi1jD9NgqhU2fS6WEWFjvib0QcwAvKf9UdvLUfp21KZ722AyB1I5Q2ngiu+9mV65EM+ANffjGgtBsP7GeLR3B6Hh951cxJbUIU9k1PKBKKQ6TqQSEk58xjW/cipEt6tydsitA3cud5QPe/UYcGtKKyrBOe/nkdvhrVr9IJkg6Mst33kaFguCxv1lB+fAuv3Po2TLI1wSkL6smipoljhcuEguMP6mvuTNwywi9SCobZlJx6xZ59Z04Ysq1x7MQWJ64gU0fqXve72wck6RrKyCHPuKmJhHhsaSdOnvrnfdF/g6PmVdHX2/5Gfm/mdT4IuNxAipM+fc04UZ24ZGEV+tm/xe8+SsbzJI22VfSp4ZCTwKGh51GTEKoiJ3Z6hVyOTvztyXPFiDEdB93S1rWrpOgDi9sKWnsxlwtUXHYsqF8OAeOuSRi9juvq4/7wN/gTYrIby/Hy+XklxtjhayZiF+7h7/TBhAAAZZqfJpQi4PnwTSTL0aHD/yve4ghJW/iKxr/Ag2j3srvj5BYL7IGLYEtJEBIvOg0rmlY2YE3ZjRijyXl2bcNeEejDg9ah6QILZX6+J3JJqx5XsbyhYstL4m3wFGkmlX4O9F9RD54BEJU5Xv79OZX7wuuK2jOOziANik3ETw/2yjxIgcr9Xx/VbFvFBIaoB1vd8+tZXzgOM1LKfEMyjZMAsni4AtRrqppOBcAf6ECl8WtpP3xUblW1hxqJHk4tkeL32K8os7m4Rc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(110136005)(54906003)(316002)(4326008)(6512007)(122000001)(6636002)(33656002)(6506007)(38100700002)(76116006)(64756008)(8676002)(6486002)(66946007)(66556008)(66476007)(91956017)(86362001)(71200400001)(508600001)(66446008)(5660300002)(36756003)(8936002)(2906002)(82960400001)(83380400001)(186003)(2616005)(38070700005)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cDdXd09FR1p6NEVRQ3diVXNOWittdUNwR0ZSWm9pNHJWYnRWYUIwZ04rOFB0?=
 =?utf-8?B?R3FTSVlJc283UVdSbk9WSzNBOHVMT0I3aXZZZGlxWGVzWFNpa0taVFFSaUoz?=
 =?utf-8?B?a1M3dXJCWVA2N0ZTRzA4TG5WZHh2MGhHR09lTWozM2FTZ2RtWnpDQmZ1anhp?=
 =?utf-8?B?dUdQckhWNFJPV3pJc2NsaThTbUVURXpPakZXcCtMaTBaeGNwN29nWWczKzlP?=
 =?utf-8?B?S29uTkNXMkZpdDV3aEtNbXpjTE9adThIRTFqekpmUkVnSjRybHpiWUtva2Jh?=
 =?utf-8?B?YmtjT2hJSVoxSUQ0YXFYWnJ5ek8yV0RySWNPTWlRU0U5SjRkTklDcFlmMWJz?=
 =?utf-8?B?eVU4TjJobXdzSFNMamhvVTVoT3VBcFhod1h1V2RTQUdwNGM5QTlKeTh5Ymsx?=
 =?utf-8?B?OWcyQ29Oc1FPRUI1cy9nZFpza1k0eTMrcEc4dytpYkQvTU5GWEhoVUNIYnkr?=
 =?utf-8?B?WGtpelhJbVc5ODVwODUxUHMzVktNYXd4WXF2RStvbFFoMmVZS3ljQjR1VG5D?=
 =?utf-8?B?YzkvL3oxQXhodVFlN2NtNEp5OVFyS2VkbitxR0hERHZaQTU3QUZFTGlJdWdj?=
 =?utf-8?B?TCtWSW1iVFZUWU1vY0hOUFJhTE16c3NQRXA1SHFFMkg5djArSkk3VC9OOVd6?=
 =?utf-8?B?bzlTWnBKbXdwTnAzRlp4ak1iZlNzakdOcUU4eEp3eHRnenZvWUlpT01GUndD?=
 =?utf-8?B?RSt1SW8yeU54d0MrTGpnaUNlTVkwQmsweURPUHRxRG1ldlY5Q0FkNnhpWGlr?=
 =?utf-8?B?dEtramo4Y1BwN2VuWkZoRzNGbnFQeW9iYXZaWlhibUc5T05tMFlsWlZ5WCtn?=
 =?utf-8?B?bVBDVkFkNEEvdWgrejMwL0srYTJMNjVpOVVFcklFMjR2TXVBSm9RWU5nV3NR?=
 =?utf-8?B?a1E3SjY3dUo3MkhIbEZoYkdjT01RcVp1bXdBYkcwMGNrS0tzTVBIOWM1OURw?=
 =?utf-8?B?aXYzMHhqa2dyYko1TFk3WU1BbkNObWUrM1lOKzZ0S25adFlHNHQxRUQrd1JY?=
 =?utf-8?B?TE5xbnJGS1l6ckhEY3pZYlAwQzZHRnplV0w0UUt6Y1pnMHVyY0JaUkYvL2NS?=
 =?utf-8?B?NEM2VndTY3AxZWFET29oYmlxTWdBQWhSL3BoMXErdThxa3VFUVJKV29uNytq?=
 =?utf-8?B?UTl0Zk5ObmxYSFlTek1yV3Bxd0NJWGFvWjdNYkt0ai9Bd25CVUFpRHRFQm9C?=
 =?utf-8?B?NVZMVVJtR0pKSFhtYnQ0RWlYTlE0Z3NMeXl6ZndlWTV2WUdXcEgydmc1TGlm?=
 =?utf-8?B?MzVBVzdyRlN3VXN6UGlpUWYzT1RyQ3FHYUlsa29GSUJOZ0R5RlZScmhTazVs?=
 =?utf-8?B?b1R2UHJrbGNJY1llcEZxRHEwS1d5MXFkRjIrbnpsdytQNnZYeStRZnYyeEVo?=
 =?utf-8?B?NUNBc3VNUmxCdGZBRTNiN0hITTY4YzFnMzJJalVsVjdPRm1YaWZiOExYYXB2?=
 =?utf-8?B?Tk5CSGgwOWVVT3B0Mno0eGI5eVc5VDdoMjVkRXBiVk9jRWEvbTFGN2JJZWto?=
 =?utf-8?B?bkhCMDlXRlJwbUZ0VXdCamhWekt4S0JSdmtKMzRrdlN3VkdVbm82UEhrSzdt?=
 =?utf-8?B?SXV4YjdaQzg1NlM2d1RwN3c3ZjQ1aXJBK2tWbEE3Tk05eUxWMVRjaTI2M1p0?=
 =?utf-8?B?ZnhUM3VkNlFJZGlMUlVkbHByZlZsejlIWFp2YUk5ellIRkhlNlN1R3BuWEdx?=
 =?utf-8?B?c2dISlFyNVhDdGZPVHdhbHErYzZqREk4bXhLYWY0Y2xHT1NUeGFWUWVjS2ly?=
 =?utf-8?B?Q2JudW55dFBxcXpTdTRzeFV1b3ZjbjJranZpQ0luMWpsYzhFN0dwOGl5QXNr?=
 =?utf-8?B?N0RWdlc4V21JMVhJdU56bTlFWC96NVB4Qlc3SVBTRi9MMStLOEIxMEFhb25Y?=
 =?utf-8?B?L1hpK21kazkvalplTWxEK2VGQ3pnK0xHZVJIZHoydk9sRmlJdXBFK1hNUEtD?=
 =?utf-8?B?S3FzWHd0T0srS1FIUFljZ3U1WldIczU2N092Z2wzQitXdUdISTlpYTljVnli?=
 =?utf-8?B?NkRiR1RJemhqbTFHRWxNYWdVTjB2Q0ZhUU13Qk1iaUpSK2VsWFZqWTEya0p4?=
 =?utf-8?Q?DIGk6M?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <01C5019FE384414F9CCCE3D6235E5A4F@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7de6534e-03bd-49fd-c475-08da060caf51
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2022 22:47:57.5998
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hc04Ga+rw9wdbl6lvFwudV6Us7PVG7+XQU/7hNh/bWVkjC85kU6/8OdglygZfQA9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR84MB1484
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: MpqfiZuSNBIj6lGiMaHWF8Ns6brx7qBL
X-Proofpoint-ORIG-GUID: MpqfiZuSNBIj6lGiMaHWF8Ns6brx7qBL
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-14_14,2022-03-14_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 spamscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 malwarescore=0 impostorscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203140130
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQXJuZCwNCg0K77u/T24gMi8xNi8yMiwgMTo1OCBQTSwgIkFybmQgQmVyZ21hbm4iIDxhcm5k
QGFybmRiLmRlPiB3cm90ZToNCg0KDQo+ICAgIE9uZSBiaXQgb2YgaW5mb3JtYXRpb24gdGhhdCBJ
IHdvdWxkIGxpa2UgdG8gc2VlIGluIHRoZSBkZWZjb25maWcgcGF0Y2gNCj4gICAgaXMgYW4gZXhw
bGFuYXRpb24gYWJvdXQgd2h5IHlvdSBuZWVkIGEgY3VzdG9tIGRlZmNvbmZpZyBpbiB0aGUNCj4g
ICAgZmlyc3QgcGxhY2UsIHJhdGhlciB0aGFuIHVzaW5nIG11bHRpX3Y3X2RlZmNvbmZpZy4gUGxl
YXNlIGFsc28gYWRkDQo+ICAgIGEgcGF0Y2ggdG8gZW5hYmxlIHlvdXIgcGxhdGZvcm0gaW4gdGhl
IG11bHRpX3Y3X2RlZmNvbmZpZywgYWxvbmcgd2l0aA0KPiAgICB0aGUgZHJpdmVycyB5b3UgbmVl
ZCAoYXMgbG9hZGFibGUgbW9kdWxlcykuDQoNCkkgdG9vayBzb21lIHRpbWUgdG8gbG9vayBhdCB0
aGUgZGVmY29uZmlnICJjaGFsbGVuZ2UiLiBOaWNrIGhhcyB1cGRhdGVkIHRoZSBtdWx0aV92N19k
ZWZjb25maWcgd2l0aCBvdXIgR1hQIGluIGEgbmV3IHNlcmllcyBvZiBwYXRjaGVzLCBidXQgdGhp
cyB3b24ndCBleGVjdXRlIG9uIG91ciBBU0lDIChjb21waWxhdGlvbiBpcyBvaykuIFRoZSBjaGFs
bGVuZ2UgaXMgdGhhdCB3ZSBhcmUgbWlzc2luZyBhIGZldyBmZWF0dXJlcyB3aGljaCBhcmUgZW5h
YmxlZCBieSBkZWZhdWx0LCBhbmQgSSB3YXMgd29uZGVyaW5nIGlmIHRoZSBjb21tdW5pdHkgd291
bGQgYWNjZXB0IHRvIGRpc2FibGUgdGhlbSBieSBkZWZhdWx0Lg0KDQpUaGlzIGlzIHRoaXMNCg0K
Q09ORklHX1BFUkZfRVZFTlRTPXkNCkNPTkZJR19BUkNIX1ZJUlQ9eQ0KDQpCb3RoIG9mIHRoZW0g
Z2VuZXJhdGUgdW5rbm93biBpbnN0cnVjdGlvbiBvbiBvdXIgcGxhdGZvcm0gd2hpY2ggbGVhZCB0
byBrZXJuZWwgY3Jhc2guIA0KDQpXaXRoIHRoZXNlIG9wdGlvbnMgZGlzYWJsZWQsIHdlIGNhbiB1
c2UgdGhlIGRlZmNvbmZpZyBhbmQgYWRkIG9ubHkNCg0KQ09ORklHX0FSQ0hfSFBFPXkNCkNPTkZJ
R19BUkNIX0hQRV9HWFA9eQ0KQ09ORklHX0dYUF9XQVRDSERPRz15DQpDT05GSUdfQVRBR1M9eQ0K
DQpUbyBpdCwgYXMgdG8gZ2V0IGV2ZXJ5dGhpbmcgc2V0dXAgYW5kIGdldCBvdXIgbmV3IHBsYXRm
b3JtIGJvb3Rpbmcgd2l0aG91dCBhbnkgaXNzdWVzLCBhc3N1bWluZyB0aGUgYXNzb2NpYXRlZCBj
b2RlIGlzIHByZXNlbnQuIFRoZSBBVEFHUyBpcyBub3QgbWFuZGF0b3J5IGl0IHJlbW92ZWQgc29t
ZSB3YXJuaW5nIG1lc3NhZ2VzIGR1cmluZyBrZXJuZWwgYm9vdC4NCg0KSSBrbm93IHRoaXMgaXMg
cmVtb3Zpbmcgc29tZSBzdGFuZGFyZCBmZWF0dXJlLCBidXQsIEkgcHJvYmFibHkgY2FuJ3QgZWFz
aWx5IGZpeCB0aGUgbWlzc2luZyBpbnN0cnVjdGlvbnMuIEkgY2FuIGRpZyBhIGxpdHRsZSBiaXQg
aWYgbmVlZGVkIHdpdGhvdXQgYW55IGlzc3VlLiBJZiB3ZSB3YW50IHRvIGhhdmUgYSB3b3JraW5n
IGRlZmNvbmZpZyBvbiBIUEUgR1hQIHBsYXRmb3JtLCB0aGVuIHdlIG5lZWQgdG8gZWl0aGVyIHRh
a2UgdGhpcyBtb2RpZmljYXRpb24sIG9yIGNoYW5nZSB0aGUgY29kZSBmcm9tIHBlcmZfZXZlbnRz
IGFuZCBhcmNoX3ZpcnQgdG8gcHJvcGVybHkgd29yayBpZiB0aGUgcmVxdWlyZWQgdW5kZXJseWlu
ZyBoYXJkd2FyZSBpcyB1bmFibGUgdG8gc3VwcG9ydCB0aGVzZSBmZWF0dXJlcyAoY291bGQgYmUg
cHJvYmFibHkgYSBkdW1teSB0ZXN0IHRvIGlkZW50aWZ5IHRoZSBhc2ljIGF0IGNvbXBpbGF0aW9u
IHRpbWUpLCBvciBjcmVhdGUgYSBzcGVjaWZpYyBkZWZjb25maWcuIA0KDQpJIGFtIGZ1bGx5IG9w
ZW4gdG8gYWxsIG9wdGlvbnMsIGp1c3QgbGV0IG1lIGtub3cgdGhlIHByZWZlcnJlZCBvbmUuDQoN
CnZlam1hcmllDQoNCg0K
