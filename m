Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2177A47E3F4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 14:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348567AbhLWNGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 08:06:21 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:22610 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243507AbhLWNGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 08:06:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1640264780; x=1671800780;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=RV919MFILHILtq24CTdiq3rANCwpv5JM5PrZZsHz/2U=;
  b=nJ/AYnqueFKtR8Fy1Z771U05LektFc10ICmsWQUE6GsIQuKQsQcNM9S1
   EEp8KLjXFbPKUD22ATHAfBX2bQX2kme9JXz32ewsu/Sq7qI0YKqNtwVbs
   8QpsXQkiIhA0D6fkC5gqA1TDZbJFFGNsovKidooRwFIS8ybudModju/7V
   /G9hdqs69/rgHRth2LFW1eJoMKEwjaRamrMvltFOonMjJQ58BUQQKhwK4
   ZBS5kRH3m4JL914Pbha9wsKifvZHjLE7FGN8kQUON1GxhsS0e4ZpuVfm4
   7WcLZA/Cz8BYR0po7pQn7TtNWXoQB8IcCxX+e+O9iCVcyhhl7/8qwysoU
   w==;
IronPort-SDR: 5Z4T4+m0STinfBzDs+cgU8tMsWjFvxW3R9nrmzRh8/U1M0ysgdD+qIV0F3h3HYOVNTNTkyci3A
 09DNO3wHWcfMJ98DZ93xQkFObIh99mCtcINbsdRwBk3iRUkN+qPsLDIVeWNDn3kD7n1PDrxaW9
 iuqatbq3dTPwvlXtORX5sj13bay27r5JAML2v+ujBPnDHSij10tnNA5tRg+R1iKPGJyE3iymhL
 pemmhtvibqU707csw+fxPB3OQz2p+klqGJhvOkyB7Jbt2UVle/fA6BCONn5iqL5O0/7EAHrF2w
 FXSGrK6+nU9NQO2i3XJ1QoV1
X-IronPort-AV: E=Sophos;i="5.88,229,1635231600"; 
   d="scan'208";a="148177147"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Dec 2021 06:06:19 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 23 Dec 2021 06:06:19 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Thu, 23 Dec 2021 06:06:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DtpyomIXLDrAnbolqHhqCHKlnd8+V7+kFu4r/HZAzNEb65SmIOlmpfx4fIrcPDf1NC/3to0OSYaB5iAf+Si7s0q6zDk0SWi+UoG+D7KJDfuKNEp/Y6qSZA/2nMrVYK4DMdVOX+M4OFKJvYrMsJyTJ+Fwx1nGkdX2e+QTm3Fgkd6ksy3t0887oVgMwg5kslfs8Qf5ntqsovOT8W3gPwSzihgQXHy/aiDG11PPy179co70qj9snbF9iGrB5fnXHDERy2xZw+Dhv7sc3+m7zgDkvGXFoHJ9qYZ/wm+T/Cm/g0ZGzLSeGk6wAtOMNr/5HQ6e2akUbCJq/j9Nei5fXhfaPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RV919MFILHILtq24CTdiq3rANCwpv5JM5PrZZsHz/2U=;
 b=UxpiVDWuZAJe5bsNQ6j5QqcCcFSi2n8blMzrX7M/oXgplZzNLMxax3GeRKamI+AGUL2Dij7KnO4lSZCfMHRN3hrX56iTGMqHtCNb3rbCyYSqoDSRPtIRpor4BDcJ3GX3Uhtm8jB5nl2TW9PwA8/fL5Z2Eht8GUocEzAZRJrvj74YN0qDTH8Xm5W1HQ7nckFzuSnvEw8/3yl9fsZcy0SA27LNGaFDrYG/zmntg6hZw66vQBmDENp+yqnn9F4S3VIAhPA4Mc0w/KGNngnQ96MFxhGwjVZJwIfWqZGaNZMCE5O8xs900pw9ZIYmOokielTCJiGXYq3yZGMKXFTUCEDIjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RV919MFILHILtq24CTdiq3rANCwpv5JM5PrZZsHz/2U=;
 b=ZH/p5Fgg9Qefn+JxwnH3u5BX5UkLfOQ9PmXJt3J7o7ds2utScFbbL81F6zgpYig7/tIt2dSvWXP6LSFC7nJaxpv0e2s69jyLhCMZQAIUovI5i/74ecwl24h7QjvmY9zJIW3ZSIU6xaLh1x3KV5VyxmqOl96aX7OgKZkgyJbCY7A=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SA2PR11MB5161.namprd11.prod.outlook.com (2603:10b6:806:fa::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19; Thu, 23 Dec
 2021 13:06:14 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::5c96:23c3:4407:d3b1]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::5c96:23c3:4407:d3b1%9]) with mapi id 15.20.4801.024; Thu, 23 Dec 2021
 13:06:14 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <p.yadav@ti.com>, <michael@walle.cc>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>, <broonie@kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
Subject: Re: [PATCH v2 2/6] mtd: spi-nor: spansion: write 2 bytes when
 disabling Octal DTR mode
Thread-Topic: [PATCH v2 2/6] mtd: spi-nor: spansion: write 2 bytes when
 disabling Octal DTR mode
Thread-Index: AQHX9/3dZMPS/7j9wEKlAvg+zFmXJw==
Date:   Thu, 23 Dec 2021 13:06:14 +0000
Message-ID: <ec30ca85-5341-cd06-e007-c6c9aa24b0d1@microchip.com>
References: <20210531181757.19458-1-p.yadav@ti.com>
 <20210531181757.19458-3-p.yadav@ti.com>
In-Reply-To: <20210531181757.19458-3-p.yadav@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b8125b9d-a576-47d1-9d67-08d9c614ffc0
x-ms-traffictypediagnostic: SA2PR11MB5161:EE_
x-microsoft-antispam-prvs: <SA2PR11MB51619A6C23353CE9BA1791CAF07E9@SA2PR11MB5161.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iDkmoTQmJrFduvbySvpSKsUQVFmBqrPOh04Y+k+MjLAfAkmqWonAI5SDkbQjY6qbu/I9ebtQHfwoOU/wIGoZKdgnW/zB+k6e0orMUnNYyIvx0XZs9OOzFYWKzWvvrc5gbKBQggfsNdZ+vql6q9HbkF+8K2MLFjlBnmeZeTT58bAVdSMS5YKSnhNtfm7FNVh1JHb//R44gFUF5VbSYglcI7yyopV4SHsA2HT3lLPRh1OqckgccVcUzgp4z/3Iyhc8lEqkRMbNtp8mr3wK6AUs/0f+IDdP7PirXfgQVcZXTxIgR0vdD37Jq6uSKIl59CXNFAWL4UBQyJsajCMhSkEkdu03L1aVL6mf0HCAp4FEqeM3xHufr9tlL9kNv0dzZ7cNioLl23tmpxx4xMgNcUpuA/Yhxut7M8FO3PRqGs7MV41Fh13p8EurW0zav/nV8EVeivSiXSKzg84S2FN3n6LE76nN2/cT/2EG5XJvpnDNeLq6/3S4KMURttqazaVrhKZU8jpajdUUan230rtH/JoyYBDAMZdHnBEKV64kheC+jeDmZYUJj4SDu39LjHbkYKm7/l/EdQ3Bg8Nx/VczrefuNngSshz7ZOV44NO0GHzyPP5dgLmCE6nTTAJO4DYt6LX9n9QJ+a6Ckw7vsy2Y2uJO5wa8dJSUfxArmXTmAgaxjY6TmzkM0qY3Z1ye7XRWzpuCO+gDgAm4RAN/dD4w6K+U75j0R32mO5JGzkzQdj8j5mUf0MvsGYkEKmIwavbYU3iTnZ8VyRxSRRRvRYz+xVhzNw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6512007)(2906002)(508600001)(316002)(86362001)(83380400001)(71200400001)(31686004)(91956017)(110136005)(66556008)(36756003)(66476007)(76116006)(66446008)(64756008)(66946007)(2616005)(38070700005)(8676002)(5660300002)(31696002)(53546011)(6506007)(186003)(8936002)(38100700002)(26005)(6486002)(122000001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MUR5VjA2K0xWaXpKdXRpbk96ZGxzclozakpockdNSExzeXZGcEVnaituM2U1?=
 =?utf-8?B?bzYvRERmZEg0ak43WU83MEdyRks2NzBJemRWMmdneE1ORTlESy9uNFgxVzUx?=
 =?utf-8?B?YXpJMVhGaWVaVVMwYjkxNmpvRzRxYUhLY2lCTmNLYVNlVWxWZGFQWTUxdFRZ?=
 =?utf-8?B?OXpzeVAzRmpjc0ppSkVGY2UyUTM1M1J6cC95OFpkOW1XeEVrNlc2bEZtL2ll?=
 =?utf-8?B?b2FNWmJjTjNBMmF2MEJOa3RqRy9sSjZaRUJ3OW9JYWtEZE9tb3BrQTZJMUxZ?=
 =?utf-8?B?Z3N1anZXMHRJd1FNeXNnamxwRTJQR1RmY1ZLY2o3R1dJZFFOdjREKy9TZHhr?=
 =?utf-8?B?Z2JKOGVJNVpDdFI4YlQ0MEM5aVdWODRneFNETzlCUHRzVDZJY2xva1MzTFR1?=
 =?utf-8?B?bVdrZFBzQ1F2Z3dPbG1obGFVZ1RXZTYzRXU4UDRGY3hHOWo4Uk5TdEFXSDNm?=
 =?utf-8?B?T094bThFdHE0bEhLWmpHcWkyZmpoeTZ6dEpVWitXemlwaEFlSTNtZWtZZWNT?=
 =?utf-8?B?RllyTFc5SmlTSzhvRC9UbVJDTkZKSmxDTVZ1a25sVlNKUGpoRHdvOWdPQzNh?=
 =?utf-8?B?MVR6OHllMzJhTXVOUjZmZmMvTnFOU0FxSUkvK0lGL3Fqa2s2aE4wK1FmNGJE?=
 =?utf-8?B?cUV2cFN4QStxbXFES3R0MjNadTlpKzJ2WkRPR01aNFZQODBRdFowOUI0VFh4?=
 =?utf-8?B?bXVxRmxzQUh0dDVjU21MVG9sWmxDWE9HRDc5MXE0MGV6VTdackFNZ2xzcmtu?=
 =?utf-8?B?d3BheGdBSkR5SGt2RVF3aUNIcGdHYTBRM0J5WW5KQ2MreGNLRjRaclFrU0dr?=
 =?utf-8?B?ZlJrK3F5K0lQODV6dFJYZGFWOUFRcksvdnBYVmh1dWovSXl2bmczYTVZQUFk?=
 =?utf-8?B?bXRrSldGRlo0WDRFVDdLTDFzRTl6U0JPV0VPNklNOFZ2OEE2aHUwcG9zL01M?=
 =?utf-8?B?b2hUMXp0YjZia094MzJucFVtTGsreFZWcXZFNlAyZGo4bjBoWGYva015eWFL?=
 =?utf-8?B?QzRtVkw5bTUwN2NGTXMrZFpvWG9JY3BDMXU2dU1PcFhvSUtURlVsWmZJbEw1?=
 =?utf-8?B?TC82Mzh2VXJ3Vko3aWI5NUVIcUY5Z1IxNm4vKzBQa3dyZC8xeFRNM0IwRnNF?=
 =?utf-8?B?K0ZyNUd5UFFYYkhPajY1QnRGSC8xU1V6WHJXVTBvTnp4b0g4bUcwV2swRHJD?=
 =?utf-8?B?SzUveHJ2aUJkSCtSY2JNUzVweUxwU1cySlljWEl4bXdHUzFsYXhaT2xUUEtX?=
 =?utf-8?B?K1YyaU43ZHhSOVFoQjhzZFI5VjF4RmEwVXk0cm1XY0s1emROZ3VSc0RFS1ds?=
 =?utf-8?B?VklhdnlhRXFJSWJqUC9xNE9tSFhIRkduWGFUQmpTVFBXM1phcUpGZHJXYzgy?=
 =?utf-8?B?M25jVlNCbGxCeUFjYlBQaHJmbjZsKzVhNjdETlVCeEJVd3doSVhkZzJHSExJ?=
 =?utf-8?B?YkhGSmgwZWhLclJxK09yR2N0VGcrVzFtVEFwbStBMU5GZDBDUk5DYUI3QWxX?=
 =?utf-8?B?bzk1U0JwWElNZXBXajZXSWZ1MUUzV3ZtajdQOUNIcURVeXRRdGVOa25KbnpQ?=
 =?utf-8?B?TnJzQWxGd0k0c2hNVjU4RzQyU2RUMzdqWTFBTDlzUDJFd1d4aDEwTEZJeUtH?=
 =?utf-8?B?MmNLV0oxVE56a3lzZjl1MVFpM0gvUjJUL1pPSmtuTWlqdGhwbUFWeVI0U3BC?=
 =?utf-8?B?TUtqZ0JuaTNPRjRiYzJVVTB0QzFkVkhjUStxU20zc3p2bnZlRnRQNmp1Wkpk?=
 =?utf-8?B?WDJwZHRadnZabXdGcVhxeURxZFpQQmhrc2lvRUVKVVNsVGlHbm1oZUhMWE9j?=
 =?utf-8?B?aWNjS1VHNnYwOGdTVy9ZRC8rR0pDMm9TSThNZk41UkpUWm1pOUQxNlJzeFdx?=
 =?utf-8?B?TVpMOTZHUExNUllZTHpNd0hOYnpra0c4Q21DWDJPRGt4YkdFWHVlYXNYcldS?=
 =?utf-8?B?dUFXY1pjU1QvVVcyeHRDL21MZUFNVU9RQ3piNDNFdm1nZTFRMU8wWVBoRUhX?=
 =?utf-8?B?cnZoZ1NWNjFJNE1lOGZBWHl1N0lWWVpJclJEWkkzcStVYU0xMUhFSTFXK3NS?=
 =?utf-8?B?TXppTXFDdys1N09xa1hZZGtBMWphQzlpS095SHN4QnRnTmpLZVVHUlhyR0JI?=
 =?utf-8?B?cUlsMkFYMDJxSVkxMGdpdytROXFaaFJvcUV6a2I0bDlvNEh0c2ZMY1plUkxs?=
 =?utf-8?B?bXhQNjRWODNocm9EbTIyUkVwWURINU5PdlIrMEN6RGs0ZjM1THdIbnBKYWd6?=
 =?utf-8?B?dlNoN2JPS3VSdjhKNk81TXBlL0VRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6EA117AE388EA343AB32BF08B152FAC2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8125b9d-a576-47d1-9d67-08d9c614ffc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2021 13:06:14.0989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vKKAsolJvwb2nE8REkklcBvuzolnVfA8xbAWRh2RffrsSTA11iQ/9C9eGK73TEB7Nrr0DrvDarFzmQTxvcVL0KHuAxmk9Fskz/a+bDqk/Mo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5161
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNS8zMS8yMSA5OjE3IFBNLCBQcmF0eXVzaCBZYWRhdiB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBUaGUgT2N0YWwgRFRSIGNvbmZpZ3VyYXRpb24g
aXMgc3RvcmVkIGluIHRoZSBDRlI1ViByZWdpc3Rlci4gVGhpcw0KPiByZWdpc3RlciBpcyAxIGJ5
dGUgd2lkZS4gQnV0IDEgYnl0ZSBsb25nIHRyYW5zYWN0aW9ucyBhcmUgbm90IGFsbG93ZWQgaW4N
Cj4gOEQtOEQtOEQgbW9kZS4gU2luY2UgdGhlIG5leHQgYnl0ZSBhZGRyZXNzIGRvZXMgbm90IGNv
bnRhaW4gYW55DQo+IHJlZ2lzdGVyLCBpdCBpcyBzYWZlIHRvIHdyaXRlIGFueSB2YWx1ZSB0byBp
dC4gV3JpdGUgYSAwIHRvIGl0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUHJhdHl1c2ggWWFkYXYg
PHAueWFkYXZAdGkuY29tPg0KPiAtLS0NCj4gDQo+IChubyBjaGFuZ2VzIHNpbmNlIHYxKQ0KPiAN
Cj4gIGRyaXZlcnMvbXRkL3NwaS1ub3Ivc3BhbnNpb24uYyB8IDE4ICsrKysrKysrKysrKystLS0t
LQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvc3BpLW5vci9zcGFuc2lvbi5jIGIvZHJpdmVy
cy9tdGQvc3BpLW5vci9zcGFuc2lvbi5jDQo+IGluZGV4IGVlODJkY2Q3NTMxMC4uZTZiZjVjOWVl
ZTZhIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL210ZC9zcGktbm9yL3NwYW5zaW9uLmMNCj4gKysr
IGIvZHJpdmVycy9tdGQvc3BpLW5vci9zcGFuc2lvbi5jDQo+IEBAIC02NSwxMCArNjUsMTggQEAg
c3RhdGljIGludCBzcGlfbm9yX2N5cHJlc3Nfb2N0YWxfZHRyX2VuYWJsZShzdHJ1Y3Qgc3BpX25v
ciAqbm9yLCBib29sIGVuYWJsZSkNCj4gICAgICAgICBpZiAocmV0KQ0KPiAgICAgICAgICAgICAg
ICAgcmV0dXJuIHJldDsNCj4gDQo+IC0gICAgICAgaWYgKGVuYWJsZSkNCj4gLSAgICAgICAgICAg
ICAgICpidWYgPSBTUElOT1JfUkVHX0NZUFJFU1NfQ0ZSNVZfT0NUX0RUUl9FTjsNCj4gLSAgICAg
ICBlbHNlDQo+IC0gICAgICAgICAgICAgICAqYnVmID0gU1BJTk9SX1JFR19DWVBSRVNTX0NGUjVW
X09DVF9EVFJfRFM7DQo+ICsgICAgICAgaWYgKGVuYWJsZSkgew0KPiArICAgICAgICAgICAgICAg
YnVmWzBdID0gU1BJTk9SX1JFR19DWVBSRVNTX0NGUjVWX09DVF9EVFJfRU47DQo+ICsgICAgICAg
fSBlbHNlIHsNCj4gKyAgICAgICAgICAgICAgIC8qDQo+ICsgICAgICAgICAgICAgICAgKiBUaGUg
cmVnaXN0ZXIgaXMgMS1ieXRlIHdpZGUsIGJ1dCAxLWJ5dGUgdHJhbnNhY3Rpb25zIGFyZSBub3QN
Cj4gKyAgICAgICAgICAgICAgICAqIGFsbG93ZWQgaW4gOEQtOEQtOEQgbW9kZS4gU2luY2UgdGhl
cmUgaXMgbm8gcmVnaXN0ZXIgYXQgdGhlDQo+ICsgICAgICAgICAgICAgICAgKiBuZXh0IGxvY2F0
aW9uLCBqdXN0IGluaXRpYWxpemUgdGhlIHZhbHVlIHRvIDAgYW5kIGxldCB0aGUNCj4gKyAgICAg
ICAgICAgICAgICAqIHRyYW5zYWN0aW9uIGdvIG9uLg0KPiArICAgICAgICAgICAgICAgICovDQo+
ICsgICAgICAgICAgICAgICBidWZbMF0gPSBTUElOT1JfUkVHX0NZUFJFU1NfQ0ZSNVZfT0NUX0RU
Ul9EUzsNCj4gKyAgICAgICAgICAgICAgIGJ1ZlsxXSA9IDA7DQoNCmhvdyBhYm91dCB3cml0aW5n
IDB4ZmYgaW5zdGVhZD8NCg0KPiArICAgICAgIH0NCj4gDQo+ICAgICAgICAgb3AgPSAoc3RydWN0
IHNwaV9tZW1fb3ApDQo+ICAgICAgICAgICAgICAgICBTUElfTUVNX09QKFNQSV9NRU1fT1BfQ01E
KFNQSU5PUl9PUF9XUl9BTllfUkVHLCAxKSwNCj4gQEAgLTc2LDcgKzg0LDcgQEAgc3RhdGljIGlu
dCBzcGlfbm9yX2N5cHJlc3Nfb2N0YWxfZHRyX2VuYWJsZShzdHJ1Y3Qgc3BpX25vciAqbm9yLCBi
b29sIGVuYWJsZSkNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IFNQSU5PUl9SRUdfQ1lQUkVTU19DRlI1ViwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIDEpLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICBTUElfTUVN
X09QX05PX0RVTU1ZLA0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICBTUElfTUVNX09QX0RB
VEFfT1VUKDEsIGJ1ZiwgMSkpOw0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICBTUElfTUVN
X09QX0RBVEFfT1VUKGVuYWJsZSA/IDEgOiAyLCBidWYsIDEpKTsNCj4gDQo+ICAgICAgICAgaWYg
KCFlbmFibGUpDQo+ICAgICAgICAgICAgICAgICBzcGlfbm9yX3NwaW1lbV9zZXR1cF9vcChub3Is
ICZvcCwgU05PUl9QUk9UT184XzhfOF9EVFIpOw0KPiAtLQ0KPiAyLjMwLjANCj4gDQoNCg==
