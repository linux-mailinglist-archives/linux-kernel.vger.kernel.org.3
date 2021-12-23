Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A536047E440
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 14:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348710AbhLWNy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 08:54:58 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:48836 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348462AbhLWNy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 08:54:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1640267696; x=1671803696;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=AUkAq/+fR8OPb/2TNSpjxin8jaNH9llhvp0UxGQFtzw=;
  b=QL5pLIXjz017lewhQb4ndElzvzK5j+49fhSDLlFFHbxbPL2tGx7dWoBg
   TYR0iPkh4RredCQiqOBvxn8Ba1Ur9Ou6iK7ML0eMZsmqqdbvAeo5ARG2N
   a53WTxnpDB+v68ABfIV4TiJbccckdXqLRcUn5vCLxFOr4AUAaBSLAXrDx
   SnLU87IOnl9NSYW+P2e/uxC1CR9TJgVLvMKqS2CTNTUtUoXBPFBy5SN5E
   ZqiaQVEbU+V9ZaDobQn/I2tDWYGHkkoClj5Tfyr4KAcAs8/1euUnbZeCp
   unXTNkVbHrag/3qkOhH3/8T8vbrRPQt/v74IQi90jSLk7drwRNU+xajc6
   A==;
IronPort-SDR: aEqVwiLxT4LzSsslCMFsC9PX6gJ7iXZaePjW9FEgE9gtFe/Wos2Z7dCXntlO8jnQMIJWesTMQD
 4qiKUwIJhCMNSWszcG6arIsj6Ghmlq6CMufFdpPtMYQQh7hdWs352LR/tTkgg44KI6XJ+5pT0Q
 ekaEcbzeSBKUSBxFMZ1xESjltke9f/yaJd97isVfff9K1FCFMQ3xrX6ix0XRTzeKEFOjjAs3V2
 Z6PTElztgB+Y473rvTz3VCjIFhlC5+JGq0mDegSTB18ra58OstYHPmjg9tk8UBCEdBAhgS0X1z
 8SkZ609IO/qpaHhdKmUSQDKP
X-IronPort-AV: E=Sophos;i="5.88,229,1635231600"; 
   d="scan'208";a="140713017"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Dec 2021 06:54:56 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 23 Dec 2021 06:54:56 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Thu, 23 Dec 2021 06:54:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mElGdFTbNk3Im8AvnK6fwbFe6wrcC40Yht4YoZRMEnM1VXJtwwoi2+ugoyZBB/Qq7k0TiNCVJeLpBFQjKC9t6LixxXqUkYECEBSp15SdOlrg0SnboPouuAiSvRxX2kEqdE8a8T7z0KZ+HLiHNPKLB64H7K90Ui5k2kUMLaEaXWYqUENdk7jtRb2I7uQ4rj3vFSBvzfIsLaSNtQsazKNlYJX2bTxDp3Bu7mRPypjxiPAsf1mZKBpV6P4lkyfmVXmQISNPZ1rBVolf2yHX6D1L56MzlVNZ1PYKjAXDabuJlSHsjP9RsTXKNsm/sXISM/ZhXiSw8e1C1CMsKyl4SRo9nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AUkAq/+fR8OPb/2TNSpjxin8jaNH9llhvp0UxGQFtzw=;
 b=oRhslVq8lVfwHOQGL7YNEVkMgrGw+G6w/mMNcDgHquyLXujJlp9+4qpGT9qg07iJlxMdMm7jFVAISMdpQLMHNg2Usf5S54BZB1XPwhkzm3N6TP6WmQijcVqEWH9fZ3lsHkX0wA1mlFzrr4Xpg0pfku/b6c7y+oEOCBcPWQJH7+dbPHkjTfvUIfY6VaO3xSyuwjViqAJwr/Ic5O9965xMrDizpfDqL0vGFcQN4H2Hze54D0Gy95hlM9Xa6EcN8dLIUgC7HOCZc14ZBc2CC0Gat6Ybz7VAcQhMB6obGIx/5EbkU3petrQEONdv0p2pOMcsdKZmjxwLlvMOuN0mogEKPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AUkAq/+fR8OPb/2TNSpjxin8jaNH9llhvp0UxGQFtzw=;
 b=ccnL2R8ar/UNlQkLfyjPBDeAbgzDBgqk7Q9GxiBmYYU9h+TEaYVvIT+zJiGI/ZUPy+e0eiibsnMsw4cWnqgpTsN6PTpFWSLtWIJGLkymYk34yEtQVI4bF80Y/mogexG0oqyi+QsnCu9+smQSlY2gZIN+rE5BceWJgqqr/MI1phA=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SA2PR11MB4954.namprd11.prod.outlook.com (2603:10b6:806:11b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19; Thu, 23 Dec
 2021 13:54:54 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::5c96:23c3:4407:d3b1]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::5c96:23c3:4407:d3b1%9]) with mapi id 15.20.4801.024; Thu, 23 Dec 2021
 13:54:54 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <broonie@kernel.org>
CC:     <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] spi: atmel-quadspi: Add support for sama7g5 QSPI
Thread-Topic: [PATCH] spi: atmel-quadspi: Add support for sama7g5 QSPI
Thread-Index: AQHX+ASpZ3I+NNYirk6v/0Mnlw4qWw==
Date:   Thu, 23 Dec 2021 13:54:54 +0000
Message-ID: <795260b0-71d3-bfd8-4a00-9b9880c11767@microchip.com>
References: <20211214133404.121739-1-tudor.ambarus@microchip.com>
In-Reply-To: <20211214133404.121739-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 75b8e108-d8be-473b-6149-08d9c61bcc64
x-ms-traffictypediagnostic: SA2PR11MB4954:EE_
x-microsoft-antispam-prvs: <SA2PR11MB4954C27267DD7BF15527A766F07E9@SA2PR11MB4954.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z5ciarJZ5R7LXnG7M+BiBAU7jn0edbry1lIBo8ERlGIVXfpjlLPKLxfekVxD4aFGe9UwIwpRFgatSFOQpG8rsB7bEUFaYdu/bd7muLyufzbod0L2dcZui3BwZlvH8OmyL27/QjMIAk1i2ic6VFwNXSeTHFg2kbnuVDppUpfvBkIrI4K7/2qRYO8zkHTsj+anFf96LEj2b93rkTiOquV1Tb3EK5rcZRlEzaaNc7uTIv7LCc9UTsX8paXARfL2PcIvuWMKoIkQk0/nuVU3O2BIzHaZNk9IyZoZGnJ9FAnj2RMoVlORk2I6MfwvKMMDBR/oM1AN7fYwi6Xgz0VIDwHxoNo9hKqACBHCo2nGR5nLpviZaoauG+AQssVbogmo3x34bs9WUGLBini3tLYFLRLX/WCWG90Qsqown6M/PiCjz8/DEPZ81Xxi1PlL/s3cGzHcECLMB0x7uhBqxtApkyQAg7nUXNVGDR3OMJLbMSEXUb3SyU2NTghFnLeNJSJckm7cseSK5BNYG1czY413ZQMv/77rU3sXlVODB8PPE7p92QIrctP3xJvlbeWd1TVhwCRjrTTeNTjg/OU+Du2/sn/fE3snEuuBuOcPvmJttqrS8TnHkIfYs11cdddmYBcDADboY+lipEA0NBYnCXtEA5ZcO8CbUWVnCs9pxP9qp/zZ5anX7f5jLausPxsR93Lc8maTjZqQ544uxR6fMmZNZJ+f1AmFW4aYaOKLW20OWXYWNwGr51Eh42OrnfioqE2erFSD+fH3AD1Dte78se6MfToC5Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(83380400001)(38100700002)(4326008)(31686004)(2906002)(26005)(36756003)(122000001)(6506007)(6512007)(53546011)(8676002)(6916009)(186003)(71200400001)(8936002)(2616005)(316002)(66446008)(6486002)(31696002)(66946007)(38070700005)(86362001)(76116006)(91956017)(66556008)(508600001)(54906003)(64756008)(5660300002)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c0ZkMGhOVUxZNkZhMURjREEvWG5wemViVXFlK3hrYjFheWlRazh4Y1JpWkZE?=
 =?utf-8?B?QnFkb1FBbmM3cDgxU0owUWNVWFNGVG56a0Y2T1JSWUxLQmh2WDlQQXNMR2o2?=
 =?utf-8?B?d2I3bUFmN2d1Z2dmaTZUcmJlWFVmbFJiOHZCZUNVZHJ1ZjBmY2dnaDNLUXVp?=
 =?utf-8?B?Y2o3bDcrZDlxdjlxTlI2emtBU0pITFMybCtpNDJTLzRPdUJXcEJPaloxUGY4?=
 =?utf-8?B?NGNLRklwcEU3YkRRU09qeGVhZEFLZjNTMmZsODJrYVVTUVY2R0MyczhnMGtL?=
 =?utf-8?B?blFXUitYeDNvYlEwcVhDTjlmWTNqd3g3eDFXekFGMGRzVTJkRVZpRlZkVzVV?=
 =?utf-8?B?eVBSamY1d1FiVHJ5RG5sNEM0UGF6ODZidFBPS1ZTYm0xV2d2ZVFmbUxGZTVB?=
 =?utf-8?B?ZlR0QW1kZ1B4eGNCNUZYbElyaHJ2MnpLTlpkc0pvYmtlMkFUMDYzOTFzbXVV?=
 =?utf-8?B?TFEyUW1SNDhHV2NmaU9KVHJTYnU3RHBBU2NrVk9pYURMalUxcXZFVDNGMnFt?=
 =?utf-8?B?WUJOWlF5ZkRxMDN5ejJBbWZ2Y0ltcDdJV2l3aXhlVEhBQXE1Q2N5aHR2b1Jq?=
 =?utf-8?B?Sy8vNUFiZ0E3bThNUEZDRXRTbWdHa2hweEVKTGhROWI5TGx4SG4rYm9EUzAw?=
 =?utf-8?B?OXZUdDlnWWlxaStmQklKWnhMR2FQRlVZZ3hxemRuOXFicHBoOW9OdTR5ZWZp?=
 =?utf-8?B?Q0VTRlpQbXByRFN3emUyayt6UDZWYTNMb21hdWtJSnVxdXVoZEg3SFp6Y1hK?=
 =?utf-8?B?Y1RkdGoySDVXZEVNQS9Fd1NjRzdGK0E3bTdWZVQySklGeEtpQnZGK3dwR2x3?=
 =?utf-8?B?YXBuMm5YV1NqeHZIcmdVVzlSek5aQ2tycjE3TGtKR0lsME5ab29rRXYzSmpP?=
 =?utf-8?B?OXdFb3JjY1JrTENCRmJKN1MxRUxTQk9POWwwREF4UkpYdyttTWJyN0tyeExp?=
 =?utf-8?B?bzZNVURhK3QvY0FiNFQvWWxlRnlKbVd5SjNFd2dyMDF4WG04Z2t4NnJsczNH?=
 =?utf-8?B?ajV2aHlOMXpGM2tCQkJNaUNKdkNBZnNFM0JrdnE3cmRGTmVFN3RCSzhTVCtC?=
 =?utf-8?B?Z3c2K3dDYkc2RG1PeTN1N0Z6YTQ4dEcwOXgxaUozRU9TZGVzbS96ejZMclk4?=
 =?utf-8?B?cmdtdFhiRWI4dDlmTysrZmlvaEpTbUxqYkNxSkNGa3ZINkxVd2hTQU1TS2xY?=
 =?utf-8?B?dHltSThqeGRwNzhLa05MdFBXNDRqT1FZUWFHY2ZyajZpd1poRUd5ZmFDWWlN?=
 =?utf-8?B?Zk5DeUIzbWVoQk9XZjFhL3l1cnUwQ2NseEo2N05NdS9YVk83bjhoVVFwTVc3?=
 =?utf-8?B?VnN5TWJkUWUzOGFoUCs1cWpsNkhmY3lubVIxWVM4cmZ4L2U2MlcySnpMQmE4?=
 =?utf-8?B?L1hWa2dkeUpQcXhlSVp2SHVsN3NLRGhyRUtMbkNlZzlSZ1h6TmV4cThHcXJR?=
 =?utf-8?B?Q1MzSXNURW9rUDQxVVRBTnBpN0FsNzdzMFgzalJRK3VIRzhVM1JkdzRnNzJR?=
 =?utf-8?B?YjZPL25PbU51S1JmWE14MS96ZEZNY0N4aFk1RkE0Zm9PVndXNlIzcmhHUFF1?=
 =?utf-8?B?TkE0Q3J2dVVxQUlnMzVvaVBDSkpEQThWeVBZczZmTnZEd21qZ0ZZb1FYZXNm?=
 =?utf-8?B?V1I3UTFqakV3ZjNuUzV3ZzVVS3BOeEJDajlIdlVUbGlabktvQ1BxMndCb0Vm?=
 =?utf-8?B?d2xvSm5aZk1qbGhlang3MEROcjRqeHJDeWkzcUtaREEvb2hiYzFSSzI3OVhD?=
 =?utf-8?B?a0hUd1RmeVQyVUFZam9QMjN2SG1RZTBOaEhyd1JOaTh5Q0tSc1BXL0NPWitU?=
 =?utf-8?B?Y1FXaUNYTUNuU0VGNE1CbmJTcjRYd2FuTGlpQVJWSnpNdWxReUxrc2NBclh2?=
 =?utf-8?B?VVRoLy9QNEhSTjVLV1NLNldvMVZhb1M2YllNV3k5NENMUG5FazdJeVFRWm1m?=
 =?utf-8?B?cTNySU9kSTkyaEJPc0tJRm1GblNzNTFFYzF4eU9WaUhKUnRsRFZIT0JOaU8z?=
 =?utf-8?B?LzZMUS9YRDRobWpjUGxrZ3NLYXNTRGZncVRKVTc0cjAwTWZhWlRLcjZuTkhz?=
 =?utf-8?B?M2FVSVhzUDJZRFozMHc3RzA2UnlPaXV1cWxPRytONnlKbHFkL1BPcTVMV05a?=
 =?utf-8?B?V1lodnBJWElDSkxidWJTaFdidTdtekhpVUVZRFdETjY5Z0pZSVlaMGRsSnl4?=
 =?utf-8?B?cWRzOE1HZmZIdmNXTnFHRnFJM0VNK3NYbW02UWpVbmNCcFFaUUwxeFRlYU40?=
 =?utf-8?B?ZmlqRUYxMTdFbXRZc21jMzBUN0t3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AFDB9BEB1EF3334E8C59EA0FA96D12F3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75b8e108-d8be-473b-6149-08d9c61bcc64
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2021 13:54:54.4396
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fyJBzYK5C4lUc8+MiKyowO5jz7y3XQ1F6VW950SMHEnFrk3SZxZ3OQhQCueF6sAg1YxJXJSd+f8CHPJNX8pMkT//j2hCeII8OwHQmkst7ZU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4954
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIvMTQvMjEgMzozNCBQTSwgVHVkb3IgQW1iYXJ1cyB3cm90ZToNCj4gVGhlIHNhbWE3ZzUg
UVNQSSBjb250cm9sbGVyIHVzZXMgZGVkaWNhdGVkIGNsb2NrcyBmb3IgdGhlDQo+IFFTUEkgQ29u
dHJvbGxlciBJbnRlcmZhY2UgYW5kIHRoZSBRU1BJIENvbnRyb2xsZXIgQ29yZSwgYW5kDQo+IHJl
cXVpcmVzIHN5bmNocm9uaXphdGlvbiBiZWZvcmUgYWNjZXNzaW5nIHJlZ2lzdGVycyBvciBiaXQN
Cj4gZmllbGRzLg0KPiANCj4gUVNQSV9TUi5TWU5DQlNZIG11c3QgYmUgemVybyBiZWZvcmUgYWNj
ZXNzaW5nIGFueSBvZiB0aGUgYml0czoNCj4gUVNQSV9DUi5RU1BJRU4sIFFTUElfQ1IuUVNQSURJ
UywgUVNQSV9DUi5TUkZSU0gsIFFTUElfQ1IuU1dSU1QsDQo+IFFTUElfQ1IuVVBEQ0ZHLCBRU1BJ
X0NSLlNUVEZSLCBRU1BJX0NSLlJUT1VULCBRU1BJX0NSLkxBU1RYRkVSLg0KPiANCj4gQWxzbywg
dGhlIFFTUEkgY29udHJvbGxlciBjb3JlIGNvbmZpZ3VyYXRpb24gY2FuIGJlIHVwZGF0ZWQgYnkN
Cj4gd3JpdGluZyB0aGUgUVNQSV9DUi5VUERDRkcgYml0IHRvIOKAmDHigJkuIFRoaXMgaXMgbmVl
ZGVkIGJ5IHRoZQ0KPiBmb2xsb3dpbmcgcmVnaXN0ZXJzOiBRU1BJX01SLCBRU1BJX1NDUiwgUVNQ
SV9JQVIsIFFTUElfV0lDUiwNCj4gUVNQSV9JRlIsIFFTUElfUklDUiwgUVNQSV9TTVIsIFFTUElf
U0tSLFFTUElfUkVGUkVTSCwgUVNQSV9XUkFDTlQNCj4gUVNQSV9QQ0FMQ0ZHLg0KPiANCj4gVGhl
IE9jdGFsIFNQSSBzdXBwb3J0cyBmcmVxdWVuY2llcyB1cCB0byAyMDAgTUhaIEREUi4gVGhlIG5l
ZWQNCj4gZm9yIG91dHB1dCBpbXBlZGFuY2UgY2FsaWJyYXRpb24gYXJpc2VzLiBUbyBhdm9pZCB0
aGUgZGVncmFkYXRpb24NCj4gb2YgdGhlIHNpZ25hbCBxdWFsaXR5LCBhIFBBRCBjYWxpYnJhdGlv
biBjZWxsIGlzIHVzZWQgdG8gYWRqdXN0DQo+IHRoZSBvdXRwdXQgaW1wZWRhbmNlIHRvIHRoZSBk
cml2ZW4gSS9Pcy4NCj4gDQo+IFRoZSB0cmFuc21pc3Npb24gZmxvdyByZXF1aXJlcyBkaWZmZXJl
bnQgc2VxdWVuY2VzIGZvciBzZXR0aW5nDQo+IHRoZSBjb25maWd1cmF0aW9uIGFuZCBmb3IgdGhl
IGFjdHVhbCB0cmFuc2ZlciwgdGhhbiB3aGF0IGlzIGluDQo+IHRoZSBzYW1hNWQyIGFuZCBzYW05
eDYwIHZlcnNpb25zIG9mIHRoZSBJUC4gRGlmZmVyZW50IGludGVycnVwdHMNCj4gYXJlIGhhbmRs
ZWQuIGFxLT5vcHMtPnNldF9jZmcoKSBhbmQgYXEtPm9wcy0+dHJhbnNmZXIoKSBhcmUNCj4gaW50
cm9kdWNlZCB0byBoZWxwIGRpZmZlcmVudGlhdGluZyB0aGUgZmxvd3MuDQo+IA0KPiBUZXN0ZWQg
c2luZ2xlIGFuZCBvY3RhbCBTUEkgbW9kZSB3aXRoIG14NjZsbTFnNDVnLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogVHVkb3IgQW1iYXJ1cyA8dHVkb3IuYW1iYXJ1c0BtaWNyb2NoaXAuY29tPg0KPiAt
LS0NCj4gIGRyaXZlcnMvc3BpL2F0bWVsLXF1YWRzcGkuYyB8IDkyMSArKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA4NjkgaW5zZXJ0aW9ucygr
KSwgNTIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zcGkvYXRtZWwt
cXVhZHNwaS5jIGIvZHJpdmVycy9zcGkvYXRtZWwtcXVhZHNwaS5jDQo+IGluZGV4IDkyZDk2MTBk
ZjFmZC4uODk4MGE3MjlkZDUzIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3NwaS9hdG1lbC1xdWFk
c3BpLmMNCj4gKysrIGIvZHJpdmVycy9zcGkvYXRtZWwtcXVhZHNwaS5jDQo+IEBAIC0xMSwxMSAr
MTEsMTUgQEANCg0KY3V0DQoNCj4gK3N0YXRpYyBpbnQgYXRtZWxfcXNwaV9yZWdfc3luYyhzdHJ1
Y3QgYXRtZWxfcXNwaSAqYXEpDQo+ICt7DQo+ICsJdTMyIHZhbDsNCj4gKwlpbnQgcmV0Ow0KPiAr
DQo+ICsJcmV0ID0gcmVhZGxfcG9sbF90aW1lb3V0KGFxLT5yZWdzICsgUVNQSV9TUjIsIHZhbCwN
Cj4gKwkJCQkgISh2YWwgJiBRU1BJX1NSMl9TWU5DQlNZKSwgNDAsDQo+ICsJCQkJIEFUTUVMX1FT
UElfU1lOQ19USU1FT1VUKTsNCj4gKwlyZXR1cm4gcmV0Ow0KDQpyZXR1cm4gcmVhZGxfcG9sbF90
aW1lb3V0KCk7DQoNCj4gK30NCg0KY3V0DQoNCj4gK3N0YXRpYyBpbnQgYXRtZWxfcXNwaV9kbWFf
eGZlcihzdHJ1Y3QgYXRtZWxfcXNwaSAqYXEsIHN0cnVjdCBkbWFfY2hhbiAqY2hhbiwNCj4gKwkJ
CSAgICAgICBkbWFfYWRkcl90IGRtYV9kc3QsIGRtYV9hZGRyX3QgZG1hX3NyYywNCj4gKwkJCSAg
ICAgICB1bnNpZ25lZCBpbnQgbGVuKQ0KPiArew0KPiArCXN0cnVjdCBkbWFfYXN5bmNfdHhfZGVz
Y3JpcHRvciAqdHg7DQo+ICsJZG1hX2Nvb2tpZV90IGNvb2tpZTsNCj4gKwlpbnQgcmV0Ow0KPiAr
DQo+ICsJdHggPSBkbWFlbmdpbmVfcHJlcF9kbWFfbWVtY3B5KGNoYW4sIGRtYV9kc3QsIGRtYV9z
cmMsIGxlbiwNCj4gKwkJCQkgICAgICAgRE1BX1BSRVBfSU5URVJSVVBUIHwgRE1BX0NUUkxfQUNL
KTsNCj4gKwlpZiAoIXR4KSB7DQo+ICsJCWRldl9lcnIoJmFxLT5wZGV2LT5kZXYsICJkZXZpY2Vf
cHJlcF9kbWFfbWVtY3B5IGVycm9yXG4iKTsNCj4gKwkJcmV0dXJuIC1FSU87DQo+ICsJfQ0KPiAr
DQo+ICsJcmVpbml0X2NvbXBsZXRpb24oJmFxLT5kbWFfY29tcGxldGlvbik7DQo+ICsJdHgtPmNh
bGxiYWNrID0gYXRtZWxfcXNwaV9kbWFfY2FsbGJhY2s7DQo+ICsJdHgtPmNhbGxiYWNrX3BhcmFt
ID0gYXE7DQo+ICsJY29va2llID0gdHgtPnR4X3N1Ym1pdCh0eCk7DQo+ICsJcmV0ID0gZG1hX3N1
Ym1pdF9lcnJvcihjb29raWUpOw0KPiArCWlmIChyZXQpIHsNCj4gKwkJZGV2X2VycigmYXEtPnBk
ZXYtPmRldiwgImRtYV9zdWJtaXRfZXJyb3IgJWRcbiIsIGNvb2tpZSk7DQo+ICsJCXJldHVybiBy
ZXQ7DQo+ICsJfQ0KPiArDQo+ICsJZG1hX2FzeW5jX2lzc3VlX3BlbmRpbmcoY2hhbik7DQo+ICsJ
cmV0ID0gd2FpdF9mb3JfY29tcGxldGlvbl90aW1lb3V0KCZhcS0+ZG1hX2NvbXBsZXRpb24sDQo+
ICsJCQkJCSAgbXNlY3NfdG9famlmZmllcygyMCAqIEFUTUVMX1FTUElfVElNRU9VVCkpOw0KDQoy
MCAqIEFUTUVMX1FTUElfVElNRU9VVCwgdGhpcyBpcyBhIGxlZnRvdmVyIGZyb20gYSBkZWJ1ZyBz
ZXNzaW9uLg0KDQpJJ2xsIHNlbmQgYSBuZXcgdmVyc2lvbiB0byBmaXggdGhlc2Ugc21hbGwgaXNz
dWVzLg0KDQpDaGVlcnMsDQp0YQ0K
