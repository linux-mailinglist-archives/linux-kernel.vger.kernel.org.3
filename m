Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E9D50895E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 15:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379098AbiDTNcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 09:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379088AbiDTNcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 09:32:42 -0400
Received: from mo-csw.securemx.jp (mo-csw1116.securemx.jp [210.130.202.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518A13894;
        Wed, 20 Apr 2022 06:29:50 -0700 (PDT)
Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 23KDTSox007509; Wed, 20 Apr 2022 22:29:29 +0900
X-Iguazu-Qid: 2wHHts48jeB99qcdJQ
X-Iguazu-QSIG: v=2; s=0; t=1650461368; q=2wHHts48jeB99qcdJQ; m=thTcScSpdrVdCIDWSYzVgneKt0w3P3Mv/D0klpoHrBw=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
        by relay.securemx.jp (mx-mr1113) id 23KDTSWM026559
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 20 Apr 2022 22:29:28 +0900
X-SA-MID: 2772142
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NctHM4EFNSrXEn6V6GdBpLP7ujx2kBCtRr+Sc02RPLjzRyhkrk3Pkz8lqYLINsp62B9UFtNOzb1vyxn48oWXiqnc/n5KMWSKd9EEGyciiVhVLMf5G+tNVZxyMe8vqTnyzv3HC2OydneedJa10Tm7NLwz5KZvDFkWWo9gKA/ls7TSCgvr+sH8JOQT8UeUR0NSjnRgvIvHadlvRHPh6lNAgHF31tCSYNDU9T4CnOaPzNHxC1L8CnOAR2ysM2CjkVVpZSUEll2Uqt6BfE9BPHDYjb9djn4Cl7B8d3bmPALEXajneqTPWUscwUCy914StGej8dwwkEomvQd4mc4WzRGX1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T3cRKVFNIla6S/kAGTOOd5/KnVIv2BkIx4x/GpLtOL4=;
 b=RqY7m3+UrO8FeVpTRPrQ/9KuBkizGYr26YnvLf2Zvc9B/gfX469yhEJ9hGxK4+tRrhlM9CHlGJ3BzjI82JrsByiAIIvvHf88GbDgxvpjJ34VHbzvH5vvPUnU1VK+3VAgpxdpTufdVaiglZD0WlCQhXrsMeoB6Nov2tAeDrknLBErmE4xxqsNLkHc8mODP+x2KWgFX4ckGcK3+LePCBnXHwHJvEVZ1AsUzpO9/En/n4B8m96+9gSG+H6RPnHx4Jy8+8UR7u/h1qzdKd/7bPfSC4YYK9EDLSujVv7Rd6ZFPf11vf2T9otja3aZsYC20ve3Hz/f0//Zp2qglTCjm2x3og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From:   <yuji2.ishikawa@toshiba.co.jp>
To:     <hverkuil@xs4all.nl>, <mchehab@kernel.org>,
        <nobuhiro1.iwamatsu@toshiba.co.jp>
CC:     <linux-media@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/5] dt-bindings: media: platform: visconti: Add
 Toshiba Visconti Video Input Interface bindings
Thread-Topic: [PATCH v2 1/5] dt-bindings: media: platform: visconti: Add
 Toshiba Visconti Video Input Interface bindings
Thread-Index: AQHYT8F84d1jZ7iMWEq1MuwuklzECKz4eMQAgABbETA=
Date:   Wed, 20 Apr 2022 13:24:21 +0000
X-TSB-HOP2: ON
Message-ID: <TYAPR01MB620141C7A30FF629DFA0581792F59@TYAPR01MB6201.jpnprd01.prod.outlook.com>
References: <20220414053528.31460-1-yuji2.ishikawa@toshiba.co.jp>
 <20220414053528.31460-2-yuji2.ishikawa@toshiba.co.jp>
 <c3d0d176-252b-5823-0c34-f1bfc7c4978c@xs4all.nl>
In-Reply-To: <c3d0d176-252b-5823-0c34-f1bfc7c4978c@xs4all.nl>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 13983aa6-fdb4-4b9c-c1e0-08da22d11452
x-ms-traffictypediagnostic: OSAPR01MB7167:EE_
x-ld-processed: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f,ExtAddr,ExtFwd
x-microsoft-antispam-prvs: <OSAPR01MB71674CD34135EEADD634235292F59@OSAPR01MB7167.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AFhQU0CKI3Oko7TIZW91U/LYgptwwhOqmnHTlp9iB4CufItf3igsZQ14CveWx10SVh/685TmeJ7xzUXhJzrdkQtQF8IbQpsjheVMiad7f/VIq18YqOn1bstTmo/MPSnyq7rbw/s8nJgHNQ8PL1mw8uSnHDGkhWwK0be5Q5xyLXP36Q7WUOnC5xsQXYF2gpZ/rCASD0iF2XM2yIJA5RXIVzXJ1rqHD2kU0jtfPaHkSuGxk456pyf75dBpfPYgoJGTLv5Wdo3gpMgGXTU3CdeZeaHDGJNEt1ZiImTYpSctDh4mVCQ2el9xaLBJ/ts8er8oR9EM2T6yePtsw+3iA7EGQDvYbmGWqdpns8lfdhT1Uq5gsRq4rK9q+Lry/PKp4d+UiEFqlCmOdgkYRMWIEPsxaj3dslsknX72W2xW4oiteuvFCRYUGRXZLcP9N92jHuTsqiPFHe1qbeJyOTM+jS5UlUv3JWAv9yyhI1nN54jblUfhOj8bU5192d/AB8j9cPFIqEEs0Uaut3pqldytrbRfeCORjOCaMw6ifLLKBNrp0o9Eh9ZLZJspm5gMnyZxnkMzy0hUmUy5pL22EBFDv/cyCkFCeMq3JxtdCx6s9FFWKqxWLcfEpbD+63m4H8RXY/FGE9u4/RnJ2fEpJ5WQyi3tm/9+OUmFwCaAVdCp3bHPHyOy5Umg+PMZzPczsBT5bi3QfZIDjcNOkXNzs9PMfCVXFdtwPLwpNzPkGrgCG26xq23m4CPUqersxVUtt9I4Wfa2POWEo1geG086qyWCM4/eZPKyVFkorP3s2iZYWHKW+lEmyYttlVKcbUpTuPK6t0J+YUfXYqSgB4DDWu9lAJ3U7w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6201.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(71200400001)(33656002)(2906002)(26005)(9686003)(64756008)(7696005)(5660300002)(55236004)(86362001)(66556008)(4326008)(122000001)(52536014)(8676002)(66446008)(76116006)(8936002)(66476007)(66946007)(6506007)(54906003)(110136005)(966005)(316002)(6636002)(508600001)(186003)(83380400001)(55016003)(53546011)(38100700002)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a1BGSUNxMGdiQlhZeEVYMzIxVHFlWUNKRnVQTmtKQi91SUFZRDVRYkxTQXNr?=
 =?utf-8?B?M21Yc2pzZ01oRkN4eUVqSlhmT3lxa0x5a3NZYnhybC9COUxNTE81SUFCaXIr?=
 =?utf-8?B?d3pOeUtyZmpSL3VLMXZGalhMLzZqWmhFdUZqMFRpVVN2bFJtblM5YU1DNmp3?=
 =?utf-8?B?ektkNzUwTE5aOGs1RFJHd0lmU05zUjF4aVlSOEVSa01VeHZIMHZFR25RQ0hI?=
 =?utf-8?B?WVdSM3FSVFg1UkpJUW8wYklSRmFnditsb0tUbXllT2lLUXRZejltcE5vSEQ3?=
 =?utf-8?B?cUFFN2sxMVFsWTdxYTFIM1BhYkp1eUxJNlBBVGdzRmFrNmFkeFFiUU9zMDlS?=
 =?utf-8?B?N3pad0RNZGtkY0V0VVA1T3FlV00weTNzeFpsU1E5RytyOHgvMk1NN1hleXVr?=
 =?utf-8?B?ZHl1TWVQREZtaUFHNEsxNElxVFpLODFUUCtZUjM4WGYzV0ZISWtickpleFE1?=
 =?utf-8?B?azlkbytrWmc4OXNBZXpQLytOTVlEZGVuYnB5RnFKOU55YXAwdEhFaUx4SW5N?=
 =?utf-8?B?WTlkVWJnZWZkU3BFaWhMV1BzTDMvOEtGOGJmM3JJSWZyTTZrY2ZxQW1PcXhu?=
 =?utf-8?B?VjJ0bVhxZ3Z2OG9zUVJWbnpVdlFrRTFTcVI1LzlaRlliYUsrcmhNcU04UW4x?=
 =?utf-8?B?T2JxcmkyRjZCeFIxb3VGK0hsV0dXQWVBbE1oeHplc1gvM3luZ2hqYzkzbE5Y?=
 =?utf-8?B?TFB0T0hIQW0vdXA5ZXFRVVc0WXRMWmRBZTErb3JDSXh0WEtNSTMzUUNvZHVH?=
 =?utf-8?B?cHdCRXNRdndDaDZrR1BnN1BoRC82ZDAxZGhRR1BiS3lBbzFkeDdkeTRidUkw?=
 =?utf-8?B?NDZDZnFORVpnZXZrQVczVkRUVXpPb2RqZlpnVmoya3o3cUthSDNJMEdORklN?=
 =?utf-8?B?bUlLckJnTC9pUm44YllqQmRZS3ZvMmpVTXN2VkdIMy8xVnd1T2tsaHR2WGFm?=
 =?utf-8?B?ZFlWVE8yRDNVbTNCZnNUdWpUQWdjVWN3MDBNbWsrSEIzR2F2bHBHaUJFK3Rs?=
 =?utf-8?B?UWRHOS9iQTF3Y0VDM0JIS3diU0V3aW43cVhDY0tacXd3WWcrb0VEOXUxV3dU?=
 =?utf-8?B?V3FTOXFJOEQ0MVBNNkdGTkFjcmdUVVdPMEhQVDU3ajlLdUNCS2dTZW5ucGN0?=
 =?utf-8?B?RERMbVN1RDdrQUcrd0lGRXRGVHNHQkU1eTk3OWtSdDI5aHp2bDZ0ck44ZjJh?=
 =?utf-8?B?MCt6emJzQ0h2ZTJWWmdFN1RocFBjMGplek5qajJmQlQxcklEYlRTM2N2emtM?=
 =?utf-8?B?RTlJcXdVNUd0dTNCaWdqbFpVQTlSWjJEaFN4WnBHa1orcDdhS0tYTjdMMkxz?=
 =?utf-8?B?elEzL1M0Ums4UW9xSGx0THRjOUV4c2QzditrcjNnQTM5RU5zTUxwYit3V0dT?=
 =?utf-8?B?aVQxaEdDaXhIR21jTkp4Wkx3TnNhdnJGMElzVktUQWthVGxqcWo2RzIrVTFp?=
 =?utf-8?B?MDU0SlA3RHpXRWlCNFlIcjFyNVUzWGZiNUMrbjJ5RmUzNWFCTFR2TFRTTWRT?=
 =?utf-8?B?ems3NDRMZmZyZTlKNytqQlNuL2h2cno2ZnlnUFZYQ041ZUpTUWt4N0Nub3lh?=
 =?utf-8?B?Nzl4eWFzbGhtTDk5Qzd2Wk9TcU5zQnZVYS9DK2VYdW5kUXAzTHhqanNtcnJl?=
 =?utf-8?B?ZmIrekFNTXhScFFsTkhIcHlYRitJQ0F0bzVCSUMyTTFoQ2J6Wit2NXEwU3Zh?=
 =?utf-8?B?QUNmTW5jc1EwUWw0d1FMK0xOL2xwN2I2dk9LQ3V1MFA0blJzaFgxSU9qNXNm?=
 =?utf-8?B?cXd6cVJiRnFGZ0dNckNVanJFeEZIOURSOFdCbXd1WFUwTXVTNmg1c0RmbmhC?=
 =?utf-8?B?RUxqMlBjbWV0Y2dIZExBbDByNWNDdTkyeU4rQ0NZRHBSRm1seUNQL0ZxV2V4?=
 =?utf-8?B?VE52L3owWkkxb2pCa3JudjVDaEhPZXExYURPSloxNTRQZ2JrUXJaTW5JUktG?=
 =?utf-8?B?UmJrLzEvSEdHdGdoMThBNW5xUWk2VnBDSS9PZFU1blRVdzRlUmIzTUN1Q2gy?=
 =?utf-8?B?NnNEY0ZCY3JORVZiWWJLVnY4NlVZSlR1S3VhVmkzY3FjWXk3QVIyUDZwZXEy?=
 =?utf-8?B?b0lzVndRbGVPbGxVcTFsaUVvbTVTYS9BTHRaaHpUM2xhb1pUVm1tMkVPV2FG?=
 =?utf-8?B?MFpRdUg2R1BXdllPRXlSbDVUR2xCQTY4MEV3UXk1NXdkc1BsWjhzMHhXNjJu?=
 =?utf-8?B?b21CYzBHQm9zQVd2Mmk1Z0prcTlTUDlEeTdRZ0xYdG9QSnFFNnBDa2JxTENY?=
 =?utf-8?B?bmRsTlNkKzJ5RmZjTUgvbU53WkxhUzZUTkQ1YWZEbkJmMzJwMUhOWHY2Zyta?=
 =?utf-8?B?RGZ0ZkJHazZsYlkwRXdHS0VHYUtEREo3ckxqb05sZWJYeFAzVGVZTDlIZHBL?=
 =?utf-8?Q?MTKrAh18ljbWxevQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6201.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13983aa6-fdb4-4b9c-c1e0-08da22d11452
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2022 13:24:21.0198
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z333Vnk9oG/i2lFY9rTu7sLUip5sC0byEI2FAJzjX0KB7l0piHe0Tw67/PmTPPRoA97YIX38bdx0/Mcrg1OX4hcH8t5PPTWCuWYX4FNYUhE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB7167
X-OriginatorOrg: toshiba.co.jp
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEhhbnMNCg0KVGhhbmsgeW91IGZvciB5b3VyIGNvbW1lbnRzLg0KSSdsbCBhZGQgdGhlIHNw
ZWNpZmllZCBhZGRyZXNzIGZvciBmdXJ0aGVyIHBvc3RzLg0KDQpSZWdhcmRzLA0KCVl1amkNCg0K
PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBIYW5zIFZlcmt1aWwgPGh2ZXJr
dWlsQHhzNGFsbC5ubD4NCj4gU2VudDogV2VkbmVzZGF5LCBBcHJpbCAyMCwgMjAyMiA0OjU2IFBN
DQo+IFRvOiBpc2hpa2F3YSB5dWppKOefs+W3nSDmgqDlj7gg4peL77yy77yk77yj4pah77yh77yp
77y077yj4peL77yl77yh6ZaLKQ0KPiA8eXVqaTIuaXNoaWthd2FAdG9zaGliYS5jby5qcD47IE1h
dXJvIENhcnZhbGhvIENoZWhhYg0KPiA8bWNoZWhhYkBrZXJuZWwub3JnPjsgaXdhbWF0c3Ugbm9i
dWhpcm8o5bKp5p2+IOS/oea0iyDilqHvvLPvvLfvvKPil6/vvKHvvKPvvLQpDQo+IDxub2J1aGly
bzEuaXdhbWF0c3VAdG9zaGliYS5jby5qcD4NCj4gQ2M6IGxpbnV4LW1lZGlhQHZnZXIua2VybmVs
Lm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMS81XSBkdC1iaW5k
aW5nczogbWVkaWE6IHBsYXRmb3JtOiB2aXNjb250aTogQWRkDQo+IFRvc2hpYmEgVmlzY29udGkg
VmlkZW8gSW5wdXQgSW50ZXJmYWNlIGJpbmRpbmdzDQo+IA0KPiBPbiAxNC8wNC8yMDIyIDA3OjM1
LCBZdWppIElzaGlrYXdhIHdyb3RlOg0KPiA+IEFkZHMgdGhlIERldmljZSBUcmVlIGJpbmRpbmcg
ZG9jdW1lbnRhdGlvbiB0aGF0IGFsbG93cyB0byBkZXNjcmliZSB0aGUNCj4gPiBWaWRlbyBJbnB1
dCBJbnRlcmZhY2UgZm91bmQgaW4gVG9zaGliYSBWaXNjb250aSBTb0NzLg0KPiA+DQo+ID4gU2ln
bmVkLW9mZi1ieTogWXVqaSBJc2hpa2F3YSA8eXVqaTIuaXNoaWthd2FAdG9zaGliYS5jby5qcD4N
Cj4gPiBSZXZpZXdlZC1ieTogTm9idWhpcm8gSXdhbWF0c3UgPG5vYnVoaXJvMS5pd2FtYXRzdUB0
b3NoaWJhLmNvLmpwPg0KPiA+IC0tLQ0KPiA+ICAuLi4vYmluZGluZ3MvbWVkaWEvdG9zaGliYSx2
aXNjb250aS12aWlmLnlhbWwgfCAxMDMNCj4gPiArKysrKysrKysrKysrKysrKysNCj4gPiAgMSBm
aWxlIGNoYW5nZWQsIDEwMyBpbnNlcnRpb25zKCspDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NA0K
PiA+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZWRpYS90b3NoaWJhLHZpc2Nv
bnRpLXZpaWYueWFtbA0KPiA+DQo+ID4gZGlmZiAtLWdpdA0KPiA+IGEvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL21lZGlhL3Rvc2hpYmEsdmlzY29udGktdmlpZi55YW1sDQo+ID4g
Yi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWVkaWEvdG9zaGliYSx2aXNjb250
aS12aWlmLnlhbWwNCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiANCj4gWW91IG5lZWQgdG8g
Q0MgdGhpcyBzZXJpZXMgdG8gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmcgc28gdGhhdCB0aGUg
ZGV2aWNlIHRyZWUNCj4gcmV2aWV3ZXJzIGNhbiB0YWtlIGEgbG9vayBhdCB0aGlzLg0KPiANCj4g
UmVnYXJkcywNCj4gDQo+IAlIYW5zDQo+IA0KPiA+IGluZGV4IDAwMDAwMDAwMC4uODQ4ZWE1MDE5
DQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9tZWRpYS90b3NoaWJhLHZpc2NvbnRpLXZpaWYueWENCj4gPiArKysgbWwNCj4gPiBA
QCAtMCwwICsxLDEwMyBAQA0KPiA+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIu
MC1vbmx5IE9SIEJTRC0yLUNsYXVzZSkgJVlBTUwgMS4yDQo+ID4gKy0tLQ0KPiA+ICskaWQ6IGh0
dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL21lZGlhL3Rvc2hpYmEsdmlzY29udGktdmlpZi55
YW1sIw0KPiA+ICskc2NoZW1hOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFzL2Nv
cmUueWFtbCMNCj4gPiArDQo+ID4gK3RpdGxlOiBUb3NoaWJhIFZpc2NvbnRpNSBTb0MgVmlkZW8g
SW5wdXQgSW50ZXJmYWNlIERldmljZSBUcmVlDQo+ID4gK0JpbmRpbmdzDQo+ID4gKw0KPiA+ICtt
YWludGFpbmVyczoNCj4gPiArICAtIE5vYnVoaXJvIEl3YW1hdHN1IDxub2J1aGlybzEuaXdhbWF0
c3VAdG9zaGliYS5jby5qcD4NCj4gPiArDQo+ID4gK2Rlc2NyaXB0aW9uOiB8DQo+ID4gKyAgVG9z
aGliYSBWaXNjb250aTUgU29DIFZpZGVvIElucHV0IEludGVyZmFjZSAoVklJRikgcmVjZWl2ZXMg
TUlQSQ0KPiA+ICtDU0kyIHZpZGVvIHN0cmVhbSwNCj4gPiArICBwcm9jZXNzZXMgdGhlIHN0cmVh
bSB3aXRoIGVtYmVkZGVkIGltYWdlIHNpZ25hbCBwcm9jZXNzb3IgKEwxSVNQLA0KPiBMMklTUCks
IHRoZW4gc3RvcmVzIHBpY3R1cmVzIHRvIG1haW4gbWVtb3J5Lg0KPiA+ICsNCj4gPiArcHJvcGVy
dGllczoNCj4gPiArICBjb21wYXRpYmxlOg0KPiA+ICsgICAgY29uc3Q6IHRvc2hpYmEsdmlzY29u
dGktdmlpZg0KPiA+ICsNCj4gPiArICByZWc6DQo+ID4gKyAgICBpdGVtczoNCj4gPiArICAgICAg
LSBkZXNjcmlwdGlvbjogcmVnaXN0ZXJzIGZvciBjYXB0dXJlIGNvbnRyb2wNCj4gPiArICAgICAg
LSBkZXNjcmlwdGlvbjogcmVnaXN0ZXJzIGZvciBDU0kyIHJlY2VpdmVyIGNvbnRyb2wNCj4gPiAr
DQo+ID4gKyAgaW50ZXJydXB0czoNCj4gPiArICAgIGl0ZW1zOg0KPiA+ICsgICAgICAtIGRlc2Ny
aXB0aW9uOiBTeW5jIEludGVycnVwdA0KPiA+ICsgICAgICAtIGRlc2NyaXB0aW9uOiBTdGF0dXMg
KEVycm9yKSBJbnRlcnJ1cHQNCj4gPiArICAgICAgLSBkZXNjcmlwdGlvbjogQ1NJMiBSZWNlaXZl
ciBJbnRlcnJ1cHQNCj4gPiArICAgICAgLSBkZXNjcmlwdGlvbjogTDFJU1AgSW50ZXJydXB0DQo+
ID4gKw0KPiA+ICsgIGluZGV4Og0KPiA+ICsgICAgZW51bTogWzAsIDFdDQo+ID4gKw0KPiA+ICsg
IHBvcnQ6DQo+ID4gKyAgICAkcmVmOiAvc2NoZW1hcy9ncmFwaC55YW1sIy8kZGVmcy9wb3J0LWJh
c2UNCj4gPiArICAgIHVuZXZhbHVhdGVkUHJvcGVydGllczogZmFsc2UNCj4gPiArICAgIGRlc2Ny
aXB0aW9uOiBJbnB1dCBwb3J0IG5vZGUsIHNpbmdsZSBlbmRwb2ludCBkZXNjcmliaW5nIHRoZSBD
U0ktMg0KPiB0cmFuc21pdHRlci4NCj4gPiArDQo+ID4gKyAgICBwcm9wZXJ0aWVzOg0KPiA+ICsg
ICAgICBlbmRwb2ludDoNCj4gPiArICAgICAgICAkcmVmOiB2aWRlby1pbnRlcmZhY2VzLnlhbWwj
DQo+ID4gKyAgICAgICAgdW5ldmFsdWF0ZWRQcm9wZXJ0aWVzOiBmYWxzZQ0KPiA+ICsNCj4gPiAr
ICAgICAgICBwcm9wZXJ0aWVzOg0KPiA+ICsgICAgICAgICAgZGF0YS1sYW5lczoNCj4gPiArICAg
ICAgICAgICAgZGVzY3JpcHRpb246IFZJSUYgc3VwcG9ydHMgMiBvciA0IGRhdGEgbGluZXMNCj4g
PiArICAgICAgICAgICAgaXRlbXM6DQo+ID4gKyAgICAgICAgICAgICAgbWluSXRlbXM6IDENCj4g
PiArICAgICAgICAgICAgICBtYXhJdGVtczogNA0KPiA+ICsgICAgICAgICAgICAgIGl0ZW1zOg0K
PiA+ICsgICAgICAgICAgICAgICAgLSBjb25zdDogMQ0KPiA+ICsgICAgICAgICAgICAgICAgLSBj
b25zdDogMg0KPiA+ICsgICAgICAgICAgICAgICAgLSBjb25zdDogMw0KPiA+ICsgICAgICAgICAg
ICAgICAgLSBjb25zdDogNA0KPiA+ICsgICAgICAgICAgY2xvY2stbGFuZXM6DQo+ID4gKyAgICAg
ICAgICAgIGRlc2NyaXB0aW9uOiBWSUlGIHN1cHBvcnRzIDEgY2xvY2sgbGluZQ0KPiA+ICsgICAg
ICAgICAgICBjb25zdDogMA0KPiA+ICsNCj4gPiArcmVxdWlyZWQ6DQo+ID4gKyAgLSBjb21wYXRp
YmxlDQo+ID4gKyAgLSByZWcNCj4gPiArICAtIGludGVycnVwdHMNCj4gPiArICAtIHBvcnQNCj4g
PiArDQo+ID4gK2FkZGl0aW9uYWxQcm9wZXJ0aWVzOiBmYWxzZQ0KPiA+ICsNCj4gPiArZXhhbXBs
ZXM6DQo+ID4gKyAgLSB8DQo+ID4gKyAgICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvaW50ZXJydXB0
LWNvbnRyb2xsZXIvYXJtLWdpYy5oPg0KPiA+ICsgICAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2lu
dGVycnVwdC1jb250cm9sbGVyL2lycS5oPg0KPiA+ICsNCj4gPiArICAgIHNvYyB7DQo+ID4gKyAg
ICAgICAgI2FkZHJlc3MtY2VsbHMgPSA8Mj47DQo+ID4gKyAgICAgICAgI3NpemUtY2VsbHMgPSA8
Mj47DQo+ID4gKw0KPiA+ICsgICAgICAgIHZpaWYwOiB2aWlmQDFjMDAwMDAwIHsNCj4gPiArICAg
ICAgICAgICAgY29tcGF0aWJsZSA9ICJ0b3NoaWJhLHZpc2NvbnRpLXZpaWYiOw0KPiA+ICsgICAg
ICAgICAgICByZWcgPSA8MCAweDFjMDAwMDAwIDAgMHg2MDAwPiwNCj4gPiArICAgICAgICAgICAg
ICAgICAgPDAgMHgxYzAwODAwMCAwIDB4NDAwPjsNCj4gPiArICAgICAgICAgICAgaW50ZXJydXB0
cyA9IDxHSUNfU1BJIDY0IElSUV9UWVBFX0xFVkVMX0hJR0g+LA0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgPEdJQ19TUEkgNjcgSVJRX1RZUEVfTEVWRUxfSElHSD4sDQo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICA8R0lDX1NQSSA3MyBJUlFfVFlQRV9MRVZFTF9ISUdIPiwNCj4g
PiArICAgICAgICAgICAgICAgICAgICAgICAgIDxHSUNfU1BJIDc2IElSUV9UWVBFX0xFVkVMX0hJ
R0g+Ow0KPiA+ICsgICAgICAgICAgICBpbmRleCA9IDwwPjsNCj4gPiArICAgICAgICAgICAgc3Rh
dHVzID0gImRpc2FibGVkIjsNCj4gPiArDQo+ID4gKyAgICAgICAgICAgIHBvcnQgew0KPiA+ICsg
ICAgICAgICAgICAgICAgI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+ID4gKyAgICAgICAgICAgICAg
ICAjc2l6ZS1jZWxscyA9IDwwPjsNCj4gPiArDQo+ID4gKyAgICAgICAgICAgICAgICBjc2lfaW4w
OiBlbmRwb2ludCB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgcmVtb3RlLWVuZHBvaW50ID0g
PCZpbXgyMTlfb3V0MD47DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgYnVzLXR5cGUgPSA8ND47
DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgZGF0YS1sYW5lcyA9IDwxIDI+Ow0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgIGNsb2NrLWxhbmVzID0gPDA+Ow0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgIGNsb2NrLW5vbmNvbnRpbnVvdXM7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgbGluay1m
cmVxdWVuY2llcyA9IC9iaXRzLyA2NCA8NDU2MDAwMDAwPjsNCj4gPiArICAgICAgICAgICAgICAg
IH07DQo+ID4gKyAgICAgICAgICAgIH07DQo+ID4gKyAgICAgICAgfTsNCj4gPiArICAgIH07DQo+
ID4gKw0K

