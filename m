Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A852547E3F7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 14:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348573AbhLWNL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 08:11:56 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:37545 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348543AbhLWNLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 08:11:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1640265114; x=1671801114;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=LCu6qnPURvrDf+hymn/Qb8FwS7Qdv/il6FJhZgicC0o=;
  b=OPesccz7hVg/Yz0vYbzZT2J0A5cQtK4nCZaHmLNP/2o9uo+bVI5CkX/Z
   naTQAK8Xo0j5BdMlhjJVwD2Y713IYeAW2yA25GUmDww7rfpRlzUgD6OlI
   cht2HOmoAWzZayxCLK8MSebR1oM2sHQL7i5GkT37Vod0RyqxFxr7JHiXQ
   JaUEJ2i2bWQB1s8wPxRvoT4Z3p1wgzChzZoA1woTGV0MFwidCasB5DA1p
   zC/tP6XZP08vHAhSdWzDt7nZWOfyal+uxY309P7/IpdrOAMg0Kajr8Y/O
   FpAD3BI/Qfdc4289lHgx7cbaHKnZqmrPFksnguN447C5scPlQ/d/fhNT1
   w==;
IronPort-SDR: Ug4E9LA63PeqRRkI4XOibCHrx7H/Ys9uhzUGsxEKji0vOiLNNrb2Tg2nyzGp1o+LW6uKIHHi8M
 aKhM9p8Kx6DqU0nfmck31y2a7+myCPJrYr4OUczkxXbnmrA5DqBxPDI69yT4QNLxjv/YSjSxQA
 qAqZHiQ2j1PyWGyrBbxVuQMTEIkhuHXxLd8X+p8MPmY25UoYRAtnayej/ioQ/Ll/D0LZ1jIY9U
 zpDtMenZJZ/K/pU5lypuvk0YJf270ncXIAMFLBnIS8emZfGfvUROB1/MgmG1usv+2QvpvNSkbG
 ABfRCisFlv1WoU8sL8VsgTm1
X-IronPort-AV: E=Sophos;i="5.88,229,1635231600"; 
   d="scan'208";a="140710709"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Dec 2021 06:11:54 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 23 Dec 2021 06:11:53 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Thu, 23 Dec 2021 06:11:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cb0aiNwS+ZXmKnXXG+YKvjQyXQ7wgvJ8Wncv8Zm/BjG4Y9QlOkhZlJodPEYHNraa4B0BfCUq/lcDdjEMgHp6dRIVlgc8OJUTT8cjL0VSf9M93T1tJtsksoY6bgQMPOPQcdUso2V6wvxb6XQmQb7qCF5WBtEzvxv+ZLM/NDGcP+fHU2OJUi54tfqe3qeY+p5/ea8j7EpPHG2ns+Nv1KBJVvwalhd6Buz5gb7/p2/IrbHQ1v1ngZf2VBEtacMqyAf9Wg8BjSRS9Nj5IL3gqYu1dS/0YzD3Ib1GOKtzT2fgc1Q9ZsLst//dNCzbGjlL/6B1oS23jm4taHLl/3HO+32ySw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LCu6qnPURvrDf+hymn/Qb8FwS7Qdv/il6FJhZgicC0o=;
 b=RJe11+OSinVtX5v8Zcr4JAY0d2qcnRzpMXZBCF6hj49ZY28wh3dagdmjZ8dtvfoc1IBXfx9NWio0r8iwQnrZyWM8gBpFTZTse/YJJkpRKxxCY/7Ew8SkODY4/5k/QlUuTxjEstFXVfC5Z32HpHNUP77nulaYYCCswBUgZTiHSvDbT1Biexx0WSvma4VTUFoHEkvCgOtiutZQJf0Ya8qqz5qsArTEta83pB4uXcdtDmqJfUOwhsvUWzNLLzhLbAmid50f+UAym53qmxDjxtpyivb/PcUYf+9g4JueACVtaAlT6OG1m+1Ddi7QolhiEMxR6mTeLYTm5lNbL+7T/AqCvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LCu6qnPURvrDf+hymn/Qb8FwS7Qdv/il6FJhZgicC0o=;
 b=Nw4XgRxLPSyjpaxFT4rKpDudq+ken2W4eP8nqCIvwfDPyOS3N6hUYfTd8jh4iKKTD9BQE+vLgdoVUxGa7vXJ4zuPzQvRUIt3WIJRLGh52YICHmCwfgxN+/lbXOfZCR0h897L/1vVpmwCejc/9gVwywzd2v3Xp5FV7FAbp++dYnk=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SN6PR11MB2943.namprd11.prod.outlook.com (2603:10b6:805:d3::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Thu, 23 Dec
 2021 13:11:51 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::5c96:23c3:4407:d3b1]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::5c96:23c3:4407:d3b1%9]) with mapi id 15.20.4801.024; Thu, 23 Dec 2021
 13:11:51 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <p.yadav@ti.com>, <michael@walle.cc>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>, <broonie@kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
Subject: Re: [PATCH v2 2/6] mtd: spi-nor: spansion: write 2 bytes when
 disabling Octal DTR mode
Thread-Topic: [PATCH v2 2/6] mtd: spi-nor: spansion: write 2 bytes when
 disabling Octal DTR mode
Thread-Index: AQHX9/3dZMPS/7j9wEKlAvg+zFmXJ6xADU8A
Date:   Thu, 23 Dec 2021 13:11:51 +0000
Message-ID: <d211abea-0a4f-d23e-45fa-319d7aebe52d@microchip.com>
References: <20210531181757.19458-1-p.yadav@ti.com>
 <20210531181757.19458-3-p.yadav@ti.com>
 <ec30ca85-5341-cd06-e007-c6c9aa24b0d1@microchip.com>
In-Reply-To: <ec30ca85-5341-cd06-e007-c6c9aa24b0d1@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 575701b2-de69-457f-a67d-08d9c615c8c1
x-ms-traffictypediagnostic: SN6PR11MB2943:EE_
x-microsoft-antispam-prvs: <SN6PR11MB294386A156E90D11BA89ADB3F07E9@SN6PR11MB2943.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F2rQJZXoelPFjxqPli6KIqoLNaWloOnkFCRRKoJ8tI3OUobOWofpafmTwiBczkt3sTOjektKz/MG6I+6VT24axvh04ESBkJej3kHKAM2tEQJm3vhXDvUuquXzsQLKyXHLmpVNm0qmAi14l3/9eGlyT4ThkXtkXL4x/iUmdy7JPFf6JM+hjx9lzM8FbAeBwf9wbIMZIBeeBuQMIs6Nt8lFahX11Wjm3X5bmytLULlcReUV7v7vjuYh76Tk+CoSBI0ESq4Wty3V24H71GJvvXcCUK528odGvT8/MGQJGFmQ0FOLrlF9o6hRa3eMcXLDhPWjWpqcc+qJF+LIXE+J4W/lMQM4MTyi0cLrTjS1P3aIl6ZTFhCwH2ysN44g8p52eHn6ZWr7x05loqRCAcELBzOZGjkAP9PyLQKmcAInoYz98YnKkECKt340i5JHiJpJkvAM3FUNmNUPJIXtGNc9PqNTVdwpYsEfc4YxcScZFUddHf724okgRCO//HaJ0AtYGzhdSxEuE80NtAIl6EgQzoeKNiIV6BZVvy2EaxDl/YW/NtYbfxnw8MGSw4tZ/VNRus1ONMCtpPeQWb3IluUAeLmoIZP8hlteZ+hGjyi8CDJO1UPPi153yOTT5lh4x/MZyacOf5CrVqrPNlpIGjM7y01ZnuJONIvx79xWcEAeWch9Nmm8i5rCY9MV0lHVEw1f2NP9h6yxLTTm6UvYUmawC2DxgO8OOyW6FifkZ7RDCQD5TDGe/0XpL11WPh8GurE9R1G1H/zcHPXg//l/I56+IbOjw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38100700002)(8936002)(91956017)(66446008)(64756008)(2616005)(8676002)(66476007)(66556008)(6512007)(110136005)(31686004)(316002)(31696002)(2906002)(76116006)(38070700005)(66946007)(508600001)(6486002)(83380400001)(36756003)(5660300002)(186003)(86362001)(71200400001)(122000001)(53546011)(6506007)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SXQxSldkQmhJZUNWRnJ2dUoxY3IrV3gySStqQ0lVeDBUVTV3M1RYSGhaTEhi?=
 =?utf-8?B?N1N0WmlYaTNVNGhIdi9mYmExQkxxeGszMFZwVjFaMC9zNmRzdU5SSmpoalcy?=
 =?utf-8?B?cjJWQjhLcmlNWkNlcFg4Q3QwZXNESEFQdHhoTEEvanY3VnFsbmRRT1FNSU0x?=
 =?utf-8?B?ekYycUkzTmg2VVB3OTk5QWNLZHU5eUo5WWJKdVprVnA3VnM2RkFXTXdXcThj?=
 =?utf-8?B?UGVJRTd2QmJPTVhxVTBWbE10VXUwZ2NTWHkrdk9jWlN4Q1IxWnZ1MEhUbkxm?=
 =?utf-8?B?YTgvNWxEMFphZmdJbnlndlhRQWVzcmtDSHo4NnkzRmxtU3dldjNFRFVWaWJS?=
 =?utf-8?B?RlJTQXlnL3JXT1U5M2IwbytkQzFGTVpEZzAwY0dZbFdIamNOOG82Z3hBY00x?=
 =?utf-8?B?dzdMTUpZSC9MeU9TSlk5RzhSd1RpamMrUTZxMm9vMzcvL24zN1VqdG14Tk1h?=
 =?utf-8?B?NDY3b3ZVS21ETjY3MVpibld3RUtFcU9RSDNwZzBpMzdEQ2tmVzcwclRhQVNt?=
 =?utf-8?B?bnhzclRqMER3aXV5bzV6QjhZTHE5WkNVUys1T0VUT3oySFpOSmlGTjYzZEZY?=
 =?utf-8?B?WkRFVWpCOUZVSEhJeEYyM2dEeWVOT0s3NGlha1ZHV05UbitLcllGMFNKL0c0?=
 =?utf-8?B?aGd2RStXTEpHN0ZURHBIZGhqbjJnbTFFVVF1NUhvdFMrQU5CVVV2V2hhQmZl?=
 =?utf-8?B?dVhEekd4RXlHRTFnV1J4OE1GN01DM2c5NDlyQXh2emVTTHBCNXRiNzQ4RjlD?=
 =?utf-8?B?cGxnd3RUMWN5MytBMElMbE0xTG5uU3dSYlcvcFN6S3RHZm1nanQ2MHNpSVJw?=
 =?utf-8?B?L3hXM3NqT2Y4QTB5eTd6cW9zWkMwOXZuajRjcU9HME42YTBGWXZGSkNOZUY4?=
 =?utf-8?B?S3ltcVIwOXJIT20xMXBlZTZuSVFwUmxrb21rbFdHbzZsLzFqU1UxeWx2amRs?=
 =?utf-8?B?T1NxeWc2aFdNV21yd0tzeVBSVGl4OWZyNElhKzgwMHFyWEhRMEtuVm1YRDE2?=
 =?utf-8?B?Q0lMSzI1cnpYdHFXN002MGYveDRJK3Z2V1BHYkN0enRvUWdsek1CWWI4OFZO?=
 =?utf-8?B?dWZCREF1Q0gya2VQZytheUtNaVVYaUI3V1hRZnZKNTdXYWgzaXF1Vi9wMEZx?=
 =?utf-8?B?aUxUNnZxVEtwdG0rVTlvSHpCZjBlSXEvY0NhNGo5c2ttbkpJUWJnS2lmWUx1?=
 =?utf-8?B?OU4yZk0zNzR1cFk3aUFxakY3clpua3Y4anQvV2R1am9Wb2RxOWdRaW1NaHo1?=
 =?utf-8?B?ZWliOCtZejlhOVlGbkhjRkZOUVhLR3VwdStQakh2c0c1ejdaV2p0eXl6ZXZ1?=
 =?utf-8?B?YUhlVS9DdWgwcm5RUE93UklISTN6UjRJKzNFbTdZanhaRGlqb29RZGdBQkpa?=
 =?utf-8?B?cGhLc2JRbEgxeVVqMlVwVUlab3ZYbFRSWk9sUFpNMjA5TEo4V0NJUFVKL2V5?=
 =?utf-8?B?NHIxakRETThmL3lBRFd5cC9hWDA4QlJKdkptV0hWdldHSm5HUGozUTVQZTJG?=
 =?utf-8?B?akdhbzFpc1VGQkZKeWVwSXIrV2c2Vk56RE9tY1FvcldVT2lYMUJIQ0s0Y2Vo?=
 =?utf-8?B?d2RCOCs0WkZHeHp1djhpL1M3cDFlRllhSms0bXA3SUZLbmVMbFJpTlZuRkFY?=
 =?utf-8?B?N3RDMERNZTZ0SUtjZ3NNbHp0OUlobEgrRWtXZ1RHd29pR240ZTNaVGRqS1M2?=
 =?utf-8?B?RzAzMktseTNCN1BNckZRelBtUGg4YWlRZVQvUHkyTlRrQTlPMXlONVE5MWVm?=
 =?utf-8?B?K0tUK2dpT1lzb01GalVQc05NZE93ejBPNkdEdTVmRUIwUDZwVlM1MkF2MEZ3?=
 =?utf-8?B?LzRqN3JiTGlUUG1zZkkwVVpicUJwcy9QNWtoRlpmS0VsUmhQMXJTQThzV2RI?=
 =?utf-8?B?OVpnQjNvbmxqMXBTdmwwUG90QkUzcm05VDVmWEt1aW45cU1DRFBRdFFVQVJk?=
 =?utf-8?B?T09ZMXJKUUFxbjJpRVQycWlZY05MVWtKWHNCQmtDK1QrVmcvSkhiQ2wxVDcy?=
 =?utf-8?B?ZkdMVjAyU2FNcGpPQkgrby9kQzk5YlRPOXY1UVZlTWUwc2VvZGtwZGkrZi9u?=
 =?utf-8?B?ZTUxYjlrVERSZjA3NDJsREFybUx0L25nV1JsVWk5SVN5NSs2VW1CNitvenVK?=
 =?utf-8?B?M2FhOG03S1l4MzNKUkRvOWRVOHk2bmhiZXh4N2lTZFY1bWYzbFpKYm1UVkty?=
 =?utf-8?B?aGMrZ2dRampvSzhBWUpPMjk3akkwajNlL3lOeEV0eHBuODhFby9tOXRCczQx?=
 =?utf-8?B?Z08yS2ZkNTg1RmdENGMwL2wzWFVRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <98EE2BB807AAB946A46FAB9EE4B1DB5E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 575701b2-de69-457f-a67d-08d9c615c8c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2021 13:11:51.2839
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 80GY8HXV++BLittrSNAjTe8jlmnDlIgayPBf1/Cpvf3dvuMu7feGF8hi0OANhO4kfd4K8uJJYK/Hx8skZ/syrjyKh7iP6zcZJcxylCj9B/g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2943
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIvMjMvMjEgMzowNiBQTSwgVHVkb3IgQW1iYXJ1cyB3cm90ZToNCj4gT24gNS8zMS8yMSA5
OjE3IFBNLCBQcmF0eXVzaCBZYWRhdiB3cm90ZToNCj4+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3Qg
Y2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cgdGhlIGNvbnRl
bnQgaXMgc2FmZQ0KPj4NCj4+IFRoZSBPY3RhbCBEVFIgY29uZmlndXJhdGlvbiBpcyBzdG9yZWQg
aW4gdGhlIENGUjVWIHJlZ2lzdGVyLiBUaGlzDQo+PiByZWdpc3RlciBpcyAxIGJ5dGUgd2lkZS4g
QnV0IDEgYnl0ZSBsb25nIHRyYW5zYWN0aW9ucyBhcmUgbm90IGFsbG93ZWQgaW4NCj4+IDhELThE
LThEIG1vZGUuIFNpbmNlIHRoZSBuZXh0IGJ5dGUgYWRkcmVzcyBkb2VzIG5vdCBjb250YWluIGFu
eQ0KPj4gcmVnaXN0ZXIsIGl0IGlzIHNhZmUgdG8gd3JpdGUgYW55IHZhbHVlIHRvIGl0LiBXcml0
ZSBhIDAgdG8gaXQuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogUHJhdHl1c2ggWWFkYXYgPHAueWFk
YXZAdGkuY29tPg0KPj4gLS0tDQo+Pg0KPj4gKG5vIGNoYW5nZXMgc2luY2UgdjEpDQo+Pg0KPj4g
IGRyaXZlcnMvbXRkL3NwaS1ub3Ivc3BhbnNpb24uYyB8IDE4ICsrKysrKysrKysrKystLS0tLQ0K
Pj4gIDEgZmlsZSBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPj4N
Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9zcGktbm9yL3NwYW5zaW9uLmMgYi9kcml2ZXJz
L210ZC9zcGktbm9yL3NwYW5zaW9uLmMNCj4+IGluZGV4IGVlODJkY2Q3NTMxMC4uZTZiZjVjOWVl
ZTZhIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9tdGQvc3BpLW5vci9zcGFuc2lvbi5jDQo+PiAr
KysgYi9kcml2ZXJzL210ZC9zcGktbm9yL3NwYW5zaW9uLmMNCj4+IEBAIC02NSwxMCArNjUsMTgg
QEAgc3RhdGljIGludCBzcGlfbm9yX2N5cHJlc3Nfb2N0YWxfZHRyX2VuYWJsZShzdHJ1Y3Qgc3Bp
X25vciAqbm9yLCBib29sIGVuYWJsZSkNCj4+ICAgICAgICAgaWYgKHJldCkNCj4+ICAgICAgICAg
ICAgICAgICByZXR1cm4gcmV0Ow0KPj4NCj4+IC0gICAgICAgaWYgKGVuYWJsZSkNCj4+IC0gICAg
ICAgICAgICAgICAqYnVmID0gU1BJTk9SX1JFR19DWVBSRVNTX0NGUjVWX09DVF9EVFJfRU47DQo+
PiAtICAgICAgIGVsc2UNCj4+IC0gICAgICAgICAgICAgICAqYnVmID0gU1BJTk9SX1JFR19DWVBS
RVNTX0NGUjVWX09DVF9EVFJfRFM7DQo+PiArICAgICAgIGlmIChlbmFibGUpIHsNCj4+ICsgICAg
ICAgICAgICAgICBidWZbMF0gPSBTUElOT1JfUkVHX0NZUFJFU1NfQ0ZSNVZfT0NUX0RUUl9FTjsN
Cj4+ICsgICAgICAgfSBlbHNlIHsNCj4+ICsgICAgICAgICAgICAgICAvKg0KPj4gKyAgICAgICAg
ICAgICAgICAqIFRoZSByZWdpc3RlciBpcyAxLWJ5dGUgd2lkZSwgYnV0IDEtYnl0ZSB0cmFuc2Fj
dGlvbnMgYXJlIG5vdA0KPj4gKyAgICAgICAgICAgICAgICAqIGFsbG93ZWQgaW4gOEQtOEQtOEQg
bW9kZS4gU2luY2UgdGhlcmUgaXMgbm8gcmVnaXN0ZXIgYXQgdGhlDQo+PiArICAgICAgICAgICAg
ICAgICogbmV4dCBsb2NhdGlvbiwganVzdCBpbml0aWFsaXplIHRoZSB2YWx1ZSB0byAwIGFuZCBs
ZXQgdGhlDQo+PiArICAgICAgICAgICAgICAgICogdHJhbnNhY3Rpb24gZ28gb24uDQo+PiArICAg
ICAgICAgICAgICAgICovDQo+PiArICAgICAgICAgICAgICAgYnVmWzBdID0gU1BJTk9SX1JFR19D
WVBSRVNTX0NGUjVWX09DVF9EVFJfRFM7DQo+PiArICAgICAgICAgICAgICAgYnVmWzFdID0gMDsN
Cj4gDQo+IGhvdyBhYm91dCB3cml0aW5nIDB4ZmYgaW5zdGVhZD8NCg0KcGF0Y2hlcyAxLCAyIGFu
ZCAzIGxvb2sgZmluZSwgZXhjZXB0IGZvciB0aGlzIGNvbW1lbnQuIFdvdWxkIHlvdSByZXNlbmQg
dGhlbSwgb3IgeW91IHdhbnQNCm1lIHRvIGRvIHRoZSBjaGFuZ2UgbG9jYWxseSB3aGVuIGFwcGx5
aW5nPyBTZW5kIG1lIGFuIHVwZGF0ZWQgY29tbWVudCBpZiBzby4NCj4gDQo+PiArICAgICAgIH0N
Cj4+DQo+PiAgICAgICAgIG9wID0gKHN0cnVjdCBzcGlfbWVtX29wKQ0KPj4gICAgICAgICAgICAg
ICAgIFNQSV9NRU1fT1AoU1BJX01FTV9PUF9DTUQoU1BJTk9SX09QX1dSX0FOWV9SRUcsIDEpLA0K
Pj4gQEAgLTc2LDcgKzg0LDcgQEAgc3RhdGljIGludCBzcGlfbm9yX2N5cHJlc3Nfb2N0YWxfZHRy
X2VuYWJsZShzdHJ1Y3Qgc3BpX25vciAqbm9yLCBib29sIGVuYWJsZSkNCj4+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBTUElOT1JfUkVHX0NZUFJFU1NfQ0ZSNVYs
DQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMSksDQo+PiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBTUElfTUVNX09QX05PX0RVTU1ZLA0KPj4gLSAgICAg
ICAgICAgICAgICAgICAgICAgICAgU1BJX01FTV9PUF9EQVRBX09VVCgxLCBidWYsIDEpKTsNCj4+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgIFNQSV9NRU1fT1BfREFUQV9PVVQoZW5hYmxlID8g
MSA6IDIsIGJ1ZiwgMSkpOw0KPj4NCj4+ICAgICAgICAgaWYgKCFlbmFibGUpDQo+PiAgICAgICAg
ICAgICAgICAgc3BpX25vcl9zcGltZW1fc2V0dXBfb3Aobm9yLCAmb3AsIFNOT1JfUFJPVE9fOF84
XzhfRFRSKTsNCj4+IC0tDQo+PiAyLjMwLjANCj4+DQo+IA0KDQo=
