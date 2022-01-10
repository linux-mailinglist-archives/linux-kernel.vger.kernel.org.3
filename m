Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECAEB48966B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 11:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244012AbiAJKdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 05:33:50 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:29309 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243967AbiAJKc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 05:32:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1641810778; x=1673346778;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=q/NsG5xjGofsvPGuUtnr/BxlHq/9+6EEkra6kjfR4F4=;
  b=FQfxchG6z/dpNKEh1f2//s0Fu4HzYWOgWNF5M8psdh1txY0nGuVA0x5a
   zlwyyLzi9Fe3FltcS4FJj/WWkfAlzGVSiF4pHkejOBndikSP9vI4eCJwm
   sHlQXo+FJqevrjYfixb/nQjvo+p6Yk2EqN1JYBXXDr+Eabl95BazxoRvA
   hKVW9MOqnAAKz584f37WS9ZOU0MUGOQkuqrjfojDeOqrrjc5gsYdxKbad
   zu/26HwW6q5RB80XG1C6Wkh3l9Vxx5+/5qWJkDzkdy/36wInBii6cry4O
   gPIHV8vRAZPJfC+lY6dypreFXkQGLe6qBwt9OEw29HsjHdT74AcIaSTaW
   A==;
IronPort-SDR: FCx85KwoT6l9P+wtKX4Q0HOqa03D3tVYs5AN5F342RL4AFZo3oMpwyYgjOVPk29a9pW5MwoMQr
 h52xxaVCcfFKpPuE+ZP+J5Etj0vpesPbbBQx9OZx/NhyuJ/hz3Td6aOMfisVSyyorNkP5gxItf
 e8NsCxvjiv0abgpCLqawW//j7zNdvguzX3WI4ocTK4jrkmS1uoiYu/t+8c1GFbjSENC3HpTWN1
 x9rsO0S93aGJffOayQTaKmFk4VjIAICzhbm4+rkhRoDCyzEEW6Cta6tUWQCzcz0bStUASWPiPi
 aoDO4Nde3HIhd7QjfF0diLxg
X-IronPort-AV: E=Sophos;i="5.88,276,1635231600"; 
   d="scan'208";a="158067907"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Jan 2022 03:32:58 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 10 Jan 2022 03:32:57 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Mon, 10 Jan 2022 03:32:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GpipQt6FzPzChDEsb1fWQ424txsdZiHEO0kezzhgp0PlkVMWShP5nIumHO8H9y0P2lW6t0tXjY3ryO7FlVD22WZkw7P4GFx8fm9TJbiT7LH1ohSSWcx+/X81Fxm74a+JAQr/KD9yy60V1JYnmvGKwqCqe1+CNYH5AKrySIc6pKw7U5pkbFdWHZ7wCioniiJByqm9jZP181OLehNsbw3ro4p2wC600OD8cY6f4sXjtjFTJW9aVFovEDbfOZnX+Z+rxl5gnq8DGUxJVPm9+i3VL0/D2voW1Du3/G2ICpTa+mmYDYRuTa1k+tGzimjD/A9JN1wQgVjX1Kr17zwSxYsN5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q/NsG5xjGofsvPGuUtnr/BxlHq/9+6EEkra6kjfR4F4=;
 b=hQG55DYeesvSpiITUYTyf0Mr0cmYn4icwXnQJGB248A5xbPdq7PGGotM1ThIup56p+PbvMka8FL6LwuUlt+ampPdoNlsxc/qXD0ym53+CaKjjfimqSeuhF1YJgocjeswqo7NLObQ4plh57DNlgbn0yCeTn35xOLMRMbtZhpzb/dwrO9nYFyNWN9H3XhlUtqT5sr9c6pMGFX6UU+tGocvbpyiXlRnIOvPoIUCaU2M++5+cLUBOI0Vs2DuFGkWjHxatcTNmdbfdVK2XAEr+4k+PfMw+KkTLILsQROAihgOXfukaxf+CwBB8gZ9OMLr3mMX88F3wXhfMF4R+5rJ7T46RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/NsG5xjGofsvPGuUtnr/BxlHq/9+6EEkra6kjfR4F4=;
 b=iWDaDHM0oPFO4sNOyR3oqqKftz4q5l9eYIldSPy+EzWazASxB+2ZOxO9BAkRK1MsFPKG4gViuYimyuFpSoTuPs7S4JFhMYft0R7eJRmWor4oWpZ7zlqpmNOvSAUZUDNzdlHvy12c/R0vm2y+gYCFe464cDY8o4dxjLb8WEO9idg=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:95::7)
 by MWHPR1101MB2367.namprd11.prod.outlook.com (2603:10b6:300:79::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Mon, 10 Jan
 2022 10:32:45 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::6032:bbb2:b522:2ac3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::6032:bbb2:b522:2ac3%6]) with mapi id 15.20.4867.011; Mon, 10 Jan 2022
 10:32:45 +0000
From:   <Conor.Dooley@microchip.com>
To:     <arnd@arndb.de>
CC:     <aou@eecs.berkeley.edu>, <olof@lixom.net>,
        <Cyril.Jean@microchip.com>, <Daire.McNamara@microchip.com>,
        <Lewis.Hanly@microchip.com>, <jassisinghbrar@gmail.com>,
        <j.neuschaefer@gmx.net>, <sfr@canb.auug.org.au>,
        <damien.lemoal@wdc.com>, <atishp@atishpatra.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <Claudiu.Beznea@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>
Subject: Re: [PATCH v2 0/1] soc: add polarfire soc system controller
Thread-Topic: [PATCH v2 0/1] soc: add polarfire soc system controller
Thread-Index: AQHX9a/UoiOGRKIfI0yoKROyro43JqxcMCKA
Date:   Mon, 10 Jan 2022 10:32:45 +0000
Message-ID: <6924ec40-d253-0370-9e51-49552855f56d@microchip.com>
References: <20211220144413.6798-1-conor.dooley@microchip.com>
In-Reply-To: <20211220144413.6798-1-conor.dooley@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: be51c3f6-46ad-4807-c508-08d9d4248a9a
x-ms-traffictypediagnostic: MWHPR1101MB2367:EE_
x-microsoft-antispam-prvs: <MWHPR1101MB23671834D9F205151FC95F1A98509@MWHPR1101MB2367.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kNynOM8RAzCeSKa4c7G0ZkZF9yDdO1gsmwte/gf7CJoVQFUMN3ed0nJQd0WBRupwtQsxxtEhekGQ93KON1SWXHP3FqEbi9WyF/pT9zezJTf2UJwlBR2TOSPZuZVxFKaEgnsu1S7SPW2a3iGLxq5XR7y8bH0YNsP6Fcc8TaF3MPVV2l9MI9b4UemvilOwbRJ77mPC5H32g+Nsm4X/jg4QRrcjWGoPN7HF4W3GbyvZp54AKkEeYaTrKaSP48dRIpQ/6w+XZwRmsI1IoAZ1yPYfungAj+s7yYqExYXkkU9o/KUf4qSc7Q+4ljz+cF7bZek7/OhlI7Uqp5XrGpqTzScXJNrVTKZQnJOn4RDJ4PUi/4OlGAA3PjHCwJIu4H1wo9EbnZ9AZaqOm71TDLD4+iTZE6T/p8vDiFYDvKZ1aFkMhiCStVOpfj7+Zt6a78MuFhAmbZRrh5WHylkV1AD6Wa2lul0unAGQrcSSEILB08eypDu7ihMLPI0jY9N9tZVZXk4nfPnZi1daQsKqMZk9AvBmVHusDByriZp8VHcGIEkv1TehSrLhPBPPPahlg649j1ZV1oc9l8j8yVn8yLMZziNHLQPjmuNhwx8WzsWxCb308oXo87QXxKJP1/pMiWZ4OkRUFWZMtGI+FEDiBA/ZbViiTWFgqJeJskOjQ+y2A1DpfeTYPRUK0XBsL+NedJEnzJHetvkq3Uw4fs/rwDLrJRuEDeI7QbWbTfjj3DsDHi6OvRUpp4B22zUarX3/Syu/UtCib21+CSVDL1XUD0M7pXAXOXAHUVB33DqivEuHqEzkpQsWijX+pGAMgPxhW+41mQwRBMvudoIlzTba2Z4EO5m1ncFzTS2T5Q+inGkD8X3M6OAVGywDS+zfmO7ZRjoP4dAfBRY21zNLriCaF5AgTKKZzw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(8936002)(7416002)(26005)(2616005)(5660300002)(316002)(38070700005)(54906003)(86362001)(4326008)(36756003)(83380400001)(91956017)(66946007)(186003)(64756008)(66556008)(6486002)(76116006)(508600001)(966005)(6512007)(6506007)(122000001)(53546011)(8676002)(6916009)(31686004)(66476007)(31696002)(38100700002)(66446008)(71200400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aG1nUkhHQzlWYko1b0VTVTlab3prMS81WG1EajM4OGg4VUlLamtQTGJKeXdW?=
 =?utf-8?B?OTV1alk4L2ljZlZFb0s1YVV0TUt0S0ZHL1lUN20vUFVXR0dyMlF6SFAvU3pC?=
 =?utf-8?B?SUhYVCtXSy9xZGdQVGEwRnQyZC9ZOExzbDd2OGRXU0xPUUd2cWtsTE1EYkVQ?=
 =?utf-8?B?dnEwTWNLbjV5WkExWnhsQ2VTZlRtSzgvTzJST0U0WkJCRW1jWUdHNjYrRDNY?=
 =?utf-8?B?V2x3Nks3dVBHTWdsNmNYK3NPMmRUaHM1S2VCOGdiWXRib01JeVVvdTJqQ3Z5?=
 =?utf-8?B?UzdOcXZNR1NWcUlVTnZLUHhYd0ZBMWN0NUtrcW1PWmJrbEdoVEpYcWdYVk4x?=
 =?utf-8?B?RVE1VURsQTFya3ZGWHlmTkRjeHcyODh5WW5OTE04U0E2d2h2NUdaUWtXSHVa?=
 =?utf-8?B?bHJKQ0kydFFGVTRKeFdpaXVHelI5d2ErNlVYNGp2L3d3RDFxYWtMb1d1QUox?=
 =?utf-8?B?cjE5UW1ia2JXRFV6VE5YMlppVXJzZFdLSHlDL3VYUm9salFLM016c3ZYQVR4?=
 =?utf-8?B?Q2Q1Tk1CM2JIWG83a2s5azA3MUxFOXZFWHRBbXpXRTFkdzBqVUVxUVd5eklQ?=
 =?utf-8?B?MkV0TlUyRmpEV1RNZnFNVUlPVlZ2TVRtRjRQVTJSUU8wUHIxNFRBZ09wbEJS?=
 =?utf-8?B?UlhjZ0pDbGQzeEJaY2o1M3RDdkN4VDZ6MEZWZ3d3Y0hoQkNrZXBkL3F4Ny85?=
 =?utf-8?B?K2YzeWZHUjJsS2JXYTI5RjBOWFBSbXF0cE1nZEQvS0UwUlNZemNMREh5L2tB?=
 =?utf-8?B?N2N3QzRTRzVOeHF4dE5Jc0I0dzFsTDJWK1B6ckhrZGppdjZEYmFocWxsOEJS?=
 =?utf-8?B?UDd0d2hxbXY1dE1IR2pqSDEzYmQ2blpiMWY3T2pLZFNFV2xqaTZjRzhwZ0E0?=
 =?utf-8?B?Z0FjY0w5VEc2SzNYeUlxZGppUzR3QjhlV0UyYkxWZDRwb3VRNlFqN3grSkhn?=
 =?utf-8?B?RTZscThFZE1zdnlNZjRCaUpFU2Rsc0NPRUlHUnZDV1R5aHp3YTQ1VXkvR0tm?=
 =?utf-8?B?RUFQMjJsVElPc0xPZ0VGc2VPc1FEYjJKMnlsNTN6bU1SRDBmRU5tcnhtZjRM?=
 =?utf-8?B?cy9WY2xKUUx2R3M2eC84KzUvbXBJZEk5RGh3VC9qRnMwVWNWOHJHbW55ZUoy?=
 =?utf-8?B?WnRBcjRJN2dXaEVEekJzZ1RMZ0haOXpJdXp0bHN3MUZmcnhkV1RKdU90NXVt?=
 =?utf-8?B?Sys1U25QQkF2M3lGYTBqaFcwV3djV2JKR082UzFIY2J0dXBjNGNJOWYySkQ1?=
 =?utf-8?B?cGdNVVZ5aTN1cEtPMWtMUlUvMWNDN09ETWd6bW5EbVZucmpWR0hJUnJGV0Fn?=
 =?utf-8?B?Ry9tU3MxUUpFT2dPcUFTSm9lYmFCeDlibkZZVjlid1dId0xzSFB1ZDZpMXRt?=
 =?utf-8?B?eVJHZFNkVDdBYitTWkxNQVJQYXNMdWdkejBOVERnQTBlQzZSdDc1Z01Md3hD?=
 =?utf-8?B?eWkzRFpQU0tZUkN2Mng5SGxkVDVobkxWbllBMzA4cFZHemE0QzQ1QWVlVWtH?=
 =?utf-8?B?SEU2Y2V2VUNIbFFvaitCaFUrUDBBaGtSc3BQK0JlSGdlZmxnNGd3ekxDUk1o?=
 =?utf-8?B?NFdxdXlDcEIrQ3JQL3JVNm11YmZGdDF2bG1qR2RDc3RWMXBiaFkxQmRvLzlX?=
 =?utf-8?B?ZnF3U1pVK2xwcEVLUjZNOFdCSzV1VkFYUTQ5dGtFYkpEb2pMYU5VNlNmZmJx?=
 =?utf-8?B?WGJnd2R6elBrZUJRV210dG43TkNsNVBrYnB0RG9ZWmVUZi9lSlNyTFJ6aTBq?=
 =?utf-8?B?R3hFOEU2UmVJbzVtbzUweG43Yi9Ma1E2NzZMWHNrajcvYlVjWWduenNMb2Qr?=
 =?utf-8?B?TzNsN01XTkxzYWt2ZjZLTE5KR2NkWlhsRGhaSDhTelY0a0hXTFYwaTZrMys1?=
 =?utf-8?B?NUtuVVZNQTNGUWl1dUkwQmdmaGEvbjhEL3dRV1dXdlFNaUFac2dtTHN6UFds?=
 =?utf-8?B?aHNaT1lvRllZTSs4RFdBNEpBdHErSWdTMW5LSnR3M3BBNXVPOXRuV0dsS0w5?=
 =?utf-8?B?MHdQamV2Yk5XV3VwaVpKT2R4QmgwRlBQSnF1Ykp0T3YycTkyTlJwS3c3Uk5s?=
 =?utf-8?B?ME41NUV0SkdNamxGZkJWYk1WZnFPNHNwRGMxKzk1NHV0NXlka21BN09jQmhI?=
 =?utf-8?B?Mi8zZ3c1YVdYK0RnT2ZzckxSVk1LM09yU0FZYnArc3QvRDQ1L2p5NThpRmta?=
 =?utf-8?B?RUVONmEyUmN6b2VWQ0pxeXdLc1BUaXpreUN6NThDTS92U2dTZzFvMzk4ZXVY?=
 =?utf-8?B?Yy82bnVDZEcxZUNrMHVrRFJpQ3RBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E3AE3AEB61162746AC326186A3506C2F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be51c3f6-46ad-4807-c508-08d9d4248a9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2022 10:32:45.7227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xW4cCWfcXWq9rlZkFVbV2EdYp7IRqNfaNelFh6Y/rph0xeMOEDsh4sve9QeLIHArCvNEp+F6ZHwU1f/Ecwb5HX4F3iJy7W43k3vhTHMAp3A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2367
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAvMTIvMjAyMSAxNDo0NCwgY29ub3IuZG9vbGV5QG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+
IEZyb206IENvbm9yIERvb2xleSA8Y29ub3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+DQo+IA0KPiBD
aGFuZ2VzIHNpbmNlIHYxOg0KPiAtIHN5c3RlbSBjb250cm9sbGVyIGlzIG5vdyBhbiBtZmQNCj4g
LSBwYXJlbnRhZ2UgaXMgbm93IHVzZWQgdG8gZ2V0IHRoZSBkZXZpY2Ugbm9kZSBvbiB0aGUgc3lz
dGVtIGNvbnRyb2xsZXINCj4gLSBtcGZzX3N5c19jb250cm9sbGVyX2dldCgpIG5vdyB1cGRhdGVz
IHRoZSByZWZlcmVuY2UgY291bnQNCj4gLSAicG9sYXJmaXJlLXNvYyIgaW4gY29tcGF0IHN0cmlu
ZyBjaGFuZ2VkIHRvICJtcGZzIg0KPiANCj4gRGVwZW5kcyBvbiBbMF0gdG8gY2hhbmdlIHRoZSBj
b21wYXQgc3RyaW5nIGluIHRoZSBkdC1iaW5kaW5nLg0KPiANCkhleSBBcm5kLCBpZiB5b3UgY291
bGQgdGFrZSBhIGxvb2sgYXQgdGhpcyBpdCdkIGJlIGdyZWF0DQo+IEBBcm5kIEJlcmdtYW5uOg0K
PiBJIHNlbnQgdGhlIGZpcnN0IHZlcnNpb24gb2YgdGhpcyBwYXRjaCBpbiBOb3ZlbWJlciAmIHlv
dSAoYWxvbmcgd2l0aA0KPiByZXF1ZXN0aW5nIHJlZmVyZW5jaW5nIGNvdW50aW5nKSB3YW50ZWQg
bWUgdG8gY2hlY2sgaWYgdGhlIGRyaXZlciB3YXMNCj4gYm91bmQgdG8gdGhlIHNwZWNpZmljIGRl
dmljZSBbMV0uIEkgaGF2ZSB0YWtlbiBhbm90aGVyIGxvb2sgYXQgdGhpcw0KPiBkcml2ZXIgbm93
IGFuZCBJIGFtIHN0aWxsIG5vbmUgdGhlIHdpc2VyIGFzIHRvIGhvdyBJIHNob3VsZCBkbyB0aGlz
Lg0KPiANCj4gQXMgSSBzYWlkIGluIHRoZSBwcmV2aW91cyB0aHJlYWQsIEkgY2hlY2tlZCBvdGhl
ciBkcml2ZXJzIGJ1dCB3YXMgbm90DQo+IGFibGUgdG8gZmluZCBhbnkgZXhhbXBsZXMgb2Ygb2Zf
ZmluZF9kZXZpY2VfYnlfbm9kZSgpIHdoZXJlIHRoZSBiaW5kaW5nDQo+IG9mIHRoZSBkcml2ZXIg
d2FzIGNoZWNrZWQuIElmIHlvdSBjb3VsZCBwb2ludCBtZSB0b3dhcmRzIGFuIGV4YW1wbGUNCj4g
dGhhdCB3b3VsZCBiZSBncmVhdC4NCj4gDQo+IFRoYW5rcywNCj4gQ29ub3IuDQo+IA0KPiBGb3Ig
c29tZSBleHRyYSBjb250ZXh0LCB0aGUgZGV2aWNlIHRyZWUgZW50cnkgZm9yIHRoaXMgZHJpdmVy
IHdpbGwgbG9vaw0KPiBsaWtlOg0KPiANCj4gc3lzY29udHJvbGxlcjogc3lzY29udHJvbGxlciB7
DQo+IAljb21wYXRpYmxlID0gIm1pY3JvY2hpcCxtcGZzLXN5cy1jb250cm9sbGVyIiwgInNpbXBs
ZS1tZmQiOw0KPiAJbWJveGVzID0gPCZtYm94IDA+Ow0KPiANCj4gCWh3cmFuZG9tOiBod3JhbmRv
bSB7DQo+IAkJY29tcGF0aWJsZSA9ICJtaWNyb2NoaXAsbXBmcy1ybmciOw0KPiAJfTsNCj4gDQo+
IAlzeXNzZXJ2OiBzeXNzZXJ2IHsNCj4gCQljb21wYXRpYmxlID0gIm1pY3JvY2hpcCxtcGZzLWdl
bmVyaWMtc2VydmljZSI7DQo+IAl9Ow0KPiB9Ow0KPiANCj4gYW5kIHRoZSBtcGZzX3N5c19jb250
cm9sbGVyX2dldCgpIGZ1bmN0aW9uIGlzIGNhbGxlZCBpbiwgZm9yIGV4YW1wbGUsDQo+IHRoZSBt
cGZzLXJuZyBkcml2ZXI6DQo+IA0KPiBub2RlX3BvaW50ZXIgPSBvZl9nZXRfcGFyZW50KGRldi0+
b2Zfbm9kZSk7DQo+IGlmICghbm9kZV9wb2ludGVyKSB7DQo+IAlkZXZfZXJyKCZwZGV2LT5kZXYs
DQo+IAkJIkZhaWxlZCB0byBmaW5kIG1wZnMgc3lzdGVtIGNvbnRyb2xsZXIgbm9kZVxuIik7DQo+
IAlyZXR1cm4gLUVOT0RFVjsNCj4gfQ0KPiANCj4gcm5nX3ByaXYtPnN5c19jb250cm9sbGVyID0g
IG1wZnNfc3lzX2NvbnRyb2xsZXJfZ2V0KCZwZGV2LT5kZXYsIG5vZGVfcG9pbnRlcik7DQo+IA0K
PiBbMF0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtcmlzY3YvQ0FNdUhNZFdUanJBaUhv
c1UwY0d5SllrSz05SnpOZ0hiPXRqSFhQZFl4VFdta1Z6ZVlRQG1haWwuZ21haWwuY29tL1QvDQo+
IFsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1yaXNjdi9DQUs4UDNhMW1fTGhPZzVK
R01xUHo2c29oSmEyaFBaM0dOLWpRRFB4aWdaNURhcUFHeFFAbWFpbC5nbWFpbC5jb20vDQo+IA0K
PiBDb25vciBEb29sZXkgKDEpOg0KPiAgICBzb2M6IGFkZCBwb2xhcmZpcmUgc29jIHN5c3RlbSBj
b250cm9sbGVyDQo+IA0KPiAgIGRyaXZlcnMvc29jL0tjb25maWcgICAgICAgICAgICAgICAgICAg
ICAgICAgfCAgIDEgKw0KPiAgIGRyaXZlcnMvc29jL01ha2VmaWxlICAgICAgICAgICAgICAgICAg
ICAgICAgfCAgIDEgKw0KPiAgIGRyaXZlcnMvc29jL21pY3JvY2hpcC9LY29uZmlnICAgICAgICAg
ICAgICAgfCAgMTAgKysNCj4gICBkcml2ZXJzL3NvYy9taWNyb2NoaXAvTWFrZWZpbGUgICAgICAg
ICAgICAgIHwgICAxICsNCj4gICBkcml2ZXJzL3NvYy9taWNyb2NoaXAvbXBmcy1zeXMtY29udHJv
bGxlci5jIHwgMTY5ICsrKysrKysrKysrKysrKysrKysrDQo+ICAgaW5jbHVkZS9zb2MvbWljcm9j
aGlwL21wZnMuaCAgICAgICAgICAgICAgICB8ICAgMyArLQ0KPiAgIDYgZmlsZXMgY2hhbmdlZCwg
MTg0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gICBjcmVhdGUgbW9kZSAxMDA2NDQg
ZHJpdmVycy9zb2MvbWljcm9jaGlwL0tjb25maWcNCj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJp
dmVycy9zb2MvbWljcm9jaGlwL01ha2VmaWxlDQo+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZl
cnMvc29jL21pY3JvY2hpcC9tcGZzLXN5cy1jb250cm9sbGVyLmMNCj4gDQoNCg==
