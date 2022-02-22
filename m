Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5DFF4BFC24
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 16:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbiBVPO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 10:14:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiBVPO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 10:14:56 -0500
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120050.outbound.protection.outlook.com [40.107.12.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E9F13396C;
        Tue, 22 Feb 2022 07:14:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CTgmHL+sIw9h0n5XlKYnqhpQTEsM1bBOweHc9EkJuCV+iJDUAgKd57whZVzLgfzMcX3rofxERzAhP7nX3IjStZewsXBKqQrowncNMS1jDfIesDlU3lJtZj/Ib45mKARXFzwH/a88ob3ROn6k996RpBbiGA6XiEOamS7vh/+lFY7kS5s7VRhOnnolBdMQiexAkctihyMIZUopu9m3fF2AJBmzNq8DvTU3vwsGi5w5fULIx8eZtMZT0rRbi2Y8ec6wlqS+HGesWA5lUyxF6bSVedNDmNMVYUAUI7MkBJeFbcfsiVaMJ2O3ISwlwMRkeRSFusPP/9W0N/C7yMnmNTgX6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BvVa6XLVpHnKnFtav8LLjZlpQ3+xQBfIDQIiJ/Ns8Wk=;
 b=iDvopHPX2HukWGYGD7wCcnFwuI5IVDNRaSk0ADN5PEoG14RtmRzm2PBU+hA0SFGdE3XyEeuA3AOAdjbHFoMqVT8ZAZ+EbI9yhXNqSmLaCA8mKKYbAIaY5ZfvsbMmvNMzctcrTplMYmvV1fHFXCLtb39+0O0Xejhn7DakiGSDVaozcU1QEUgdAlbceLiQUwCSrW57+CNK3Ty/jk4vkFUyF9eQ0cen5jE3s5z4mialdkJVRdmISr9lFeVPL3UrLve+HEsBttu2qWyPJo4oTrwxp4rxB+4Hd/O/Z4+35Tyib09/8vVGC/YPkSs12nCcrFB8QRD6KoV9KIr14Sxo9Z15HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR2P264MB0528.FRAP264.PROD.OUTLOOK.COM (2603:10a6:101:e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.17; Tue, 22 Feb
 2022 15:14:27 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::8142:2e6f:219b:646d]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::8142:2e6f:219b:646d%5]) with mapi id 15.20.5017.021; Tue, 22 Feb 2022
 15:14:27 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/4] Miscellaneous cleanups
Thread-Topic: [PATCH v2 0/4] Miscellaneous cleanups
Thread-Index: AQHYJ/6il2MVw1p/fkyHa2Kl9f6KAKyfrcUA
Date:   Tue, 22 Feb 2022 15:14:27 +0000
Message-ID: <708fb1b3-e229-e9f6-48e7-500da8a894ef@csgroup.eu>
References: <cover.1645542447.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1645542447.git.christophe.leroy@csgroup.eu>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7510469f-64fd-4613-482f-08d9f61604b5
x-ms-traffictypediagnostic: PR2P264MB0528:EE_
x-microsoft-antispam-prvs: <PR2P264MB052858C079AC932EE6DF988EED3B9@PR2P264MB0528.FRAP264.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XPkUbsQotGALQagmYM617ig7Bgv0kw4LRCeQalrz+CMbcs7DPGilgaxZHMgaePklFyTP0pgyp6aP7fdz9RDndDQS2bhRN7xkB2eCDgqlkYMnpLwFALIDkObUBWQYCEINZBc3AVg5b+kyYSmZpJ/ZsgQqxY9e5QvJboNhyz4Zt9vZBfZQ7nicE+3sEZzG2nl6v4V5Hsexdl7g5uD5wox+JVsp8mK88IazB5wJ/5/RqGsa1O3rwD+tVHVxMCzlsj59wQ9RxjY/5Sve8B4oKIANVhqUK+7O7ALqDRSfoAML65Eryb0M/SLJy4/y16pohXk8uPfmLhQHkBpFlZpVzzgF8VOkG9QxsB/7+u16e9UsSrUNVlghvYaNbNu6Hq4i6R9oiVa4dxYT6Y8hXG+ZJBoLYob5DkLFPw1JrvWT8Jr6E/wsQcxYHzAyQB02I3MJ+Z5IaG6O4lfWdo/D1w0X1ygHNLNBUAQMjjA8IvLYITj9fFOeNNgxKurglQGy7r0j67YAdgzRkYZD91QCP59TidweO1mLPmuD6Q4GZraNXGz+T+LtNTUQoJcOCPo6bo9sWsAYeaf8srx9MB25L0i3d9q6R/ufslUDxaEqGOIIVKb0AOEnbwFPqtY2Og+sP4aqYhwSNAcsErmC8SN0Fy1ydmKnpywUr2IHlFS6jXulwlchQn38hDUBuX/AKJI4Pk7+EiL0MUGF1bAsTrj6F1+hd/pmpj6lpMWIzQxOI4yTgaWGraH/2szsvoEJQmyOjixC/WQHv2+mTL7Lekuni6tWstLwZw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(2616005)(71200400001)(6506007)(38070700005)(6486002)(6512007)(31686004)(2906002)(38100700002)(508600001)(66476007)(186003)(5660300002)(64756008)(66946007)(4326008)(66446008)(91956017)(110136005)(66556008)(26005)(8936002)(66574015)(316002)(44832011)(122000001)(31696002)(86362001)(8676002)(76116006)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T0Z6R3hFczgwY0xncGxMNksvOFJua0I2S2E2SG50N3hnQjB0K3dNYzltYytj?=
 =?utf-8?B?YW5aTUt5NEpzY0s0MUNhNXZuczNMdTg0MFhmejJIQmo2WG5ETHRCN2FJeE5R?=
 =?utf-8?B?RFBjYkVwL3NWNng0aXZvOTl2bGtqcU5HalNMUzQ3ZlFwRjlscTB4WkJTRXpW?=
 =?utf-8?B?NnIyMTUydDBXN05QR01jZzVjeEl3U1htbzlZeEJWSXdJZDJPcW1xZWFBY0tS?=
 =?utf-8?B?M3JUSzNnMWZOVTh1dGFiR0FFb3NmUzRVTE1WT1NINFIxd0R2QjVtdjV1VTdO?=
 =?utf-8?B?aGxGTjVUYW9xelZQalZBTm9RRUpQQUpuSGE4Ukh2UmRMME5XanY4a2NTU3Jo?=
 =?utf-8?B?dTA3SG43c25XOWRMWEJnZE9xZzhaTFA0dElCZ05mMTRxSXhLc0NSalZEZnQy?=
 =?utf-8?B?S28xcklqVmpQZjJCdnRpYlEwV2dEaW1pcG5ST3plZU56T044NDV3ZjhjU2Ny?=
 =?utf-8?B?a2NuZVdwUG1XVE85Tko0YklnZkZyVU0vODE3eWVXRUFYMWd2Q2J6SGs1dGpT?=
 =?utf-8?B?aHdUR2hGZUdpdmRMM2hBbnZtbS9GeGx3R3QzUVdldGJlVjFRb3hNUUlnQThV?=
 =?utf-8?B?YytkRnBibnVHTHBSUEIxTkQxK0RRcDB1N0pCU3NmRE91TEpBWS8zNE9ONGZi?=
 =?utf-8?B?dUgxT0Z5WUxOZDN5aVg1VDh1aWhHL0hxSTdzT0NSSnNTSHBMZTQzTHFUSFJi?=
 =?utf-8?B?dTRtUmpBTGNqY1lEZEZreE5xRUFaOEkwaXlablgrRzVaajU5b1hEc2ZHT0Qz?=
 =?utf-8?B?OFlRNWFMa3BKZHMvWUNUanUvOWZXbnpJdFBsNWQrRzlHd09IRzJJY3dFQlBq?=
 =?utf-8?B?QmZIRlo3NnNoYTRnOG5xb1d5b21EUGRicnlxN3doZ1pwZzRVWC9IRGtLMC9R?=
 =?utf-8?B?YTQ3N2VocDJuYXpBSG5jbXhGYTJmRlBQTkVjMkhzeVc0TEgwM1VOY0haNVAv?=
 =?utf-8?B?OFI4MTF6YUY1WWNkc0lIY0NNb1dmU016N29tdEZtSEJka2UrRkdob1U5Z3lU?=
 =?utf-8?B?RGhIVGtPNFB5bmlzd1V6Y0tmYjkzb0YrNmowRE9FRHYwVFliaGFGRHJaV3Z2?=
 =?utf-8?B?aFdEa2dLdEk3UUNtK1laWnArOEprMHZ1K0pIaWM4R2Jjb0VNS203QzcxdnJR?=
 =?utf-8?B?a01lUmZKOUJpWVEvaEhQSDIrUHlvakQ5M1RwYnRZM3ZrcUttZ2RndWQyeVZq?=
 =?utf-8?B?QmhjaTIyYktLKzNWVktrMWNZUzZZSm1BaTUrcmYwQldVcFo3VlVlWkpZaDND?=
 =?utf-8?B?eFRvZ3NRMXo3emcvRmlOa2oxV3JSYytiRzV4a1pKbVlWS3VGLzdwV0ZrNkFX?=
 =?utf-8?B?SXN0bUJwMUNtNGx5ZHBwcXRUR1lQYWtCVHIwZFl5S3IzdjJNZThVc2pBcFAz?=
 =?utf-8?B?UFZFTTM4Q3psRHR6NE5hS2huaGVCVlEwaU8xdXY4anpPeUZVdEQ0Z1FZUWZH?=
 =?utf-8?B?REhTQ2dSTG9tcURzZHJrOVhTaDJTdVRiOEoxYTdWbi9ZaXhUalVYa3lrL24z?=
 =?utf-8?B?MnZ5c1ZtN09TQ1BiNnVaaUlWVDhCYkpObmdIRkZHYUk1SklXaWVlMVBPZklM?=
 =?utf-8?B?eWp3NjhFYUFzOHBWSHFOOWM0T3dqVm1QU2xGdXlCT0QvUkFZL2g3Y2NDSllk?=
 =?utf-8?B?R2RpK1oyY2NTY3ZlY0tIQk1tMVRsN1VQMmFOOHdpSllPN1hab3UwdUFqOVZn?=
 =?utf-8?B?dFBDdkl4Q0pnL2lrbUt6WldyS25oV1RPdWJpRTJhWFN1ZStrMFdBeVV1VWp5?=
 =?utf-8?B?R2RhRm1aSCtMOThHbzNHSVVIblZ1am9tSGFoOWZHRnpNczRhNTdtbVkvT1pu?=
 =?utf-8?B?bjZLZWJDWndJamlPcU5LY0NvSGhjZHpxcHNBSTYyRnNUQnR2bE5rVnY5eXI5?=
 =?utf-8?B?bnlqbFRsak01NnN3WWdDRHlwQ0hzTzg1M2N6bFhZekFtWS9IMmQxeGNDR3dH?=
 =?utf-8?B?eDNRYytWbUp1UzhvTHRXRUhXUXkrcHJxMEhRdUQ1bEFlbFFrekduS2xYNFNQ?=
 =?utf-8?B?bThYVEFtaGx4VlpJYUdMbG8zSFVVZWJwM1ZlSldIcTh4TVNDb2hwQlU4S1RO?=
 =?utf-8?B?UEpwWGxTMG9mb0dxTFlHV01EaDhDL3RPU3FET3FyZGhsM0o5K3VoZEFIT2VU?=
 =?utf-8?B?WUpvME9neDQxcis3VXRrRFdWNjR3LzQwMlV3MmNRSHA1RVJqMkFOeTVkUnlL?=
 =?utf-8?B?SDRyVHBmeGM2UWxudnVqN2Qxc1U0elNjRUN6M0tNMTRHaUxYNkl4K014Z3Jm?=
 =?utf-8?Q?yVUJ4QhDjDZRRdEOejyLKbaF4l/doi7Mhv6xLMXlXI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3257335E2825F74D92305BB5F6009AB0@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7510469f-64fd-4613-482f-08d9f61604b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2022 15:14:27.7557
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eu794yHTGgpKrXDJyFHE4kcQrMDx7FnXaHn1jmoef7+lAtrlXp31fe4Txw0LFPfbBizkzJP+RLaLityMDT5PTedp1ey9UCTxRohLDSLcQMM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR2P264MB0528
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDIyLzAyLzIwMjIgw6AgMTY6MTIsIENocmlzdG9waGUgTGVyb3kgYSDDqWNyaXTCoDoN
Cj4gVGhpcyBzZXJpZXMgYXBwbGllcyBvbiB0b3Agb2YgbXkgc2VyaWVzICJBbGxvY2F0ZSBtb2R1
bGUgdGV4dCBhbmQgZGF0YSBzZXBhcmF0ZWx5IiB2NS4NCj4gDQo+IEl0IGRvZXMgc29tZSBjbGVh
bnVwIGFyb3VuZCB0aGUgc2V0dGxpbmcgb2YgbW9kdWxlcydzIGxheW91dCBwYWdlIGZsYWdzOg0K
PiAtIE1ha2UgbW9kdWxlX2VuYWJsZV94KCkgaW5kZXBlbmRlbnQgb2YgQ09ORklHX0FSQ0hfSEFT
X1NUUklDVF9NT0RVTEVfUldYDQo+IC0gUmV1bmlmeSBldmVyeXRoaW5nIGludG8gc3RyaWN0X3J3
eC5jDQo+IC0gQ2hhbmdlIGJpZyBoYW1tZXIgQlVHX09OKClzIGludG8gV0FSTl9PTigpcw0KPiAt
IENoYW5nZSBtaXNsZWFkaW5nIGRlYnVnX2FsaWduKCkgdG8gc3RyaWN0X2FsaWduKCkNCg0KU2Vl
bXMgbGlrZSBJIG1hZGUgYSBiaWcgbWVzcyB3aXRoIHYyLg0KDQpJIHdpbGwgcmVzZW5kIGl0IGFz
IHYzLg0KDQpTb3JyeSBmb3IgdGhhdC4NCg0KQ2hyaXN0b3BoZQ0KDQo+IA0KPiBDaGFuZ2VzIGlu
IHYyOg0KPiAtIFJlYmFzZWQgb24gdG9wIG9mIG15IHNlcmllcyAiQWxsb2NhdGUgbW9kdWxlIHRl
eHQgYW5kIGRhdGEgc2VwYXJhdGVseSIgdjUNCj4gLSBNb3ZlZCB0aGUgS2NvbmZpZyBwYXRjaCBv
dXQgb2YgdGhpcyBzZXJpZXMsIGl0IGlzIGFuIGluZGVwZW5kZW50IGNoYW5nZQ0KPiANCj4gQ2hy
aXN0b3BoZSBMZXJveSAoNCk6DQo+ICAgIG1vZHVsZTogTWFrZSBtb2R1bGVfZW5hYmxlX3goKSBp
bmRlcGVuZGVudCBvZg0KPiAgICAgIENPTkZJR19BUkNIX0hBU19TVFJJQ1RfTU9EVUxFX1JXWA0K
PiAgICBtb2R1bGU6IE1vdmUgbW9kdWxlX2VuYWJsZV94KCkgYW5kIGZyb2JfdGV4dCgpIGluIHN0
cmljdF9yd3guYw0KPiAgICBtb2R1bGU6IFJld29yayBsYXlvdXQgYWxpZ25tZW50IHRvIGF2b2lk
IEJVR19PTigpcw0KPiAgICBtb2R1bGU6IFJlbmFtZSBkZWJ1Z19hbGlnbigpIGFzIHN0cmljdF9h
bGlnbigpDQo+IA0KPiAgIGtlcm5lbC9tb2R1bGUvTWFrZWZpbGUgICAgIHwgIDMgKy0NCj4gICBr
ZXJuZWwvbW9kdWxlL2ludGVybmFsLmggICB8IDI2ICsrKy0tLS0tLS0tLS0NCj4gICBrZXJuZWwv
bW9kdWxlL2thbGxzeW1zLmMgICB8ICA0ICstDQo+ICAga2VybmVsL21vZHVsZS9tYWluLmMgICAg
ICAgfCA1OCArKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgIGtlcm5lbC9tb2R1bGUv
c3RyaWN0X3J3eC5jIHwgNzYgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0N
Cj4gICA1IGZpbGVzIGNoYW5nZWQsIDg4IGluc2VydGlvbnMoKyksIDc5IGRlbGV0aW9ucygtKQ0K
PiA=
