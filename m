Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05F584A603E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 16:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240190AbiBAPhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 10:37:04 -0500
Received: from mail-vi1eur05on2054.outbound.protection.outlook.com ([40.107.21.54]:29601
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233563AbiBAPhC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 10:37:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M58VjGRzcdP1G2SWdfCYOjgVYXQnlz8HufOJlQxyxMc9HkIUHtpVfCTLwlfQAGoV10e4xxIVYvIXsucaKFtnV7/mBo5rfAA02wVvOwrIxG1awzY2omUsK6YOI4utR5Pgr4or72T7KdMxCC/CGWCrHrg1LZt/qChSICqSJTV7aVDQTCWF/nIpdIMHFe3kWPimQxr2TCQ8yxN6PR72F31DLaWCFNF38glmQoR2CiHRMmTr+dVw6/ZDFzHT5ONk+mOsNR97of2E/Cdu4rXU0Q3AiRqIe/00IZgvGPMN4f8W5Si7UNACCXGLZMpYXZV2n5aGUj12NpAaushD0QB2AHIsPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r8J3vDKqis5zQBgVAJeNbVcfA2OaA5P8JHa8MUdpxOM=;
 b=UgyWC/QI2GQds/S5WKPsUI+UtXL3cUHYBuSznNffrOs/Q9KTpgclnVEEeZxFxhkC7AeEnuReejSZ4x745xwuWSp5OihqrGWPl+iBzrW1c3eGcMuWfY/e28R2VCjPcBf4dKx5y1QxOOc7+8pi/Bx0ydbYDO1AGrUOOb0JMfFfSpypnr9U5zJ4fIOseM8PICPyXiOBgesJ7hqLgam8nQAcXH6uCzRTHy033PtEkAxoyKCX5+wHh8o5yOspvH0TMgVPWJL3TGx058WO080SOMpK2CqRQBWIPT0HPdWObU3oqIpmX/rKAfZJkxydyIsdAsGKUa38mtTDXSYuuCJivVPwSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r8J3vDKqis5zQBgVAJeNbVcfA2OaA5P8JHa8MUdpxOM=;
 b=UpS4Ti/UP057Dy86AfTgduGcNXHmY/oiNvv27AVvRwzssUbnDP4lpjJJ8YFl7Ef8pBwqrPY15PHek4niXuZX+2FRWdHhoSZWwBw0aqaiJp+OyeXHJaWUKIkp0RS/XaTUKb25L+Rtcsovav+/pL/W2yiZXeinwAJ+RZVlusqP83g=
Received: from PAXPR04MB8334.eurprd04.prod.outlook.com (2603:10a6:102:1cc::8)
 by AM9PR04MB8113.eurprd04.prod.outlook.com (2603:10a6:20b:3e9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.22; Tue, 1 Feb
 2022 15:37:00 +0000
Received: from PAXPR04MB8334.eurprd04.prod.outlook.com
 ([fe80::a804:e11c:f458:a582]) by PAXPR04MB8334.eurprd04.prod.outlook.com
 ([fe80::a804:e11c:f458:a582%4]) with mapi id 15.20.4930.022; Tue, 1 Feb 2022
 15:37:00 +0000
From:   Nikhil Gupta <nikhil.gupta@nxp.com>
To:     Rob Herring <robh+dt@kernel.org>
CC:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Priyanka Jain <priyanka.jain@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>
Subject: RE: [EXT] Re: [PATCH] of/fdt: move elfcorehdr reservation early for
 crash dump kernel
Thread-Topic: [EXT] Re: [PATCH] of/fdt: move elfcorehdr reservation early for
 crash dump kernel
Thread-Index: AQHYE/7NUAdCF89rWEGfCrdo+11hRqx4kKqAgAY+g8A=
Date:   Tue, 1 Feb 2022 15:36:59 +0000
Message-ID: <PAXPR04MB83348BB9265516255BBB2ACB8B269@PAXPR04MB8334.eurprd04.prod.outlook.com>
References: <20220128042321.15228-1-nikhil.gupta@nxp.com>
 <CAL_JsqKWmnQde+4tnZ3d90pWguezLVqto4DRe3WRjf9PCQ=L4w@mail.gmail.com>
In-Reply-To: <CAL_JsqKWmnQde+4tnZ3d90pWguezLVqto4DRe3WRjf9PCQ=L4w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f761eb24-daa7-421c-05c5-08d9e598affe
x-ms-traffictypediagnostic: AM9PR04MB8113:EE_
x-microsoft-antispam-prvs: <AM9PR04MB81130779B152423C2C095BE08B269@AM9PR04MB8113.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Lq4vTrVALvMrPPLwwzQLVICXWCtn57wKzce/3t0oZSrsMW63/SK1QOeDzgg08EdNjPZ92hIvs6zmhe3ocgYt61uM6y6T0Kya7Y1+jGg0WOQcDFY1YM2G0UvF460eKQs4eYa/I6if9+Zub2krXf7c0+iElM9F6gZ5LlGwfKTo3ZrWHxZtN8xQQ4aOXrZYdRVk8Zy8LUVnh8v5F0pyycGFGE7GVo3cJjb3Nne9xgX7ifJo2oYNi2CKYlJCskfPdO8qVT4L3M6QUbL6527Wpr4b2p4HAuKVWUOUqQqshK/KqE3ed5xrYe/oq4iy66lWqGhD1TZ1pA6m0/CTchTxnQbdO/n5BzbrVnqZHCcsWvaPJSDiPrgA+0jT2PTPxT9OjufYgvSnLUob20fzT6B8hKP2FPfiePOfOTCBx/D3RHlNvUEROjwL9viWMa43SP4XIqa7/QmxPZaJX57HQi0ewQxbygvALjJnUgGfDvMbZLhadYyu4ahLFc1lCB5sxljPuOsCZ2C48n569SqHBO9G/RbmqgWa5LeFveQAMdAMwFS7PtubLlgK54bcF03kpUys8ZRnVt4CysGv9VJlXueOtbctu4dI+336HS4mDf2fd3d5FZsmeqtmZlsqObGDmqC6/Reu1xSJV+XTDbvnr10TbghwG2IhaLlEQ1NgLzjMme5We8GH6y1lpqpnVdho6u1LjoxEzGbL2rIqQFDASImrUcl3RQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8334.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(71200400001)(53546011)(26005)(186003)(55236004)(9686003)(122000001)(6506007)(7696005)(2906002)(38100700002)(38070700005)(4326008)(316002)(66556008)(33656002)(76116006)(66946007)(66446008)(66476007)(64756008)(8936002)(86362001)(54906003)(8676002)(55016003)(5660300002)(83380400001)(44832011)(52536014)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WFI4ZDJLRnU0WE1IWWx0MlVObzMzMWdRa2JVUUlDanFHdTJicjJWakhiMlN4?=
 =?utf-8?B?UTJQNlJTMCtJOVRnQkNFdCtjKzQvZHBWS1hrdjFHejROVytJcitFNHR1UlVj?=
 =?utf-8?B?cFRzQkpINzhpTDRNOWEvVFZCc0JBQjBWdzl5R1NLMjI0bW54elVFK2djTXZ6?=
 =?utf-8?B?M2FYMzhOeXRBNHhnNHREVnFKYis5bFBCd3dSdDN5TmZ3UllPZUtieWQzcnlP?=
 =?utf-8?B?aXkwcmNkWTQxNlAzNXpxQW1JYllsT1lQYmhXMkFJa1ZsMlpCRWtGeXN1YkUv?=
 =?utf-8?B?YmJRdlhhc3Q1MnIwbW5EZkdTbUk4VTJ0aytLUGJHUGlLUGdJczRVS1J6aTZp?=
 =?utf-8?B?b3oyd1p5YVFFeWJRY2JVMkxEQy8zdVlkUitQZkRLMU5YZnJmVFdRR0ZFM2h1?=
 =?utf-8?B?NUlyMmtxK2JhSUl2ai9GcTdKRmhmYmZ6aU9UUEhmbmRPUlZmTFowNXVQYk9z?=
 =?utf-8?B?NHhNbkFrekVFdEF3cmpjQXlBTS9yMFVXSFJqeitOOEorWFlDLzVaQTdMMjFO?=
 =?utf-8?B?NUk3TW42L2g1OVZVb2hNR081Rld1UFNuQS91N21uVkJzU1ZLdnU1Uy95d3cx?=
 =?utf-8?B?cjBxSHliQmZYekNSYjZBa0t6dVhaRW05elFrWUF4QXl1eXJhNnFGZkVuTW9s?=
 =?utf-8?B?REVUUWJQck5zczl0dGR2S1JuSDJwMjE1QXBXVm5GaHQxOFhhdW9STXJrUm9M?=
 =?utf-8?B?aWRaWjRLTzVFR3JkSU5aWVgzbjVkUXFRRzRBWDNFM0xScG5kRWVMdEZqSUNo?=
 =?utf-8?B?OHpha254TjRrMUlTTDNWdGVlb0VGaEk0QmtuQ1doZlF5MCtFaXF1b09kQXdY?=
 =?utf-8?B?RzhxZHQvMy9WNW9NelRSdThnTVpjMTNoY29VU2xOcTVHM1dMcmtlblcycDZG?=
 =?utf-8?B?MTlvd09Rd1pLU3lqNXUreDBKaHRxL0J6OXN1K0xiNzdBTVZIMmlaQ0RBeE1H?=
 =?utf-8?B?MS9TbndJTENRTnVoOUpSd2cybmxXV05UZzlkdERNaEVzRWhZTFdXS3Fienlz?=
 =?utf-8?B?aUpSUjNlVmw2ZHNDQXY3UWJmU3p3RnZYRGdNZ1F3SXJwVkRWWVdjZ1R5RUtO?=
 =?utf-8?B?akpoSWFWWGwvdWkzMm1DTURkT3lrN0ptbG9TUitOVzhCNno0ZndRdXUzZTBC?=
 =?utf-8?B?bkhFRVIzYnVDOVp4U0pqUE1SZ1g5NThUOFNSZ3dVVmlqUzVxODUwVVBIQVBt?=
 =?utf-8?B?K01SSHIwODNmQ2EybFNSTDNSMGlIVnY2RUpmVnpFWTRGU0YxNUlDZEYrM1ZD?=
 =?utf-8?B?MUoyNHRNK1pEVGpnUnZ4TVhWdUQrOHJuQmNxd2IySzQyNFZ0Ui9kcFZHNXBs?=
 =?utf-8?B?L2RCTTRML0lsR1AvcTRxc0hlWnVRMEVNdEh5S2EzejVlZlRuN1RpUVhYeHpv?=
 =?utf-8?B?bG5tZ0wrR25LYXBiY25RbUdPUkpzbHRmSjh2bHRwR3Y5bUJTVzBhZGg1YXJ0?=
 =?utf-8?B?WFZWOTNMYStXUTh5MVEvNWJOcHZ4SjlPS1RVN2JsUnZYbHhsMzM4KzlxQWQw?=
 =?utf-8?B?bDlxLy9WVlZwUjVlVENOSUN5eEhOb2JndGRkTmx4TU95aTljZFNrUXltU2R1?=
 =?utf-8?B?NTM5N1J3L0kvSTVmYWpyaXlEd2dGeEREd29SL0kyaE9mMUFLa21LWU5VQnFo?=
 =?utf-8?B?YzlQYUFyclVUcWtMS3dnUVNSaEUvT1dLZm5iRSs4MkZqSERzN3VlbWh0R0ds?=
 =?utf-8?B?cUZlOWl0VjZHSkRYajJXaEJ6a1A3eWJ6Qys0UWJkVkVxK1MrKzhiWVdzRVdO?=
 =?utf-8?B?eGVqZ09kWjZWT29PcGlFUWRQczlLc2ppNnJvLzlESHlrbEM2OG5obVNQeVY0?=
 =?utf-8?B?M3hDK2lRZC9qeDl6WHpCYW1rNmxBcGYzNlVXcTdSMlA2U3hNUkYyOS9kY0du?=
 =?utf-8?B?ZzVOcWlCSTZCM2IzeWRjUC9PWUM2bEExMkJELzJnTlZOWlRlRjZEdjBuV3k2?=
 =?utf-8?B?TVljVkJTRE15ZFhwTVFlamhRR25KNEF2ZVlEZEtJcEh5NWJmVlpjajdESWhk?=
 =?utf-8?B?UklhaTZNNUNjd0xXcFNvQ2NsS0hyUGR2OTRDbDRaMXArRkNNdzBBOVJzbDQy?=
 =?utf-8?B?ajMwdm5tVFl3QUFzYkFSR08wZk9yd3QrSHl0ZnRib0tXU0gyQWhxTUdvR1pC?=
 =?utf-8?B?SHp1V0VlRUduM3VhWC9lb3pTdmFsdzZBR2VyckdIV3I0R1kvNG5mdElHdUVj?=
 =?utf-8?Q?BLclP+xiht2nLLAc2c5GOJU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8334.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f761eb24-daa7-421c-05c5-08d9e598affe
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2022 15:36:59.8836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T2Lqe4MPHcYCYKvjcuArqCJ58pa0EqbIMR1CQX22KPkFf/gS4TazyTSB9Jhtyw9VogLmBdmkgvwjbY6SKQpc9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8113
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gUm9iLA0KDQpUaGlzIGlzc3VlIHdpbGwgY29tZSBpbiBzY2VuYXJpb3Mgd2hlcmUgdGhl
IG1lbW9yeSBoYXMgYmVlbiByZXNlcnZlZCB1c2luZyBmZHRfaW5pdF9yZXNlcnZlZF9tZW0oKQ0K
VGhlIG1lbW9yeSBhZGRyZXNzIHdoaWNoIGlzIHJlc2VydmVkIG92ZXJsYXBzIHdpdGggdGhlIGFk
ZHJlc3Mgb2YgZWxmY29yZWhkciB3aGljaCBoYXMgYSBmaXhlZCBhZGRyZXNzLA0KU28gdGhlIG1l
bW9yeSBmb3IgZWxmY29yZWhkciBuZWVkcyB0byBiZSByZXNlcnZlZCBmaXJzdC4NCg0KY3Jhc2hr
ZXJuZWwgbWVtb3J5IHJhbmdlIDogMHgwMDAwMDAwMGQ0MDAwMDAwIC0gMHgwMDAwMDAwMGY0MDAw
MDAwICg1MTIgTUIpDQplbGZjb3JlaGRyIGFkZHIgaXMgY2FsY3VsYXRlZCBpbiBrZXhlYyB0b29s
IGJhc2VkIG9uIHJlc2VydmVkIGNyYXNoa2VybmVsIG1lbW9yeSBzcGFjZS4gKExhc3QgcGFnZSBp
cyB1c2VkIGluIHRvcCBkb3duIG9yZGVyKQ0KZWxmY29yZWhkciBjb25mbGljdCB3aXRoIG1lbW9y
eSBbICAgIDAuMDAwMDAwXSBtZW1ibG9ja19yZXNlcnZlOiBbMHgwMDAwMDAwMGYzYzAwMDAwLTB4
MDAwMDAwMDBmM2ZmZmZmZl0gcmVzZXJ2ZWQgYnkgZmR0X2luaXRfcmVzZXJ2ZWRfbWVtKCkNCg0K
V2l0aG91dCBQYXRjaDoNCg0KWyAgICAwLjAwMDAwMF0gbWVtYmxvY2tfcmVzZXJ2ZTogWzB4MDAw
MDAwMDBkNDAxMDAwMC0weDAwMDAwMDAwZDY3N2ZmZmZdIGFybTY0X21lbWJsb2NrX2luaXQrMHgy
NTgvMHgyYzgNClsgICAgMC4wMDAwMDBdIG1lbWJsb2NrX3BoeXNfYWxsb2NfcmFuZ2U6IDQxOTQz
MDQgYnl0ZXMgYWxpZ249MHg0MDAwMDAgZnJvbT0weDAwMDAwMDAwMDAwMDAwMDAgbWF4X2FkZHI9
MHgwMDAxMDAwMDAwMDAwMDAwIGVhcmx5X2luaXRfZHRfYWxsb2NfcmVzZXJ2ZWRfbWVtb3J5X2Fy
Y2grMHg5Yy8weDE2Yw0KWyAgICAwLjAwMDAwMF0gbWVtYmxvY2tfcmVzZXJ2ZTogWzB4MDAwMDAw
MDBmM2MwMDAwMC0weDAwMDAwMDAwZjNmZmZmZmZdIG1lbWJsb2NrX2FsbG9jX3JhbmdlX25pZCsw
eGRjLzB4MTUwDQpbICAgIDAuMDAwMDAwXSBtZW1ibG9ja19waHlzX2FsbG9jX3JhbmdlOiAzMzU1
NDQzMiBieXRlcyBhbGlnbj0weDIwMDAwMDAgZnJvbT0weDAwMDAwMDAwMDAwMDAwMDAgbWF4X2Fk
ZHI9MHgwMDAxMDAwMDAwMDAwMDAwIGVhcmx5X2luaXRfZHRfYWxsb2NfcmVzZXJ2ZWRfbWVtb3J5
X2FyY2grMHg5Yy8weDE2Yw0KWyAgICAwLjAwMDAwMF0gbWVtYmxvY2tfcmVzZXJ2ZTogWzB4MDAw
MDAwMDBmMDAwMDAwMC0weDAwMDAwMDAwZjFmZmZmZmZdIG1lbWJsb2NrX2FsbG9jX3JhbmdlX25p
ZCsweGRjLzB4MTUwDQpbICAgIDAuMDAwMDAwXSBtZW1ibG9ja19waHlzX2FsbG9jX3JhbmdlOiAx
Njc3NzIxNiBieXRlcyBhbGlnbj0weDEwMDAwMDAgZnJvbT0weDAwMDAwMDAwMDAwMDAwMDAgbWF4
X2FkZHI9MHgwMDAxMDAwMDAwMDAwMDAwIGVhcmx5X2luaXRfZHRfYWxsb2NfcmVzZXJ2ZWRfbWVt
b3J5X2FyY2grMHg5Yy8weDE2Yw0KWyAgICAwLjAwMDAwMF0gbWVtYmxvY2tfcmVzZXJ2ZTogWzB4
MDAwMDAwMDBmMjAwMDAwMC0weDAwMDAwMDAwZjJmZmZmZmZdIG1lbWJsb2NrX2FsbG9jX3Jhbmdl
X25pZCsweGRjLzB4MTUwDQpbICAgIDAuMDAwMDAwXSBPRjogcmVzZXJ2ZWQgbWVtOiBpbml0aWFs
aXplZCBub2RlIGJtYW4tZmJwciwgY29tcGF0aWJsZSBpZCBmc2wsYm1hbi1mYnByDQpbICAgIDAu
MDAwMDAwXSBPRjogZmR0OiBlbGZjb3JlaGRyIGlzIG92ZXJsYXBwZWQNCg0KV2l0aCBQYXRjaDoN
Cg0KWyAgICAwLjAwMDAwMF0gbWVtYmxvY2tfcmVtb3ZlOiBbMHgwMDAxMDAwMDAwMDAwMDAwLTB4
MDAwMGZmZmZmZmZmZmZmZV0gYXJtNjRfbWVtYmxvY2tfaW5pdCsweGEwLzB4MmQ4DQpbICAgIDAu
MDAwMDAwXSBtZW1ibG9ja19yZW1vdmU6IFsweDAwMDA4MDAwYzAwMDAwMDAtMHgwMDAwODAwMGJm
ZmZmZmZlXSBhcm02NF9tZW1ibG9ja19pbml0KzB4ZmMvMHgyZDgNClsgICAgMC4wMDAwMDBdIG1l
bWJsb2NrX3JlbW92ZTogWzB4MDAwMDAwMDBkNjE2MDAwMC0weDAwMDAwMDAwZDgzYmVmZmZdIGFy
bTY0X21lbWJsb2NrX2luaXQrMHgxYzgvMHgyZDgNClsgICAgMC4wMDAwMDBdIG1lbWJsb2NrX2Fk
ZDogWzB4MDAwMDAwMDBkNjE2MDAwMC0weDAwMDAwMDAwZDgzYmVmZmZdIGFybTY0X21lbWJsb2Nr
X2luaXQrMHgxZDQvMHgyZDgNClsgICAgMC4wMDAwMDBdIG1lbWJsb2NrX3Jlc2VydmU6IFsweDAw
MDAwMDAwZDYxNjAwMDAtMHgwMDAwMDAwMGQ4M2JlZmZmXSBhcm02NF9tZW1ibG9ja19pbml0KzB4
MWUwLzB4MmQ4DQpbICAgIDAuMDAwMDAwXSBtZW1ibG9ja19yZXNlcnZlOiBbMHgwMDAwMDAwMGQ0
MDEwMDAwLTB4MDAwMDAwMDBkNjE1ZmZmZl0gYXJtNjRfbWVtYmxvY2tfaW5pdCsweDI2MC8weDJk
OA0KWyAgICAwLjAwMDAwMF0gbWVtYmxvY2tfcmVzZXJ2ZTogWzB4MDAwMDAwMDBmM2ZmZjAwMC0w
eDAwMDAwMDAwZjNmZmYzZmZdIGVhcmx5X2luaXRfZmR0X3NjYW5fcmVzZXJ2ZWRfbWVtKzB4Mzcw
LzB4M2M4DQpbICAgIDAuMDAwMDAwXSBPRjogZmR0OiBSZXNlcnZpbmcgMSBLaUIgb2YgbWVtb3J5
IGF0IDB4ZjNmZmYwMDAgZm9yIGVsZmNvcmVoZHINClsgICAgMC4wMDAwMDBdIG1lbWJsb2NrX3Bo
eXNfYWxsb2NfcmFuZ2U6IDQxOTQzMDQgYnl0ZXMgYWxpZ249MHg0MDAwMDAgZnJvbT0weDAwMDAw
MDAwMDAwMDAwMDAgbWF4X2FkZHI9MHgwMDAxMDAwMDAwMDAwMDAwIGVhcmx5X2luaXRfZHRfYWxs
b2NfcmVzZXJ2ZWRfbWVtb3J5X2FyY2grMHgzOC8weDhjDQpbICAgIDAuMDAwMDAwXSBtZW1ibG9j
a19yZXNlcnZlOiBbMHgwMDAwMDAwMGYzODAwMDAwLTB4MDAwMDAwMDBmM2JmZmZmZl0gbWVtYmxv
Y2tfYWxsb2NfcmFuZ2VfbmlkKzB4ZGMvMHgxNTANClsgICAgMC4wMDAwMDBdIG1lbWJsb2NrX3Bo
eXNfYWxsb2NfcmFuZ2U6IDMzNTU0NDMyIGJ5dGVzIGFsaWduPTB4MjAwMDAwMCBmcm9tPTB4MDAw
MDAwMDAwMDAwMDAwMCBtYXhfYWRkcj0weDAwMDEwMDAwMDAwMDAwMDAgZWFybHlfaW5pdF9kdF9h
bGxvY19yZXNlcnZlZF9tZW1vcnlfYXJjaCsweDM4LzB4OGMNClsgICAgMC4wMDAwMDBdIG1lbWJs
b2NrX3Jlc2VydmU6IFsweDAwMDAwMDAwZjAwMDAwMDAtMHgwMDAwMDAwMGYxZmZmZmZmXSBtZW1i
bG9ja19hbGxvY19yYW5nZV9uaWQrMHhkYy8weDE1MA0KWyAgICAwLjAwMDAwMF0gbWVtYmxvY2tf
cGh5c19hbGxvY19yYW5nZTogMTY3NzcyMTYgYnl0ZXMgYWxpZ249MHgxMDAwMDAwIGZyb209MHgw
MDAwMDAwMDAwMDAwMDAwIG1heF9hZGRyPTB4MDAwMTAwMDAwMDAwMDAwMCBlYXJseV9pbml0X2R0
X2FsbG9jX3Jlc2VydmVkX21lbW9yeV9hcmNoKzB4MzgvMHg4Yw0KDQpLaW5kIFJlZ2FyZHMsDQpO
aWtoaWwNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IFJvYiBIZXJyaW5nIDxy
b2JoK2R0QGtlcm5lbC5vcmc+IA0KU2VudDogRnJpZGF5LCBKYW51YXJ5IDI4LCAyMDIyIDk6MDMg
UE0NClRvOiBOaWtoaWwgR3VwdGEgPG5pa2hpbC5ndXB0YUBueHAuY29tPg0KQ2M6IGxpbnV4LWFy
bS1rZXJuZWwgPGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZz47IEZyYW5rIFJv
d2FuZCA8ZnJvd2FuZC5saXN0QGdtYWlsLmNvbT47IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBQcml5YW5rYSBKYWluIDxwcml5YW5rYS5q
YWluQG54cC5jb20+OyBBaXNoZW5nIERvbmcgPGFpc2hlbmcuZG9uZ0BueHAuY29tPg0KU3ViamVj
dDogW0VYVF0gUmU6IFtQQVRDSF0gb2YvZmR0OiBtb3ZlIGVsZmNvcmVoZHIgcmVzZXJ2YXRpb24g
ZWFybHkgZm9yIGNyYXNoIGR1bXAga2VybmVsDQoNCkNhdXRpb246IEVYVCBFbWFpbA0KDQpPbiBU
aHUsIEphbiAyNywgMjAyMiBhdCAxMDoyMyBQTSA8bmlraGlsLmd1cHRhQG54cC5jb20+IHdyb3Rl
Og0KPg0KPiBGcm9tOiBOaWtoaWwgR3VwdGEgPG5pa2hpbC5ndXB0YUBueHAuY29tPg0KPg0KPiBl
bGZjb3JlaGRyX2FkZHIgaXMgZml4ZWQgYWRkcmVzcyBwYXNzZWQgdG8gU2Vjb25kIGtlcm5lbCB3
aGljaCBtYXkgYmUgDQo+IGNvbmZsaWN0ZWQgd2l0aCBwb3RlbnRpYWwgcmVzZXJ2ZWQgbWVtb3J5
IGluIFNlY29uZCBrZXJuZWwsc28gDQo+IGZkdF9yZXNlcnZlX2VsZmNvcmVoZHIoKSBhaGVhZCBv
ZiBmZHRfaW5pdF9yZXNlcnZlZF9tZW0oKSBjYW4gcmVsaWV2ZSB0aGlzIHNpdHVhdGlvbi4NCg0K
SG93IGRvZXMgY2hhbmdpbmcgdGhlIG9yZGVyIGhlbHAgZXhhY3RseT8gSWYgeW91IGhhdmUgYW4g
b3ZlcmxhcCwgdGhhdCBzZWVtcyBiYWQgbm8gbWF0dGVyIHdoYXQuIFdoYXQgaWYgdGhlIG92ZXJs
YXBwaW5nIHJlc2VydmVkIGFyZWEgaXMgdXNlZCBieSBhbm90aGVyIGNvcmUgb3IgZmlybXdhcmU/
DQoNClJvYg0K
