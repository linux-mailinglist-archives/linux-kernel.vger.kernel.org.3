Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698A9585C85
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 00:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235832AbiG3Wdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 18:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiG3Wda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 18:33:30 -0400
Received: from alln-iport-7.cisco.com (alln-iport-7.cisco.com [173.37.142.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4084413D6B
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 15:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=4460; q=dns/txt; s=iport;
  t=1659220409; x=1660430009;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=VRTP/irVtC5ZFFoFQvcndshQPDlKqiWjd34blHoWcxA=;
  b=iQnQTTj7aXpcgoziMQgGOG+ZOrLUqoQEFEpKbHHTy/6W6PTjmU5T5zAf
   ZKyil1TykKGWhTsUJnwiYjbNa6UwK009oU35BqmNVDEPUkuQ9Qq/2Vi5w
   HUKkSZd6MBQLRmDYO34mFUnZ73m8JdIsKZjZyFRp4yREHOEXjC/wNP0FX
   0=;
X-IPAS-Result: =?us-ascii?q?A0AIAgBQseVimIkNJK1agQmBT4FSKih/XDpFhE6DTAOFL?=
 =?us-ascii?q?4ULgwKbUIJRA1QLAQEBDQEBQgQBAYFSgzQCFoReAiU3Bg4BAgQBAQEBAwIDA?=
 =?us-ascii?q?QEBAQEBAwEBBQEBAQIBBwQUAQEBAQEBAQEJFAcGDAUOECeFaA2GQwIBAxIRE?=
 =?us-ascii?q?QwBATcBDwIBCBoCJgICAjAVEAIEDgUigluCZgMyAwGafAGBPwKKH3qBMYEBg?=
 =?us-ascii?q?ggBAQYEBIUQGII4CYERLYMZhEuHOyccgUlEgRUnHIJnPoQcKINWN4IulzQcO?=
 =?us-ascii?q?AMaKx5EAwtRBQgJFxIQEAIEERoLBgMWPwkCBA4DQAgNAxEEAw8YCRIIEAQGA?=
 =?us-ascii?q?zEMJQsDFAwBBgMGBQMBAxsDFAMFJAcDHA8jDQ0EGAcdAwMFJQMCAhsHAgIDA?=
 =?us-ascii?q?gYVBgICTjkIBAgEKyMPBQIHLwUELwIeBAUGEQgCFgIGBAQEBBYCEAgCCCcXB?=
 =?us-ascii?q?xMYGxkBBVkQCSEcDhoKBgUGEwMgbwUKOw8oMgE1PCsfGwqBEiorFQMEBAMCB?=
 =?us-ascii?q?hgDAyICEC4xAxUGKRMSLQkqdQkCAyJrAwMEDB4uAwkhHwcJMAEbApdbUxkGB?=
 =?us-ascii?q?zmBG1sKDHIuDDqSQBKCV0arLgqDUaAYBC2nbXothwePSKIfhQwCBAIEBQIOA?=
 =?us-ascii?q?QEGgXeBf3AVZQGCPVEZD445gQ0BDoI9il51OwIGAQoBAQMJjD+CRwEB?=
IronPort-PHdr: A9a23:+V0whBDcLKNiDUk6zUDjUyQVaBdPi9zP1kY95pkmjudIdaKut9TnM
 VfE7PpgxFnOQc3A6v1ChuaX1sKoWWEJ7Zub9nxXdptKWkwJjMwMlFkmB8iIQUTwMP/taXk8G
 8JPHF9o9n22Kw5bAsH7MlbTuXa1qzUVH0aXCA==
IronPort-Data: A9a23:5e82YK8vbytBodHkpOUJDrUDS3mTJUtcMsCJ2f8bNWPcYEJGY0x3z
 mJMUGuEb/zeYTeheY0nPIu+9EwC6p/WyNQwG1Bt+S5EQiMRo6IpJzg2wmQcns+2BpeeJK6yx
 5xGMrEsFOhtEjmE4E3F3oHJ9RGQ74nQLlbHILOCa3sZqTNMEn9700o8wLZh2eaEvPDga++zk
 YKqyyHgEAfNNw5cagr4PIra9XuDFNyr0N8plgRWicJj5TcypFFJZH4rHpxdGlOjKmVi8kFWc
 M6YpF2x1juxEx7AkbpJmJ6jGqEBaua60QRjFhO6VoD66iWuqBDe3Y4LDPYOSB1llAyUnsx91
 eVWt62tSzUAa/ikdOQ1C3G0Egl3OalAvbTAO3X67YqYzlbNdD3nxPAG4EMeZNJDvL0pRzgVs
 6VDd1jhbTjb7w6y6LiyTvJxnuwoLdLgO8UUvXQIITTxXad5HMCaHP+XjTNe9G0CjMENINDHX
 dgQOBt3dxbjMw9fAlhCXfrSm8/x1iWgLFW0smm9oasx/niWzwFr1rXpGMTad8bMRshPmEuc4
 GXc8AzRBhAcKczawCCAt3GhnOnCmQv/WZkOD/u58PBwiVGez2BVDwcZPXO5pvm/ola+QdVNJ
 kpS/TAhxYA09UeoCNn0QB65pmWsvgYRHdFXFoUS8gaW1qfY/y6WAW8ISz9aLts8u6ceXzkpl
 VyEhdXkARRmqriRSHSA5vGTtzz0JCt9BWYYaSUsTgYf5dTn5oYpgXrnStdlDbXzkdTxHTzxw
 RiOrS43nbJVitQEv4275VnvkSOwoYKPRQkwji3HDjyN7Q5jYoOhIYuy5jDz4f9eIcCZR1+as
 X4sn8mY8fBIDJeRmSjLS+IIdJmj/96MNDzRhw4pE5RJ3zGs/XGkVZpd7DF3OAFiNcNsUSPmZ
 F/7vQJX+YNJO32rfel7buqZD8Us0LjIHM7gUvHSc8oIZYJ+MhKElAlnf0ic92n3lkQm160yU
 ap3au6lCXIcTK9g1jfzG6EW0KQgwWY1wma7qY3HIwqP4YKSdl/Pe6g8LVqSYv0J96G1vQfn2
 oMKXyeV8Cl3XOr7ayjR1IccK1EWMHQ2bawaTeQKJ4ZvxSI7Rgkc5+/tLaAJINc8xvsL/gvc1
 jTsBBEHmQOXaWjvc13iV5x1VF/4sX+TR1oSOSghOz5EMFB8PN72t8/zm3bLFITLGcRqyfpyC
 vICYcjFXrJESy/M/HIWapyVQG1emPaD2FPm08mNOWVXk3tcq+rhoIGMkuzHr3JmM8ZPnZFiy
 4BMLyuCKXb5eyxsDdzNdNWkxE6rsH4WlYpaBhWVc4MLJRWwqNE0cEQda8PbxelScX0vIRPHh
 26r7esw/oEhXqdsqoCS3PDYx2tXO7ImQRAy85bnAUaebHmGoTXLLX5oW+eTdjeVT3Lv5Kinf
 o1oIwLUbpU6cKJxm9MkSd5DlPtmj/O2/uMy5lk0TR3jMgXwYps9cybu9ZcU7MVlmOQG0TZar
 2rSoLG2z53TZpO8eLPQTSJ4Btm+OQY8wWWPta5scRmmtUeaPtOvCC1vAvVFswQFRJMdDW/v6
 b5JVBI+g+BnticXDw==
IronPort-HdrOrdr: A9a23:WqqqJa7sHqLosn/KXQPXwWqBI+orL9Y04lQ7vn2ZFiY6TiXIra
 +TdaoguSMc0AxhJE3Jmbi7Sc29qeu1z+873WBjB8bcYOCAghrnEGgC1/qv/9SEIUzDH4FmpN
 9dmsRFeb/N5B1B/LvHCWqDYpcdKbu8gduVbI7lph8HJ2wLGsJdBkVCe3ym+yZNNW577O8CZe
 OhD7181lydkBosH6GGL0hAe9KGi8zAlZrgbxJDLQUg8hOygTSh76O/OwSE3z8FOgk/gYsKwC
 zgqUjU96+ju/a0xlv3zGnI9albn9Pn159qGNGMsM4IMT/h4zzYJ7iJGofy/gzdktvfrGrCo+
 O85CvI+P4DrU85S1vF5CcFHTOQiQrGpUWSkWNwykGT3/ARDAhKevapw7gpKScwLyEbzYxBOG
 Uh5RPCi3MfN2KyoMy2jeK4Jy1Chw66p2EvnvUUiGEaWYwCaKVJpYha509NFowcdRiKo7zPPd
 MeRf003swmOW+yfjTcpC1i0dasVnM8ElOPRVUDoNWc13xTkGpix0UVycQDljNYnahNBqVs9q
 DBKOBlhbtORsgZYeZ0A/oAW9K+DijITQjXOGyfLFz7HOUMOm7LqZTw/LIpjdvaMqAg3d83gt
 DMQVlYvWk9dwbnDtCPxoRC9lTXTGC0TV3Wu7djDlhCy8rBrZbQQFi+oQoV4rmdSt0kc7nmZ8
 o=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,205,1654560000"; 
   d="scan'208";a="897581725"
Received: from alln-core-4.cisco.com ([173.36.13.137])
  by alln-iport-7.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 30 Jul 2022 22:33:25 +0000
Received: from mail.cisco.com (xfe-rtp-001.cisco.com [64.101.210.231])
        by alln-core-4.cisco.com (8.15.2/8.15.2) with ESMTPS id 26UMXPYS029795
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=OK);
        Sat, 30 Jul 2022 22:33:25 GMT
Received: from xfe-rcd-002.cisco.com (173.37.227.250) by xfe-rtp-001.cisco.com
 (64.101.210.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Sat, 30 Jul
 2022 18:33:24 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (72.163.14.9) by
 xfe-rcd-002.cisco.com (173.37.227.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14
 via Frontend Transport; Sat, 30 Jul 2022 17:33:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SGVhChEQEszbhNa66bKu8vwDhVriNzsGJUhtY+hRDbTrEjtwx8wTBPU0jM84NFw4wYDxScX33whWBdyRg0h1eTCQrrkaTJS8siIhYSH14RZ+SSHJFbZlLXJE6gALQIhjObaD7OuPwZgcx2+LcCGPDxqjiJGiySP/iM3IeTQ+GhJ2CeyzBlhHbAgy8TEK5VmtrSmodVDd+qW/tlZ3k2wX3lc9e+8sJmrTf2kmp/Dnf6FwPSoJ6yKQQsochHuXrQil1XWaALuw4iO+DXU3pJS0nUxOgFiAalYn5shA5r1pA9FLojYSGL943u6XLvq2b08qEF/pDMqbsrSEu5rOgJIoYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VRTP/irVtC5ZFFoFQvcndshQPDlKqiWjd34blHoWcxA=;
 b=mwuzXWWNkJT9lKTqIllDCn9lnVsMv2M01jlZLuKk0FdaXDpqXjvsPqViIaCa2yDfVKIVbWrFm/kblDciEvKc2rDrhG0spq2IVqnAutogJOhA50xInfgMoLIaMIdJ/2/XNVWc5ybF8St6qWgsVZcsKgdOva+DeM8evJBvyhdXOiwa8ZgFbfWexu3ioTw554zCBKW+tOlq9hBAGI1MXISRH1RQMpqgecA5W/awqubQwirOcYLVx7+IamsPRiwY37Zq9X79a5JKRvtivIKzLFPuG/zJjKjrrzlItN6igba+49KBzaGFW23/Ath98bF4rdNvzRd6lfP8DgafXuNh4IgWDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.onmicrosoft.com;
 s=selector2-cisco-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRTP/irVtC5ZFFoFQvcndshQPDlKqiWjd34blHoWcxA=;
 b=Y3Clj9I/wXHdC2ZHWOYwR6KqAiIVsSQDlxnF9u/aOLU9Q3XCsbEC/mRnr0SKlChAK1sOCtLS/defnlnCIoh1wI3eUDlUmJUPOv+WmUtC2Ww97yipSxW8uaTxH0YJbrFuD3VoP8RwLaOKu0psn8d97UhXiJ4ESZfXUUamxyTZIhE=
Received: from BL0PR11MB3524.namprd11.prod.outlook.com (2603:10b6:208:73::21)
 by SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.14; Sat, 30 Jul
 2022 22:33:22 +0000
Received: from BL0PR11MB3524.namprd11.prod.outlook.com
 ([fe80::5c25:1833:51e5:4d5d]) by BL0PR11MB3524.namprd11.prod.outlook.com
 ([fe80::5c25:1833:51e5:4d5d%7]) with mapi id 15.20.5458.025; Sat, 30 Jul 2022
 22:33:22 +0000
From:   "Billie Alsup (balsup)" <balsup@cisco.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "nick.hawkins@hpe.com" <nick.hawkins@hpe.com>,
        "john@phrozen.org" <john@phrozen.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Allow configuration of ARCH_NR_GPIO
Thread-Topic: [PATCH] Allow configuration of ARCH_NR_GPIO
Thread-Index: AQHYo6zcfTXM5BpcJEqAjq/4nyvE/K2WztgAgAA9MYA=
Date:   Sat, 30 Jul 2022 22:33:22 +0000
Message-ID: <D7DCF238-0AE9-44A0-86B1-8C731FF8BB59@cisco.com>
References: <20220730003846.1730265-1-balsup@cisco.com>
 <CAK8P3a0Bn9xKRX9z369zVCy6CuguTvNbtXOOPbf_OfS697cDyQ@mail.gmail.com>
In-Reply-To: <CAK8P3a0Bn9xKRX9z369zVCy6CuguTvNbtXOOPbf_OfS697cDyQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.63.22070801
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cisco.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5647fd00-2211-4cfc-cb5e-08da727b8286
x-ms-traffictypediagnostic: SA1PR11MB6733:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TgXgLol6GqssPxWbztKfjnTgnc+PPnJzhQmZvmcD0Ovg1VEET1T/DQHed5uit9GHujh50e9U1IcCuVV3N7Ty2BkqUa3oB4pKXabs40mOxjizFHYa1BUA3vLnzI/vAgOrQ8/lDuxSpW3VzQ0OmPl9zF10XJ7AFY9u1xdBLte+VTdQpSypXYlk281Fauj65y86brgMuex2IrWKkE5AdsMSdLq+WMpQgeDCVJZN2sf1KiaXTzo5/Bc7KmMxpL1hojDwHuLWIZl09w8owicK6O9SsS8C8p44IrZBAvqNmnK5+rHbL13WxwkDIDu7CayBp39WJpcHJ+WKtGaPhVKuBcf44y/aD9ce9SzL5HBkZoYb3Jka+6N2rJw2eF05eLMoZ7BI4AmLmTi+I04izOweJBkD3QkMq9SiPQDnAnZt34z8D++xYg9+jHkvVhI0ExyxprTRrihWFdAhCrDwFqG+XrkEWMN26xgdjYE88qsTcOfty3xB2ORBml9PxhILLWm6Ftqc8L0mDiuim+kSRt/wVYFK39UHIGsqXcvCs3quhr8U0Z9Cj2Hixzftmo3AATDx473ifgpfNQBkC3KTeNoU/vlUaCdWULGwpF8z16IoOeQ0w2z9KbUjoZsBKbCVaZXITwbjZ4lYeuXkkrmTvnYeTtAzZQDk3jRkxhfNZlThLB5xk73TjchtSDqAYVARJ3X4t4cR1zLYLdk873swgvKwNRmZCWQqjdGSB95PlmacKyvQAmlrCLiXhkbZgVjbOifEmha3DoLYy64ZDtuNWsIZUGfAA0Kbqw/DzG11NFFgN1sA71c+zkixEOggVXwsafto1e7j9MXaTAD8Aa1eBy6i9IyR1w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3524.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(376002)(366004)(346002)(396003)(4326008)(91956017)(6506007)(38070700005)(2616005)(66446008)(86362001)(6512007)(26005)(8676002)(186003)(71200400001)(5660300002)(83380400001)(7416002)(8936002)(36756003)(6916009)(6486002)(66476007)(66946007)(64756008)(76116006)(316002)(54906003)(66556008)(2906002)(122000001)(38100700002)(41300700001)(478600001)(33656002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cVhvWkRNeGFUTUtNRzB6NXp0MExjYXBlNWUzTlNFaDVwOFB3VE10K0ROUmhT?=
 =?utf-8?B?RUpic3Q2Q2dCNytwYlZXckM2cE15RncvNkpLbHhFRmhPZzV3a2F4U3RuOXpn?=
 =?utf-8?B?a0RlaytkQ2tkbFhGbnl0YUtKMm1LeHBaaEZRa0VReHhWY3hXZ1haNnpmM1ZO?=
 =?utf-8?B?QWxHRURLQ05yUTA3UTRDTEFTUVR0eUJCU0NLb0JhRkkyeW83OVB1NEZYa2VB?=
 =?utf-8?B?Unk3L0ZhVGVIb0tJMDJKcDAyMEllNFZ5ZXByWG1hUVliVUZUUkxrUVZwT0VB?=
 =?utf-8?B?a1hPbUxhR3ZpMmRmZzdNTVV4ZlpJWFVKTzh3d0VHMDJ2U0lsNjRwWWgwbklR?=
 =?utf-8?B?VFY2RCs1b1lIRmlUYm1qbUhLSVh2VkQ1MTVoZkcvci9MUzlOcm1BRWZXSldt?=
 =?utf-8?B?VU1LditUMys2aTkzUnhkUnZMS1VVQksxK2laTnNHbHFZcEZabFdoQjNlTzM1?=
 =?utf-8?B?Q21sRWFaOWlSNVpybjlXeUxaVDMwVE9iSGczWlM0Um9VdCsvU2l3TGNhTDdy?=
 =?utf-8?B?ckszaUxiQ20wb1dhME85clQ0dmpYck11RS9DS0hWTTdLd2RzVTBuY2ZtZk9V?=
 =?utf-8?B?ZTN2OFl4SUZ2V1YyNkpaUEdTVkhTRXBRYUhvS3NhLzVFVk9welp0NXU0L1hp?=
 =?utf-8?B?T1R6djJ0QW9HNG5XcVFWekVtbjBKajVjSVVJRmM4b1pLaG5URGUzU1dTNHg3?=
 =?utf-8?B?NGpSaXNBemRqRHlJRUhxTXUySThNUmhyRk02VUd5czZ4VFVJMmVMTjNUU0gr?=
 =?utf-8?B?LzJzZ0Nka0c3dU9YT0QzcDRrY0RGRHE3WmVZanRCalNmbTJtUlJ3Z2ZyVTNS?=
 =?utf-8?B?cnZBTktzSEl2bzkvUFo3YmRUSVJCb3NDa1Nmek5iOWoxeUlBUGhnWkE5NGpF?=
 =?utf-8?B?V1BheS9qeFc0YlBDdHAvOXVQQUNjVmYvMThTNEdieGFzaVFHWjhhWWkzV0xW?=
 =?utf-8?B?TDN2MlFQeTBaNGxmOWtBL2F5ajdTOFVkalJBcWk1S3d1S0FnUE5tZWVuZmY2?=
 =?utf-8?B?N3NxMFFPcXo0ZGJ0dlNnK3hESC9LWFIxeHBuNE9pc3M0MXpjOWJRaXQwLyt1?=
 =?utf-8?B?MWJVb2tFaGhvM0ZoMVZiMFFKd01vTWMybm1ORjE1VjZ4T0lpTWF3cm50czRz?=
 =?utf-8?B?TW1WMmtpV2doRGN1bEx6SnVPZFRiVEh1aHdkdzBMbDliNzRzeFkrdVJGM1do?=
 =?utf-8?B?bmE0NzVvOStyTjRRT0w5U1hJU0xiUTYreFVKYXU5SW5iZWtybGpNT2JXYitD?=
 =?utf-8?B?MVZ5UTF4SDJhWnkzUW5QcFg1L3Z2eGpERTJGdTNyNEt2djZPbVV6QWYrRVAy?=
 =?utf-8?B?cG85amVmclkvTGh2UWxSc1hBcmN5NEplT3VrWlo2OXZHSDk5eHo0L09Jby9S?=
 =?utf-8?B?NHZHc24wdk5wdHdETEwyUENlenhtYnMreVlEZEo4cWtReEh5Y29QR2dTWTRB?=
 =?utf-8?B?ekUvRnRFd3FSNTB0UHNQRVFTTEpHOEJRVzFmYmtIWWFya0pFbHIyNTZ0Q3dJ?=
 =?utf-8?B?QnF1dSsvOE9vb0l1L3lxMFNOQVA2VjVSYTJETzl6OFNzWnZBZDZ4VXVhMzdm?=
 =?utf-8?B?Tk5oOUFtTFJWNldLRFVXYTBxMmZPK1Zxb2RPSGhzRWdLUWxjK0Zkb1Y2ZFNU?=
 =?utf-8?B?SkpNUVZEUHRiNXNuWmhTMEQ0bjJwYkduZ2RkM1dXbitkS3dwekNWSkpvMkg0?=
 =?utf-8?B?Q01XUERTbGRVYmoxZGs2S1JNdE1WWVBQYUw3Qk1Cd1ZreGdUZnpNRWM3V3FQ?=
 =?utf-8?B?cmFtNjhmNE00TnJRc2lRcWdWbi9SM2oyNUJoNWszaFpGN2pKaCswdm0vYjRG?=
 =?utf-8?B?cng5QzQzUGhpTnY2NnNKbS9idnVwRUs4d254Z2dIazNjWFFzcCt0TnY5SW80?=
 =?utf-8?B?SmlubjNlVEZ0bzhQTTNpT2FnK2lIUmZDR0xxV25SS0M1MGp4cjRDOXFIRGow?=
 =?utf-8?B?M0dtWWhmTzJlbXAzWEZydHJmSE9jQkxtczAwV0RWb1R2akErOVIxSmxkQXVK?=
 =?utf-8?B?dDBEbGdEWEZOc0o5M1N1VWZZbVBwZEsxSU8yUDlJRUZoSW5Sb2VtYUNBVmJv?=
 =?utf-8?B?alBhaTc2SHBPSHBQMERqbWw4TmdtM0lndUJzbVIycmh4c1RlY0c1L081ZjRD?=
 =?utf-8?Q?6hN1b7feSrWiPP1q00JMWZqBq?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4425400197BC9849866D722CFC7272EE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3524.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5647fd00-2211-4cfc-cb5e-08da727b8286
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2022 22:33:22.2137
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t5c3iSOkjhA/iSJpJotfNblXnt1cfx9tBDAVfuFiO2XtCFgqCapnt09lfh5Bgg8BMdrK/xkI9CArFIAIbmmU/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6733
X-OriginatorOrg: cisco.com
X-Outbound-SMTP-Client: 64.101.210.231, xfe-rtp-001.cisco.com
X-Outbound-Node: alln-core-4.cisco.com
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQogID5PbiA3LzMwLzIyLCA0OjU0IEFNLCAiQXJuZCBCZXJnbWFubiIgPGFybmRAYXJuZGIuZGU+
IHdyb3RlOg0KDQogID5XaGF0IGlzIHRoZSB1c2UgY2FzZSBmb3IgbWFudWFsbHkgc2V0dGluZyB0
aGlzIHJhdGhlciB0aGFuIGRlcml2aW5nDQogID5pdCBmcm9tIHRoZSBzZWxlY3RlZCBwbGF0Zm9y
bXM/DQoNCkEgQ2lzY28gR1BJTyBJUCBibG9jayBzdXBwb3J0cyAxMDIyIHBpbnMuICBBIHNpbmds
ZSBGUEdBIGNhbiBzdXBwb3J0IA0KbXVsdGlwbGUgR1BJTyBJUCBibG9ja3MgKGFsdGhvdWdoIHR5
cGljYWxseSAxIG9yIDIpLiAgQSBzeXN0ZW0gbWF5IA0KaGF2ZSB0d28gb3IgdGhyZWUgRlBHQXMg
ZGlyZWN0bHkgYWNjZXNzaWJsZSB0aHJvdWdoIHRoZSBQQ0kgYnVzLCBhbmQgDQphbiBhZGRpdGlv
bmFsIDggdG8gMzYgRlBHQVMgYWNjZXNzaWJsZSB0aHJvdWdoIGFsdGVybmF0ZSBtZWFucyAoZS5n
LiwgDQpTTFBDLCBpMmMsIG9yIGEgcHJvcHJpZXRhcnkgcG9pbnQtdG8tcG9pbnQgYnVzKS4gIEFs
dGhvdWdoIHR5cGljYWxseSANCnRoZSBmdWxsIHNldCBvZiBwaW5zIGlzIG5vdCB1c2VkLCBpbiB0
b3RhbCwgaXQgaXMgdmVyeSBlYXN5IHRvIGV4Y2VlZCANCnRoZSBsaW1pdC4gIFByZXZpb3VzIHBh
dGNoZXMgaGF2ZSBzaW1wbHkgYnVtcGVkIHVwIHRoZSBudW1iZXIsIGFuZCBJIA0KdGhvdWdodCBh
IG1vcmUgZ2VuZXJpYyBhcHByb2FjaCB0aGF0IHdvdWxkIHNvbHZlIHRoZSB1c2UgY2FzZSBmb3Ig
DQpjdXN0b21lciBkZXZpY2VzIHdvdWxkIGJlIG1vcmUgYXBwcm9wcmlhdGUuICBJIGFtIGFsc28g
dHJ5aW5nIHRvIGtlZXAgDQp0aGUgQVJNIGFuZCBYODYgaW1wbGVtZW50YXRpb25zIHNpbWlsYXIs
IGFzIHRoZSBkZXZpY2VzIGFyZSANCmFjY2Vzc2libGUgZnJvbSBib3RoIGFuIEFSTS1iYXNlZCBC
TUMgYXMgd2VsbCBhcyBhbiBYODYgdHlwZSBDUFUuICBJdCANCmlzIGRlc2lyYWJsZSB0byB1c2Ug
dGhlIHNhbWUga2VybmVsIGNvbmZpZ3VyYXRpb24gZm9yIG11bHRpcGxlIA0KcHJvZHVjdHMsIGV2
ZW4gdGhvdWdoIHRoZSBudW1iZXIgb2YgRlBHQVMsIGFuZCB0aGVyZWZvcmUgdGhlIG51bWJlciAN
Cm9mIHN1cHBvcnRlZCBHUElPIHBpbnMgY2FuIHZhcnkuICBTdWNoIGlzIGFsc28gdGhlIGNhc2Ug
Zm9yIE9wZW4gTk9TIA0KZW52aXJvbm1lbnRzLCBzdWNoIGFzIFNPTmlDIGFuZCBGQk9TUywgd2hp
Y2ggYXR0ZW1wdCB0byB1c2UgYSBzaW5nbGUgDQprZXJuZWwgY29uZmlndXJhdGlvbiBhY3Jvc3Mg
bXVsdGlwbGUgKG11bHRpLXZlbmRvcikgcHJvZHVjdHMuIEEgDQpwbGF0Zm9ybSBzcGVjaWZpYyBv
cHRpb24gd291bGQgbm90IHNlZW0gdG8gd29yayBpbiBzdWNoIGNhc2VzLiAgDQpJZGVhbGx5LCBJ
IHdvdWxkIGxpa2UgdG8gc2VlIHRoaXMgY29uZmlndXJhdGlvbiBrbm9iIGdvIGF3YXkgDQpjb21w
bGV0ZWx5LCBidXQgdGhhdCBtaWdodCBiZSBhIG1vcmUgY29tcGxpY2F0ZWQgYW5kIGNvbnRyb3Zl
cnNpYWwgDQpjaGFuZ2UuICBJdCBpcyBub3QgdXNlZCBpbiB2ZXJ5IG1hbnkgcGxhY2VzLCBidXQg
dGhlIHByb2JsZW1hdGljIHVzZSANCmlzIHdpdGhpbiB0aGUgaW5saW5lIGZ1bmN0aW9uIGdwaW9f
aXNfdmFsaWQuDQoNCiAgPkhhdmUgeW91IHRyaWVkIHRvIHVzZSBib3RoIGEgcGxhdGZvcm0tc3Bl
Y2lmaWMgb3B0aW9uIGZvciB0aGUgbWluaW11bQ0KICA+bnVtYmVyIG9mIHRoaXMgc2V0dGluZywg
YW5kIHRoZW4gcmVzdGljdHJpY3RpbmcgdGhlIA0KICA+Q09ORklHX0FSQ0hfTlJfR1BJTw0KICA+
c2V0dGluZyB3aXRoIGEgJ3JhbmdlJyBzdGF0ZW1lbnQ/DQoNCkkgaGF2ZSBub3QgdHJpZWQgYSBw
bGF0Zm9ybSBzcGVjaWZpYyBvcHRpb24sIGFzIHdlIHdvdWxkIG5lZWQgdG8gDQpjaG9vc2UgdGhl
IHdvcnN0IGNhc2UgcGxhdGZvcm0gZm9yIHN1Y2ggYSBjb25maWd1cmF0aW9uIChpbiBvcmRlciB0
byANCnNoYXJlIGEga2VybmVsIGJ1aWxkIGFjcm9zcyBwcm9kdWN0cyksIGJ1dCB0aGlzIGluIHR1
cm4gbWF5IGNvbmZsaWN0IA0Kd2l0aCB0aGUgY2hvc2VuIHBsYXRmb3JtIGZvciBzb21lIG90aGVy
IOKAnHdvcnN0LWNhc2XigJ0gc2V0dGluZyBvZiANCmFub3RoZXIgdmFyaWFibGUuICBJdCBzZWVt
cyBwcnVkZW50IHRvIHNpbXBseSBhbGxvdyB0aGUga2VybmVsIA0KYnVpbGRlciB0byBjaG9vc2Ug
dGhlIG9wdGlvbnMgdGhleSB3YW50LiAgVGhpcyBpcyBqdXN0IG9uZSBleGFtcGxlDQp3aGVyZSB0
aGUgY29uZmlndXJhdGlvbiBpcyBub3QgZGlyZWN0bHkgYXZhaWxhYmxlIHRvIHRoZSBrZXJuZWwg
DQpidWlsZGVyLCBidXQgbXVzdCBiZSBzZXQgaW5kaXJlY3RseS4gIFdlIGhhdmUgb3RoZXIgY29u
ZmlndXJhdGlvbiANCm9wdGlvbnMgdGhhdCBjYW5ub3QgYmUgc2V0IGRpcmVjdGx5LCBhbmQgaW5z
dGVhZCByZXF1aXJlIHVzIHRvIGVuYWJsZSANCmFuIHVucmVsYXRlZCAoZnJvbSBhIHByb2R1Y3Qg
c3RhbmRwb2ludCkgY29uZmlndXJhdGlvbiBpdGVtIHB1cmVseSANCmZvciB0aGUgc2lkZS1lZmZl
Y3Qgb2YgZW5hYmxpbmcgc3VjaCBhbiBvcHRpb24uICBDT05GSUdfQVJDSF9OUl9HUElPIA0KaXMg
YSBzaW1pbGFyIGlzc3VlLCB3aGVyZSB5b3UgY2hvb3NlIGEgcGxhdGZvcm0gdG8gaW5kaXJlY3Rs
eSBzZXQgdGhlIA0KdmFsdWUsIGJ1dCB0aGF0IHZhbHVlIHJlYWxseSBuZWVkcyB0byBiZSBjb25m
aWd1cmFibGUgYnkgdGhlIGJ1aWxkZXIuIA0KVGhlIGxhc3Qgc3VjaCBwYXRjaCBmb3IgWDg2IHNp
bXBseSBidW1wZWQgdXAgdGhlIG51bWJlci4gIEkgdGhvdWdodCANCml0IGJldHRlciB0byBzaW1w
bHkgYWxsb3cgY29uZmlndXJhdGlvbi4gIEkgaGF2ZSBubyBpc3N1ZSB3aXRoIA0KcmVzdHJpY3Rp
bmcgdGhlIHZhbHVlIHRvIGEgbWluaW11bSwgaWYgdGhhdCBpcyBhIHdvcnJ5Lg0KDQpJIG5vdGUg
dGhhdCBpdCBkb2Vzbid0IHNlZW0gdGhhdCB0aGlzIHNldHRpbmcgaGFzIGEgbmVnYXRpdmUgaW1w
YWN0IG9uDQpyZXNvdXJjZXMgd2l0aGluIHRoZSBzeXN0ZW0uICBPbmx5IG9uZSBkcml2ZXIgKGdw
aW8tYWdncmVnYXRvcikgcGVyZm9ybXMNCm1lbW9yeSBhbGxvY2F0aW9uIGJhc2VkIG9uIHRoaXMg
dmFsdWUsIGFuZCB0aGF0IGlzIG9ubHkgZm9yIHRoZSBkdXJhdGlvbg0Kb2YgYSBzaW5nbGUgZnVu
Y3Rpb24gY2FsbCB0byBhZ2dyX3BhcnNlLiAgT3RoZXJ3aXNlLCB0aGVyZSBkb2VzIG5vdCBzZWVt
DQp0byBiZSBhbnkgbmVnYXRpdmUgY29uc2VxdWVuY2UgdG8gaGF2aW5nIGEgaGlnaGVyIGxpbWl0
Lg0KDQoNCg==
