Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFD35B1F52
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 15:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbiIHNfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 09:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbiIHNfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 09:35:37 -0400
Received: from esa6.hc3370-68.iphmx.com (esa6.hc3370-68.iphmx.com [216.71.155.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB37EA50DA
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 06:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1662644133;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mJjpNemdX6RWg/s5XdXc4aF3F7zenUTc1q8/DqqR0zI=;
  b=MznviJOOFoD8YHns956H4rJkswdSBj9vIJRTQ4cyZbbXQMo3fD0v8V3A
   ii7x8BSj6SSR0PGrYFGycNlWfMapUg0yfXZ4MGtZbOTDOSVJn8A53uDtG
   7nR0JqOwjL4bNcKXr6WOk+WQ2aUgkPsxd3kfsUfkwVtLjlO8iJeyCzV0p
   g=;
X-IronPort-RemoteIP: 104.47.57.176
X-IronPort-MID: 79755135
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:FoxhgapPRdorxxC/fA1x8nwio7FeBmJNZRIvgKrLsJaIsI4StFCzt
 garIBmHPfqLMzP8etp2bdm/9x8E65XQyoVjTlBv/C8yFi8boJuZCYyVIHmrMnLJJKUvbq7GA
 +byyDXkBJppJpMJjk71atANlVEliefSAOKU5NfsYkhZXRVjRDoqlSVtkus4hp8AqdWiCkaGt
 MiaT/f3YTdJ4BYpdDNPg06/gEk35q6q6WtI5gZWic1j5zcyqVFEVPrzGonpR5fIatE8NvK3Q
 e/F0Ia48gvxl/v6Ior4+lpTWhRiro/6ZWBiuFIPM0SRqkEqShgJ+rQ6LJIhhXJ/0F1lqTzTJ
 OJl7vRcQS9xVkHFdX90vxNwS0mSNoUekFPLzOTWXWV+ACQqflO1q8iCAn3aMqUF49x4KF52+
 8Y4BwIsMTPcof6/nK+kH7wEasQLdKEHPas5k1Q5lHT1KKhjRprOBaLX+dVfwTE8wNhUGurTb
 NYYbjwpawncZxpIOREcD5dWcOWA3yGjNWEH7g/K4/NovQA/zyQouFTpGPPTdsaHWoN+mUGAq
 3id12/4HgsbJJqUzj/tHneE2b6QwH6iA996+LuQ3fxHkniJylIvWTIuUWejgaWItnCwcocKQ
 6AT0m90xUQoz2SrQtTyWBC0rVaesxIcUsYWGOo/gCmVx7bZ+RSxB24KVDdNZdUq8sgsSlQCz
 FaHlt7tLT9iqruYTTSa7Lj8hSu7JyURBXIJemkPX2Mt/9bnsKk3jxTSUsxkFq+lyNH4cRn1w
 jaFqwAkirkThNJN3KK+lXjNmxqlopnESF5z6gi/dm6s8A4/ZIejfIGuwVza6+tQaoefUlSF+
 nMDnqC27PgHJYOciCuXBu4KGdmB96bbGD7Rm1hiG98m7TvF03qie51ApTJzPkFkNu4adjLzJ
 kzeowVc4NlUJnTCRaN+fY/3C80s1qXmPdXjSv3QKNFJZ/BMmBSv+ShvYQuc2j7rmU11yKUnY
 87EL4CrEGoQDrlhwHyuXeAB3LQ3xyc4g2TOWZT8yBfh2r2bDJKIdYo43JK1RrhRxMu5TM/9o
 4wPXydW432ziNHDXxQ=
IronPort-HdrOrdr: A9a23:dQrVca8QpvaUUqn6RM5uk+F7db1zdoMgy1knxilNoENuH/Bwxv
 rFoB1E73TJYW4qKQodcdDpAtjifZtFnaQFrLX5To3SJjUO31HYYL2KjLGSiQEIfheTygcz79
 YGT0ETMrzN5B1B/L7HCWqDYpkdKbu8gcaVbI7lph8DIz2CKZsQljuRYTzrcHGeMTM2YabRY6
 Dsg/avyQDBRV0nKuCAQlUVVenKoNPG0Lj8ZwQdOhIh4A6SyRu19b/TCXGjr1YjegIK5Y1n3X
 nOkgT/6Knmmeq80AXg22ja6IkTsMf9y+FEGNeHhqEuW3XRY0eTFcdcso+5zXUISdKUmRIXeR
 730lAd1vFImjHsl6eO0F3QMkfboW8TAjTZuCKlaDPY0LDErXQBeoR8bMtiA2XkAwBLhqAC7I
 tbm22erJZZFhXGgWD04MXJTQhjkg6urWMlivN7tQ0XbWIyUs4nkWUkxjIiLL4QWCbhrIw3Gu
 hnC8/RoP5QbFOBdnjc+m1i2salUHg/FgqPBhFqgL3f7xFG2HRii0cIzs0WmXkNsJo7Vplf/u
 zBdqBljqtHQMMaZb90QO0BXcy0AGrQRg+kChPbHX33UKUcf37doZ/+57s4oOmsZZwT1ZM33I
 /MVVtJ3FRCD34Gyff+qaGj3iq9MFlVBw6du/22z6IJyYHUVf7sLTCJTkwono+pv+gfa/erKc
 qOBA==
X-IronPort-AV: E=Sophos;i="5.93,300,1654574400"; 
   d="scan'208";a="79755135"
Received: from mail-dm6nam11lp2176.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.176])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Sep 2022 09:34:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TDf7U54JWEVCGpfxnn2iQDXtn47bNlNSmAzlab1kBZCssQybuaN+KeJDM+9E9doPMO6AGcjVU7eJwcUvyu+63csUlywceFU5RFyde/FGDPUt3VEcQVg9+2oDDnKtz01zs7LnBDrR5hqzjpFxJLK/n9VHTWjF/u+TMLMO1c0jstbqqKiCal9w6wnkY7GLNk2feg+p2sx+TtCqdzx7I8qYF8sWYvxt2Wo6gsIrNs4Re/MpIoT/Da7UPcgE+pYxIgnhFKECgWBRW0dAKWr294ISERQzPlTLvHlT2CoR/MzXxXTwPc/jF6eQPTsw31aYUssEQYg/BWKiRiQezqdnruwSLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mJjpNemdX6RWg/s5XdXc4aF3F7zenUTc1q8/DqqR0zI=;
 b=Hcwb6G4ZR0MkFZ002koCyqxBr45N6BfSXA5kZw73CdEYQ6ne/7qbvrtPA4wUS4Jjnv1Eu2vrf6hI3rP/k0fC4iotVWGK8jl+XtqJFsFV67VMF8XrUeIqtHOO/ZLiZ+YM2+L8uyUL7RiP2IxwcA7WrYXFr/DbAjYjmRi82+8NOoEw4Y712YTlSRfYSNFzrz5FXfXVc92phfdLDIAVzde1nsSR3zJpiM6hO6ATVM1yzKFPY+g3Nw55tbElgKBHTMyIZw4vWTs3rBZJzi/eCBUihJzAAPKj7KlykG1egFX8yCiYfTt+dzCN0bjkZ1N8aM39KhngBOCUTJqpdIe0ZIaVsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJjpNemdX6RWg/s5XdXc4aF3F7zenUTc1q8/DqqR0zI=;
 b=Eq8RH+6KCZbVC+g0KnNSNmz6cYjLaUzPoBP9WCSFKQaKK74zvihxfbphDLySOXPUbULfu5zwxUS0bqp3z5sJGN/pW7Jn1Q6sfLsiCkHmJs+sRBPapx6anRszRimtLNajX6ZpWR/aYCRRvdQ/LCa/+D85NvkGyiyUpCEHip/cmac=
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by MN2PR03MB5296.namprd03.prod.outlook.com (2603:10b6:208:1e8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.18; Thu, 8 Sep
 2022 13:34:26 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::b9c9:c866:817c:60dd]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::b9c9:c866:817c:60dd%4]) with mapi id 15.20.5588.018; Thu, 8 Sep 2022
 13:34:26 +0000
From:   Andrew Cooper <Andrew.Cooper3@citrix.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
CC:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH] x86/cpu: Avoid writing MSR_IA32_TSX_CTRL when writing it
 is not supported
Thread-Topic: [PATCH] x86/cpu: Avoid writing MSR_IA32_TSX_CTRL when writing it
 is not supported
Thread-Index: AQHYwkHHCzBeZjOWqECnhF3StKRjaa3TBEyAgACPOICAAfdlAA==
Date:   Thu, 8 Sep 2022 13:34:26 +0000
Message-ID: <f03cbd95-6f77-8092-36ef-b38018babf8e@citrix.com>
References: <20220906201743.436091-1-hdegoede@redhat.com>
 <YxexAl+i+6MGjf7K@hirez.programming.kicks-ass.net>
 <6ff23930-325b-4207-12fc-4d8fd5bea1ff@redhat.com>
 <Yxe09Bk7tNwa6OsO@hirez.programming.kicks-ass.net>
 <c076b593-815b-f7b2-4eab-9d2087580a71@citrix.com>
 <5e446bfb-a45d-5146-7617-48d1d4798fee@redhat.com>
In-Reply-To: <5e446bfb-a45d-5146-7617-48d1d4798fee@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 24cb7ad2-4820-4a9d-f65c-08da919ed96f
x-ms-traffictypediagnostic: MN2PR03MB5296:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8B2LMy6+FGD8yk7gWskJqFMzGDGjgqWgz6f+odmrersr7Uj8e3syFe8+fTmt+KyELt42F0m0j+lyQeuR4JR9C2KeLpYDJCmDL7SqPSPHuSRIRLfqUZvZnQcleuEENZAzaSYNblTSnrStGuwrY5ZorHIqNsiDLIlm36H2sboyux9usxXWf+kuI1/py19BkcKiZyG8RNdVHJDr/E9qmEWDv2rxgUIDRcUJovexVD0KCg0lScdtwXFYAEvQsQDpn9zKVV6Ae8pKSgjeFZNwfktGJCnx0kxGSxGEizs1Zlb8Dv5yMHK+daZetGXKWsUuuBUYgevVq08WFlguEkLyd1ZV4fCmhL5D+B8wvrAtPWjWw7CDmp4MrKCg2FdBKqTx6bQFuF7kRlITshzSsjPUzFFMcOHP7kclSNvjbgUBfwoBbUKdkfDeOpjC4bLhEzhlSEG4Hm2opqfX2SskDkj+LXXTJL9tBzAO3gwiMxP2VvC6hNmYTFVt+gtBK6cVj+5xeMnM9WliUz9mdUH7FL1ehj+JXQOYRA43FWBOIHnakyvoZd+m2loqpd/W/yk17dyu1hVDeWBGovmQit6+/da1eBgFm8YNIiMVohO0voiEYFybCFk6g/QvpxWFtd9Q2qI297sd+5x4zXP8DXVMNExMORSgNRPDdmTgQ7r5g/4CKyQ2AOOZoltQ5sqLs87PnXnUoJV2Lvj3TYNo9P+oJttH2C5zovPI3/8HcdPLrWUFCt4zT3D2/BKBUZ2dlmX0BNsXgZcWdlC6mWIp6lA3NLO2Dp6GH/axak8r34QoQ7oThfyJb2i+W5vxThmVSVAcOj2w7ndN5w+DL68mELX+vNo4eiH8Ow==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(136003)(396003)(376002)(366004)(86362001)(83380400001)(8676002)(6506007)(54906003)(110136005)(31696002)(316002)(38070700005)(478600001)(41300700001)(6486002)(186003)(2616005)(122000001)(4326008)(6512007)(26005)(53546011)(82960400001)(5660300002)(31686004)(7416002)(36756003)(2906002)(38100700002)(66476007)(66556008)(64756008)(66446008)(76116006)(91956017)(66946007)(71200400001)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eDkwbms3eWR3N0ppVklHMWxyOGNlNHZWNzAyV1VabjlDWUZFa1FLYmQ2K1Iw?=
 =?utf-8?B?TmxWaHBVYWdGOWRwaVlnbzQ0dlUxblZpM0lrT1dWN0JodWZLUEtrS3lPdDBo?=
 =?utf-8?B?ZzFVSEJSN3NCR3EyUktDRmpkOUovbkgxZ05hekhsRDhTT2tQREJETG5UdW9k?=
 =?utf-8?B?ZjEyZW9hNnNGbWk1bWpONmI4SGVhNVcwZDFvMTJ5eEJ5NmI5SHlRUEY4c3Mx?=
 =?utf-8?B?dGhreW5ack5qS2hqWVZQZ0dTUHpxb1NqcjFNaWlsZU5ERzAySjZjdFNsN0tj?=
 =?utf-8?B?NUZjZS92YW9uRHhwc1M5L2JMWHNvQlV4cnFvaGZmQk1xbi9LWXRJTWpveFQ2?=
 =?utf-8?B?WnM4YTNkY0Raa0RRNVBzVzN0QkFIUWNXM1c3MFU3eEcwTjM0UnJEeGRiblFs?=
 =?utf-8?B?VnVBbmU0NVl2RG52WDQvUjVhQUllT01aRFNUZXNXSlYrMWZXL1lCcENUQWxa?=
 =?utf-8?B?RGw4TjBWV1VNZ1dHMHA1WEZpQzYvd0NZYVFnQmUwaFVTc0FuWTAxa29nUk9r?=
 =?utf-8?B?THl1Vmgyb2QzYnIxclNUQ2dPV1p2ZmFGaFJXcEIxU2Vsc1VJcENlaEE1b09B?=
 =?utf-8?B?QkltUlRZeG8zK3Z1Q3k2VDZXNWlDdkhzR3VENHZqYXhhQkxOM2NFekNNblJX?=
 =?utf-8?B?QWRFMlVoeUtlZENIZGpQeVdrQlNZTnZsdms0QjZnbW9xeFRPLzdmNkZuN0tu?=
 =?utf-8?B?WDZJU2J4Yk04L3Z5d05CUUpod3I5cUtXTWJxU3JPcHBvQU9HYVZVSkhHbmV1?=
 =?utf-8?B?VDBuNzBhUnovMllNRU9kTW1TU0o4T1VIQi80cmR0OCtHUEIxMmczS0h1WGVL?=
 =?utf-8?B?NXdXMmxkK1RMNUpnNHdaY2xwNXBRNzBWNkZJZ3BGblFnbXNNVktlMklzblVw?=
 =?utf-8?B?b2pQRm4rcEUrS2RHaUJ4SE94dGRySEx2REtuVlp1YzRvd2NDNEd0M00zSzNv?=
 =?utf-8?B?MWY1YldXSXZPZ0ZJTzVwT0NRaEYrOTVDeUdJQy83VFhNOGpaQ0VWclVrd2xq?=
 =?utf-8?B?aGc2c3N4bjZZNHdDUlBUZTY2eDBMSTVXZDM5cllpbzhVTDNwNDYvK1krZHMx?=
 =?utf-8?B?cW16S0hwcnhvVnJlc2x5NU1OOHhQRFdRaDRjcmdMVW1uWDlSZzJ4SFpoUVRn?=
 =?utf-8?B?OGM2MEZ6L2F6RW9tOEpQR2pIMFlWK2hSTE42OGhzaUUzWmhtRFdrcmJzeS8v?=
 =?utf-8?B?dmdCbkpkcjArWjIxQ3FUME0vMElCcE01d05VcHIvbmEyWnlRUGE4YmFpWDN6?=
 =?utf-8?B?WExEODRTMkJseXJhbTVjMmV1TzVaMmxNNkhiMkNwcjRNc095V2lqTHk5RkRl?=
 =?utf-8?B?Z0hoSVpzVVg4ZS9xVFdyekhuOWJScUliOHpSZlpQcXJERTArR1BINSsrV2tj?=
 =?utf-8?B?YVY2QkZuTmNWM1hnTFVjaHpuQU9BakU0WmdqWmpFbnd3UEF6RGtzK0I2ZGY4?=
 =?utf-8?B?NXp3RzhsQVZvTytkVHlDRmQza1ZBZXBQZzc0bmFYOVcyS1kzazRkeGx3cnc1?=
 =?utf-8?B?QXRSaXI5UEUvblY3MFQzbEFwOEhEM3RoSU1kWWF4YW4wTWFwMFc2dkEwODdB?=
 =?utf-8?B?NlN1VFRZUis2MXVUVjZLakUvSHEyQUxTZHppTXJZYWtqdiswaXREc1JZcHo4?=
 =?utf-8?B?dEt4bW04enNhKzcyZXZGeVg0VHQ3Y0xLZ3hURDQ2OFpHQjNvL1Zya3hHS05q?=
 =?utf-8?B?MEg4K242QTBIdE84eWJlVmZGeFpDVEZpTWFyZVNJazM5eDY0ZlQ4SDg2dVVT?=
 =?utf-8?B?bHZHTTR0ZDBmTzZMZUgxQWFoMVNZUjZRQWFhMFRkNDlSTkxXMTVwTVlRRVNh?=
 =?utf-8?B?NzdJVHU4NlE3cGtDVmNGeEIyWlBEWEgvNjlEcEdBM25PZ1lib3p4VU9JaWwr?=
 =?utf-8?B?M2JKWmRrOTVwWXVVUmtKcjc4OFhMTXI2MXFPSlZJVHJkV2Y5aFFJemR6N00y?=
 =?utf-8?B?MXdMaVkyVEhPZEF5cVV3WXBoek5CWEZhaVVOMWcxZUJjMXN3SnovVmk3aUNo?=
 =?utf-8?B?aWJEMFFUM1cvTmwxRHpPdnZkNlB6UVJXbmdVQmhQa0IxdCtyUnRhcXlNWmlv?=
 =?utf-8?B?cDZSVHE5Ynl2bWpub0ZyQkNFb0VaeVdCRHVSTjh3RHNDQkpkYWdqRHYxRDZM?=
 =?utf-8?Q?RL/+BcHW1Fu0OvAV55d0EKvJC?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2338E134A62D2F458DA9FC8F0E36C519@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24cb7ad2-4820-4a9d-f65c-08da919ed96f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 13:34:26.4575
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: luGO58ZbOtjXrRnM5qtp+RuIyH/ZLNGo86G3RDrypw4gArz8uslH2Luka6LtNDlgxfJ9Ov2SVi2rxz+P9ap+wVmwODTrCtvEz6qkzqrkAZU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5296
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDcvMDkvMjAyMiAwODozMiwgSGFucyBkZSBHb2VkZSB3cm90ZToNCj4gSGksDQo+DQo+IE9u
IDkvNy8yMiAwMTowMCwgQW5kcmV3IENvb3BlciB3cm90ZToNCj4+IE9uIDA2LzA5LzIwMjIgMjI6
MDAsIFBldGVyIFppamxzdHJhIHdyb3RlOg0KPj4+IE9uIFR1ZSwgU2VwIDA2LCAyMDIyIGF0IDEw
OjU2OjQ3UE0gKzAyMDAsIEhhbnMgZGUgR29lZGUgd3JvdGU6DQo+Pj4+IEhpLA0KPj4+Pg0KPj4+
PiBPbiA5LzYvMjIgMjI6NDMsIFBldGVyIFppamxzdHJhIHdyb3RlOg0KPj4+Pj4gT24gVHVlLCBT
ZXAgMDYsIDIwMjIgYXQgMTA6MTc6NDNQTSArMDIwMCwgSGFucyBkZSBHb2VkZSB3cm90ZToNCj4+
Pj4+PiBPbiBhbiBJbnRlbCBBdG9tIE4yNjAwIChhbmQgcHJlc3VtYWJsZSBvdGhlciBDZWRhciBU
cmFpbCBtb2RlbHMpDQo+Pj4+Pj4gTVNSX0lBMzJfVFNYX0NUUkwgY2FuIGJlIHJlYWQsIGNhdXNp
bmcgc2F2ZWRfbXNyLnZhbGlkIHRvIGJlIHNldCBmb3IgaXQNCj4+Pj4+PiBieSBtc3JfYnVpbGRf
Y29udGV4dCgpLg0KPj4+Pj4+DQo+Pj4+Pj4gVGhpcyBjYXVzZXMgcmVzdG9yZV9wcm9jZXNzb3Jf
c3RhdGUoKSB0byB0cnkgYW5kIHJlc3RvcmUgaXQsIGJ1dCB3cml0aW5nDQo+Pj4+Pj4gdGhpcyBN
U1IgaXMgbm90IGFsbG93ZWQgb24gdGhlIEludGVsIEF0b20gTjI2MDAgbGVhZGluZyB0bzoNCj4+
Pj4+IEZXSVcsIHZpcnQgdGVuZHMgdG8gZG8gdGhpcyBzYW1lIHRoaW5nIGEgbG90LiBUaGV5J2xs
IGFsbG93IHJlYWRpbmcNCj4+Pj4+IHJhbmRvbSBNU1JzIGFuZCBvbmx5IGZhaWwgb24gd3JpdGUu
DQo+Pj4+IFJpZ2h0LiBTbyBJIGd1ZXNzIEkgc2hvdWxkIHNlbmQgYSB2MiB3aXRoIGFuIHVwZGF0
ZWQgY29tbWl0DQo+Pj4+IG1lc3NhZ2UgbWVudGlvbmluZyB0aGlzID8NCj4+PiBOYWgsIGp1c3Qg
c2F5aW5nIHRoaXMgaXMgYSBzb21ld2hhdCBjb21tb24gcGF0dGVybiB3aXRoIE1TUnMuDQo+Pj4N
Cj4+PiBUaGUgYmVzdCBvbmVzIGFyZSB0aGUgb25lIHdoZXJlIHdyaXRpbmcgdGhlIHZhbHVlIHJl
YWQgaXMgaW52YWxpZCA6LyBvcg0KPj4+IHRob3NlIHdobyBhbHNvIHNpbGVudGx5IGVhdCBhIDAg
d3JpdGUganVzdCBmb3IgZ2lnZ2xlcy4gTHVja2lseSB0aGF0DQo+Pj4gZG9lc24ndCBoYXBwZW4g
b2Z0ZW4uDQo+PiBTZXZlcmFsIGNvbW1lbnRzLsKgIEZpcnN0IG9mIGFsbCwgTVNSX1RTWF9DVFJM
IGlzIGEgZnVsbHkgcmVhZC93cml0ZQ0KPj4gTVNSLsKgIElmIHZpcnQgaXMgZG9pbmcgdGhpcyB3
cm9uZywgZml4IHRoZSBoeXBlcnZpc29yLsKgIEJ1dCB0aGlzIGRvZXNuJ3QNCj4+IGxvb2sgdmly
dCByZWxhdGVkPw0KPj4NCj4+IE1vcmUgaW1wb3J0YW50bHksIE1TUl9UU1hfQ1RSTCBkb2VzIG5v
dCBwbGF1c2libHkgZXhpc3Qgb24gYW4gQXRvbQ0KPj4gTjI2MDAsIGFzIGl0IGlzIG1vcmUgdGhh
biBhIGRlY2FkZSBvbGQuDQo+Pg0KPj4gTVNSX1RTWF9DVFJMIHdhcyByZXRyb2ZpdHRlZCBpbiBt
aWNyb2NvZGUgdG8gdGhlIE1EU19OTywgVEFBLXZ1bG5lcmFibGUNCj4+IENQVXMgd2hpY2ggaXMg
YSB2ZXJ5IG5hcnJvdyByYW5nZSBmcm9tIGFib3V0IDEgcXVhcnRlciBvZiAyMDE5IHdoaWNoDQo+
PiBpbmNsdWRlcyBDYXNjYWRlIExha2UsIGFuZCB0aGVuIGluY2x1ZGVkIGFyY2hpdGVjdHVyYWxs
eSBvbiBzdWJzZXF1ZW50DQo+PiBwYXJ0cyB3aGljaCBzdXBwb3J0IFRTWC4NCj4+DQo+PiBwbV9z
YXZlX3NwZWNfbXNyKCkgaXMgdG90YWxseSBicm9rZW4uwqAgSXQncyBwb2tpbmcgTVNScyBibGlu
ZGx5IHdpdGhvdXQNCj4+IGNoZWNraW5nIHRoZSBlbnVtZXJhdGlvbiBvZiB0aGUgY2FwYWJpbGl0
eSBmaXJzdC4NCj4gTm90ZSBJIGRpZCB0byBhIGRpZmZlcmVudCB2ZXJzaW9uIG9mIHRoaXMgcGF0
Y2ggYmVmb3JlIHRoaXMgd2hpY2ggZGlkDQo+IGFkZCBhIGNhcGFiaWxpdHkgY2hlY2ssIGJ1dCBJ
IG9ubHkgc2VuZCB0aGF0IHRvIHZhcmlvdXMgeDg2LWZvbGtzICsNCj4geDg2QGtlcm5lbC5vcmcg
d2hpY2ggYXMgUGV0ZXIgcG9pbnRlZCBvdXQgaXMgYW4gYWxpYXMgbm90IGEgbGlzdCwNCj4gc28g
eW91IHdpbGwgbm90IGhhdmUgc2VlbiB0aGF0IGVhcmxpZXIgdmVyc2lvbi4NCj4NCj4gSSBoYXZl
IGF0dGFjaGVkIHRoZSBlYXJsaWVyIHZlcnNpb24gdG8gdGhpcyBlbWFpbC4NCg0KSW4gYW5zd2Vy
IHRvIHlvdXIgcXVlc3Rpb24gaW4gdGhlIHBhdGNoLCBubyB0aGUgb3JkZXIgZG9lc24ndCBtYXR0
ZXIsDQpkZXNwaXRlIHRoZSBvdmVybGFwcGluZyBpbnRlcmFjdGlvbnMgYmV0d2VlbiBUU1hfQ1RS
TCBhbmQgTUNVX09QVF9DVFJMLg0KDQp+QW5kcmV3DQo=
