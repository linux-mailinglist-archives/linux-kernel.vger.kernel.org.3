Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35208591FA9
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 13:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbiHNL62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 07:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiHNL60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 07:58:26 -0400
Received: from esa2.hc3370-68.iphmx.com (esa2.hc3370-68.iphmx.com [216.71.145.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D603013E20
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 04:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1660478302;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9z0Ds9VCX1OaAkzkyQCfgtjKdmfV9Fn8HENyPID2tNw=;
  b=aDy9HZ83+bTPdw0mQ33cGNzuchKVWtwDRQAiiW85uPFGDEcyD0D8ppRl
   z0TwI5iXc9AAz9lUpV51pTgfkwXq0niTH2RPfOchWJlcbPYzUZbFtbYDK
   DuNOVXSMXckKIxw4LdZoq0byhpLlOIvhHV16w8jiAutpIlBebBaALI6N9
   o=;
X-IronPort-RemoteIP: 104.47.57.169
X-IronPort-MID: 78062482
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: =?us-ascii?q?A9a23=3AggPytKs6BwgbaD7oYfir7rYF3efnOphVZhnMI?=
 =?us-ascii?q?MmfNqXej2XJXxfKv0VenOmqQY87lptIF4alNSHST4PzKe4jnKoZ0izqCEa6Q?=
 =?us-ascii?q?H6F6NTWHA3uREtQtodjdSJ/fNBe2qSfuKDHH4YujZ0C/xXX02LxFEotNG0+h?=
 =?us-ascii?q?HSJ7yX8D3JTqztB5mBHLobbaDodLT/EnuTnOkQ2oZeHMjdPesP+fNlon5FxF?=
 =?us-ascii?q?LE2VA64vZi15tYOhe4jy0vDppWKCPUfnYsUGBop6impUq9En4BM3VMjUueh+?=
 =?us-ascii?q?7Fro+QPt1QzINUHDSk8c/9BKo5dbLFuqR04Jy7/Q2rR8yrdG0y8CAzkegvy2?=
 =?us-ascii?q?7WG0enweBicmhagAF5awt54hGGauqBQg957YBuH4E1VBDCu+RP2wPnGFpoYI?=
 =?us-ascii?q?+h2oTiQ71nvz9RO1HEI3msQe7+8QZnrvW3Is6q1PRy21/wW2YWCjPAY9eViP?=
 =?us-ascii?q?017vOqGqsYBK5p1Ot8CgrJIXj0n1fMQ1VBQRRU0w+hhekAcqoiBoRSWtUTht?=
 =?us-ascii?q?iMzaqXLp5cysyrNsVjuXdvfe4WvFqzs8rfcOOWtlciHi4CCOu6KfefqJLtFQ?=
 =?us-ascii?q?tw8PxwJIa4jjId39iRMX26dBQk8HqGvT4iHsUjpmjom3N6xKD+Ci4fbAXPzt?=
 =?us-ascii?q?bIEovB5c/IOwroF/rn5ubkkrsUgnFDdyId9gI8fyDiy+JWa9113RStwoc0z2?=
 =?us-ascii?q?L3fn1bVC/zMRCJvPZSY4vCyadbNqx2bzGl2TJhlZvSBkZerWp82l1l3+UXRq?=
 =?us-ascii?q?VAE7Tv8Y9F7gaCr08+4qjR3pVZ9xxSCgt1cNmQ2mUaABRva8dvlM/LjopPXJ?=
 =?us-ascii?q?xZI1fO/C4F2JjwHw5M2ZWx2/TJTpIsqEGun9LEUQti/Ud8o00zE/0+qPOdEu?=
 =?us-ascii?q?UrwPrMD8lLSLZjYYrlPe4NFLAFoKJrVzf0L89omFm8JHJ2EFg80dZBZKZ+iU?=
 =?us-ascii?q?d4wBfJ+2J+/qiOycToO2PBf8JJxcbJH2t8RtMTqQMmFIdOB2r0r4AWFaj9ou?=
 =?us-ascii?q?XdK6N50EzFRnMiDBT3wULImUjPNw5fkeoEiTCTXtbnis+qT9oQ54QNsN22Nh?=
 =?us-ascii?q?4hLWo94UG1W6rEV8Q8zsW8pNiRhiKb4qJPuxkqmt0FSpzuU8VzyqcZDhV7nD?=
 =?us-ascii?q?2nZVhbHfVn6QlOxoDbmLdFMRYDvOCaAmKQaasB34RvxUUQjt4QLQ8NKlucM6?=
 =?us-ascii?q?NEV0VtYcAORYhW6MCHboLop+0QS2SfYv+XU/C6EqguqYAvjfF12tRosz8DTE?=
 =?us-ascii?q?9giDU12Gk6nzzYose9Zr/gNMW3Mog56eN093EhYM+9ekDZSDF3Zb1CVXW7hi?=
 =?us-ascii?q?aLoXgjyrQxNV3LRahWn3Yl06J7w/dKolBK3GuxObD+rWJwokeAu3K6h6GT6C?=
 =?us-ascii?q?gmG6BtIaJzae2oSv4pxFNsMzknKeX3K6xdAOqGRecKsgO3Md5cWBtdN9PeFX?=
 =?us-ascii?q?v4euvkOiKimVvVIRJsldZTkTOINUgotH6Vg4uTe31XYV0wsJwICZ1CtedWVC?=
 =?us-ascii?q?9rogWZ7jTE4IDLeLd8sYtODUkv+NOBZs2WTk64fOLIfblwFBVwECBD4geVk2?=
 =?us-ascii?q?3JUB1hIsOToQY/tLmcqKC0R5kJS9w2zRvBqCOYY9brX7V5BKpqsda2aWdDoV?=
 =?us-ascii?q?EgxE1Fsfx/0NnGXffn0GivWLFsYLNawp1W5VwwJh8Yt0je1Fx2zpV2tLftKB?=
 =?us-ascii?q?xo1yle+bPO005E3u2aAeM6CTRVePsRWCeNepzc+cekZW7nBunFONHPHAHSiZ?=
 =?us-ascii?q?XKlbUlWbi8h0JkDsUfpC//KB4qXutqSWGJBUPO3yDjmO1OF/vrgUZvdWfe0q?=
 =?us-ascii?q?KMOeVLJg3DdaqyEagjeVCALwP4ZvFdY9orhPh8q51SeiL3uj5rc8hV8b2pGe?=
 =?us-ascii?q?ouTEyTDkCW8nDqSKcpxuWgTu/qUv82ASxvzxAIyoixgwc2LseUWy/76FZTTf?=
 =?us-ascii?q?hibsI7PQZ563NYqN3JKO2sQFtyE/FBCszNOQbapHDKyybHsjwfbiYq9CLH9W?=
 =?us-ascii?q?L2KUeU5ohOdkzz+GFJ3gCHHSH92GwW3Hxp4z1prilNEyK85h8ZGamlLh0A8e?=
 =?us-ascii?q?5mRZVavSEkgO50LTUikSsaaJMRt5YT696llR+hDX1rAn55NuZ4HQxdsvaXX/?=
 =?us-ascii?q?BVUGav+012GAEIwh2gp0Zbk95sV3/plOUzyKmnMGMBKXZPdNTJ1TpQc6KnJT?=
 =?us-ascii?q?BMId8XqpFRjJte2JsGw8PszLZ0BroG6hE9j93nKqZddszS7UqIpw7U54MW0f?=
 =?us-ascii?q?tVfbkPm5IHrfZ8n+AqlzXDY8lXcaMRUV1gitU9fyy360Lf/QYFbjujACaiAX?=
 =?us-ascii?q?bTYqJypIIwOw09wmjYumDyH14HQuqNjIUEjEIg7udFZM4zWVDazRVjH1vb8/?=
 =?us-ascii?q?U/xRRmkUH4By3pSG6YpTM9wE09JwtZcuepLky11zGJPXGrqGNtjMcujsh/sH?=
 =?us-ascii?q?SHtSrAS8SOs9IUxqPaRvvLmVRZ3nRRpPvVGIj7N7nbsuTFh7JdBgEWqTPyfX?=
 =?us-ascii?q?8kMOGfazZMmfBLUifI4qfPJYIlqoqGcWebmjPwO7S5rvq1CCVomwbpwkASf3?=
 =?us-ascii?q?yBN6a9j7Er48pWUJLinyyEsNPxGSL4LfQ9zWmPVwl0U7miNc/jFg1ex7CIUP?=
 =?us-ascii?q?fh55umWJchbEfe5Dt3MOzkqv2zsE7tBBGrKizjELvQDim8tXzg9H54OS3ueG?=
 =?us-ascii?q?jiND2/5j5xQgvihQ8AqfG6mYcH+N0DxaYaPevtYf1+wSlIQVl4jPgRdM2aCs?=
 =?us-ascii?q?GfIOkPfQHjCNMmuo+Hrt30fuKcGaFI1M3vKnfsdSIDRxo8EvSTCN/JX/rjKO?=
 =?us-ascii?q?XT8G5x8tnNpgZBsayjiJ2MIKvtEu1prsoGMIMvNlKsTdYGXIjoHkySU6iP5y?=
 =?us-ascii?q?w=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.93,236,1654574400"; 
   d="scan'208";a="78062482"
Received: from mail-dm6nam11lp2169.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.169])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Aug 2022 07:58:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FQNsvPQWHDHDSzjaDGoik6HsswGKRezQ3V/GXn0HGL+ONtIoI9Fh5O245gqK+D4PdvyPmKfIF8L6KZ38Osr3hNEQjciIhj9OgCZzq6Vkh6OUg25LBEDxYlA0vmQss0eKVS/7LWi8SwrqpWhmLssW3LTTV5c/KPOpZiDxV4MYuzy+iv881fuObma6eZBmpggfjTp8yQt1Jjz3d6fetd+Ev3biHN18zrt/L+u4gJGxa6XBjfVOCxOKT/e6+p/fOQY6E+oWAdzKToAFjhYWV055rdNEFcBbtLQhkYl7PXoqh9ASIFLkDh5qoR6fDLc3Ew9GZ/PHuFBuocZXBa2GoyTgtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9z0Ds9VCX1OaAkzkyQCfgtjKdmfV9Fn8HENyPID2tNw=;
 b=LHGITFq++xuBmHNqUUsyE6oFqyxTpFl4GKYLk5ZJQr0r/7ZTCMGoo4/0g6jFnVD2W3nd4j0hMQEYCJJwFFkkotqP0ZdKI61hU+EXFJMCbaEt5191VnGcgvNDU2LNnuD0hz9p9mMPmGjbd7z5woMBUFTyx6NeRSKv0TGxK1ONrJ1ATRxJjCJxJkYcxhU2dNyk0r5mEhjJmagALFBBd+3uURaOMBVxEJGwO1xMAih4S+MqOfsIIyyGue6KAVp/qydu7HBZ7ms4MjInnlWFEeIa9t2riEPzBSZYcvmop9PEzcU7L2756Vez99IiECW7ZSeUZ6OWIvzUeNkOXq7H8dSc0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9z0Ds9VCX1OaAkzkyQCfgtjKdmfV9Fn8HENyPID2tNw=;
 b=D5POW/hI2fw+1qozXBUyBqcWqFrfXhnlS4umkUd62c+qAkp2nkLI3NWtpbQPtK5X2wlY6zrnj1w30IIqKNnE9xV5sS8ZEr2H5f1n7gA85T2tJjgHUHRHSmKxUkjpF/VTR9zvxnZUgsu4+cIfoYZ0zqDSLUc/iI83uMJYHYAyh+A=
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by DM4PR03MB6031.namprd03.prod.outlook.com (2603:10b6:5:392::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Sun, 14 Aug
 2022 11:58:18 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::b9c9:c866:817c:60dd]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::b9c9:c866:817c:60dd%4]) with mapi id 15.20.5504.027; Sun, 14 Aug 2022
 11:58:17 +0000
From:   Andrew Cooper <Andrew.Cooper3@citrix.com>
To:     Ashok Raj <ashok.raj@intel.com>, Andy Lutomirski <luto@kernel.org>
CC:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "luto@amacapital.net" <luto@amacapital.net>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH 5/5] x86/microcode: Handle NMI's during microcode update.
Thread-Topic: [PATCH 5/5] x86/microcode: Handle NMI's during microcode update.
Thread-Index: AQHYr3K6IzdrCDFoaU+Dyh1drlmm3q2ts3KAgACX7gA=
Date:   Sun, 14 Aug 2022 11:58:17 +0000
Message-ID: <328bf268-51b3-f9b2-1315-bac0e883d135@citrix.com>
References: <20220813223825.3164861-1-ashok.raj@intel.com>
 <20220813223825.3164861-6-ashok.raj@intel.com>
 <0d6afdb6-e546-4ef0-80c2-84827c11f2ce@www.fastmail.com>
 <Yvhj5YaLdJnF60uR@araj-dh-work>
In-Reply-To: <Yvhj5YaLdJnF60uR@araj-dh-work>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b0c9048a-0589-4a72-93be-08da7dec4672
x-ms-traffictypediagnostic: DM4PR03MB6031:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2IE24O+vLTKT1DMcAsKPYs+ruktviMSGiN0DHYFiyr4IcoD8QW1UYPdVeTplzELgm898lFL6smOj1CR/Z8NwDOCy3DS3ARyCkWbIDf3bcRNLF/qZoDhIkonNOEZttMwYPW1qGOaOWsaw7VkUkrL2Er0p4fN/CcJrvyBtXHSKm1+DPjz/pJhfdIPv7/J80CrvC399BDaBjlYeUb5g8fVLFHqjp7cdo9xx1Ws35kV2R/+64hcVkD0n3dcKmG5o7baEuoO3Y4xwv3WSKszgqDX2wfWUTRdHwiK3do/zKAMRx8L7Apu25nf2tEV+swmUYOEnMHcHBj801H5kuIRa9X7bp90UDSivwjWs/ZEEeIZrHOux8+oJidBJJY72x0JQgqlG5POEAvYdhlvPb7V+eboVC6DVYvUIeDuwfoTdSVoxdC6rzsrQYmzRp+TW+q+6ruYu3Qt4wrc98w29Y76aiB6gUE5BfVWBxmDCLyLGLD3BMEsIFHA+/DexoBy0yCXfW3U+tcsdtywDwhSevrkjqhTJJekPExV3CwPomMpbMDaeQ3BmmWxXysJpDf8jIqOooUVkOHiMA55IJFtNvmXNOschdeaBjX0O0NV/unza9G75Uyloa6JowpHiZxQHbII/utQ0Z0zWqLpkXXxgYzMPbnldATV6rof3qrshnQGC9G4H2qxugDDiSS8j/FJ2BcnnesSylHozLM5xrMFI8i6b58VG+Uixk8JRPJ/1KKbLHfyhoxw5vDnEIJHSC5J5e4MjPp4sIIfZSCr3vcNUyXDY7XR5T9QUqVZgoX2hRtcFaKIUYkk29w7VYhRo7MqeA7WOdaxqxN+CinPKD4Sp2u5k5XOegGyusZ+XM6flrgIyhsjqIgCpchH2r1pQ+X31ojryTQCZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(366004)(396003)(39850400004)(136003)(346002)(31696002)(36756003)(6486002)(53546011)(6506007)(478600001)(186003)(86362001)(38070700005)(41300700001)(26005)(2616005)(110136005)(83380400001)(71200400001)(6512007)(316002)(54906003)(66946007)(4326008)(91956017)(66476007)(66556008)(31686004)(76116006)(64756008)(66446008)(82960400001)(8936002)(122000001)(15650500001)(38100700002)(8676002)(2906002)(7416002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OXdUWUc5YmYvcXpOaWdtVnFpN0Q2K2lodXU2R20yb2pPQ25IUjVTSlVZc0lF?=
 =?utf-8?B?MElkOVFWcGlINjJEUUhPbmROdFlYcTEvYlBIcGhkcEFFdDFmUWg2cW9JWXMv?=
 =?utf-8?B?UWpwUElMOXZqem5YTG5iNEsxSTZhaEZuTzE3WlAvU3dCSzdCallQWDA1Tnd4?=
 =?utf-8?B?ZEdDeFF1b3NXVy83dDdEZ2VKSTNBNGVHdWNZdTArVVlka0F3cTB1M2N2TkdV?=
 =?utf-8?B?WFJQdDFoQWI5OTJSb2trYjd3a3o0ZHNlZ0hIR2hhQ05MOXZUd2ZLRHdsNmtZ?=
 =?utf-8?B?azlEQXhnMk5hdEkydDBJaU5xdkV3WXV5OFpWTzJiV0dUTWVOZ2FjTmNocEhk?=
 =?utf-8?B?ODhTdm9ubG4yZHJ3T3d3dithbUd4SHc4S0hEa2ZWR1JLR2RKak15aVM3TjRD?=
 =?utf-8?B?a2g5d2NQRHZwSVhCdjludHNuZXJpY1lWNjhMb3A4Z1NxNlFLRHNkL05PYU9C?=
 =?utf-8?B?WlNOakFMMUc1bEUrNDFsYmZSd2NxdHVmV1dhRHZlNXpLcTBOOFlGcHYzVTl2?=
 =?utf-8?B?aUtiT1JzZzZ1V2ZOSGJwMXY0NXg2b3Z6Nk9MNUVSalFic0ZXT2dxVnRvMGcz?=
 =?utf-8?B?VklWSkFhYjJkUzU3L2Z0WHlTR21NY1crZ2luanlZMGcwR1lMa3lJdlNJT0Q2?=
 =?utf-8?B?UG5sMGNTUU1VUUtjWG1ZU2pJY1dCajFnRjJ2MTRBbkpESm5LUHpoODhTUHRX?=
 =?utf-8?B?dks4bUI4eElMWnh2QnFOMGQyR3NsWHVGcjB3KzhlZ2N1VlNSL0pZb1dkQkhw?=
 =?utf-8?B?bHlITEs1bkJTMWVUaktEOEIwa3NvdlE5NEQ3dkY3WnVVNTcraStHWW5iekdO?=
 =?utf-8?B?VnVJdVJaWVhRVEgwK2Njc05xQkVqRkFaK2JMYi9XWFlJMEhkbXF0UDBxYlBO?=
 =?utf-8?B?UlpNSFBKeFFmMHYvRFZBTWZnT085c2J6N3U0VitXODNvUHVFRDVnNmU3L29I?=
 =?utf-8?B?WTFEOFZ6emtFUitVZm8rTUV5RURBcTNCb3RVTkt5THJESmVrT2FXR2hnYWND?=
 =?utf-8?B?aCtyd2NETHF4VFVVTVZrUlQ2TUFIUjZUYnVvSFRSUGpvakdtWVVmSzU4eHh0?=
 =?utf-8?B?UWVCRFZjb3Zjb2k0dzkrQUZnOWxpRGFFUDg2K3dkeWkxR0JZYlpCa3VKNm9X?=
 =?utf-8?B?U2k5ZkNsOU9mR1ZRWlFvVGdSWlpJWDg5Zi9rT3FSL3VqNm16MW10MnVPNnRW?=
 =?utf-8?B?VXVoL0F2dlNHOUVMM3NpamNoQkZXSXBQbUlHMVdobmIzN1ZJelRvdEdtTzF1?=
 =?utf-8?B?ZFJKS0E3YXVOZVBWNkdIdDZQVFpXZkM5TzUxSE1qTlo5UjRCOTlSNkMwREFQ?=
 =?utf-8?B?N1dYc2tmY0NxQVdQZzIwdVB2cDdzZ0cxMTNBY0NQazBnLzd4SjAvRGRlZTQz?=
 =?utf-8?B?Mk0xdDdSaU9RREJQQTNsczQzckR5MWFNdDJQK1lzMFVPbVVRMFZKWWRlZ0N1?=
 =?utf-8?B?TGNkc1lPVGsxMDdHcUJ5dWVKdHRJTi9SV0Z1Q1I0RGhPQWNHWnFqcy9VeDVP?=
 =?utf-8?B?U3lsZGdmOERyUXpjYlc4ZGxyZ0ZNWm83Nnk3U0ZrVHl2K2VsRVNyZzFHYnd0?=
 =?utf-8?B?QXNQeW9lTXE5UXU4dlhiOHQ0SGNHcHF4MVFZL0VtZ3Bna2tod3RvNVU2cCty?=
 =?utf-8?B?aFZPUlJsQjF1WmtjVE45K2VHQ1NDdWYvK3pOazhSalZYMTlIaGE0Z3crSHhY?=
 =?utf-8?B?SFJCbEdyc1VBUE9ERnNndUNwUWVHc21QcnR4cG1pZkJ3Y0c5WENFM2JEdG1v?=
 =?utf-8?B?RHFBVGJlVUNIVTRrbDF6OWR1Z0dVN2ZSaGY1S3NVSWQ5d1JBWWJqWUZUNTRM?=
 =?utf-8?B?RlVBQUFvL0xYTWhpVnR5NlJFWTl5ZVlOLzVVSzc2eXJNWkxiMU9hRDBITjFt?=
 =?utf-8?B?a0xsVFpTNG5JQ0N2UHNsanFZeTN2NzZKbEg4UlU3bzZsWm1sM2FoalpPMENB?=
 =?utf-8?B?OGFKZnpnOGRlNHZDaGhRSGl1cmtNckJxWlJySUhnL1Qrbys4dWlmRU8xQnI0?=
 =?utf-8?B?OE5pd05vaUF3NjJMbVB1RDJubmJxQU9MMDdCOHk2SXpzSEp1cnB4TElQd09n?=
 =?utf-8?B?OG5DZHRtMEs0YXBuc3NacGtiOGt6UHplZnN4N2E3VytzR0hNM0lQcmFtaTF1?=
 =?utf-8?Q?gLlXZK0vT9QVBy6bMBo1djptY?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A5CD2B4BA3F4244B8C20EBB8E7270D5B@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?SzRMNERHczJxM3lkWkZFSlBoSXZRWXQ4MUtwNzZZbVBTOWZFOUZvNWNELytq?=
 =?utf-8?B?djVoQVFFT0JhTTR2ZENpYlNjSUg4bitXWG1YUU1uckQ3Z0txTFNFQ2lXQ0Vs?=
 =?utf-8?B?eUMxdVNGbTJXZTdlRXUxNm9KZ0RQUFJoOWNmYjdFcUZhb2M3dHFvQU1DRnFV?=
 =?utf-8?B?aDkrWTNBUkUzczkwK29CQjBJdktSZEV2SWhROTJ6a1NGeUh3NEo5a0tvcW0x?=
 =?utf-8?B?S3hPbk5heGRRR2FvOE5NcTBiV2ZMeTJBeG5ZMU40MEdMQW04bHZZaHErM2NY?=
 =?utf-8?B?emdnSlRxRzR0UDdWWDMrbTNBWnlmREZ5SHB1N2ZCNldOZzdrRllEQ2pvT21L?=
 =?utf-8?B?cS9Cemw1bjdQMWtiSHorK2hTUUtxNnE4aVByTTdHTUR6c3RnV0tqeGN3Vmcz?=
 =?utf-8?B?L29tcTB2UjVWbHFQZkdsVlVSb2d5RnpUdk9RTld0NEdrZGxzWUs2ZU9wamJm?=
 =?utf-8?B?RkVCTElVc0NIT0xtNHZZMEVsdEhtMHpBeTFkRFNScm5WQXRuUU9IMitJR3BR?=
 =?utf-8?B?dEJNYnNiRndvRCtFUUFLRU5BQ01sQXdrNVBKdkVHdzdCOEEvTnRzRTZuckFV?=
 =?utf-8?B?OHVmZ3dHbEk5TFVWWlhiV2VrZGFtT1VUd3BQTjZYS2d4TmxTL01EN09WWmsv?=
 =?utf-8?B?UUgrbmg4MUU3RStuQnJhWmp2REl3Z2V0bXduQTNBRWlLVkVudlgvNVNWRGsw?=
 =?utf-8?B?YnNzOGR1L2hjRi9BWUtxdC9UNzMwTG45WWc1Q1UyQW14SEJFZEkyaWtzcG1Z?=
 =?utf-8?B?ZnZCVU9qVHlGYWczUVpQcGNxOEtIeldrSFZwZGo1dXZGUU01MGRweDNTRkFJ?=
 =?utf-8?B?NmVzdXVqR1FjZWJtNkVtaWUrd2l0NFE3enRqV3g3NEc4TDlOTEo5V0RKVURp?=
 =?utf-8?B?ZTJPRGtLZzQ2bUI5cGxYVmxoTHJwOHcvNGhCZ3h5ZTd4U1lHWndhQUJBNG14?=
 =?utf-8?B?N0FjNkpLQlVwZVZsTlRYWEdXQktOZGYrclJ4UDBmWHUwYjRaNks0cHJOTlhL?=
 =?utf-8?B?K2JHaTB1L2NOKzBYQkJtcTVIVUQ0R1lFNXIzVHZ2RHFwWDVzeTdLbTE2NEJ4?=
 =?utf-8?B?NUtyRlZlc2hteVp5VzNScnNsaXo3U3ZZbzlaM1FIT29SSlo0emV1MzluT1lZ?=
 =?utf-8?B?SjZpVHU1YjZqWWYzeVNXcDRzTzRiSDN1VlhSZVA3emFWa0RJOXdKNGtWMDNr?=
 =?utf-8?B?QnV0RllVVjVKZnRlb2F1dW4xMXI4NFV6eit6WDRHYjFMbFd0ZkhHQ2djdHhB?=
 =?utf-8?B?SU00T1c0R0hEY1RmSWlwOThQZ2ViQmg3UXFFYkoxT05qUFc3S3JwSnA1cWdp?=
 =?utf-8?B?TDVZenRJQThIaHhhRzBtaGhqZm52dEx4TGRkcWZodVJOaUtoY0ZBekhZTzBV?=
 =?utf-8?B?YkdGN0pmQXo4ZmFxOUNHandXSEZJV2dLeitwSXFaY3B6c25rWlJXVVVDNlUw?=
 =?utf-8?B?SFUyT2M0L09ybnVRQW9temZwVnpoZUt0S2h4S2NUalRNNGRZMDNNL21td2Ux?=
 =?utf-8?B?YXZBSUlRVTFsdkl0eFRyZkdBRjhKYU9JVXBKSll6Kzc3anRrRTVFUldxeWNP?=
 =?utf-8?Q?ZH7me6FfyIbAdj0dSBLhEOiDA=3D?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0c9048a-0589-4a72-93be-08da7dec4672
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2022 11:58:17.3701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BhlnZGa5/+2xn1LztDMqGmVGwBO1ZsvoVde3/jqQv9k68HQdNvvybngrDbH+JClvsMPq66to+ZV5cFBfkJLdRwWga89PWgKznZR/Q74fcYs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6031
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTQvMDgvMjAyMiAwMzo1NCwgQXNob2sgUmFqIHdyb3RlOg0KPiBPbiBTYXQsIEF1ZyAxMywg
MjAyMiBhdCAwNToxMzoxM1BNIC0wNzAwLCBBbmR5IEx1dG9taXJza2kgd3JvdGU6DQo+Pg0KPj4g
T24gU2F0LCBBdWcgMTMsIDIwMjIsIGF0IDM6MzggUE0sIEFzaG9rIFJhaiB3cm90ZToNCj4+PiBN
aWNyb2NvZGUgdXBkYXRlcyBuZWVkIGEgZ3VhcmFudGVlIHRoYXQgdGhlIHRocmVhZCBzaWJsaW5n
IHRoYXQgaXMgd2FpdGluZw0KPj4+IGZvciB0aGUgdXBkYXRlIHRvIGZpbmlzaCBvbiB0aGUgcHJp
bWFyeSBjb3JlIHdpbGwgbm90IGV4ZWN1dGUgYW55DQo+Pj4gaW5zdHJ1Y3Rpb25zIHVudGlsIHRo
ZSB1cGRhdGUgaXMgY29tcGxldGUuIFRoaXMgaXMgcmVxdWlyZWQgdG8gZ3VhcmFudGVlDQo+Pj4g
YW55IE1TUiBvciBpbnN0cnVjdGlvbiB0aGF0J3MgYmVpbmcgcGF0Y2hlZCB3aWxsIGJlIGV4ZWN1
dGVkIGJlZm9yZSB0aGUNCj4+PiB1cGRhdGUgaXMgY29tcGxldGUuDQo+Pj4NCj4+PiBBZnRlciB0
aGUgc3RvcF9tYWNoaW5lKCkgcmVuZGV6dm91cywgYW4gTk1JIGhhbmRsZXIgaXMgcmVnaXN0ZXJl
ZC4gSWYgYW4NCj4+PiBOTUkgd2VyZSB0byBoYXBwZW4gd2hpbGUgdGhlIG1pY3JvY29kZSB1cGRh
dGUgaXMgbm90IGNvbXBsZXRlLCB0aGUNCj4+PiBzZWNvbmRhcnkgdGhyZWFkIHdpbGwgc3BpbiB1
bnRpbCB0aGUgdWNvZGUgdXBkYXRlIHN0YXRlIGlzIGNsZWFyZWQuDQo+Pj4NCj4+PiBDb3VwbGUg
b2YgY2hvaWNlcyBkaXNjdXNzZWQgYXJlOg0KPj4+DQo+Pj4gMS4gUmVuZGV6dm91cyBpbnNpZGUg
dGhlIE5NSSBoYW5kbGVyLCBhbmQgYWxzbyBwZXJmb3JtIHRoZSB1cGRhdGUgZnJvbQ0KPj4+ICAg
IHdpdGhpbiB0aGUgaGFuZGxlci4gVGhpcyBzZWVtZWQgdG9vIHJpc2t5IGFuZCBtaWdodCBjYXVz
ZSBpbnN0YWJpbGl0eQ0KPj4+ICAgIHdpdGggdGhlIHJhY2VzIHRoYXQgd2Ugd291bGQgbmVlZCB0
byBzb2x2ZS4gVGhpcyB3b3VsZCBiZSBhIGRpZmZpY3VsdA0KPj4+ICAgIGNob2ljZS4NCj4+IEkg
cHJlZmVyIGNob2ljZSAxLiAgQXMgSSB1bmRlcnN0YW5kIGl0LCBYZW4gaGFzIGRvbmUgdGhpcyBm
b3IgYSB3aGlsZSB0byBnb29kIGVmZmVjdC4NCj4+DQo+PiBJZiBJIHdlcmUgaW1wbGVtZW50aW5n
IHRoaXMsIEkgd291bGQgcmVuZGV6dm91cyB2aWEgc3RvcF9tYWNoaW5lIGFzIHVzdWFsLiAgVGhl
biBJIHdvdWxkIHNldCBhIGZsYWcgb3IgaW5zdGFsbCBhIGhhbmRsZXIgaW5kaWNhdGluZyB0aGF0
IHdlIGFyZSBkb2luZyBhIG1pY3JvY29kZSB1cGRhdGUsIHNlbmQgTk1JLXRvLXNlbGYsIGFuZCBy
ZW5kZXp2b3VzIGluIHRoZSBOTUkgaGFuZGxlciBhbmQgZG8gdGhlIHVwZGF0ZS4NCj4gV2VsbCwg
dGhhdCBpcyBleGFjdGx5IHdoYXQgSSBkaWQgZm9yIHRoZSBmaXJzdCBhdHRlbXB0LiBUaGUgY29k
ZSBsb29rZWQgc28NCj4gYmVhdXRpZnVsIGluIHRoZSBleWVzIG9mIHRoZSBjcmVhdG9yIDotKSBi
dXQgc29tZWhvdyBJIGNvdWxkbid0IGdldCBpdCB0bw0KPiBub3QgbG9jayB1cC4NCg0KU28gdGhl
IHdheSB3ZSBkbyB0aGlzIGluIFhlbiBpcyB0byByZW5kZXp2b3VzIGluIHN0b3AgbWFjaGluZSwg
dGhlbiBoYXZlDQpvbmx5IHRoZSBzaWJsaW5ncyBzZWxmLU5NSS7CoCBUaGUgcHJpbWFyeSB0aHJl
YWRzIGRvbid0IG5lZWQgdG8gYmUgaW4gTk1JDQpjb250ZXh0LCBiZWNhdXNlIHRoZSBXUk1TUiB0
byB0cmlnZ2VyIHRoZSB1cGRhdGUgKmlzKiBhdG9taWMgd2l0aCBOTUlzLg0KDQpIb3dldmVyLCB5
b3UgZG8gbmVlZCB0byBtYWtlIHN1cmUgdGhhdCB0aGUgTk1JIHdhaXQgbG9vcCBrbm93cyBub3Qg
dG8NCndhaXQgZm9yIHByaW1hcnkgdGhyZWFkcywgb3RoZXJ3aXNlIHlvdSBjYW4gZGVhZGxvY2sg
d2hlbiB0YWtpbmcgYW4gTk1JDQpvbiBhIHByaW1hcnkgdGhyZWFkIGJldHdlZW4gc2V0dGluZyB1
cCB0aGUgTk1JIGhhbmRsZXIgYW5kIGFjdHVhbGx5DQppc3N1aW5nIHRoZSB1cGRhdGUuDQoNCn5B
bmRyZXcNCg==
