Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1464A7E3B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 04:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349157AbiBCDJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 22:09:50 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:58104 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234912AbiBCDJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 22:09:48 -0500
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 29C93C011E;
        Thu,  3 Feb 2022 03:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1643857788; bh=RnJR4Nm0tlqoAVeD2uScofui0K3k/6rULvtsCOHQ/7A=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=II6UEMnTMP5rPgqV4WZX3K/5O0AbP/GKtW7LaDO5qYP+Pj1AX72Ob5Fsknaue2TLC
         f546WKVEExN/PisrGBL7h716UzRHLf22aSfN9g7FF82/PmQk5Om1N0K3vbhGFBAs9z
         hE9aqcBhFe+QmAQdAJvU+zNmNDvylKmN1nclOE3fCwuJNMEJ00Lnlw5N4JRowTx//J
         8meHdYNai/4Ge14GoeCUQgLq3LiIH00SuXXTtUoKInstp9IO/osxtralG9r0Zj3/NG
         Ho48qjhAyjrhzQUktOXcSK/Hvr2XKg6Be7muy3zy6wh6IZRMCMrh4VNPl7BMzDCImz
         6b35MEUkmhc1w==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 5CC6AA0081;
        Thu,  3 Feb 2022 03:09:43 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 9BCE3800B6;
        Thu,  3 Feb 2022 03:09:40 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="ea4s9tJ7";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qyn7MsbfrgBBZMiV8E3L11C5LqGA6djMW1efQgXnv/pkxtgUXsmfGvooMwAmpQcYosi2djli0CU24CGzRR/ptoPz+a3HIYC80hlIpIc64816sutHmlJz+Tbhy7k7J+DFek40lvrhgRjcN3/9lO+y0/+/ak8f45FeoK1dka94ppmoMknyuFZli8Ls3WIATLCb2qPk4N7kiQz4kmWRbnvu0zuWrC+w3ImF3sUWZ04sLAQFZ7HKOPdAmImE+ah3Let7153DB/uQhKhUCRJxjdzPGKPFPnlymdmzIs9SpCfRMYmQPFqX9274PAkqWbiVog+MEraVCrIf+2RZckUC3xQe2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RnJR4Nm0tlqoAVeD2uScofui0K3k/6rULvtsCOHQ/7A=;
 b=Gr9qbnRn1+4beW/CREw1LqcK2pmJPjtYodqCcn7gUM2eoWo/D2wFK8Jy+rax61ylqMWEOMMqU3hH8DZbO+un6RIk9Ug3BpXn3Yky4R6HysdMhu2r5/OYRlSF5CkEc23buOtDPRBiewvbqdXJ8HnTYHcyU1PdPK8qpZfRYmPNpfXkZRp5RpYsawO7bqGsYsQTwU4bkTtsUSAo50IKxvecAFAoat5/7LW3+BevsIftfXZsFF12iO0sj8MDKqvf8AAXX/A6V6K8vT3CmvHM8hj2XGzfmmDWBEagzLxxMCqV+mCARYUmV/cOOFtSy+YICbe/oGvMZCCefC5gywl42v4ykA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RnJR4Nm0tlqoAVeD2uScofui0K3k/6rULvtsCOHQ/7A=;
 b=ea4s9tJ7QFmw1rZxMOX0fiIRV9ul7pt3Vt+cGTcMOG5u4f9Lpl1k98nJ3Bfj1/4yUnQHPElnsCbCrw7BB0nTwP/3k6j7YPXa9eGrgwYtBcsAGnEEqQAzNiAmmOJDtswd6DZ4NtZ6waq2+RYIoLvWUx5XWw5KPxRU/rNMQY850r0=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by PH0PR12MB5419.namprd12.prod.outlook.com (2603:10b6:510:e9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 3 Feb
 2022 03:09:33 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::c5f4:5df4:b5bf:b13e]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::c5f4:5df4:b5bf:b13e%3]) with mapi id 15.20.4930.022; Thu, 3 Feb 2022
 03:09:33 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Sean Anderson <sean.anderson@seco.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
CC:     Robert Hancock <robert.hancock@calian.com>,
        Baruch Siach <baruch@tkos.co.il>,
        Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Balaji Prakash J <bjagadee@codeaurora.org>
Subject: Re: [PATCH v3 3/7] usb: dwc3: Calculate REFCLKPER based on reference
 clock
Thread-Topic: [PATCH v3 3/7] usb: dwc3: Calculate REFCLKPER based on reference
 clock
Thread-Index: AQHYE7l0lGfdNeSKqky3xXQjlQCZuayBL3oA
Date:   Thu, 3 Feb 2022 03:09:33 +0000
Message-ID: <bdbebb19-f132-b809-239f-51993acd7ad4@synopsys.com>
References: <20220127200636.1456175-1-sean.anderson@seco.com>
 <20220127200636.1456175-4-sean.anderson@seco.com>
In-Reply-To: <20220127200636.1456175-4-sean.anderson@seco.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fefee045-0e61-48d1-9334-08d9e6c29a13
x-ms-traffictypediagnostic: PH0PR12MB5419:EE_
x-microsoft-antispam-prvs: <PH0PR12MB5419BE647012C83152D3CE9FAA289@PH0PR12MB5419.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1850;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0VasCTvYGbWOFqE2IIWX4rsb6NJA0W+KWDIuZruxhnmemAt0QLA6S/4hH3I32A7aQmkgX5vKvSiQRr2b5+bZ0oNjrgDyhg9aBSY0X4f93ddT6zt0F6T3b/2zIk6emsnTBvBe/jyDmtwtZ/0B8qmBp83U2x12ApZZE+NE5enYzW7XI9Y5lXFCZ+sdwZtx0i6LmW8dkdSJFBO6dhrvJQPXa2HTTIbAaMj1VgpJxOHGXMwlaYxKpQ4NZRQxSyoPD876kE4EQBJDZbbHXhgK3ha1wPB0nZpPV832PmIhcOjW8LlohegZu8BpiIzcu67R7LfDIU950Fs1I92T2ZRkNNMalLkBybHslb7u/nMwCAYN6EL4/CI80OfSR7g3VxGx1UWkBxacPZqAOSd99mI9PhGdYyEJlJf1FeYtP+d/zEdT8nmXlMczzAsjoDgwDpu+smZltSpYNUX8xpnYa799g/3R4kaOdfUYl/S/GnTazXxaiF3d4J/v6lsZIjagTcxtp+itVhMka3Ao1/DDomQke7QhkZT4G8otlwHVxxv148I6GcXgCsFmwrFO0qekGz2n4+yoMwSelnzfW9F6qvF0NybkjnJVMhaxi6PqRieAwtYnS5HhKXIaSwTpV7RAH97uaVcLinXlkcl02SCftC0pLuTNBqaIRTIJnGU1kGp3jyh1XT0UvRDU5TCPwHyDHG00PY1qEIGxmGWHnVaDpuV+CL92jFXADtSyBQOG40Ok1Sm2rYm8UnCjte7/ze9D6HLulDlsQX7DFnLAufxvR6LVeoaIKA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(122000001)(2906002)(6506007)(6512007)(5660300002)(83380400001)(66476007)(508600001)(86362001)(6486002)(38070700005)(54906003)(31696002)(36756003)(71200400001)(66556008)(64756008)(76116006)(2616005)(4326008)(8676002)(8936002)(66946007)(110136005)(186003)(31686004)(66446008)(26005)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QTh5c0xSWGRMSVh4Y2krNE1iTTE4SGw4WFpXY1FySy9XNElOdkl1WTZHMys4?=
 =?utf-8?B?MGRTUFFnaTU3QXl2aW5pdzdMTlNxaDJPZnpJMU5HRXNWTmhVcWJZRmZNNDlU?=
 =?utf-8?B?SHZYUUJWdFJNZWJSUnhFQUl5R0VxUXFFV1k0TXh4elFlR080RGVCeDRyRHFi?=
 =?utf-8?B?L004Zm13SFdMbHgwcEpkc2EwTmZWdmRpdUVVeXhTa08vQXRTenI4ZFNNUDNP?=
 =?utf-8?B?b0FrNXUrSThVbGduOXlYNm85MzFOMGRDNDJqTzZpQVhXdGF2YjVvU1FrOW9P?=
 =?utf-8?B?eE1OUDNHMzk3bllvcWdQcmEyN2ZwdEZMVGV5VTJ6bThZYmQzZHZ2a25aRTVy?=
 =?utf-8?B?MTRiNFgxdWE5UDZWL2lBZ2ZFUnFtUFpqdW91SUl6OVpsSUdjRnJkZ1ZZeTRy?=
 =?utf-8?B?Ryt1VWNXdDJ5d2MwUEpNWE8rdzE3YjYwWURESmN1RWJtWHdzVmJCS0xkTEVL?=
 =?utf-8?B?VUVkb2tuNmxSSTNRMjhDWmowRU15TExINUkzMzFweGp0QW9WeG9zVmgzN296?=
 =?utf-8?B?MWVhN2d2ZG9SMmppbmJZbEtneW5Delg1Z0s2OStGL0xjNnJsNUlqZ0hmNUVK?=
 =?utf-8?B?MVJLN0JtNzdINVc5NjA4UXlKa0tPQy9LeTRsYm4wOG1udTdJWVFtSC9TQVZG?=
 =?utf-8?B?c0RKeE0xQjc4NmpldXdoeHhTMmxHTkEzTy9ldkFlN0lVaEc5VFZCZkZNT1F5?=
 =?utf-8?B?WXlJRU5kOTBya2QzYlh1V3Z3NGw1bkVJcFJ5TGVWS1pEQmgrdE91YS9QQlcw?=
 =?utf-8?B?dzhXRjhYaEE1OWRaYndneHhMS2VZUktVWnYxTzJzNXkvdnV0eFRQY1NZSHFa?=
 =?utf-8?B?TFhrenY4dDduck5KMWM2K3pGbU8zNDQ2REFSNUU3eDV4Vm4xNGlKSzY1NjdC?=
 =?utf-8?B?T2VVdzlWcStNc3pJQ3F3THNEVDVQWW5NMzMxbXdZUWZRZGhJZi9zSStrVWYx?=
 =?utf-8?B?cmYvaU5vOEZWclA0OS96RERwd0ZESTJQVzZmeCsvL0t5SUFIWEVuQTdmOVRo?=
 =?utf-8?B?Z1JQWVgwTG5Qa0FzMDFaRkxON1Y2T3BIWXhHOThNOGF5RVdkVVR1YytZQmt4?=
 =?utf-8?B?YkFzUG9OK1A4Z2xiMTRmdFhrc2hCdkowK0JnM1dPK3RHZ21qZmtPV3hSNVE0?=
 =?utf-8?B?bzUyUmVJNzM5d3pSWXpRT3lIdGNPVEhaUnBYbnpIdTcyWlJLRjNqR2g0VnJH?=
 =?utf-8?B?aEZzQ1dpUGpnRnlhdWhWMTZ0UE5KK0tBd1pWa0JCV2lzN2RtbkVJeU5NaEVZ?=
 =?utf-8?B?ZlRDMGFYVnUrd1I4WXora1BhSWRpRm44bVNwdkcvYVBVVitNSTZZTG95M1RM?=
 =?utf-8?B?WFBBdm12WHA4dVIrK29uTXRBak84YUMxZ0s1SGgxbXdkUHBBZkxKWFN1Y1Yz?=
 =?utf-8?B?UDIwcnN1azliNGxvMDZSWXdHTDVZbFJ6dmdLa2JYcVdDdmNPV1ZQZlFqMUVS?=
 =?utf-8?B?ZVZMa1N3R3M5Z3JBaGpGbm8wSVJOem10T29ma1NOaXhwd0UvVnhrbVhSSEw5?=
 =?utf-8?B?b09EOGhwYzYzNG1lV3RGTHVyNi81bG5ob2V5ditFaGxHeU52a3pZbXkvR1Fi?=
 =?utf-8?B?TlhEQkF5TVBJb2lqaFdoN2phQjF2VHRoQ1ZYYlJaVmFFK3VtSlA5dklDOWdp?=
 =?utf-8?B?SWkrOUFuVnRvNzkrTlVrNFM4RTVGbTF5ZG0zYkgwNGxLU0VsYTJvMVpHV0xI?=
 =?utf-8?B?YU1RMjBUNDVEM0FRemhYRDIwd2wrODJQMXo0YkkxdkhOZWxPdkFmYmJrdHo3?=
 =?utf-8?B?dHdxdWtNcEZadk9tRDd6UXFJY1RnNXRwS05yTVAwK04yendRZjJTSUw4NGg3?=
 =?utf-8?B?Zm5sTWsycGNyUmd4aVU2L3J6aGNVbEFSUGFiWnNTRjFhbS80VW9NMFlMSkEy?=
 =?utf-8?B?MzV5T29GeURKckx6Mmh4UU5MMGtUVjFpcEcveFpOV2JQdXBMOHdVcjV1UEZJ?=
 =?utf-8?B?KzFVaXRMMFltcFoxOElsYjEwenNXUmFwcGxKZm5VRkE3RERHT014ektwR2Qr?=
 =?utf-8?B?SlYzaFQzcUwvUnpDQVc4Y2ZpS1puN3NZcFJERHJsdWY5TnFQMHozTW1CbmtX?=
 =?utf-8?B?V01na1p5SU5TbFUydkdFV3RGOThrRG5vSFZLNkdlR1Z4dXV3VnFCb251ajBo?=
 =?utf-8?B?bTN6bzJYNUpHZHFwOEVvNmpJSlFPeXZZNndGbXVTUHFlbnZBSW0wSnVzaU96?=
 =?utf-8?B?T2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CB14CEE03DBFD9448C60BAA72A8843A1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fefee045-0e61-48d1-9334-08d9e6c29a13
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2022 03:09:33.1872
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mzrXlpLljZWCzUwRDyNefRp3sRDRlIa/YdnDJLj0AvbwaORrDQl90jDMUzbzlQgHuPdkzZzfjL7A0CRMS89JtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5419
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U2VhbiBBbmRlcnNvbiB3cm90ZToNCj4gSW5zdGVhZCBvZiB1c2luZyBhIHNwZWNpYWwgcHJvcGVy
dHkgdG8gZGV0ZXJtaW5lIHRoZSByZWZlcmVuY2UgY2xvY2sNCj4gcGVyaW9kLCB1c2UgdGhlIHJh
dGUgb2YgdGhlIHJlZmVyZW5jZSBjbG9jay4gV2hlbiB3ZSBoYXZlIGEgbGVnYWN5DQo+IHNucHMs
cmVmLWNsb2NrLXBlcmlvZC1ucyBwcm9wZXJ0eSBhbmQgbm8gcmVmZXJlbmNlIGNsb2NrLCB1c2Ug
aXQNCj4gaW5zdGVhZC4gRnJhY3Rpb25hbCBjbG9ja3MgYXJlIG5vdCBjdXJyZW50bHkgc3VwcG9y
dGVkLCBhbmQgd2lsbCBiZQ0KPiBkZWFsdCB3aXRoIGluIHRoZSBuZXh0IGNvbW1pdC4NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IFNlYW4gQW5kZXJzb24gPHNlYW4uYW5kZXJzb25Ac2Vjby5jb20+DQo+
IFJldmlld2VkLWJ5OiBSb2JlcnQgSGFuY29jayA8cm9iZXJ0LmhhbmNvY2tAY2FsaWFuLmNvbT4N
Cj4gVGVzdGVkLWJ5OiBSb2JlcnQgSGFuY29jayA8cm9iZXJ0LmhhbmNvY2tAY2FsaWFuLmNvbT4N
Cj4gLS0tDQo+IA0KPiBDaGFuZ2VzIGluIHYzOg0KPiAtIERlZmluZSBlYWNoIHZhcmlhYmxlIG9u
IGl0cyBvd24gbGluZQ0KPiANCj4gIGRyaXZlcnMvdXNiL2R3YzMvY29yZS5jIHwgMTQgKysrKysr
KysrKysrLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9u
cygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jIGIvZHJpdmVy
cy91c2IvZHdjMy9jb3JlLmMNCj4gaW5kZXggNjk5YWI5YWJkYzQ3Li4zOGZlZjVjNzQzNTkgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+ICsrKyBiL2RyaXZlcnMvdXNi
L2R3YzMvY29yZS5jDQo+IEBAIC0zNDcsMTQgKzM0NywyNCBAQCBzdGF0aWMgdm9pZCBkd2MzX2Zy
YW1lX2xlbmd0aF9hZGp1c3RtZW50KHN0cnVjdCBkd2MzICpkd2MpDQo+ICAgKi8NCj4gIHN0YXRp
YyB2b2lkIGR3YzNfcmVmX2Nsa19wZXJpb2Qoc3RydWN0IGR3YzMgKmR3YykNCj4gIHsNCj4gKwl1
bnNpZ25lZCBsb25nIHBlcmlvZDsNCj4gKwl1bnNpZ25lZCBsb25nIHJhdGU7DQo+ICAJdTMyIHJl
ZzsNCj4gIA0KPiAtCWlmIChkd2MtPnJlZl9jbGtfcGVyID09IDApDQo+ICsJaWYgKGR3Yy0+cmVm
X2Nsaykgew0KPiArCQlyYXRlID0gY2xrX2dldF9yYXRlKGR3Yy0+cmVmX2Nsayk7DQo+ICsJCWlm
ICghcmF0ZSkNCj4gKwkJCXJldHVybjsNCj4gKwkJcGVyaW9kID0gTlNFQ19QRVJfU0VDIC8gcmF0
ZTsNCj4gKwl9IGVsc2UgaWYgKGR3Yy0+cmVmX2Nsa19wZXIpIHsNCj4gKwkJcGVyaW9kID0gZHdj
LT5yZWZfY2xrX3BlcjsNCj4gKwl9IGVsc2Ugew0KPiAgCQlyZXR1cm47DQo+ICsJfQ0KPiAgDQo+
ICAJcmVnID0gZHdjM19yZWFkbChkd2MtPnJlZ3MsIERXQzNfR1VDVEwpOw0KPiAgCXJlZyAmPSB+
RFdDM19HVUNUTF9SRUZDTEtQRVJfTUFTSzsNCj4gLQlyZWcgfD0gIEZJRUxEX1BSRVAoRFdDM19H
VUNUTF9SRUZDTEtQRVJfTUFTSywgZHdjLT5yZWZfY2xrX3Blcik7DQo+ICsJcmVnIHw9ICBGSUVM
RF9QUkVQKERXQzNfR1VDVExfUkVGQ0xLUEVSX01BU0ssIHBlcmlvZCk7DQo+ICAJZHdjM193cml0
ZWwoZHdjLT5yZWdzLCBEV0MzX0dVQ1RMLCByZWcpOw0KPiAgfQ0KPiAgDQoNClJldmlld2VkLWJ5
OiBUaGluaCBOZ3V5ZW4gPFRoaW5oLk5ndXllbkBzeW5vcHN5cy5jb20+DQoNClRoYW5rcywNClRo
aW5oDQo=
