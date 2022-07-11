Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9749956D2E9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 04:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiGKCOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 22:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiGKCOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 22:14:19 -0400
X-Greylist: delayed 65 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 10 Jul 2022 19:14:18 PDT
Received: from ms.asus.com (ms.asus.com [103.10.4.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D862140C7;
        Sun, 10 Jul 2022 19:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=asus.com; i=@asus.com; q=dns/txt; s=asuscom;
  t=1657505738; x=1689041738;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kDBn8cx8gK2IgaTxT/Q5+5qtBkac7HGhZbK8hfgISnA=;
  b=KqnwCmRloUZ7clTmlliJgUfhXIrBqkvdT7Onb8nRldTW1puZVcWoi94y
   VSpLt8CETyfNE0SO1EFox1Rc/a0AR7vTJ4f368hGKyVOCqkX+m6ooAEet
   hvFTXuARNS+8M5vQfxIN3jVpTFG5Uhq1/XSawmutahlxlHUfQe05JqcDk
   E=;
IronPort-Data: A9a23:Qjp8iq4cjOWJr2KdQh7qLwxRtPPGchMFZxGqfqrLsTDasY5as4F+v
 msYWW7VbPvZZmugL4t2bI/k90NX75TTyYBmQANl+C42Eysa+MHIO4+Ufxz6V8+wBpSYFRo4t
 a3ySTViwOQcFCK0SsKFb+CJQUFUjP3OHvymYAL9EngZqTVMEU/NtDo48wIHqt8w6TSGK17V0
 T/Ci5W31IiNgGYc3so8sspvmTs31BjAkGpwUm8WPJiniGTje0w9V/rzE00Rw0zQGeG4FsbiL
 wrKISrQEmnxp3/BAfv9+lr3n9Fjrhc/8mFih1IPM5VOjCSuqQQIw4k4DPsNTH0J1T/Yg8Ir1
 dBmrKyZHFJB0q3kwIzxUjFkK2RbEeh4oOaBKn+lqcqe0wvPaGb3qxlsJBhpZ8tCoKArXicXq
 pT0KxhUBvyHr9q/zL6qSfFbt80kBMDwIZhZsXZlpd3cJah5Hs6ZGPySjTNe9BQrwfIUJdiPX
 so+ajtgURfpYztwY25CXfrSm8/t3BETaQZwqF6Yqq0672X71gF90LHxdtHSf7SiTMNZjwCDp
 m/Y9GT0BBIdHNOawDuBtHmrg4fnnDjjUY4eBZW38/drhBuYwWl7IBgZT1ygutG9i0ijS5ReL
 VAZ/mwlqq1a3EesVNT7Qxy+5nWEtwQNc9VVGuw+rgqKz8L85xuaC0AATDlHZcdguMIoLRQy0
 laVkdTzAHljqryLRGjY5ufKhS29NDJTLmIYYyIACwwf7LHLpIA1kwKKTdt5FqOxpsP6FCu2w
 D2QqiU6wbIJgqYj3q6j/AzOmC+344XSQxQd4gTMQnnj9QRkfoWoaYuy5lWd6/tcRLt1VXHY4
 yJCwZLYsL9IVM7leDGxfdjh1YqBv56tWAAwS3YwRvHNKxzFF6afQL1t
IronPort-HdrOrdr: A9a23:sAzgy621m08QcNb7m59WcgqjBQlyeYIsimQD101hICG9Lfb2qy
 n+ppgmPEHP5Qr5AEtQ4+xpOMG7MBHhHO1OkPQs1NCZLUPbUQqTXcpfBOTZslvd8kHFltK1kJ
 0QCJSWa+eAQGSS7/yKmTVQeuxIqLLsnsGVbKXlvg9QpGlRGuZdBmxCe2Om+zhNNW577O0CZf
 6hD6R81lmdUEVSSv7+KmgOXuDFqdGOvonhewQ6Cxku7xTLpS+06ZbheiLokis2Yndq+/MP4G
 LFmwv26uGIqPeg0CLR0GfV8tB/hMbh8N1eH8aB4/JlZQkEyzzYKriJaYfy/Azdk9vfq2rCV+
 O84SvICv4Dqk85uFvF5CcFlTOQlArGoEWStWNwyUGT3vARAghKTfaoweliA0LkAgMbza9B+b
 MO0GSDu5VNCxTc2Cz7+tjTThlv0lG5uHw4jIco/gpiuKYlGctsRLYkjTRoOYZFGDi/5JEsEe
 FoAs2Z7PFKcUmCZ3ScumV02tSjUnk6Ax/DGyE5y4So+ikTmGo8w1oTxcQZkHtF/JUhS4Nc7+
 CBNqhzjrlBQsIfcKo4DuYcRsm8DHDLXHv3QSuvCEWiELtCN2PGqpbx7rlw7Oa2eIYQxJ93g5
 jFWEMwjx9GR6svM7z94HRmyGG8fIzmZ0Wd9ih33ekLhoHB
Received: from unknown (HELO TP-MD-V01.corpnet.asus) ([172.22.47.17])
  by ms.asus.com with ESMTP; 11 Jul 2022 10:14:09 +0800
Received: from TP-EXHB-V02.corpnet.asus (172.22.6.14) by
 TP-MD-V01.corpnet.asus (172.22.47.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Mon, 11 Jul 2022 10:12:48 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (104.47.110.47)
 by TP-EXHB-V02.corpnet.asus (172.22.6.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.9
 via Frontend Transport; Mon, 11 Jul 2022 10:12:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EyFmOJuD0aH8rSyec3UIF5OPI9ppi+ni41rG8MKlgvSHZ9ZcoVGSeJ+KvqLn2k+VO92oIk2cYXfglECeXNt7Nvnfo6NU4PpeMC6CFkBDB2jlAY2NZWuwR0Ekz5eJBfLjuOrBq2tCkH3MlPObXGu75fopAfM1PWbU+IC6FX+c4V35bwXV5JPIAThRuO4B4bmRUosZf64rwZVW3xuTQhDj73y7BYSVZLZ+CRlZBzKlBB6zjLK0DQYBQE5f/ED0iK0Wl0Cs74cMhChYKTi1JlV0CPpwi5hVCk6pDGDC5RxHDbusR8zVN6N301JeJo3IYiFtY5QdWegWQfwnYNYGGPrJ4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dov/ZfAtr8qQguSDSvHhbCKOXdmFipjVt1yGmJEzvb0=;
 b=c91/9zkPTe5lGDA8kejQGfSGIo55MApe0tnDA3sEwM9BKOlEfuwkKOENo30J4WP0rmDKSWZwhCyJNokm9grmRygmfY4D/r3CyCMV82ILNEpIhZdA21GFb7KEOOtPQtw3TMnnh80C6qzFpVY8qqIz8kJssN3Ok1ypIUuYoXUT1urjteJP7jf+cg1XqVug5/FZUlQM1pJ7w/xu1dP3EAsWmdxOeqoWH4wqXgNyafrBDrLCxAeahyi1ZtRj5Ua42e1JXA+hBhPH3BcdEAfAJ6HX8ELlB2paUjVHxPhEMTtwh5x81HqhnkKIaPTfm6SHPlDViFvwkJu0gKFqlB1AZ8TCEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=asus.com; dmarc=pass action=none header.from=asus.com;
 dkim=pass header.d=asus.com; arc=none
Received: from HK0PR04MB3363.apcprd04.prod.outlook.com (2603:1096:203:8b::14)
 by PSBPR04MB4053.apcprd04.prod.outlook.com (2603:1096:301:10::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15; Mon, 11 Jul
 2022 02:12:47 +0000
Received: from HK0PR04MB3363.apcprd04.prod.outlook.com
 ([fe80::5032:7603:6171:2fc1]) by HK0PR04MB3363.apcprd04.prod.outlook.com
 ([fe80::5032:7603:6171:2fc1%6]) with mapi id 15.20.5417.025; Mon, 11 Jul 2022
 02:12:46 +0000
From:   =?utf-8?B?UGFkZHlLUCBZYW8o5aea5ZyL6bWsKQ==?= <Paddykp_Yao@asus.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        PaddyKP_Yao <ispaddy@gmail.com>
CC:     Mark Gross <mgross@linux.intel.com>,
        Corentin Chary <corentin.chary@gmail.com>,
        Luke Jones <luke@ljones.dev>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>
Subject: Re: [PATCH 1/1] platform/x86: asus-wmi: Add mic-mute LED classdev
 support
Thread-Topic: [PATCH 1/1] platform/x86: asus-wmi: Add mic-mute LED classdev
 support
Thread-Index: AQHYkqeWB0dGe0PEgUWBGkyFVWllS610Lv+AgAG+IQCAADPfAIACTlOQ
Date:   Mon, 11 Jul 2022 02:12:46 +0000
Message-ID: <HK0PR04MB33636680A6DC47211560BB43FA879@HK0PR04MB3363.apcprd04.prod.outlook.com>
References: <20220708084816.1140540-1-PaddyKP_Yao@asus.com>
 <20220708090731.1237488-1-PaddyKP_Yao@asus.com>
 <CAHp75Vc-5Py8heCJ4bKh1-7y+U+ycJxRuYdFwiT=NM5=gLqwQw@mail.gmail.com>
 <8211e5ce-7ab0-312d-3d64-00c94440a676@redhat.com>
In-Reply-To: <8211e5ce-7ab0-312d-3d64-00c94440a676@redhat.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=asus.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b7ca6b74-9181-48d6-af81-08da62e2d8e5
x-ms-traffictypediagnostic: PSBPR04MB4053:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +/Zew9SAza+3nXrO9IBp/4ekuEI3ApfdaNn2ylUSvyDx5UjorWL3WmTrCRSmY9aTB/aN2VSUC7ZehO649ShT6SFzdpR/toUVMS29nFQJfmethhJx/K1yMXvPKiqLYtueqKi4MPd/pAc8vEc4nMnISkJw8cVa6ie8UBEgXObu1pnhje4vMTvE+r41RE0+KaW6fg1kqIUVDXTV3lq0cuDFl4JYt+WtDaXcG65vj6VuW6uGNz8bdZZMt9Hk510iVGNYLhVtLkcC/kEbTLETySP6CT4zEzkI5RaExPtM4cLGDlrFqWGv4Mb/yioVhX8BB1wemvp8tm6AX7fQuMO9wAoqJArd2T2QxdAWJri/cUEzWIG8MOgP3uF9P6kv+nF0iafJdBKDHGuW/CxRB/75q9Nnh9OejSZuj6FJI/vfeDrG/mapiLV31DH3pDlus5m8IwlAZDmHuDuwRzUM/TrSjQ52mXWAtXLZdTlh6uicOrSB/Bc6sTATQGxFAE8Xt5OXxhl3rGdRVwRoNpvHszS4IrfsgPzl8JFyNWp3q1Lfw3GwvV9N8KuKYIbkg8l4cYo3GaKax/iUzc/vX6UtQDrqEF32Jx7I41MXW/5zBwCxFvq8XaeDxG4XAAlMpEF7yz7n68XwvMis4+Te+B+9IPdcBgSN0t75ai5Tr/MKt83q2IJzGULWvcTJAL6p52jeMIT8C0VqqvR1jBIxk9ym76Z4XeBLM5qKsbgOyXBZToFrffz1wR9F1cgRGfoYX+uYgSLCUmhTeMACiPBXhwMZwpEz3GZG6lR7wiC3d4RuTzhKLkY9mODaI0Jy0H/TJwu+xP8a+C8N
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR04MB3363.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(376002)(396003)(136003)(366004)(5660300002)(76116006)(54906003)(110136005)(55016003)(316002)(186003)(71200400001)(53546011)(26005)(9686003)(6506007)(41300700001)(2906002)(478600001)(7696005)(122000001)(83380400001)(38070700005)(86362001)(8676002)(85182001)(66476007)(64756008)(4326008)(52536014)(8936002)(66946007)(66556008)(66446008)(33656002)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NFlUYlFyWkRQY1J1YTRsT3lwZmZOWkJVWlJvNWMycDhqNW9nYjMzL1Fvekwr?=
 =?utf-8?B?c2JYZXVNL1I4a1Q4aVA5Q1JnVmNlWDE2WGNjZGFEOTYybmNRcC9Xa0xXbFJC?=
 =?utf-8?B?TTU0WGt4RS84WS8zN3dka2szaDdiQzJDcyt1NmdoMTl5RGVwTG90eWFhNzQ3?=
 =?utf-8?B?VWNFQTc0WDhEckVXTFpaUFpaWkNGSUtHUnlML1ZIZEFrNXZndDI2WHREWVJ6?=
 =?utf-8?B?M2FadWJ5M0dKQ3dwa294MFhaa2ErWGpWaHpGRlFDS281OUVXaVhibGxONmh2?=
 =?utf-8?B?Yy9VR3BtZ2hxek5SUlJXdExISWVCRjVZdWJiVEZiY2ZlQ0xTT0RFYUZGL1ZQ?=
 =?utf-8?B?TGxXQktTUjlUb1VCaUVpNS9QeVhUYjh6YUlXMUd6aTBQOHJXRGRTZ1lMcGdU?=
 =?utf-8?B?Q3ZCY1YraFNDSHRUS01xRTdwdHZWU1dTT0MybERULzJlSlhGcUw1ZDhYMHlN?=
 =?utf-8?B?QTRWWXlYWHJKSGMremJmQ2I0ZXp5MUVORnZGVFRZc1A3V0NyTGhScDgvZ0FX?=
 =?utf-8?B?M05sSkFSdVlYdHNBVFpFcGNHYzZ0ZXhTT2QyUU5TUWFCM0xXNDl4REFiNURB?=
 =?utf-8?B?cmJUUS8wSTVmbVFDcTFJQXdtTUxiK3c0ZGtFOGtYQWRPc05hVGdscThpaGk2?=
 =?utf-8?B?RmhYYU5JZ2NvL3ZHclNZMmJwQWlySnp2MkkxZW9kUHhZY3BzSWRsVU5CakhR?=
 =?utf-8?B?OTdkTWJwbVZRZ1J0UlBYcTJYZ0g0dmx2aTJXSGpWWDFUeEZyT0RVTEh5aXhx?=
 =?utf-8?B?MnU4emJ1d3RhSjY3emFjY3pGOERPOWZRZlo2M0xFVTFvRmN1WlRHc1p0bExs?=
 =?utf-8?B?dTdkQU0rbmQ5aldWWUFnWVJ1ck1VLzdCbC9OSmpuQ1Q3dFFwUkZVOHFwbTJi?=
 =?utf-8?B?OEdqWkpac1YzMXZIL1hFVFlYR1JHeDluRVlrd2lKTTR0TldmQ0xIKythbkUx?=
 =?utf-8?B?NmRLOFQ2cHBGbHNYQ3BsblZQWWNNcE4veGhlOE51ZmQ5VHA4RWUrRVkzZk5M?=
 =?utf-8?B?enZWckNOMHhhVWhxRWppV2taWHRtTStZMXA3RGpKR3pyTWcwVzRnMDVLUWNJ?=
 =?utf-8?B?dUZBNWpxMDNOTFZXU3dLNTlGUVhVZmhVaTNtQlVrdnR5ZUJ6OXI0bktQQWlS?=
 =?utf-8?B?ZEs3bXBDSVVDVUZYV3l2dnZJTHQ4Z3FRK0pmY2Z5enVwdC9aK3EvUHFvQkQ4?=
 =?utf-8?B?VGxsek84end2bmJLT01Fc2ZDUFRVajVCL2c5UytKVHZNeHZXbUN0cEhBZ1kv?=
 =?utf-8?B?ZE1HRVNJbVI2VXN4VTZ0cUJ2eUJiMUtoMStMSkJlWXI5SFJOWGVNa29nY0c0?=
 =?utf-8?B?WHVvLzNVd0NUNVFZVVpyMVFoL2JFKzRxc2NrZTQvRnduY0pQZVdFVU5xWjln?=
 =?utf-8?B?S21GaXlRYUZYWSs4RGdYZVVoSkplSDZKMnNHN0ZlWkxBNER1Q0JEWWt3dHV3?=
 =?utf-8?B?OHppb1V4Y3ZpY2VYbGdsb1VYV2REWnYyUVlRU040RjM4YVJsQWpFOS9ha1lI?=
 =?utf-8?B?UkVES0NiUCs4V1d1aEFzUEJtTmpNMTh1Zm93N3V1RDJyeklGMWRMYkgzZ2Rj?=
 =?utf-8?B?OTI2K1hOYStLbEl1MlNDS0M0RnZIZzA5ZkZreEkrdDNKWXRxWHpUWUJUZ0I4?=
 =?utf-8?B?T0hZeDhCZlU2cVZVT1V1VklPYUgydGdJSmlHZ0p4M3RBNVFlNDI1bmJYY3FU?=
 =?utf-8?B?QkpOUHZLRVRGbmY5c0lDUC9SeFc4VzJKV1ROOHhIOW1QWSsvU21nSVBUYzRz?=
 =?utf-8?B?d0dFZ2dQaC9uZkpLR0ptekJmR205QUhLTjFSM2tsTER6M3JPY1hsM2Q2bG1p?=
 =?utf-8?B?R0NlTks3MThnemc5WlBPRC8wTDVFOTBjYXM3VER6VGFNL3FYZG9jMHh4dy9h?=
 =?utf-8?B?dmlRZWhrbm0zcFNVd3UwalVWcTRucmR3TlovbC9hSXJmMytUZFNVQ0tlQWRD?=
 =?utf-8?B?d1lrNzJpM3NKdHRkMGVEYlZHbnFFbjRpL1JkcytEY2ZoS1FUekMyK1N6TWlJ?=
 =?utf-8?B?ZFByNVYvTmFUaXd5VGVxWC9sMFRQZWIvbXRZcDhKMGZybUdqbU1vd0g1RFRr?=
 =?utf-8?B?aERTSEc2NUdwRmVQejQ0OHVTQjQxYm5KcEk0WUZvT0FVeTZ2enlVSmIxTjho?=
 =?utf-8?Q?6lpKroatkVtBhVkV7KKd4LxlK?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR04MB3363.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7ca6b74-9181-48d6-af81-08da62e2d8e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2022 02:12:46.7252
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 301f59c4-c269-4a66-8a8c-f5daab211fa3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OUTKMID3oZ1cPCm+KW5FhoNdC6O5JBnZcO+KiK3MtmWufGSVmn/94NN6qrcYuzxJ4yP3rD7DUOewabz9sCH/kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSBPR04MB4053
X-OriginatorOrg: ASUS.com
X-TM-SNTS-SMTP: 9DAF8F1C63E1E8DCD73EBD454306EA00F9A48DF8B1A1698EE26FEF31E54241B62000:8
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSGFucyBkZSBHb2Vk
ZSA8aGRlZ29lZGVAcmVkaGF0LmNvbT4NCj4gU2VudDogU2F0dXJkYXksIEp1bHkgOSwgMjAyMiAx
MDo1MCBQTQ0KPiBUbzogQW5keSBTaGV2Y2hlbmtvIDxhbmR5LnNoZXZjaGVua29AZ21haWwuY29t
PjsgUGFkZHlLUF9ZYW8gPGlzcGFkZHlAZ21haWwuY29tPg0KPiBDYzogTWFyayBHcm9zcyA8bWdy
b3NzQGxpbnV4LmludGVsLmNvbT47IENvcmVudGluIENoYXJ5IDxjb3JlbnRpbi5jaGFyeUBnbWFp
bC5jb20+OyBMdWtlIEpvbmVzIDxsdWtlQGxqb25lcy5kZXY+OyBQYWRkeUtQIFlhbyjlp5oNCj4g
5ZyL6bWsKSA8UGFkZHlrcF9ZYW9AYXN1cy5jb20+OyBQbGF0Zm9ybSBEcml2ZXIgPHBsYXRmb3Jt
LWRyaXZlci14ODZAdmdlci5rZXJuZWwub3JnPjsgTGludXggS2VybmVsIE1haWxpbmcgTGlzdCA8
bGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBhY3BpNGFzdXMtdXNlciA8YWNwaTRh
c3VzLXVzZXJAbGlzdHMuc291cmNlZm9yZ2UubmV0Pg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDEv
MV0gcGxhdGZvcm0veDg2OiBhc3VzLXdtaTogQWRkIG1pYy1tdXRlIExFRCBjbGFzc2RldiBzdXBw
b3J0DQo+DQo+IDxhY2NpZGVudGFsbHkgaGl0IHNlbmQgdG8gc29vbiwgdHJ5aW5nIGFnYWluPg0K
Pg0KPiBIaSwNCj4NCj4gT24gNy85LzIyIDEzOjQ0LCBBbmR5IFNoZXZjaGVua28gd3JvdGU6DQo+
ID4gWW91IGhhdmUgc2VudCB0d28gcGF0Y2hlcyB3aXRoIHRoZSBzYW1lIHZlcnNpb24sIHlvdXIg
c3VibWlzc2lvbg0KPiA+IGNvbmZ1c2VzIGV2ZXJ5Ym9keSwgd2hpY2ggb25lIGFyZSB3ZSBzdXBw
b3NlZCB0byBjb25zaWRlcj8NCj4NCg0KTWFueSB0aGFua3MgZm9yIHlvdXIgZmVlZGJhY2sNClNv
cnJ5IGZvciBjb25mdXNpbmcuIEkgd2lsbCBzZW5kIG5ldyB2MiBwYXRjaCBhZ2Fpbi4NCg0KPiBB
bHNvIHRoZSBGcm9tIG9mIHRoaXMgZW1haWw6IFBhZGR5S1BfWWFvIDxpc3BhZGR5QGdtYWlsLmNv
bT4gYW5kDQo+IHRoZSBTaWduZWQtb2ZmLWJ5Og0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBQYWRkeUtQ
X1lhbyA8UGFkZHlLUF9ZYW9AYXN1cy5jb20+DQo+DQo+IGRvIG5vdCBtYXRjaC4gSWYgeW91IHdh
bnQgdGhlIEF1dGhvciBmaWVsZCBvZiB0aGUgY29tbWl0IHRvDQo+IGJldCBzZXQgdG8gbWF0Y2gg
dGhlIFNpZ25lZC1vZmYtYnksIGJ1dCBoYXZlIHRyb3VibGUgc3VibWl0dGluZw0KPiBwYXRjaGVz
IGZyb20geW91ciBBc3VzIGVtYWlsIEkgY2FuIGZpeCB0aGlzIHVwIGZvciB5b3Ugd2hlbg0KPiBh
cHBseWluZy4gUGxlYXNlIGxldCBtZSBrbm93IGlmIHlvdSB3YW50IG1lIHRvIGRvIHRoaXM7DQo+
IG9yIGZpeCB0aGlzIGlzc3VlIGZvciB5b3VyIG5leHQgcGF0Y2guDQo+DQo+IFJlZ2FyZHMsDQo+
DQo+IEhhbnMNCj4NCg0KSSB3aWxsIHJlc2VuZCBwYXRjaCBhZ2FpbiBieSBteSBBc3VzIGVtYWls
Lg0KDQo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PQ0KVGhpcyBlbWFpbCBhbmQgYW55IGF0dGFjaG1lbnRzIHRv
IGl0IGNvbnRhaW4gY29uZmlkZW50aWFsIGluZm9ybWF0aW9uIGFuZCBhcmUgaW50ZW5kZWQgc29s
ZWx5IGZvciB0aGUgdXNlIG9mIHRoZSBpbmRpdmlkdWFsIHRvIHdob20gaXQgaXMgYWRkcmVzc2Vk
LklmIHlvdSBhcmUgbm90IHRoZSBpbnRlbmRlZCByZWNpcGllbnQgb3IgcmVjZWl2ZSBpdCBhY2Np
ZGVudGFsbHksIHBsZWFzZSBpbW1lZGlhdGVseSBub3RpZnkgdGhlIHNlbmRlciBieSBlLW1haWwg
YW5kIGRlbGV0ZSB0aGUgbWVzc2FnZSBhbmQgYW55IGF0dGFjaG1lbnRzIGZyb20geW91ciBjb21w
dXRlciBzeXN0ZW0sIGFuZCBkZXN0cm95IGFsbCBoYXJkIGNvcGllcy4gSWYgYW55LCBwbGVhc2Ug
YmUgYWR2aXNlZCB0aGF0IGFueSB1bmF1dGhvcml6ZWQgZGlzY2xvc3VyZSwgY29weWluZywgZGlz
dHJpYnV0aW9uIG9yIGFueSBhY3Rpb24gdGFrZW4gb3Igb21pdHRlZCBpbiByZWxpYW5jZSBvbiB0
aGlzLCBpcyBpbGxlZ2FsIGFuZCBwcm9oaWJpdGVkLiBGdXJ0aGVybW9yZSwgYW55IHZpZXdzIG9y
IG9waW5pb25zIGV4cHJlc3NlZCBhcmUgc29sZWx5IHRob3NlIG9mIHRoZSBhdXRob3IgYW5kIGRv
IG5vdCByZXByZXNlbnQgdGhvc2Ugb2YgQVNVU1RlSy4gVGhhbmsgeW91IGZvciB5b3VyIGNvb3Bl
cmF0aW9uLg0KPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT0NCg==
