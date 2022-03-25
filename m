Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 232574E6C46
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 02:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357613AbiCYB7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 21:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245354AbiCYB7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 21:59:02 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2137.outbound.protection.outlook.com [40.107.255.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B749F6F5;
        Thu, 24 Mar 2022 18:57:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=keZqBTwWDt4a6M/5q7Gs3T5SPVEA+Y0bw+cQ99nX2zKdRCDALF88yjiaLQjJ3UqPHfgLuqxgCAyIEXC6WFpygZvlbWstpvT7NfxKrgDsAHgGwGYwQSb+ftkKI7woEl5P+ySe+MBUMANrAj6EsOW8Z4QUT+x+Je7VIMH2ymSrxgjgxk1kPFqO6Zr7f1HOE3x5HfJf5ZeKSPWFL6OmFVCSnX9ARf4CtGdvo5DAMxhxD3IDuWuOQ4u1daHV1/r9RByp7cAoTnl0V2uCutNi0AQqCBnI5GYwpngel3bSfreUdy5VVBouKNvN6DQnp72rruI/PzwMzvxGn8OsgXQsEGDTmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nk+9uTh9v3WPata+czIdfobV6Oro0f4JTOEKpuJxX+8=;
 b=GGXqurV8YUv+wpkh6bN/+CVbGO9URhSgV/G8/bzzoYsxybbIRGePt8S+qR0BKi6CqR5ekveqMu38GL3hD2+XQZ93nLvdzbH/Z8zV7Xaj3luPIBFJjljBQt6QfrZy6BxTmdQwjejmNA9vIIpGtDknao9lPs9ldP41pP8pDkhmbfTxXqHe/rKRy2kwyKQsCLznqqY8ZfsPFMocX3/qRUOZT3t0zvoHD+rmfqqmPZtzJSOQOTyYp1GL6WRLsakCrdsHhny+Pe6XkTZFx3/wz0/m9kVcvYafBAknSiS77LXiQxz4CCpJmKyohWq9F8gYxhbChyaoRUQXgOxUV2ehiXf40A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nk+9uTh9v3WPata+czIdfobV6Oro0f4JTOEKpuJxX+8=;
 b=U2tQ8gZs9QolqrJCD4uV/wO7y9SYSxyeYklAtlNFQtSsaCn+vKBoA7h+BqhHwifK4A2Ss4ifKO/oBW0pe1XTiBpt0NYIOxyscNJ3n6Hi03ohgegu8lAvRUei/SsxEy4nIlFwDpeGH/CKIc0E1n69ssZA1poYiWLScgZfCz7Niv3KB63HdeOpieSDRKKBDw6YpzfqN83HyHoIvpKillDOKwOqqcHAW3p0EX3EpMpOTzUhUyOKvU3Q686yVa2CXeH+lHcxoLb6CJhOROySat9oESxgQoa18hTtDhQrPJXOm9nPWJfA6Bb+HPFE219MyFOhdC2JD9gwlgt5fWeJO8ElaQ==
Received: from HK0PR06MB2307.apcprd06.prod.outlook.com (2603:1096:203:46::19)
 by HK0PR06MB3234.apcprd06.prod.outlook.com (2603:1096:203:85::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Fri, 25 Mar
 2022 01:57:24 +0000
Received: from HK0PR06MB2307.apcprd06.prod.outlook.com
 ([fe80::e89b:474d:4944:ca2a]) by HK0PR06MB2307.apcprd06.prod.outlook.com
 ([fe80::e89b:474d:4944:ca2a%6]) with mapi id 15.20.5102.019; Fri, 25 Mar 2022
 01:57:23 +0000
From:   Howard Chiu <howard_chiu@aspeedtech.com>
To:     Jae Hyun Yoo <quic_jaehyoo@quicinc.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 2/3] dt-bindings: clock: Add AST2600 video engine reset
 definition
Thread-Topic: [PATCH v1 2/3] dt-bindings: clock: Add AST2600 video engine
 reset definition
Thread-Index: Adg/UKCbpNLlLr71St+tw+UGNvcM8wANZZ+AABlaAUA=
Date:   Fri, 25 Mar 2022 01:57:23 +0000
Message-ID: <HK0PR06MB23073BAA6569EE0AD5527D00E61A9@HK0PR06MB2307.apcprd06.prod.outlook.com>
References: <SG2PR06MB2315F68B23BB0998B8F7E93EE6199@SG2PR06MB2315.apcprd06.prod.outlook.com>
 <527e9d9e-0dac-3a97-da83-068891a41381@quicinc.com>
In-Reply-To: <527e9d9e-0dac-3a97-da83-068891a41381@quicinc.com>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 903bce68-6859-48c0-1943-08da0e02ce49
x-ms-traffictypediagnostic: HK0PR06MB3234:EE_
x-microsoft-antispam-prvs: <HK0PR06MB3234D9B10991D7311BA11413E61A9@HK0PR06MB3234.apcprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zkuvu+tKLru7rynnZmmP4nfkqQ+Qirkn3plBXbOKS4eirhALAkFB2nPSFaHBZBD+3yWJTvYFkFYn/KXnTsnq4utuD53CtfN7uhjThU0fgOzWtITOlaXiQHKTLuT/oxMlFt7BPSix4C6RO+UusHwWBFq8NP2+zmqhCcPR91jofksKcOROJBjADwLObVQs4GU6Q9FQMRtqCnnV/z5D3rwe4SHZ49RqtAVFTyq1OmkkaiKZmyaDg14k6L9G/ymBxCc2C2rc/cka9z5PHFFy1eepr2wvvVICw2WgzhKoWLlAtJzUE3zHzm1nfWhcMiTmgruyvP44djjAQtwKCuo6IkOw2AvHa2FaotSGi2vgmjaFa0By/SVB57gxt5HdZzPbhDLzI2pQEhy5mZTpUTS7TX7ka8kUYhrr9V3w4gs/VjgR4quvM+l12O5IdEAE1UOmRc+5UGzhNBhBbTYdbHe0Im3rVts8GD2cblN+cc2zCSkHkfQvi+XP3QK3dUUwL2fJvM7qq20nhibENKnuvo+xALbO/9i1q/KfvXUzuZgLXNLZ1mcb0ITDuurq/CwfsRKPWsBfsFK+weap8+ujsgeXgwg/tiemQTFVFn/Zf8h0cBunzgUaiOxD0gtEqIm/trArtZckEbtFCFSJ14xcqxI3+4STYh4LhsvwhbF3yepR9vJaLY8pq6+oDB1QtoJcsC/j6+H7hOpdpfrd9ejARh46b0SfdQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB2307.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(396003)(346002)(39850400004)(366004)(376002)(136003)(66476007)(64756008)(83380400001)(66446008)(66946007)(66556008)(5660300002)(71200400001)(76116006)(6506007)(508600001)(52536014)(55016003)(86362001)(26005)(8676002)(2906002)(186003)(8936002)(33656002)(122000001)(38100700002)(316002)(7696005)(9686003)(53546011)(38070700005)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eFo2cHlIUmJyY1VWekFYcmI4b0ZCajR5dFMzd0J0Ris3NEVnajFQQmpNOWFM?=
 =?utf-8?B?ak5YT0kvdHlsemx2d2ZOWTN5SVhxdzhQZHdUdXhlbGZPdjI4VXp5ZHBYMS91?=
 =?utf-8?B?RG0vK2dZU0kzUzdlajlueXFLZkVEdzhWeUQ3MDdEQktFVlJIcGpHN0k2NkxB?=
 =?utf-8?B?U04xNXZlQmtuSmZTMVprU1lPM0hxU255b0YydWpOaURSVE0wWTQvUlBZZkE3?=
 =?utf-8?B?VzlMSVE3U0ZET2t5ZW5jZE9kT3pDbnQ2dWU2RExFL0w0emx3bUZRMDlPSTJH?=
 =?utf-8?B?eTFCUUhtUlZWVjY2K2drUGZxOFRjWUo0RWMzeVVTS1VnK2FEU2RaK1VMNW9Z?=
 =?utf-8?B?TFJKelpSRnN1YjkyZXh0UjRNSk1DYWZ4TDBYQjQ2ZnFSVU0xelR0a0pRZ0dH?=
 =?utf-8?B?K2pnWWhLY0g1NHh1T2RlUTNFUnZBU0xWYjZjeGNrSWVBck41dkk4ek5yVExH?=
 =?utf-8?B?bld4N0NRdDRPeDFOcndnaDZOK1FwQ053T3pQVUVaQ1lXQU1ZMlo0VHUzRHR3?=
 =?utf-8?B?U08rRWNLYTRxbkdxd25ScVZudGNvY1F6TkQ1a0VRVzJON2hzOFBtWDl0bm14?=
 =?utf-8?B?dm5kbzQyVm1kYktUODM1cWFlVG4rbFFPQW1yUzVkdmRLY09ubGtDTm4rMXRk?=
 =?utf-8?B?Vm9XbE5FOGVXZUZrQzNENHBndVA5L1hHaHhTdkdqdHkzb2lRQXBNYVJaWGpq?=
 =?utf-8?B?dlRoam9zZ3hsazZqREE2S1FLenNKS3lXOFp2bStHYzBjcU1GMG9tVlNNTGkx?=
 =?utf-8?B?WXA5Rm12M2l3bXhVSUFwejZ1Q0RITFJ6OFJtNEhLQWpQN0JFRE9XMlhRbVlM?=
 =?utf-8?B?cytiNWFIcm1XSUdnTFdRZEpNVzNRY0p5VE9qOVVsWkEvK3ZXOHcyZHR1RjRI?=
 =?utf-8?B?c2lOVVJmNHFNdXY4ZmdndXlNWmRhV2tyWmUvV2U2U1VreW9MUWVxbXhPR1ZF?=
 =?utf-8?B?RUZ6c3FpTGJjeUcrUllFNHpNSThMM1lRSk9LWUlDOTlDNytyZ0dLS1N2Mjdv?=
 =?utf-8?B?N25OZVR6QjFQWVZpaUdiMnF4WnJBOFB2TG5PMVNuamlqbWVXZzBrMzRYazdJ?=
 =?utf-8?B?c0I0QThjTUt4alF5bDZ4M1dXSWlFZ0F1TTNFWWs0WnU5WWFFaXNMS0laRXB1?=
 =?utf-8?B?RDhYdkc0Wk43UFVtdTdrRWszTTVFK2hqeFBrWW5xcnNCT1d2NmVhSU9ZVUdC?=
 =?utf-8?B?dEI0TXBtOWt0ZzBxc2xpdHZoMk5PMm5JUy96R3o5djFqUXhnSk9MdVd3MGxp?=
 =?utf-8?B?NU5UT0YwamUxR0EwUXdwa3BDRjAvZzlaZEpmRmhScVZHZHdiQ2I5WjlFQ3Nr?=
 =?utf-8?B?cnd6eFR0ODg5RkEvMWk4RE85MUpYM2hzcXdKR0pNWGpkMEh1b2l1cUJUYWJ4?=
 =?utf-8?B?anowNXh2bStjYUdHdGdVRmNZVXQxd0Q3UWZBdFZuU2x4amRBZ0RXdkprSmVu?=
 =?utf-8?B?dE1Qd0NQQnlRNmxHZVZ4cjhTVlpVK0lydnp3OEZnQXUzV21MRmx4ZWxGUTA3?=
 =?utf-8?B?TkZUc21WdHV1cFVCY3N1cG5qaDlJeG4xVFd0VUpTY3V4Z25SVEgzaXNHYVFy?=
 =?utf-8?B?NjRoOGFBRXVwNisrZ1ZmeFZhVjdXbmRXR1Zqd0x1bVVJK0l0b0ZkdGpWK2dP?=
 =?utf-8?B?MUNhWWZmeVprNTFsU1NlemRMVjBrcTllNFlMckVWc3BDcC9QWHQ0VkwxS1o0?=
 =?utf-8?B?VzNHL0gyYnBuRUE2Y3hNSFNmaWlrTlNuZDZXejQ4alQyYVluaWkvVTNXb2NQ?=
 =?utf-8?B?Z1VkaTkvcDdSZ0JjUi9qWHN0T1dSRUxTWCtEZEZDS0J5MFc4cTJvNVp0M1F0?=
 =?utf-8?B?OS95UXV1bXBLUFZ1NnBzcTFUK3NYN2NiWDU0WE5ZVFJNV1N1TmlZSUFIV2o2?=
 =?utf-8?B?UGtDSzgzNlV3anRWZ3J6YmpUeUNnOU9LNU1YMnIvMXRjME02S09LMnRPc1JO?=
 =?utf-8?B?c2VLZml6em9oOTlLTW50bjBSVVowQ091UU55alFyN2Q1UFNVTWNrMkhOWmxB?=
 =?utf-8?B?YU9UdktFbG1nPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB2307.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 903bce68-6859-48c0-1943-08da0e02ce49
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2022 01:57:23.8560
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 67J05dKCkQiScObijyK4G/ocpqVAZCWU8mlqE/0BdqUW9SjeV1rC23BiUgwzdGJqSk+Le/L6OoQySjAcVMbwrWv4g3LWeaDADgsW/IMw8Ik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB3234
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSmFlDQoNCioqKioqKioqKioqKiogRW1haWwgQ29uZmlkZW50aWFsaXR5IE5vdGljZSAqKioq
KioqKioqKioqKioqKioqKg0KRElTQ0xBSU1FUjoNClRoaXMgbWVzc2FnZSAoYW5kIGFueSBhdHRh
Y2htZW50cykgbWF5IGNvbnRhaW4gbGVnYWxseSBwcml2aWxlZ2VkIGFuZC9vciBvdGhlciBjb25m
aWRlbnRpYWwgaW5mb3JtYXRpb24uIElmIHlvdSBoYXZlIHJlY2VpdmVkIGl0IGluIGVycm9yLCBw
bGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgYnkgcmVwbHkgZS1tYWlsIGFuZCBpbW1lZGlhdGVseSBk
ZWxldGUgdGhlIGUtbWFpbCBhbmQgYW55IGF0dGFjaG1lbnRzIHdpdGhvdXQgY29weWluZyBvciBk
aXNjbG9zaW5nIHRoZSBjb250ZW50cy4gVGhhbmsgeW91Lg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+IEZyb206IEphZSBIeXVuIFlvbyA8cXVpY19qYWVoeW9vQHF1aWNpbmMuY29t
Pg0KPiBTZW50OiBUaHVyc2RheSwgTWFyY2ggMjQsIDIwMjIgOTo1MSBQTQ0KPiBUbzogSG93YXJk
IENoaXUgPGhvd2FyZF9jaGl1QGFzcGVlZHRlY2guY29tPjsgcm9iaCtkdEBrZXJuZWwub3JnOyBK
b2VsDQo+IFN0YW5sZXkgPGpvZWxAam1zLmlkLmF1PjsgYW5kcmV3QGFqLmlkLmF1OyBkZXZpY2V0
cmVlQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnOyBsaW51eC1hc3BlZWRAbGlzdHMub3psYWJzLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDIvM10gZHQtYmluZGluZ3M6IGNs
b2NrOiBBZGQgQVNUMjYwMCB2aWRlbyBlbmdpbmUgcmVzZXQNCj4gZGVmaW5pdGlvbg0KPiANCj4g
DQo+IA0KPiBPbiAzLzI0LzIwMjIgMTI6MjcgQU0sIEhvd2FyZCBDaGl1IHdyb3RlOg0KPiA+IFJl
c2V0IGJpdCBmb3IgVkUgaXMgNg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSG93YXJkIENoaXUg
PGhvd2FyZF9jaGl1QGFzcGVlZHRlY2guY29tPg0KPiA+IC0tLQ0KPiA+ICAgaW5jbHVkZS9kdC1i
aW5kaW5ncy9jbG9jay9hc3QyNjAwLWNsb2NrLmggfCAxICsNCj4gPiAgIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvZHQtYmluZGlu
Z3MvY2xvY2svYXN0MjYwMC1jbG9jay5oDQo+ID4gYi9pbmNsdWRlL2R0LWJpbmRpbmdzL2Nsb2Nr
L2FzdDI2MDAtY2xvY2suaA0KPiA+IGluZGV4IDYyYjk1MjBhMDBmZC4uYTdkMGFkOTUzOWViIDEw
MDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUvZHQtYmluZGluZ3MvY2xvY2svYXN0MjYwMC1jbG9jay5o
DQo+ID4gKysrIGIvaW5jbHVkZS9kdC1iaW5kaW5ncy9jbG9jay9hc3QyNjAwLWNsb2NrLmgNCj4g
PiBAQCAtMTEwLDYgKzExMCw3IEBADQo+ID4gICAjZGVmaW5lIEFTUEVFRF9SRVNFVF9QQ0lFX0RF
Vl9PRU4JMjANCj4gPiAgICNkZWZpbmUgQVNQRUVEX1JFU0VUX1BDSUVfUkNfTwkJMTkNCj4gPiAg
ICNkZWZpbmUgQVNQRUVEX1JFU0VUX1BDSUVfUkNfT0VOCTE4DQo+ID4gKyNkZWZpbmUgQVNQRUVE
X1JFU0VUX1ZJREVPCQk2DQo+IA0KPiBZb3UgZG9uJ3QgbmVlZCB0byBhZGQgJ3Jlc2V0cycgZm9y
IHZpZGVvIG5vZGUgaW4gRFQgc28gaXQgd291bGRuJ3QgYmUgbmVlZGVkLg0KPiANCkdvdCBpdC4N
Cj4gLUphZQ0KPiANCj4gPiAgICNkZWZpbmUgQVNQRUVEX1JFU0VUX1BDSV9EUAkJNQ0KPiA+ICAg
I2RlZmluZSBBU1BFRURfUkVTRVRfQUhCCQkxDQo+ID4gICAjZGVmaW5lIEFTUEVFRF9SRVNFVF9T
RFJBTQkJMA0K
