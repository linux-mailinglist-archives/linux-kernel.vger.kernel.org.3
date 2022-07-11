Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDD957040A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 15:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbiGKNR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 09:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiGKNRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 09:17:25 -0400
X-Greylist: delayed 355 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 11 Jul 2022 06:17:23 PDT
Received: from us-smtp-delivery-162.mimecast.com (us-smtp-delivery-162.mimecast.com [170.10.129.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2833ED55
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 06:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hp.com; s=mimecast20180716;
        t=1657545442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MqYOMtvV6peSEhSN0WLCzjAXE4OBKnA5rR5fMzI1/O4=;
        b=d5QQZvNy66VKws6wQHtfzSI8YaKqBOlrTs7TLrbEcqyMNTYxcr/3+eQGXfE77CTcvnBUkg
        EAV5A62QwtccKFvENvUqSM2GO/agxEt47HjvZjYkqYqdQvvdUV7H8XYTKISnNNcXaqy/Zd
        Bvqrl8/5sTJKfX2AF15Er7+yjQi21/M=
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-246-KVK_JjppNsic-Wtt1Lmprw-1; Mon, 11 Jul 2022 09:10:13 -0400
X-MC-Unique: KVK_JjppNsic-Wtt1Lmprw-1
Received: from PH0PR84MB1953.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:160::10)
 by PH0PR84MB1672.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:160::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Mon, 11 Jul
 2022 13:10:11 +0000
Received: from PH0PR84MB1953.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::880d:1bb8:7f9e:19cc]) by PH0PR84MB1953.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::880d:1bb8:7f9e:19cc%7]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 13:10:11 +0000
From:   "Lopez, Jorge A (Security)" <jorge.lopez2@hp.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Alex Dewar <alex.dewar@gmx.co.uk>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "tiwai@suse.de" <tiwai@suse.de>,
        "markgross@kernel.org" <markgross@kernel.org>
CC:     "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Subject: RE: input/i8042: Malfunctioning brightness keys on HP Elite Dragonfly
 G2
Thread-Topic: input/i8042: Malfunctioning brightness keys on HP Elite
 Dragonfly G2
Thread-Index: AQHYlR8s56cSTJIX+UqJ5MPQFYzlza15IwvQ
Date:   Mon, 11 Jul 2022 13:10:11 +0000
Message-ID: <PH0PR84MB195309F5BA5B96858024E61FA8879@PH0PR84MB1953.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220629094314.b7xmfb3xccj7vs6v@ic-alex-elitebook>
 <3fedf676645bfa638c9a6c656121083abc2c98ea.camel@gmx.co.uk>
 <8b893c42-e514-bcef-0513-070b3723cdcc@redhat.com>
 <df7313597d2ac3212f10c05aa3d369728f030c86.camel@gmx.co.uk>
 <c89d39eb-17b9-8800-c8ff-8d236b80de2f@redhat.com>
In-Reply-To: <c89d39eb-17b9-8800-c8ff-8d236b80de2f@redhat.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-bromium-msgid: b02d3f79-ed5b-4e49-a1d4-8863e6b815a7
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2a11d15a-11db-4586-c7b1-08da633eafd3
x-ms-traffictypediagnostic: PH0PR84MB1672:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: bPLk7LXfD4RFQi9W00Azk+CyPeETA0n4RaiTrkTo0fdfim+54Nu9dg7KkYSwzukHsaWG79ahqiyK05wd+ftDskQ733CZCO4jVC8jEu3lcDKs6WyqSxotu5gdY/f3oKDPRGGbx26gCZTG/lof9/+mi98scI2sgHnq/6vb3MHqp+krNvAqDuCwzxj2LS2Jb6U5bIhOWd9wzXeWEvUhop9GWRgZDaBLt13VKMOFZLc5v3W2Yc0TyIvFVu+Z6mfbHZXX2WwrYT8IyvvZhjnXg0BnJjp2sRgsFVXeQaV/rZoh2OHegiwatPc7jkU10lrrBe2nbI5p5JoSgsT6E7fOEQAf7ny6sKGJaGpRa6m6mM7V7ksj+TibNVV1KBsXsSFCE9jxynnZwvNcYgstL7uRwgqmqPFP2EngTNytSG/zpISOuuCo7xkEtx5BrRbZlJM1MClJaBW+4gg5RQMgdBWvPg8gsq0QgBRNUCkiMbmGcFR39KyFB68aYQws8B1mYDohictzsXl9naculX/eEccWdGMHQjDQ+WPF8pWC3VF6hV3ieyD23/Buf9jrxL6rC1KxmRmMG+U/WSVAs0kwhx+rh0HRJHxHTbz7zKENhYuEat1nReLGUOEYEZl4PGO1fNWMMyP4APr2qU/yc06HdiGVdX8+zBOAXm72PvcGjuXTJqfrQrg10depaS8tU/FQ3JacAgShpPW3TxajCE+OQApNl+IzceNEXVAmrcFokScSMm+SIn2k3gq54E8som1HQhDszGSnT/wDPQsjMI3gTyP5fwrQyBUw73rRoBoM40LcrNTe047QDWc1BG3AZnRm6Ocbov5L
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR84MB1953.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(396003)(39860400002)(346002)(376002)(136003)(366004)(84040400005)(316002)(76116006)(66946007)(66556008)(83380400001)(66446008)(66476007)(64756008)(8676002)(4326008)(5660300002)(7696005)(6506007)(26005)(9686003)(54906003)(110136005)(186003)(38070700005)(53546011)(71200400001)(86362001)(478600001)(55016003)(2906002)(41300700001)(38100700002)(33656002)(122000001)(52536014)(8936002)(82960400001);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YmxrRjRhdHhWVWJFNEtVUjZscG1WczNoQ1ZzeTNLNi9walhZMzk2VURyNkJp?=
 =?utf-8?B?L1FPS2tHYmJrWEhURTRBSm9JaGxGM1pHMVVlUDdFZm9EcE1mQ2p0SUVNOHpy?=
 =?utf-8?B?TWZZT2RUYWhHbUV1emVMcTFId1B3aW8wUjNjbjM0bjJ3dXdHckF5cng5R0NY?=
 =?utf-8?B?OTcwTGYyOVZHWjFmamVGdlVmdXBSQjUxVW5yNEtzMVJ5M2RuVVltV2hYbmdr?=
 =?utf-8?B?SFZQNTdHYURpbk0yTmNGaUMraSsrRDRTQjhmUEQwWkRqeEJlZmdCb1QxQllK?=
 =?utf-8?B?ZmE4MVI4aU5qa0ZpUWJPcUpKVTZNUGJSRWIyYWdCVGF4bmlDemUvYWE0Y2Y5?=
 =?utf-8?B?RE9wVyt5d1NwT3I5dzVmUWNkc1NxYWMvRDZMMHN6d002RE0ybUZ5OEloWm9o?=
 =?utf-8?B?QS80dFBoRWVwaUhGaDlwZTJQZFp3NklWOVNhTklTTUg2VlRVRzUxTHhwY0Vy?=
 =?utf-8?B?bCt0Y3FWKzZEKzVQcHNVeGpISXdUMlV3TStBbmZmeVVNVjk1aW8rZFgzSGFD?=
 =?utf-8?B?M09PeFhRZlYzRGMxS1NUMkd6L3hMaVRiVWtWT0FlZTdZTDYyVUFZV096VUow?=
 =?utf-8?B?UXJqWHEvSkhDQzNUT0dGUS9wc3N0eHlKcFRsR2QvazAwZWJvenpKaU9QaUFQ?=
 =?utf-8?B?VnFmVXRLM0R2UjJ6eDdzclA4a1NBSjQxd0xRN1l6OE5pWUcvSUN3c2laUjYv?=
 =?utf-8?B?aG9ZTFEraWVLUXM4MnpNelJGVXRrVnBWeWVCMVQ3R1Avekg3OE5oOWc5dENl?=
 =?utf-8?B?blc2Z3poVzRKc0NtMFhJcFJQSENGdWxuWmpLUkduTGhqYnlwVUFKZGFNdHov?=
 =?utf-8?B?U1FreTNoeGVUMnMvdkhnMmh2Ykpvd1o4RC9DWGNaRHZVaXFnUGRyUHRBKzNy?=
 =?utf-8?B?M1RxY1IvZWUycjhsRzFjNXo3MCtEWEdPUEVhQS9KZXFDSCsyc1FGRFp4Q0tJ?=
 =?utf-8?B?SllyNHE1TWxCTTJrSjNreHJNUUlzRTZZd2RwSGo1S0VJcVNvYXBRb2N0RVlJ?=
 =?utf-8?B?NDRnUDQzWXhxUmJTUmNudHJaYnVQWFZQai80azdWZFhvbFI1a1JtcmdUVysx?=
 =?utf-8?B?KzM0VGpzT3hVNzVtQ1oyRFRXTDRZa3VPRk5KZmorNlRZdVc2N1JxVkF4RWwx?=
 =?utf-8?B?N0E5UVJUU3lHOURnTXh3UWJOVE52K0tnQXZDRU5PZkFGZzhlY3hlY2thTmIx?=
 =?utf-8?B?dEhxQVVnZzZuaU8yVXo5d1krK1RDaHREOHNrZWJRdDVMY1lwN1BqZ2tDMVVL?=
 =?utf-8?B?YUlGRWN3aDlyM0dUQUI4blhWYWJCdHV3S3cydmFENnFUMnI5a1UzVU01Wk11?=
 =?utf-8?B?UmVaV0p2RlBNbU1BRTBJdnlTUERCMVNOUjQ3TnNrd1NmZndrd3NIN2tsZ1Q0?=
 =?utf-8?B?WWFjdGgxbVNBQzM5Wlk5TXdCVFIyV1UybktOSVpDU1NXRmtxSHRpODlkaXJV?=
 =?utf-8?B?cnR3T2haejdlREw4VjBtN1V0L3VEcDlkNGVybjJDU05lQ1ZRaXZpNVZnbHFT?=
 =?utf-8?B?MDVJK2U4aFltTXVYVWFVMERuUGNiKzgwSkdFWTIrVW53cXI0cnk2dE5rbmE3?=
 =?utf-8?B?cWUrVWdOdEY4WGgxY3M5T29yZzJOd3ZJMkMvbkhDd0pJLzVkb2hPREdNbkZt?=
 =?utf-8?B?WmZKYjJUUmlmM1A5bjMvMlg5allBVDh6UDVUUmJGaTd1WVpvbkozZmsydmVV?=
 =?utf-8?B?ejJtU0tCWG5CZDdqdHRvK1ZjV3hGUkxRamgxMzFSSVNUVHNHZWk4WVVVT0RI?=
 =?utf-8?B?TE4vVnBkbXg5MjN2NFF0WDJqeHZHdzliNEdGZEg2QVZrbkRhNWxuTktVa0JD?=
 =?utf-8?B?UmNDUXlxWEQ1c1p4bWNWVnZIRnhDKzlkcXU1d0xXVzgyUllYYTJWMU5CSlVJ?=
 =?utf-8?B?TjlwZEI2c0haRTJIY0t6VGRHVnZKeGZsT0NScWVzMHBBOFBlNVowQmxPclNv?=
 =?utf-8?B?USt2T0UrbmR5bFROeCtnQ3hsaUhoRDNYdi9UdSs0TE5jaGFDRW01elQ0aGhu?=
 =?utf-8?B?T1ZzSFlkcDE0L2RSb0psdU5UVnFVSjVQSWtsYmJEekZkdzdNaW5odXdNMVZE?=
 =?utf-8?B?K2NnWjlVYVNCZE5zUkpkYy9xbnErYmszTHkvZGVhL3VxY0lYMHFoWEVWdVdx?=
 =?utf-8?Q?cDTryDcmffbwVvGDBlJUNRz1U?=
MIME-Version: 1.0
X-OriginatorOrg: hp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR84MB1953.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a11d15a-11db-4586-c7b1-08da633eafd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2022 13:10:11.5204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ca7981a2-785a-463d-b82a-3db87dfc3ce6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: se6P5DdHxDw1P6jdeNXkQqbrOKbsJwnLG7+g7ZlBqyloREKzmdU0whZZ64u4ZMoklvEHnzdYFPqOrBqL9qobiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR84MB1672
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA62A171 smtp.mailfrom=jorge.lopez2@hp.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: hp.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQWxleCwNCg0KTGV0IG1lIGludmVzdGlnYXRlIHRoaXMgaXNzdWUuICBUaGUgZHJpdmVyIG1h
cHMgc29tZSBrZXlzLCBzbyBpdCBpcyBwb3NzaWJsZSB0aGUgbGlzdCBpcyBpbmNvbXBsZXRlLiAg
DQpJdCBpcyBleHBlY3RlZCBocF93bWkgZHJpdmVyIHRvIGJlIGxvYWRlZCwgQ29ycmVjdD8NCkNh
biB5b3UgcHJvdmlkZSB0aGUgQklPUyB2ZXJzaW9uIGN1cnJlbnQgaW4geW91ciBzeXN0ZW0/DQoN
Cg0KUmVnYXJkcywNCg0KSm9yZ2UgTG9wZXoNCkhld2xldHQtUGFja2FyZCANCg0K4oCcT25jZSB5
b3Ugc3RvcCBsZWFybmluZywgeW91IHN0YXJ0IGR5aW5n4oCdDQpBbGJlcnQgRWluc3RlaW4NCg0K
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEhhbnMgZGUgR29lZGUgPGhkZWdvZWRl
QHJlZGhhdC5jb20+IA0KU2VudDogTW9uZGF5LCBKdWx5IDExLCAyMDIyIDc6MTAgQU0NClRvOiBB
bGV4IERld2FyIDxhbGV4LmRld2FyQGdteC5jby51az47IGRtaXRyeS50b3Jva2hvdkBnbWFpbC5j
b207IHRpd2FpQHN1c2UuZGU7IG1hcmtncm9zc0BrZXJuZWwub3JnOyBMb3BleiwgSm9yZ2UgQSAo
U2VjdXJpdHkpIDxqb3JnZS5sb3BlejJAaHAuY29tPg0KQ2M6IGxpbnV4LWlucHV0QHZnZXIua2Vy
bmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgcGxhdGZvcm0tZHJpdmVyLXg4
NkB2Z2VyLmtlcm5lbC5vcmcNClN1YmplY3Q6IFJlOiBpbnB1dC9pODA0MjogTWFsZnVuY3Rpb25p
bmcgYnJpZ2h0bmVzcyBrZXlzIG9uIEhQIEVsaXRlIERyYWdvbmZseSBHMg0KDQpIaSBBbGV4LA0K
DQpPbiA3LzExLzIyIDA5OjQ5LCBBbGV4IERld2FyIHdyb3RlOg0KPiBIaSBIYW5zLA0KPiANCj4g
T24gU2F0LCAyMDIyLTA3LTA5IGF0IDE2OjU2ICswMjAwLCBIYW5zIGRlIEdvZWRlIHdyb3RlOg0K
Pj4gSGksDQo+Pg0KPj4gT24gNy81LzIyIDE5OjI1LCBBbGV4IERld2FyIHdyb3RlOg0KPj4+IEZy
aWVuZGx5IHBpbmc/IPCfmYINCj4+Pg0KPj4+IEknbSBhbHNvIENDJ2luZyB0aGUgeDg2IHBsYXRm
b3JtIHBlb3BsZSBpbnRvIHRoaXMsIGFzIEknbSBub3Qgc3VyZSANCj4+PiB3aGV0aGVyIHRoaXMg
cHJvYmxlbSBpcyBzb21ldGhpbmcgbW9yZSB3aXRoaW4gdGhlaXIgcmVtaXQuDQo+Pg0KPj4gUGxl
YXNlIHRlc3QgdGhlIGF0YmtkIGRldmljZSB3aXRoICJzdWRvIGV2ZW11LXJlY29yZCIgb3IgInN1
ZG8gDQo+PiBldnRlc3QiDQo+PiBhbmQgaWYgdGhlIGJyaWdodG5lc3Mga2V5cyBnZW5lcmF0ZSBl
dmVudHMgdGhlcmUsIHdyaXRlIGRvd24gdGhlIHJhdyANCj4+IGV2ZW50IGNvZGVzIChNU0MgZXZl
bnRzKS4NCj4gDQo+IEkgdHJpZWQgdGhpcyBidXQgdW5mb3J0dW5hdGVseSB0aGlzIGRvZXNuJ3Qg
c2VlbSB0byBiZSB0aGUgd2hvbGUgc3RvcnkuDQo+IElmIEkgcHJlc3MgImRlY3JlYXNlIGJyaWdo
dG5lc3MiIEkgZ2V0Og0KPiBFdmVudDogdGltZSAxNjU3NTI1MzkzLjkyMjcyNywgLS0tLS0tLS0t
LS0tLS0gU1lOX1JFUE9SVCAtLS0tLS0tLS0tLS0NCj4gRXZlbnQ6IHRpbWUgMTY1NzUyNTM5Ny4w
NDMzNDgsIHR5cGUgNCAoRVZfTVNDKSwgY29kZSA0IChNU0NfU0NBTiksIA0KPiB2YWx1ZSA4MQ0K
PiBFdmVudDogdGltZSAxNjU3NTI1Mzk3LjA0MzM0OCwgdHlwZSAxIChFVl9LRVkpLCBjb2RlIDE5
MCAoS0VZX0YyMCksIA0KPiB2YWx1ZSAxDQo+IEV2ZW50OiB0aW1lIDE2NTc1MjUzOTcuMDQzMzQ4
LCAtLS0tLS0tLS0tLS0tLSBTWU5fUkVQT1JUIC0tLS0tLS0tLS0tLQ0KPiBFdmVudDogdGltZSAx
NjU3NTI1Mzk3LjA1MDM4NCwgdHlwZSA0IChFVl9NU0MpLCBjb2RlIDQgKE1TQ19TQ0FOKSwgDQo+
IHZhbHVlIDgxDQo+IEV2ZW50OiB0aW1lIDE2NTc1MjUzOTcuMDUwMzg0LCB0eXBlIDEgKEVWX0tF
WSksIGNvZGUgMTkwIChLRVlfRjIwKSwgDQo+IHZhbHVlIDANCj4gDQo+IEFuZCBpZiBJIHByZXNz
ICJpbmNyZWFzZSBicmlnaHRuZXNzIiBJIGdldDoNCj4gRXZlbnQ6IHRpbWUgMTY1NzUyNTM5Ny4w
NTAzODQsIC0tLS0tLS0tLS0tLS0tIFNZTl9SRVBPUlQgLS0tLS0tLS0tLS0tDQo+IEV2ZW50OiB0
aW1lIDE2NTc1MjUzOTguNjA3MTg0LCB0eXBlIDQgKEVWX01TQyksIGNvZGUgNCAoTVNDX1NDQU4p
LCANCj4gdmFsdWUgODENCj4gRXZlbnQ6IHRpbWUgMTY1NzUyNTM5OC42MDcxODQsIHR5cGUgMSAo
RVZfS0VZKSwgY29kZSAxOTAgKEtFWV9GMjApLCANCj4gdmFsdWUgMQ0KPiBFdmVudDogdGltZSAx
NjU3NTI1Mzk4LjYwNzE4NCwgLS0tLS0tLS0tLS0tLS0gU1lOX1JFUE9SVCAtLS0tLS0tLS0tLS0N
Cj4gRXZlbnQ6IHRpbWUgMTY1NzUyNTM5OC42MTQxOTAsIHR5cGUgNCAoRVZfTVNDKSwgY29kZSA0
IChNU0NfU0NBTiksIA0KPiB2YWx1ZSA4MQ0KPiBFdmVudDogdGltZSAxNjU3NTI1Mzk4LjYxNDE5
MCwgdHlwZSAxIChFVl9LRVkpLCBjb2RlIDE5MCAoS0VZX0YyMCksIA0KPiB2YWx1ZSAwDQo+IA0K
PiBUaGVyZSdzIG5vIGRpZmZlcmVuY2UhIEFuZCBJIGFsc28gZ2V0IHRoZSBzYW1lIHRoaW5nIGlm
IEkgcHJlc3MgdGhlDQo+ICphY3R1YWwqIG11dGUgbWljIGJ1dHRvbiDwn5ieLg0KPiANCj4gQW55
IGlkZWFzPw0KDQpGcm9tIHRoaXMgaXQgbG9va3MgbGlrZSB3ZSBuZWVkIHRvIHVzZSBzb21lIG90
aGVyIGludGVyZmFjZSB0byBnZXQgdGhlc2UgZXZlbnRzICgrIGlnbm9yZSB0aGUgYWJvdmUgZXZl
bnRzKS4NCg0KRG8geW91IGhhdmUgYSAiSFAgV01JIGhvdGtleXMiIGRldmljZSBpbiB5b3VyIGxp
c3Qgb2YgaW5wdXQgZGV2aWNlcz8gIEFuZCBhcmUgeW91IGdldHRpbmcgYW55IGV2ZW50cyBvbiB0
aGF0ID8NCg0KTGlrZXdpc2UgZG8geW91IGhhdmUgYSAiVmlkZW8gQnVzIiBkZXZpY2UgYW5kIGFu
eSBldmVudHMgb24gdGhhdCA/DQoNCkkndmUgYWxzbyBhZGRlZCBKb3JnZSBmcm9tIEhQIHRvIHRo
ZSBDYy4gSm9yZ2UsIGNhbiB5b3UgaGVscCB3aXRoIHRoaXMgPw0KDQpSZWdhcmRzLA0KDQpIYW5z
DQoNCg==

