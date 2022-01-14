Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57DAB48F02A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 19:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243337AbiANSvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 13:51:02 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:53454 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236181AbiANSvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 13:51:00 -0500
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 1547AC0162;
        Fri, 14 Jan 2022 18:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1642186260; bh=9vSSYDdVaJckCvfRs6DlfIxQnGZ+9LbcTT3BgOvp16k=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=WFBU9j4hhne5O+4E8tpCforN0poNohNWU4e8hxvA5F1lcUXPGb0OjeIp0hvyYQ6gb
         9xlNKS1mh34bFnpycAQEFcH3oXCPOJov1roloQDeKUJXiPr3taR3WjIvR/Ilk1AXb9
         5ID8qeW39GmkuJTXD/+acaqdy/qGkXfTRRDAQfM4wJ+bhibW4A0+5eW/0Y7WUn+anz
         vNluXYb2UKdgXFlnytc06mlMJ8oh91STPSrQB5klfq+Mw67FFO2B9hzyunz4jWKh4e
         erhOVrSAwm1AM0KdsVx67h3DysgEcoZTATvRSazw8yCjp7C9JOpNY25XbPn6CONAiX
         0Qyr5KN/yUqgw==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 5E83AA0079;
        Fri, 14 Jan 2022 18:50:59 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 1FBC381496;
        Fri, 14 Jan 2022 18:50:57 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="VZQhjXBb";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mFpSl6oiFIR5x5wS3oNGzen9WAxiY2dhUWkFFEhvKYDQwJYhHvoO7CUo6OfoqrpflNce7Z5cMOS1Bj3u2e4jOzjQuBfAu8SIQHpBYEzKbubB37kfCI3HF2NlV7a7Dfj0cffHUhBWHJJk2+qT66k1lTr6jhlMllrQsPFXYYGKiXfnz/gY097Ra9XBYrDxXGTYOywHxcrSCq7D/otO1OnqTXqhlU0ZaCllYbCvBhuBJjIrsb0NZ/cXADjOjCvehFvI9cGGaLxXtllhKwCFw3csNHSVkzInO6IzBN9RNx0K2jil1fymP8OiZ0SL1QtO9PIHOGMmjSIGwi1wZdCCPijkzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9vSSYDdVaJckCvfRs6DlfIxQnGZ+9LbcTT3BgOvp16k=;
 b=JtryHasMxTEbqPfVmHWZgJkzsBgcHIoHk6hPw57h1azzLYGxLk3eQIW5nokpwrHS9yBIQ1l2Q7xTgW1qdhozALHfWyyom+YCTW/LBYY2wNx1umnrXZSYBmOj0h8gWecbzFJyeXouWkw74C0WoUlTYofWURsrqTpjBujMlZhAlFYZuewotY+fu4yQOiZ23GlAxJjDfcS7m/nqifnx7QimTqaeW9aC5kjBQI91aDwFY5xbj6/I5lXWI3WnKYoDDyOuCRBnjjCTZpfVnT6+EJmtJWGZ8wNLr20Vb1m6Hdq4vdPIr7ieJ+on6xnb60+/eOy5AVCAC8Wrze9GewY9zmgUcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9vSSYDdVaJckCvfRs6DlfIxQnGZ+9LbcTT3BgOvp16k=;
 b=VZQhjXBbUSPASpQht6W+2UP0y75xyHl/OsRfxQJE623ZadgHml0zr0/3XqsNjsSnqU7cgZ79+qhaCp7ZwcefJM301aoRa0A7aFGgJ9dKl8hxHoGDNeV0HcsIXNjihru6wde9gf90jVkuJgSYYbg/M78WhSBr/iud97YqIDJdEPQ=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by CY4PR12MB1799.namprd12.prod.outlook.com (2603:10b6:903:11c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Fri, 14 Jan
 2022 18:50:54 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::8983:6493:8c38:d34a]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::8983:6493:8c38:d34a%3]) with mapi id 15.20.4888.011; Fri, 14 Jan 2022
 18:50:54 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH][next] usb: dwc2: Use flex_array_size() helper
Thread-Topic: [PATCH][next] usb: dwc2: Use flex_array_size() helper
Thread-Index: AQHYBr+zu79I9xAKMUG6shqTZFpNVKxi4c8A
Date:   Fri, 14 Jan 2022 18:50:54 +0000
Message-ID: <d1ec4e8a-574a-d841-850c-3f136e404d1a@synopsys.com>
References: <20220111075513.GA76424@embeddedor>
In-Reply-To: <20220111075513.GA76424@embeddedor>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8e9bf014-9e01-417a-23bc-08d9d78ecb34
x-ms-traffictypediagnostic: CY4PR12MB1799:EE_
x-microsoft-antispam-prvs: <CY4PR12MB17995A33741FE92416868F6AAA549@CY4PR12MB1799.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BKBIws43uQ+Nbq2RIZ+3p8g8kk+lM5FIPC328KnEBkTenm6PIL10uKMUPZppw/TaJ5a0LC1LC1Aen7AUJzbELCWZo9O3tdcqanroJeUEMrivI08RR02knS/ZOC+KdGlD0xKdwDdYZ47izLl9pM4bcgBNi+iFivLn5rw+Wdfg50gX9qv/2/eYp7uDvLe34jEbgBxi9ziIwBrYRC1rTRulwsE55A9UTlyzYR/5ojclr+AEXSXIx+8aNtx/SfEWI6HL9cP0wsbLLCVexCJ4+27Vyl76JsrmH94woLTGRou2fIq539coVHsLSlKWGxOy0g2KKQcJvTSUzKxc+5ZC5wqW65m9CnDI8ctJMbPjG7qedJ8o1rv3hfskIuvAc/h7IS5yz4PqKS/tFHkZsWHV6DtFp/3t7TE6Uu6IMFOcLTYnUIX6PH5+JbsKso//vVwQ58JIKifgb002Wn7lYceN8rhPK34F2vpaFJjtrBUyNFtpx86KpxGxiuis6RMRkE6u6XTl4XD7+/o1FrDFmN3MJC69y2aZ3N3k9ybMaRyEWHxZ5JqzsTAY84umXCAtDJk+FZM+pmz6mZ+F2PgHHrdPQCRuWMHf8XVfJUIwwaMmWgsoDdsuGFuxBn00rkRghJLhidYQmiV4sVeB1ktpYTw3hgPL1imKpXt9xXZpftztfZcARH7vieFe+x5rPqczGZZKwvJpOaESRlClUTvRbLo2S/S0P3MdP2+Kt+x5idqJvZ3XrWoLjJsI9RmvjNW1VlTuUrMzF49PnapfZ+GAitwabRfg/PLqQybF/3iX6VvnYDNtxAYQLZVkRDEfzyuRrG8i8taEBzMptZgXwgSxjfI4n6RvWMn+LK5nf2zN1nS5QGsheVM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(54906003)(76116006)(316002)(6486002)(31696002)(2906002)(31686004)(36756003)(4326008)(110136005)(6512007)(66946007)(86362001)(8676002)(38070700005)(122000001)(83380400001)(5660300002)(38100700002)(2616005)(66476007)(66556008)(71200400001)(966005)(508600001)(64756008)(66446008)(186003)(6506007)(26005)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VjREbUFyU1dkVlVhK09YbWdXNk9kT3l6WHpnNU41L0R4R1kvTC9wdXhMeHFR?=
 =?utf-8?B?TkpyTGtYMHRqa1kvQTF5OU9zNHRrWFRMQ3Z3WUlXWVFLeVZZSC8ySHhVcURO?=
 =?utf-8?B?cDBRRExiMU5XamRFK08xUzRlRk12TCt2YzdYNXcvMDZMRWlKcVZuNXB6N2R2?=
 =?utf-8?B?WXNSS2pWM0JlVmRFUVNNa0wxVUU1Zm9rRDRQdDZkQXpVUmt1RnVMbnlidnFt?=
 =?utf-8?B?UFh0NjMvZENuRE9ScTBBRGdVdldWd0JlLzVmbTE0OURGc3pEQjNwbFVTWVA0?=
 =?utf-8?B?K0N2L3IwRVFINGQyRGlyYit2U2gwYnBXcWpBOGNYRnhjMlBCZmNCdWJZVG1M?=
 =?utf-8?B?SEEvaUpacVNFYURmcWQyWW9icFVpdUowN21PKzFjYU5sblE4a0tEMERvZ05M?=
 =?utf-8?B?M0xsdkMvdXdZTDVMVlJFVTNsQlA4dm1lM0kwdnRRd2t0OCtGa1VnZmlYRTZp?=
 =?utf-8?B?R01CdStxWFhQeGEzM0l4blF0U2djclhoYVF2enBqMDZuRVYzNXJ2Qk5QSW8v?=
 =?utf-8?B?VVhOdUpyZ1F0L3BndDVIQ09xT3FLRXN4RU9xSDcrZlh3T0ZOMFJGRG14aUh5?=
 =?utf-8?B?bm40ckRZR0grYVg2R1J1OEExQWt5bXJNVFNDajExWFdkZWNybnlRM0pWQWo0?=
 =?utf-8?B?YkZ0eXpNSSt3NXZiNzBSaVoxUVNpejBjVkxOY2hlRjZ0NWQyNnFnVERaL2Zx?=
 =?utf-8?B?YjhrZ24yam9ydEFGcFBvV1hXWDBUNnZhS21PbFdnRW1zR0FVdVZ3cHd4TUVU?=
 =?utf-8?B?ZFg5ZUwxYTUrVndha1BmYVBXUTFQQ1FhSVcyKzA1VjdiSnozRU9XMzBNRUJP?=
 =?utf-8?B?cnBiNDJDS2JCZ2JvWEpmS0dwd1Y1NHI2aW9JTjlmakpnSUNQK081YzZGNTVp?=
 =?utf-8?B?cnZFNDdOV2R5TEZtakpnTldEc1ZGNTZvTUU0UUhaY1pNV20wNU9RYUJOM0Z6?=
 =?utf-8?B?Ly9BaTNYNmNkK0g1L3ZVWGQyc1p1K1ZGYkZMcFNrOVUxRElTREFYR3NnWkE1?=
 =?utf-8?B?ZEk2MnZZanV6VzVrQ3hub3BSRnRUWnQyZVEzSHJjM2RkeWFQRm9jMmJERGNP?=
 =?utf-8?B?UXJzc1BobGxCSUVESmxDbFF6ZmJUY3Z0Nmd6WmQvcXU1RjVWVFc4VzV5WEhM?=
 =?utf-8?B?NnNYK1pNcXN6ejRBcTN5SFh1eUpIcE9Jc1FiODYzTHRvOFF2Z0J0TVRFUytu?=
 =?utf-8?B?anJEb042NERLcnMzMnplSXFDdmZyeDdBbytvekNkbHpSVHA5cmplQ2d6ZWN6?=
 =?utf-8?B?VmNqYVo5ZnlJemlRYjVkc3FscHZJcm1qZlFTWUhqdnhCeVNQRm9BanNuQ1FX?=
 =?utf-8?B?cXBNYUNVc0M5U0dXYjFOK3JwSTNCVm9tL1RLbHpGT1JCK3FLaDdHaVdYMHh2?=
 =?utf-8?B?Y2NLeGxraDJzMGE2bGtJMUdDeXpkQmM0Sm50alBaTndWUCtGcmtVOEgvUndD?=
 =?utf-8?B?VTI5Z2psSkt0V0l2MjFpaXNYSmVJWEl1TElta2lRdjlzMC93TEVJVWsxcFlP?=
 =?utf-8?B?SVQ4bkVsYlR1VTJtWW53aFJGWnBSb3dzOWI5SVRHMUdoQWJ0VjY2TFNVeWc2?=
 =?utf-8?B?WUw4cWZBYVNkdGliSlcyNmpoaFdGZDY3dkJzK2VMODVzM3FrNFNHamlvWGxC?=
 =?utf-8?B?VkIxNEdHbExXb2xCZE9SWW5LVDRJNC9rcEN0aXpMWjA3UlpuZXU3MXVYYUZp?=
 =?utf-8?B?dnB6T1JVS1htdzRxNDRhRUZGZXJOcHhFUnRhdGxoUU41RmdxNkRPd21yK3ZH?=
 =?utf-8?B?alJTUDBMdkVsOURDVGM5V25LV0tSb1lUeWxhTTEwUXovRkJoako1WVBiWXNK?=
 =?utf-8?B?eWRjMW5ZODdkYU1yd0NwdVlNZFIxMGtFUlJWZHk0REp0ZnArQjluY0tqUitj?=
 =?utf-8?B?NWl1TWFUZHdvbzJmRWZ2Q1BPMTFuekxHOXNQV2N2S3VpbWQzbFk1K1RXR3hj?=
 =?utf-8?B?ZUpxUEJlNlhqUlV6ZjRPTVNyTUpJNkU5Wm0zL3IvaThUUFBCMk1rMGlLdHBE?=
 =?utf-8?B?a0xKcFg2RmhSNnBXOFQzb3p0SzAzcFgraWZMa0trdDdsVVVHM2cxb1JicGZP?=
 =?utf-8?B?dmtxWWsxaHlqbUY1eEg0eWZkaW54R0QxNXU3azFaVVBqdlVxZFREcWhlSSt1?=
 =?utf-8?B?VGhKQzdQN3Z3bmxndHIyei9wbTE0MWE0c0dqYUJmOXF0aXNuSGVzU1ByRHN4?=
 =?utf-8?B?eVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <358B3E440A6E1A41B34D18DB369DD857@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e9bf014-9e01-417a-23bc-08d9d78ecb34
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2022 18:50:54.0562
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v5b7fmtVRqJKGbqZrBiGBuM+25uJKIypmwOY8JVhnlO7Y7nKpRS8PJB5EHfYGCW79YrA3In5unUOMcx+1CEcDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1799
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCkd1c3Rhdm8gQS4gUi4gU2lsdmEgd3JvdGU6DQo+IE1ha2UgdXNlIG9mIHRoZSBmbGV4
X2FycmF5X3NpemUoKSBoZWxwZXIgdG8gY2FsY3VsYXRlIHRoZSBzaXplIG9mIGENCj4gZmxleGli
bGUgYXJyYXkgbWVtYmVyIHdpdGhpbiBhbiBlbmNsb3Npbmcgc3RydWN0dXJlLg0KPiANCj4gVGhp
cyBoZWxwZXIgb2ZmZXJzIGRlZmVuc2UtaW4tZGVwdGggYWdhaW5zdCBwb3RlbnRpYWwgaW50ZWdl
cg0KPiBvdmVyZmxvd3MsIHdoaWxlIGF0IHRoZSBzYW1lIHRpbWUgbWFrZXMgaXQgZXhwbGljaXRs
eSBjbGVhciB0aGF0DQo+IHdlIGFyZSBkZWFsaW5nIHdpdGggYSBmbGV4aWJsZSBhcnJheSBtZW1i
ZXIuDQo+IA0KPiBMaW5rOiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9naXRo
dWIuY29tL0tTUFAvbGludXgvaXNzdWVzLzE2MF9fOyEhQTRGMlI5R19wZyFMOHA3VGxmYkgwc05w
TDlndHNWdVdFWlZuUDhldU1adEpLcGM3MXNYeHpFdzRNQUtXdVEyOGRKSmMwY0pUSTNiV1hMbSQg
DQo+IFNpZ25lZC1vZmYtYnk6IEd1c3Rhdm8gQS4gUi4gU2lsdmEgPGd1c3Rhdm9hcnNAa2VybmVs
Lm9yZz4NCj4gLS0tDQo+ICBkcml2ZXJzL3VzYi9kd2MyL2hjZC5jIHwgNSArKystLQ0KPiAgMSBm
aWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3VzYi9kd2MyL2hjZC5jIGIvZHJpdmVycy91c2IvZHdjMi9oY2QuYw0K
PiBpbmRleCBmNjNhMjdkMTFmYWMuLjJjMjE0OTg2NjJjZCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy91c2IvZHdjMi9oY2QuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MyL2hjZC5jDQo+IEBAIC00
MDU0LDggKzQwNTQsOSBAQCBzdHJ1Y3QgZHdjMl90dCAqZHdjMl9ob3N0X2dldF90dF9pbmZvKHN0
cnVjdCBkd2MyX2hzb3RnICpoc290Zywgdm9pZCAqY29udGV4dCwNCj4gIAkJCSAqIEZvciBzaW5n
bGVfdHQgd2UgbmVlZCBvbmUgc2NoZWR1bGUuICBGb3IgbXVsdGlfdHQNCj4gIAkJCSAqIHdlIG5l
ZWQgb25lIHBlciBwb3J0Lg0KPiAgCQkJICovDQo+IC0JCQliaXRtYXBfc2l6ZSA9IERXQzJfRUxF
TUVOVFNfUEVSX0xTX0JJVE1BUCAqDQo+IC0JCQkJICAgICAgc2l6ZW9mKGR3Y190dC0+cGVyaW9k
aWNfYml0bWFwc1swXSk7DQo+ICsJCQliaXRtYXBfc2l6ZSA9DQo+ICsJCQkJZmxleF9hcnJheV9z
aXplKGR3Y190dCwgcGVyaW9kaWNfYml0bWFwcywNCj4gKwkJCQkJCURXQzJfRUxFTUVOVFNfUEVS
X0xTX0JJVE1BUCk7DQo+ICAJCQlpZiAodXJiLT5kZXYtPnR0LT5tdWx0aSkNCj4gIAkJCQliaXRt
YXBfc2l6ZSAqPSB1cmItPmRldi0+dHQtPmh1Yi0+bWF4Y2hpbGQ7DQo+ICANCg0KVGhpcyBkb2Vz
bid0IGxvb2sgcmlnaHQgZXZlbiB0aG91Z2ggdGhlIHJlc3VsdCB3aWxsIGJlIHRoZSBzYW1lLiBU
aGUNCnJldHVybiB2YWx1ZSBmcm9tIGZsZXhfYXJyYXlfc2l6ZSgpIG1heSBub3QgYmUgdGhlIGZp
bmFsIGFycmF5IHNpemUgYXMgeW91DQpjYW4gc2VlIHRoYXQgYml0bWFwX3NpemUgZ2V0cyB1cGRh
dGVkIGFnYWluIGEgY291cGxlIGxpbmVzIGRvd24uDQoNCkhvdyBhYm91dCB0aGlzIGluc3RlYWQ6
DQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MyL2hjZC5jIGIvZHJpdmVycy91c2IvZHdj
Mi9oY2QuYw0KaW5kZXggZjYzYTI3ZDExZmFjLi4wOTM2ZmY4YjU3ZGIgMTAwNjQ0DQotLS0gYS9k
cml2ZXJzL3VzYi9kd2MyL2hjZC5jDQorKysgYi9kcml2ZXJzL3VzYi9kd2MyL2hjZC5jDQpAQCAt
NDA0OCwxOCArNDA0OCwxNyBAQCBzdHJ1Y3QgZHdjMl90dCAqZHdjMl9ob3N0X2dldF90dF9pbmZv
KHN0cnVjdCBkd2MyX2hzb3RnICpoc290Zywgdm9pZCAqY29udGV4dCwNCiANCiAgICAgICAgICAg
ICAgICBkd2NfdHQgPSB1cmItPmRldi0+dHQtPmhjcHJpdjsNCiAgICAgICAgICAgICAgICBpZiAo
IWR3Y190dCkgew0KLSAgICAgICAgICAgICAgICAgICAgICAgc2l6ZV90IGJpdG1hcF9zaXplOw0K
KyAgICAgICAgICAgICAgICAgICAgICAgaW50IGNvdW50Ow0KIA0KICAgICAgICAgICAgICAgICAg
ICAgICAgLyoNCiAgICAgICAgICAgICAgICAgICAgICAgICAqIEZvciBzaW5nbGVfdHQgd2UgbmVl
ZCBvbmUgc2NoZWR1bGUuICBGb3IgbXVsdGlfdHQNCiAgICAgICAgICAgICAgICAgICAgICAgICAq
IHdlIG5lZWQgb25lIHBlciBwb3J0Lg0KICAgICAgICAgICAgICAgICAgICAgICAgICovDQotICAg
ICAgICAgICAgICAgICAgICAgICBiaXRtYXBfc2l6ZSA9IERXQzJfRUxFTUVOVFNfUEVSX0xTX0JJ
VE1BUCAqDQotICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNpemVvZihkd2Nf
dHQtPnBlcmlvZGljX2JpdG1hcHNbMF0pOw0KKyAgICAgICAgICAgICAgICAgICAgICAgY291bnQg
PSBEV0MyX0VMRU1FTlRTX1BFUl9MU19CSVRNQVA7DQogICAgICAgICAgICAgICAgICAgICAgICBp
ZiAodXJiLT5kZXYtPnR0LT5tdWx0aSkNCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
Yml0bWFwX3NpemUgKj0gdXJiLT5kZXYtPnR0LT5odWItPm1heGNoaWxkOw0KKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBjb3VudCAqPSB1cmItPmRldi0+dHQtPmh1Yi0+bWF4Y2hpbGQ7
DQogDQotICAgICAgICAgICAgICAgICAgICAgICBkd2NfdHQgPSBremFsbG9jKHNpemVvZigqZHdj
X3R0KSArIGJpdG1hcF9zaXplLA0KKyAgICAgICAgICAgICAgICAgICAgICAgZHdjX3R0ID0ga3ph
bGxvYyhzdHJ1Y3Rfc2l6ZShkd2NfdHQsIHBlcmlvZGljX2JpdG1hcHMsIGNvdW50KSwNCiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbWVtX2ZsYWdzKTsNCiAgICAgICAg
ICAgICAgICAgICAgICAgIGlmICghZHdjX3R0KQ0KICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICByZXR1cm4gTlVMTDsNCg0KDQpCUiwNClRoaW5oDQo=
