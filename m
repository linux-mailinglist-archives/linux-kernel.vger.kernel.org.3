Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE9714DD4B7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 07:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbiCRGg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 02:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbiCRGgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 02:36:54 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Mar 2022 23:35:35 PDT
Received: from esa7.fujitsucc.c3s2.iphmx.com (esa7.fujitsucc.c3s2.iphmx.com [68.232.159.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4102B3D7D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 23:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1647585336; x=1679121336;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=dFQ+s2q0P1go5ywvrobfIONEUHdgQiyO2PXZ/1s3Imo=;
  b=lhgQjATNCxAiWpMDxEZ2eIdr94Us+C/KEyP72pA7YHloTKBCMtGMCCAH
   ix7argGysdnTo3g9vJ90ZSoFnLvUIKqL+7+zbkIp/hoVtJZp0b//sLsz4
   FQOLjqqa8+Tm/4yRzuv+XB3RprGsJXbIeKG0H/VQDg2AJifiwHVFts6ab
   m3eraozooqMBgj8L3Gapmuu9Ls7hMNzHOX6gKaNfFEInA+Rmy5cqvUVCg
   af5t3lSqpGvm+wD+bjbJg/uSLe9UF27wXwKVStDgk+m6CsntQn/m77rMz
   BLtFgTOtAaFWt2tzW1Idesj7wvxtfMjhExlSW/SPSnvANJG8PSBroc31k
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="52052854"
X-IronPort-AV: E=Sophos;i="5.90,191,1643641200"; 
   d="scan'208";a="52052854"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 15:34:28 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lCT4wuNaMLzypw/pK+EhvUHcp2vcZxFV5Txzh9J1rfuJe7IcyjInmVSGjzTOyD+8lREoUpOuE/Kkezb13q4thylnWrQLouDJfQvRr1gO/2GJQzNKDNsPzPekMEA21nvqZpLkPf+3Sje1O65j0w7SoOFy+6p3Z9zyo1Y3gIq/Zsft/O7YWzIIU5YNnbt0lJShLxzrtIAeKekyD0eS+fDSKynCNdwRfG1Ttc5RJMnq8YY48Rp3lHVRyTBk0pZvWF60nqrWTlHe+oEbIkn9ejyAndxRowmmbe01M9tYVeQpoJOZTmVMolpPL6EwLA13bJY21YGT5Qk7H7uTH0mgP/KbOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dFQ+s2q0P1go5ywvrobfIONEUHdgQiyO2PXZ/1s3Imo=;
 b=PB23+L1m/V+LtlLMMpdeNZd5RKbr/XRvYyk7cZ2gqF6uR5A/P434GTRTy05eFB14VoCzzvnTCJ5a4EysoGpBf/7eppt2gDxE+y1an9TUX1XJAuO+pJAvk9jiBATtPLBnZ/w+YFu0vBBzGc1ie/30AzFtWd4EI84h8+Wvzvg+D6N7A9bfqn52CaCSGpM/XUUGvtyenTuP+8LwS1PIttp08w4qud8MOa6yyhmjfbHGzUo+pmqdOZ0bIXH63CpVBHfHyRBBXKhaUgI0D+n4C7qcOa2Wgx+dlnQf6ldgo6I5AD6Mu1k4Z6dxs1z+wICe1Eb2IqZiCuai/hzfl9JNSPffRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dFQ+s2q0P1go5ywvrobfIONEUHdgQiyO2PXZ/1s3Imo=;
 b=XznlHbqY3zhbjIPO2XErHAMDQQZg+aRzijSjrg48ErN8P7Xkqy/iSJIN6VVP4qi7ZrzIY5rpFMOu92+BSbtkedlok6cKuWS2MyUfU7vc2aUrugl+h2AxvyPsbqa8P8qiwQ26tR+N1FLDc64Q6XcBxTWhkO9rsTTO2SdUfFIyqZU=
Received: from OSBPR01MB2037.jpnprd01.prod.outlook.com (2603:1096:603:25::17)
 by OSAPR01MB3444.jpnprd01.prod.outlook.com (2603:1096:604:53::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Fri, 18 Mar
 2022 06:34:24 +0000
Received: from OSBPR01MB2037.jpnprd01.prod.outlook.com
 ([fe80::885a:78d2:af39:629f]) by OSBPR01MB2037.jpnprd01.prod.outlook.com
 ([fe80::885a:78d2:af39:629f%4]) with mapi id 15.20.5081.014; Fri, 18 Mar 2022
 06:34:24 +0000
From:   "tarumizu.kohei@fujitsu.com" <tarumizu.kohei@fujitsu.com>
To:     'Dave Hansen' <dave.hansen@intel.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 0/8] Add hardware prefetch control driver for arm64 and
 x86
Thread-Topic: [PATCH v2 0/8] Add hardware prefetch control driver for arm64
 and x86
Thread-Index: AQHYNTHCaAMJnEu3606TXBPJHqyKHay/Rm2AgAVwI8A=
Date:   Fri, 18 Mar 2022 06:34:24 +0000
Message-ID: <OSBPR01MB2037A987CEFA28B326F063AB80139@OSBPR01MB2037.jpnprd01.prod.outlook.com>
References: <20220311101940.3403607-1-tarumizu.kohei@fujitsu.com>
 <40b468cb-5144-77f0-963a-67e81d2e3aa4@intel.com>
In-Reply-To: <40b468cb-5144-77f0-963a-67e81d2e3aa4@intel.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 73c706cc-97cc-4014-8a6e-08da08a957d2
x-ms-traffictypediagnostic: OSAPR01MB3444:EE_
x-microsoft-antispam-prvs: <OSAPR01MB3444789DAAF2E53BC2C5BB4480139@OSAPR01MB3444.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xuGEU8p6xX3PT3NCskfzAEOaxWAwDM/jjgHGqHcaK6tFzw/Jhy603XQoR7cryF74VTVmVEwrzRpVdqOT0E0Db9Rna7FV5oNgbUS8fLL9WijIa6dYc9oxDcMvNBgkD9Baub8EIU1BOfORm/5hnTRiSZZd9qF1m6YPbgIt1eQo6Ve4PeO6yyKMV5UKOqXbPFRXWsXmnvPwHe53kPjmpw3pOmFSOr8oSejbAM+ZGUQM15J4rqL9DAPAETRpo+L3hafYiJ/fk6i9JqRH4t1zxEPiCfDkCIDheIXxAfkfuS7pruPxkw6gbMZBNEbvmA2mplyXK1rveUjE40N7oK56rBlXVTRWupEHLB8DlnSgGYmQ2bZ+DdRwtkYeUFtgFSkbXiuFnTCOc9An2h4UAEoQKvxeQF6Rt1DVMefB2KcqRtZVshCmtuz+aHQWs4P8exXI2bwBONd8Aos5dY7rHH63Wq2at56HBhRZ9WdXj3u4kCz0uYVFGGo7mqoctRVHQo1EgMW9YFwg0+HcaLN/JJpy99Papow6W4z87frOeDKBPJMOOn4sO1wT7erQqF1PRoi3Ez5BqYr6b6DHN918Zh33BMpUS7NDom973b4GPnxnvdu/tpMNXUWmFch36cHmblOkJhqqgzoXDSb4Whh+tjLTZIEnk5vh3bTDt9I9xGQHYbJeARYISu6hWcT07s0JplaTNmdeF5Y9yZn9EKtof6iDzomphONS2dtvp558LUDn1jzr9CQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2037.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(52536014)(7416002)(66446008)(66476007)(66556008)(66946007)(76116006)(38100700002)(8676002)(64756008)(508600001)(86362001)(9686003)(7696005)(2906002)(6506007)(85182001)(5660300002)(71200400001)(82960400001)(122000001)(33656002)(26005)(110136005)(921005)(4744005)(316002)(55016003)(38070700005)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MC9qcEZzNjREZzNzZDZvelU1UHJDeTlBMlp5cUNDYjFraVB2aE5HNHp4OUtv?=
 =?utf-8?B?RzZjR3lVd2UwR3B3dEUvNWdLb2V5S1VkUVh0TjFjcVVBUWNzSUNicWM5TG9R?=
 =?utf-8?B?NTNQZTFSbEJ1Q3ZVM0xEQkZ0VGdlZ2kyT1N1aGFqWXZQN01BMVlxc0dnWTg3?=
 =?utf-8?B?VHM0SVZac1hCRzZHRDd1MDJxVHAyZnN2MmtNS2FjWXZLK2tVbGpLVlhQN2pJ?=
 =?utf-8?B?QXZjUHRWeGphZWIwbTRTRGxZa0tMb1NOVG9ZVjl6ZWJwdWYycVBuM0pNYWZS?=
 =?utf-8?B?SG1OYm5hNTRrcThZZlVuK0pITmVVWURJQ2hsYXlkN0hiUDVubDBQUDl5YXh1?=
 =?utf-8?B?NmJuQkFkUkE5cmNwRkVyV0VPTXVISWlaY1hXQWsrZGVJb2VIdmgyMEZ3UmU1?=
 =?utf-8?B?cTVoZDVNSncyc3VadEtrcHduSHI2Z08xWG9jZlc0a1J1U2d0V0RKcDVlbkxq?=
 =?utf-8?B?aXVyL1QybGY2SFRFc3NCSXNBSFFwUzNZbldWN3dGV2xCWERYVEdVcjFiNFlx?=
 =?utf-8?B?YlhQTTBYQnd3NG5wdENNcUVHdFA5M1Z3bWU1RTlXUnJXQWNDTVdYVzlKSjJ1?=
 =?utf-8?B?V0lsenBCTldkMkNPcUZGNU5keWFVTHV3TWJyUjFsbXpGd3F5Q2Z5SUdUc1U2?=
 =?utf-8?B?NDN5bVVQUjdvRGQzVDVtUVpDaVFMc3JrRmF5TW9jWFY3MlRTWXNNOXUreGxH?=
 =?utf-8?B?OFQxQU9LVkJxMzBBenRZdTkvSUNRTDI5bEVhaU5QQU9mTWxidC8yS3RhZFEr?=
 =?utf-8?B?S1V6OGFodEpWUjZlMlN2NUlWRWY4UndRdEZ5WXVSb25vZzQ0RE5YTjkwQk5L?=
 =?utf-8?B?YXBmMkVHbE9IcEtSSzMyV29KM3BaSkgxa2pBVFI4ck1QVi91dHpiazR3N09S?=
 =?utf-8?B?YXJXRllpVFE4eS9LK3lxWDdqNnRXUmpwQVJ1ZkFXNEU4V0o1WGpDMVVlaHlD?=
 =?utf-8?B?QlVjWUE3N09aTnRub3gvcHFyZ3kwVURSOFVqSFdITlMrc2kvcThFYVZQNTN5?=
 =?utf-8?B?RkR4dFhTUmJiVlkwa0V2ZWZKYmMwRTJHbDNYdmhtWVAzanltMWw1cExWUXlh?=
 =?utf-8?B?UGt2K1BBaGxDeENTQ1lLQ255NWd6OTRIcXVPTVJuSytmTi9MRy8vV1dYY2hU?=
 =?utf-8?B?N25GSysrNEplMjQ1OE1NRFBqTXBQZlEwRFJrSHUxSUVUOTdSY0tCWDJ4aEI3?=
 =?utf-8?B?WG9MY0pZczFmdFpBVzVYN2hYS3dFR1hVTjhSblpteE9rd2h3c2pGMFFUZk9Y?=
 =?utf-8?B?T05jOHIxQWhOUll3SW5WSTNiS2pjK0lxRkpFVlQxcExZRDYwLzcrK2dKZUFM?=
 =?utf-8?B?aDhwc1FvcDRvNVc5bzdqSlBpNHV1VlZUUnRINkN4NmFBOUxIdVN2WG0zWlBm?=
 =?utf-8?B?UnlwUVZKNkpNZ0tpSTdyV2w2eGZnR2xGdnM5UzFYbFJvY1p0b1liTkJObXFK?=
 =?utf-8?B?NFhXcndQS1h6LzFobHIzRWUyMVI2d1ZiOTVMT2NFd2lFa3NqUzJVYnppbG5X?=
 =?utf-8?B?WWlUSUFkWDVadVJnYVRTbyt3aVcrb3ZHa2dYRThnQWtOLzQrMHhEdklKV0ZS?=
 =?utf-8?B?QlBUVGViR3ovUFBzYnJvSjVRRHBaTXhXVEx1a2NTYlZZbTlOYUk5MklQRCt2?=
 =?utf-8?B?SklndU8zWktOZEx5UnBoSlluUVcvbitVMkEzTUhla2ZlV3dhenVUZlh2QjVi?=
 =?utf-8?B?Y0daWDVkd1V2bWcrUWZ2bkMyakV3ZlNJZnNUSkxkYUJlYjVNTkE1SklYbUg5?=
 =?utf-8?B?MkhSMnZ1OG9ZUUZlLzl4M1Y1TkFWcGx6eWs3bXBsYlN1TTkvSHM5Z1p6dU1P?=
 =?utf-8?B?bHFXKzlPUWV3TDNYWmh0MTZKaUhKRXhISUtmQlVsMVk0UnBXaTF2T0U4ZUNF?=
 =?utf-8?B?Q3M2QWJ4aUNvQS9GMUtZeG9yR2RpSUtTUTQ0TmRpQ2k4R3NMRVNUMzJteStx?=
 =?utf-8?B?SFdTbHYwODlKVnRYYmFpanpQR3UzazlkbHJaU0ZQS3BPRmtuL2dFT05ZL0VW?=
 =?utf-8?B?OXp0VW8yTTF3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2037.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73c706cc-97cc-4014-8a6e-08da08a957d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2022 06:34:24.0695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +azfmg3ycvF9Q2rlb9wCqDJBHjG/ZsVWxPRekm4udUEsRMRBhJsIyf3cQ34N3Fi81hCghveh5g1+/09URFmu1NuOhgSwp/drFxKvc+a31a0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3444
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBJIHRha2UgaXQgdGhhdCB0aGVyZSBhcmUgdXNlcnMgb3V0IHRoZXJlIHRvZGF5IHRoYXQgYXJl
IHN1ZmZpY2llbnRseSBtb3RpdmF0ZWQgYnkgdGhlDQo+IGluY3JlYXNlZCBwZXJmb3JtYW5jZSB0
aGF0IHRoZXkganVzdCBkbyAid3Jtc3IgMHgxYTQgMHgxMjM0Ii4NCj4gDQo+IFlvdSB0YWxrZWQg
YWJvdXQgdGhpcyBpbiB0aGUgIltNZXJpdF0iIHNlY3Rpb24uICBCdXQsIHRoYXQncyBhIF9saXR0
bGVfIHVuY29udmluY2luZy4NCj4gSSBkb24ndCBkb3VidCB0aGF0IHRoZXJlIGlzICphKiB3b3Jr
bG9hZCBvdXQgdGhlcmUgdGhhdCBjYW4gYmVuZWZpdCBmcm9tIGhhcmR3YXJlDQo+IHByZWZldGNo
ZXIgdHdlYWtzLg0KPiANCj4gRG8gd2UgcmVhbGx5IGV4cGVjdCBlbmQgdXNlcnMgdG8gcnVuIHRo
ZWlyIHdvcmtsb2FkcyBhbmQgdHdlYWsgdGhlc2UgdmFsdWVzIHRvDQo+IGZpbmQgc29tZXRoaW5n
IG9wdGltYWwgZm9yIHRoZW0/DQoNCkluIGFkZGl0aW9uIHRvIHRoZSBzYW1wbGUgYmVuY2htYXJr
cyBpbiB0aGUgW01lcml0XSBzZWN0aW9uLCB3ZSBhc3N1bWUNCnRoYXQgc29tZSB3b3JrbG9hZHMg
d2lsbCBiZW5lZml0IGZyb20gdHdlYWtpbmcgcHJlZmV0Y2hlcy4gV2UgZXhwZWN0IHRoYXQNCnVz
ZXJzIGNhbiBmaW5kIHRoZSBiZXN0IHBhcmFtZXRlcnMgYnkgdXNpbmcgYW4gdHVuYWJsZSBJL0Yg
ZnJvbSB1c2Vyc3BhY2UuDQoNCkkgd2lsbCBmaW5kIG91dCB0aGUgc3BlY2lmaWMgd29ya2xvYWQg
d2hpY2ggaW1wcm92ZXMgdGhlIHBlcmZvcm1hbmNlLg0K
