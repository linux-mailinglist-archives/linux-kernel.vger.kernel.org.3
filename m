Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 695AF51BB1B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 10:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350773AbiEEJAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 05:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbiEEI76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 04:59:58 -0400
Received: from de-smtp-delivery-213.mimecast.com (de-smtp-delivery-213.mimecast.com [194.104.109.213])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5261A17AA8
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 01:56:19 -0700 (PDT)
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com
 (mail-zr0che01lp2106.outbound.protection.outlook.com [104.47.22.106]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-5-SnRjOy6qM8qR1mhJ_KteDw-1; Thu, 05 May 2022 10:56:11 +0200
X-MC-Unique: SnRjOy6qM8qR1mhJ_KteDw-1
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 ZR0P278MB0235.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:35::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.13; Thu, 5 May 2022 08:56:09 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::c52f:2a3f:8cf5:6144]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::c52f:2a3f:8cf5:6144%4]) with mapi id 15.20.5206.027; Thu, 5 May 2022
 08:56:09 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "soc@kernel.org" <soc@kernel.org>,
        "frowand.list@gmail.com" <frowand.list@gmail.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Denys Drozdov <denys.drozdov@toradex.com>,
        "alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "matthias.schiffer@tq-group.com" <matthias.schiffer@tq-group.com>,
        "marex@denx.de" <marex@denx.de>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>,
        "leoyang.li@nxp.com" <leoyang.li@nxp.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Max Krummenacher <max.krummenacher@toradex.com>
Subject: Re: [PATCH v2 00/14] ARM: dts: imx6ull-colibri: device tree
 improvements
Thread-Topic: [PATCH v2 00/14] ARM: dts: imx6ull-colibri: device tree
 improvements
Thread-Index: AQHYWMDrkguBdVFYI0mLpdSkg5mHma0Po20AgABm/oA=
Date:   Thu, 5 May 2022 08:56:09 +0000
Message-ID: <5fa5fa975a4db152e2f3a92d6ea6dd4c3536eba6.camel@toradex.com>
References: <20220425162356.176665-1-marcel@ziswiler.com>
         <20220505024732.GO14615@dragon>
In-Reply-To: <20220505024732.GO14615@dragon>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 69c63afd-c616-4da1-b5ab-08da2e751967
x-ms-traffictypediagnostic: ZR0P278MB0235:EE_
x-microsoft-antispam-prvs: <ZR0P278MB0235C7650E3FBE17B07518E1FBC29@ZR0P278MB0235.CHEP278.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: ftlFLIBnL2mPqk+z0XL8rpmLZFtsb2JcHkcLfbC1ZBFDj6thZhfrXtrZM4eifDT/YzebcZ+K0VJlxLPVusGEeCSGyVpNu0RbL7X1vtl9+jsaVClIohYpPotnHAyuZtM9PcaZ9qxykwMKBULA5QEMBrQ+tXW5ZG6tzaI08Xe9NgJs2q/R2QQB0Y2b/m7yGzekMbnzZ/JIb+TnR14Pejov0xtNiTElUrtfPxnYEjC61uTuIsb3dbJgpeBtl/sQxKztl5vLw6OICmsIKoEv3V3rdoyfqYcxdPsgp3fknbBhGKtuKszC4uUb1FoE8KXhMbxfqC9yXBMO9d8Mq9GsxoIABJPxuPqMhSRw4T77HQl58o5TKuAIQ3qwKGxbo5t3uVVsF/zAAKIWtx4DGJd3i7WDJ8lzJ3Ru9M4C/HVxr/gck7cz8D463/1+F4wcLrReUTGzYCMmct/oU6IXEjQdmuYbikjNlMRaHG10NKDIo7q/LTpSzA0fflt9dbDAKhKMz3cAgz2SCQOxOVOlXLihPPl7eVXERc7NzbnYqWjCEtcZYOU7bqsxgRTPhrfFxmSXAMxSQieQBMZhC1AmKxrictDrQ5+mfcj4AdMTc2T+DFPHBtUOk9pfJ2/O2ilTxUv8d7WexJ1zVPf/orA+NzF4/vla+Q3Was3d4RiRcqp1Geo9SqtE8EwoglY1c/iXPIahqBTUZEc3myphi7XqUhUOo9RfcdHDZE58BDbMD27zuElVys0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(346002)(136003)(376002)(396003)(39850400004)(366004)(508600001)(83380400001)(36756003)(2906002)(26005)(6512007)(6506007)(76116006)(316002)(122000001)(86362001)(8936002)(5660300002)(38070700005)(38100700002)(6916009)(44832011)(71200400001)(54906003)(186003)(4326008)(8676002)(2616005)(107886003)(66476007)(64756008)(6486002)(7416002)(66946007)(66556008)(66446008)(32563001);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OTc4YWFWVmp1STdPeTBueURNYWRYYVNnQlZwSnBMeC9BT0hpSTkzRDA2Y3NF?=
 =?utf-8?B?aVBzQ0tYaWk3UVBldGl1REp4VEI3cTRUekRWZ3hidUVSbHdtZlovVnVEcTFq?=
 =?utf-8?B?R1k4NnhGaFBldENITE1uK3BGRnZRR1hranRWMGxQVEZ3MlFjNG5wSm5Ec3ky?=
 =?utf-8?B?S01xOS8vR05HVlBDTGwzZkxVdGhyRzBnc25iTHhmM0x5SjU2MjFaYjVGeFVy?=
 =?utf-8?B?RWNpRWpaQkJxUW9ucm1GUVkxTzFiVkxUV0FwYWtMTTdRZW93cDFpRDUrVnJN?=
 =?utf-8?B?WnRYZFMzcmZKRWJjbXhJSmVRQlJNRXdXTHNWN1Nud2tlaVhmNWk1ZXBZK1FV?=
 =?utf-8?B?dUZNM202TG5RUUt2ZU00b1dVczdvTW4xM3dRaGlKTTNtVUdYU3BxU25VTFRa?=
 =?utf-8?B?K2ErRXhRVE1QRngweXVPYnJuZTBscGY2NStjdGFzemxrMGxSOVRFeHRvWjhv?=
 =?utf-8?B?aW8xenMvUWg4UG9QNkRCb1R6TUlrNGJYYjYyVVc0UDdEbHVDR3YvV293dks5?=
 =?utf-8?B?MTBhS2FPcWE5UTM2T2t3T0M1N0FKMjJnRDBRQklMZnVLT0lHTEFKbUtxTTJa?=
 =?utf-8?B?MkpwaFB2ZFRwdE8vUHg1WjRhakVjdDgxTUdVTXhBU1dUZjR0MmdmYWs3MDFy?=
 =?utf-8?B?TjFkR05QVGp1Vm4xL21iRm5abVlERDcweHk5K2NmT090WFljZS9jbUVUMWpk?=
 =?utf-8?B?L3BodmlCRHlsTmhsNHFEeEdFajNBemNNUUQ1U1dFMjRCaWdxbnVOQUlSUXhr?=
 =?utf-8?B?SjU5b01GQ1dlbysxT1JwdjZpblhHZnI2aFI1eEgvUVYyVmV6dzR0UnJxa1Na?=
 =?utf-8?B?RnhITXI0ZG5rcFpoZTgzNDdoREI1dFp3TkNWNDFwWVNBNVR5SGFWS0hJVkRB?=
 =?utf-8?B?WEcvazRqYnk5SjM3S0RmcHBZaTZISWRMYTBPQk1nT2tXOWNWRkExWjBvSjZl?=
 =?utf-8?B?Mm53TlpKS0Jkam9iVVdyRE5vYTl4am5iTXNTNmxYS2dXeG9XZmNsc3FDYStQ?=
 =?utf-8?B?R3RJZ0pOR0NTdmZwK2cxYUgxdHlEL0lrMmZkR3lsN3Vab0phSVIzN1N4TGVD?=
 =?utf-8?B?emt1NHlDVllGaWR2ejQycXlkdFp5TisvalZMdGljUk5SeENVc1g1QmlpSzh5?=
 =?utf-8?B?ZDhiUC9vU3lHbGVaT213Rk56YWtEZThyVTJhRWZ3QldxRUpxOHpGRzFWR0tH?=
 =?utf-8?B?OHFkenFRRy9WOWdsV0xCWFZvY282VXFJcXNoSTdseEo5Z1VQSFZGTnp1UWNI?=
 =?utf-8?B?aTlwQ05hZEJ3TTRaaUY0Q05UaXRaNUJOSDZWVDJrRVA2dTlkTVJ1NGdsVFJq?=
 =?utf-8?B?Tzlrb0lyWlJXMFg5aGhYdlgyeHRORDcxeFd5eDhMK3JGNENzTytQa2JWaFV4?=
 =?utf-8?B?MklNN2FjVU91QndGWE9kM09KM3JhYTVPNEYxc1BGNHhWbGRxNitDRlNVTGpk?=
 =?utf-8?B?cFBlTDhDZVB2NW1nNGptK2VWK09pcDR3aldtT1B2bjdEQ1VnU0FxUzV5MnFN?=
 =?utf-8?B?c3hLYUhwV2hVcFB1YXI1d1doSDhPakQ3UDJPbklQK2JrNVlLWXlTcFNqOXpF?=
 =?utf-8?B?QXpWMU1JS2U3NittcUY2eDBMTU9BSXppSlYvOTV3c2pzT0ozZzNPUDZaNzZm?=
 =?utf-8?B?ckVOUEhsYTQ5eXRteS93RDBxNXRYdjlmc2VjM0hUS3dDSlF5b2VtUXVzWUtU?=
 =?utf-8?B?RmhSTGhTdXRvQS81NTkyZHBzRk9IVDAwSlExakQ5YndqbGxod1RKSEJNd3NL?=
 =?utf-8?B?MFBQRWd1Z1F6eUV2Rlg2alorQThHUFhiNDdjNzdaVmhMUEZaNkNWb1BSRzVF?=
 =?utf-8?B?ZXJocDdVc0F5ZWVWUzNyaHcvTk9kUTgrWjY5eTNjVE1oa0ZYYVNQdXR6T09Z?=
 =?utf-8?B?N1ZaTmtPZkJrb2M2VE12Mm9MeGRwVWVtMDJDUnVMMDBqbHdZd091QXFMWHN1?=
 =?utf-8?B?WkU4TVQrUXBuZUFXUlhlUUlxSVlYRW5RRHdDQXpwUTJ4aklHNVVBeEFJV3RM?=
 =?utf-8?B?cFJVcVJTcmxGbUhOYkFsOFlrOHRGSWJyZVVDQUJaMjJZNmVxOWtXeTZTMjJH?=
 =?utf-8?B?SXJXOWN4YlhDNWs3ZmwvZERiRUpISzIzMEdjTXIyT1pScjhzemVURXRZRjZY?=
 =?utf-8?B?TXpvMkFFM3JwSDBkaWNyVFcwRkhzYjdCM1IwTFBaR3pNLzdTc2o3Rko3NllR?=
 =?utf-8?B?RDU4Q2tva2dOU0JwcjNWa2NyMXViRTMwZmJPVGJJUDFwbHVuRmJjcXJ2R2li?=
 =?utf-8?B?VlZ6NTVrREN1b1ErWVp0SGtWUi9RTlRlNGVKeHFjNDViTFNYOE9DUmU4QW5v?=
 =?utf-8?B?K2NEcUlDK2FLYkUrLzhqUzBtSTd6QWpINnZzK2Z2Z01wa0lhNVB1Q0VXU3Nw?=
 =?utf-8?Q?4f3inlfSMYF/r12EbI7/AeG2+w96BXrO4FkjS?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 69c63afd-c616-4da1-b5ab-08da2e751967
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2022 08:56:09.8468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AbUryZvRoyVi2uTHlk1cdceRVPegbOczpEdmq/zIw4hbW0coYtUjfz3Rv1sjxGXuV4O+di00VQpcNQeSIx/A/Axa1T6QxdiLo1SYFCJypK0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0235
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CDE13A77 smtp.mailfrom=marcel.ziswiler@toradex.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <78A87E3DE32C4844B167DE87D51AFCAD@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU2hhd24NCg0KT24gVGh1LCAyMDIyLTA1LTA1IGF0IDEwOjQ3ICswODAwLCBTaGF3biBHdW8g
d3JvdGU6DQo+IE9uIE1vbiwgQXByIDI1LCAyMDIyIGF0IDA2OjIzOjQyUE0gKzAyMDAsIE1hcmNl
bCBaaXN3aWxlciB3cm90ZToNCj4gPiBGcm9tOiBNYXJjZWwgWmlzd2lsZXIgPG1hcmNlbC56aXN3
aWxlckB0b3JhZGV4LmNvbT4NCj4gPiANCj4gPiANCj4gPiBUaGlzIGlzIGEgZ2VuZXJhbCB1cGRh
dGUgb2YgdGhlIENvbGlicmkgaU1YNlVMTCBkZXZpY2UgdHJlZSBmaWxlcy4NCj4gPiANCj4gPiBU
aGUgVG9yYWRleCBDb2xpYnJpIGZhbWlseSBpcyBjb21wb3NlZCBvZiBhIFNvTSB0aGF0IGNhbiBi
ZSBwbHVnZ2VkIG9uDQo+ID4gdmFyaW91cyBjYXJyaWVyIGJvYXJkcywgd2l0aCBjYXJyaWVyIGJv
YXJkcyBhbGxvd2luZyBtdWx0aXBsZSBvcHRpb25hbA0KPiA+IGFjY2Vzc29yaWVzIChlLmcuIGRp
c3BsYXksIGNhbWVyYSwgLi4uKS4NCj4gPiANCj4gPiBUaGUgZGV2aWNlIHRyZWUgc291cmNlcyBh
cmUgc3RydWN0dXJlZCBpbnRvIGEgU29NIGR0c2kgYW5kIGEgY2FycmllciBkdHMNCj4gPiB3aGlj
aCB0aGVuIGluY2x1ZGVzIHRoZSBTb00gZHRzaS4gVGhlIFNvTSBkdHNpIGRlZmluZXMgYW5kIGVu
YWJsZXMgdGhlDQo+ID4gZnVuY3Rpb25hbGl0eSBzZWxmLWNvbnRhaW5lZCBvbiB0aGUgU29NIGFu
ZCBwcmVwYXJlcyBmb3IgdGhlDQo+ID4gZnVuY3Rpb25hbGl0eSBwcm92aWRlZCBieSB0aGUgY2Fy
cmllciBIVyBvciBhY2Nlc3NvcmllcyBzbyB0aGF0IHRoZQ0KPiA+IGNhcnJpZXIgZHRzIHRoZW4g
Y2FuIGVuYWJsZSBvciBhbWVuZCBub2RlcyBwcm92aWRlZC4gQWNjZXNzb3JpZXMgYXJlDQo+ID4g
ZW5hYmxlZCBpbiBvdmVybGF5cyBkZXBlbmRpbmcgb24gSFcgY29uZmlndXJhdGlvbi4NCj4gPiAN
Cj4gPiBQbGVhc2UgZmluZCB0aGUgZm9sbG93aW5nIGNvbGlicmktaW14NnVsbCBkZXZpY2UgdHJl
ZXMgaW1wcm92ZW1lbnRzOg0KPiA+IA0KPiA+IC0gTU1DL1NEDQo+ID4gVGhlIG9yaWdpbmFsIENv
bGlicmkgc3BlY2lmaWNhdGlvbiBvbmx5IGRlZmluZWQgMy4zIHZvbHQgVFRMIHNpZ25hbGluZw0K
PiA+IGFuZCByZWxpZWQgb24gZXh0ZXJuYWwgb24tY2FycmllciBwdWxsLXVwcyBmb3IgdGhlIFNE
X0RBVEFbMC4uM10gbGluZXMuDQo+ID4gVGhlIGxhdGVzdCBjYXJyaWVyIGJvYXJkcyBsaWtlIEly
aXMgVjIgb24gdGhlIG90aGVyIGhhbmQgYXJlIG5vdyBVSFMtSQ0KPiA+IGNvbXBsaWFudCBieSBs
ZWF2aW5nIHN1Y2ggZXh0ZXJuYWwgb24tY2FycmllciBwdWxsLXVwcyBhd2F5IHJlbHlpbmcgb24N
Cj4gPiBtb2R1bGUtIG9yIGV2ZW4gU29DLWxldmVsIG9uZXMgd2hpY2ggcHVsbCB1cCB0byByZXNw
LiBzaWduYWxpbmcgdm9sdGFnZS4NCj4gPiBJbiBzdWNoIGNhc2VzLCB0aGUgY2FycmllciBib2Fy
ZC1sZXZlbCBkZXZpY2UgdHJlZSBtYXkgZXhwbGljaXRseSBkZWxldGUNCj4gPiB0aGUgbm8tMS04
LXYgcHJvcGVydHkgdG8gZW5hYmxlIGZ1bGwgVUhTLUkgc3VwcG9ydC4NCj4gPiBBbHNvLCBmaXgg
U0QvTU1DIHJlZ3VsYXRvciBmb3IgdGhlIGNhcnJpZXIgYm9hcmRzIHVzaW5nIFVIUy1JIG1vZGVz
Lg0KPiA+IA0KPiA+IC0gRkVDDQo+ID4gUHJvdmlkZSBhIHByb3BlciBwaHktc3VwcGx5IGZvciB0
aGUgRkVDLCBhY3R1YWxseSBzd2l0Y2hlZCBieSB0aGUgNTAgTWh6DQo+ID4gUk1JSSBpbnRlcmZh
Y2UgY2xvY2sgdXNpbmcgYSByZWd1bGF0b3ItZml4ZWQtY2xvY2sgdGhhdCBpcyBub3cgcHJvcGVy
bHkNCj4gPiBzdGF0ZWQuIFRoZSByZWZlcmVuY2UgY29tbWl0IGZvciBzdWNoIHJlZ3VsYXRvciBj
YW4gYmUgZm91bmQgYXQgY29tbWl0DQo+ID4gODk1OWU1MzI0NDg1ICgicmVndWxhdG9yOiBmaXhl
ZDogYWRkIHBvc3NpYmlsaXR5IHRvIGVuYWJsZSBieSBjbG9jayIpLg0KPiA+IA0KPiA+IC0gSTJD
DQo+ID4gU3dpdGNoZWQgb24gMjIga09obSBwdWxsLXVwcyBhbmQgbG93ZXIgdGhlIEkyQyBmcmVx
dWVuY3kgdG8gNDAga0h6IHRvDQo+ID4gZ2V0IG1vcmUgcmVsaWFibGUgY29tbXVuaWNhdGlvbi4N
Cj4gPiANCj4gPiAtIEF0bWVsIFRvdWNoc2NyZWVuDQo+ID4gVGhlIFRvcmFkZXggNyIgQ2FwYWNp
dGl2ZSBhbmQgMTAiIExWRFMgdG91Y2ggc2NyZWVucyBhcmUgQXRtZWwgTVhUDQo+ID4gcGVyaXBo
ZXJhbHMgYXZhaWxhYmxlIG9uIHRoZSBJMkMgYnVzIGZvciB0b3VjaHNjcmVlbiBldmVudHMuIEFk
ZA0KPiA+IGF0bWVsX214dF90cyBub2RlIHRvIHRoZSBtb2R1bGUtbGV2ZWwgZGV2aWNlIHRyZWUu
IEFsc28sIHByb3ZpZGUgcGlubXV4DQo+ID4gY29uZmlndXJhdGlvbiBmb3IgdGhlIElOVC9SU1Qg
aW5wdXRzIGZyb20gU09ESU1NIHBpbnMgMTA2LzEwNyBmb3IgbW9zdA0KPiA+IGNhcnJpZXIgYm9h
cmRzIG9yIGFuIGV4dGVybmFsIHRvdWNoc2NyZWVuIGFkYXB0ZXIgaW5wdXRzIGNvbmZpZ3VyZWQg
dG8NCj4gPiBTT0RJTU0gcGlucyAyOC8zMC4NCj4gPiANCj4gPiBDaGFuZ2VzIGluIHYyOg0KPiA+
IC0gRml4ZWQgcGluY3RybCBub2RlIG5hbWVzIGFzIHN1Z2dlc3RlZCBieSBTaGF3bi4NCj4gPiAt
IEZpeGVkIGxvbmcgbGluZSBhcyBwb2ludGVkIG91dCBieSBSb2IncyBib3QuDQo+ID4gLSBBZGRl
ZCBWMyB0byBDb2xpYnJpIEV2YWx1YXRpb24gQm9hcmQgYXMgZG9uZSBlbHNld2hlcmUuDQo+ID4g
LSBGaXggYWxwaGFiZXRpY2FsIG5vZGUgb3JkZXIgYXMgc3VnZ2VzdGVkIGJ5IFNoYXduLg0KPiA+
IC0gRHJvcHBlZCBbUEFUQ0ggdjEgMDIvMTRdIEFSTTogZHRzOiBpbXg2dWxsLWNvbGlicmk6IGZp
eCB2cW1tYw0KPiA+IMKgIHJlZ3VsYXRvciB3aGljaCBhbHJlYWR5IGdvdCBhcHBsaWVkIGJ5IFNo
YXduLiBUaGFua3MhDQo+ID4gLSBOZXcgY29tbWl0IHdpdGggcGluY3RybCBub2RlIG5hbWUgaW1w
cm92ZW1lbnRzIGFzIHN1Z2dlc3RlZCBieSBTaGF3bi4NCj4gPiANCj4gPiBEZW55cyBEcm96ZG92
ICg1KToNCj4gPiDCoCBBUk06IGR0czogaW14NnVsbC1jb2xpYnJpOiBhZGQgdG91Y2hzY3JlZW4g
ZGV2aWNlIG5vZGVzDQo+ID4gwqAgQVJNOiBkdHM6IGlteDZ1bGwtY29saWJyaTogdXBkYXRlIGRl
dmljZSB0cmVlcyB0byBzdXBwb3J0IG92ZXJsYXlzDQo+ID4gwqAgZHQtYmluZGluZ3M6IGFybTog
ZnNsOiBhZGQgdG9yYWRleCxjb2xpYnJpLWlteDZ1bGwNCj4gPiDCoCBBUk06IGR0czogaW14NnVs
bC1jb2xpYnJpOiBhZGQgc3VwcG9ydCBmb3IgdG9yYWRleCBpcmlzIGNhcnJpZXIgYm9hcmRzDQo+
ID4gwqAgQVJNOiBkdHM6IGlteDZ1bGwtY29saWJyaTogYWRkIHN1cHBvcnQgZm9yIHRvcmFkZXgg
YXN0ZXIgY2Fycmllcg0KPiA+IMKgwqDCoCBib2FyZHMNCj4gPiANCj4gPiBNYXJjZWwgWmlzd2ls
ZXIgKDQpOg0KPiA+IMKgIEFSTTogZHRzOiBpbXg2dWxsLWNvbGlicmk6IGZpeCBuYW5kIGJjaCBn
ZW9tZXRyeQ0KPiA+IMKgIEFSTTogZHRzOiBpbXg2dWxsLWNvbGlicmk6IGFkZC91cGRhdGUgc29t
ZSBjb21tZW50cw0KPiA+IMKgIEFSTTogZHRzOiBpbXg2dWxsLWNvbGlicmk6IG1vdmUgZ3Bpby1r
ZXlzIG5vZGUgdG8gc29tIGR0c2kNCj4gPiDCoCBBUk06IGR0czogaW14NnVsbC1jb2xpYnJpOiBp
bXByb3ZlIHBpbmN0cmwgbm9kZSBuYW1lcw0KPiA+IA0KPiA+IE1heCBLcnVtbWVuYWNoZXIgKDEp
Og0KPiA+IMKgIEFSTTogZHRzOiBpbXg2dWxsLWNvbGlicmk6IGNoYW5nZSB0b3VjaCBpMmMgcGFy
YW1ldGVycw0KPiA+IA0KPiA+IE9sZWtzYW5kciBTdXZvcm92ICgxKToNCj4gPiDCoCBBUk06IGR0
czogaW14NnVsbC1jb2xpYnJpOiBhZGQgZ3Bpby1saW5lLW5hbWVzDQo+ID4gDQo+ID4gUGhpbGlw
cGUgU2NoZW5rZXIgKDMpOg0KPiA+IMKgIEFSTTogZHRzOiBpbXg2dWxsLWNvbGlicmk6IHVzZSBw
dWxsLWRvd24gZm9yIGFkYyBwaW5zDQo+ID4gwqAgQVJNOiBkdHM6IGlteDZ1bGwtY29saWJyaTog
YWRkIHBoeS1zdXBwbHkgdG8gZmVjDQo+ID4gwqAgQVJNOiBkdHM6IGlteDZ1bGwtY29saWJyaTog
dXBkYXRlIHVzZGhjMSBwaXhtdXggYW5kIHNpZ25hbGluZw0KPiANCj4gVGhlIGR0cyBzZXJpZXMg
ZG9lc24ndCBhcHBseSB0byBteSBicmFuY2guDQo+IA0KPiBBcHBseWluZzogQVJNOiBkdHM6IGlt
eDZ1bGwtY29saWJyaTogdXNlIHB1bGwtZG93biBmb3IgYWRjIHBpbnMNCj4gQXBwbHlpbmc6IEFS
TTogZHRzOiBpbXg2dWxsLWNvbGlicmk6IGNoYW5nZSB0b3VjaCBpMmMgcGFyYW1ldGVycw0KPiBB
cHBseWluZzogQVJNOiBkdHM6IGlteDZ1bGwtY29saWJyaTogYWRkIHBoeS1zdXBwbHkgdG8gZmVj
DQo+IEFwcGx5aW5nOiBBUk06IGR0czogaW14NnVsbC1jb2xpYnJpOiBhZGQgdG91Y2hzY3JlZW4g
ZGV2aWNlIG5vZGVzDQo+IEFwcGx5aW5nOiBBUk06IGR0czogaW14NnVsbC1jb2xpYnJpOiB1cGRh
dGUgdXNkaGMxIHBpeG11eCBhbmQgc2lnbmFsaW5nDQo+IGVycm9yOiBwYXRjaCBmYWlsZWQ6IGFy
Y2gvYXJtL2Jvb3QvZHRzL2lteDZ1bGwtY29saWJyaS5kdHNpOjM1DQo+IGVycm9yOiBhcmNoL2Fy
bS9ib290L2R0cy9pbXg2dWxsLWNvbGlicmkuZHRzaTogcGF0Y2ggZG9lcyBub3QgYXBwbHkNCj4g
UGF0Y2ggZmFpbGVkIGF0IDAwMDUgQVJNOiBkdHM6IGlteDZ1bGwtY29saWJyaTogdXBkYXRlIHVz
ZGhjMSBwaXhtdXggYW5kIHNpZ25hbGluZw0KPiBoaW50OiBVc2UgJ2dpdCBhbSAtLXNob3ctY3Vy
cmVudC1wYXRjaCcgdG8gc2VlIHRoZSBmYWlsZWQgcGF0Y2gNCj4gV2hlbiB5b3UgaGF2ZSByZXNv
bHZlZCB0aGlzIHByb2JsZW0sIHJ1biAiZ2l0IGFtIC0tY29udGludWUiLg0KPiBJZiB5b3UgcHJl
ZmVyIHRvIHNraXAgdGhpcyBwYXRjaCwgcnVuICJnaXQgYW0gLS1za2lwIiBpbnN0ZWFkLg0KPiBU
byByZXN0b3JlIHRoZSBvcmlnaW5hbCBicmFuY2ggYW5kIHN0b3AgcGF0Y2hpbmcsIHJ1biAiZ2l0
IGFtIC0tYWJvcnQiLg0KPiANCj4gQXBwbHlpbmc6IEFSTTogZHRzOiBpbXg2dWxsLWNvbGlicmk6
IHVwZGF0ZSBkZXZpY2UgdHJlZXMgdG8gc3VwcG9ydCBvdmVybGF5cw0KPiBBcHBseWluZzogQVJN
OiBkdHM6IGlteDZ1bGwtY29saWJyaTogYWRkIGdwaW8tbGluZS1uYW1lcw0KPiBBcHBseWluZzog
QVJNOiBkdHM6IGlteDZ1bGwtY29saWJyaTogYWRkIHN1cHBvcnQgZm9yIHRvcmFkZXggaXJpcyBj
YXJyaWVyIGJvYXJkcw0KPiBBcHBseWluZzogQVJNOiBkdHM6IGlteDZ1bGwtY29saWJyaTogYWRk
IHN1cHBvcnQgZm9yIHRvcmFkZXggYXN0ZXIgY2FycmllciBib2FyZHMNCj4gQXBwbHlpbmc6IEFS
TTogZHRzOiBpbXg2dWxsLWNvbGlicmk6IGZpeCBuYW5kIGJjaCBnZW9tZXRyeQ0KPiBBcHBseWlu
ZzogQVJNOiBkdHM6IGlteDZ1bGwtY29saWJyaTogYWRkL3VwZGF0ZSBzb21lIGNvbW1lbnRzDQo+
IGVycm9yOiBwYXRjaCBmYWlsZWQ6IGFyY2gvYXJtL2Jvb3QvZHRzL2lteDZ1bGwtY29saWJyaS5k
dHNpOjI1MQ0KPiBlcnJvcjogYXJjaC9hcm0vYm9vdC9kdHMvaW14NnVsbC1jb2xpYnJpLmR0c2k6
IHBhdGNoIGRvZXMgbm90IGFwcGx5DQo+IFBhdGNoIGZhaWxlZCBhdCAwMDExIEFSTTogZHRzOiBp
bXg2dWxsLWNvbGlicmk6IGFkZC91cGRhdGUgc29tZSBjb21tZW50cw0KPiBoaW50OiBVc2UgJ2dp
dCBhbSAtLXNob3ctY3VycmVudC1wYXRjaCcgdG8gc2VlIHRoZSBmYWlsZWQgcGF0Y2gNCj4gV2hl
biB5b3UgaGF2ZSByZXNvbHZlZCB0aGlzIHByb2JsZW0sIHJ1biAiZ2l0IGFtIC0tY29udGludWUi
Lg0KPiBJZiB5b3UgcHJlZmVyIHRvIHNraXAgdGhpcyBwYXRjaCwgcnVuICJnaXQgYW0gLS1za2lw
IiBpbnN0ZWFkLg0KPiBUbyByZXN0b3JlIHRoZSBvcmlnaW5hbCBicmFuY2ggYW5kIHN0b3AgcGF0
Y2hpbmcsIHJ1biAiZ2l0IGFtIC0tYWJvcnQiLg0KPiANCj4gQXBwbHlpbmc6IEFSTTogZHRzOiBp
bXg2dWxsLWNvbGlicmk6IG1vdmUgZ3Bpby1rZXlzIG5vZGUgdG8gc29tIGR0c2kNCj4gQXBwbHlp
bmc6IEFSTTogZHRzOiBpbXg2dWxsLWNvbGlicmk6IGltcHJvdmUgcGluY3RybCBub2RlIG5hbWVz
DQo+IGVycm9yOiBwYXRjaCBmYWlsZWQ6IGFyY2gvYXJtL2Jvb3QvZHRzL2lteDZ1bGwtY29saWJy
aS5kdHNpOjI5Mg0KPiBlcnJvcjogYXJjaC9hcm0vYm9vdC9kdHMvaW14NnVsbC1jb2xpYnJpLmR0
c2k6IHBhdGNoIGRvZXMgbm90IGFwcGx5DQo+IFBhdGNoIGZhaWxlZCBhdCAwMDEzIEFSTTogZHRz
OiBpbXg2dWxsLWNvbGlicmk6IGltcHJvdmUgcGluY3RybCBub2RlIG5hbWVzDQo+IGhpbnQ6IFVz
ZSAnZ2l0IGFtIC0tc2hvdy1jdXJyZW50LXBhdGNoJyB0byBzZWUgdGhlIGZhaWxlZCBwYXRjaA0K
PiBXaGVuIHlvdSBoYXZlIHJlc29sdmVkIHRoaXMgcHJvYmxlbSwgcnVuICJnaXQgYW0gLS1jb250
aW51ZSIuDQo+IElmIHlvdSBwcmVmZXIgdG8gc2tpcCB0aGlzIHBhdGNoLCBydW4gImdpdCBhbSAt
LXNraXAiIGluc3RlYWQuDQo+IA0KPiBTaGF3bg0KDQpJIGRpZCByZWJhc2UgdGhpcyBWMiBvbiB0
b3Agb2YgeW91ciBmb3ItbmV4dCBicmFuY2ggd2hpY2ggYXMgb2YgdG9kYXkgc3RpbGwgYXBwbGll
cyBjbGVhbmx5LiBIb3dldmVyLCBpdCBsb29rcw0KbGlrZSB5b3Ugbm93IHRyeSB0byBhcHBseSBp
dCB3aXRob3V0IHRoZW0gZml4ZXMgd2hpY2ggYXJlIGFscmVhZHkgdXBzdHJlYW0uIEhvdyBleGFj
dGx5IGlzIHRoaXMgc3VwcG9zZWQgdG8NCndvcms/DQoNCkluIHBhcnRpY3VsYXIgaXQgaXMgdGhl
IGZvbGxvd2luZyBjb21taXQgd2hpY2ggYWxyZWFkeSBnb3QgYXBwbGllZCB1cHN0cmVhbToNCg0K
Y29tbWl0IDQ1OTc0ZTQyNzZhOCAoIkFSTTogZHRzOiBpbXg2dWxsLWNvbGlicmk6IGZpeCB2cW1t
YyByZWd1bGF0b3IiKQ0KDQpJZiBJIGRvIHJlLWJhc2UgYSBWMyBvbiB0b3Agb2YgeW91ciBkdCBi
cmFuY2ggKHdpdGhvdXQgdXBzdHJlYW0gYWxyZWFkeSBhcHBsaWVkIGZpeGVzKSB0aGVuIGl0IGxp
a2VseSBmYWlscw0KYWdhaW4gd2hlbiBpdCBldmVudHVhbGx5IGdldHMgYXBwbGllZCBvbiB0b3Ag
b2YgdGhlbSBmaXhlcywgbm90Pw0KDQpBbnl3YXksIGp1c3QgbGV0IG1lIGtub3cgb24gdG9wIG9m
IHdoYXQgSSBzaG91bGQgcmUtYmFzZSB0aGlzIHNlcmllcyBhbmQgSSB3aWxsIGRvIHNvLiBUaGFu
a3MhDQoNCkNoZWVycw0KDQpNYXJjZWwNCg==

