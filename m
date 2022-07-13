Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1668A573B5A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 18:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237263AbiGMQep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 12:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237145AbiGMQen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 12:34:43 -0400
Received: from us-smtp-delivery-162.mimecast.com (us-smtp-delivery-162.mimecast.com [170.10.133.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E0C23BC3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 09:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hp.com; s=mimecast20180716;
        t=1657730079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9CJalejJyV2uHoAVEHTkJaE32STy8jgtsOr0sqLqrBI=;
        b=R3BlEm33KOpsqKMySBGJE4Pgua1z8urd4famfTEINpTA6xT8Nei0qusMVbSP+j7DUmLrCH
        nXANy3bVQaKgEIfv2pus6S/bVsa0TwqQ8G/3iuZnoM1R4d6SOUnEkxv0YnfOBHIBMhY+lo
        qplGZaCzjauAP8Fu+VQN7DQk2V0c86o=
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-130-UcUTkCZxONutkLxfRFoXjg-1; Wed, 13 Jul 2022 12:34:38 -0400
X-MC-Unique: UcUTkCZxONutkLxfRFoXjg-1
Received: from PH0PR84MB1953.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:160::10)
 by MW4PR84MB1924.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1b3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Wed, 13 Jul
 2022 16:34:35 +0000
Received: from PH0PR84MB1953.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::880d:1bb8:7f9e:19cc]) by PH0PR84MB1953.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::880d:1bb8:7f9e:19cc%7]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 16:34:35 +0000
From:   "Lopez, Jorge A (Security)" <jorge.lopez2@hp.com>
To:     Alex Dewar <alex.dewar@gmx.co.uk>,
        Hans de Goede <hdegoede@redhat.com>,
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
Thread-Index: AQHYlR8s56cSTJIX+UqJ5MPQFYzlza15IwvQgAAVZnCAAARdAIAAAFBggAK6cICAAIWYEA==
Date:   Wed, 13 Jul 2022 16:34:35 +0000
Message-ID: <PH0PR84MB1953BA49D88304F1D61AB7A0A8899@PH0PR84MB1953.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220629094314.b7xmfb3xccj7vs6v@ic-alex-elitebook>
         <3fedf676645bfa638c9a6c656121083abc2c98ea.camel@gmx.co.uk>
         <8b893c42-e514-bcef-0513-070b3723cdcc@redhat.com>
         <df7313597d2ac3212f10c05aa3d369728f030c86.camel@gmx.co.uk>
         <c89d39eb-17b9-8800-c8ff-8d236b80de2f@redhat.com>
         <PH0PR84MB195309F5BA5B96858024E61FA8879@PH0PR84MB1953.NAMPRD84.PROD.OUTLOOK.COM>
         <PH0PR84MB19536D04A5625D4DC8B76AF1A8879@PH0PR84MB1953.NAMPRD84.PROD.OUTLOOK.COM>
         <0e8611ad73017bc204372f491ae5666dd60885a9.camel@gmx.co.uk>
         <PH0PR84MB195301AA9C44F2F4ECE4A848A8879@PH0PR84MB1953.NAMPRD84.PROD.OUTLOOK.COM>
 <afeb858778de9b25d0de655ffccb64b85511c428.camel@gmx.co.uk>
In-Reply-To: <afeb858778de9b25d0de655ffccb64b85511c428.camel@gmx.co.uk>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-bromium-msgid: 976a9285-b0a1-4ef2-a020-fe96239ba08f
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 00f05ca9-72d7-4192-a8c8-08da64ed92a5
x-ms-traffictypediagnostic: MW4PR84MB1924:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: skJtLTa+Sv5kUoNPC8fJwPNUtZFH2zLJ5rQwv1dC908BmfioaDHtHrae+4WRCy8IMTMKTadoEZDid0Tuccxd/pEFBFfPPydLTyp7xN14DPwOv63hLPBBETksiiEYLaGL6DbodddtcuiFI3bPtfSl+iyT0dGLz756IjyqC6m2PcLkP+x1dNJXpNC5/vdYLc1g579oxNc9t6c+mgnlKK1E/wa5PCso35jU2JCoL2IQf11f4132TyskCyDWlbICZs67+usLgw3p1AI4DudbaCE9bF7HsV+pV4x8FZ1ZcmHExr9lndm7vmApLT+xBjDL5ksL6JKcXhZkBD1pfSrezJUIPq9sSzoSz992+q0DWQOAkDwAFwh6KOzwR3G1u5+9MKfG6rRgBJ+pg2Umh8lzHIbjAvtTh7TgdKqnLqXo+Dk/ThY2nS1Qmq9Wium4s4SMcFVOnhbAkaEcnI3aNskUb7hQ8qO9TlZ9X0t9VGD/zBf9UHOWUmwl/1Jj1XX1GbnLSuyi/6u7BRq+kzgVR7SWtju2PIkHoSkWGA/zX7+g9ek3A/0xt2HUfDKZ7cQgjO+WBDjeILKA4OlZr5+DUG4BAQ4T2jFY5H6ZBvEhwGwssVT9U6eucLPqHwX53TOwWWDew85P/zkbszNjQaQx00wzAUHwm8vtrp6WoAGPegBVz17MtjWfUWGyV5tEq1rUWZbnJlXnVPNsSZ+htxMlvGQ+A+rk1iKIydX+JTw5Hg1ExIIYXC/4jJETOHSQMNgUiUU9xdi8a2ibcJnLIUl2Qv4Sc8pdoRqAH32f5uhYCPz1PwzYF2YGhW+gD44h6cIQek/wnJFsToqjRpX7IPy7A0MSCCWBr3xM8ZE9UUTF55a2YLfEuig=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR84MB1953.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(396003)(39860400002)(366004)(136003)(376002)(346002)(41300700001)(6506007)(26005)(9686003)(7696005)(110136005)(316002)(86362001)(55016003)(54906003)(53546011)(966005)(71200400001)(478600001)(38070700005)(186003)(82960400001)(38100700002)(83380400001)(76116006)(66946007)(5660300002)(122000001)(64756008)(4326008)(33656002)(66556008)(66446008)(8936002)(66476007)(8676002)(52536014)(2906002);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NzgvUzRGQ2tjUzB5VlkrSGJZOUVMT2NvcEhwMjVzQ3J0Q0pWa2U1d3VZRTdM?=
 =?utf-8?B?QjQxbVRZL0hxeGp2ZEhoTnhlNS83ci8yUm5kbGZvV1dIL2RvQzludWZzcDIy?=
 =?utf-8?B?S3VGZUo0NmZTWFZnM1pmb2xwaitmTWdKUE5JQ040a0trWGZZdFpud2V4ZW80?=
 =?utf-8?B?QnR4aXdFSlkrRmZXS3dTZmdFby9HTWtrM3VmMjFHUzV6RXpkS09kQlpVSmlC?=
 =?utf-8?B?SFg1aXZYTEl4UDlmR0FUN250cWN3RjZnWGh6UWdabXlEcWJOVE1qemNTaHFS?=
 =?utf-8?B?Q0tsTG4yNTJmUGtOaU1vYkFsMVJnRVJyZGo2V1hja3N0ejZQUTVBQkdHWk5R?=
 =?utf-8?B?UU0yU3F0WGEwZ3FNbllhVEp1K1cvWkJMWjVPeHlUTndmQk11ODJRdEZVK29O?=
 =?utf-8?B?SmFpMERFeGZ2cWRVRnZTUVVQVCsybkdlNGVsMlVaTEFqYVF5MHFxQW1pUnoy?=
 =?utf-8?B?MHFCZ1MyV0xTS0JwWDZRTysxVTlMN0lTVnhEUTdDSWxvSmVWRHFYT2JoNEQ4?=
 =?utf-8?B?SXB6NlFkdHFEWXlsRnA3NHljdzIzUXA2UDAyZWNWMFA3M2I2Q1FpU2NBSzF3?=
 =?utf-8?B?Zm1McmtRQlRlUDdUWkFxalVJWWJxZkFtc1ZYYWlQWFU3OGFiczBJbDhuUjFp?=
 =?utf-8?B?NEZrTHQ5eFg3aElLTzVzcmpiMHk0R3Q1TjBpUWhRenVOdERwV1ZlY3p6dHhr?=
 =?utf-8?B?S2s0SDg1cmlSTGtkWFVDNlFtZUFCazAwbmJIYXdFaEE0bml5anh6Z1dLRTJi?=
 =?utf-8?B?SmE4NDVGYmVGZ29SNm03SDRubUpUSjM5eVVPNmlkVXFTTVhFWUFaYmhYQmFB?=
 =?utf-8?B?QUlQM2hONy9JM0x3ZGxQLzYvRU1sZVc0NVlURzA2QTZScmJHYVJLcERhR0Fw?=
 =?utf-8?B?VG83aTNsVmhIdHRoMW1IOEx3a1VEdlUvR0lkNzZtVjM3bitqeEMyZUJNaUts?=
 =?utf-8?B?Qnd1Yzg0dG1qNERBSFlabE1TdWhDbDEwZlVlSjJFVVpjY3dGMjVraGdhYUJX?=
 =?utf-8?B?TVdVNDJoRUNiUnJoKzdqNTA2RFphRk1nRFB5L0Jwd0xoT2NjajRqaTFNRlhy?=
 =?utf-8?B?SmhONmpDeC9yZnFiQ3BjWU9uSGpONUMrWEVTa21HeGxZd2FEaTErSnBsNitK?=
 =?utf-8?B?MXlnc2ZCdVpVd085dXphYmRXYkVTUUZlKzBoTVU4OVFjK3Bwc25NUjcvWGh1?=
 =?utf-8?B?cDRveFk3dGU5b1QwTkRxdHkwZ2d1SGJYaitGRitrdWd6U0M1ekNHaWI0Zndk?=
 =?utf-8?B?aHQzRXJ6VDJUZ2NvKzZlZStScW1pZ3JVY2JaRUI2Z2xscjNwdzN3TFBtL3B6?=
 =?utf-8?B?ZVFZR0ZLZ2I4b1h5ZEdXZ3EyZ2FheHpubVcvczhvWVJCalpUay8wYmhtMHlJ?=
 =?utf-8?B?OFI2dkp4MXkxbzBjUkk5OVBkYnZQTzFRd0Q4Q3oybGMyTThVREVkalRIY2pp?=
 =?utf-8?B?SEUzMmFueVJ0WlhEYmZhM3lGN3FTcW1ZT3VEcm5JeDBWSzN5L2N1SEc5YU00?=
 =?utf-8?B?aGNwMVpCSWlFRTRtaHVyd09QRzFTaWxuSUNreVJaYnlsRDdFUWxWblFqRE9x?=
 =?utf-8?B?WHFGYVBWQTBXbDM4M05XZFR3QkRCcEtxNWZyUXpvaGR0NW55SHhYV3RCTTFE?=
 =?utf-8?B?YmVLbG15VTBKN0xFK3VhT1BRNnBjV2ZIZ3NCVHp3VithVGFPR3liNEcxR3kw?=
 =?utf-8?B?aTVVWFlVMTJXczh4RXllbXZOcmd4NSs2OEhrdXhaTmRGaUtTK1ZqWVR0L3JQ?=
 =?utf-8?B?NnpsdThMeUZsZ0lWMHNjYjVqZTQ5SU5Ra3l4V0dXYnlXNmI4Um1MYUNMMTZX?=
 =?utf-8?B?Z1hEYkRibitRK09LTnZKaDl4L01FelBVbFN3RlBLV21HNlk4Ull3UFpFTW4w?=
 =?utf-8?B?eGZQdHFjVG1oamVRWFFXYUtjbU9pY3dZbDdSSWFpakhybWhyRTFWcTVPYTly?=
 =?utf-8?B?NWlKTmpoRjVaTHhVY2REa09rdWxneXArV1JMbWlxZkhxWVhwSnNsdThUM2xj?=
 =?utf-8?B?VmdON3dwL05uUnZMVHlQWEFpOHNOSTBlT2ZkNnByMktHWlRrQTdnZXAxbkpk?=
 =?utf-8?B?VHhBLzN1aUYzejVUbHdqdXlGQVQyOE1vMUtWSTd3NlNOOWlNNmNRWDE2QUQx?=
 =?utf-8?Q?vT49/dzaEMvSW3kxkptDIFTNn?=
MIME-Version: 1.0
X-OriginatorOrg: hp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR84MB1953.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 00f05ca9-72d7-4192-a8c8-08da64ed92a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2022 16:34:35.5610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ca7981a2-785a-463d-b82a-3db87dfc3ce6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gPubKiszWbXLiTUFGr4gUfuozribCw0f0xaLw9avZe1EsxwAXJGfFkVpqJkLiHj2YQ/h1JnjtH4ku6A0LidFUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR84MB1924
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA62A171 smtp.mailfrom=jorge.lopez2@hp.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: hp.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SEkgQWxleCwNCg0KSFAgaXMgd29ya2luZyBpbiBwdWJsaXNoaW5nIEhQIEJJT1MgdG8gTFZGUyBh
bmQgdGhlIHRlYW0gaXMgbWFraW5nIHByb2dyZXNzLiAgDQpUaGVyZSBhcmUgc2V2ZXJhbCBCSU9T
IHB1Ymxpc2hlZCBhbmQgaXQgYXBwZWFycyBCSU9TIGZvciB5b3VyIEVsaXRlIERyYWdvbmZseSBp
cyBvbmUgb2YgdGhlbS4gICANClNlZSBodHRwczovL2Z3dXBkLm9yZy9sdmZzL2Zpcm13YXJlLzEw
OTQ4Lg0KDQpUaGUgQklPUyBpcyBhcHBsaWNhYmxlIHRvIG5vdGVib29rcyB3aXRoIFQ5MCB0eXBl
IEJJT1MuICBJZiB5b3UgZGVjaWRlIHRvIHRyeSBmbGFzaGluZyB0aGUgZmlybXdhcmUsIHBsZWFz
ZSBkbyBpdCBhdCB5b3VyIG93biByaXNrLg0KDQpCSU9TLVN5c3RlbSBGaXJtd2FyZSAoMSkNCkhQ
IEJJT1MgYW5kIFN5c3RlbSBGaXJtd2FyZSAoVDkwKQ0KVmVyc2lvbjogMDEuMDkuMTAgUmV2LkEJ
DQoNCg0KDQpSZWdhcmRzLA0KDQpKb3JnZSBMb3Bleg0KSGV3bGV0dC1QYWNrYXJkIA0KDQrigJxP
bmNlIHlvdSBzdG9wIGxlYXJuaW5nLCB5b3Ugc3RhcnQgZHlpbmfigJ0NCkFsYmVydCBFaW5zdGVp
bg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogQWxleCBEZXdhciA8YWxleC5k
ZXdhckBnbXguY28udWs+IA0KU2VudDogV2VkbmVzZGF5LCBKdWx5IDEzLCAyMDIyIDM6MTcgQU0N
ClRvOiBMb3BleiwgSm9yZ2UgQSAoU2VjdXJpdHkpIDxqb3JnZS5sb3BlejJAaHAuY29tPjsgSGFu
cyBkZSBHb2VkZSA8aGRlZ29lZGVAcmVkaGF0LmNvbT47IGRtaXRyeS50b3Jva2hvdkBnbWFpbC5j
b207IHRpd2FpQHN1c2UuZGU7IG1hcmtncm9zc0BrZXJuZWwub3JnDQpDYzogbGludXgtaW5wdXRA
dmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBwbGF0Zm9ybS1k
cml2ZXIteDg2QHZnZXIua2VybmVsLm9yZw0KU3ViamVjdDogUmU6IGlucHV0L2k4MDQyOiBNYWxm
dW5jdGlvbmluZyBicmlnaHRuZXNzIGtleXMgb24gSFAgRWxpdGUgRHJhZ29uZmx5IEcyDQoNCk9u
IE1vbiwgMjAyMi0wNy0xMSBhdCAxNDo1OSArMDAwMCwgTG9wZXosIEpvcmdlIEEgKFNlY3VyaXR5
KSB3cm90ZToNCj4gSGkgQWxleCwNCj4gDQo+IFRoYW5rIHlvdSBmb3IgdGhlIEJJT1MgaW5mb3Jt
YXRpb24uwqDCoCBUaGUgcHJvYmxlbSB5b3UgYXJlIGV4cGVyaWVuY2luZyANCj4gd2FzIGZpeGVk
IGluIEJJT1MgdmVyc2lvbiAwMS4wNy4wMiBSZXYuQQ0KPiANCj4gwqDCoMKgwqDCoMKgwqDCoC0g
Rml4ZXMgYW4gaXNzdWUgd2hlcmUgRm4rRjMvRjQgZG8gbm90IGNoYW5nZSB0aGUgYnJpZ2h0bmVz
cyANCj4gb2YgdGhlIGRpc3BsYXkgcGFuZWwgd2hlbiB0aGUgUHJpdmFjeSBQYW5lbCBpcyBlbmFi
bGVkIGluIHRoZSBGMTAgDQo+IHNldHRpbmdzLg0KPiANCj4gVGhlIGxhdGVzdCBCSU9TIHZlcnNp
b24gaXMgMDEuMDkuMDEgUmV2LkEgc28gdGhlIHByb2JsZW0gd2lsbCBiZSANCj4gcmVzb2x2ZWQg
YWZ0ZXIgQklPUyB1cGdyYWRlLsKgwqDCoCBCSU9TIGlzIG5vdCBhdmFpbGFibGUgdmlhIExWRlMs
IHlvdSANCj4gd2lsbCBuZWVkIHRvIGluc3RhbGwgaXQgdmlhIFdpbmRvd3MgZXhlY3V0YWJsZS4N
Cj4gaHR0cHM6Ly9zdXBwb3J0LmhwLmNvbS91cy1lbi9kcml2ZXJzL2xhcHRvcHMNCj4gDQo+IExl
dCBtZSBrbm93IGlmIHRoZSBwcm9ibGVtIGlzIHJlc29sdmVkLg0KDQpUaGF0IHdvcmtlZCBhIHRy
ZWF0LiBUaGFua3MhDQoNCkFuZCBpZiB5b3UgaGF2ZSBhbiBpbnRlcm5hbCB0aWNrZWQgY2FsbGVk
ICJTdXBwb3J0IEVsaXRlYm9va3Mgb24gTFZGUyINCm9yIHNpbWlsYXIsIGZlZWwgZnJlZSB0byBh
ZGQgbXkgKzEgdG8gaXQg8J+YiQ0KDQpCZXN0LA0KQWxleA0KDQo=

