Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A38B747C226
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 16:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238852AbhLUPCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 10:02:17 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:11230 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234288AbhLUPCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 10:02:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1640098936; x=1671634936;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=UyNUNDrQIycULZr3CjA+M01Fb7ke/QjCsbrezLK2kK0=;
  b=qElQMmV5ozh2cziLiM6vbslagqyf+u+Z8fzavZ+r+vSuYVq23Pis/8Fo
   I9GQ6Pd376dbbQ39pyzO4k3bsBB16sKNnnFxFTfRAFYeWwq39X0TiUdh5
   oDNpS0gBo8D0P42N1AtbliABXjf1PVfp75OFtpkR9qbrxOs0dquqjWe60
   qaoRlybUBFremKJaLvBcEZCGVivH7LQ8HyqQ0/Wrh5T/AWtGZgdRXS7/k
   myUq1e6kVje8jAtkKDuqXWls+uSA7AcFkWvfzvayjbieMnIzGrb7zVoep
   BcpbhAXJagrU+IRJEOUb0U9TTwOT3IXW9RwVRRMj6fQ+MvOzPchpgDjDl
   g==;
IronPort-SDR: 06nHBAM2r7W0noLI+JJd4iqDRpQbZFk5RWW07GJIf5utxd/7y4idmDxF4UwDEMg0ZQ57FiBG+w
 84Yha0fOp5YNjAb/cNZBaFqCTS5fWxP0TRpvi4Mv6Vj/Jv5oLGgHvUfLzhFN4gWDyb4TnJAu4G
 xwt7px+AMW5WOQhEleCHe0rse0yKA5U3CM/bBN1v4XZf5crFpcTH1gQrCx5zHmzrK45ro0koZ3
 opHvjvCDzKkZk9gZvCwvFImPA8HfQAdzh6+Yfm4YiPZlWi+WYKe6STqX0xQYAtLyk0EZdWn9bK
 K7z7tb++SHBZ/g2sSPQkYmbp
X-IronPort-AV: E=Sophos;i="5.88,223,1635231600"; 
   d="scan'208";a="147377948"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Dec 2021 08:02:03 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 21 Dec 2021 08:01:59 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Tue, 21 Dec 2021 08:01:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kfUX8d0Dc3ndnbVe+3/j5C9D46dMtl7+LIRxCb6guaYmiywVIXJAUsJ79kDyQb+MzLc9cnWi4cSi1uPC46ZStCBcr5c753JJg2azMICkntZFZ3gjHxtFmhRFC1unN5WKFtg75OaXObp8l/KQF+a+rVPIt/iKB/toq82XrQqX0GrLurN30BXhwNA9NmBM1mC8lyZF2B9JBpEPTPxkrLz8682HgY3JFM4oRExYVR9nbAa2PVwjWEpSIVeH7SKG6metnhdP4c9sl6OTlExdjw98Wy8GhYbgCdahgal1jvc8K8WOksm8w1zzBbWVGlKwQHG5I+f2xf2Xlhmn4vE3EjFOMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UyNUNDrQIycULZr3CjA+M01Fb7ke/QjCsbrezLK2kK0=;
 b=fqam8SZP7dIXw4juFkOvXlsb31ER/cBBEey1nNEli2WyxfzQEE4iX4rXfjv4zTN85tLOUxCG1aKJzRTsWHA0c6g1Cwaw9OStfAuWuDrGPuQylAgABS9GyziM1wWN91lXmqLYeSDPMkuhOuFN/wIG9y0dnTh5RsIx4atjsU520H3P9HkV2fpDFhDsNEKEkeYwxdgGHE1DGRt1PYhV/9k2BhvezQKVPybplubRo0EaH9LtoUgSdO368suWOi3Et4CpXjmPOHcNxgMSBWDXlVoPXMgfBvO+qaHasVzf9fOnb70Kn2MnlXCaRsVj7WYnbM4MtYWsokN7z3AoYvLQGIIoIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UyNUNDrQIycULZr3CjA+M01Fb7ke/QjCsbrezLK2kK0=;
 b=n4Ma4PsBN0yvn17pI7F23ljIXb08c5ruvOItQ1eXe3ldpGFx0937r/HjxSn6GVudfbL4cmbdfACI1YKu+7kSGmRzZM29sgRom99/9z8i596OADaCoZwb7G+5gImrKyCeLK5HVq3hp3rWnQMuGMKG55Zvkuf0QbVZlpLRL7cRytM=
Received: from PH0PR11MB4920.namprd11.prod.outlook.com (2603:10b6:510:41::22)
 by PH0PR11MB5112.namprd11.prod.outlook.com (2603:10b6:510:3b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Tue, 21 Dec
 2021 15:01:57 +0000
Received: from PH0PR11MB4920.namprd11.prod.outlook.com
 ([fe80::1433:9dcf:4912:b8f]) by PH0PR11MB4920.namprd11.prod.outlook.com
 ([fe80::1433:9dcf:4912:b8f%9]) with mapi id 15.20.4801.020; Tue, 21 Dec 2021
 15:01:57 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <prabhakar.csengg@gmail.com>
CC:     <hugues.fruchet@st.com>, <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        <jacopo+renesas@jmondi.org>, <sakari.ailus@linux.intel.com>,
        <laurent.pinchart@ideasonboard.com>, <slongerbeam@gmail.com>,
        <paul.kocialkowski@bootlin.com>, <linux-media@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>, <biju.das.jz@bp.renesas.com>,
        <mchehab@kernel.org>
Subject: Re: [PATCH v4 1/6] media: i2c: ov5640: Remain in power down for DVP
 mode unless streaming
Thread-Topic: [PATCH v4 1/6] media: i2c: ov5640: Remain in power down for DVP
 mode unless streaming
Thread-Index: AQHWgvi4qdMvk8Y9N0iZFwzrul8/26lggxKAgcwfagCBEtLdAIAAd/kAgAAEIAA=
Date:   Tue, 21 Dec 2021 15:01:57 +0000
Message-ID: <450850f6-9296-e505-4b92-c71ed190b95f@microchip.com>
References: <20200904201835.5958-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200904201835.5958-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <8b5d4928-2921-b876-7d1e-04bb42eff4fa@st.com>
 <3b54ab9b-4ffd-ab32-d495-fad6132ea504@microchip.com>
 <5c56c87d-ca48-5573-0606-da1441fab7ff@microchip.com>
 <CA+V-a8uk3h95aL7n7cDjYdXJBbE6GWF_LkiAVMOFtVzv-83ZpQ@mail.gmail.com>
In-Reply-To: <CA+V-a8uk3h95aL7n7cDjYdXJBbE6GWF_LkiAVMOFtVzv-83ZpQ@mail.gmail.com>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a711751c-51e9-47d3-eda2-08d9c492d584
x-ms-traffictypediagnostic: PH0PR11MB5112:EE_
x-microsoft-antispam-prvs: <PH0PR11MB51124CE010041B6B17819D14E87C9@PH0PR11MB5112.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XRprqIjt4yqBGoUMl+mOut9pA9VbOC4p1GLf5ZB/9mBR2/g/pJmrE+IM2EeXcSul9wDKuZYkNh3WEvHp7CmmzXjxYZbyjLvn5FgeS5Ex3XxUL9hu0PkqjYsFSK2D6XYg9zd8L1MCST6aC6xCTK+0uDGTCawZtlF40ONANwOwWqOv+tmgKW2DP5zkN9U8pp6NwEEMpT2QRFd6eRMZg1+U9lwOQ7ueO9QeiYpzInkM+IykN78C/qIh36IZqk/HO21WsP+vKPH+FihGeXMGYfiMh8tZXZCWZA4Fri9YtHueOwhdRQZhDRE5NHtrIT8+OQm1AcWP6DksmcqRGQc+wCj/avvkpkrfLpy3lECs4KmZs7GhVPGkE7nUpy6/lt/jql37Uk4bZ03VMSt5TiflfzGEAq0Ov5Io+Qca9/9ng/CZUk4+Yw/aOtxOsmNd8uaBhGzgCG8Bb4USNXgyC7KXAZq7lX7TRna8jtLfYGj7RchcIcTBrjNGZwkfVol6h62WUewWjysWzR2iXyCwG1fImaJj88E+TNNvksB2TXf4Ys5EEOzowSmGoPSaa/mVj1Sv0dR8MkCJzYixu537L6qlqe//VY2COJKrR3dGSxQEe9SI40HGZGDnEfbogBZh9U5FL3JHJsAJk0PSLZNnLEfmsVt8NsufEALkuNnZ9QTUTRjp8X4d68VRIzYYbkEvNS5xofh+IMGCxEn+t47sRn47pMgFEWyztuF+V1F3y4jshCbfhmX73iLUG/84jjtgzfQ52+RM8hByVibxJ8gVBAqAtf2pzw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4920.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(122000001)(6486002)(5660300002)(38070700005)(31686004)(316002)(7416002)(6916009)(38100700002)(66446008)(31696002)(64756008)(66476007)(76116006)(36756003)(6512007)(26005)(6506007)(4326008)(66946007)(186003)(83380400001)(66556008)(508600001)(91956017)(54906003)(71200400001)(8676002)(2616005)(8936002)(86362001)(53546011)(966005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RFJPY3NBdUVRMzFuNHlQdHJPV0xMaGxIcUY0Wmp0czk3aWRRSm5OU2VXVCtU?=
 =?utf-8?B?NktTZVBNbHk2Rk1NY3JJTmc5NG5Rbng3RitWWUE4di8xRExIakZRTXBaOUxq?=
 =?utf-8?B?bFVyVklNbWpQYlo1QXZ1R3E2Y1E2RjBOTk83ZW03M0FzVkFyWmdzWXBOYy9Q?=
 =?utf-8?B?cVNHRTVsTDhwNVJZS1JIL1h4TWwxTzVsYTF5OGFzbFQ0U3Q5WmlsK1hPVld2?=
 =?utf-8?B?ZTZIOVN2MkVyL3BkQ1o5eHJSbnVkdm5OM0k1KzhSV2hFbk5BVG9iNmtpbkwr?=
 =?utf-8?B?T3RKUTk5ZFR5ZTBkQ2xKNW84R3BqbjlUR1NoMnZwWVJoejV4MTRVeFFOaXBF?=
 =?utf-8?B?c0E2VjZXU1BJcVVDditmVUNrZG9oR0JkdWQ4dEpjSmYxT0pSYVJBQXp4Nkxv?=
 =?utf-8?B?eEtndmNjZ0FkS0QvY2J2bndxOS8zNzFWLzI0amlmQTZnMEtJOHRYbGpHeWNw?=
 =?utf-8?B?K3ZWa1Bxdnl6VXNZQ0lkQVhtejJyODdaN25kNHlzc0VCM2JCT1h3QVVzTGo5?=
 =?utf-8?B?Y1JRUE1qUnVtb3JlQ0JKL2dwSGkxbTlVaUM2aDN0QUtDMGVkV0tKVUE0dVVw?=
 =?utf-8?B?aU1ZSWRBYjhmdll5T1NpeHNZYm4xZUJSZ0NHNlBlZnkvM2NmY3lKL2IzVUlo?=
 =?utf-8?B?UzNpeG9BSDAzZ0dqcGwzK0RCRUtETlRNTi9SNjlXcEZoZzJIRUtUM2g0c0Uz?=
 =?utf-8?B?QU41eFB1K0ZCRXpRMTFPWTZSdlRQa2Znak42QXFjZk5DYVg1NEt5L21XU3lP?=
 =?utf-8?B?Z3BXSFJFeE1HMVExY0pEb2d2ZFFjNFJaK0wzcVdpQVJ0WWwyM24zMGNDeGNZ?=
 =?utf-8?B?ZDRRY3BBeWNRemRzZTYyQjVMSExyMjVOYk9FdEsveDcxYjVxb2UyM3RoZ2ZS?=
 =?utf-8?B?Y1g5eXBnN1NPMy9WdlpMNitQeE13U0dyeUp6RUF2WTZZMEhLcU1JQVRYcVVr?=
 =?utf-8?B?VjQrcmZGWGtpVDJBWk5ZQ0Fyb1REeG9majlUNDErQUx4WTNSSFhDdFJTQ3BS?=
 =?utf-8?B?UWc4YjRBNFpBTEh5YVFNZ0d0ckV4L3hsczhBSTF1aWZ3c3pxcERiTUhZUzl5?=
 =?utf-8?B?RWZpV3hjdndlN3RSck9aUFYvZ1IwbnNDK1JsdEFiekg1NnFrb3JGVXczMkha?=
 =?utf-8?B?N0IxcmxDeExtQ1RFR01kSFVLRVBjQTdoTXZTNUd1aXhwRzhMT244UlhUUWVK?=
 =?utf-8?B?cC9tdzRBWGRCYTB5cjd3Zk1lT3NpamxJNnMwRnFuWU1hemlXaElHUDFKNTVI?=
 =?utf-8?B?NmNScEREVDBuWGxiM3dNQ1RGMTgwa2VaQnZoZ3VmM2RGOU5JNlNhQVBtR3Z3?=
 =?utf-8?B?cXdGZVIwVGZkNEhGVUtaMkFmZmtyMlUrQnhaT1VyRXdEcTF2dUtWWUtjbzRE?=
 =?utf-8?B?cHRUdkZpZDNyV3A2T0hpZm8xaVFyTVk4b1EyNFBtYjhsay9qWDlsWEJyc2hH?=
 =?utf-8?B?c2t1K1pwWE15OWRzQVFmUVJacWlSazJ3eGh0Lys5Vi9ON2xmV2pzVkYvREV6?=
 =?utf-8?B?Y1ArcmgyUzA5SW4zUHlGL2lhdSswZFFQaVJVUnZtbTZBenlTSnlnaXhvQWF3?=
 =?utf-8?B?RENhcEh6ZEFveW1WNWRucXp0dTYvRnN0K0NTRzFLSy9JM0lsOEVScFVoRW14?=
 =?utf-8?B?cVJmLzRHQ1BmR2FVSmovME9sZHY0RURLQ3I0ZDRzaWZkVTA2ZGIxMlBLaENV?=
 =?utf-8?B?L2gyb1g3eEpWcndHa3NaaGUvcFRVa3ZUSERRN1lqYW4yeCtvSVlsbmh6Rmxx?=
 =?utf-8?B?dlBzV0FEaVhUNlMyK1NzaDU5TXJ2NUdxbEo1TVh4dlZVOC9pQk4rV2wyd2Vm?=
 =?utf-8?B?dTBlMWJHcGhySzdKNlhwNTVkSzJOcnlaSTgrSFhEbktXNnpQcXpsbDBkUGY0?=
 =?utf-8?B?cmNHdXFyTG5ob3JqWWhyajIzOGczMkFib1JvT0d5SVBWVk5ETWlNS3dlWkpY?=
 =?utf-8?B?dzVuUmpXZ3ZweCtHZDZmdllPbzBjeWJhSzZJVnl3M3RUdWJVMmZMWERkSVo0?=
 =?utf-8?B?dm5ZOTJ5d3JGdXZhQzRDa2doVlJYTnVJQlF4UGF2cEtVQzFEUWEyUUF6MVlr?=
 =?utf-8?B?bm9pTEhEY0gvVWFZSHVvL3RQdjFKaFU2ajZTbXROZmhJSThUV1MwcXhKZjIv?=
 =?utf-8?B?ZmhHNnZ4OXg2MmdMWUhCVTFQMk1mM3ErWlUvclQxY1oycnRyT0s4eFZITTh1?=
 =?utf-8?B?THNnZlZBdGJES0hJemdCSmsxdXphM2Vobnl6cG9BNWpaejhHVC95RWhNUW1J?=
 =?utf-8?B?VzREcDJ3RGIxNi9kV1ZDV0Z1VzN3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FE6FE57D3385E944B6976AE1243D1AB4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4920.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a711751c-51e9-47d3-eda2-08d9c492d584
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2021 15:01:57.0986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4cYqRxxuRVvwAg1yC61fN7+v9x/Uq0HWeV73taTQnUX6R02Tt2VepMYGvACfMI8gcko8fY7O0qMxU3mue4bwDqigpyGpwgjixpY9hpY2up8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5112
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIvMjEvMjEgNDo0NyBQTSwgTGFkLCBQcmFiaGFrYXIgd3JvdGU6DQo+IEhpLA0KPiANCj4g
U29ycnkgZm9yIHRoZSBkZWxheS4NCj4gDQo+IE9uIFR1ZSwgRGVjIDIxLCAyMDIxIGF0IDc6Mzcg
QU0gPEV1Z2VuLkhyaXN0ZXZAbWljcm9jaGlwLmNvbT4gd3JvdGU6DQo+Pg0KPj4gT24gNi8yOS8y
MSAxOjQ3IFBNLCBFdWdlbiBIcmlzdGV2IC0gTTE4MjgyIHdyb3RlOg0KPj4+IE9uIDkvOS8yMCA3
OjE2IFBNLCBIdWd1ZXMgRlJVQ0hFVCB3cm90ZToNCj4+Pj4gSGkgUHJhYmhha2FyLA0KPj4+Pg0K
Pj4+PiBBcyBkaXNjdXNzZWQgc2VwYXJhdGVseSBJIHdvdWxkIHByZWZlciB0byBiZXR0ZXIgdW5k
ZXJzdGFuZCBpc3N1ZSBiZWZvcmUNCj4+Pj4gZ29pbmcgdG8gdGhpcyBwYXRjaC4NCj4+Pj4gTmV2
ZXJ0aGVsZXNzIEkgaGF2ZSBzb21lIHJlbWFya3MgaW4gY29kZSBpbiBjYXNlIHdlJ2xsIG5lZWQg
aXQgYXQgdGhlIGVuZC4NCj4+Pj4NCj4+Pj4gT24gOS80LzIwIDEwOjE4IFBNLCBMYWQgUHJhYmhh
a2FyIHdyb3RlOg0KPj4+Pj4gS2VlcCB0aGUgc2Vuc29yIGluIHNvZnR3YXJlIHBvd2VyIGRvd24g
bW9kZSBhbmQgd2FrZSB1cCBvbmx5IGluDQo+Pj4+PiBvdjU2NDBfc2V0X3N0cmVhbV9kdnAoKSBj
YWxsYmFjay4NCj4+Pj4+DQo+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBMYWQgUHJhYmhha2FyIDxwcmFi
aGFrYXIubWFoYWRldi1sYWQucmpAYnAucmVuZXNhcy5jb20+DQo+Pj4+PiBSZXZpZXdlZC1ieTog
QmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPj4+Pj4gVGVzdGVkLWJ5OiBK
YWNvcG8gTW9uZGkgPGphY29wb0BqbW9uZGkub3JnPg0KPj4+Pj4gLS0tDQo+Pj4+PiAgICAgIGRy
aXZlcnMvbWVkaWEvaTJjL292NTY0MC5jIHwgMTkgKysrKysrKysrKysrKysrKy0tLQ0KPj4+Pj4g
ICAgICAxIGZpbGUgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4+
Pj4+DQo+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tZWRpYS9pMmMvb3Y1NjQwLmMgYi9kcml2
ZXJzL21lZGlhL2kyYy9vdjU2NDAuYw0KPj4+Pj4gaW5kZXggMmZlNGE3YWMwNTkyLi44ODBmZGU3
M2EwMzAgMTAwNjQ0DQo+Pj4+PiAtLS0gYS9kcml2ZXJzL21lZGlhL2kyYy9vdjU2NDAuYw0KPj4+
Pj4gKysrIGIvZHJpdmVycy9tZWRpYS9pMmMvb3Y1NjQwLmMNCj4+Pj4+IEBAIC0zNCw2ICszNCw4
IEBADQo+Pj4+PiAgICAgICNkZWZpbmUgT1Y1NjQwX1JFR19TWVNfUkVTRVQwMiAgICAgICAgICAg
ICAgMHgzMDAyDQo+Pj4+PiAgICAgICNkZWZpbmUgT1Y1NjQwX1JFR19TWVNfQ0xPQ0tfRU5BQkxF
MDIgICAgICAgMHgzMDA2DQo+Pj4+PiAgICAgICNkZWZpbmUgT1Y1NjQwX1JFR19TWVNfQ1RSTDAg
ICAgICAgICAgICAgICAgMHgzMDA4DQo+Pj4+PiArI2RlZmluZSBPVjU2NDBfUkVHX1NZU19DVFJM
MF9TV19QV0ROIDB4NDINCj4+Pj4+ICsjZGVmaW5lIE9WNTY0MF9SRUdfU1lTX0NUUkwwX1NXX1BX
VVAgMHgwMg0KPj4+Pg0KPj4+PiBGb3IgdGhlIHRpbWUgYmVpbmcgdGhpcyBzZWN0aW9uIHdhcyBv
bmx5IHJlZmVycmluZyB0byByZWdpc3RlcnMNCj4+Pj4gYWRkcmVzc2VzIGFuZCBiaXQgZGV0YWls
cyB3YXMgZXhwbGFpbmVkIGludG8gYSBjb21tZW50IHJpZ2h0IGJlZm9yZQ0KPj4+PiBhZmZlY3Rh
dGlvbiwgc2VlIE9WNTY0MF9SRUdfSU9fTUlQSV9DVFJMMDAgZm9yIGV4YW1wbGUuDQo+Pj4+DQo+
Pj4+PiAgICAgICNkZWZpbmUgT1Y1NjQwX1JFR19DSElQX0lEICAgICAgICAgIDB4MzAwYQ0KPj4+
Pj4gICAgICAjZGVmaW5lIE9WNTY0MF9SRUdfSU9fTUlQSV9DVFJMMDAgICAweDMwMGUNCj4+Pj4+
ICAgICAgI2RlZmluZSBPVjU2NDBfUkVHX1BBRF9PVVRQVVRfRU5BQkxFMDEgICAgICAweDMwMTcN
Cj4+Pj4+IEBAIC0xMTIwLDYgKzExMjIsMTIgQEAgc3RhdGljIGludCBvdjU2NDBfbG9hZF9yZWdz
KHN0cnVjdCBvdjU2NDBfZGV2ICpzZW5zb3IsDQo+Pj4+PiAgICAgICAgICAgICAgICAgIHZhbCA9
IHJlZ3MtPnZhbDsNCj4+Pj4+ICAgICAgICAgICAgICAgICAgbWFzayA9IHJlZ3MtPm1hc2s7DQo+
Pj4+Pg0KPj4+Pj4gKyAgICAgICAgICAgICAvKiByZW1haW4gaW4gcG93ZXIgZG93biBtb2RlIGZv
ciBEVlAgKi8NCj4+Pj4+ICsgICAgICAgICAgICAgaWYgKHJlZ3MtPnJlZ19hZGRyID09IE9WNTY0
MF9SRUdfU1lTX0NUUkwwICYmDQo+Pj4+PiArICAgICAgICAgICAgICAgICB2YWwgPT0gT1Y1NjQw
X1JFR19TWVNfQ1RSTDBfU1dfUFdVUCAmJg0KPj4+Pj4gKyAgICAgICAgICAgICAgICAgc2Vuc29y
LT5lcC5idXNfdHlwZSAhPSBWNEwyX01CVVNfQ1NJMl9EUEhZKQ0KPj4+Pj4gKyAgICAgICAgICAg
ICAgICAgICAgIGNvbnRpbnVlOw0KPj4+Pj4gKw0KPj4+Pg0KPj4+PiBJIHVuZGVyc3RhbmQgdGhh
dCBtb3JlIG9yIGxlc3MgcmVnaXN0ZXIgT1Y1NjQwX1JFR19TWVNfQ1RSTDAgKDB4MzAwOCkNCj4+
Pj4gaGFzIGJlZW4gcGFydGlhbGx5IHJlbW92ZWQgZnJvbSBiaWcgaW5pdCBzZXF1ZW5jZTogZm9y
IHBvd2VyLXVwIHBhcnQsDQo+Pj4+IGJ1dCBwb3dlci1kd24gcmVtYWlucyBhdCB2ZXJ5IGJlZ2lu
bmluZyBvZiBzZXF1ZW5jZS4NCj4+Pj4gV2Ugc2hvdWxkIGNvbXBsZXRlbHkgcmVtb3ZlIDB4MzAw
OCBmcm9tIGluaXQgc2VxdWVuY2UsIGluY2x1ZGluZw0KPj4+PiBwb3dlci1kd24sIGFuZCBpbnRy
b2R1Y2UgYSBuZXcgZnVuY3Rpb24gb3Y1NjQwX3N3X3Bvd2VyZG93bihvbi9vZmYpIHRoYXQNCj4+
Pj4gc2hvdWxkIGJlIGNhbGxlZCBhdCB0aGUgcmlnaHQgcGxhY2UgaW5zdGVhZC4NCj4+Pj4NCj4+
Pj4NCj4+Pj4+ICAgICAgICAgICAgICAgICAgaWYgKG1hc2spDQo+Pj4+PiAgICAgICAgICAgICAg
ICAgICAgICAgICAgcmV0ID0gb3Y1NjQwX21vZF9yZWcoc2Vuc29yLCByZWdfYWRkciwgbWFzaywg
dmFsKTsNCj4+Pj4+ICAgICAgICAgICAgICAgICAgZWxzZQ0KPj4+Pj4gQEAgLTEyOTcsOSArMTMw
NSwxNCBAQCBzdGF0aWMgaW50IG92NTY0MF9zZXRfc3RyZWFtX2R2cChzdHJ1Y3Qgb3Y1NjQwX2Rl
diAqc2Vuc29yLCBib29sIG9uKQ0KPj4+Pj4gICAgICAgICAgICogUEFEIE9VVFBVVCBFTkFCTEUg
MDINCj4+Pj4+ICAgICAgICAgICAqIC0gWzc6Ml06ICAgICBEWzU6MF0gb3V0cHV0IGVuYWJsZQ0K
Pj4+Pj4gICAgICAgICAgICovDQo+Pj4+PiAtICAgICByZXR1cm4gb3Y1NjQwX3dyaXRlX3JlZyhz
ZW5zb3IsDQo+Pj4+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICBPVjU2NDBfUkVHX1BB
RF9PVVRQVVRfRU5BQkxFMDIsDQo+Pj4+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICBv
biA/IDB4ZmMgOiAwKTsNCj4+Pj4+ICsgICAgIHJldCA9IG92NTY0MF93cml0ZV9yZWcoc2Vuc29y
LCBPVjU2NDBfUkVHX1BBRF9PVVRQVVRfRU5BQkxFMDIsDQo+Pj4+PiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIG9uID8gMHhmYyA6IDApOw0KPj4+Pj4gKyAgICAgaWYgKHJldCkNCj4+Pj4+
ICsgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4+Pj4+ICsNCj4+Pj4+ICsgICAgIHJldHVybiBv
djU2NDBfd3JpdGVfcmVnKHNlbnNvciwgT1Y1NjQwX1JFR19TWVNfQ1RSTDAsIG9uID8NCj4+Pj4+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE9WNTY0MF9SRUdfU1lTX0NUUkwwX1NXX1BX
VVAgOg0KPj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgT1Y1NjQwX1JFR19TWVNf
Q1RSTDBfU1dfUFdETik7DQo+Pj4+PiAgICAgIH0NCj4+Pj4+DQo+Pj4+PiAgICAgIHN0YXRpYyBp
bnQgb3Y1NjQwX3NldF9zdHJlYW1fbWlwaShzdHJ1Y3Qgb3Y1NjQwX2RldiAqc2Vuc29yLCBib29s
IG9uKQ0KPj4+Pj4NCj4+Pj4NCj4+Pj4NCj4+Pj4gQlIsDQo+Pj4+IEh1Z3Vlcy4NCj4+Pj4NCj4+
Pg0KPj4+DQo+Pj4gSGVsbG8gZXZlcnlvbmUsDQo+Pj4NCj4+PiBXaGVuIEkgdXBkYXRlZCBkcml2
ZXIgaW4gbXkgdHJlZSB3aXRoIHRoaXMgcGF0Y2gsIEkgbm90aWNlZCB0aGF0IG15DQo+Pj4gc2V0
dXAgdXNpbmcgdGhlIEFUTUVMIGlzYyBwbGF0Zm9ybSArIG92NTY0MCBpbiBwYXJhbGxlbCBidXMg
bW9kZSBzdG9wcGVkDQo+Pj4gd29ya2luZy4NCj4+Pg0KPj4+IEl0IGxvb2tzIGxpa2UgdGhlIGN1
bHByaXQgaXMgdGhpcyBwYXRjaC4NCj4+PiBJIGFtIG5vdCBzdXJlIHdoaWNoIGlzIHRoZSBiZXN0
IHdheSB0byBmaXggaXQuDQo+Pj4gSXQgbG9va3MgbGlrZSBpbml0aWFsbHkgdGhpbmdzIHdvcmsg
ZmluZSB3aGVuIHByb2JpbmcgdGhlIGRyaXZlciwgYnV0DQo+Pj4gd2hlbiB3ZSB3YW50IHRvIHN0
YXJ0IHN0cmVhbWluZyBhdCBhIGxhdGVyIHBvaW50LCB0aGUgcmVnaXN0ZXIgU1lTX0NUUkwwDQo+
Pj4gY2Fubm90IGJlIHdyaXR0ZW4gYW55bW9yZS4NCj4+PiBIZXJlIGlzIGFuIG91dHB1dCBvZiB0
aGUgbG9nOg0KPj4+DQo+Pj4gICAgIC0tLSBPcGVuaW5nIC9kZXYvdmlkZW8wLi4uDQo+Pj4gICAg
ICAgIFRyeWluZyBzb3VyY2UgbW9kdWxlIHY0bDIuLi4NCj4+PiAgICAgICAgL2Rldi92aWRlbzAg
b3BlbmVkLg0KPj4+ICAgICAgICBObyBpbnB1dCB3YXMgc3BlY2lmaWVkLCB1c2luZyB0aGUgZmly
c3QuDQo+Pj4gICAgICAgIG92NTY0MCAxLTAwM2M6IG92NTY0MF93cml0ZV9yZWc6IGVycm9yOiBy
ZWc9MzAwOCwgdmFsPTINCj4+PiAgICAgICAgYXRtZWwtc2FtYTVkMi1pc2MgZjAwMDgwMDAuaXNj
OiBzdHJlYW0gb24gZmFpbGVkIGluIHN1YmRldiAtMTIxDQo+Pj4gICAgICAgIEVycm9yIHN0YXJ0
aW5nIHN0cmVhbS4NCj4+PiAgICAgICAgVklESU9DX1NUUkVBTU9OOiBSZW1vdGUgSS9PIGVycm9y
DQo+Pj4gICAgICAgIFVuYWJsZSB0byB1c2UgbW1hcC4gVXNpbmcgcmVhZCBpbnN0ZWFkLg0KPj4+
ICAgICAgICBVbmFibGUgdG8gdXNlIHJlYWQuDQo+Pj4NCj4+PiBJIGFtIHVzaW5nIGEgc2ltcGxl
IGFwcGxpY2F0aW9uIHRvIHJlYWQgZnJvbSAvZGV2L3ZpZGVvMCAod2hpY2ggaXMNCj4+PiByZWdp
c3RlcmVkIGJ5IHRoZSBhdG1lbC1pc2Mgb25jZSB0aGUgc2Vuc29yIHByb2JlZCkNCj4+Pg0KPj4+
IEkgaGF2ZSBhIGZlZWxpbmcgdGhhdCBzb21ldGhpbmcgaXMgd3JvbmcgcmVsYXRlZCB0byBwb3dl
ciwgYnV0IEkgY2Fubm90DQo+Pj4gdGVsbCBmb3Igc3VyZS4NCj4+Pg0KPj4+IFJldmVydGluZyB0
aGlzIHBhdGNoIG1ha2VzIGl0IHdvcmsgZmluZSBhZ2Fpbi4NCj4+Pg0KPj4+IEhlbHAgaXMgYXBw
cmVjaWF0ZWQsDQo+Pj4gVGhhbmtzLA0KPj4+IEV1Z2VuDQo+Pj4NCj4+DQo+Pg0KPj4gR2VudGxl
IHBpbmcuDQo+Pg0KPj4gSSB3b3VsZCBsaWtlIHRvIHNlbmQgYSByZXZlcnQgcGF0Y2ggaWYgbm9i
b2R5IGNhcmVzIGFib3V0IHRoaXMNCj4+IGRyaXZlci9wYXRjaCBleGNlcHQgbWUuDQo+Pg0KPiBJ
IHBvd2VyZWQgdXAgdGhlIFJlbmVzYXMgUlovRzFIIGNvbm5lY3RlZCB3aXRoIGFuIG92NTY0MCBz
ZW5zb3IgYW5kDQo+IHdhcyBhYmxlIHRvIGNhcHR1cmUgdGhlIHZpZGVvIGRhdGEgWzBdIHVzaW5n
IHRoZSB5YXZ0YSBhcHBsaWNhdGlvbi4NCj4gSSdtIGZpbmUgd2l0aCByZXZlcnRpbmcgdGhlIHBh
dGNoIHRvbyBhcyB0aGlzIHdvcmtzIGZpbmUgYXMgd2VsbC4NCg0KSGkgUHJhYmhha2FyLA0KDQpU
aGFua3MgZm9yIHRyeWluZyB0aGlzIG91dC4NCm92NTY0MCB3b3JrcyBpbiBib3RoIHBhcmFsbGVs
IG9yIENTSTIgbW9kZS4gTG9va2luZyBhdCB0aGUgYm9hcmQsIGl0IA0KbG9va3MgYSBwYXJhbGxl
bCBjb25uZWN0aW9uIGJ1dCBJIGFtIG5vdCAxMDAlLCB5b3UgdGVzdGVkIHVzaW5nIHBhcmFsbGVs
IA0KaW50ZXJmYWNlID8NCg0KPiANCj4gSnVzdCBzb21lIHN1Z2dlc3Rpb25zOg0KPiAtIFdoYXQg
aXMgdGhlIGFwcGxpY2F0aW9uIHlvdSBhcmUgdHJ5aW5nIHRvIHVzZSBmb3IgY2FwdHVyaW5nPw0K
DQpJIHdhcyB1c2luZyBhIHNpbXBsZSBhcHAgdGhhdCByZWFkcyBmcm9tIC9kZXYvdmlkZW8wLCBp
dCdzIGNhbGxlZCANCmZzd2ViY2FtLiBJIGNhbiB0cnkgbW9yZSBhcHBzIGlmIGl0J3MgbmVlZGVk
Lg0KDQo+IC0gSGF2ZSB5b3UgdHJpZWQgcmVkdWNpbmcgdGhlIGkyYyBjbG9jayBzcGVlZD8NCg0K
SSBkaWQgbm90LCBidXQgd2l0aG91dCB0aGlzIHBhdGNoLCB0aGVyZSBpcyBubyBwcm9ibGVtIHdo
YXRzb2V2ZXIsIGFuZCBJIA0KaGF2ZSBiZWVuIHVzaW5nIHRoaXMgc2Vuc29yIHNpbmNlIGFyb3Vu
ZCA0Ljkga2VybmVsIHZlcnNpb24uDQoNCj4gLSBDYW4geW91IHRyeSBhbmQgZG8gYSBkdW1teSB3
cml0ZSBmb3Igc29tZSBvdGhlciByZWdpc3RlciBpbg0KPiBvdjU2NDBfc2V0X3N0cmVhbV9kdnAo
KSB0byBzZWUgaWYgaTJjIHdyaXRlcyBhcmUgZmFpbGluZyBmb3IgYWxsIHJlZ3M/DQoNCkkgY2Fu
IHRyeQ0KDQo+IC0gQ2FuIHlvdSBhZGQgb3Y1NjQwX3JlYWRfcmVnKCkgaW4gb3Y1NjQwX3dyaXRl
X3JlZygpIHdoZW4NCj4gaTJjX3RyYW5zZmVyKCkgZmFpbHMgdG8gY2hlY2sgaWYgcmVhZCB0b28g
aXMgZmFpbGluZy4NCj4gDQo+IFswXSBodHRwczovL3Bhc3RlLmRlYmlhbi5uZXQvMTIyNDMxNy8N
Cg0KWW91IHNlZW0gdG8gYmUgYWJsZSB0byBjYXB0dXJlIHN1Y2Nlc3NmdWxseSwgSSBoYXZlIGEg
ZmVlbGluZyB0aGF0IGluIG15IA0KY2FzZSB0aGUgc2Vuc29yIGlzIHNvbWVob3cgbm90IHBvd2Vy
ZWQgdXAgd2hlbiB0aGUgY2FwdHVyZSBpcyBiZWluZyANCnJlcXVlc3RlZC4NCkNvdWxkIHlvdSBz
aGFyZSBhIHNuaXBwZXQgb2YgeW91ciBkZXZpY2UgdHJlZSBub2RlIGZvciB0aGUgc2Vuc29yIHNv
IEkgDQpjYW4gaGF2ZSBhIGxvb2sgPw0KDQpUaGFua3MsDQpFdWdlbg0KDQo+IA0KPiBDaGVlcnMs
DQo+IFByYWJoYWthcg0KPiANCg0K
