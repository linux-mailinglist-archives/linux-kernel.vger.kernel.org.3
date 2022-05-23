Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC4E530F8F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235571AbiEWMgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 08:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235511AbiEWMfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 08:35:44 -0400
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30087.outbound.protection.outlook.com [40.107.3.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00CE42EDA;
        Mon, 23 May 2022 05:35:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gxITZVK7j9OSFy9T4JvpXx+ls1xG1/rkoups0/tvhbdO+Q9VPqLlgJdL1qEZ7P0igcX6nwbKqjF5t7wbDC+zP191T0fEpFBcR7TKiTj0QjR2VCzZAKZCkpC9R/Oasf3C0CFIYKtC844iHfLQ/XhS3B9jZ30SdvUyqNMOdS3Lsj7KrKsH+kj3FHE6IUbHJQeVDQ0ah71l94qbwOp2OUvZ2vyMdLVRPprMbCEVTlb8lwJrPisHTmKGlqtbDsYdo37qy0ws/9kMPjsOQV02AG3JIeTutriq8/dkL3G302y1eVzYOennhOJfaII6oXCZqDAwTn/e7wcYQIVibMHzIx+6RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5mzCvgTtHp5G6lhzudOhTHl4g0chGlNS4R+DblvEIFQ=;
 b=mDswmRE5gAqXOkSnu7f6G4k/nZBpGLX1ttOJcBgV4OlekRjzXreZrTe9ZIvZyAePw4cEY+yVIxUJl59z1zDsBz5/E+ZX9mQTm85oCYtlZXKsPcz5YjghGIL9DfbofvqXvgNWix/FSPd9VhiB9ba8CDpzyu2WzrHL7v7mbfNogU82VU6vTKmtCZ1JWy9JprLvjwhMALQyQ/TOKPwAlh44GgHtMCPTUFWU81eGeBTFE0OC1J8EKl+ka3qLs60cxrDw1u4BO7sqNBo2+pqU3t24f7tR75MvOmXFY1HZlc7enCa3AiWKTdnmamDcAmPoPYfcj6sppu8xl/3GgTPAd98TFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5mzCvgTtHp5G6lhzudOhTHl4g0chGlNS4R+DblvEIFQ=;
 b=PKkXXGnuVt3xfSIeU/TNh88jukbAYl3tpREX8WZH/8sv4vzRoY9wImXA39hoWNf41ImGaourFbYKHosp0Oc9m6imFigw5RUNKEZp2M9zfuF2XDtaA2y4RNdQs7/HdyHkKdC+fFfYn5j+W5ZkX1G3nCZmGBYTH3nIk/xel+LRaz7LIz5V5tnC4JAgPJ+fxujhSD1HeGoJMoOR6EtVe4KYsI1Z8FOLD78G/CMBXb5pg5bZKf3ALly/314zrE0N6mfvFvqJ1DtRsAZofSpwqtcOp6BdopAct0higL6VaqxjJNH8dMosxqIDyJwxCKkjZWm+dAgB8jJX5ZvYbJq/GQBCYg==
Received: from DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:395::21)
 by AM9PR10MB4593.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:266::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Mon, 23 May
 2022 12:35:20 +0000
Received: from DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7479:206e:9e85:df85]) by DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7479:206e:9e85:df85%4]) with mapi id 15.20.5273.022; Mon, 23 May 2022
 12:35:20 +0000
From:   "Starke, Daniel" <daniel.starke@siemens.com>
To:     Jiri Slaby <jirislaby@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 4/9] tty: n_gsm: fix missing timer to handle stalled
 links
Thread-Topic: [PATCH v2 4/9] tty: n_gsm: fix missing timer to handle stalled
 links
Thread-Index: AdhuoYqMHLmH9AcKRGicUvhj66xgZA==
Date:   Mon, 23 May 2022 12:35:20 +0000
Message-ID: <DB9PR10MB5881A13C22F91D7F5834E71EE0D49@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Enabled=true;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_SetDate=2022-05-23T12:35:18Z;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Method=Privileged;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Name=restricted-default;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_ActionId=e4236c8e-579d-4c24-958e-c145dd63805f;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_ContentBits=0
document_confidentiality: Restricted
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 73a021c0-3659-48d8-1936-08da3cb8b346
x-ms-traffictypediagnostic: AM9PR10MB4593:EE_
x-microsoft-antispam-prvs: <AM9PR10MB459318E37A2F930B2D1F475FE0D49@AM9PR10MB4593.EURPRD10.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ANRVfDIqOBAvli+41X0i4YTcurE4Ke8RqllIkQzKCQ9Pvy7wmeD7wFBQcObIXJdC/98Ur8uCn8T+039FTyFDkNyngrojmTPYWpIkJo6koL83TiFbnTxMUvQbed14zyCyt+Nr535DSMCc6zFFL642SA0v/KZrLmQ6OyM73w1XqMmbihVy4RyTgwrSq99Cfj1gcIMn5tCFy6YxUGNmMqQ9JwYXsVStN/Peg0wCa9roGFviEaWKDHEPmrxDmx1mRSYga73O/RGrmiG2NFQTAaPNO0WOKNhCCcozOuTRm5Xbs/iRWPtBn49cf7R69QREIhgBszaN0DkiLKWYc01Lo7wgPD/QL07C4VgizzaLCZukmcXVU/nkQGG1dpnsi0rg/Du2X5OBd5XNVGsn2OybAs0PR/3Od78ctJ9GM9urkFGVuXejbTvZtzPQ/jCIPPQHT6XbGVNucTE0HWxGNqaknS4eMLCCL4ESddtXyf0LAU4cpDgwWRZzN9Ox5MKqWFS8qt4BZ8TWoS3GTjcsFzjXPN5lt0sLLmLnFfhBCmyRCH2Y9Idw0nMBTsMlrUlYIOaThsL5ZnGrid1JS9ldlcnlHMo7o8t8EOnJ/0HMlPnArU7HiD0Pue7Tli6lEVCOJ6pKUmb0yUHhL95O0kNdOLQTXcvUTfoufONDdeOHALIYrThOErEz7nFfF3G6w+6uUvaRhT8+jcL7dt3I6DdH0LjhW5tOhg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(52536014)(8936002)(186003)(6506007)(316002)(110136005)(86362001)(508600001)(71200400001)(4326008)(76116006)(66946007)(8676002)(66476007)(66446008)(64756008)(66556008)(9686003)(7696005)(26005)(55236004)(38100700002)(38070700005)(122000001)(82960400001)(83380400001)(33656002)(55016003)(2906002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QWJqays2N3NUd3Zua1JET1VFcGowRlR0QmxRUlNCZ2ZHVFNkZC9vRTh4TWtj?=
 =?utf-8?B?S0wrOFdEYzc3Tmg0dXNFd3FlY1BHeVlma1FQYmZuZGN2Q0twTUFGT0wrZEgz?=
 =?utf-8?B?MlZxOWYrcS9XQ2JrTUtVSjdPQmMzNEJBWk40OXFDYVh6SkNsMzA4QXRaejQ1?=
 =?utf-8?B?dlZVYWwyS1l0d3NxQ0NHU2F2ZWloM1l5NmFiZDFXamZudFpuTjFkalRzN0Vj?=
 =?utf-8?B?cndxcis4YmgwWkJkRnRVMFl4STExOFMxMHYyZFowUFJXb1crYW4vTmlFaDZ6?=
 =?utf-8?B?TkZMd0x5TXZKL25veFM1T29nVzJWdFc5N0ljMFRiUWlrQldwdHQzODJnQ0Rq?=
 =?utf-8?B?RWxmaUNNKzlJL3U3TzRyNVF5UlhWMHdVSWs1RUd3TXBsZEpVOGYvRTR3V1Mz?=
 =?utf-8?B?Tjl3TVFJVEY2RUZLZlh0SVdsYXp3YzBCc3NOTXJFRlhXQlMrZGxzemJXNGlO?=
 =?utf-8?B?aUlDSjhuQVVtbjRjdDNaS2tuVUk3ZU9zVURQcGRaSXIxWU1DNWpOa0NnaEl5?=
 =?utf-8?B?czNYeEZFTFB6ckpwSVgzclowM2FRZnl2TllBNFhRQ1ZhWEFZWGlMcXd2VzlN?=
 =?utf-8?B?NkxlSnJheXlLd1pHV2tsZzhTUHNITW5Ja2R5U0FDdElIa1JjbERpUGlmUDl3?=
 =?utf-8?B?THNUc2dWTHE4VXlQU2tIWVBwY2VZMEZ0TVI3ZnZqZWtUZ2NvaUlidXBJKytB?=
 =?utf-8?B?SmRoSldhRE9EU3VWMExOaVh4ZWJUQUtNL0RkOUowb3MyanF4T0E2eTZuVXYy?=
 =?utf-8?B?RitnZFppUGdrNFg1YTZ3cWtaN2w1b2x6TVZuWFVBdWVHSy9JTzhlT2NrWXBI?=
 =?utf-8?B?QXdNZ1dEWElzNVU5U2tJZmlKakdHdDN2QTFLeklIQURNVUNQTUJnYkpNR0wr?=
 =?utf-8?B?dE1ONExFSVhDa3c0ZXFSTjNmeU10TFFSc09JL2F2RmcvWU5hN3pZREV5WXJR?=
 =?utf-8?B?TytNTUtQMHZSekhjeGJNTFYyRUsvZmdvTkQ5OXJnR0E2TUpjTXpuZm4vM3Ju?=
 =?utf-8?B?WkRPNGFuc3REYU5mMVFCakNlL1RJTFF6UjlNTDFVZm5BOEswcjFXNTNDNEJ4?=
 =?utf-8?B?ZFY5R0lYNDVvemxPYWhlQUN0TmFaY3lueUFPRlY1ZEdFUGp0RC9OL3pLNGlY?=
 =?utf-8?B?YVF4Mk5DeEpTN1BkNWpXa1dlK3lyUmhuRU9sdmdvQlQ1aGFLcmRERkdDU2Ey?=
 =?utf-8?B?d1pGZDVOeTFPUEZVa2FWdFU5RVBlb1BibG1GTXhaZGdRQURqTTB2V1dHYXE0?=
 =?utf-8?B?VmVrNVFxSjc4ZWpCODR1MktrY1gyWnhuVmQ3bmtTUUtlVmwyTmJyL1JZS21J?=
 =?utf-8?B?c2NWQm5nNThqZ0tkZ3gvaGl2bldlZWxMN01PVS9BSnB5eGRBanpEb0pDWUZD?=
 =?utf-8?B?ZE5ZWUU4S2V0STdheWc4MktXMjRnOHAyYnFJRzBtLzF4V21FNDE4b0hFVU1W?=
 =?utf-8?B?N1FONk5Edzg5YVRkdG5QemRPemV5bXlETncyRG5VdFJDWHpHVU0rVFI1akhy?=
 =?utf-8?B?R05lRDBZTzBncUJtUHJiR2hQM2UzZEJyVlVwM3BBd244NWZKckt2aGdGdkVT?=
 =?utf-8?B?T1pkbCtPSHQ3eWFmd2NhWVdtU2hLY2JoSDNxV00rK0thc0FSUVZ0MjNyNEkx?=
 =?utf-8?B?LzVsSUdxdmZQQmEvY2VWWGZMNUNqY0tUaUh4SS80K1NScUhJYndMVVgzNk4z?=
 =?utf-8?B?Z0VZQzhjV1pZU0MyR2lyVDJ0aXFGRUVDdi9xVnJ6Q2dGUDV4aHBodzgzd3lp?=
 =?utf-8?B?RWlhNjBKakQwS0UvS2RaT29sWUhUMWY3VDdhMzNxSkFVblQ0NlZnRC9wN25t?=
 =?utf-8?B?ajBzK0NZQUlxTEdpaHFVNm5oRWFCWHBjZURyelZXc3lCOVM5OWlJU3crUG56?=
 =?utf-8?B?TjZqMUlNQzNaWW9zb0VHRFg1THM1RFA4ZUlaZzdidFZGT1dDM096dFB5MTdZ?=
 =?utf-8?B?clBpTXVPOTJxNlA2Smk1OGN4R0VaVGdLN0xkYzNVNWxJMjZISVpVL2VFOVZx?=
 =?utf-8?B?enMybzc0RytNVG9YQkZRaUkwVTdnS3diNkNOa2g5bTR6REwvc2FxdmVrMEE3?=
 =?utf-8?B?WmpGbHExakpybG43R2dqWmdGaW4ybXN1MHE2bkpSbCtIa0U4ZmkvVjdJcUtH?=
 =?utf-8?B?TU9wNUVnKzFlSXFjaFJEZTNKbTdFY1kvWGZFdEVXejBmbzEyWS9iU2U0MVpk?=
 =?utf-8?B?N0t2TmJVOW5oMW83YTFjeVRIai9mOWFTSkYrckJFQkVvM2E4azJuWnZwTE96?=
 =?utf-8?B?L0NFZUlrR1VKOFpCd1FuMmhmZnhoV3JyS2c3TWVFbmJ3YUdqKy91NGFDcWVS?=
 =?utf-8?B?elJEV1o0eEl1bnBNQ3FYWVFhejNhMzR5TzV2Z1NDVXo2S21sTnY4cWVWamZV?=
 =?utf-8?Q?UQh109b+dl2pis/M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 73a021c0-3659-48d8-1936-08da3cb8b346
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2022 12:35:20.5086
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pxVkPtWljb8uGUcDrJy3gIfneBAGds2d+KX72dsnvpPNr7pC+oZgc/3HOJfvF7oGH8lLS8j1twFefy4ndfJausutznbN03RS1Y8dkbAW898=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4593
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+IEZyb206IERhbmllbCBTdGFya2UgPGRhbmllbC5zdGFya2VAc2llbWVucy5jb20+DQo+ID4g
DQo+ID4gVGhlIGN1cnJlbnQgaW1wbGVtZW50YXRpb24gZG9lcyBub3QgaGFuZGxlIHRoZSBzaXR1
YXRpb24gdGhhdCBubyBkYXRhIA0KPiA+IGlzIGluIHRoZSBpbnRlcm5hbCBxdWV1ZSBhbmQgbmVl
ZHMgdG8gYmUgc2VudCBvdXQgd2hpbGUgdGhlIHVzZXIgdHR5IA0KPiA+IGZpZm8gaXMgZnVsbC4N
Cj4gPiBBZGQgYSB0aW1lciB0aGF0IG1vdmVzIG1vcmUgZGF0YSBmcm9tIHVzZXIgdHR5IGRvd24g
dG8gdGhlIGludGVybmFsIA0KPiA+IHF1ZXVlIHdoaWNoIGlzIHRoZW4gc2VyaWFsaXplZCBvbiB0
aGUgbGRpc2MuIFRoaXMgdGltZXIgaXMgdHJpZ2dlcmVkIA0KPiA+IGlmIG5vIGRhdGEgd2FzIG1v
dmVkIGZyb20gYSB1c2VyIHR0eSB0byB0aGUgaW50ZXJuYWwgcXVldWUgd2l0aGluIDEwICogVDEu
DQo+ID4gDQo+ID4gRml4ZXM6IGUxZWFlYTQ2YmI0MCAoInR0eTogbl9nc20gbGluZSBkaXNjaXBs
aW5lIikNCj4gPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiA+IFNpZ25lZC1vZmYtYnk6
IERhbmllbCBTdGFya2UgPGRhbmllbC5zdGFya2VAc2llbWVucy5jb20+DQo+ID4gLS0tDQo+ID4g
ICBkcml2ZXJzL3R0eS9uX2dzbS5jIHwgNDMgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKystLS0tLS0tLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDM1IGluc2VydGlvbnMoKyksIDgg
ZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gU2VlIHBhdGNoIDYgcmVnYXJkaW5nIGNoYW5nZXMgc2lu
Y2UgdG8gdjEuDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdHR5L25fZ3NtLmMgYi9k
cml2ZXJzL3R0eS9uX2dzbS5jIGluZGV4IA0KPiA+IDBhOTkyNDQ0NTk2OC4uM2E0YTIzOTRkOTcw
IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvdHR5L25fZ3NtLmMNCj4gPiArKysgYi9kcml2ZXJz
L3R0eS9uX2dzbS5jDQo+IC4uLg0KPiA+IEBAIC04MzMsNiArODM0LDcgQEAgc3RhdGljIHZvaWQg
X19nc21fZGF0YV9xdWV1ZShzdHJ1Y3QgZ3NtX2RsY2kgKmRsY2ksIHN0cnVjdCBnc21fbXNnICpt
c2cpDQo+ID4gICAJbGlzdF9hZGRfdGFpbCgmbXNnLT5saXN0LCAmZ3NtLT50eF9saXN0KTsNCj4g
PiAgIAlnc20tPnR4X2J5dGVzICs9IG1zZy0+bGVuOw0KPiA+ICAgCWdzbV9kYXRhX2tpY2soZ3Nt
LCBkbGNpKTsNCj4gPiArCW1vZF90aW1lcigmZ3NtLT5raWNrX3RpbWVyLCBqaWZmaWVzICsgMTAg
KiBnc20tPnQxICogSFogLyAxMDApOw0KPiANCj4gVGhlIGZvcm11bGEgZGVzZXJ2ZXMgYW4gZXhw
bGFuYXRpb24uIEFuZCB3aHkgMTAgKiBYIC8gMTAwLCBhbmQgbm90IFggLyAxMD8NCg0KVDEgaXMg
ZGVmaW5lZCBhcyAxLzEwMHRoIG9mIGEgc2Vjb25kIChzZWUgY2hhcHRlciA1LjcuMSBvZiB0aGUg
c3RhbmRhcmQpLg0KVGhlcmVmb3JlLCBpdCBpcyBnc20tPnQxICogSFogLyAxMDAuIEkgY2hvc2Ug
MTB4IFQxIGFzIHRoaXMgY2FzZSBzaG91bGQNCnVzdWFsbHkgbm90IG9jY3VyIGFuZCBvbmx5IGFj
dHMgYXMgYSBmaW5hbCBjb3VudGVybWVhc3VyZSBhZ2FpbnN0IGENCnN0YWxsZWQgbGluay4gT3Ig
YXJlIHRoZXJlIGFueSBvdGhlciBzdWdnZXN0aW9ucyBmb3IgYSBwcm9wZXIga2ljayB0aW1lcg0K
dmFsdWU/DQoNCj4gPiBAQCAtMTA2Miw5ICsxMDU4LDkgQEAgc3RhdGljIGludCBnc21fZGxjaV9t
b2RlbV9vdXRwdXQoc3RydWN0IGdzbV9tdXggKmdzbSwgc3RydWN0IGdzbV9kbGNpICpkbGNpLA0K
PiA+ICAgICoJcmVuZWdvdGlhdGUgRExDSSBwcmlvcml0aWVzIHdpdGggb3B0aW9uYWwgc3R1ZmYu
IE5lZWRzIG9wdGltaXNpbmcuDQo+ID4gICAgKi8NCj4gPiAgIA0KPiA+IC1zdGF0aWMgdm9pZCBn
c21fZGxjaV9kYXRhX3N3ZWVwKHN0cnVjdCBnc21fbXV4ICpnc20pDQo+ID4gK3N0YXRpYyBpbnQg
Z3NtX2RsY2lfZGF0YV9zd2VlcChzdHJ1Y3QgZ3NtX211eCAqZ3NtKQ0KPiA+ICAgew0KPiA+IC0J
aW50IGxlbjsNCj4gPiArCWludCBsZW4sIHJldCA9IDA7DQo+IA0KPiBXaHkgaXMgcmV0IHNpZ25l
ZD8NCg0KTWFueSBvYnZpb3VzbHkgb25seSB1bnNpZ25lZCB2YWx1ZXMgYXJlIHNpZ25lZCBpbiB0
aGUgY29kZSBvZiB0aGUgb3JpZ2luYWwNCmF1dGhvci4gSSBzaW1wbHkgYWxpZ25lZCBteSBjb2Rl
IHRvIHRoaXMgdG8gYmVsaWV2ZSB0aGF0IGludCBpcyBwcmVmZXJyZWQuDQpCdXQgSSBjYW4gY2hh
bmdlIGl0IHRvIHVuc2lnbmVkIGludCBpZiB0aGlzIGlzIHByZWZlcnJlZCBoZXJlPw0KDQpCZXN0
IHJlZ2FyZHMsDQpEYW5pZWwgU3RhcmtlDQo=
