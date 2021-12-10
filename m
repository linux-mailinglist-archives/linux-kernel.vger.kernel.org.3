Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 464C6470CFB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 23:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240836AbhLJWVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 17:21:04 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:57130 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231806AbhLJWVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 17:21:03 -0500
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 02BCBC1806;
        Fri, 10 Dec 2021 22:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1639174647; bh=FAYx5j+oua1JTqMAa3Z/8DKUMqIcaUbe/aw2DcckoHI=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=J8DQ6uzbHUZ84wGLLqrsFaGwrHTYM7Bp1hex9TY74I5YUwGm5k97kYNFxidmboUQ2
         aq2Nm2OhYHG4YFA3BKhS31wvbFGhtpeBxkCgz1tOtmjtkD+cdhaIxItBTEGN8FJBgr
         tBDiYwi2FfnwG1rzXyzcdho84XP2uJvkI+CwyHJ2URgQCUK9fj4ZWKdGn5cur5E1PG
         wQaJ2xLjY+M+jcIqjzGIhIKhWfs6qRYvyoj0jKBaupd2ezWN4Klj9+6JqbungcYTTD
         vBald+ajtgAUIZYwpaTeDYREIaNKobTtHLSPJ9Dx5CDZdnohZfle5TQq1Xunv2jzzg
         6Qt+72DZkAdzA==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 20B8DA0068;
        Fri, 10 Dec 2021 22:17:25 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id B9429800CD;
        Fri, 10 Dec 2021 22:17:24 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="TW4oo+B7";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WdcD2KtamAIH72BaCWjkQr+ov6GIBLFzLckQxOAaJbgoIFECuPsiIJ+rSPQujys3DC6xFRovmhRl/xKruI3lsAlSLlhGQ13my23dyitOzKWD4+dnwKqQGVCD7lIqdFPkpVWo9NXwz2dhSKj0RQ8I14vtr196AD6gWrzBsW7T73XSnl9Xr9eU4rboLdMxKtcWJqA7gygs7CYimWpZv1EOi/8Oi8lLunf1/EtuOCZ/wdwisbpCZ/M8fa+z5yclO1vNXo0PEu2lqizA8ub2ULIbdmtecJgowYLyRL+bAYNREz6TEctjlngTInLoInim7LtOdKJ/piFFUxd6pqS8uXNavw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FAYx5j+oua1JTqMAa3Z/8DKUMqIcaUbe/aw2DcckoHI=;
 b=b9Vaa6uM+9mR7VJAS1Ba7kiXsm7rSUVYgdig1tieRgBTG+55UNDjicKf+1ec/FdyvH3VfGnpswdqSL75NIJ9FFdRUEZaZh86tepsKJWi/O4FSg0NTgYQMt3iI3WWihOji/esssVXYz1vahrTLv6Hv8DWVwOtOe7axSTp6cP2L3E6p5cKS1fAlpXzGQtndCQA/Fq4xxyrUCvzF+WG4kSLjjpW5e3zCD32q1AMi+axm8GlGoL4a/vqloOfWTuaj2b2eJ80Mi+pF1AkWNGpo5aZdICCSzsXvXKMJ0ysf4Ewng8HI4xw2cF+kUQlTe+xdxDwoLfWuU4BsU0OIJLZNLTmKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FAYx5j+oua1JTqMAa3Z/8DKUMqIcaUbe/aw2DcckoHI=;
 b=TW4oo+B7J7zpSRr1Mdm2cffW8UpfmKUQhR4F313dbc06bzN9vtrs7oRfFjNhTJd4n1K0ofpiAkQ0XWZBqPuuGzKvd5bjraH9ZSv3nok+iyiEP0FXtDfZ3qcvYB62RH0gb7OIh21rfSKzoDD5V2HoIrhMQm1LcfCekwLlIz9zhXU=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BYAPR12MB3047.namprd12.prod.outlook.com (2603:10b6:a03:d9::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.13; Fri, 10 Dec
 2021 22:17:20 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::65:9861:75c5:8e08]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::65:9861:75c5:8e08%6]) with mapi id 15.20.4778.013; Fri, 10 Dec 2021
 22:17:20 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Yaqin Pan <akingchen@vivo.com>, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "kernel@vivo.com" <kernel@vivo.com>
Subject: Re: [PATCH] usb: dwc3: add sprs_ctrl_trans_quirk
Thread-Topic: [PATCH] usb: dwc3: add sprs_ctrl_trans_quirk
Thread-Index: AQHX7QQoJhzp+mIg0U2qyt5GqIQ0JKwsTVuA
Date:   Fri, 10 Dec 2021 22:17:20 +0000
Message-ID: <2b09270f-eb8f-08bd-2133-1a92a34921c2@synopsys.com>
References: <20211209134616.20031-1-akingchen@vivo.com>
In-Reply-To: <20211209134616.20031-1-akingchen@vivo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a3efaf8b-aa17-42c5-4cf2-08d9bc2ad55a
x-ms-traffictypediagnostic: BYAPR12MB3047:EE_
x-microsoft-antispam-prvs: <BYAPR12MB3047EBDC26986260A418288FAA719@BYAPR12MB3047.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Pd1/yCTPyfOevyokm0GM5ukj6ptdSxmfi8mQq4W13jdO7SM9U7VuczIhzw3JjhRvpnwdk+nWoyXxCeZcEeA9CS82WYo42hfoGbltmG7Oc2zRPzXDZJ/+nvdG27DW7GfqVfEXt6vn6tXSKRRHEXr3FAYDwpVl5oBzL6aEZZ01ilQZcs75exOfDDYvlelnPryfqLRngchayXOuDotm9fL0CX9UYCywQ8J2mRuOvh2YVnqOMxdxX9fXq3fhkBPUETKb9UgzmHYrz83r6JfEe2LnVtSMD7xbJRNsMu0ElDyTG+a8y5spoOZ6YkHkwLjgxgMWhQ13fALm2iD+WjEZAF64xt91yquoD+HPqz6r3nOFSnWUNxCU8zHJcdPueKveC4zWGJ9gHdUIV62LzwTNy1E3jfHuWhaANzQFCTxzx78XCGlYxoVNIqFW/TZZdeuCYZ1B8LV6KkacqlW5A6p4P8D07CLPVSZ8I3qHeEtC9jtxjpzQoBtaFfv06xiCGXR1f4Y0c8Mg98jLfbquKEOG3Vz/CSNuqWhhXKW2LGTMSglgY8s5R+L/4zkb1IDlNWcG2bJM0GV0kTM+U6jxZwlCXGutfMiopPGBiBhERFXBssAIG3PEEt3WBdz5uAKbqsBThgawmLTxOpj834f7ofw8PRkfG8PCA8ef7HnWqBFdfl9gxWteGHdAsW62PLrMfxN+LhwnNlOxsolnS1Xw2+IptxHTZHcUIK+mMg3hwQKG1UzJPmFQjO3WVsTth+aq5ZXIrfIeR6fsNHIEKGomT5HTjT2o1g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(122000001)(6486002)(38100700002)(4326008)(31686004)(110136005)(8676002)(2906002)(71200400001)(26005)(6506007)(8936002)(186003)(66446008)(66556008)(508600001)(76116006)(6512007)(66476007)(66946007)(2616005)(38070700005)(36756003)(31696002)(86362001)(316002)(5660300002)(64756008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cW04NFhpcCtmQXBuSFo4NzlyMTY2cHk1UTB3NmRTOUU5N2szYkRJUHdVUkcz?=
 =?utf-8?B?cmRySi9wVWlvdFNRbnlEV1Q4TEIrYVZnMU9ROXJJSy8weXJJWGJzQzBOVXdE?=
 =?utf-8?B?MEhhS3JDa3hsZzZXem5PcDN0Y21ka0RzMFlEMUxBTVJtSjcvVXFEZFVJVEpr?=
 =?utf-8?B?aUlsbzdrNlRMejdMU1RrSm9TR0pIMmtlZER2ZC9BOGI0NzBXRTVEVDFNUStr?=
 =?utf-8?B?a0t1d1QxQWQ4aE1TQmRBQlRsZ0lnM1dpc2JuMURyMi9uRFBJOVNlNUlXcnls?=
 =?utf-8?B?amRKWmZNb0UwZUthWTJTSnR2aFBsK1NUMk9sRGJWbDJpY2FFVFhWTFhzNjRJ?=
 =?utf-8?B?bDhiQW8reXBDVzBqckdxVmVELzQ0Z3BFOGhCV3pCYy9iRzhyZ1hYbHlwcU9X?=
 =?utf-8?B?bHlqNnkvVnVhZUt3cXZyYVZRUjM5STdYemhYZ2YvUzdsaGNVd0hzS1BJcGh6?=
 =?utf-8?B?WlExRnZHZFpiNVpPZ3l3NEhzQW9aR3g5dE82dzVoTXFTQ09ueW5zRWNHYytK?=
 =?utf-8?B?M3VGTWxNNWl4ZkNxM3RNUXNNbmdPQjZOMjBaTzZUWUhxMjJ0TjlGeW4xVE8r?=
 =?utf-8?B?cEtNUnlFU0E2NnoreGpNL3RRUXU5bHpCSHZnRCtaWjc0M1Z5SzREQ09qSmgv?=
 =?utf-8?B?SVo3WDdrVWVBSFJVUnVnc25vQjNSZUZiQkNaQTF2RmpTZTJ1OU05aTQ2ODFL?=
 =?utf-8?B?OWpkN0FnOW9MMnRqWENRUHJOWkE2YUMyN2d6c0JMbTVzc0hIRUlSUnBJaEFu?=
 =?utf-8?B?WTJGREkyV3FnT2trUXBQeHp3ZVVrY1dKZzhJeE5MZVdWRVI2bWFHUmVURndk?=
 =?utf-8?B?OEJtK283eXE2QlJWZjdWMlI0NUFMMXRRMTFjTWk1NitBYks0cWRWZUZPbEkz?=
 =?utf-8?B?RjJoclFQbU4wTE5abFB5MkJWcVNmWm1mZU14OHVrUUlXSHRjTDVwdkZmTzJv?=
 =?utf-8?B?TmZseDlUdC9icGd6TmxoVm1pSVpCU3F6M0VQU2krZVhEUFVOSjB6Rkwwb2x5?=
 =?utf-8?B?SUZGU0UwQ0tQeHlodG1WR3dOeStyVDRIdVg4dTMwM1dYdm5leXVGQyttT3ZB?=
 =?utf-8?B?ek5hTjRwbDc4YmVxblJOc1FTbHE0OEpZRExkQUxLVzVoMDZqT2E3Z1VtOHdo?=
 =?utf-8?B?RHJWRkJoWDdadXI5WGJkMjhSbWFjYnlkU2JtRm9ocWVRRVVxYmJ2TFFyVk5u?=
 =?utf-8?B?WWJYcWZDUmY0dktvQWNzNndOcWx2RXV0UXowaEN3QkhJRkhkSld2U1drSUZx?=
 =?utf-8?B?eUs5QythZXRYVkZ5bEU3cDZKTXAzZzdkcUgrWGViMDJLMWVZdk8rU0w3d1dM?=
 =?utf-8?B?UjdCMktwRENuczFtWEI0N2xpWExUTm1GNkQ3ZjlTL212MjBUcCtSUWcvWmJR?=
 =?utf-8?B?RzB6U2JLL0tuVWF1bThjM3Z6R0NreG01R2hFSkZJNFo4SGtRZGN2ak5NRmhi?=
 =?utf-8?B?MEFlZ1NVZXk2Um5tVjNVSGE3VDFhaHNNRWxrQzFQNFFxUTNsZkJWdHphekQ5?=
 =?utf-8?B?VEFkZDRlTCtGdHJLcXorSFhOYmRQMkVodTJ0NVlTRUR2QkJQK0VZNWRSMkpq?=
 =?utf-8?B?T1FacnJXTXA0Z0o5amNZdzFUV3Fsajh5ZGRYeEdVclRBdm91T3hZQTNUTStz?=
 =?utf-8?B?c0VqcUxCdnJ5QUVKTGZXZHB3em9HNDdtdFFTVUIreDRQRXJVRlVkd2twMEJJ?=
 =?utf-8?B?bXEyNGxJMndkT1V0OGR1VUFrUWlXL2FmenJmT3Q1NGFZSVZhM0N3eWVDWHZj?=
 =?utf-8?B?OC9BbkxFeG1laXROSXVJWDR2NUpoWUY0K0NyQWFvenNEd2JCN096RTQ0SUhv?=
 =?utf-8?B?ODFtTWdFaG1MYzdLYU5WS2ZrTGppM0h2SEp2dGQraThvQXZGdCsyZFNBazhW?=
 =?utf-8?B?Z2NWNG45Qk1mOEwxb0xveWJiOXRnTERHVWxUaTRrdmoxSHVSUUxRT1p2Y256?=
 =?utf-8?B?dmNrSENFZDF6MDBXZlBQcnZreEpjUEtnTnZSL0VnRVBVTWUrNG53eFZvL2xL?=
 =?utf-8?B?RHBGL1QxaHFpejJzUDFqV1VEQld5bUlwZ3BNOE5WckYzZWxwU2UxK2ZKbHlj?=
 =?utf-8?B?dGNta3Z2TG9vOG9idzVIUWd4dW5YMlZPSEpXYUd5bkxET0FtVnB6TlhaMHpK?=
 =?utf-8?B?Y25HTzh5amx0Vy9WcUJlSmlrcjFRLzNCOE42a3AzUUFuV2NSYmxRMytHa2Rr?=
 =?utf-8?B?QlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <52DCA23232B581479EC34A24BFFA5273@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3efaf8b-aa17-42c5-4cf2-08d9bc2ad55a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2021 22:17:20.0624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D3lu2dkFICMh+hmXt3nIFZ1xvltqv541U2pG0lOs6tYcohcxgGyqmxAz7p6uNgljg9bNLecrurMyk//2qb7/5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3047
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCllhcWluIFBhbiB3cm90ZToNCj4gQWRkIGEgcXVpcmsgdG8gc2V0IEdVQ1RMLlNQUlND
VFJMVFJBTlNFTiBiaXQuDQo+IA0KPiBTb21lIHNwZWNpYWwgcGVyaXBoZXJhbHMgY2FuJ3QgaGFu
ZGxlIHRoZSBjb250cm9sIHRyYW5zZmVyIHdlbGwuDQoNCkNhbiB5b3UgZXhwbGFpbiB0aGUgcHJv
YmxlbSBpbiBtb3JlIGRldGFpbD8NCg0KPiBGb3IgZXhhbXBsZSwgVEYgY2FyZCByZWFkZXIgKGFh
YWE6ODgxNik6DQo+IHVzYiAxLTE6IG5ldyBoaWdoLXNwZWVkIFVTQiBkZXZpY2UgbnVtYmVyIDIg
dXNpbmcgeGhjaS1oY2QNCj4gdXNiIDEtMTogZGV2aWNlIGRlc2NyaXB0b3IgcmVhZC9hbGwsIGVy
cm9yIC0xMTANCj4gRnJvbSB0aGUgdXNiIGFuYWx5emVyLCBhbHdheXMgcmV0dXJuIE5BSyBpbiB0
aGUgZGF0YSBwaGFzZS4NCg0KQW5kIGhvdyB0aGlzIGNoYW5nZSBoZWxwIHRvIHJlc29sdmUgdGhp
cyBpc3N1ZS4NCg0KQWxzbyBub3RlIGluIHRoZSBwYXRjaCB0aGF0IHRoaXMgaXMgZm9yIGhvc3Qg
bW9kZS4NCg0KPiANCj4gU2lnbmVkLW9mZi1ieTogWWFxaW4gUGFuIDxha2luZ2NoZW5Adml2by5j
b20+DQo+IC0tLQ0KPiAgZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgfCA0ICsrKysNCj4gIGRyaXZl
cnMvdXNiL2R3YzMvY29yZS5oIHwgMyArKysNCj4gIDIgZmlsZXMgY2hhbmdlZCwgNyBpbnNlcnRp
b25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgYi9kcml2
ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiBpbmRleCBiYTc0YWQ3ZjY5OTUuLjkzYWMyYzc5YTJjMCAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gKysrIGIvZHJpdmVycy91
c2IvZHdjMy9jb3JlLmMNCj4gQEAgLTEwNzEsNiArMTA3MSw4IEBAIHN0YXRpYyBpbnQgZHdjM19j
b3JlX2luaXQoc3RydWN0IGR3YzMgKmR3YykNCj4gIAkJICogcGFja2V0IHdpdGggUmV0cnk9MSAm
IE51bXAgIT0gMCkNCj4gIAkJICovDQo+ICAJCXJlZyB8PSBEV0MzX0dVQ1RMX0hTVElOQVVUT1JF
VFJZOw0KPiArCQlpZiAoZHdjLT5zcHJzX2N0cmxfdHJhbnNfcXVpcmspDQo+ICsJCQlyZWcgfD0g
RFdDM19HVUNUTF9TUFJTQ1RSTFRSQU5TRU47DQo+ICANCj4gIAkJZHdjM193cml0ZWwoZHdjLT5y
ZWdzLCBEV0MzX0dVQ1RMLCByZWcpOw0KPiAgCX0NCj4gQEAgLTEzNzcsNiArMTM3OSw4IEBAIHN0
YXRpYyB2b2lkIGR3YzNfZ2V0X3Byb3BlcnRpZXMoc3RydWN0IGR3YzMgKmR3YykNCj4gIA0KPiAg
CWR3Yy0+ZGlzX3NwbGl0X3F1aXJrID0gZGV2aWNlX3Byb3BlcnR5X3JlYWRfYm9vbChkZXYsDQo+
ICAJCQkJInNucHMsZGlzLXNwbGl0LXF1aXJrIik7DQo+ICsJZHdjLT5zcHJzX2N0cmxfdHJhbnNf
cXVpcmsgPSBkZXZpY2VfcHJvcGVydHlfcmVhZF9ib29sKGRldiwNCj4gKwkJCQkic25wcyxzcHJz
LWN0cmwtdHJhbnMtcXVpcmsiKTsNCg0KU2luY2UgeW91J3JlIGFkZGluZyBhIG5ldyBkZXZpY2Ug
cHJvcGVydHksIHBsZWFzZSBhZGQgYW5vdGhlciBwYXRjaCB0bw0KZG9jdW1lbnQgaXQgaW4gRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYg0KDQpCUiwNClRoaW5oDQoNCj4gIA0K
PiAgCWR3Yy0+bHBtX255ZXRfdGhyZXNob2xkID0gbHBtX255ZXRfdGhyZXNob2xkOw0KPiAgCWR3
Yy0+dHhfZGVfZW1waGFzaXMgPSB0eF9kZV9lbXBoYXNpczsNCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvdXNiL2R3YzMvY29yZS5oIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmgNCj4gaW5kZXggNTk5
MTc2NjIzOWJhLi42MDQ4MDg3ZGYxZDEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMv
Y29yZS5oDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oDQo+IEBAIC0yNTQsNiArMjU0
LDcgQEANCj4gIA0KPiAgLyogR2xvYmFsIFVzZXIgQ29udHJvbCBSZWdpc3RlciAqLw0KPiAgI2Rl
ZmluZSBEV0MzX0dVQ1RMX0hTVElOQVVUT1JFVFJZCUJJVCgxNCkNCj4gKyNkZWZpbmUgRFdDM19H
VUNUTF9TUFJTQ1RSTFRSQU5TRU4JQklUKDE3KQ0KPiAgDQo+ICAvKiBHbG9iYWwgVXNlciBDb250
cm9sIDEgUmVnaXN0ZXIgKi8NCj4gICNkZWZpbmUgRFdDM19HVUNUTDFfUEFSS01PREVfRElTQUJM
RV9TUwlCSVQoMTcpDQo+IEBAIC0xMDc3LDYgKzEwNzgsNyBAQCBzdHJ1Y3QgZHdjM19zY3JhdGNo
cGFkX2FycmF5IHsNCj4gICAqCTMJLSBSZXNlcnZlZA0KPiAgICogQGRpc19tZXRhc3RhYmlsaXR5
X3F1aXJrOiBzZXQgdG8gZGlzYWJsZSBtZXRhc3RhYmlsaXR5IHF1aXJrLg0KPiAgICogQGRpc19z
cGxpdF9xdWlyazogc2V0IHRvIGRpc2FibGUgc3BsaXQgYm91bmRhcnkuDQo+ICsgKiBAc3Byc19j
dHJsX3RyYW5zX3F1aXJrOiBzZXQgdG8gZW5hYmxlIHNwYXJzZSBjb250cm9sIHRyYW5zYWN0aW9u
IHF1aXJrLg0KPiAgICogQGltb2RfaW50ZXJ2YWw6IHNldCB0aGUgaW50ZXJydXB0IG1vZGVyYXRp
b24gaW50ZXJ2YWwgaW4gMjUwbnMNCj4gICAqCQkJaW5jcmVtZW50cyBvciAwIHRvIGRpc2FibGUu
DQo+ICAgKi8NCj4gQEAgLTEyNzksNiArMTI4MSw3IEBAIHN0cnVjdCBkd2MzIHsNCj4gIAl1bnNp
Z25lZAkJZGlzX21ldGFzdGFiaWxpdHlfcXVpcms6MTsNCj4gIA0KPiAgCXVuc2lnbmVkCQlkaXNf
c3BsaXRfcXVpcms6MTsNCj4gKwl1bnNpZ25lZAkJc3Byc19jdHJsX3RyYW5zX3F1aXJrOjE7DQo+
ICAJdW5zaWduZWQJCWFzeW5jX2NhbGxiYWNrczoxOw0KPiAgDQo+ICAJdTE2CQkJaW1vZF9pbnRl
cnZhbDsNCj4gDQoNCg==
