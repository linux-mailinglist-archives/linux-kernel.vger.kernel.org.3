Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19EA3476EDC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 11:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235996AbhLPK0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 05:26:39 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:49466 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236058AbhLPK0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 05:26:38 -0500
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 17AE547772;
        Thu, 16 Dec 2021 10:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1639650398; bh=TEolMqXeSATtD2baMNpTuvBqCPKTAbWzg/S9F3KFyc8=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=P2pweiISLce+aMuPT2LiSq5h2eAl5hjeN43fCfiQp0a/7XAUeugO7LwviIo/aVJpf
         jJeu3djWJiAiGHd/lGsSJO62J9tVguhnKW6B8JCoHyIdcB7dGEP3UpE0GaGU+IRBHW
         wmtuCUnKV5UIgjE0SWK9SqVPLZ7rQ6Dhg4NBWoEficWyVZ09E/HKBUyIrrTxaUT61V
         DXiM15rN2qPUoEjoLs92wGvISFp29UQY3UM2qgENHa3054Ao3y/N8YNmD2o5IjrWU0
         iydeXCoA/zeEy+XJ0WzgBb+PS7lOliA3JgFs8GkL+MsUVDPNRCweNsRoWT+8RA9fjs
         GgRk98M4jFjiQ==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 03AA8A0080;
        Thu, 16 Dec 2021 10:26:36 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 670F5801D6;
        Thu, 16 Dec 2021 10:26:36 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=hminas@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="TiKjM/GR";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QSoCE8Z5+Ub0RnDKYIgBhV9Fdic56hDZSV0npYEdKtBWLqc5GrkLAA0YDhCdnnaarCxS3BY57dXnjrKYUAhdpSTuROFjZ1IPiHc1eotdMZ5Lji0VdMgAoItPHeD8h3zy7YbQw3qkZzqpUjnTnFVoxIaWIqlfkXt9AIxsx4/XmbR9JPvIaNUJEcE747w5H2B0u/+6lKbCxIMPBCV3MTOjBjlXE21K5TEoeWa+JPdw0tpwtH6z49pW+HXmaK/KVr6IGHwI4C99kzFghL3BZ8kBg/hFwyIyEoR2cFwNm2jRxLZ1ZBhc+cPR6LMj8e2DOxsTprjmPoRWpoEOfrUr5IqZTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TEolMqXeSATtD2baMNpTuvBqCPKTAbWzg/S9F3KFyc8=;
 b=gdmh3FOWogUeMAKKCHIU0yI97kowQlheVljrXVYZa3gIMSMosB2PYLxWc4pU4cRp8/EGypCBiB/UCEw3xZGNtEefaPmh+P3yT+ACIqt/tKu6qt7fiZUFfzuBZlZLvTl8UuRV24IRyYXTAis6rysrfrQ9L0GJqAKAw/iYSU1vDuQkmgW/nc/S4a4s4xUPkYZ/v0nETYlO5Kb8sVZ/qNyzdE1ppVsiTvx6AWJ7M38f9NOdr2TGCaHIpY0I5Gd+sPBJ0mPNLseeLNcXsBGng8r4wdfB3j0byrxw/Lo8T6KfJvEGx6Fp9uBdNppepEFxNi5eHO/rWZpeKyCBvHgWMevsow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TEolMqXeSATtD2baMNpTuvBqCPKTAbWzg/S9F3KFyc8=;
 b=TiKjM/GRGFaQ1/Y9oBTjUzNiDp90qi3ZfycdXR5bSk5/+AWB5QiX3hPNwLWaXvH7Pb/oW/cRi+waysPLQhyuFicsT6gu7IHusU/QLEN+MvsTSJaWkOHmfxNnjesvOl5Sh4emi7acL0YN1gMicFVz8FiB85dC+02WeoAN9GPTzMU=
Received: from BYAPR12MB3413.namprd12.prod.outlook.com (2603:10b6:a03:ab::15)
 by BYAPR12MB3126.namprd12.prod.outlook.com (2603:10b6:a03:df::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.14; Thu, 16 Dec
 2021 10:26:34 +0000
Received: from BYAPR12MB3413.namprd12.prod.outlook.com
 ([fe80::51c0:c3a7:fb8a:11e1]) by BYAPR12MB3413.namprd12.prod.outlook.com
 ([fe80::51c0:c3a7:fb8a:11e1%6]) with mapi id 15.20.4801.014; Thu, 16 Dec 2021
 10:26:34 +0000
X-SNPS-Relay: synopsys.com
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "amelie.delaunay@foss.st.com" <amelie.delaunay@foss.st.com>,
        "alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>
Subject: Re: [PATCH 3/3] usb: dwc2: drd: restore role and overrides upon
 resume
Thread-Topic: [PATCH 3/3] usb: dwc2: drd: restore role and overrides upon
 resume
Thread-Index: AQHX6roiG1adQQu2GEqyh8VLpxLQkaw0+VgA
Date:   Thu, 16 Dec 2021 10:26:34 +0000
Message-ID: <6f7adaf0-4894-4e7b-6c2b-757e25a1f39b@synopsys.com>
References: <1638806203-6624-1-git-send-email-fabrice.gasnier@foss.st.com>
 <1638806203-6624-4-git-send-email-fabrice.gasnier@foss.st.com>
In-Reply-To: <1638806203-6624-4-git-send-email-fabrice.gasnier@foss.st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 036cdcbd-1eda-4576-6e52-08d9c07e8912
x-ms-traffictypediagnostic: BYAPR12MB3126:EE_
x-microsoft-antispam-prvs: <BYAPR12MB31260BA6D0D87E9C028B1996A7779@BYAPR12MB3126.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pdiEcP/rKQ3KTDcf28lFmI3+/8Z+s1OY1RHu9gFPO0wzBq9xizazEHza5UmC5HF/U38Zmy++r7Zzv7DjtcJANOvMj8D1tH7opzjWzUXNq8m+/0LqY29WrmqNEbfAcwram3D/2RmAyBCQOF4cqZjQaiBgN+V3XLESNBa2rBfo7Xs/mckrhZFUAI86//MPrHjmKKpn4u6Bza4T9W/qRnI3glEKkOXRoIGBxwPOxbjI0nR8tuVRNnZiV8gg8V+SffiSNs41pvATCxKnCyB+ykAcX21AioX2BxhaP0Xq6NGv/12eYP0pvdRF7Q1enaAuKVVc37chKqf7lDY8v1yWDmftWfKqLYzHJrDSvXMa88fMWnskIFRS9DtS4G4GL7pJpA4peppxvmZ9hLQ6jMvk5Dp0FiXCo8+N+UTtd4fPOJe8oUbrpFwoJWix3mVFP4GOF/EFV3LHfxN7hVWiMrgTKy6eHC65R2NCBSDPyM1uN3l5h/nTwrCzPuuJdBI2+E4lOofi6YLckHfhgUAjWgylRxL3ODr4ilnGCj4XuUvu2JK8o06YRSSK1qgKkYj162Fxn5z2sKwsxx19HF4X6BJVhLdfMXORauyePEFnkSIxLasE7YaL0VDBqlJHASENr6JUY2o7jKBvJ7bzGsQR6ipSKfUM+blrPhmjQai0DJuDwoFC6Si/llg++xfaDLTm8BMXWxaceE2dk+OyJgotcOJ8+fjOb5lzwGW08pZ5jNp2bqJ02S4C3Y1xdpE1WygP6aUtqjHT/WTEllBRQIcvvNC5L+e6Fw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3413.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(36756003)(6512007)(86362001)(66446008)(64756008)(66556008)(38070700005)(508600001)(83380400001)(6506007)(71200400001)(31696002)(91956017)(2906002)(4326008)(186003)(2616005)(66946007)(31686004)(66476007)(53546011)(5660300002)(8936002)(6486002)(8676002)(110136005)(26005)(122000001)(54906003)(38100700002)(316002)(76116006)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NXFuQ0tEZS8wWEhCOXNpT3ZwUmd1ejllQUt2ejVQRGpzMU1TK1o5dTFpRThC?=
 =?utf-8?B?aUo3TWkzdVdaVnZqOGhyNzZsclY5WnRMZi83NnY1Qld5b3NtRkkveW9HWU9w?=
 =?utf-8?B?SHBhTkkybEFpS2tQaHVRV0dZV1RLVWhxbnlkZXhoYnpRNmgzMHU1djZTendv?=
 =?utf-8?B?NEhWUURlNmNteGxUY2liM2o2RUdDS1BJbkd0WjVZZmhBSnpSeVBXd0ZtVzVL?=
 =?utf-8?B?TFloeStpQVZ3bXB0QlBiWWhnNXNsUnF1M3JnWFUyRUh5MGZ0bVhQUy9Ddmph?=
 =?utf-8?B?NVUveE1HbmFLeTZsbEp1bFhvRGc3T2l5MTkvNHVDdDMxT2VQZUhqeWljR3Bu?=
 =?utf-8?B?ZkVtWHdQSnl4OENkYi9YU3cvY2hsWDduV1RVTkpxenFuK2ZKOUZabUdRYjVE?=
 =?utf-8?B?MXJJeU1GSGcrRkVyRFBzVnF4c3pnaWdZbXpybFNoUjF5QzlyN09LcFpMd3Nu?=
 =?utf-8?B?STF1a09wM2RlTjFrWnZWN016ZlpNZ1VzY09YQXRBRGhLNHpxaHF6SEVUWHdk?=
 =?utf-8?B?Q0lzU1RlRnNZR1VvOXorVzBQd2VPc1RxazFDc0tMamJoVlFnSlI5OU1HUVZm?=
 =?utf-8?B?TmgxY250V1l3NWhTUkNsT1VNZ1BsWGRJait3YUNibnZiN083U2dUZlg1NVNv?=
 =?utf-8?B?dkJzaXR0SmdJRHJ1TTRlT25ZOFUyblF4d2Q0QXp5S1p1OEcvd1c4ZnNHVU9p?=
 =?utf-8?B?c2V2NTZkN2FJMmZ5ZFZHenV1ektJZzVkVWJVbHVzZFpWeXlKZ2tuYjVoYnZw?=
 =?utf-8?B?d3ovbGxPUTFPWmZ4dEZ0ZXQ5bnZTQ2JvWXR0R3pwU21EdzRVTHBGQkNqekxO?=
 =?utf-8?B?S2FISFA1VmNlUk4zZVQ4OEtLQm5SNm9CR3lBdVFJRUtsTXpiRUxuRlFPNTA0?=
 =?utf-8?B?SmFwNUd4eGdHYWNxSkV6N1dMYzVDUFIwQUZIQ0pQLzlFOVlQb05jd2laZ1Br?=
 =?utf-8?B?ZHBXZFFIMzJ4Z0V4Vm55WUVxclVyTEVvWGs1R3JxN0h4NkRLWnIycU4zNkNR?=
 =?utf-8?B?Q1FNampNcWlSaFl4a1BhZEVPckcxU3VQYndIVWZMRzJvUW0yVGJKRkh4YUtZ?=
 =?utf-8?B?NVRqSlBxTElkdzFZVzltN1VCQU5GYkhhTDJRMWZ3OEF5U0pTendpa25SSHFm?=
 =?utf-8?B?YWNuM0IvVzltMnU0VGV6Z0dVcGJrcDNBSmNEeEM4aUp5R3VTaVlFSHBWVnZr?=
 =?utf-8?B?VFBSTmZxbHJKZVVLUFY4UkF5WjRuaytqb3Y5LzVFWG9QSWhPbnRULyt3dFpt?=
 =?utf-8?B?RUV1TU5lNVRDY0RsNlkxc01TK2IrMlRoMnVoV3dsN1AvOXhwZkZsZjdHSXJ4?=
 =?utf-8?B?UGVwUUFYaFB1VTVpQ2Z2dVJVUDQ2Y1BXV2cyRG1tYzk0Nk5NRmVaMDZwYmJh?=
 =?utf-8?B?WERqbUc1MU1CZ1V4YktTZlg3QmNidmV2NkNvcmlrOXJObWlZdXFxaW52NDR4?=
 =?utf-8?B?SWdjUjhmdnE1MnAxYnRqSkMrZFAzYnpGRGZHN0JETEljazhEMk5UcklUVVdO?=
 =?utf-8?B?SDFEd2NTTUVUQm83Q1d4Z3RzOGRzRFlST3F5OHRmbU1ISXhpVkhLZ2dSRXdl?=
 =?utf-8?B?V0ZtU0hCeTU2d2FPTi9rV0dmTCs1aVF3WHJ0emlRRUFER0ZmUDNmVFluelFy?=
 =?utf-8?B?SkV0WTR6UzNEMCtSckN4KzZrdENsQ0FlaVFXVVdhUFFUN1NWTnNONlhxcUl5?=
 =?utf-8?B?QUJCQnRaR25xZ3NpT3FIZDFISm1OTVJ1NHlGejRGZHViZXlYWVh6eTE5SE5N?=
 =?utf-8?B?WlVST3RuZ1djU2FCR0t4WElXbWFVUTZaa25NRFRDclFNWmpKVE5SVXZkVlIy?=
 =?utf-8?B?ODdoL3pMN0Y5cWgyMGpPSHZsc2NUSTdiVitrMzVSNXVvSHdVRVJiSzdaTG9s?=
 =?utf-8?B?MDRqazA3a21uLy92dVl6UDJTM05tSTcyeGVrNGxXSXQ0eGNJME9EWkNNWXVW?=
 =?utf-8?B?UGtoTmZxVTVTcGl6WEsxWmVWWS8vTVRUYzk2cVcxS1paWDJKNnAwQ1kvcHZn?=
 =?utf-8?B?WUVGaTFlRnNYK1JVV2xXNnk0dmFTZmFPemZrRmJlTWN3RUNWUDkzTHkvV1o3?=
 =?utf-8?B?Vm5RVTQrSTJPcW9zMmFqeU5QQU5TeUNzQTJKVVpFTHRUYUxIWnQyREc0ZlFI?=
 =?utf-8?B?N2RhRkwzY3UwVDQyenJ5M1dnWVdEVVpYeFFjVmpTSDBnTTZ0RG9NN093bjJo?=
 =?utf-8?B?bHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <91B6FD40BB2CBC4CBAFFB8B3C0148934@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 036cdcbd-1eda-4576-6e52-08d9c07e8912
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2021 10:26:34.4766
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3H/C9OhcADBNEiOLIUMZfhITry7+GTxiFnZspNx8wBGDqIw6UB+T4s9ffs/hfsLl0aWMyUOyErBk3MkBQFKrsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3126
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIvNi8yMDIxIDc6NTYgUE0sIEZhYnJpY2UgR2FzbmllciB3cm90ZToNCj4gT3ZlcnJpZGUg
ZW5hYmxlIGJpdHMgbWF5IG5vdCBiZSByZXN0b3JlZCB3aGVuIGdvaW5nIHRvIGxvdyBwb3dlciBt
b2RlDQo+IChlLmcuIHdoZW4gaW4gRFdDMl9QT1dFUl9ET1dOX1BBUkFNX05PTkUpLg0KPiBUaGVz
ZSBiaXRzIGFyZSBzZXQgd2hlbiBwcm9iaW5nL2luaXRpYWxpemluZyBkcmQgKHJvbGUgc3dpdGNo
KS4gUmVzdG9yZQ0KPiB0aGVtIHVwb24gcmVzdW1lIGZyb20gbG93IHBvd2VyIG1vZGUgKGluIGNh
c2UgdGhlc2UgaGF2ZSBiZWVuIGxvc3QpLg0KPiANCj4gVG8gYWNoaWV2ZSB0aGlzLCB0aGUgbGFz
dCBrbm93biByb2xlIGlzIHJlc3RvcmVkIHVwb24gcmVzdW1lLiBBbmQgdGhlDQo+IG92ZXJyaWRl
IGVuYWJsZSBiaXRzIGFyZSBhbHdheXMgc2V0IHdoZW4gY29uZmlndXJpbmcgYXZhbCwgYnZhbCBh
bmQgdmJ2YWwuDQo+IA0KPiBXaGVuIHJlc3VtaW5nLCBmb3JjaW5nIHRoZSByb2xlIHNob3VsZCBi
ZSBkb25lIG9ubHkgb25jZSwgb3IgdGhpcyBjYW4gY2F1c2UNCj4gcG9ydCBjaGFuZ2VzIGluIEhP
U1QgbW9kZSBmb3IgaW5zdGFuY2UuDQo+IFNvLCBvbmx5IHJlc3RvcmUgRk9SQ0VERVZNT0RFL0ZP
UkNFSE9TVE1PREUgd2hlbiByb2xlX3N3IGlzIHVudXNlZA0KPiANCj4gU2lnbmVkLW9mZi1ieTog
RmFicmljZSBHYXNuaWVyIDxmYWJyaWNlLmdhc25pZXJAZm9zcy5zdC5jb20+DQoNCkFja2VkLWJ5
OiBNaW5hcyBIYXJ1dHl1bnlhbiA8TWluYXMuSGFydXR5dW55YW5Ac3lub3BzeXMuY29tPg0KDQo+
IC0tLQ0KPiAgIGRyaXZlcnMvdXNiL2R3YzIvZHJkLmMgICAgICB8IDM4ICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKy0tDQo+ICAgZHJpdmVycy91c2IvZHdjMi9wbGF0Zm9ybS5j
IHwgMTAgKysrKysrLS0tLQ0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgNDIgaW5zZXJ0aW9ucygrKSwg
NiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MyL2RyZC5j
IGIvZHJpdmVycy91c2IvZHdjMi9kcmQuYw0KPiBpbmRleCA0ZjQ1M2VjLi4xYjM5YzQ3IDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MyL2RyZC5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3
YzIvZHJkLmMNCj4gQEAgLTEzLDYgKzEzLDEwIEBADQo+ICAgI2luY2x1ZGUgPGxpbnV4L3VzYi9y
b2xlLmg+DQo+ICAgI2luY2x1ZGUgImNvcmUuaCINCj4gICANCj4gKyNkZWZpbmUgZHdjMl9vdnJf
Z290Z2N0bChnb3RnY3RsKSBcDQo+ICsJKChnb3RnY3RsKSB8PSBHT1RHQ1RMX0JWQUxPRU4gfCBH
T1RHQ1RMX0FWQUxPRU4gfCBHT1RHQ1RMX1ZCVkFMT0VOIHwgXA0KPiArCSBHT1RHQ1RMX0RCTkNF
X0ZMVFJfQllQQVNTKQ0KPiArDQo+ICAgc3RhdGljIHZvaWQgZHdjMl9vdnJfaW5pdChzdHJ1Y3Qg
ZHdjMl9oc290ZyAqaHNvdGcpDQo+ICAgew0KPiAgIAl1bnNpZ25lZCBsb25nIGZsYWdzOw0KPiBA
QCAtMjEsOCArMjUsNyBAQCBzdGF0aWMgdm9pZCBkd2MyX292cl9pbml0KHN0cnVjdCBkd2MyX2hz
b3RnICpoc290ZykNCj4gICAJc3Bpbl9sb2NrX2lycXNhdmUoJmhzb3RnLT5sb2NrLCBmbGFncyk7
DQo+ICAgDQo+ICAgCWdvdGdjdGwgPSBkd2MyX3JlYWRsKGhzb3RnLCBHT1RHQ1RMKTsNCj4gLQln
b3RnY3RsIHw9IEdPVEdDVExfQlZBTE9FTiB8IEdPVEdDVExfQVZBTE9FTiB8IEdPVEdDVExfVkJW
QUxPRU47DQo+IC0JZ290Z2N0bCB8PSBHT1RHQ1RMX0RCTkNFX0ZMVFJfQllQQVNTOw0KPiArCWR3
YzJfb3ZyX2dvdGdjdGwoZ290Z2N0bCk7DQo+ICAgCWdvdGdjdGwgJj0gfihHT1RHQ1RMX0JWQUxP
VkFMIHwgR09UR0NUTF9BVkFMT1ZBTCB8IEdPVEdDVExfVkJWQUxPVkFMKTsNCj4gICAJaWYgKGhz
b3RnLT5yb2xlX3N3X2RlZmF1bHRfbW9kZSA9PSBVU0JfRFJfTU9ERV9IT1NUKQ0KPiAgIAkJZ290
Z2N0bCB8PSBHT1RHQ1RMX0FWQUxPVkFMIHwgR09UR0NUTF9WQlZBTE9WQUw7DQo+IEBAIC00NCw2
ICs0Nyw5IEBAIHN0YXRpYyBpbnQgZHdjMl9vdnJfYXZhbGlkKHN0cnVjdCBkd2MyX2hzb3RnICpo
c290ZywgYm9vbCB2YWxpZCkNCj4gICAJICAgICghdmFsaWQgJiYgIShnb3RnY3RsICYgR09UR0NU
TF9BU0VTVkxEKSkpDQo+ICAgCQlyZXR1cm4gLUVBTFJFQURZOw0KPiAgIA0KPiArCS8qIEFsd2F5
cyBlbmFibGUgb3ZlcnJpZGVzIHRvIGhhbmRsZSB0aGUgcmVzdW1lIGNhc2UgKi8NCj4gKwlkd2My
X292cl9nb3RnY3RsKGdvdGdjdGwpOw0KPiArDQo+ICAgCWdvdGdjdGwgJj0gfkdPVEdDVExfQlZB
TE9WQUw7DQo+ICAgCWlmICh2YWxpZCkNCj4gICAJCWdvdGdjdGwgfD0gR09UR0NUTF9BVkFMT1ZB
TCB8IEdPVEdDVExfVkJWQUxPVkFMOw0KPiBAQCAtNjMsNiArNjksOSBAQCBzdGF0aWMgaW50IGR3
YzJfb3ZyX2J2YWxpZChzdHJ1Y3QgZHdjMl9oc290ZyAqaHNvdGcsIGJvb2wgdmFsaWQpDQo+ICAg
CSAgICAoIXZhbGlkICYmICEoZ290Z2N0bCAmIEdPVEdDVExfQlNFU1ZMRCkpKQ0KPiAgIAkJcmV0
dXJuIC1FQUxSRUFEWTsNCj4gICANCj4gKwkvKiBBbHdheXMgZW5hYmxlIG92ZXJyaWRlcyB0byBo
YW5kbGUgdGhlIHJlc3VtZSBjYXNlICovDQo+ICsJZHdjMl9vdnJfZ290Z2N0bChnb3RnY3RsKTsN
Cj4gKw0KPiAgIAlnb3RnY3RsICY9IH5HT1RHQ1RMX0FWQUxPVkFMOw0KPiAgIAlpZiAodmFsaWQp
DQo+ICAgCQlnb3RnY3RsIHw9IEdPVEdDVExfQlZBTE9WQUwgfCBHT1RHQ1RMX1ZCVkFMT1ZBTDsN
Cj4gQEAgLTE5Niw2ICsyMDUsMzEgQEAgdm9pZCBkd2MyX2RyZF9zdXNwZW5kKHN0cnVjdCBkd2My
X2hzb3RnICpoc290ZykNCj4gICB2b2lkIGR3YzJfZHJkX3Jlc3VtZShzdHJ1Y3QgZHdjMl9oc290
ZyAqaHNvdGcpDQo+ICAgew0KPiAgIAl1MzIgZ2ludHN0cywgZ2ludG1zazsNCj4gKwllbnVtIHVz
Yl9yb2xlIHJvbGU7DQo+ICsNCj4gKwlpZiAoaHNvdGctPnJvbGVfc3cpIHsNCj4gKwkJLyogZ2V0
IGxhc3Qga25vd24gcm9sZSAoYXMgdGhlIGdldCBvcHMgaXNuJ3QgaW1wbGVtZW50ZWQgYnkgdGhp
cyBkcml2ZXIpICovDQo+ICsJCXJvbGUgPSB1c2Jfcm9sZV9zd2l0Y2hfZ2V0X3JvbGUoaHNvdGct
PnJvbGVfc3cpOw0KPiArDQo+ICsJCWlmIChyb2xlID09IFVTQl9ST0xFX05PTkUpIHsNCj4gKwkJ
CWlmIChoc290Zy0+cm9sZV9zd19kZWZhdWx0X21vZGUgPT0gVVNCX0RSX01PREVfSE9TVCkNCj4g
KwkJCQlyb2xlID0gVVNCX1JPTEVfSE9TVDsNCj4gKwkJCWVsc2UgaWYgKGhzb3RnLT5yb2xlX3N3
X2RlZmF1bHRfbW9kZSA9PSBVU0JfRFJfTU9ERV9QRVJJUEhFUkFMKQ0KPiArCQkJCXJvbGUgPSBV
U0JfUk9MRV9ERVZJQ0U7DQo+ICsJCX0NCj4gKw0KPiArCQkvKiByZXN0b3JlIGxhc3Qgcm9sZSB0
aGF0IG1heSBoYXZlIGJlZW4gbG9zdCAqLw0KPiArCQlpZiAocm9sZSA9PSBVU0JfUk9MRV9IT1NU
KQ0KPiArCQkJZHdjMl9vdnJfYXZhbGlkKGhzb3RnLCB0cnVlKTsNCj4gKwkJZWxzZSBpZiAocm9s
ZSA9PSBVU0JfUk9MRV9ERVZJQ0UpDQo+ICsJCQlkd2MyX292cl9idmFsaWQoaHNvdGcsIHRydWUp
Ow0KPiArDQo+ICsJCWR3YzJfZm9yY2VfbW9kZShoc290Zywgcm9sZSA9PSBVU0JfUk9MRV9IT1NU
KTsNCj4gKw0KPiArCQlkZXZfZGJnKGhzb3RnLT5kZXYsICJyZXN1bWluZyAlcy1zZXNzaW9uIHZh
bGlkXG4iLA0KPiArCQkJcm9sZSA9PSBVU0JfUk9MRV9OT05FID8gIk5vIiA6DQo+ICsJCQlyb2xl
ID09IFVTQl9ST0xFX0hPU1QgPyAiQSIgOiAiQiIpOw0KPiArCX0NCj4gICANCj4gICAJaWYgKGhz
b3RnLT5yb2xlX3N3ICYmICFoc290Zy0+cGFyYW1zLmV4dGVybmFsX2lkX3Bpbl9jdGwpIHsNCj4g
ICAJCWdpbnRzdHMgPSBkd2MyX3JlYWRsKGhzb3RnLCBHSU5UU1RTKTsNCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdXNiL2R3YzIvcGxhdGZvcm0uYyBiL2RyaXZlcnMvdXNiL2R3YzIvcGxhdGZvcm0u
Yw0KPiBpbmRleCBjOGYxOGYzLi5lNmE3ZmMwIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9k
d2MyL3BsYXRmb3JtLmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMi9wbGF0Zm9ybS5jDQo+IEBA
IC03NDgsMTAgKzc0OCwxMiBAQCBzdGF0aWMgaW50IF9fbWF5YmVfdW51c2VkIGR3YzJfcmVzdW1l
KHN0cnVjdCBkZXZpY2UgKmRldikNCj4gICAJCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmR3YzIt
PmxvY2ssIGZsYWdzKTsNCj4gICAJfQ0KPiAgIA0KPiAtCS8qIE5lZWQgdG8gcmVzdG9yZSBGT1JD
RURFVk1PREUvRk9SQ0VIT1NUTU9ERSAqLw0KPiAtCWR3YzJfZm9yY2VfZHJfbW9kZShkd2MyKTsN
Cj4gLQ0KPiAtCWR3YzJfZHJkX3Jlc3VtZShkd2MyKTsNCj4gKwlpZiAoIWR3YzItPnJvbGVfc3cp
IHsNCj4gKwkJLyogTmVlZCB0byByZXN0b3JlIEZPUkNFREVWTU9ERS9GT1JDRUhPU1RNT0RFICov
DQo+ICsJCWR3YzJfZm9yY2VfZHJfbW9kZShkd2MyKTsNCj4gKwl9IGVsc2Ugew0KPiArCQlkd2My
X2RyZF9yZXN1bWUoZHdjMik7DQo+ICsJfQ0KPiAgIA0KPiAgIAlpZiAoZHdjMl9pc19kZXZpY2Vf
bW9kZShkd2MyKSkNCj4gICAJCXJldCA9IGR3YzJfaHNvdGdfcmVzdW1lKGR3YzIpOw0KDQo=
