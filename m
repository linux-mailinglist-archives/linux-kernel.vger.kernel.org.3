Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48F0E51E126
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 23:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444509AbiEFVgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 17:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444489AbiEFVgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 17:36:19 -0400
Received: from de-smtp-delivery-213.mimecast.com (de-smtp-delivery-213.mimecast.com [194.104.111.213])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AA32A60DA3
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 14:32:34 -0700 (PDT)
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com
 (mail-zr0che01lp2112.outbound.protection.outlook.com [104.47.22.112]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-22-HQ4TYUV2MOOnx76lfP8Sdw-1; Fri, 06 May 2022 23:32:31 +0200
X-MC-Unique: HQ4TYUV2MOOnx76lfP8Sdw-1
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 GV0P278MB0067.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:1e::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.13; Fri, 6 May 2022 21:32:30 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::c52f:2a3f:8cf5:6144]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::c52f:2a3f:8cf5:6144%4]) with mapi id 15.20.5206.028; Fri, 6 May 2022
 21:32:30 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "frowand.list@gmail.com" <frowand.list@gmail.com>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>, "olof@lixom.net" <olof@lixom.net>,
        "soc@kernel.org" <soc@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Subject: Re: [PATCH v1 24/24] ARM: dts: imx7-colibri: add support for Toradex
 Iris carrier boards
Thread-Topic: [PATCH v1 24/24] ARM: dts: imx7-colibri: add support for Toradex
 Iris carrier boards
Thread-Index: AQHYYWIlPUyByPKumEu29+pGCeiJNa0SXs6A
Date:   Fri, 6 May 2022 21:32:30 +0000
Message-ID: <5c6536a717a5f6952e748c88338b91c955a7f608.camel@toradex.com>
References: <20220506152809.295409-1-marcel@ziswiler.com>
         <20220506155821.297686-1-marcel@ziswiler.com>
In-Reply-To: <20220506155821.297686-1-marcel@ziswiler.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dac67b4b-0c89-4427-75bd-08da2fa7ec99
x-ms-traffictypediagnostic: GV0P278MB0067:EE_
x-microsoft-antispam-prvs: <GV0P278MB0067FF30EAD0985E2B5008D3FBC59@GV0P278MB0067.CHEP278.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: R9jz2fIDUYhxepup8CSUYb0zGJ4AdO8ByY38VRooK9p7rQip03psaJWFHqGwaGtMDZF5zC+rnlamdOpLxiNWh27BVFHn1L+0oBEI5sXqJ6kll5xQ1ryXAse1cQkr/tqKThGVBoWQePkB99hSjbhQvYqUWYqFOCeBnAd1O+8Z77yF3BPHoo2Lb1NRyW/TK6uKKGDXTZI2Px8LJOA+bYZkvxrul5KdHoF9ZnqZSy6UXW6Xafl/ihFRjMXlOD1R2NAmtjFTEueBXjQlszJ2sgZM9vyfxwhbDWwaYYJCxaEcTJf/KD4bHirq+VWcEkB/88ttyYZgtb61nyWPJh3tSGHviS4WVMesmKEUuqQpz4bKm3K2JJitxpk+z9wpEKarvsfzJdSgxL4AcQGXWWZFN17LgTQFsglLlhTk9NFyxVbS7jkiZ0VYcbr9VEnBbyvIWgoUgdFAFTpN//heXr9R/f3gdt3MPsR/lbLrmHLr5Fl0qeS/WaiKSsXywgVRoPstd++cVewj8UkZ37zXF/iCgi72IjsIz5HSBM9d5eA1NhXMkAVk9y6QQZuEl2tirjW6UeJvA29GHlgOAd/Ax+2PL/N+e8xxPrEoxoyoTq2fcUFfx7C4Ag/kLY/BY7u36nOoJfrSpgEomzLnUsp4biq7n3zzJj5sVJ4kh1HVBtx20oHkOjmWpmAdNh0f2NnKMLzyn7LKiv4Hnvw0mR9aADq34qR0o+rN+1xfVhtYSz2K9LE7UP+zqpi2wfZMs1Xj+5oHxllddudN28mDn8A4UFb3CcOoa3O9cu/tO+GY2fCfCDQ2E/8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(376002)(136003)(39850400004)(366004)(396003)(346002)(186003)(76116006)(66556008)(44832011)(66476007)(66946007)(64756008)(66446008)(2616005)(7416002)(83380400001)(122000001)(8936002)(4326008)(5660300002)(38100700002)(38070700005)(6506007)(86362001)(2906002)(8676002)(6916009)(6486002)(316002)(966005)(508600001)(54906003)(71200400001)(6512007)(36756003)(26005);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WGM0cndwbFlmSkY1TjEwTTJGOWpaMXNLUE9BeFlBWVR1SEdvR1J5QUJ0bWYw?=
 =?utf-8?B?R1BIbWtyMVB1bWx1ZnEreGZ5em5FNE0wZWF0a3BnNXJQWjhQd0U1VW5wRDdF?=
 =?utf-8?B?Y3R5MmdJTS9MdEwzZUxjekdtcm5LbjY2aHBJbGxRZUZSWTVKdldRcFA3eSs5?=
 =?utf-8?B?eFo5eWN6OWQ3VDNobEVrUUNWejFkSWdJVEZhTXJ3WUNIa2t0bWl6dHZmVEpu?=
 =?utf-8?B?bzhkYnpaN1RMYTZUT0VZWkxvV0wyaTZzNm5IVUtNcURLYUZBcHFOZXVPd2JC?=
 =?utf-8?B?eUMwR2tqVG5adlZmZEdVVmcxVWMwNFF4OVkyNlJKbXRNSmRzaVNRY0paU21F?=
 =?utf-8?B?bmhsT3REU0J1dE1KeWRHWUswd0V4NXQyK3BQSzdpdDc1eHJ2UFpPc2lOczJw?=
 =?utf-8?B?WDBrdGgrSmNSbklXM004UkF6S2RYb0hkbmhWYm1HaGRHejJ4dEpURWtiQ05l?=
 =?utf-8?B?bE5lZmlYV1ZudTVMRkM2UC9vR1Bsc1F0RXE4aTdCbWlFanlkNEprWjkyUERD?=
 =?utf-8?B?RHlOU296dHM5MXd3clRDNXpNVjh6L3dzdHdLM1VES0liYkdvcFpCdWt5QXB2?=
 =?utf-8?B?SS9pemFEV2txZXFHQnV0RmpkeENHYVIxUWt6Yi9sVkFJVW4vSUxkamhSMHZ6?=
 =?utf-8?B?RzNKZVF6QytWbUdLWGd6SmpaOUJpZi8vNHZneTUxR204dVdQNDhpekQzaTZE?=
 =?utf-8?B?Y2h3WDhFOFFyUWZDTXV6R2dvMUN0dUQrdWdvbkxpcXY0UEV4cEFtL3BvbTQ2?=
 =?utf-8?B?ampERERMV2JFcEdLV3BVTlhqZWtDNGsrU25sQW1hTTN6WjVMUDJKNzNpYXk0?=
 =?utf-8?B?eGpXZTI1Q1FITGEyOFZ6T1M5dUdsdlhhYWgzMXh1bnM3WG15UDNYSEJVZDFj?=
 =?utf-8?B?Z0Ixc1I2aWhkWWV3RXlaMVBvcVA4dXgzNzJ0QnJXbDhPQU92clZMdnRVckxK?=
 =?utf-8?B?YVpiaE9xSlo5a3k3eVpOWm5NbVlWWkdzT0NPMEFaNHhoeS9JajNuYmIxR0xG?=
 =?utf-8?B?eSsxNzZBVVRnNU5xNzN0Qk5BSzA2R2VyM3dnbEFSMEU0TXJjSnhGblFrTmNO?=
 =?utf-8?B?YzNJbDhlMUc1eVhPWFRLajFpL3FLRytpUGEwTndMRC9FWVZGUFN2eWwreUNs?=
 =?utf-8?B?elcxc2pXYnJLVFNyTExXOTdnaVBOZnJjalU2YjVtb3FEWlY3Tlpldm94czlM?=
 =?utf-8?B?SEVlMGRvTytYRGNLVWJ3K0xzbFl2T3paU25FVysxbzR4NlpRMmt0dDNpMjE2?=
 =?utf-8?B?S1lCcXRkZmFEY200eW9YMkFDQjA3R25Ga0NxdXBBai9kVmpoaFZ3Qmw5VFdK?=
 =?utf-8?B?eStPdE5IRTlpb3oyamVGZG9UblB6dkkxL2F3aE9oZVFGWjZjendpeXZZVGpV?=
 =?utf-8?B?WWk1VCtPVkRtRzZQYU5iV1U3dUh2R2I0V3poR0NaOVJ3VG9lc0dYckdsdytn?=
 =?utf-8?B?N0h6cHFoNTg0Z2ozdE9FZWxHVGs0RDhTOUhyNkRaWlV4dnJIOFBLSzlnVTQ1?=
 =?utf-8?B?YkxxTGJQbGtvR0tTRkVGNXk4Y3RJb2M4dDZnUS85cUJtY1V5TGJySU9QbTZu?=
 =?utf-8?B?a0IyWEViT2l4TDcrUVZNcEpJUWZPQTJpSTUyYW5PU2tJVnhSUTNrd1Qra0d4?=
 =?utf-8?B?YWppRDg5ZmZ4cmlob2s0TnJSR3VrQmpsTTJLWkRIcXY5VkN1LzJoWHRGcHRr?=
 =?utf-8?B?RXlRWlExSjB4L1l5aHhVWHE1QnJCNytTc3hvSHlXeGJpemdYcVFhWTVGT3d6?=
 =?utf-8?B?Ykp6OStmMEpPTFdlVHU5N2ptREM2dEkvNzJtUXozTzJOWThHSmdrMGtJVXBU?=
 =?utf-8?B?bVlzdHF5YU5JQ2xSOWlmZUtrUGFXdEhrWGRhNVNTelFLd1dCUzBxZUtyNTdY?=
 =?utf-8?B?QXl6NTNkVHFsQlY5T3FORVVxNUVBak5IbldKVUFuRWdkOXdielR5Zk1xV0Zu?=
 =?utf-8?B?TzZBT2lyU0F4YnBDN1RwZ2RKaDUxaXJUckRFbUlla2NPbzBNblQyckRMOXQ0?=
 =?utf-8?B?YU9mUnZhV3RDQmpwaG9Bb0I2T25UKy9kWUgvZkkzTE84ZXVTSkdtTDE0dHFa?=
 =?utf-8?B?SnRQZ2FJZG51blpkK0xLM0RSWUg5MXduSmFzZVRPQU16dmZlZEloNVFOZ3V4?=
 =?utf-8?B?cVhiVmpEcWpXM2Q3TkJiVnE1TjVRcTduRTYrcW1vQnMxS1U3TUVQZWt4dkxt?=
 =?utf-8?B?OHdWYkNqVWRwSTFpZmloS1dqYVd1aFNOUUhTMFVMeWF2MTFTMzFuK1hCMGVy?=
 =?utf-8?B?TGdwWlZ4ckk5NTRzaSswa3pPR0R2NFhVM2tXeEtYbFJzYUVjakY5T1BQbHFH?=
 =?utf-8?B?dzJLVG5xQ3JqZG42VFN4b2k0Ylp2NjJ1aU1HbDJXVWpWeXFpRngvRm9IWHl3?=
 =?utf-8?Q?O1LGuYcRaMPxKU9y8NHZvyQAy2Cj2Q9PU6/lo?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: dac67b4b-0c89-4427-75bd-08da2fa7ec99
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2022 21:32:30.1713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /fq0TkKVAoGcc11P8OLGbDUATl+MB8emcVU6+CR1kb/wMFcpjNZIB0ljC8xoygbbBUSF7EbtD3hFAOU/KWQb7M7KfKF/CB4tXlr6rYYYw/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0067
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CDE13A77 smtp.mailfrom=marcel.ziswiler@toradex.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <D368003DAA04E346924AA285C31D16F9@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIyLTA1LTA2IGF0IDE3OjU4ICswMjAwLCBNYXJjZWwgWmlzd2lsZXIgd3JvdGU6
DQo+IEZyb206IE1hcmNlbCBaaXN3aWxlciA8bWFyY2VsLnppc3dpbGVyQHRvcmFkZXguY29tPg0K
PiANCj4gQWRkIHN1cHBvcnQgZm9yIFRvcmFkZXggSXJpcywgc21hbGwgZm9ybS1mYWN0b3IgUGlj
by1JVFggQ29saWJyaSBBcm0NCj4gQ29tcHV0ZXIgTW9kdWxlIGZhbWlseSBDYXJyaWVyIEJvYXJk
Lg0KPiANCj4gQWRkaXRpb25hbCBkZXRhaWxzIGF2YWlsYWJsZSBhdA0KPiBodHRwczovL3d3dy50
b3JhZGV4LmNvbS9wcm9kdWN0cy9jYXJyaWVyLWJvYXJkL2lyaXMtY2Fycmllci1ib2FyZA0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogTWFyY2VsIFppc3dpbGVyIDxtYXJjZWwuemlzd2lsZXJAdG9yYWRl
eC5jb20+DQo+IA0KPiAtLS0NCj4gDQo+IMKgYXJjaC9hcm0vYm9vdC9kdHMvTWFrZWZpbGXCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCA2ICsNCj4gwqBhcmNoL2Fy
bS9ib290L2R0cy9pbXg2ZGwtY29saWJyaS1pcmlzLmR0c8KgwqDCoMKgIHzCoMKgIDkgKy0NCj4g
wqBhcmNoL2FybS9ib290L2R0cy9pbXg3LWNvbGlicmktaXJpcy12Mi5kdHNpwqDCoCB8IDExMiAr
KysrKysrKysrKysrKysrKysNCj4gwqBhcmNoL2FybS9ib290L2R0cy9pbXg3LWNvbGlicmktaXJp
cy5kdHNpwqDCoMKgwqDCoCB8IDEwOCArKysrKysrKysrKysrKysrKw0KPiDCoC4uLi9ib290L2R0
cy9pbXg3ZC1jb2xpYnJpLWVtbWMtaXJpcy12Mi5kdHPCoMKgIHzCoCAyMSArKysrDQo+IMKgYXJj
aC9hcm0vYm9vdC9kdHMvaW14N2QtY29saWJyaS1lbW1jLWlyaXMuZHRzIHzCoCAyMSArKysrDQo+
IMKgYXJjaC9hcm0vYm9vdC9kdHMvaW14N2QtY29saWJyaS1pcmlzLXYyLmR0c8KgwqAgfMKgIDgz
ICsrKysrKysrKysrKysNCj4gwqBhcmNoL2FybS9ib290L2R0cy9pbXg3ZC1jb2xpYnJpLWlyaXMu
ZHRzwqDCoMKgwqDCoCB8wqAgNTYgKysrKysrKysrDQo+IMKgYXJjaC9hcm0vYm9vdC9kdHMvaW14
N3MtY29saWJyaS1pcmlzLXYyLmR0c8KgwqAgfMKgIDc4ICsrKysrKysrKysrKw0KPiDCoGFyY2gv
YXJtL2Jvb3QvZHRzL2lteDdzLWNvbGlicmktaXJpcy5kdHPCoMKgwqDCoMKgIHzCoCA1MSArKysr
KysrKw0KPiDCoDEwIGZpbGVzIGNoYW5nZWQsIDU0MCBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9u
cygtKQ0KPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL2FybS9ib290L2R0cy9pbXg3LWNvbGli
cmktaXJpcy12Mi5kdHNpDQo+IMKgY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJtL2Jvb3QvZHRz
L2lteDctY29saWJyaS1pcmlzLmR0c2kNCj4gwqBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9hcm0v
Ym9vdC9kdHMvaW14N2QtY29saWJyaS1lbW1jLWlyaXMtdjIuZHRzDQo+IMKgY3JlYXRlIG1vZGUg
MTAwNjQ0IGFyY2gvYXJtL2Jvb3QvZHRzL2lteDdkLWNvbGlicmktZW1tYy1pcmlzLmR0cw0KPiDC
oGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL2FybS9ib290L2R0cy9pbXg3ZC1jb2xpYnJpLWlyaXMt
djIuZHRzDQo+IMKgY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJtL2Jvb3QvZHRzL2lteDdkLWNv
bGlicmktaXJpcy5kdHMNCj4gwqBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9hcm0vYm9vdC9kdHMv
aW14N3MtY29saWJyaS1pcmlzLXYyLmR0cw0KPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL2Fy
bS9ib290L2R0cy9pbXg3cy1jb2xpYnJpLWlyaXMuZHRzDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJj
aC9hcm0vYm9vdC9kdHMvTWFrZWZpbGUgYi9hcmNoL2FybS9ib290L2R0cy9NYWtlZmlsZQ0KPiBp
bmRleCBiNzExZDQ0MjNiNDIuLjVhOWM4MDVkYmM4NCAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm0v
Ym9vdC9kdHMvTWFrZWZpbGUNCj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvTWFrZWZpbGUNCj4g
QEAgLTcyNiw4ICs3MjYsMTIgQEAgZHRiLSQoQ09ORklHX1NPQ19JTVg3RCkgKz0gXA0KPiDCoMKg
wqDCoMKgwqDCoMKgaW14N2QtY2wtc29tLWlteDcuZHRiIFwNCj4gwqDCoMKgwqDCoMKgwqDCoGlt
eDdkLWNvbGlicmktYXN0ZXIuZHRiIFwNCj4gwqDCoMKgwqDCoMKgwqDCoGlteDdkLWNvbGlicmkt
ZW1tYy1hc3Rlci5kdGIgXA0KPiArwqDCoMKgwqDCoMKgwqBpbXg3ZC1jb2xpYnJpLWVtbWMtaXJp
cy5kdGIgXA0KPiArwqDCoMKgwqDCoMKgwqBpbXg3ZC1jb2xpYnJpLWVtbWMtaXJpcy12Mi5kdGIg
XA0KPiDCoMKgwqDCoMKgwqDCoMKgaW14N2QtY29saWJyaS1lbW1jLWV2YWwtdjMuZHRiIFwNCj4g
wqDCoMKgwqDCoMKgwqDCoGlteDdkLWNvbGlicmktZXZhbC12My5kdGIgXA0KPiArwqDCoMKgwqDC
oMKgwqBpbXg3ZC1jb2xpYnJpLWlyaXMuZHRiIFwNCj4gK8KgwqDCoMKgwqDCoMKgaW14N2QtY29s
aWJyaS1pcmlzLXYyLmR0YiBcDQo+IMKgwqDCoMKgwqDCoMKgwqBpbXg3ZC1mbGV4LWNvbmNlbnRy
YXRvci5kdGIgXA0KPiDCoMKgwqDCoMKgwqDCoMKgaW14N2QtZmxleC1jb25jZW50cmF0b3ItbWZn
LmR0YiBcDQo+IMKgwqDCoMKgwqDCoMKgwqBpbXg3ZC1tYmE3LmR0YiBcDQo+IEBAIC03NDcsNiAr
NzUxLDggQEAgZHRiLSQoQ09ORklHX1NPQ19JTVg3RCkgKz0gXA0KPiDCoMKgwqDCoMKgwqDCoMKg
aW14N2QtemlpLXJwdTIuZHRiIFwNCj4gwqDCoMKgwqDCoMKgwqDCoGlteDdzLWNvbGlicmktYXN0
ZXIuZHRiIFwNCj4gwqDCoMKgwqDCoMKgwqDCoGlteDdzLWNvbGlicmktZXZhbC12My5kdGIgXA0K
PiArwqDCoMKgwqDCoMKgwqBpbXg3cy1jb2xpYnJpLWlyaXMuZHRiIFwNCj4gK8KgwqDCoMKgwqDC
oMKgaW14N3MtY29saWJyaS1pcmlzLXYyLmR0YiBcDQo+IMKgwqDCoMKgwqDCoMKgwqBpbXg3cy1t
YmE3LmR0YiBcDQo+IMKgwqDCoMKgwqDCoMKgwqBpbXg3cy13YXJwLmR0Yg0KPiDCoGR0Yi0kKENP
TkZJR19TT0NfSU1YN1VMUCkgKz0gXA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMv
aW14NmRsLWNvbGlicmktaXJpcy5kdHMgYi9hcmNoL2FybS9ib290L2R0cy9pbXg2ZGwtY29saWJy
aS1pcmlzLmR0cw0KPiBpbmRleCBjZjc3ZDg5NGY2ZDcuLjZlMDQ4ZDY5NmM3NyAxMDA2NDQNCj4g
LS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14NmRsLWNvbGlicmktaXJpcy5kdHMNCj4gKysrIGIv
YXJjaC9hcm0vYm9vdC9kdHMvaW14NmRsLWNvbGlicmktaXJpcy5kdHMNCj4gQEAgLTQwLDExICs0
MCwxMCBAQCAmZ3BpbzIgew0KPiDCoMKgwqDCoMKgwqDCoMKgcGluY3RybC0wID0gPCZwaW5jdHJs
X3VhcnQxX2ZvcmNlb2ZmICZwaW5jdHJsX3VhcnQyM19mb3JjZW9mZj47DQo+IMKgDQo+IMKgwqDC
oMKgwqDCoMKgwqAvKg0KPiAtwqDCoMKgwqDCoMKgwqAgKiB1YXJ0LWEtb24teDEzLWVuYWJsZSB0
dXJucyB0aGUgVUFSVCB0cmFuc2NlaXZlciBmb3IgVUFSVF9BIG9uLiBJZiBvbmUNCj4gLcKgwqDC
oMKgwqDCoMKgICogd2FudHMgdG8gdHVybiB0aGUgdHJhbnNjZWl2ZXIgb2ZmLCB0aGF0IHByb3Bl
cnR5IGhhcyB0byBiZSBkZWxldGVkDQo+IC3CoMKgwqDCoMKgwqDCoCAqIGFuZCB0aGUgZ3BpbyBo
YW5kbGVkIGluIHVzZXJzcGFjZS4NCj4gLcKgwqDCoMKgwqDCoMKgICogVGhlIHNhbWUgYXBwbGll
cyB0byB1YXJ0LWItYy1vbi14MTQtZW5hYmxlIHdoZXJlIHRoZSBVQVJUX0IgYW5kDQo+IC3CoMKg
wqDCoMKgwqDCoCAqIFVBUlRfQyB0cmFuc2NlaXZlciBpcyB0dXJuZWQgb24uDQo+ICvCoMKgwqDC
oMKgwqDCoCAqIHVhcnQtYS1vbi14MTMtZW5hYmxlLWhvZyB0dXJucyB0aGUgVUFSVCB0cmFuc2Nl
aXZlciBmb3IgVUFSVF9BIG9uLiBJZiBvbmUgd2FudHMgdG8gdHVybg0KPiArwqDCoMKgwqDCoMKg
wqAgKiB0aGUgdHJhbnNjZWl2ZXIgb2ZmLCB0aGF0IHByb3BlcnR5IGhhcyB0byBiZSBkZWxldGVk
IGFuZCB0aGUgZ3BpbyBoYW5kbGVkIGluIHVzZXJzcGFjZS4NCj4gK8KgwqDCoMKgwqDCoMKgICog
VGhlIHNhbWUgYXBwbGllcyB0byB1YXJ0LWItYy1vbi14MTQtZW5hYmxlLWhvZyB3aGVyZSB0aGUg
VUFSVF9CIGFuZCBVQVJUX0MgdHJhbnNjZWl2ZXIgaXMNCj4gK8KgwqDCoMKgwqDCoMKgICogdHVy
bmVkIG9uLg0KPiDCoMKgwqDCoMKgwqDCoMKgICovDQo+IMKgwqDCoMKgwqDCoMKgwqB1YXJ0LWEt
b24teDEzLWVuYWJsZS1ob2cgew0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGdw
aW8taG9nOw0KDQpZZXMsIHRoYXQgY2hhbmdlIHRvIGFyY2gvYXJtL2Jvb3QvZHRzL2lteDZkbC1j
b2xpYnJpLWlyaXMuZHRzIHNsaXBwZWQgaW50byB0aGlzIENvbGlicmkgaU1YNyBzcGVjaWZpYyBw
YXRjaCBzZXQNCmJ5IGVycm9yIGFuZCB3aWxsIGJlIHJlbW92ZWQgaW4gYW4gdXBjb21pbmcgVjIu
IFNvcnJ5IGFib3V0IHRoYXQuDQoNCltzbmlwXQ0K

