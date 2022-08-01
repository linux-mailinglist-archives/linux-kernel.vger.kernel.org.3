Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD271586DE1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 17:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233461AbiHAPhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 11:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbiHAPhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 11:37:03 -0400
Received: from alln-iport-5.cisco.com (alln-iport-5.cisco.com [173.37.142.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB70428E0B
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 08:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=3424; q=dns/txt; s=iport;
  t=1659368221; x=1660577821;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qr6x5DQfOq7hN6uqT6kHcrrkNWIkc+8ib3BXqxHAfoU=;
  b=YWFLjCAQsLWOUyXsWJhdNLtqxMHnM+JuSI9ojgCqcm3AUylurUvbgyWl
   iE+RABE58nrXyQ1WIR0VDJ8HBuSvmP9hberlG1se1dy+/+N/cIb6T6Blm
   NfSnuYO4iqk8aJQROSzcITmLfLNTJzH1uHFzx3Ah3FG3U6EV+G/X62xf9
   c=;
X-IPAS-Result: =?us-ascii?q?A0BwAQC08edimIwNJK1QCoEJgU+BUioof1w6RYROg0wDh?=
 =?us-ascii?q?S+FC12CJQObTYEsgSUDVAsBAQENAQFCBAEBgVKDNAIWhGACJTQJDgECBAEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEDAQEFAQEBAgEHBBQBAQEBAQEBAQkUBwYMBQ4QJ4VoDYZDA?=
 =?us-ascii?q?QEBAgESEREMAQE3AQ8CAQgaAiYCAgIwFRACBA4FGweCW4JmAw0lAwGbHgGBP?=
 =?us-ascii?q?wKKH3qBMYEBgggBAQYEBIUQGII4CYERLIMahEuHOyccgUlEgRUnDBCCZz6EF?=
 =?us-ascii?q?wWDfjeCLotvi0YcOAMaKx5CAwtRBQgJFxIQEAIEERoLBgMWPgkCBA4DQAgNA?=
 =?us-ascii?q?xEEAw8YCRIIEAQGAzEMJQsDFAwBBgMGBQMBAxsDFAMFJAcDHA8jDQ0EGAcdA?=
 =?us-ascii?q?wMFJQMCAhsHAgIDAgYVBgICTjkIBAgEKyMPBQIHLwUELwIeBAUGEQgCFgIGB?=
 =?us-ascii?q?AQEBBYCEAgCCCcXBxMYGxkBBVkQCSEcDhoKBgUGEwMgbwUKOw8oMgE1PCsfG?=
 =?us-ascii?q?wqBEiorFQMEBAMCBhgDAyICEC4xAxUGKRMSLQkrdQkCAyJtAwMEDB4uAwkhH?=
 =?us-ascii?q?wcJJhIBGwKXY2YGgR1EAmNACDE/C5J+glpGmB6TEAqDUaAYBC2DdpMmkUsth?=
 =?us-ascii?q?wePSKFsM4UMAgQCBAUCDgEBBoFhghVwFWUBgj1RGQ+OLA0JgQQBBIJHil51O?=
 =?us-ascii?q?wIGAQoBAQMJjD+CRwEB?=
IronPort-PHdr: A9a23:AIAwtR9N1wRGr/9uWCXoyV9kXcBvk7n3PwtA7J0hhvoOd6m45J3tM
 QTZ4ukll17GW4jXqpcmw+rbuqztQyoMtJCGtn1RfJlFTRRQj8IQkkQpC9KEDkuuKvnsYmQ6E
 c1OWUUj8Wu8NB1eGd31YBvZpXjhhQM=
IronPort-Data: A9a23:KjVgwaK3soB2pcTJFE+RGpIlxSXFcZb7ZxGr2PjKsXjdYENS1jBTy
 mpLC22OOvrYYmH8fItyboy/oE8EsJCEydU2HQcd+CA2RRqmiyZq6fd1j6vUF3nPRiEWZBs/t
 63yUvGZcIZsCCW0Si6FatANl1EkvU2zbue6WbWs1hxZH1c+En9x0Us7wobVv6Yx6TSHK1LV0
 T/Ni5W31G+Ng1aY5UpNtspvADs21BjDkGtwUm4WPJinj3eC/5UhN6/zEInqR5fOria4KcbhL
 wrL5OnREmo0ZH7BAPv9+lrwWhVirrI/oWFih1IOM5VOjCSuqQQI4oc+P9wya35MpDCLn8Fg5
 e59kayZHFJB0q3kwIzxUjFRFyV4eKZB4rKCfj60sNeYyAvNdH6EL/dGVR5te9ZGvL8sRzgSr
 ZT0KxhVBvyHr+i/xKmmUsFnh98oK4/gO4Z3VnRInGiIV6x8EcibK0nMze4H0io73Z5qIdrxW
 Ik+UyQ0VTrkfAIabz/7D7pnzLv32RETaQZwrFOTuLpy4GXJygF1+KbiPcCTedGQQ8hR2EGCq
 Qru+2X/HwFfPcaajDmI6HShgsfLnDjnQ8QTErOi//JniVHVwXYcYDUUUlu9ieG5kEmsVtQZL
 FYbkgIorKMxskyiUdr8WQaQoGaJ+BUbXrJ4Ceoh9AyB1oLb5AGVA2kfCDlbZ7QOrso1Bj8nz
 FmEm/vgHzlrsbuIWTSa7LjSsDDaESEPIWUqZiIeSwYBpd75r+kbihPJU80lD6exitD0Gxn0w
 jaDti94gK8c5eYLz6yT70HbhCjqrZ/MJiYltlv/XW+/6A59Iom/aOSA5VHF4LBAJYCCQ1+pu
 HkChtjY7eYSAJXLnyuIKM0HBJmg4/eINm2ajVMHN5wg8Tuq02SucYBZ/Hd1I0IBGtoLfS/BZ
 E7VpB9L45lSLD2mYMdfZ4O3FtQCxLLlEdXjS+CSacBBJIVyHCeO5idiTUeK2Wzn1kQh+ZzTI
 r+SdcKqSH0dE6kik3y9RvwW1vkgwSVWKX7vqY7T9SSG1LG4SnysUpgAMluff80C3Ie0iVCAm
 zpADPeixxJaWez4RyDY948PMFwHRUTX47ir8aS7kcbefGJb9HEd5+z5muh4ItM790hBvqKZo
 C/iCxYwJE/X3yWvFOmcVpx0hFoDt75WqXY2O0TA1n73hiB6Ou5DAErjHqbbkJEu8OhliPVzV
 fRAJIOLA+9ETXLM/DF1gXjBQG5KKk3DaeGmZnfNjN0Dk3hIHV2hFjjMJVCHycX2JnDr3fbSW
 pX5vu8hfbINRh55EOHdY++1wlW6sBA1wbwvDhGZeIMIIBy9reCGzhAdaNdqfangzj2ellOnO
 /q+Wn/0WMGU+dZuqYmV7Ux6h97xTLIW8rVm85nztObqanayEpuLyo5bW+HAZiHGSG7x482fi
 RZ9kZnB3Ak8tA8S6eJUSu8zpYpnvoeHj+IKn2xMQSSQB3z2W+wICifdh6Fn6PYSroK1TCPrA
 CpjDPEAZ+XQUC4keXZMTDcYghOrjKpPxmCNtKtvey0XJkZfpdK6bKmbBDHU4AQ1EVe/GNpNL
 TsJ0CLO1zGCtw==
IronPort-HdrOrdr: A9a23:Pf66tamUW0ywaHRCzRtuMtgt0IXpDfOOimdD5ihNYBxZY6Wkfp
 +V8sjzhCWatN9OYh0dcIi7SdW9qXO1z+8Q3WGIVY3SEzUOy1HYU72KirGSjQEIeheOutK1sJ
 0AT0EQMqyJMbEXt7eZ3OD8Kadc/DDlytHouQ699QYXcegCUcgJhG0Vanf5LqQ1fng9OXNTLu
 v62iMznUvYRZ1hVLXcOpBqZZmnm/T70LbdJTIWDR8u7weDyRmy7qThLhSe1hACFxtS3LYL6w
 H+4kzEz5Tml8v+5g7X1mfV4ZgTssDm0MF/CMuFjdVQAinwizyveJ9qV9S5zXMISaCUmRQXee
 v30lMd1vdImjTsl6aO0F3QMjzboXMTArnZuAalaDXY0JTErXkBerR8bMpiA2rkAgwbzYpBOG
 Yh5RPFi3KRZimwxhgVruK4JC2D3CCP0AofuP9WgHpFXYQEbrhN6YQZ4UNOCZ8FWDn38YY9DY
 BVfYrhDdttABqnhkrizyFS6c3pWm52EgaNQ0AEtMDQ2z9KnGphx09dwMAEhH8P+J80VpEBvo
 3/Q+lVvaALStVTYbN2Be8HT8fyAmvRQQjUOGbXJVj8DqkIN3/Etpay6rQo4+OhfoAO0fIJ6d
 78eUIdsXR3d1PlCMWI0pEO+hfRQH+lVTCo0c1a74gRgMyLeFMqC1z1dLkDqbrUnxxEOLyoZx
 +aAuMjP8Pe
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,208,1654560000"; 
   d="scan'208";a="919222800"
Received: from alln-core-7.cisco.com ([173.36.13.140])
  by alln-iport-5.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 01 Aug 2022 15:37:00 +0000
Received: from mail.cisco.com (xfe-aln-001.cisco.com [173.37.135.121])
        by alln-core-7.cisco.com (8.15.2/8.15.2) with ESMTPS id 271Fb0Eh015652
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 1 Aug 2022 15:37:00 GMT
Received: from xfe-aln-004.cisco.com (173.37.135.124) by xfe-aln-001.cisco.com
 (173.37.135.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 1 Aug 2022
 10:37:00 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (173.37.151.57)
 by xfe-aln-004.cisco.com (173.37.135.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14
 via Frontend Transport; Mon, 1 Aug 2022 10:37:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LDTtjJBmxTutLZexkZ5yfKK9Prm3pPtbK2wK7lfkXzOD+fTG+D1Nzo2rIonPLcIr2tfXijIstEjbf8g7EMpYNGyG7Ei+daCs8FrcHJRt53JyOQizSFHHzzc1ge+bI5PY2yh+jM8tpCIqDjRdPHmDhuizAF8lTPoK1LiS0cKkyxWkg50X2wuUZI/Np+d4wWxot8urT40M6/U9zV5wV92AxG/wNEMpbh2eskIPz/TjjUl6cyb8S5FPL0avG8UX9q8EADjPpEiVOUsBIcW89NY90LP0iqyqsfkrqjBqhSy5+JN4/x+K48lFEOaregk5L2pBeZBVlFfIeYvGdJiEqv1VVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qr6x5DQfOq7hN6uqT6kHcrrkNWIkc+8ib3BXqxHAfoU=;
 b=KRC39BpuIPEiXq0exfd6dwWPmReEA6Kv0DcSbBWo/8hSj5wN+1X+XeZTmqi6se4QpXeKRVbHhgmjVeInLkhCvbUfJHE4VabyeojnKh3+9qJ+sc8zV6bXbGCQpqCpQsTM9qRmD7euTOkNtlsNMQ8FxLH7yEEtxcCcuwRy3fhNTbjhcvZT8Y+iSDvfaEbA9FI4jI+YILiF2Yyk2M5omFm5SvUsn2CWU6fzzKblwrUZow0ub585W2v1PEdZ+vQiWVcaYs+5BPzF3cWOZX8tJgn63HnWOYx76WVYk592ZfXyx7edrxErobkNLOXD5XYid2PRp29stSTDOu0xaj4eQbN/lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.onmicrosoft.com;
 s=selector2-cisco-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qr6x5DQfOq7hN6uqT6kHcrrkNWIkc+8ib3BXqxHAfoU=;
 b=ulgr/WQuvV0ZudSpxyOLBVvLFM5pfrjBiDAHK0bbK+8cL20gUk5BjxEPcl+uzKfVIf0kevTRNqjEuWrT8aeScvN+5ThrdaQGy2XHWqHTvSzwtNMinpCRess9ig+HGGDuIXAOfKmQOS+MAidvXjnUG5yYL/bUz6jGIZvzIktYdYU=
Received: from BYAPR11MB3527.namprd11.prod.outlook.com (2603:10b6:a03:8b::26)
 by BY5PR11MB4183.namprd11.prod.outlook.com (2603:10b6:a03:18e::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.15; Mon, 1 Aug
 2022 15:36:58 +0000
Received: from BYAPR11MB3527.namprd11.prod.outlook.com
 ([fe80::75bf:8e9b:9b33:91bb]) by BYAPR11MB3527.namprd11.prod.outlook.com
 ([fe80::75bf:8e9b:9b33:91bb%6]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 15:36:58 +0000
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
Thread-Index: AQHYo6zcfTXM5BpcJEqAjq/4nyvE/K2WztgAgAA9MYCAAVCSgIABX8OA
Date:   Mon, 1 Aug 2022 15:36:57 +0000
Message-ID: <6245780D-F629-4089-961B-94EBA5F0A4E3@cisco.com>
References: <20220730003846.1730265-1-balsup@cisco.com>
 <CAK8P3a0Bn9xKRX9z369zVCy6CuguTvNbtXOOPbf_OfS697cDyQ@mail.gmail.com>
 <D7DCF238-0AE9-44A0-86B1-8C731FF8BB59@cisco.com>
 <CAK8P3a1QOU+kSJo04zga8S-tHatJ3WNQBCR1Nxa10Ux1qNYb4A@mail.gmail.com>
In-Reply-To: <CAK8P3a1QOU+kSJo04zga8S-tHatJ3WNQBCR1Nxa10Ux1qNYb4A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.63.22070801
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cisco.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c76cdaf4-e38c-407e-8127-08da73d3ab94
x-ms-traffictypediagnostic: BY5PR11MB4183:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aI3LTELf6uq+1iYqyRB/Ed4clADtHLWweu5Tg7t1iVTGMyMyG9u5fBsLdtHExH+QtF3jBWHhijG197MQGSCJkqvs4pn9ahA8rLhTHwhvJgKP2dmCI/UQX+9I4HC0xLhTxvhGAViSrU3WVXLrbZzlS3PTNLhwXKWBoAh1p/ype07+P5bzOvYps8FLcnb/MuRw2I2L+vfiFXfAwfghFeJLSB/yuAUenLI8rN/9e+z/XCd7D+nnJulTkQqP1fLZgG5/CWSbcr1rrUGEFnFu/E25yRfPGVKE86+b95Dhif6jCm1z6WqVH8EepLWeSxoi3FIVRuI7yjcpT5mRDWWed08y7fcGpqzbJsXpdMy9sNSGGAbh9VdxKjXhCidO0UYJUpdaXJYUT1LOL7kX/TWo4s5hJIpQ4JQ+d+yLkMbBimHuKT+1fRWV1fIztKQUfno/jYLIIkWYqkzavjkQE4IyA1gGPG0xDKCrwqiGPcdMOSMFXAWuwH3jWlGOgEYKKDlbdPMyX0qkGB17Zwebx7avcZuUPS2W2Gr/s/zasE3hEIM2QIawzR4tPNZJgHG+fcr9pKGDi4D4pMC28im7dd5Eh6kADMiEI3nSwSCh7GTxZI0wuXPnTEMPC7pmelBMcv/MewSx2BGmNf6D/fT/p1dRQE9G5S2zH1CktTXbV9bKbmu2JaXdNUVKGNiSGgo1Kx8sDqbXElbXCAD4TxIf+tbPuiKBIpur6dbsq24enVZbxZUXLSXjxha1z6LEzjH+RMq+iuf/VTgxqJe7I50j/JuBd2vqtFsL4NviZGvNbn9LbDw7g6lqyFVN9na2k5nJqJeqVcL/3ZjYYKvDGSwbLS+KxDbhPw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3527.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(396003)(376002)(366004)(346002)(26005)(6506007)(2616005)(38070700005)(6512007)(33656002)(86362001)(122000001)(38100700002)(186003)(83380400001)(316002)(478600001)(6486002)(7416002)(8936002)(5660300002)(6916009)(71200400001)(64756008)(4326008)(8676002)(66476007)(36756003)(66446008)(76116006)(66556008)(2906002)(54906003)(66946007)(41300700001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MXNEOW05RGZMYkJXUG1BVGo3c29KWHU4dTk1S2hhakNQTWswUkNuby95czYx?=
 =?utf-8?B?eCthMWlDWnFNUmtyR0tIN2NQbVBtYU1HOVRteUMyV2R6RWZCdU85MFVVS3Bx?=
 =?utf-8?B?c0l4NnI4dmNUQndPblFEdkJOOUxhQUpiSEZYRllhUHhvLzh3bTFsMWtpN3l1?=
 =?utf-8?B?YmRRV1hMcXZrQ0lqdjhwVCtmbUdaRTFFK01lYlJuWlhScll3SGdPR2ZINjMx?=
 =?utf-8?B?bWRGeU03ekFWNURPM3JhSkFuVmFyNDRFK2FIbU9wcmFXTlk2eHE4NS9GSzk4?=
 =?utf-8?B?UmpBSVF5YitMRjJ2aG5ReGZMbE15aThqM0hsZzhCSTNobTFSQzFUSDV6RlFI?=
 =?utf-8?B?b2RwZlk2MnkxaEZEREt0d0R4c3lLSlFRMVE1a2RRNDZOYjFkT3MzdnJDVlc3?=
 =?utf-8?B?Z0REd1d4SnZPTHl1cXJJRjN4WU9WYy9aSDZtdlI5ZnVycjY0Qk1LaCs3cEtK?=
 =?utf-8?B?SDZtbXhRZkJOUDJyNUNFeEM5TzZzMHJCdkJ2Q2hVUCs0MEVyNndSWVk4dnJG?=
 =?utf-8?B?U045eCtxaTREMTJGNE5saUZLUGhnUWVGTzJWdlcxN1d5ZVNNZlg2V2oreXdW?=
 =?utf-8?B?R004dlphNHFESnFoL2JGT1JmaFdGM0hEQ2pwVk1MTW9CZHgySlR4QUdXbGto?=
 =?utf-8?B?NURuUExYeGMxTDV5dlB0cEZuWnlnSUt6ekl0QkVFcmRGd2IyM2xlNFE2OHFX?=
 =?utf-8?B?bnU4RzREMjZKRVhyUnVQWkE1MDV0bFNVdXVFMi9wSHhaYTV1a2tsWjdsdk1B?=
 =?utf-8?B?dzRkNC9vK3NFNUFkbnhmaXYyKzh0THZXMWdod3pNS3NYZDgxeXJTV21sRGE1?=
 =?utf-8?B?MUh6aGFUU2FVODFheXhONG5nUnAyQkpWSDFFUDFyYUFWSUV2ZVovUWcrZ0k0?=
 =?utf-8?B?cWptUlE5MzVZZnJJeCsxSEZ5WVRZZ2lBY2dCVEhpR1JvczRCbmJ3aEhLSVYw?=
 =?utf-8?B?M2gvck44aEliRlQrVTVHMExKcmc0UzV6UkphR0UwSmE2UzlUOWM1Um5xdXgr?=
 =?utf-8?B?TGxrRHBkcFFkTEIyVURBUGZxdy9PY0V1ekIrNUJNTTZVRGh4aE5nVmt2RGVw?=
 =?utf-8?B?dk9WamdKS0d1OHJFazU5T2JFMXQ4cUp5dzJScjBydVYvMUdaVmNvTmJaN3Fw?=
 =?utf-8?B?OC9mVFFLZkdlZTNlWk92TldVZGJPeHlLZnd6L2FNVnhEZktiL21EanlUcWgw?=
 =?utf-8?B?U1c2RlBQdjNTVmNwOTEwWGNBUE5XdzZQbzdJUmN1Ui9GK1cxVVQyM2RqeDd5?=
 =?utf-8?B?RlFBZHh6U09iSWswTVBtdWc0aXVSR1U0ZHF6K3ZFMDVGeWRsZ2gzM1hVa1J0?=
 =?utf-8?B?ditoTUcrTzh4RVp5YlBpdE5uNGJsajMrOGZHMmVDck1TRk5QaXpKT0dvNm83?=
 =?utf-8?B?TVllTmF2eFZSYm1abVBkQTBTVmlZUHB0NDNIT0t4QjlaQnVHSm1qQVY3d2J1?=
 =?utf-8?B?dmpaUzJNTUIwTlozUGdiN2ZhcnA2VDJ0bG82c0hGRjNFU3VFVGVQWFBlV0lx?=
 =?utf-8?B?NWRQdTNTUzdUWG5EOHhxYjYyTHhEV0FYemhoSTkveE90clBuOE9WK3VyUmJn?=
 =?utf-8?B?ZjZ1TW5HNy9XWWF5S2RwT3pxSjdBTHhBRk5naEhzU0FhREswZndiMTgxdmNt?=
 =?utf-8?B?MEt0c3dFZTBwV0FSOC90VjZ0eGtoZmFCSnpnY3Z6NHdoV1Z2bFlJcXNpSnZG?=
 =?utf-8?B?TGFkVXBraG1NN0JrU0tja2lBdHZ0MlJGSko5VmplZE4vem9XMmx3cVgxSnlw?=
 =?utf-8?B?YXdreitzTVJPcC9jNkRRSjVOcHlHVUFVRkFValRkRGVFa3NtQkl2TGdLM1ZC?=
 =?utf-8?B?YmpEdmZZbEJvNnVMT0RlTUpvOE5aSzVUK1ZOdDgvUWszWFBOc0dwNzAyam0w?=
 =?utf-8?B?Q0VoYWdpMVZQcmYrdHJtSEJnL3ZWZVgyYng2eFFldDBhNUI3SXRvYnp4bGFm?=
 =?utf-8?B?Q2NoREZEQ2U1c2VEYSs0RThkVExzbnRQdVZnbDJzU1VCLzJJT1FiQjJQWmJn?=
 =?utf-8?B?cDBWdmtOTExqeTVyNDh5Yk9kZGdVemIyOWZ0VWtud1dNVTRGWXc5MVJJRmt0?=
 =?utf-8?B?TWMra0NZaU5BUThqaDZRdnpvNVg2U0g1SlNMeFFSZ1pXRkh0d2U5cURadHlv?=
 =?utf-8?Q?HoEeXARYklW1wUu3Rh/8qGux4?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8D3C1AAF9B1B90489D9F1190327594B2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3527.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c76cdaf4-e38c-407e-8127-08da73d3ab94
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2022 15:36:58.0120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m96sPK78Md8HNn8PeBMwh1fKYKC7gD5WwEpOug5DCh+fJewWEXxM7Him3L3NUeDCVnJP8IL8Cu0Y29SRt5V/iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4183
X-OriginatorOrg: cisco.com
X-Outbound-SMTP-Client: 173.37.135.121, xfe-aln-001.cisco.com
X-Outbound-Node: alln-core-7.cisco.com
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCu+7v09uIDcvMzEvMjIsIDQ6NDQgQU0sICJBcm5kIEJlcmdtYW5uIiA8YXJuZEBhcm5kYi5k
ZT4gd3JvdGU6DQoNCiAgICA+T25lIHdheSB3ZSBjb3VsZCBkbyB0aGlzIGlzIHRvIGtlZXAgdGhl
IGV4aXN0aW5nDQogICAgPkNPTkZJR19BUkNIX05SX0dQSU8gZm9yIG9uLWNoaXAgR1BJT3MsIGFu
ZCB0aGVuIGFkZA0KICAgID5hIG5ldyBLY29uZmlnIG9wdGlvbiBmb3IgZXh0cmEgR1BJT3Mgb24g
dGhpbmdzIGxpa2UgUENJIGNhcmRzIG9yDQogICAgPnByb2dyYW1tYWJsZSBsb2dpYy4NCg0KVGhh
bmsgeW91IGZvciB5b3VyIGZlZWRiYWNrLiAgVGhpcyBtYWtlcyBzZW5zZSB0byBtZSwgYnV0IHlv
dXINCm5leHQgc3RhdGVtZW50IGhhcyBtZSByZXRoaW5raW5nIHRoZSBwcm9ibGVtLg0KDQogICA+
IEluIHlvdXIgdXNlIGNhc2UsIGNhbiB5b3UgaWRlbnRpZnkgYSBzZXQgb2YgZHJpdmVycyB0aGF0
IG5lZWQgYWNjZXNzDQogICAgPnRvIG9sZC1zdHlsZSBHUElPIG51bWJlcnMgYWJvdmUgdGhlIGhh
cmRjb2RlZCBvbi1jaGlwIG51bWJlcnM/DQogICAgPk1heWJlIHdlIGNhbiBwcmlvcml0aXplIGZp
eGluZyB0aG9zZSBkcml2ZXJzLg0KDQpGb3IgRkJPU1MsIGxpYmdwaW8gaXMgdXNlZCwgc28gY29u
dHJvbGxlciBzcGVjaWZpYyBvZmZzZXRzIGFwcGx5LiAgVGhlIG9ubHkNCmlzc3VlIGlzIHRoYXQg
b3VyIGdwaW8gY29udHJvbGxlciBhbGxvd3MgdGhlIGtlcm5lbCB0byBzZXQgdGhlIGJhc2UgcGlu
DQpudW1iZXIsIGFuZCB0aGF0IHdpbGwgZmFpbCB3aXRoIGEgc21hbGwgQVJDSF9OUl9HUElPUy4g
V2UgY2FuIHdvcmthcm91bmQNCnRoaXMgaXNzdWUgYnkgZXhwbGljaXRseSBhc3NpZ25pbmcgYSBi
YXNlIHBpbiBudW1iZXIgKGFzIGEgcHJvcGVydHkNCnJlYWQgZnJvbSBkZXZpY2UtdHJlZSBvciBB
Q1BJKS4gIEZvciBTT05pQyBob3dldmVyLCBHUElPX1NZU0ZTIGlzIHN0aWxsDQp1c2VkLiAgRnJv
bSBjb2RlIGluc3BlY3Rpb24sIHRoZSBncGlvX2lzX3ZhbGlkIGNhbGwgd291bGQgb25seSBhcHBs
eQ0KaWYgYSBwaW4gbnVtYmVyIHdlcmUgdXNlZCB0aGF0IGRvZXMgbm90IHlldCBleGlzdC4gIFN1
Y2ggd291bGQgYmUgdGhlDQpjYXNlIHdoZXJlIHRoZSBwaW4gbnVtYmVycyBhcmUgcHJlZGVmaW5l
ZCwgYnV0IHBlcmhhcHMgdGhlIGNvbnRyb2xsZXINCmhhcyBub3QgeWV0IGJlZW4gaG90LXBsdWdn
ZWQuICBJbiBzdWNoIGNhc2VzIGEgcHJfd2FybiBpcyBlbWl0dGVkIGZyb20NCmdwaW9fdG9fZGVz
Yy4gIEhvd2V2ZXIsIEkgdGhpbmsgdGhpcyBzaG91bGQgYmUgb2sgKGFzIGl0IHdvdWxkIGJlIG9u
bHkNCmFuIG9jY2FzaW9uYWwgcmFjZSBjb25kaXRpb24gd2hlbiB0aGUgYXBwbGljYXRpb24gc3Rp
bGwgdGhvdWdodCBhIGRldmljZQ0Kd2FzIHBsdWdnZWQgaW4gYW5kIHRyaWVkIHRvIGFjY2VzcyB0
aGUgZGV2aWNlLCB3aGlsZSBhIHVzZXIgd2FzIGluIHRoZQ0KcHJvY2VzcyBvZiByZW1vdmluZyBz
YWlkIGRldmljZSkuDQoNCkxldCBtZSBydW4gc29tZSBleHBlcmltZW50cyB3aXRoIG91ciBjb250
cm9sbGVycyBwYXNzaW5nIGluIGFuIGV4cGxpY2l0DQpiYXNlIHBpbiBudW1iZXIgaW5zdGVhZCBv
ZiBsZXR0aW5nIHRoZSBrZXJuZWwgYXV0by1hc3NpZ24gaXQuICBUaGlzIHdpbGwgb2YNCmNvdXJz
ZSBiZSBvdXRzaWRlIG9mIHRoZSBBUkNIX05SX0dQSU8gc2V0dGluZy4gIElmIHRoaXMgaXMgc3Vj
Y2Vzc2Z1bCwNCnRoZW4gbm8gS2NvbmZpZyBjaGFuZ2VzIGFyZSBuZWNlc3NhcnkuICBJZiB0aGVy
ZSBhcmUgc3RpbGwgaXNzdWVzLCB0aGVuDQpJIHdpbGwgZm9sbG93IHVwIHdpdGggYSBWMiB0aGF0
IHNldHMgYW4gRVhUUkFfTlJfR1BJTyBvciBzaW1pbGFyIGluDQpkcml2ZXJzL2dwaW8vS2NvbmZp
ZyBhcyB5b3UgaGF2ZSBzdWdnZXN0ZWQuICBUaGlzIGNhbiBkZWZhdWx0IHRvIDAuDQpUaGlzIGVu
c3VyZXMgdGhhdCB0aGUgcGxhdGZvcm0gc3BlY2lmaWVkIENPTkZJR19BUkNIX05SX0dQSU8gaXMg
bm90DQpzZXQgdG9vIGxvdyAoaW5jb25zaXN0ZW50IHdpdGggdGhlIHBsYXRmb3JtIHJlcXVpcmVt
ZW50cyksIGFuZCBnaXZlcw0KdXMgdGhlIGZsZXhpYmlsaXR5IHRvIHN1cHBvcnQgYWRkaXRpb25h
bCBjb250cm9sbGVycy4gIFRoaXMgbWlnaHQgYmUNCm5lY2Vzc2FyeSBpZiB3ZSBoaXQgdGhlIEFS
Q0hfTlJfR1BJTyBsaW1pdCB3aXRoIGdlbmVyaWMgaTJjIGdwaW8NCmV4cGFuZGVycyAoYWx0aG91
Z2ggZXZlbiBpbiB0aGF0IGNhc2UsIHJlYWRpbmcgdGhlIGJhc2UgcGluIGZyb20gDQpkZXZpY2Ut
dHJlZSBvciBBQ1BJIHNlZW1zIGxpa2UgYSBiZXR0ZXIgc29sdXRpb24pLiAgZ3Bpby1wY2E5NTN4
IGRvZXMNCmFsbG93IHNldHRpbmcgdGhlIGJhc2UgdG9kYXkgZnJvbSBwbGF0Zm9ybSBkYXRhLCBi
dXQgd2UgcHJlZmVyDQpkZXZpY2UtdHJlZSBhbmQgQUNQSSBvdmVyIHRoZSBwbGF0Zm9ybSBkYXRh
IHRlY2huaXF1ZS4NCg0KVGhhbmsgYWdhaW4gZm9yIHlvdXIgZmVlZGJhY2shDQoNCg0K
