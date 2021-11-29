Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55A9046131D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 12:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354142AbhK2LJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 06:09:21 -0500
Received: from mail-eopbgr50083.outbound.protection.outlook.com ([40.107.5.83]:3767
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1354283AbhK2LHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 06:07:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m3UASlnhhDtKjct4QsgWAx7ZjP7aEUBIi9a38pAuAzyv7+xMnarTKaRSYQDrfYbCivze6Xp+k4ooqbrHiuCEVKsiAzgPujVFfl69tOlMjGzLdi6F0vN0jlaIFvxsF5g3V3Z/h3mYzw9ebE2c8F5KKOK1hw53EzxoBOG+HUFYyBqqD+utQf8houEtAcR9/yyVF2hjGuHlGe+InX8ZyhfLF7ceb1Z/5+MemtNu+4+gqJCxsCiCJEtmXDteH35jhU7RdZ0pWkVNx/3Z/0MjTZJrdEz/AQrztwPkm0Xpn/MLPR8fznnrNNDpC9wE/q13K++uNm9G4FqLHeCumIYCvY0AOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6U4M0jeBxTtOJBYWjW/uFzQxfarVZS4/sMwkDAOiTL4=;
 b=C5NkjrOfUao4djM8DSU9RDVEUJ3WJX1V+0E4ZhgGBxMkugsqpPcFZG5RemC58EMZtFlGNfHFLZd029M88lhC/GXyP9cTcrHqZKaNq5I33ypfPXQGt5U4aUQEv7ZLs0tVkv59NXXNqFgLgbXnILeEeo5hnTimJnfAoYTshmAxK7njzqQ5n4qkaNpZeUQqHey4gJpVcY2Qxik4k2U7HrRHuiCEfQqjd4xablQWPGc8TcsYUeUiuMp8zGm9pSby+Ptq7F/d1hEMw6PJnnh3ukSyVQhy3s73CGUiqpXghkdJksJ7DZ4mnzWq7TdB40bzTpDjQGCEzINHqRqXdce1L/dLbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6U4M0jeBxTtOJBYWjW/uFzQxfarVZS4/sMwkDAOiTL4=;
 b=QxxM+kjcpzHOaKYXEhveKTBCVn1gODZ3dduIwNlNOLaEckbljSkw+AGrtSy2AibTlPC6ZMMOAx8Zmhs6kkkuH12hGvis5IEOAiz441mf/EAAoBnpJeSHYXzhHusrUpaOBWIE/uwq/BS6a1m3ymwLxULoVeFmP1P2yPxZlP0T2Cs=
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:255::23)
 by DB6PR10MB1576.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:6:38::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20; Mon, 29 Nov
 2021 11:03:56 +0000
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::852d:c54f:8414:3276]) by DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::852d:c54f:8414:3276%3]) with mapi id 15.20.4734.024; Mon, 29 Nov 2021
 11:03:56 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
CC:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        David Abdurachmanov <david.abdurachmanov@sifive.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] rtc: da9063: add as wakeup source
Thread-Topic: [PATCH v3] rtc: da9063: add as wakeup source
Thread-Index: AQHX5PKJ6KO7EBlE+EGOwLgsbrHEvawaV2TA
Date:   Mon, 29 Nov 2021 11:03:56 +0000
Message-ID: <DB9PR10MB4652F8B0DD6D4294276CFCB980669@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
References: <20211129072650.22686-1-nikita.shubin@maquefel.me>
In-Reply-To: <20211129072650.22686-1-nikita.shubin@maquefel.me>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cc4c7d63-4e07-46d8-fbec-08d9b327f037
x-ms-traffictypediagnostic: DB6PR10MB1576:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-microsoft-antispam-prvs: <DB6PR10MB157637A362DE887BEEA5799BA7669@DB6PR10MB1576.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tewpxOhILP4OKPEBHwgjq6kUCoEv8H1i2fW2tZh/yXwVlrU8VlOvO+OZZ4p8tcLUtom9G8w+l1p+LIUZUB6VsesAcriLY7F2F4t+LFxMMPLEWeo6UmDndMPbWEKwaGAaru48dWYTJbawlUJu3zENgTFsaIOeJ1iPzuSVoN9G3O9DMG8aMDGNvNnKvOz4gCxeou4PYEI9q+IlmZa97wBKprmhQnTzWanRlF23Q0CnWKXrIe/ncIFpDQPdlSS6xyUtLked+w/ZkPyxzWAMwyaHA9wlMX8Gem0n/h8LUtYXkzXDcc/E7yzFaTXLRsra5a84bqFM4Qk1MDhwE2R9vuT8TWA5MEfMhMQDxeV50r4DwjYK5Ku+84t1I/HJb6H1i2F9mNTa6/RWVxRFktV6RUuRSwRNVF+E/npvDZii+ypwOpZUZS4CicyCk3z61vX60+9KhHuqUJ0n+mBMAfzdyCu+oG/7VwM5krk7H3s2gYdxVhmfXvmby/J0hN5M4njKtPjrFH5e65sZkOyiyd1U+ldijK/uF7viVWOryRHHpp9pBw0FH9NIojVxcNngJLad9wmhOopcZCAIhmITiRwEpM/AnsrhMQg9pM92CHedXcO1PUeryPC/yXJelj0rgk3I8cuiCsAXDgBpY95enCDNK2JOs7yNiWZlpCGg1Tz5QtNKbiZVnHDVb1R8V4ww9A6Sr3yxDTyXVOAS8z+ZNPQ2cRQHTg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(9686003)(38100700002)(122000001)(7696005)(83380400001)(52536014)(86362001)(4326008)(54906003)(2906002)(6916009)(5660300002)(55016003)(6506007)(33656002)(53546011)(76116006)(66476007)(26005)(38070700005)(64756008)(186003)(66556008)(66946007)(4744005)(316002)(8936002)(8676002)(71200400001)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fhr8D1mnr7dRbEJ19iMDXKSFyeeQvMMb/mOZo53kU31DzS1xj9VnCNsFGSC3?=
 =?us-ascii?Q?El8bwCEEZ4LxW68eQE2hj48qMws2xv7zGRlSN5rF0mtFfWZDnhOfCvNo6NtY?=
 =?us-ascii?Q?LZrX8zEg5lkkJR+mkmwHIe/v5yFnd+K1n/mlj55m7VSRAdaRZ4D0JzjWxfRr?=
 =?us-ascii?Q?VsJ621V86YLDtJdSBgrOyDQI0fhycN9WftjizIYhzW8HmocUZwnZwDfSSxn4?=
 =?us-ascii?Q?UfgzDkVmJt7R9GAAR7bMtJDZ8gFd7lOi+aIfBAgucoKxVsNxevsAFKwjqvUQ?=
 =?us-ascii?Q?oyK2hFbqotVrHkfqUu7Y/go0KaOqouveVRfXVDKfSnmXku7+y5R0YJeQOZDp?=
 =?us-ascii?Q?odVFRbKBy9ULJTFRdQbfyOki/m3SgJtGX9hhFmf4LXbdL6nbKnSWpgmCcFdK?=
 =?us-ascii?Q?CAOGwKiL6+h4Cu0FjTGU9kH2DtiuFeMJjrSo3SwFBkj3a0UME9yxuqg4ChSy?=
 =?us-ascii?Q?IOD90fdP+O3mG7iP4I2Be2NJcHgY/alQgQJiGiLNIemaWJj4ygLDZMf5F8k+?=
 =?us-ascii?Q?+AG50XQL4+oc2PR16QVVKOp4qNEeqnCYeGUByYmm/PBWutpx5yVvoiYmQ1fZ?=
 =?us-ascii?Q?+wWCOX68BinszBC9TKcEOCq5xdRTT219yc1gKmnTn9BZCH9LVEEsuYrHlzrN?=
 =?us-ascii?Q?mtopoUIDG5yEG8Mjf5m0Jcda1GXdJ99zVOt7ilfeQWdaqMAPExUcWsuApxSy?=
 =?us-ascii?Q?YWKnT6FOCyzWt0O73iQHyzMKa2pyWvs/N2EtW6DoE0XjBeNu7te/dT53JRtJ?=
 =?us-ascii?Q?CD17+kRKDCAXhXEWgaUgnd0XXfgXBSnxKin74JL2N2N4yWMK9dqbwAsrGnXK?=
 =?us-ascii?Q?1AmF0iXR9SV2446AhhYYHK+4DbX1NmXfeq+JM78KpyRCpIam2rdk2DLd4kr9?=
 =?us-ascii?Q?MENo4Fhqj8XcRyq+d9r1850/d0jQW+bxR0KOxz0c6xLT8DXALURzYieTSYRR?=
 =?us-ascii?Q?VrbPL0B9vCK0nDqW8LbIRXvRY2HhHa2MSImWAo9Z4wfvxAQqOXNMybrKJYgK?=
 =?us-ascii?Q?85V6LwEATwkJ2T03WS6xSEBxSn+33D9w4gVrwQHqouFLp39v9wr0d+UPtBJH?=
 =?us-ascii?Q?Ajoee99hN+q4GRVrK9BysZs8mO15yLI3uENMT1TlTD2897+O0d8Ctq7fqyRC?=
 =?us-ascii?Q?+CV5zdvJgBq2/Ym2f7k2kz5Mxv/xcVxoqGUpWIwft7auB23PGx1H794JaNLe?=
 =?us-ascii?Q?a/ZO3cKPUrA3mnXhhci1GiPgOb7T73nJEe4gAx+5lL3GYapLsMNWJaMqNUgD?=
 =?us-ascii?Q?GL75T6Nh6t0hRMBu/ABwCmsPUbPjHhCTcAm+TnrT/4gkPb2RnqrRZhLHq8dz?=
 =?us-ascii?Q?Lxd+j02PCxZSGW6RQ7f6D/A/7JtnIt83i3qwr3Q4L7Uy8L4ATCdC7mkdFtz5?=
 =?us-ascii?Q?FEmt0E6gQPhSzQtyQ9/yyc54ZcHbrLvllgnDPgYsBjC5ut5PwSiABo/SqNSW?=
 =?us-ascii?Q?y/mPlXK4tfUHZBphwvpj4U61tO/IDAvXeeJWJ+zbmTo3HGL3RlCyoVo9ztgx?=
 =?us-ascii?Q?T4o5JM+xqtrKJvJEnPoLjaE4euGMQ7ZoK4/z4NRvp+rxiht/FVJa1uJGKOP7?=
 =?us-ascii?Q?wKXoTGYz4hsUYqE3+4lC9G8igS6l2HYddFpmirL6ImUHgK2a3jq5fItSmiZE?=
 =?us-ascii?Q?mqiXLAkNdPXdM/RH6noWQyYfcSKCGPxrbutsLh5KG4yYCZvZxJEx5r8fskeE?=
 =?us-ascii?Q?ohf4fg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: cc4c7d63-4e07-46d8-fbec-08d9b327f037
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2021 11:03:56.3549
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ICmM2zJwfUHqm+4f58Y8Pdk/gpReD+mvRfTb9Fbv41E4hLSZIdPZhyc0QSpmyWGBaWdd1/hfTUaCBzI8aiIbOGcmWUg8IkoZcC9lIq5SGIw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR10MB1576
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 November 2021 07:27, Nikita Shubin wrote:

> As da9063 RTC is not a real I2C client, but relies on da9063 MFD
> driver, we need to explicitly mark da9063 RTC as a wakeup source
> to be able to access class/rtc/rtcN/wakealarm sysfs entry
> to set alarms, so we can wakeup from SHUTDOWN/RTC/DELIVERY mode.
>=20
> As da9063 driver refuses to load without irq, we simply add it
> as a wakeup source before registering rtc device.
>=20
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---

Thanks for the update.

Reviewed-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
