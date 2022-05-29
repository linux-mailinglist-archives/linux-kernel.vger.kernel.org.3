Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAAC1537182
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 17:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbiE2PVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 11:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiE2PVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 11:21:08 -0400
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120050.outbound.protection.outlook.com [40.107.12.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DECE437A94;
        Sun, 29 May 2022 08:21:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OethoODTQ+e88VpDwBmqo/zv8M3H6OXxv1YCU22BinjAqgM1jfuoFXYJvL4KtSSCsloErbUNvB4T8pLz6SgVX0KXdkDD6QQAsLnjtabBIX+CA7F7RPMy3KZfdiC61inhizUTrZ20XVCQZQRk27OQ/dVrhUH0mVMmo0qvzvqF5dU8QnaYKdcY7FhyNwpVux4UkhXVOcmlpeQ8eUevgvpYTNxwCBAb6NVY+EdKdZpywyN5guoDw6LvkZJTeVhUm390oRDvxKdNmdWj/Pyr+gspNA0cc1Fm31IRDJ2CXrTuWYetrJqDyNysgA4rQLScJLNz3DLE4KU6pHqU1eFNJe6/1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MkmA7zfH54CmVki2cVJBEomV+JKtkgDT4ElXm0GxMAs=;
 b=OiGxDSeCAgM1C+FLSfnjWsO9CNrBjCwxSggjApEOAh4AsVirNwplbqCMwVtR+1YP1SpwBX5uFn4zeC3jDZ41fBfZ/gIR2by1RbWPmHz9nZdSi0dT1wbywMbnEoInZ+FjCjlmQBdLjEhyzVZsvCq8XiylnHUHMdL6rcLjIgZsOuCk0raHVbDT3BRcn6RCNUl6+M7Q+dx5i5hOJL6ePj1ZcIfIWYrqnl9uLwMPHfXu8lNVSbokzTZQMADIexQ9rseCEdBxlW7lnNJee49HaNck8Q4YxdERL3khvnh+tUahZJuLOFjNVlGxExHl+0q0U3w6P+S8xhnLAL5HUIxhgN4nTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PAZP264MB3069.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Sun, 29 May
 2022 15:21:04 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::b15e:862f:adf7:5356]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::b15e:862f:adf7:5356%5]) with mapi id 15.20.5293.019; Sun, 29 May 2022
 15:21:04 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Leslie Rhorer <lesrhorer@att.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>
Subject: Re: Modules list
Thread-Topic: Modules list
Thread-Index: AQHYc1A0Tz/Qb2QzikeVqwAx7Y3Jm601+MkA
Date:   Sun, 29 May 2022 15:21:04 +0000
Message-ID: <7999b7b4-3b58-a9c4-4756-445e54404f0f@csgroup.eu>
References: <dd7e69ce-41a4-cc5e-5a15-0ae9fc52aad0.ref@att.net>
 <dd7e69ce-41a4-cc5e-5a15-0ae9fc52aad0@att.net>
In-Reply-To: <dd7e69ce-41a4-cc5e-5a15-0ae9fc52aad0@att.net>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b04a1d9b-113f-49a1-a964-08da4186d895
x-ms-traffictypediagnostic: PAZP264MB3069:EE_
x-microsoft-antispam-prvs: <PAZP264MB30696A9C97A96CB2EEF2C1C5EDDA9@PAZP264MB3069.FRAP264.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zu47ZJmBdq6/RQx7BZ4iQCOoVitECJdmYewE74htpPtPD0BiIqL13K09tjdDyvHYPqlF8TW9hBJ2+EbyoPjgWYGk17Q+aGBBd89GMYsSwTqlzy5qIUDgNYD/E3/6XpK6fg5PTFB0Yv6jnWTRHN9vLywvmW7WtZQEir8qlkbBVZAwXiiRinIbVWeQU3ms5DE7elVCP9Sc68Lwam5aaZKyHIGWnnCjlVbu+drzkBEbQS1WcyDFOPn+JLuWkNSVVcSeHgSh+yYQDTboi2t6c831tryqg6LIaXdwweHBuxkobMO9sD9iaz25X6bJ4nqC6fb2LgquDUcA9f8Clj4WvN7wd21nKU90q4KrPwyl6Dz5LcbizbMP8tP+pjV9SnCRUwcVTWbd8E0hcuTcWd7HeG6n46mse0npxeTJqAX2NYVF4FYg8HVHNp5owsKAEjyNmEnUDL4jQ2SiucLutJ7gKzeT1zfW6tGfCZeJd3ooEHOAjPCdUyUHwYRm4SVjDZxR/UOHsipAb27kPNGnjCKHs3Oickwkd346cjH2BNHxSAG63AUYfS1SMZxg3alyEdNCzZzvW0ufKFSdsNLcVl3KG2FyCn9EAII1cQmyIHZhraEd7Geqw8vRAUJJNKKX82k01BPxh8CNHMoMWMGaFspkC3VIKvW/m4EtU6dOn72LDMqwf+w/LeKHQkE1tYXOP9LL7DQKODg3ZK5oY1Ov94oB+0q6EORG3fvu9Byonejf0dV9tElfIZyJ/t1QOnaomJJJ83huAEmCfFAJcdi6PVwKADCH2w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(71200400001)(6506007)(31686004)(3480700007)(6512007)(26005)(316002)(8676002)(8936002)(4744005)(44832011)(6486002)(5660300002)(36756003)(66946007)(64756008)(66476007)(76116006)(186003)(91956017)(66446008)(66556008)(508600001)(110136005)(31696002)(86362001)(2906002)(38100700002)(2616005)(83380400001)(122000001)(38070700005)(7116003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SGNpQ29MY1BLc0tCK0U5V2hwdWZvSk9kaUFkTWFtazIwakdPNWRxcDlIQ3do?=
 =?utf-8?B?REVIY0Q0WG5IYVBNMVdBT3RBVmxpK1YvelZtOFk5emkxRXIveHVSRW5sRjZ5?=
 =?utf-8?B?aS9nYzJlNlZNdmg2R3dsblRjSE5sRjU4d0dTYlRiS1JacXBQaUwxYlEyN3Uv?=
 =?utf-8?B?N1NqeTJQRFVsRTFTR0VkVUZqNjhSQU9YMzlLQjJBMWNzN25uQ3JGNWl5TFI1?=
 =?utf-8?B?aU5jOW1IbzlGbGJFNHZrWTlXZjZDbWsvTDFDdW5yb3dxSkZJeUdFd25pcXYx?=
 =?utf-8?B?UlFXZy9XcUVSWjlCUGF1WjRDTWEySHgvZkxRMVlXRE9ocXRCZmZCS2lsb0cv?=
 =?utf-8?B?UVlXNGdwQWVPb1Bhckd6N1hZeUlvN0xXZ3ZoQkR0QVVjb01aU3hQVnRCWFJv?=
 =?utf-8?B?VUNhb2VFRTFrMTVjbnVLTHpMbndndXBlZk1UYXJycnZDMWl5WFpYU0ovcEVZ?=
 =?utf-8?B?ZkhEbGttbCtrZndLcUN2SFBmdzltUTF0NWZVcW9uUjh2MjRxWTVZek12ZkZy?=
 =?utf-8?B?TjlMUitpNXphNXF3WjlabjNPcjZ0UmNmYks4aVkwLzE5bVVIUnZDL2lDYlNs?=
 =?utf-8?B?UGJQb1AyYVN6NmVyOFpzQ1kwemFWWHhHcFZORkZkQkN2SElzUHQ0Z2FhWWc1?=
 =?utf-8?B?VGVIYkJ1dEN3Zkp2NzFJREJmUFBmeXFnTVo5Uk1lNElXVEh5WHRqTnRseHFN?=
 =?utf-8?B?MHhkMnFvZloxSERnRW4yaHpOZXFLQkVWSkRFNS9GeVdwVklZRHpEblRXMHZX?=
 =?utf-8?B?QWtQMFdrOUdyOE1tdDNMYXpLemZYSFVxeWJqNUlQSnFkTzRKZVFMbjdFM3Vp?=
 =?utf-8?B?WEtlYU15ZVpUeUFyNVIvZXpjM2pmWEVRMWNSc2FFT1UzTmwxbSttRUt4SzRH?=
 =?utf-8?B?c0FhRVRXVFVoYWJEclhDUlJxSkFaUlBaNlJKeFUyZkNFek51L01udUEwb3pD?=
 =?utf-8?B?R2ZiVnRlVWx3ZHBDazd4WnZLWWxzUENuMHMxUVZFNFJpMlBwVTZZWUpYekp4?=
 =?utf-8?B?RFBDbXl4eEtoTTdPcjc4L21HSWgxTEVrODBCZURSb2dnalhnWnJxOTJkR243?=
 =?utf-8?B?Mnd6STNyYkxQcTRqWGlsNXFQQmx3RjgzSTdpQ3AreHpWRVdEUXNHayt5bGlj?=
 =?utf-8?B?dzMybzRyYWkrbFJFSC9nbWhRSmhGdWhIVkEvREtHeG5UdVJodkM0Ri9hYU9t?=
 =?utf-8?B?ek5xTFFMZHNhL3hyRFNVT00wY2s4eTYreVpXMUVxdFh3MUZsVXBXcUZJM2xT?=
 =?utf-8?B?dXN0UzYwVFFYQmRacC8xVStlWVBwcnRCYkxkNFIrbFVRaWMxZzlrcmM3dXR6?=
 =?utf-8?B?VWY2cVlUTUJ5Y1pTcVRTM2R1UkFIQUZBKzhSREpmaE41S2Q2TGtCSTNTaXJZ?=
 =?utf-8?B?VjZLLzUzbGFMTDVzUms4Z3Y0d0wvVXJldnZHeitITFlFYXR0eGd0emZRSFJ3?=
 =?utf-8?B?bkhhQnkzb09mNWN1Zkxwd1M1c2wwMEhzUGxGK2lwMXNPV0ZWcy9lVU9CaFh3?=
 =?utf-8?B?ejlSQkVibzlrZWtBMGdyVFFFTER0SkVRRjJ4RlpjQUlDeXNyQ0RjcHg5cmg1?=
 =?utf-8?B?M3I2c2pQaWZqRWdrYWs1ZTZNWVdkbVhmUFdOV0cyWUxvNmJWbEN3bjBUeDVx?=
 =?utf-8?B?QU1MSEQvdS85b2IyZGZyNEhjdllmSUhOWjJpbU8ybGJPUTlBaG5ScXFZMHRw?=
 =?utf-8?B?eEhudWVLZWhaWERrelpvbmR0TTM4dGczekhvZ1hoWG5FUGYxTkFwQkU0aEs3?=
 =?utf-8?B?VzBNajQxVmNqN21zdjEzNkphTFQ4QVgySmMvQkt2enlGZnUyMzJFcnhDTXgv?=
 =?utf-8?B?dld6bXIxdmx1ZUJsaUZrYkdibWo2b0dzMG1wSU16ZUlsR0VPUGhyd3dsKzV2?=
 =?utf-8?B?dHJvQzdaMlRiWFhXdFo3NzVicUFQRmtQUjFCRHNsR1hIek9MR1BhMVJsSjJz?=
 =?utf-8?B?TnQ4SHJHOXgyOWp0RUZobWY4dk5Pd0dBRTd0RUNVRHV4UEpDb1Q2dXJVK1d5?=
 =?utf-8?B?RjE5S2cyN04yLzNjT2ZPQ3RtWm9JNXZ1NFZWdllpSERBTGRrb0RRbDUvNytx?=
 =?utf-8?B?bjdZY3F4WFpESmZhUHJGY0Z3ZFUyM01KajRkOElPN3JsRXpFblIrSldXTlVj?=
 =?utf-8?B?ZEhsd2hIWTJVdGhVRllSZWVRTS9VVjR2bFZEclVHenk5dWwza0s3MEIyT1Jy?=
 =?utf-8?B?aHg4VzN1RGc1S1ZTNWRMRnhRRjcyUlZZU0hEVkpHZUZIeUo4TWVLZlBLQkw1?=
 =?utf-8?B?VFZGK0JRMW9KVWhaWEJNOW8vamRJTnRpNTFDWXR4em5kbUlGTXNOT2FzRm1q?=
 =?utf-8?B?bktOLzNEK2pvVHZobFBsQnJoVW5QOVhRVVlrSmZWMlVXYVJDQVRiRTFUNG1h?=
 =?utf-8?Q?JydIIKQXwu1Frt017pwWzFmhrK6n/lIhNXLHK?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EB6B96DB349D2B4381D82459FDFF1EE5@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b04a1d9b-113f-49a1-a964-08da4186d895
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2022 15:21:04.0831
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6q3M/Yf7rIIqs7lqxRyxB5HchwjZe7uGcm2MRSYDBu6ZVHPeUw49vHc0ejAf27w8OJsUgzGTJ523MSXoyjhBh1XBQRf6kFYM0qA/g8Mbzgo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAZP264MB3069
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCkxlIDI5LzA1LzIwMjIgw6AgMTM6MzUsIExlc2xpZSBSaG9yZXIgYSDDqWNyaXTCoDoN
Cj4gIMKgwqDCoMKgwqDCoCBJIHNlbnQgYSBzdWJzY3JpcHRpb24gdG8gdGhlIGxpbnV4LW1vZHVs
ZXMgbGlzdCB3aGljaCBzZWVtZWQgdG8gYmUNCj4gc3VjY2Vzc2Z1bCwgYnV0IHdoZW4gSSBzZW50
IGEgbWVzc2FnZSwgaXQgYm91bmNlZC7CoCBJIHNlbnQgdGhlIG1lc3NhZ2UNCj4gdG8gbGludXgt
bW9kdWxlc0B2Z2VyLmtlcm5lbC5vcmcuwqAgRGlkIEkgZG8gc29tZXRoaW5nIHdyb25nPw0KDQpP
YnZpb3VzbHkgeW91IGRpZCBpdCByaWdodCBhcyBJIGdvdCB5b3VyIG1lc3NhZ2UgdGhyb3VnaCB0
aGUgbW9kdWxlcyANCmxpc3QgKEknbSBub3Qgc3Vic2NyaWJlZCB0byBsaW51eC1rZXJuZWwgbGlz
dCkuDQoNCkNocmlzdG9waGU=
