Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F4854F3E9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 11:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381499AbiFQJHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 05:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381483AbiFQJHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 05:07:08 -0400
Received: from esa6.fujitsucc.c3s2.iphmx.com (esa6.fujitsucc.c3s2.iphmx.com [68.232.159.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1FAB53B43;
        Fri, 17 Jun 2022 02:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1655456826; x=1686992826;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6vM/8x/tpC2aCDqRJw0u9w4cSK0auWga9Oj4nGoRDYU=;
  b=Wdziet6HjTqYLR3879c7KmzZWvdtlWoCXBa6g8YNlVI652/cfN41xY2l
   R5u2nru0+gHmzIGMXhdCAEwWDEfqm4MI9TyK3mfv6d4+Nh1WC6UXQJKgc
   wu24zdY52PTlRX9ewCWOIFzw428t1ArPB3vrn3+l6OBaQWzLOYt4eoRDB
   9D8gOGk55q92FpW92JoTdgmftw21wKfD+7e/bp/OMIt/yutpOcvy9s0vI
   +sdyjcP9dvYUq0MaqxISr/A7s3dWN0C+wO5ANQYP1RHw//HDBDKozzhe8
   98C8MC9y/nQzdWT3+yPFRblrEHD7seYWSHt0f8MMyFnSkqJasMTpLmLF4
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="58378880"
X-IronPort-AV: E=Sophos;i="5.92,306,1650898800"; 
   d="scan'208";a="58378880"
Received: from mail-os0jpn01lp2108.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.108])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 18:06:56 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oKGqd7BcakIwTjE4nPkfZNUu7DCApgD+bQgPld3K2e/kWOaeF4Z3AiCCGC3ss6mZdDqpjPURcBGRm2q716mDuPMUlVAAJvQvqn+HeFCjTWB90SSLn60QP8mnbK69JlxNT3Ef3E2N+4RskaSa/puKwOWAys2os5ftYGvvYNtrrlf1QZak9SmIdZeESeTD7dWEKt1b1VeU2nv/TXZKVztSlkS7MLFwtXBNuumhPvwsRXmI+HUTVda/AOesO2+ec03i9gKio4EZFYXHua/SFCKFx/x3ITFCN785mAde89nDk/+vHlzL6K4E6cU++jYUrwckQ+CovAQdP44Lg8M2Jifrkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6vM/8x/tpC2aCDqRJw0u9w4cSK0auWga9Oj4nGoRDYU=;
 b=mwmbB3YACxxDipSEoEbJiJ/PTzIpbre1yiuyo+G+mxCROxoq/VFB977COXWMboEDDIoRqPiXuJk1oy9AOMydXJqCC+revOproBQn/UQjb4uT3/wFll91ezlRH9WdKcv/3Ldq3U82+3lIau7lEBLJPy6jYlFtTU0XptwjMg72+HdKkpX1m9FoNMfHyuMnalgXleogGNpgVBOWqMyzV7EkISz29OxlqjPtfnsfhETALhogUDv2q+nphvWDK9Utr0ezcI53RwEQ7njauqw6iieYp/TO/a3M+0ikE2SMUWGkXMgFqvLEPvwcEX+mNQs08BuPjIhhL5WOJd3sTztUpib9VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6vM/8x/tpC2aCDqRJw0u9w4cSK0auWga9Oj4nGoRDYU=;
 b=FBzOwrm5k8mhKeZ+jlnog8ylZh6DgeGPaAsoqcET0QXouejsCyDd3C3FUcUpjfMBBNkKM4x3uSp8NixCjMBYFVzQlmsFaIhwgAcyvTbZFUfUmzZWO9TU320FTHWkNHvLlpl7Ux4aiHGTw397wIGtkPCvwGXcrdAlM3sDX4KCilg=
Received: from TY2PR01MB2042.jpnprd01.prod.outlook.com (2603:1096:404:12::11)
 by OSAPR01MB3684.jpnprd01.prod.outlook.com (2603:1096:604:5e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Fri, 17 Jun
 2022 09:06:53 +0000
Received: from TY2PR01MB2042.jpnprd01.prod.outlook.com
 ([fe80::e13d:16ae:7ddb:a10a]) by TY2PR01MB2042.jpnprd01.prod.outlook.com
 ([fe80::e13d:16ae:7ddb:a10a%3]) with mapi id 15.20.5332.023; Fri, 17 Jun 2022
 09:06:53 +0000
From:   "tarumizu.kohei@fujitsu.com" <tarumizu.kohei@fujitsu.com>
To:     'Linus Walleij' <linus.walleij@linaro.org>,
        Mel Gorman <mgorman@suse.de>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "eugenis@google.com" <eugenis@google.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "pcc@google.com" <pcc@google.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "marcos@orca.pet" <marcos@orca.pet>,
        "marcan@marcan.st" <marcan@marcan.st>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "conor.dooley@microchip.com" <conor.dooley@microchip.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "ast@kernel.org" <ast@kernel.org>,
        "peter.chen@kernel.org" <peter.chen@kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Paolo Valente <paolo.valente@unimore.it>
Subject: RE: [PATCH v5 0/6] Add hardware prefetch control driver for A64FX and
 x86
Thread-Topic: [PATCH v5 0/6] Add hardware prefetch control driver for A64FX
 and x86
Thread-Index: AQHYemckLVPNFhFQbU+IAdEo3cwBO61IrLSAgAqvcWA=
Date:   Fri, 17 Jun 2022 09:06:53 +0000
Message-ID: <TY2PR01MB2042C88E285FE67CCBCC602280AF9@TY2PR01MB2042.jpnprd01.prod.outlook.com>
References: <20220607120530.2447112-1-tarumizu.kohei@fujitsu.com>
 <CACRpkdbPLFOoPdX4L6ABV8GKpC8cQGP3s2aN2AvRHEK49U9VMg@mail.gmail.com>
In-Reply-To: <CACRpkdbPLFOoPdX4L6ABV8GKpC8cQGP3s2aN2AvRHEK49U9VMg@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9Mjc2ODcwNTYtOWFmYS00MjM5LWE1Y2UtZGJlNjI0M2Jj?=
 =?utf-8?B?OWJkO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFRO+/ou++gA==?=
 =?utf-8?B?776LO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX1NldERhdGU9MjAyMi0wNi0xN1QwODo1ODo1NVo7TVNJUF9MYWJl?=
 =?utf-8?B?bF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfU2l0ZUlk?=
 =?utf-8?Q?=3Da19f121d-81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f84c3463-ff40-44a1-2fc8-08da5040b8b1
x-ms-traffictypediagnostic: OSAPR01MB3684:EE_
x-microsoft-antispam-prvs: <OSAPR01MB36847D4FF1CCD737B0A74C6A80AF9@OSAPR01MB3684.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bQ5Ed61RafxPHRI8s8MX38OjUxVfRCRFUUerKz7YkWwlMQijvNZg6IQY0COHW4wnZ0EeVB9oa/+ztjletqcUFQram90uexj7rhKFYFnZuraVCafRj8iuIAeG85i583xXi2LkZDFUUYj1Z094Z5/RKhAeJ39B4FOYqL/TOAjE05k7I2ghr32nDFCXIWYjXH6MI6AlYPcz1+Hkxg4c1LzzlApQ8v3g/sQmaVgZr4tSh1peG72ZBXfq/M/K2dofGgC57HtPhHygyneMCd8+HtAjEv9e5FJoiJVOEKFPu73JwI3nBcSzXgPShufnZ06+GE7lhjXDyVLdCDFq0G3DX51m5dUXNq+BAGgRH2GAT2gSjophZxo+dsIzF/q0/3Mqu81BzPj5scJ+nMgzo10NeFC4UHiqvpGopNF+CIUzchBkA82hsibsmf+Y0QBQcGvTZcMirjGEWC1lCuYhCTqsgibcgpcCNmJ1lso8oaRq6Fho7oBiGuteaS58XIDBbJTXWnWPfcACvzDb+HXUa45Otr8yIzoKb667L4B33FiLzVWXYrYMqCsXjYH8DOjmy1n8B5Ba5uh6Bg4cbsF0lCoUY7af3AsO3ysigHQKwQ115PqETvY7gFn/353/9mMa/u7F7quQUTj/z/kQ4xgSlNBeLuCZXdig5pdL94PK7hiXn7j1t+B1PtcZDbaEBi6JVSTGVI2sROMZKq/Jh+OqAwhpcnWEBw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB2042.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(66446008)(66476007)(76116006)(66556008)(64756008)(82960400001)(8676002)(7406005)(26005)(52536014)(110136005)(71200400001)(38070700005)(6506007)(66946007)(7416002)(7696005)(55016003)(316002)(2906002)(4326008)(186003)(54906003)(508600001)(85182001)(8936002)(33656002)(9686003)(5660300002)(83380400001)(86362001)(122000001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eXc1U3Jva1ZkSVRVS3VadnNEMDA2T1RsRnFpVldCQzZ4K1lYZ0hvZzJPVDVD?=
 =?utf-8?B?YWd4OVFQbGVyTFlxN0pEUVhvRU95by80Q2NRc05HMmVxTjJrT0ZKZVF0Z1VO?=
 =?utf-8?B?ZVh1UUY3YUVOSmdkTmhCQnlUeElHWUhOdHp4a1Nwa3VlSm8xQVVNbDZHU0Er?=
 =?utf-8?B?dTJqWXdJS1VTd2hLNDRrcUFDU3l1YUluM2ZPOEFyMVEzRm5FMXRDeVp3b1dQ?=
 =?utf-8?B?bGc3eXhnODZlU2M0L0JoZ3J4N1E2R3JRR3JvTklQQlBSbkhMN1JKekp0TEdS?=
 =?utf-8?B?REYrUlZrQXJydU1CZHBOdDY3dUtvOUJpR0RMSzVDNXVSNldoRXNpUVRyTldT?=
 =?utf-8?B?ZWFvbmpIWWRuckI5NEdqVTNyTmV6aVVxTk1hdC9qL3F2ZmFDdC8xSllEK1Rr?=
 =?utf-8?B?a0E5QkxRTW9lNXVQNFZSS0RoTFRMZDZHWFpFNnNJdVNRb1cyZlBhOUd6QU1N?=
 =?utf-8?B?ZG1Mc3NXYlp0UStWakliTXVDMTJQV3JkcVZyU29XNEtpMGRVTVRPRGlOM25w?=
 =?utf-8?B?TE1KaktkMFdyS09Za3pvZjZLUEZnN21FdVcwTmM4TUlMSUFlaklobkZUcGhW?=
 =?utf-8?B?bUl2cnBwQkFCekhmNFNTRDBuSEllVjJHalBLU3d4QkFqbVRBQTVPQ0ZKNlpN?=
 =?utf-8?B?RXFHa2YvVnd1OU1tclFhUExiSmJLL3ZqM2thYnZnMUN6MUpIbW5BWnQ2WGJE?=
 =?utf-8?B?OEJkYnZHNXE3UFpLMVZpb2VKeE81NHlCajd4R1g5aFZkaUZBWUF4ZW1Kekxn?=
 =?utf-8?B?ZUkycTk5VHhQSEVQYzBHdVgzR0FYZDRjQ1BXTlMrSnhCUllwVFIrUFJ2SnhR?=
 =?utf-8?B?aytjNjBnRUhsNmZGYjN0QVhSRytBOS83bjJzSDdWR1RZU0hvbjZEaUdkQ2hi?=
 =?utf-8?B?UUpwQ29rTUhYcjl2VjJqekxGM3Rpdnl5MmpaZkFXeVpFQ1dlY2IzbkFYdzU4?=
 =?utf-8?B?YWRSVWxJSUZhM3dienRtRGtTd0JSR0dzdm94dytORFRacVd3N0lvSi9GemZB?=
 =?utf-8?B?VSsxR01mMmlGUzhSTXVPWW14UW4zZDIvbmJWaFdzOXErb3hYMm1LMXNTUkY4?=
 =?utf-8?B?NHF1aXdsOVhMVHFqZlBPaDJuRkpQazFGVENkNG4zb2tkRWMwd2Y2ZWFtWVF4?=
 =?utf-8?B?RG51MWVXTDhaZitzRXB6OU1DY2FpTUxZT3V1WHZVY292d3dXZGE4SWZJODJh?=
 =?utf-8?B?ZUhDNU9QYlNjaWxETzhDK2lla2lqb1JkT0o4RG8waVFCaFpCaUx1bUx6RXhx?=
 =?utf-8?B?V0hMODh6T3RpOCtSZDROVEM3VHdkOGRUTE1QeGNZN3NrcEttM3o5bW55SEhG?=
 =?utf-8?B?ZjJwZlF0M2lyVElEU3lNSWFwZjhoQ2cvajQrYXVEczZ3dmhYcHB1VTVXYUlR?=
 =?utf-8?B?dHltQ01DdFNyanhhNDF5OTFqb2NObGlSMEVXUE4xcXFPSmVLdm1lZTNyMWlw?=
 =?utf-8?B?N3JUSDROTjFzNWpuWmxjZ0dHWmdteVJRMlNOYzhkWlhmeWpNSHo5bWw1MElz?=
 =?utf-8?B?a3M0R3ZkSzVIREhYRzJqSU8xTndBMDhzd295VFd2Mjg2YzBybExJYUdQMFJQ?=
 =?utf-8?B?dGNjWklOb0xVcVorTDl0NlJsV0llQ2Nnb2o1SzBQUit6eVptZHZEZVNRTTc5?=
 =?utf-8?B?NHc1aEhMdkdaQ01mWlFyL0ZNWUwrVkphWXZRb1NlWGdTSmdxcktzMTJHQXlx?=
 =?utf-8?B?ajVJUU9yMjNub3ZOb2lvWDVWcWtINk5uMnpaYXNETXJZZWhIWjg1WVdUamdM?=
 =?utf-8?B?QTFLa1Y4a2poby9SNlUyZUtSQUhiVXk5eTVFSFFod2ExSHl4U0p3WXJqd29O?=
 =?utf-8?B?TUFCdVZ4S2ZVa1RIQk4veWVWak1XdXFOYXhhL3JpZmVVa29QQ2FpYlJvaUFa?=
 =?utf-8?B?SEZrcVM1VEpwUWN3UTJDa2lSUlVTRDRZOExhRjJMMEs5OURUVFZmdHFOZjdV?=
 =?utf-8?B?RXUzTy9UTmVkaXJ0NGRDTmdHaUNqZ0wySmloRkt0ZkFISVZRaUZ3SXNwOE11?=
 =?utf-8?B?N1Z4Mm1ZZS9rbFBPQklRZXdZTHpJUVJpWGE5Ni9hNmcwc3F4b28vVW92d0pi?=
 =?utf-8?B?cHpOVWRNaXNOa2NwbHNXc1k3bFE1VHdoalFackJuNEtqVUQ3WVVDTzVPUVJU?=
 =?utf-8?B?eEZYanVFaVhKdHpscXJVVDdEdWY4MkZDTE1SVW1LR1VNODFxbUVYVGE3UFo1?=
 =?utf-8?B?ZXNDSEc3WlAxRWt2UDhDb3ZjQzVQVE4zaWNQb1V2NlNxTlI5clVVOGxYNDJs?=
 =?utf-8?B?amtjRTJvZHl3eUVrNFZ3S1g3M1Q5Rm5pVXVEUFJuU0JoYUc1ZnhBUldyOHE1?=
 =?utf-8?B?WWoxcFJBc2VSbTJyTm92QWt6YWhMdTllZm8wWmtnM215SGQ5U1hkNk90UENq?=
 =?utf-8?Q?7XaOaadTQMYhvPcI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB2042.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f84c3463-ff40-44a1-2fc8-08da5040b8b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2022 09:06:53.2782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mGbAgBMd5bbQL+v5Lq1QAHFjj7jL/Lq6n6kZsA/hZ2Ruk2el8bHuAtTvRvFHR8yB0DiUVvhAP7CZlECXAWd71gMlo665Whi6VMiNArHpmMM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3684
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGludXMsDQoNClRoYW5rcyBmb3IgdGhlIGNvbW1lbnQuDQoNCj4gT0sNCj4gDQo+ID4gQTY0
RlggYW5kIHNvbWUgSW50ZWwgcHJvY2Vzc29ycyBoYXZlIGltcGxlbWVudGF0aW9uLWRlcGVuZGVu
dCByZWdpc3Rlcg0KPiA+IGZvciBjb250cm9sbGluZyBDUFUncyBoYXJkd2FyZSBwcmVmZXRjaCBi
ZWhhdmlvci4gQTY0RlggaGFzDQo+ID4gSU1QX1BGX1NUUkVBTV9ERVRFQ1RfQ1RSTF9FTDBbMV0s
IGFuZCBJbnRlbCBwcm9jZXNzb3JzIGhhdmUgTVNSDQo+IDB4MWE0DQo+ID4gKE1TUl9NSVNDX0ZF
QVRVUkVfQ09OVFJPTClbMl0uDQo+IA0KPiBIYXJkd2FyZSBwcmVmZXRjaCAoSSBndWVzcyBvZiBt
ZW1vcnkgY29udGVudHMpIGlzIGEgbWVtb3J5IGhpZXJhcmNoeSBmZWF0dXJlLg0KPiANCj4gTGlu
dXggaGFzIGEgbWVtb3J5IGhpZXJhcmNoeSBtYW5hZ2VyLCBjb252ZW5pZW50bHkgbmFtZWQgIm1t
IiwgZGV2ZWxvcGVkDQo+IGJ5IHNvbWUgb2YgdGhlIHNtYXJ0ZXN0IHBlb3BsZSBJIGtub3cuIFRo
ZSBtYWluIHByb2JsZW0gYWRkcmVzc2VkIGJ5IHRoYXQgaXMNCj4gcGFnaW5nLCBidXQgcHJlZmV0
Y2hpbmcgaW50byB0aGUgQ1BVIGZyb20gdGhlIG5leHQgbG93ZXN0IGxldmVsIGluIHRoZSBtZW1v
cnkNCj4gaGllcmFyY2h5IGlzIGp1c3QgYW5vdGhlciBtZW1vcnkgaGllcmFyY2h5IGhhcmR3YXJl
IGZlYXR1cmUsIHN1Y2ggYXMgaGFyZA0KPiBkaXNrcywgcHJpbWFyeSBSQU0gZXRjLg0KPiANCj4g
PiBUaGVzZSByZWdpc3RlcnMgY2Fubm90IGJlIGFjY2Vzc2VkIGZyb20gdXNlcnNwYWNlLg0KPiAN
Cj4gR29vZC4gVGhlIGtlcm5lbCBtYW5hZ2VkIGhhcmR3YXJlLiBJZiB0aGUgbWVtb3J5IGhpZXJh
cmNoeSBwZW9wbGUgaGF2ZQ0KPiB1c2Vyc3BhY2Ugbm93IGRvaW5nIHN0dWZmIGJlaGluZCB0aGVp
ciBiYWNrLCB0aHJvdWdoIHNvbWUgc3BlY2lhbCBpbnRlcmZhY2UsDQo+IHRoYXQgbWFrZXMgdGhl
aXIgd29ybGQgbW9yZSBjb21wbGljYXRlZC4NCj4gDQo+IFRoaXMgbG9va3MgbGlrZSBpdCBuZWVk
cyBpbmZvcm1hdGlvbiBmcm9tIHRoZSBnZW5lcmljIG1lbW9yeSBtYW5hZ2VyLCBmcm9tIHRoZQ0K
PiBzY2hlZHVsZXIsIGFuZCBwb3NzaWJseSBhbGwgdGhlIHdheSBkb3duIGZyb20gdGhlIGJsb2Nr
IGxheWVyIHRvIGRvIHRoZSByaWdodA0KPiB0aGluZywgc28gaXQgaGFzIG5vIGJ1c2luZXNzIGlu
IHVzZXJzcGFjZS4NCj4gSGF2ZSB5b3Ugc2VlbiBtbS9kYW1vbiBmb3IgZXhhbXBsZT8gQWNjZXNz
IHRvIHN0YXRpc3RpY3MgZm9yIG1lbW9yeQ0KPiBhY2Nlc3MgcGF0dGVybnMgc2VlbXMgcmVhbGx5
IHVzZWZ1bCBmb3IgdHVuaW5nIHRoZSBiZWhhdmlvdXIgb2YgdGhpcyBoYXJkd2FyZS4NCj4gSnVz
dCBteSDigqwwLjAxLg0KDQpUaGFuayB5b3UgZm9yIHRoZSBpbmZvcm1hdGlvbi4gSSB3aWxsIHNl
ZSBpZiBtbS9kYW1vbiBzdGF0aXN0aWNzIGNhbg0KYmUgdXNlZCBmb3IgdHVuaW5nLg0KDQo+IElm
IGl0IGRvZXMgaW50ZXJhY3Qgd2l0aCB1c2Vyc3BhY2UgSSBzdXBwb3NlIGl0IHNob3VsZCBiZSB1
c2luZyBjb250cm9sIGdyb3VwcywNCj4gbGlrZSBldmVyeXRoaW5nIGVsc2Ugb2YgdGhpcyB0eXBl
LCBzZWUgZS5nLiBtbS9tZW1jb250cm9sLmMsIG5vdCBjdXN0b20gc3lzZnMNCj4gZmlsZXMuDQoN
CkhhcmR3YXJlIHByZWZldGNoIHJlZ2lzdGVycyBleGlzdCBmb3IgZWFjaCBjb3JlLCBhbmQgdGhl
IHNldHRpbmdzIGFyZQ0KaW5kZXBlbmRlbnQgZm9yIGVhY2ggY2FjaGUuIFRoZXJlZm9yZSwgY3Vy
cmVudGx5LCBJIGNyZWF0ZWQgaXQgdW5kZXINCi9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2NwdSov
Y2FjaGUvaW5kZXgqLg0KSG93ZXZlciwgd2hlbiB1c2VyIGFjdHVhbGx5IGNvbmZpZ3VyZSBpdCBm
b3IgYW4gYXBwbGljYXRpb24sIHRoZXkgbWF5DQp3YW50IHRvIHNldCBpdCBvbiBhIHBlci1wcm9j
ZXNzIGJhc2lzLiBDb25zaWRlcmluZyB0aGF0LCBJIHRoaW5rDQpjb250cm9sIGdyb3VwcyBpcyBz
dWl0YWJsZSBmb3IgdGhpcyB1c2FnZS4NCg0KRm9yIGV4YW1wbGUsIGlzIHlvdXIgaWRlYSBvZiBp
bnRlcmZhY2UgbGlrZSB0aGUgZm9sbG93aW5nPw0KDQpgYGANCiAgL3N5cy9mcy9jZ3JvdXAvbWVt
b3J5L21lbW9yeS5oYXJkd2FyZV9wcmVmZXRjaGVyLmVuYWJsZQ0KYGBgDQoNCkNwdXNldCBjb250
cm9sbGVyIGhhcyBpbmZvcm1hdGlvbiBhYm91dCB3aGljaCBDUFUgYSBwcm9jZXNzIGJlbG9uZ2lu
Zw0KdG8gYSBncm91cCBpcyBib3VuZCB0bywgc28gbWF5YmUgY3B1c2V0IGNvbnRyb2xsZXIgaXMg
bW9yZSBhcHByb3ByaWF0ZS4NCg0KQ29udHJvbCBncm91cHMgaGFzIGhpZXJhcmNoaWNhbCBzdHJ1
Y3R1cmUsIHNvIGl0IGlzIG5lY2Vzc2FyeSB0bw0KY29uc2lkZXIgd2hldGhlciB0aGV5IGNhbiBt
YXAgaGFyZHdhcmUgcHJlZmV0Y2ggYmVoYXZpb3Igd2VsbC4NCkN1cnJlbnRyeSBJIGhhdmUgdHdv
IGNvbmNlcm5zLg0KRmlyc3QsIHVwcGVyIGhpZXJhcmNoeSBjb250YWlucyB0aGUgc2FtZSBDUFUg
YXMgdGhlIGxvd2VyIGhpZXJhcmNoeS4NCkluIHRoaXMgY2FzZSwgaXQgbWF5IG5vdCBiZSBwb3Nz
aWJsZSB0byBjb25maWd1cmUgaW5kZXBlbmRlbnQgc2V0dGluZw0KaW4gZWFjaCBoaWVyYXJjaHku
DQpOZXh0LCBjb250ZXh0IHN3aXRjaCBjb25zaWRlcmF0aW9ucy4gVGhpcyBmdW5jdGlvbiByZXdy
aXRlcyB0aGUNCnZhbHVlIG9mIHRoZSByZWdpc3RlciB0aGF0IGV4aXN0cyBmb3IgZWFjaCBjb3Jl
LiBUaGVyZWZvcmUsIHRoZQ0KcmVnaXN0ZXIgdmFsdWUgbXVzdCBiZSBjaGFuZ2VkIGF0IHRoZSB0
aW1pbmcgb2YgdGhlIGNvbnRleHQgc3dpdGNoDQp3aXRoIGEgcHJvY2VzcyBiZWxvbmdpbmcgdG8g
YSBkaWZmZXJlbnQgZ3JvdXAuDQoNCj4gSnVzdCBhbiBleGFtcGxlIGZyb20gb25lIG9mIHRoZSBw
YXRjaGVzOg0KPiANCj4gKyAgICAgICAgICAgICAgICAgICAgICAgLSAiKiBBZGphY2VudCBDYWNo
ZSBMaW5lIFByZWZldGNoZXIgRGlzYWJsZSAoUi9XKSINCj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGNvcnJlc3BvbmRzIHRvIHRoZQ0KPiAiYWRqYWNlbnRfY2FjaGVfbGluZV9wcmVmZXRj
aGVyX2VuYWJsZSINCj4gDQo+IEkgbWlnaHQgb25seSBiZSBvbiAiYSBsaXR0bGUga25vd2xlZGdl
IGlzIGRhbmdlcm91cyIgb24gdGhlIG1lbW9yeSBtYW5hZ2VyDQo+IHRvcGljcywgYnV0IEkga25v
dyBmb3Igc3VyZSB0aGF0IHRoZXkgYXQgdGltZXMgYWRqdXN0IHRoZSBtZW1iZXJzIG9mIHN0cnVj
dHMgdG8gZml0DQo+IG5pY2VseSBvbiBjYWNoZSBsaW5lcy4gQW5kIG5vdyB0aGlzPyBJdCBsb29r
cyByZWFsbHkgdXNlZnVsIGZvciBrZXJuZWwgbWFjaGluZXJ5DQo+IHRoYXQga25vdyB2ZXJ5IHdl
bGwgd2hhdCBuZWVkcyB0byBnbyBpbnRvIHRoZSBjYWNoZSBsaW5lIG5leHQgYW5kIHdoZW4uDQo+
IA0KPiBUYWxrIHRvIHRoZSBwZW9wbGUgb24gbGludXgtbW0gYW5kIG1lbW9yeSBtYWludGFpbmVy
IEFuZHJldyBNb3J0b24gb24gaG93DQo+IHRvIGRvIHRoaXMgcmlnaHQsIGl0J3MgYSByZWFsbHkg
aW50ZXJlc3RpbmcgZmVhdHVyZSEgQWxzbyBnaXZlbiB0aGF0IHBlb3BsZSBzYXkgdGhhdA0KPiB0
aGUgbWVtb3J5IGhpZXJhcmNoeSBpcyBhbiBpbXBvcnRhbnQgcGFydCBpbiB0aGUgcGVyZm9ybWFu
Y2Ugb2YgdGhlIEFwcGxlDQo+IE0xIChNMikgc2lsaWNvbiwgSSBleHBlY3QgdGhhdCBtYWNoaW5l
IHRvIGhhdmUgdGhpcyB0b28/DQoNCkkgdGhpbmsgdGhpcyBwcm9wb3NhbCB3aWxsIGJlIHVzZWZ1
bCBmb3IgdXNlcnMsIHNvIEkgd2lsbCBwcm9jZWVkDQp3aXRoIGNvbmNyZXRlIHN0dWRpZXMgYW5k
IHRhbGsgdG8gdGhlIE1NIHBlb3BsZS4NCg==
