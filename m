Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 822634C0C9A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 07:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236500AbiBWGfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 01:35:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbiBWGfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 01:35:05 -0500
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90045.outbound.protection.outlook.com [40.107.9.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F046060DBD;
        Tue, 22 Feb 2022 22:34:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J7c6uHrNzmcwTa4yTZblcRgMk76uNqEhibxKpQMPl65W7WbVaC9NY29zXc2Kyada15w6TCxbVIwRK8Tut3qZNfhP3alz0qZDdQaRQPQj9XA2WgfsKNg6RKPU6/fsECSoQy+AIzyhV6BimRvSOwYfiOIT19FWkrt2AttVAOtqcsYanjmzsz1Q7lq/az7hKSI9hMSy+C77CwmoGFdWQuCqafpKaxBrFYSjth+I8z6SxP8o72HREkCJj47VlFivmdKFGmxEoSB5vQjPtVKE/1yGW90CfaieekWYSgvLrf3l9HUbNpO9WDV412OOe00QP8gnf+w7j9ZneGL5+EVkBXPkrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qye22WnU6l5OO5+3aix54BydRV3JIPBhyUDxV7hsWs8=;
 b=PQ2P1X2CKz5PipLBQ0FyvsIQfj6xc95mMZn50rWbNLPjlqs7lTzF1hyzxeIsXpk0tRAS2ZuibrqgR4l2QeEOWAcwSBybAjWTM/LG3jlNfMUE20DEaofopGBoV0Z8JK63ZdZXH93K24g/84ftFrndBaOPHo/hq3bJYqH9tZ6Tt+LE7oQghg0B1orndLV8mVXL6Cq6wwY1PoPm7iKWZCnQT7W4fEFRhuD2+2WbcLWhdqNAVdtFEm15q6DmZdUqp3Q11HRWAkJe+R0ytg8oOwFw5ubn5rudnWWm+3YjIcVMSTWt5P/BT4FUB1wT2HJcVpGUasSDbfgI9teuEUT5ecSATw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MRXP264MB0581.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500:1e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Wed, 23 Feb
 2022 06:34:34 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::8142:2e6f:219b:646d]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::8142:2e6f:219b:646d%5]) with mapi id 15.20.5017.021; Wed, 23 Feb 2022
 06:34:34 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     Aaron Tomlin <atomlin@redhat.com>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/4] Miscellaneous cleanups
Thread-Topic: [PATCH v3 0/4] Miscellaneous cleanups
Thread-Index: AQHYJ/85dfnoz0vqrEeFuKWAfjCOeqygSDqAgABmngA=
Date:   Wed, 23 Feb 2022 06:34:34 +0000
Message-ID: <f0c560b4-6f71-63c3-8cb4-1570f0ec42b2@csgroup.eu>
References: <cover.1645542893.git.christophe.leroy@csgroup.eu>
 <YhV/ZQKsO2rElYdL@bombadil.infradead.org>
In-Reply-To: <YhV/ZQKsO2rElYdL@bombadil.infradead.org>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 179e545c-7caf-4f6b-02f6-08d9f6968e9a
x-ms-traffictypediagnostic: MRXP264MB0581:EE_
x-microsoft-antispam-prvs: <MRXP264MB0581E1ECB6C5B05B45EE225AED3C9@MRXP264MB0581.FRAP264.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /+a/tFxG1SDuJQ3cRE2pbz9Wb6IysA0gzhJqQDpGPIRs34X5h3184j+zP+z06tVi+sbh72JfVb7W7SvPbeGitfFSTfV9pHtRqy8kh/vC3y8OvQSKvAzEul9pB0QWcZFUfSpIYoBGsT6LSh9EQjxK35jzSzgzw4MjfFcTUVC/rl1Yd580r7CWDhDk4PtSVvlBJ0hZ8CGKc6A4EOiVrxemmQjxOF3HafwVBJevGCtkLO111SnEHsWhHzjXcYx3tI1lRcAQdAPXvXocpKTR8l+rpLhppU7RoL77DQ+NUJ9DHSsaWyv8JZi4rpBIZYRDSKDM9qp4CR38t+HAX2ba2J30++HuLegZWvIqRz1pZiM49aZzJ0KglOH9aQxYd1QM3wRmH5WXmMfUbn11Sv5LsQQ2MfMKZ8kR5dHbiZv4IHVEoJX8C6YTxVA3GitAVV+QbU3EYhMAlNdRI+1GCVS1kk/dOp72NUf9ZTShZmkiqBzwv2z5sr4PIcAw8n9Y8C76kLNEia23vPWpWTG9n0AC/IlzX6LwAgz9XL7EEZh1UFl93WTkN3qCVpCZZtUN83h4jQRTJfchC6kzCEQx/2FIvHi+HojCwiNUy6bOMAjwzLj1vsU4oDJN4iC24Y2z0LoQcgqiIiB1uiurcLsTEEWLBEL1/IfZONyK9+SwgtVf+XYewU05V9G4PoWd0/rAEz0XaTE2rYsdAELD0x7Vp46LpCISdE8i73LJY/J8wGNvPbKbfpM6e+wjoe9NDHh2eXQJ4Q7wAUY0u7KlAmzIkBz1j+BW2A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38070700005)(66476007)(66446008)(186003)(64756008)(26005)(4326008)(8676002)(66556008)(36756003)(66946007)(316002)(91956017)(76116006)(2616005)(2906002)(122000001)(86362001)(38100700002)(31686004)(31696002)(54906003)(44832011)(66574015)(5660300002)(8936002)(83380400001)(508600001)(71200400001)(6512007)(6486002)(6506007)(6916009)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YzZmT2s1OGkxYUVQNVNLUXVFNmRtRHFCSTFvY3VHdlNsd2M5MFNoVGdYZVh5?=
 =?utf-8?B?ZDU1TzI5U0VtNUFXYVR0M2dSRXFDWk40WGF2RGVJUVpLdkZRTGpNMUVwVUZi?=
 =?utf-8?B?MW9iZE84bWQ2eVdDM3FQNnczMGRwem0vM1FtVDhCeFJ1Y2kvbW5WTHZpRW9t?=
 =?utf-8?B?c1BHTE5uaGM4S3pubEtBK3NFL2J2Nmp5Y1Q1QWNPZkZMNmlITWZ4Uy9XeUhk?=
 =?utf-8?B?R0g0WWJXSmd1TW5VcTEyMjZOMlZWWkhkZEhiby9YOGh5RlJaNU55OUo1SWg4?=
 =?utf-8?B?clVTSEVqb2ZVVlBsS3RvcWVNeDZkRk9OQ2E2WjBGbWgyZ1JKaWtmQUY2SmJL?=
 =?utf-8?B?QTI5ZXA0V3BFbEVwZFQ4c1hMZjBFaTg1Wk9ZckNwdDNrNTRCV0c4KzU5cVVB?=
 =?utf-8?B?Q0RnUkxGQ0lLV1luVDNPUDh4ZmRsUWl4bDhWL01LQ3dZVksrS3JyWEpnbUd4?=
 =?utf-8?B?TGhnNHpKV2pCaVExQ0RKOTVwMnpBWjhXNS8yek9WMythK3F2L0NqOEdkV1VI?=
 =?utf-8?B?SFpQN0hicjFucWJCd0RnajZYaXV6NW5vcEJWVjBWS0h6VFJxWXVFYTl2dEkw?=
 =?utf-8?B?Y1dTUEpGOXEvRHNpOHFXa3QvWFZPb3RNNGRlV004YzEzQlVjNG4raUU4Y0F2?=
 =?utf-8?B?Zi9CSG1Vb0hUOTNGRmdFNUVYQkxsQzBvUW13ZFhDQk9FdnZTZW1wdHVWSWtH?=
 =?utf-8?B?TFYvRlljSGxVUithVEt4alVMUTVXbjFxYkJWUkEzWS9SUUVvMVlqUFUvYmNM?=
 =?utf-8?B?MnRQbnBYUmg4bFkwNDh6YVFURFkrODFxZ3ludFNLblFLODlvMjc2R29Nck1t?=
 =?utf-8?B?dWdRQThLUDY0V0FLRCt3UDJtb3BFRkQvdk1JbVlpck1nbGFYYWlnenhZbmx4?=
 =?utf-8?B?UmpWTkFiRGsvZzU3L3psSDBtOTJHUjJKbWZseGZVNGd2S2pxZTlxTHdUZERl?=
 =?utf-8?B?dW5Mdyt1bG9DaWxVSzBYYmJ3YXlRcHpFbmF6aUdUeERPRUxQY1ZSczIyMWVO?=
 =?utf-8?B?WDdveGVqZjNkWkJzbkVVMUtJaXBzbEZxK2xuUHBuVjNFTU5wVGJ4VjVlNnFI?=
 =?utf-8?B?VzFqWkplMGNEYkdjU2Q0TUJTaGlDTlF0SnROTmhoN1NTZ094T0MzYWhJVGJx?=
 =?utf-8?B?cERhaXRlSkoxSTdRZzZjWkJMOUpvcmVWUloxNzhjUE81ZUFyMWFpY0kzeHh3?=
 =?utf-8?B?UEtNT2ZidFBCOVNaaW5QMzNIcDVTSWduYks4RTMzN01RN2pzRGgyNklWbldz?=
 =?utf-8?B?QWNZSkx6MEtTaHFRendQa01pb1YwZ2c0dDMxRGJWbDR6SEVZcGd2RmVoTkxy?=
 =?utf-8?B?TkZ1RjNZQzFScHBoODJmQkViTU5sQ0ZBd0wvTHRFSHd3VWlsQVptaDlLbXFm?=
 =?utf-8?B?d09oTkJVV2Y5bzFKcDVkbUxLeDJIZHRPQW9DcSs1TEExRG1sL3hHMDR1T0dX?=
 =?utf-8?B?azhkcGRQQ2pMU0ZudklHYUhwT0t2UWRpL1Awd0Q1Tm9pNXpmMGRBVjVxOXJl?=
 =?utf-8?B?SUREUFI1ZVFkeEhQcDhkc01BWVpIN1liTzZUVUJXdldIbVNaMWE3VkhkdEV3?=
 =?utf-8?B?MUdkZU4zaFROZncwT2wrc0RFQmxpai9jc0Z4cEZxVGRWM0hRUXNUNExObVF6?=
 =?utf-8?B?RldzeTJEZHVRbjExZTdVcEVjSGRlMUZlVG1sQmEyQW5SdWxVMGxPejB3Ymlz?=
 =?utf-8?B?dXd4Tjgyak9IUzFqV28xSlh6M3JBby96TmlxbktncU1GMS83Tkw3ajdmY05i?=
 =?utf-8?B?UFpNdW5sR3lUTmNRUlNYWW11cU5vdkVjdDJuNGFSMEQ1Q2pmWURGcm1COFIr?=
 =?utf-8?B?b0VZcGprZ2dCUE5BVmdIZVpjcGxkWS9OQ0x5bEw0eUFpTUIxWkRaVlRhci9P?=
 =?utf-8?B?MnRtakdnY0RQUzZpK09zTDhBZEFiTWZma3V2dUlSelVzMmZHNXgxZDFNcGkr?=
 =?utf-8?B?R01Md2NVeCt0VGRLeTNDM0Nnc0ZRK2w1U1JwZ3JWTWlDU2k5UXBWMHVncTJY?=
 =?utf-8?B?SkZZeG1HdkpKaVZRRDdkU0U3c3plS0Nna2puWVdmSDhUQXYzU3Exb0pEeExV?=
 =?utf-8?B?MVpINkJpQzlWMWlGNHc0Tk5BakNhamZtM0lXODlGZHV4bXpMYmRrSGZvS0xD?=
 =?utf-8?B?Mi9iTHpsWjZ1UFo0eUwyYVRxcmdOaVQyVXpBTXU4RTkybGs0K1BFem5oQzEw?=
 =?utf-8?B?eWxtVTQ3UHF0eTc2NWIrWE8vWUgwb2Q3N1lpQ2hZclY4Nk9TNGNsTTRDSkw0?=
 =?utf-8?Q?zQ1M70b8SudtCxf1qemS0Fd8fp+YbqZhSwt28E3ImY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D9137136EF8E6D488800CEAEC48AD4E6@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 179e545c-7caf-4f6b-02f6-08d9f6968e9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2022 06:34:34.6527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 34LNeKwAMD+5NzhzP/l7QJSoo67azpDgRqtR/52dIxFqaILVqDpomjSf3PBbG5PAvuRGalf2t4phPEeIzab5cdo16i0m4FP9z/bmhBBgYEs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRXP264MB0581
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDIzLzAyLzIwMjIgw6AgMDE6MjcsIEx1aXMgQ2hhbWJlcmxhaW4gYSDDqWNyaXTCoDoN
Cj4gT24gVHVlLCBGZWIgMjIsIDIwMjIgYXQgMDQ6MTY6MzBQTSArMDEwMCwgQ2hyaXN0b3BoZSBM
ZXJveSB3cm90ZToNCj4+IFRoaXMgc2VyaWVzIGFwcGxpZXMgb24gdG9wIG9mIG15IHNlcmllcyAi
QWxsb2NhdGUgbW9kdWxlIHRleHQgYW5kIGRhdGEgc2VwYXJhdGVseSIgdjUuDQo+Pg0KPj4gSXQg
ZG9lcyBzb21lIGNsZWFudXAgYXJvdW5kIHRoZSBzZXR0bGluZyBvZiBtb2R1bGVzJ3MgbGF5b3V0
IHBhZ2UgZmxhZ3M6DQo+PiAtIE1ha2UgbW9kdWxlX2VuYWJsZV94KCkgaW5kZXBlbmRlbnQgb2Yg
Q09ORklHX0FSQ0hfSEFTX1NUUklDVF9NT0RVTEVfUldYDQo+PiAtIFJldW5pZnkgZXZlcnl0aGlu
ZyBpbnRvIHN0cmljdF9yd3guYw0KPj4gLSBDaGFuZ2UgYmlnIGhhbW1lciBCVUdfT04oKXMgaW50
byBXQVJOX09OKClzDQo+PiAtIENoYW5nZSBtaXNsZWFkaW5nIGRlYnVnX2FsaWduKCkgdG8gc3Ry
aWN0X2FsaWduKCkNCj4+DQo+PiBDaGFuZ2VzIGluIHYyL3YzOg0KPj4gLSBSZWJhc2VkIG9uIHRv
cCBvZiBteSBzZXJpZXMgIkFsbG9jYXRlIG1vZHVsZSB0ZXh0IGFuZCBkYXRhIHNlcGFyYXRlbHki
IHY1DQo+PiAtIE1vdmVkIHRoZSBLY29uZmlnIHBhdGNoIG91dCBvZiB0aGlzIHNlcmllcywgaXQg
aXMgYW4gaW5kZXBlbmRlbnQgY2hhbmdlDQo+Pg0KPj4gU29ycnkgZm9yIHRoZSBtZXNzIGluIHYy
Lg0KPiANCj4gVGhhbmtzIGZvciBhbGwgdGhpcyB3b3JrISBBbnkgY2hhbmNlIHlvdSBjYW4gYWN0
dWFsbHkgc3VibWl0IHRoaXMgcHJpb3INCj4gdG8geW91ciBhbGxvY2F0ZSBtb2R1bGUgc2VyaWVz
PyBUaGlzIGFuZCB0aGUgcGF0Y2gsICJtb2R1bGU6IE1vdmUNCj4gbW9kdWxlJ3MgS2NvbmZpZyBp
dGVtIGluIGtlcm5lbC9tb2R1bGUvIi4gQmVjYXVzZSAqaWZmKiB3ZSBnZXQgZW5vdWdoDQo+IHRl
c3Rpbmcgb3V0IG9mIEFhcm9uJ3MgY2hhbmdlcyBhbmQgeW91ciBjbGVhbnVwcywgcGVyaGFwcyB0
aG9zZSBtaWdodA0KPiBiZSBjYW5kaWRhdGVzIGZvciB0aGUgbmV4dCBtZXJnZSB3aW5kb3cuIFRo
ZW4gd2UgY2FuIHNhdmUgYWxsIHRoZSBuZXcNCj4gZnVuY3Rpb25hbCBjaGFuZ2VzIGZvciB0aGUg
b3RoZXIgbWVyZ2Ugd2luZG93Lg0KPiANCg0KU3VyZSBJIGNhbiBzd2l0Y2ggdGhlIHR3byBzZXJp
ZXMuDQoNClRoZSBLY29uZmlnIHBhdGNoIGlzIGluZGVwZW5kYW50LCB5b3UgY2FuIGFscmVhZHkg
YXBwbHkgaXQgaW4gYW55IG9yZGVyLCANCkkgd29uJ3QgcmVzZW5kIHVubGVzcyBJIGdldCBjb21t
ZW50cyBvbiBpdC4NCg0KQ2hyaXN0b3BoZQ==
