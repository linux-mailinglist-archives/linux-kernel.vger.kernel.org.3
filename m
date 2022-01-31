Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33D674A3E4E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 08:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235759AbiAaHr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 02:47:59 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:46956 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235006AbiAaHr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 02:47:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1643615277; x=1675151277;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=JiH7nXqPLvuJVZJsRcmZoJxUgOz4iJUi9KhiCr8K2i8=;
  b=okajhzENSJkButaBT3YN1eUl0MULB7sqp5//IfeLl0HQLAJQE5WRS4VQ
   s819m9UeG6N0ftg964UcAnAgyBlWkUgOTQFYtzp7G9BYJQIn20pZYVeSo
   R0t4v5aAmxEcizGMC4anvdS7YE+TcnfEyVCofUX8A/ApakADMFcba/IK/
   1IhVZE0XwPC+Tya0k9s+FkTtaPsjvR6p+V8NHTuJ+VYFFmtOXxgK79C1Z
   Wt2HdX303vg98vDrFNHGCeyi+Jn2XyVjLeWAKQ1g/lMWSgE/Yz/YsOLha
   BF/dSzvPXDaRFtHh0eTrugqUEgh5XJxd5dVOjTaEEkN5MvcGR78Nw5b0S
   A==;
IronPort-SDR: bIalXIEGyU9eNfgP1AHNV4gGYdzLEWl7nHHYBq7r6nS1Cv+lndVNbL/xJglZ9BQtQ1md0NB5ym
 Lu5yw/4je7VJ5NnZ7OnM9abJMHYfsfhDyDcPL/kXdPkAiqNkBUMpRPEWIpP+d0x/Gq7cuzPYfe
 mzgpgo+cBmG6stwcq/h6E+mbkT8hRGxwreem7juS6Z4KSx5/qmGx6zsq/tlWI7V2CX/19q/ubn
 7CmjlOuMPVkvCpYDH0nYl9ypFtF3JjDS1LVUEa+z8rNQwnsjK29UznkVJUSotQRyqvQwmapePH
 25X0ZY7AFHfiAPhBMcktO3p1
X-IronPort-AV: E=Sophos;i="5.88,330,1635231600"; 
   d="scan'208";a="147098907"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Jan 2022 00:47:57 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 31 Jan 2022 00:47:56 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Mon, 31 Jan 2022 00:47:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DzfyPmoUO+91WEWOa07e1tFAKbDhduiQijFLMlWH3SlNc8QPCvN7He93tkq8OqnICAUxqn0EXOM+NUDERShjcQw7Di2tcePU4O+9gHCsIJTva+AeC+95VZKh0y+T3ZuF8pnZUhFqVNUHFsE8myMee71YPKdRknm1qPn9gOA4X4sEPlwDJOUrXu8n4qQabucH1dia20DxGkdzi/4Picqp0dB4T9r4YszARRMRnXCDAUfJvppsTptnIn3IAbIyAGUksfdUHHZRPVBrdugdvRUjMBPgvM4VDyax2ANxmQnCP4CtQD6IypFCTsLkE5OUlltL61Mxb++pR0dj8DDlMUeNpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JiH7nXqPLvuJVZJsRcmZoJxUgOz4iJUi9KhiCr8K2i8=;
 b=evy2G7cZPs+XSROByuDT5PuWFHZ0uSb69d2DZlQ52aRnAzTECRe5xKBOs3h7BCNgzTDmNt0Xh3wS3mQ9QhUQRiKYVH4Q0tME3HdudbbTH13dIxKpplnjMhIjLhPISXQst0ozMAhtG56+MUSodAn1oaVhfQQlfXnBZuTv8ulHe7+0CWT90cE/yh2WhlmzLmh1oOQFGYeFvLRXDW1TYA3PiAnWb3q7qOuht/+Ubt/38q6q6QCmwV32/vohK0tx3nrOr+sTF1qpiwRuMcO9I/wMNOE/oLeLL1RuuNpasjoRT4US0Rjs26UxsgNFSRIyJ7BjCnPLiitdWLQcIHreLV4QMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JiH7nXqPLvuJVZJsRcmZoJxUgOz4iJUi9KhiCr8K2i8=;
 b=CSY+ukk6voWhikbmBR5EOo5CvSYxa9mVfwGLNYFb6voevahZva0en+PyMsAYm7ujRWLzTCGFXjNkDHDS0g66aTIRjhOoqb2WXMdCq/kDMSCN2xSFALO4qwqeDVWah1X/nYfutyUFoYu6t32K2XKFnDsFcHmJYzuo/E3Z1wQjAg0=
Received: from CO1PR11MB4769.namprd11.prod.outlook.com (2603:10b6:303:91::21)
 by PH7PR11MB5817.namprd11.prod.outlook.com (2603:10b6:510:13a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Mon, 31 Jan
 2022 07:47:51 +0000
Received: from CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::5cae:e802:4a48:bd0f]) by CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::5cae:e802:4a48:bd0f%6]) with mapi id 15.20.4930.022; Mon, 31 Jan 2022
 07:47:51 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/2] dt-bindings: ARM: at91: update maintainers entry
Thread-Topic: [PATCH 2/2] dt-bindings: ARM: at91: update maintainers entry
Thread-Index: AQHYFnbZS8xqBSj9n02OdYyrU6moXw==
Date:   Mon, 31 Jan 2022 07:47:51 +0000
Message-ID: <03bbe737-ce57-a7ef-211c-b29e15afdffd@microchip.com>
References: <23819d8baa635815d0893955197561fe4f044d5e.1643553501.git.nicolas.ferre@microchip.com>
 <5bf9873eeee3cd49c52a8952a7cd4cb60b61d50a.1643553501.git.nicolas.ferre@microchip.com>
In-Reply-To: <5bf9873eeee3cd49c52a8952a7cd4cb60b61d50a.1643553501.git.nicolas.ferre@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b16ea401-0e08-498e-cbb8-08d9e48dfbea
x-ms-traffictypediagnostic: PH7PR11MB5817:EE_
x-microsoft-antispam-prvs: <PH7PR11MB581781F02B2975165219D66787259@PH7PR11MB5817.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:949;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o7kOnbx15V1ldAdN8vDl7doSm3m/SJmFAM8UfQN8457uUeE3XwkVqpN0jt3W/h0spa9zNIz1AV8g+6GDylnACnv3HDUs2O0Ulqxq1zmim8Nt5zziofUMNbnR7IbWmwxqQydlWXVUXquXt9RHN2kxM1EA9Q64c8edNDchUY11dO9qLt/pJVP3+tvm6fqg4+znjOgJ8D5VjLIUg0skjzcwqpqHJhFbguIR5bUUvgifMCHT1+yK04wxKc7GZtRVyJ6P+HhgZzffQ0FMh9hQsgZ4c6siUppxdaX98Xted3bJFSQ1z9mG5pyGzUGdQ1qSvxZyzlByR7DHSi/PJaQXx6IHnUpNHLCwQyzqOdZD43YHGoEM67ZqfvR1MCKOEun9QKHw+nPeYUAzrqEqdi9GTyklSDYJKvLdMS8XYoJrIEoino9rQosSewMh43+WFgN4vwtQlmvRY3+pMdTJeiRhKAC7tSuqQoeoDR0Fw+9fqqNkBA88QQoGTWQ5WsHuG4usFtpWFHSP2vdH0o7xoVkHpMBm145cd8WueKIzWyItjGNUtpJbc0AHIQbVrxD9D4DMfUB3fvlbYPcBt0XZdiJKF/QWMiGb6e7utuiLKdvxKehuDyXuEglchunPqN9nAsnpIX5D1mEbRME1G35ru8F0QsVafi6m1Bi2K0sZP2XfYH5yI8/kqn/H89MFEfk/VBw4kmT7V0gxsffW/ree41I9GV8QoNJdrn3O1mEJ3BZiDJLFyR+FMMF1TvOgLKHPJxI9NcByXTcQ82fdlFZ2Xv5qjaLtpA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4769.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(76116006)(508600001)(91956017)(86362001)(122000001)(8676002)(83380400001)(66946007)(15650500001)(5660300002)(64756008)(38070700005)(38100700002)(4326008)(8936002)(4744005)(66446008)(66476007)(66556008)(31696002)(2906002)(71200400001)(26005)(6506007)(6636002)(186003)(6486002)(110136005)(6512007)(2616005)(36756003)(316002)(31686004)(53546011)(54906003)(43740500002)(45980500001)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZktrT3dlaExVc2o0a3JKM0ZhS1QrSHdOdlFNcEhBd1dLNjJGN0t3S3Vmb2U1?=
 =?utf-8?B?TWdnSFB5R2NHUmJNMThhS3VkdjlNeXExUHIwVGVSQ2YwT2JRM1E0ZUo1VTdx?=
 =?utf-8?B?S3NUK1k2dHFxRDFORHdueWZVZGNFNUZNV2h3c0RYYnp1U3hwek9CY1o4K1ZE?=
 =?utf-8?B?Zi9hQThRU2YvODFwTU52NmVkREFwb3Bwam1oQy9iVUxTaFR2NUpZTW84STdH?=
 =?utf-8?B?V2Y1aWtlcHZ4UXlkcXBlOXJNN2xjV0VXaFNkWHIvWWxiN2p4T0UvYkVySjRy?=
 =?utf-8?B?U09HSjJ4NFJTaVRwMlpyRlFXTkU3aXlLdGFkTG1jdFpBUVpvaEZoemRwSkRr?=
 =?utf-8?B?Rjh1bHpPSVRXd0U2TUs4SWJrNzQwVUZIZGtFdG9PQjhtMFdRRVRLOTVtR2Fw?=
 =?utf-8?B?dm5GblFSZlBiZ0FnVlkwNmNhSFNxQ3Fla0JJajRXVGlVSXcyR2s1NjRtY2Uz?=
 =?utf-8?B?N0xXVGlGaXFhTTJHbDBLRmwvVnhqTGdDZnR1YW16bEJRbW40a0dsSHBBTm1V?=
 =?utf-8?B?a2pRenBuY0Jja0NHRzVtMnlQdWQrY1RxNWRDM1BqYmJLUENrb0c2WllVaXhx?=
 =?utf-8?B?R25HQUZjY3laU1RqakJtdlBPaitoRG1CQTVaUDY0ZWFVektQUk9pUUE2Rk83?=
 =?utf-8?B?QytvRk9QV0lQSjVSOFBrK2NJOEJhRW1ZaFNGczdMTzNweEQ0clNNZURybjU1?=
 =?utf-8?B?WGF0NUdGV0VzeE13SURMR0kwS1lzQjlCTmpjMStIaTQ5WDUwcEdEM0FDaDhJ?=
 =?utf-8?B?dmpLMkVoaHRVQXUvWGNsYTROT1BMaXpXYzR1Y1FEakFWOUUwQlpRRVBVZ1A4?=
 =?utf-8?B?UCtDNEtqTS95RDIvLzNSRkxGWmE5dUVxQzNXbnNMMzY2b3lJRHpDdUM3cS9o?=
 =?utf-8?B?WEs5VWtnblVzcUVqVlJURFYwUzJFSVh1RlhUU2Y3UVZDUXJqa3lJbGVKUkp6?=
 =?utf-8?B?RVlHRElnZ0E2UkgzQnQvTWNKVGxxMDhzTVhYblkxWFZLRWFjMmxxajdzcmRv?=
 =?utf-8?B?TzdjVTFSSTdjMzFoNjZjaW9nL2xtOUxCaXRFVFZ1TVlNd3pUWEJhTlhuVncx?=
 =?utf-8?B?RjVncDY4OWE4eGJxRjN0SFdpa1AyL3cvYm9UUWpPVzZpUzRTckJwUmM4VEll?=
 =?utf-8?B?ZTd3QUw0aWVJRmdPM3FkZnh3eVlBNmJxM1VHbVBqaVdrZ1JnTHAvQlZBVktj?=
 =?utf-8?B?dFBzN1dlT2gwT1dKQ2hUS2pOODdmaGtaUFFlUVFOdk91dEt4SnFHTSttbGhz?=
 =?utf-8?B?REZqcWZRcmhZUGxOSlYxU0FJdFA3UnJ3QUtSVWZoSlNBRWhPQWx5eFlIdkpv?=
 =?utf-8?B?YWk4UjdRdktRNm85WURNcXhJVzJOYmc1Yk1sRnp2U2hpQ0VPajE1MEF1YlZK?=
 =?utf-8?B?Rk1oanpTMUpnby9hNmhxdWthekM5UEJCTHpsWmJtNG9OU01YRnhrZGNYY1RV?=
 =?utf-8?B?eTJ4bFU1U09MeUVmMU8wMFdGcUF5c1Fwaml4emwzZXpURm44RGZMMWp0aUJ6?=
 =?utf-8?B?ejdkc2dETVRIL0RuWWlIdk9wRHl5NElQWWFFRi9vN0hJSFg2MU44ajY3aDNj?=
 =?utf-8?B?Y0doeitRQlZHVmxuSkRURStDTTBWSkhBQWJ1MHZuS21QQkI2Q2gvdDkyTy91?=
 =?utf-8?B?amFNNkpFdlFSc0U4Rk0rTXgxUHNLcXd4L0NwMjRsYWd1alZHQ0VnQS83TWNw?=
 =?utf-8?B?VDhNY3dXZFdINitwTGxmL01DOGJycTFzWENFTGZFbkwxeXd0bEplV2d0Yjhk?=
 =?utf-8?B?eHovR1pLOGR1N0Vkd0tZQ2RpOGxGZVBDb255WGtzSE1pbUNVbnMzSFVaVjlF?=
 =?utf-8?B?bnFVZ1czem9JN0MxWXFYa0NtdjVTUWZvcDhzNUlJVVZWWGI5QkdyRXpmMS9Y?=
 =?utf-8?B?RTJLMm52ZGQ5OXdGME5LdDN0OHZJdkJGSXF1UDg3ZUNoOTJiSUFpRmt1THVo?=
 =?utf-8?B?UFlBbGJpbDdMdnZVM0Y3Q25xUGhGbnpGN0pUZGFxSzdsOTAwY29mQkZCWHU4?=
 =?utf-8?B?VzhIY3Y4VGh1ZDB3QkN4eE5OQ1QwalBteStXdnVJRGpQTG4wOWVhYVhJSUpC?=
 =?utf-8?B?QzRKL3pqZ3J0TW9WTWQ0eFRUOHpxb1hBc2l2UVIwZFRXNDVvbk1kL2NrUTlP?=
 =?utf-8?B?MHZ3aGthQXErR3pYZVpUQmwrbXU0VGVtNVNEK2k5SVRPOXNhRUZaRk5HY3RY?=
 =?utf-8?B?NUlTWGFlVTROb2lPNzVpYnBjZ1hmOWw4ZkZCTzVJNWdraTRTOXhoZm1JVkhV?=
 =?utf-8?B?bnpvUDAvc2ozTVphV0VwRTNSUXh3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3102EA973D65CB4AAAA78CC27A3CB097@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4769.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b16ea401-0e08-498e-cbb8-08d9e48dfbea
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2022 07:47:51.6844
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mtOZsngo7RqFabq3PJmvZSgXL+Bc68fPhXaHvTprSTSA8SDh4IXqkaQug6fu+I26w0sVTQUgXD0CSjUvgeVhdyup6zFvWpd/1BzSoDtoDg8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5817
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMzAuMDEuMjAyMiAxNjozOSwgbmljb2xhcy5mZXJyZUBtaWNyb2NoaXAuY29tIHdyb3RlOg0K
PiBGcm9tOiBOaWNvbGFzIEZlcnJlIDxuaWNvbGFzLmZlcnJlQG1pY3JvY2hpcC5jb20+DQo+IA0K
PiBBbGlnbiB0aGUgYmluZGluZyBkb2N1bWVudGF0aW9uIHdpdGggdGhlIG5ld2x5IHVwZGF0ZWQg
TUFJTlRBSU5FUlMNCj4gZW50cnkuDQo+ID4gU2lnbmVkLW9mZi1ieTogTmljb2xhcyBGZXJyZSA8
bmljb2xhcy5mZXJyZUBtaWNyb2NoaXAuY29tPg0KDQpBY2tlZC1ieTogQ2xhdWRpdSBCZXpuZWEg
PGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQoNCg0KPiAtLS0NCj4gIERvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vYXRtZWwtYXQ5MS55YW1sIHwgMyArKy0NCj4gIDEg
ZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2F0bWVsLWF0OTEu
eWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vYXRtZWwtYXQ5MS55
YW1sDQo+IGluZGV4IGM2MTJlMWY0OGRiYS4uZmY5MWRmMDRmOWY0IDEwMDY0NA0KPiAtLS0gYS9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2F0bWVsLWF0OTEueWFtbA0KPiAr
KysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2F0bWVsLWF0OTEueWFt
bA0KPiBAQCAtOCw3ICs4LDggQEAgdGl0bGU6IEF0bWVsIEFUOTEgZGV2aWNlIHRyZWUgYmluZGlu
Z3MuDQo+ICANCj4gIG1haW50YWluZXJzOg0KPiAgICAtIEFsZXhhbmRyZSBCZWxsb25pIDxhbGV4
YW5kcmUuYmVsbG9uaUBib290bGluLmNvbT4NCj4gLSAgLSBMdWRvdmljIERlc3JvY2hlcyA8bHVk
b3ZpYy5kZXNyb2NoZXNAbWljcm9jaGlwLmNvbT4NCj4gKyAgLSBDbGF1ZGl1IEJlem5lYSA8Y2xh
dWRpdS5iZXpuZWFAbWljcm9jaGlwLmNvbT4NCj4gKyAgLSBOaWNvbGFzIEZlcnJlIDxuaWNvbGFz
LmZlcnJlQG1pY3JvY2hpcC5jb20+DQo+ICANCj4gIGRlc2NyaXB0aW9uOiB8DQo+ICAgIEJvYXJk
cyB3aXRoIGEgU29DIG9mIHRoZSBBdG1lbCBBVDkxIG9yIFNNQVJUIGZhbWlseSBzaGFsbCBoYXZl
IHRoZSBmb2xsb3dpbmcNCg0K
