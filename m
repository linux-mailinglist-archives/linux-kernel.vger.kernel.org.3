Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D4C586E96
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 18:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbiHAQeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 12:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbiHAQe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 12:34:28 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 01 Aug 2022 09:34:22 PDT
Received: from rcdn-iport-9.cisco.com (rcdn-iport-9.cisco.com [173.37.86.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF8E37187
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 09:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=3207; q=dns/txt; s=iport;
  t=1659371662; x=1660581262;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=yyJwzqCQPtV140lidHN70jorJHE8uwvmb8Ff230T8f8=;
  b=gabIWB3x4bO/VhuM9Rhs1ae3O5JHN07Jmqnmjjne7c9JNuZ09ElW/l6F
   +TQknrAsv7iVg0z0B+AcV2tzsHClxrgI9HOtO6rP4WAwcLiwie+FeNwV7
   rLdmB7poIej5tI7je3U3pGRQIwzSaGn7xvRWPTWS8wsni1+4Hsj+mn31n
   c=;
IronPort-PHdr: =?us-ascii?q?A9a23=3A43Y0gR+0WNWDcP9uWCXoyV9kXcBvk7n3PwtA7?=
 =?us-ascii?q?J0hhvoOd6m45J3tMQTZ4ukll17GW4jXqpcmw+rbuqztQyoMtJCGtn1RfJlFT?=
 =?us-ascii?q?RRQj8IQkkQpC9KEDkuuKvnsYmQ6Ec1OWUUj8Wu8NB1eGd31YBvZpXjhhQM?=
 =?us-ascii?q?=3D?=
IronPort-Data: =?us-ascii?q?A9a23=3AT5ebdKMha3fMcmPvrR25lsFynXyQoLVcMsEvi?=
 =?us-ascii?q?/4bfWQNrUoggWdVnDcfCm7VM63Zazaje9EgPonl8U9U7ZXdz9NkTHM5pCpnJ?=
 =?us-ascii?q?55oRWUpJjg4wn8dtEp+F+WbJK5cx5hYO4CowPwcFCeG/E/wa+a59BGQ6InRL?=
 =?us-ascii?q?lbCIL+cUsxObVcMpBcJ0XqPqsZh6mJaqYHR7zCl4bsel/bi1GqNgFaYBI67B?=
 =?us-ascii?q?5Wr83uDtNyq0N8RU8dXifpj5DcynFFNZH4TyD3YEpf2fmVUNrbSq+fr1rq1+?=
 =?us-ascii?q?CbS+A0gT4rjmbfgeUpMSbnXVeSMoiMJAO753V4T/Wprj/xT2Pk0MS+7jx2Jk?=
 =?us-ascii?q?t9t1thBqbS7SBwiOevHn+F1vxxwQnwvZvQYoeWZSZS4mYnJp6HcSFPwxO9wB?=
 =?us-ascii?q?UU6JqUc++BqESRA8uEeJDkRbxeFweWsz9qTQ+p0g+wnLc/2LMYRvWxmwTjFD?=
 =?us-ascii?q?PEgB5fZTM3i+dhCxys9gIZOHPLUfcsSaRJ0YR/dZRBTfFwQDfoWguashnT7d?=
 =?us-ascii?q?ntXsluEjaUy6mnXigd21dDFLNXRavSORMNIglyfoGPWuWj0ajkYM9G30Tef+?=
 =?us-ascii?q?XKhnanEmiaTcIsWELyj8fhChFqT23AUC1sQWEfTieikkF/4XdVFLFI89S8nr?=
 =?us-ascii?q?Kx0/0uuJvH3WAe+vGSNsxERQfJcHqs74gTLwa3Riy6dB24ZXntCZcYgucseW?=
 =?us-ascii?q?zMnzBmKksnvCDgpt6eaIVqS7LqbrjOaPSkTMH8MYjICQQIZ4t7l5oYpgXryo?=
 =?us-ascii?q?nxLeEKupsf+FTe1yDeQoW1nwb4SlsUMka68+Dj6b/uXjsChZmYICs//BwpJN?=
 =?us-ascii?q?j9EWbM=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AFHtUUqGNv9/wpfXUpLqFVpHXdLJyesId70?=
 =?us-ascii?q?hD6qkvc3Jom52j+PxGws526fatskdtZJkh8erwXJVoMkmsiaKdhrNhcItKPT?=
 =?us-ascii?q?OW8ldASbsC0WKM+UyZJ8STzJ8+6U4CSdkzNDSTNykAsS+S2mDReLxMoKjlzE?=
 =?us-ascii?q?nrv5al854Hd3AMV0gU1XYBNu/tKDwReOApP+tdKLOsou584xawc3Ueacq2Ql?=
 =?us-ascii?q?MfWfLYmtHNnJX6JTYbGh8O8mC1/HyVwY+/NyLd8gYVUjtJz7tn23PCiRbF6q?=
 =?us-ascii?q?KqtOz+4gPA1lXU849dlLLau5V+7Y23+4kowwfX+0WVjbdaKv+/VfcO0aSSAW?=
 =?us-ascii?q?MR4ZnxStEbToBOAj3qDyaISFDWqnbdOX4VmgHfIBmj8D3eSQiTfkNjNyKH7r?=
 =?us-ascii?q?gpKycxonBQze1UweZF2XmUuIFQCg6FlCPh58LQXxUvjUasp2E++NRjxkC3fL?=
 =?us-ascii?q?FuH4O5l7Zvin99AdMFBmb3+YonGO5hAIXV4+tXa0qTazTcsnN0yNKhU3wvFl?=
 =?us-ascii?q?PeK3Jy8fC9wnxThjR03kEYzMsQkjMJ8488UYBN46DBPr5znL9DQ8cKZeZ2Bf?=
 =?us-ascii?q?sHQ8GwFmvRKCi8eF66MBDiDuUKKnjNo5n47PE84/yrYoUByN8olJHIQDpjxB?=
 =?us-ascii?q?oPkoLVeLizNbFwg2PwqT+GLETQI+lllupEhoE=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0BwAADea4Ji/5hdJa1aHQEBAQEJARI?=
 =?us-ascii?q?BBQUBQIE7CAELAYFRUgd1Alg5Q4gaA4RSX4UJXYIoixSQJIEsgSUDVAsBAQE?=
 =?us-ascii?q?NAQE5CQQBAYUCAoU+AiU0CQ4BAgQBAQESAQEFAQEBAgEHBIEJE4VoDYZCAQE?=
 =?us-ascii?q?BAQMSKAYBATcBDwIBCBUDHgULIRElAgQOBQgaglyCYwMxAQ6fZwGBPgKKH3i?=
 =?us-ascii?q?BM4EBgggBAQYEBIE3AYNVDQuCOAmBPAGDE4MCiEonHIFJRIEVQ4JnPoIggiQ?=
 =?us-ascii?q?ChAuCLoMbimmHYzsDVIEFEoEhcQEIBgYHCgUyBgIMGBQEAhMSUx4CEwwKHA5?=
 =?us-ascii?q?UGQwPAxIDEQEHAgsSCBUsCAMCAwgDAgMjCwIDGAkHCgMdCAocEhAUAgQTHws?=
 =?us-ascii?q?IAxofLQkCBA4DQwgLCgMRBAMTGAsWCBAEBgMJLw0oCwMUDwEGAwYCBQUBAyA?=
 =?us-ascii?q?DFAMFJwcDIQcLJg0NBBwHHQMDBSYDAgIbBwICAwIGFwYCAnEKKA0IBAgEHB4?=
 =?us-ascii?q?lEwUCBzEFBC8CHgQFBhEJAhYCBgQFAgQEFgICEggCCCcbBxY2GQEFXQYLCSM?=
 =?us-ascii?q?cLAsGBQYWAyZSBQQfAZV2gWiBGxMrUYEKlkABqissawqDTIsajnOGGRWFRKM?=
 =?us-ascii?q?TLZY5hHiIL4NZkH+EfwIEAgQFAg4BAQaBYTyBWXAVgyMJCj4ZD44gN4M7hRS?=
 =?us-ascii?q?FSnUCATgCBgsBAQMJkRoBAQ?=
X-IronPort-AV: E=Sophos;i="5.91,230,1647302400"; 
   d="scan'208";a="959316126"
Received: from rcdn-core-1.cisco.com ([173.37.93.152])
  by rcdn-iport-9.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 01 Aug 2022 16:33:18 +0000
Received: from mail.cisco.com (xfe-rcd-005.cisco.com [173.37.227.253])
        by rcdn-core-1.cisco.com (8.15.2/8.15.2) with ESMTPS id 271GXI6L021926
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 1 Aug 2022 16:33:18 GMT
Received: from xfe-rtp-001.cisco.com (64.101.210.231) by xfe-rcd-005.cisco.com
 (173.37.227.253) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 1 Aug 2022
 11:33:18 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (64.101.32.56) by
 xfe-rtp-001.cisco.com (64.101.210.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14
 via Frontend Transport; Mon, 1 Aug 2022 12:33:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PEYq3X1qqIqefC8Q3PkbFrPEG9oaJoZx5g42rnDqxNxaYJfKaCPNtfd3IjoOk/4jntdboL1rZOCSLgNfntrePNgm6ahtZBxDzc6mU06LIuM0nwMkPMpgL1TUV5RPCGvrFFJNrJYuBFS4itFKEWi68q/Xp7PzcyXjDcFk+BrsBFodHPF65IT/iNubC+DsTOpmFQhMiFEzAzvMQ2XFTewoFEJeY65AqwpOJL8hVQsEJCOHPZxCQ8lR3XchHyNTT66gNFRpzkmY8NmcO76lwBE2CqDRPP+DkwTPoSpPhKBi/WzQsz9f4/4RSj2rgoCicRFku7IOV1bVEFXPlpAV7GMQvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NobGOPm2rsPQFjc9zHaKVL26+IAUvRklSL5I95ZpC0Y=;
 b=buq8Tx0w5pTg0WnRp94FZORFhdQLiv67F1pqjKJC3z8oOCAsE6SwudOCylJDNyKt0Whqf88prXIdKY/tYkDEN9Sz7VGPeQVAx1FQxp/GZj7JCGizCh5/nhi9vjLedXdEKNRDd/EFPxEuSC9sppdn7q3scnXQU3THxGPWA8f40ilp1BYcpJJZECi/ZSgcdCqlpbOBu1FIpuyT2ryiO7ja8nScFzsb/aA47hn9WGjtGKj7AujWlYWXQCvGV/wg6e/qmzfhBZ0tf+A6XBRRfGoVUPFMmjNRl6jipc8RTadLFYchSqjA3uS4i7u5KqwEz9dOhZlQGc7E+/5D+sPAecq4Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.onmicrosoft.com;
 s=selector2-cisco-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NobGOPm2rsPQFjc9zHaKVL26+IAUvRklSL5I95ZpC0Y=;
 b=eGnT0aSg4PxcBTYkN/f4Zaj3beYmc8n4oXlGA5o+I0JAqEF2VwB98llKHZak5yS4s+6kITErLYdcVa3a8jMg4db9rX47v2qijTocn4aXSo3kgfoWkZv/YAN8L8CJ4ft/85iK6vQQkKE0gTSgRZxZIamP5QCSQzccf7+6gChpXQs=
Received: from DM5PR11MB0012.namprd11.prod.outlook.com (2603:10b6:4:68::36) by
 DM5PR11MB1563.namprd11.prod.outlook.com (2603:10b6:4:5::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5482.15; Mon, 1 Aug 2022 16:33:16 +0000
Received: from DM5PR11MB0012.namprd11.prod.outlook.com
 ([fe80::9dd1:452:e3b1:c527]) by DM5PR11MB0012.namprd11.prod.outlook.com
 ([fe80::9dd1:452:e3b1:c527%5]) with mapi id 15.20.5482.015; Mon, 1 Aug 2022
 16:33:16 +0000
From:   "Hans-Christian Egtvedt (hegtvedt)" <hegtvedt@cisco.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Christian Borntraeger" <borntraeger@de.ibm.com>,
        Yury Norov <yury.norov@gmail.com>,
        Allison Randal <allison@lohutok.net>,
        Joe Perches <joe@perches.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Torsten Hilbrich <torsten.hilbrich@secunet.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [v4.9 PATCH 1/6] include/uapi/linux/swab.h: fix userspace
 breakage, use __BITS_PER_LONG for swap
Thread-Topic: [v4.9 PATCH 1/6] include/uapi/linux/swab.h: fix userspace
 breakage, use __BITS_PER_LONG for swap
Thread-Index: AQHYpZcr1yx3FrFazUy92OCHJ4IlcA==
Date:   Mon, 1 Aug 2022 16:33:16 +0000
Message-ID: <DM5PR11MB0012AB20FEF4F3895792863FDD9A9@DM5PR11MB0012.namprd11.prod.outlook.com>
References: <20220731182635.1910069-1-hegtvedt@cisco.com>
 <20220731182635.1910069-2-hegtvedt@cisco.com> <Yue0Tj+tnXRhCWab@kroah.com>
Accept-Language: en-DK, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cisco.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c0da23d8-e232-47f9-b9e7-08da73db896f
x-ms-traffictypediagnostic: DM5PR11MB1563:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yMQfa+BYOeMQQVOsZqixIO/31Z4aG8PuIrSo9gQK/qlVmX/YNcL6sZwYJomYPx5x9Px1yqX+Rtxx1e+n8AP4/D1ydokID4xokIhOu/h7vQ0VWRyE/1v5wYY0/fpGkKTPWEashd9dFEZgr+UbfrE/7vfmQ6Ajy6JXlV3jK3h4inThCe9SvhwrhZk7KXay2JudL1AGrW3b6TKw6EmUZP3popjklAW36wj18YRdJtkD+wi7klee3Ry62lJkGMLwDPV1Fk7nSXUW/IibSWMSD4R54U8eXdLS8Zb9i1wHIUAL5854jRvp2wMdly3C1Srl3Z13kqmkb3ppaEjrILi0HAWWEyb1F8wua9vk/FSuqXYRsnua/SLN/99Hv6Rflnhxx+P0KJOsH/beBHt7L5iPoe92xll2V6F8DNP/IVDt0joVUNee34mnRrJBhx7hjOCquR7Zs9FQwPsTjtndWpw2+HNd5UA/BWYwPyMNtYbs8/Tnlh6GSJLx1+uZTxUpv2mwEWH8Q5x3GnY0my7m87GX4s65SrUAgN0uLR5bPgqkJeylaiPeNQYvppp1/3Ehg2Z18XYC/0pRfmii0qgENJ5GNOaXS2xbdnzoX6LVXTfg8G6DViRkE/9JH3pRH0BigNfQTbquXC/3PIAdHTyQBbkOVyMKhjvBdYuwuv86R6Sa2yCmFjJxaxOSNHr7ZwPtI31OI4anGwW5kvzPZ0WSxbGDyocYXd37TnPLUDo3HrfR/wGIxPrfpaxNhM0+S08lWFOVPXLwjc1fUjIJjSC2+GPN22mbcFPlpfeAxwWUwODfaT81D+oDuvrnbpHSDKiYIufXubwQTOoDFARjOS5TqxwXslFmqw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB0012.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(346002)(376002)(366004)(396003)(71200400001)(83380400001)(76116006)(91956017)(186003)(38100700002)(316002)(54906003)(6916009)(8676002)(66476007)(66446008)(66556008)(66946007)(4326008)(64756008)(52536014)(8936002)(9686003)(26005)(966005)(38070700005)(5660300002)(478600001)(6506007)(53546011)(7696005)(86362001)(41300700001)(55016003)(122000001)(33656002)(7416002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dIBZ2CWkvQXQP951WEeWIFDGYTLwabecI3htdcbU0x1L3ZOa3IiZxd70ehJG?=
 =?us-ascii?Q?cPcoXLEaWH18r4GtVFvW/ismeLc+HdK85cYb9HHZMAe+ecIgSG4IzyH9z8Ai?=
 =?us-ascii?Q?St1pswupBIIusP+5Uf/U/jnGcZ0OT/DA3AQFLwWWalntiHjeOUzEW5j+Wj0v?=
 =?us-ascii?Q?wLmfYSqip0TgqKvJcfKATkTOS5JRUObgZxxtZYVZtGGx2Ae9G0jMCPtTp4MT?=
 =?us-ascii?Q?4GK/0VwTJhIVAA8nt65uf2SsoHyUwvVu/H2fw3c+g2uUfNKU2NjSpji2S1mr?=
 =?us-ascii?Q?yFJUpWBVwwSDOeRX4paNLOElE52jcGE25jq6kPJAXRraHmXwbGnwcrrxEXpt?=
 =?us-ascii?Q?IzglLmBEeApFBw+iygxaNMO5exyK4IVkTc2yiTt43X4ZIYIn0qVAb5S1aDx2?=
 =?us-ascii?Q?+o7+NcxT506FvkXuger8h7GLdVTYQ+7RGWEa2CD/GoirmZZreOtmXBhQvNMe?=
 =?us-ascii?Q?+3m12BrAZcLRphYXt5W8+cUrVIGGRNZ6vE8398O5B92eZrhbEjirhfNVB24b?=
 =?us-ascii?Q?XHB9ZpjA2W1Tnc2csq11ZnJU2NU8RlAyaIrCDaixIfGlNilaBBXGbKEZFpfk?=
 =?us-ascii?Q?re2a5kS16PWm5SZbKU4z9/5Mbke77Xm0OUfvuGw2bKUAwxPYCsLesMl8oq33?=
 =?us-ascii?Q?J8f18R8RhMLK1/EhvpAfmO5wEFQxvAaqqPoZIUlY7qRyZG7pusoDoI1bwG3g?=
 =?us-ascii?Q?qwloL9XIJdUmajwFzC1LI+twh9suk+hf/gtkmaak/270OLT47kswZ3oBKIeU?=
 =?us-ascii?Q?Dbu+El4EIUu2MQZRtNWIsaTzywwuQUDdbFYbozrfh1ujJ0za/vkrm3n32u1v?=
 =?us-ascii?Q?CqiiJrAlieoKP+lAqE+MZROvmlNt0to0eVZGvQBUDA8uccyS0WAUiRmaKox/?=
 =?us-ascii?Q?JJVLzfg4CgHJRS5huOu5//wCdD/rq7m2BZFUqXHYX6WHr42iEVKc9Jaw85+l?=
 =?us-ascii?Q?uipW0jfR5bQ7gRjAdJZaUgvS6mN63e+qiEeQ/IlJDxXGY1bZGk25qFaGEBdg?=
 =?us-ascii?Q?Tcme5w4mjILP8YeH93l3rLQlA0mMTUOSlmJ2orFepKMzx1F0jluULWQvfROA?=
 =?us-ascii?Q?8nqL6X5wDIAI9P73OMHc+BlewCP2L+pvVoF9LSv+0PuCDiD2DzIm5jBy1meZ?=
 =?us-ascii?Q?9xIUSjesRdtEqB5U2TblYk2pXCHGzFwLLT7hvkuM3SvelEu7dy/LPwXnWoNT?=
 =?us-ascii?Q?9AfhJz7CIPVW0rR/CNVqzM5FvYTqB7jBBNWj+MmqthOwZI0L+obxQNdH/exx?=
 =?us-ascii?Q?Mn2ELte3/a53dMugscgcbsHawNdUoto64DsfcMBwEfYXxYw9d3oabv4qVjaC?=
 =?us-ascii?Q?XrbPTtOzHb2FlMLi6xk6OrL4avhxIg4d3hSrwgbUYuzsz9mEYpEX83Qwc8O3?=
 =?us-ascii?Q?BU0GbvA9hYoI4l8lIDeRmH0i2A2herZTM/CpFa2O5PECtqK1iRTQlQtZnOui?=
 =?us-ascii?Q?QethViNAqEbOl2NaErFxQ/+nV/8XQCPcquuSduagaTraus+5lSbVXI3srb8V?=
 =?us-ascii?Q?q/taYnx4u+GgEpVADx0fldsQXIa6bT397okLYnk4Y4mSbbrTDlbvQ26BV3zY?=
 =?us-ascii?Q?nLT6ix8V8cEUY5UX3JPsx+3/pN/RnnpYU4PdG1O+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB0012.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0da23d8-e232-47f9-b9e7-08da73db896f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2022 16:33:16.6554
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bhuNvM8eIR5tV0yHcI3+yIZUSyQBTEj4e0txJ2BlKqTlJb0SioTahoQC+aPq3vXbiYqepsGoHMc5h2sNeqfx0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1563
X-OriginatorOrg: cisco.com
X-Outbound-SMTP-Client: 173.37.227.253, xfe-rcd-005.cisco.com
X-Outbound-Node: rcdn-core-1.cisco.com
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/08/2022 13:09, Greg KH wrote:=0A=
> On Sun, Jul 31, 2022 at 08:26:31PM +0200, Hans-Christian Noren Egtvedt wr=
ote:=0A=
>> From: Christian Borntraeger <borntraeger@de.ibm.com>=0A=
>>=0A=
>> QEMU has a funny new build error message when I use the upstream kernel=
=0A=
>> headers:=0A=
>>=0A=
>>       CC      block/file-posix.o=0A=
>>     In file included from /home/cborntra/REPOS/qemu/include/qemu/timer.h=
:4,=0A=
>>                      from /home/cborntra/REPOS/qemu/include/qemu/timed-a=
verage.h:29,=0A=
>>                      from /home/cborntra/REPOS/qemu/include/block/accoun=
ting.h:28,=0A=
>>                      from /home/cborntra/REPOS/qemu/include/block/block_=
int.h:27,=0A=
>>                      from /home/cborntra/REPOS/qemu/block/file-posix.c:3=
0:=0A=
>>     /usr/include/linux/swab.h: In function `__swab':=0A=
>>     /home/cborntra/REPOS/qemu/include/qemu/bitops.h:20:34: error: "sizeo=
f" is not defined, evaluates to 0 [-Werror=3Dundef]=0A=
>>        20 | #define BITS_PER_LONG           (sizeof (unsigned long) * BI=
TS_PER_BYTE)=0A=
>>           |                                  ^~~~~~=0A=
>>     /home/cborntra/REPOS/qemu/include/qemu/bitops.h:20:41: error: missin=
g binary operator before token "("=0A=
>>        20 | #define BITS_PER_LONG           (sizeof (unsigned long) * BI=
TS_PER_BYTE)=0A=
>>           |                                         ^=0A=
>>     cc1: all warnings being treated as errors=0A=
>>     make: *** [/home/cborntra/REPOS/qemu/rules.mak:69: block/file-posix.=
o] Error 1=0A=
>>     rm tests/qemu-iotests/socket_scm_helper.o=0A=
>>=0A=
>> This was triggered by commit d5767057c9a ("uapi: rename ext2_swab() to=
=0A=
>> swab() and share globally in swab.h").  That patch is doing=0A=
>>=0A=
>>   #include <asm/bitsperlong.h>=0A=
>>=0A=
>> but it uses BITS_PER_LONG.=0A=
>>=0A=
>> The kernel file asm/bitsperlong.h provide only __BITS_PER_LONG.=0A=
>>=0A=
>> Let us use the __ variant in swap.h=0A=
>>=0A=
>> Link: http://lkml.kernel.org/r/20200213142147.17604-1-borntraeger@de.ibm=
.com=0A=
>> Fixes: d5767057c9a ("uapi: rename ext2_swab() to swab() and share global=
ly in swab.h")=0A=
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>=0A=
>> Cc: Yury Norov <yury.norov@gmail.com>=0A=
>> Cc: Allison Randal <allison@lohutok.net>=0A=
>> Cc: Joe Perches <joe@perches.com>=0A=
>> Cc: Thomas Gleixner <tglx@linutronix.de>=0A=
>> Cc: William Breathitt Gray <vilhelm.gray@gmail.com>=0A=
>> Cc: Torsten Hilbrich <torsten.hilbrich@secunet.com>=0A=
>> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>=0A=
>> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>=0A=
>> (cherry picked from commit 467d12f5c7842896d2de3ced74e4147ee29e97c8)=0A=
> =0A=
> As you are passing on patches from others, it is usually requried that=0A=
> you too sign-off on them.  Can you fix that up on this series and resend=
=0A=
> it so that I can take them?=0A=
=0A=
Yes, sorry, we do not add signed-off-by entries internally, so my git=0A=
config does not add it by default. Will resend the series.=0A=
=0A=
-- =0A=
Best regards, Hans-Christian Noren Egtvedt=0A=
