Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 458855227F9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 01:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbiEJX5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 19:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238804AbiEJX5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 19:57:21 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB8920CD85;
        Tue, 10 May 2022 16:57:13 -0700 (PDT)
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24AJCgRn000770;
        Tue, 10 May 2022 23:56:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=5dnbBcVaBA2OnGXLeSQOEKrnQfR7UA4ltPmYEKJQDAw=;
 b=Bzxmg1v4a+hP3Q8daMHgxlQXjxi128RynADu+Whs6Yd52RxeQDBk36KNM1BX9pyp9mDu
 vWrB/IIIQL3RvT23oZyxUA4E7xnK8oelUCGRqPrScZCKMuS+Dp85l6FxBVKZFc4cpsc5
 wH/o+SsnaZLTXezROSgsGoJHwGov/yWF6L3uP4PH7wo5F+nT88spaZn+Ie49yfZPgaaz
 C4BBBxsGGc5OgiG6/oejs+ako+dP2nTLkD1+2U7GbY+CsDlcBpqH3KwAyBNLzRluZXT8
 4hjUfMNMAUZMEX7u6wSFfG9cwge5Tam3KAWszmd0jxTuP5jeMesaty8gGlN6qtRzHCTM Ug== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3fysjcvgq9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 May 2022 23:56:50 +0000
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id A39A913095;
        Tue, 10 May 2022 23:56:49 +0000 (UTC)
Received: from p1wg14926.americas.hpqcorp.net (10.119.18.115) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 10 May 2022 11:56:44 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Tue, 10 May 2022 11:56:44 -1200
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 10 May 2022 11:56:44 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GBa66zRIO03dKzj87ZuLdrDRshGyRiU2L+z3INUJy7ISalmbH4ZZSY34evmCCO/LNk5ZlZNDGP5fxc4fu6qGSyL9rX34mWbBQbOKZN9+5TbSMfvFv4uH6qqn/kMh+RnUTerlMt7A2m0ZAXu9cBhT+BcdjnkLsUIPfdQa/KdoQ2ctumLpSOj7i3Pwy4UerACIloxrU7yMaKUQwf7Zk3SpZ7Z3DjxXNRQEvvg7+GNHtsQFczO/RvtuLZUhG34KpDLyIxbODG5JHLgr3DlypAWH43cULRCLrlX8UAZd2Z+UIGg7Kl1NGbxTPJEAb5RXkyMDwtkP5on80qSOw5+n06R7qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5dnbBcVaBA2OnGXLeSQOEKrnQfR7UA4ltPmYEKJQDAw=;
 b=J93kNnStGbFAn2BweiUhD77/MUlGfI8H2lIJ7A32hHQYXth2yWoFfmSCI+JYVwQsKwFUQyPuye9WBwteDR1wE/UBte3umv6k7sv74FWnWHdnsWct/K5mHFBuA5SOgUdQCeVUZN9VDB/UJ6dBpo7re0uHitL7Dks2pyeVBsECMoGYHvg61LGH1mqrV/07KRbNxr/D+XExsFW+cwshEXrQl7ceYHVseT0psG/DTbSh3gxngHXzU/Zp2LwNLL0jEgaveUKKkyOvBS2hOt7JkZX8zsqX+QNVj7rhVci3rV65w9KIXN2DyZ4oUpzU7Xi6uMzLPzBOn24MYMcZCS0QrztF9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:172::21)
 by DM4PR84MB1495.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Tue, 10 May
 2022 23:56:43 +0000
Received: from PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6055:1602:5a0a:1562]) by PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6055:1602:5a0a:1562%7]) with mapi id 15.20.5250.013; Tue, 10 May 2022
 23:56:43 +0000
From:   "Hawkins, Nick" <nick.hawkins@hpe.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        "Verdun, Jean-Marie" <verdun@hpe.com>,
        "joel@jms.id.au" <joel@jms.id.au>, "arnd@arndb.de" <arnd@arndb.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Subject: RE: [PATCH v7 3/8] watchdog: hpe-wdt: Introduce HPE GXP Watchdog
Thread-Topic: [PATCH v7 3/8] watchdog: hpe-wdt: Introduce HPE GXP Watchdog
Thread-Index: AQHYYX1Tz9XRkKUMa0OtTpJ2y5sfnK0YiuaAgABDz7A=
Date:   Tue, 10 May 2022 23:56:42 +0000
Message-ID: <PH0PR84MB171853A2C23FBD4BC9EA568D88C99@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220506191339.78617-1-nick.hawkins@hpe.com>
 <20220506191339.78617-3-nick.hawkins@hpe.com>
 <8b706f6d-5022-d3a8-3a0f-7b5fc6310308@roeck-us.net>
In-Reply-To: <8b706f6d-5022-d3a8-3a0f-7b5fc6310308@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 845e04f4-dbab-4abb-a4dc-08da32e0bbaf
x-ms-traffictypediagnostic: DM4PR84MB1495:EE_
x-microsoft-antispam-prvs: <DM4PR84MB1495A3D9322970B18437B7CE88C99@DM4PR84MB1495.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vcS1HS9GIEPG6guyEVfI+SrLIbyzgv7BO6dd3xBZlfJB0QNrFYIMWzd6wTi3pVp6PH3QRy1ClXPo4Kz7zXwBAlp5eU8lxfJEqGMnV5vfpqX8GT8kF7yd0n7KOXZnm3YaE2Ib/NURugBamzopr22sJ3hKD6nkl2HNPE0o4CBaVFtZDWOCSwiTqaFKWBgxjuaGC4GGHQ8Oy6+Kk+FOOQoxqebdiMIY1Q41xja/LObD6YWn2wJpqnNkZZaRe5lu3W28PTbfIJ7ZnTNPAxrzP5Vvp24bhdMKVXU8jshYPh6+w2qn089636NeCa1/81wJm7t6h3s5ISCefnu+XW4mjNcIQeOQU9Zu4KLANB3BwS+degk1EiSOktHb7KNVlkm5qLOpdr3XUv2sUVn2fjRHIsZj7fotsCvYsQEwCa3TZa9FY/iLDT31aMr07s1FMfJcd+4HzJRPj3qLRLCIMsapEuhZi3fRiW/iE01JDS1FJNw3gCW7doU9esIr0HQv7RZfVrl3cub6fuZycueX/aYN3hvSDVOSDc2g+PSiBHYadEJD/tc1s1GF1dqe9fp9dX9QSkbEDF2lgaCusS56gJUX1NiXXrCIfLEVfOOvc5MQAyb0tOgmy4eaXmWyApe+b/ZUP92hUh+ODCfD5KW6XiePy1aLjSrNuJLlB2O9gZW87aiac/SObSiPzd+hA1qhC5AKA4XYwgnrUqHyKfVRfb1OZ90lAA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(64756008)(53546011)(55236004)(5660300002)(6506007)(83380400001)(26005)(66476007)(9686003)(66946007)(76116006)(4744005)(4326008)(66446008)(8676002)(2906002)(8936002)(66556008)(33656002)(7696005)(186003)(52536014)(508600001)(71200400001)(55016003)(38070700005)(38100700002)(86362001)(122000001)(110136005)(54906003)(316002)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZmErdHNmMDJ3YXV3Q0FESm9IYUkwd2R2cFM2ZG9KUkxyMWh5RmwyVWxoR2xm?=
 =?utf-8?B?WmEwQnQvUEYycm1CQzVaemN4Ni9aUVd0cld1R2VXZjVSa1BiVFZIdkcyVlFu?=
 =?utf-8?B?NG9GMnNaS2RVTkFudUQ1OTZncWdGaThSMmw3MGRLdTdLRktkYzBveThpNlQx?=
 =?utf-8?B?a3lXN0N3SXk4Zi81YURZVnRGSmMrcEFodHhzc2xuSFlUOS9hUUE1aS9pS2Q4?=
 =?utf-8?B?azk2d2F5bFRhRnoyMHowbkVzVEpmQzRSVTdzeDN2RXoweWZjYjd5K2lKMzFr?=
 =?utf-8?B?bHg4cTdYRzVLblErUitGTUtvempoUXErelhFU2dUWFA0dk5lNGYwZXNKNzJR?=
 =?utf-8?B?SUtSejRXTWI1cmQ2OG0vZEU2TjE2S2prTWtibTdJQythMzIzd2FtN2xWekJV?=
 =?utf-8?B?cE9tVjZVeFNhb1ZIZkIyNEtnOENUbkdTakpjQUZ2VjVjbUxOMWZYay9ja1pw?=
 =?utf-8?B?R2JHeVVGczA2NlN0UHNpcWl1cTEwOTd4NXQ2TnNKZGRQR29LY2llNHl5Y25o?=
 =?utf-8?B?ZkVPV09iUXdCMWZaUE9Ld2MwbW9hTEdLeVc3dTJ2RktSL3pjQkRXeEVTcGtZ?=
 =?utf-8?B?cnIvUGxKaG9MM0ZtWEEyRUFiMkdXTmE0SHBlcVIyZk9ZenpNS1FsL00yUnM2?=
 =?utf-8?B?bi9wVzZaZWV1OE5JNDdsa3BUTWdWK214dVUvSjIwTkUxNlZlK1d6YVRaZ0JF?=
 =?utf-8?B?NTN2cmRsNDFiUXJ6SUJabCswTW4vTnFaVEpwKzJSYmMraWlyUUwwc3BPdkJi?=
 =?utf-8?B?Wm5zdi9GOEFibERIYWoxcEt5WHdwdEcyRG4zNjlyY1RvRHJnUGJERnhDTytn?=
 =?utf-8?B?dC9iNGdTYUF4MGFaTEk2c0d4NEZDS2xySXdUTkNNOEZVc1B5RXVLUjlZaUtS?=
 =?utf-8?B?eFJWVkFvNkFTeWdRQ2pMVGdSYXRpeTBvTU91VVB0SjdUODFJb2JKelBDNlJE?=
 =?utf-8?B?Y0xpc1BGc0s0ZkpsM21sSWgzS3ZITk5IQ2pTcVN4clJHS0o2YjJvT2QyRDhY?=
 =?utf-8?B?ekd3eDlUSm15ZmErTE0vUTBIZlFNNDVNVWF1V2habG9lNEoxUmI3Z01INlda?=
 =?utf-8?B?WW96MWpUU3lKSGZpYTk4bFFvSS9KUkpyY2ZmcTdGUDNlTklxV21lTVBGRnJ6?=
 =?utf-8?B?SnVsSXlMR1dqL2N2a2F6bXZDa3F5T2plMEh0VE44WHRMRlYxSEg1ZW81SzFU?=
 =?utf-8?B?S09ONGZVd3o1UnZNR3R0UFlLaU9oODR6UmUxaE9LQ01mUWltWXVTOFRYZTJL?=
 =?utf-8?B?bUYwL3Q0dDhieVZFS0EreEpGV09xM0lwWlpWb2VUZnRkaU85K2F3TXhvZ3JI?=
 =?utf-8?B?NkFpY05WczRSd1lYeTYxaHcrNlV2dnF6TWo5eUxWL1JkeWFxUWFBcjhTZ0FU?=
 =?utf-8?B?a0RTTTVjWnpuNldhSnl1NEkrTlFZc2JFZDZsckF3eVEreVpKWWVpayt4TkRh?=
 =?utf-8?B?cGpIOE5rd0todW9IVEoyTWVOWjR1YVQ5bWhKd01FRU1FMC9JWW8vSkVNd0ky?=
 =?utf-8?B?eUJsZVBuNU9vekIzeEx0Z2IzOGt3ZXlINUhjL1FtdVEycW5McVhkdjdkTmRH?=
 =?utf-8?B?d0FMd2M3SW5DZkpZN3YwQmlhREs5QWRsVGhWZDMwL0dDbENVYXcyYkh6OWpM?=
 =?utf-8?B?RHh1My9KdTd0TUhOZGFPTm1TRlNTM2hBRWNLWnYvUktVQXUrbTFMbDZlZzlM?=
 =?utf-8?B?a041RU5DUVpOa3czdnJuNy92UDZGYU1GOWxWaTFCY0M1cEorY2JCZHM1c0Ir?=
 =?utf-8?B?MjFvamRoQ1pHZTh2ZjNGWEM1eGhtZVpxdlYzYkZVd3BmanIram1IdnRyUFF6?=
 =?utf-8?B?dzZyV1JrRVV4OXFOb1B0QnUvU2VxaXhqMWswY3hWUXB1YkJpOHQ3Z3RSL3hT?=
 =?utf-8?B?K2tCMkdrZEZwN0dQZE9pWXZWakVrN1NkM2JYQ3JSdU42eHk3bFVBdm9YR21H?=
 =?utf-8?B?cnRYZUd5c3VIaWZsek03a1lnaktoWGlIWHEvK0YrTWU1SThwdHJNZ3R5TWxw?=
 =?utf-8?B?MnhkSHdkRjROeEorWlU5OTd6WUtLNjk4U1ZJTjFPVGtTOVpROEdwQ1FOMmhL?=
 =?utf-8?B?SmcwWXprNVd3SEFnSGZZVkZ4eFc0UlZjWnlvVEQ1ZmtIck5hMDBHemF1MFVL?=
 =?utf-8?B?c05jelZCVUhzbnJadENxUGNqZVJJK21ZUEdnaUZOM1ByRk9vbW9ES3Zjamdr?=
 =?utf-8?B?M0srM3dZaGlvR2ZuSnVjR2QyL2RacC9XTXlER0tPaFR3bXYyK3JrcTMwRDdB?=
 =?utf-8?B?SXVtck9SZ05CQ1ZMRWxxM3dHdXBIVUdpZmNTN0U5SlRJRFF5Rmw5aTVwVGZp?=
 =?utf-8?B?dXFVWE42bjlMTDN3UXplT3p5WE1kYlRHVUttL3FCbXNYV29Qd3FkUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 845e04f4-dbab-4abb-a4dc-08da32e0bbaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2022 23:56:42.8947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7dbWQPWPE6o+a3Nf6BbZxkl7bqbMiKVDmJ43/7w/dWTJueJGOgMy84hogfUzfxLqt9+K37Hgr8759nI2+OMu/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR84MB1495
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: 3OHSwl320WQ-A6T_LsPZAZrz06NRy1Jv
X-Proofpoint-ORIG-GUID: 3OHSwl320WQ-A6T_LsPZAZrz06NRy1Jv
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-10_07,2022-05-10_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 malwarescore=0 phishscore=0 mlxscore=0 mlxlogscore=710 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205100099
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNS82LzIyIDEyOjEzLCBuaWNrLmhhd2tpbnNAaHBlLmNvbSB3cm90ZToNCj4gRnJvbTogTmlj
ayBIYXdraW5zIDxuaWNrLmhhd2tpbnNAaHBlLmNvbT4NCj4gDQo+ICsJLyogVGhlIHJlZ2lzdGVy
IGFyZWEgd2hlcmUgdGhlIHRpbWVyIGFuZCB3YXRjaGRvZyByZXNpZGUgaXMgZGlzYXJyYW5nZWQu
DQo+ICsJICogSGVuY2UgbWFwcGluZyBpbmRpdmlkdWFsIHJlZ2lzdGVyIGJsb2NrcyBmb3IgdGhl
IHRpbWVyIGFuZCB3YXRjaGRvZw0KPiArCSAqIGlzIG5vdCByZWNvbW1lbmRlZCBhcyB0aGV5IHdv
dWxkIGhhdmUgYWNjZXNzIHRvIGVhY2ggb3RoZXJzDQo+ICsJICogcmVnaXN0ZXJzLiBCYXNlZCBv
biBmZWVkYmFjayB0aGUgd2F0Y2hkb2cgaXMgbm8gbG9uZ2VyIHBhcnQgb2YgdGhlDQo+ICsJICog
ZGV2aWNlIHRyZWUgZmlsZSBhbmQgdGhlIHRpbWVyIGRyaXZlciBub3cgY3JlYXRlcyB0aGUgd2F0
Y2hkb2cgYXMgYQ0KPiArCSAqIGNoaWxkIGRldmljZS4gRHVyaW5nIHRoZSB3YXRjaGRvZ3MgY3Jl
YXRpb24sIHRoZSB0aW1lciBkcml2ZXIgcGFzc2VzDQo+ICsJICogdGhlIGJhc2UgYWRkcmVzcyB0
byB0aGUgd2F0Y2hkb2cgb3ZlciB0aGUgcHJpdmF0ZSBpbnRlcmZhY2UuDQo+ICsJICovDQoNCi8q
DQogICogUGxlYXNlIHVzZSBzdGFuZGFyZCBtdWx0aS1saW5lIGNvbW1lbnRzIGluIHRoZSB3YXRj
aGRvZyBzdWJzeXN0ZW0uDQogICovDQoNCkhpIEd1ZW50ZXIsDQoNClRoYW5rIHlvdSBmb3IgdGhl
IGZlZWRiYWNrLiBJIHdpbGwgZml4IHRoaXMgd2l0aCBhIHY4IHZlcnNpb24gb2YgdGhlIHBhdGNo
c2V0Lg0KDQotTmljaw0K
