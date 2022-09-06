Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4F65AF82B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 01:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbiIFXAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 19:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiIFXAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 19:00:17 -0400
Received: from esa6.hc3370-68.iphmx.com (esa6.hc3370-68.iphmx.com [216.71.155.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3323E6CD21
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 16:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1662505212;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=r5GEIp9GOi8KaTHVSJyUN+iBQjGYAjMsn6VgY48TNvA=;
  b=Ayw5oBBYKlg1hWpTMZQeNFDCg3uej2bxPF2BrgLI5any8h9MnN1308Sb
   X2h/VqfmoxSsubsC6uGkYUVMi300pdd/t9tEe8Om7UWut8D1RFs3vavUu
   x8mFlt03SfBNjOrVInsKQBdIMTyWVPZ3woLmLZ9UjzzYNJC2H5MXotpNv
   o=;
X-IronPort-RemoteIP: 104.47.55.172
X-IronPort-MID: 79597746
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:oiDR5KwXP2INfHhXnph6t+d8xirEfRIJ4+MujC+fZmUNrF6WrkUHz
 jRLWGrXafjYajH1fIglYYm+/U9Qu5fSz95qHVNp/yAxQypGp/SeCIXCJC8cHc8zwu4v7q5Dx
 59DAjUVBJlsFhcwnj/0bv676yEUOZigHtLUEPTDNj16WThqQSIgjQMLs+Mii8tjjMPR7zml4
 LsemOWCfg7+s9JIGjhMsfjb+Usx5K6aVA4w5TTSW9ga5DcyqFFNZH4vDfnZB2f1RIBSAtm7S
 47rpF1u1jqEl/uFIorNfofTKiXmcJaLVeS9oiM+t5yZqgpDvkQPPpMTb5LwX6v1ZwKhxLidw
 P0V3XC5pJxA0qfkwIzxWDEAe81y0DEvFBYq7hFTvOTKp3AqfUcAzN1yC1hsP9NI2dpuAD9P1
 bslJDwkQg660rfeLLKTEoGAh+wFBeyyZsY1nCElyjvUS/E7XZrEXqPGo8dC2ys9jdxPGvCYY
 NcFbT1ob1LLZBgn1lU/Ucpi2rv3wCSiNWQH8jp5poJui4TX5CV33KLgL5z+fduSSN8Otk2Zu
 njH7yLyBRRy2Nm3lmvYoy3z2rGncSXTXbw8SuKD1tJQ0AeD4zI9WAIXDX+Xrqzs4qK5c5cFQ
 6AOwQI2oLQ/7l6DT9/zRRS0rXeI+BkGVLJ4E+E35waAxqf8+QuVBmEYCDVGbbQOrsY4TDEu/
 lyEhdXkAXpoqrL9YWqU6LqQhS65Jm4ePwcqeSAAXSMB4t/+vJs0iBPfCNpueIawj9v6Hhnqz
 jyKpTR4jLIW5eYBz42y+VHKhWLqqpWhZgI8+AiRXmuj9Q5/TIqkYZG4r1nd8ftEao2eSzGpv
 GANs9qP8OcUS5qKkUSlULVTNLKk/fCINHvbm1EHN50g8Sm9vn2uZ4Zd5BlgK0pzdMUJYznkZ
 AnUoww5zJNaInbsbaZxeI+3I8Us0aXkU9/iU5jpgsFmZ5FwcEqN+nFobEvJhWT1yhFzy+c4J
 IuRdtuqATACE6N7wTGqRuAbl7g22iQ5wmCVTpf+p/i67YejiLeuYe9tGDOzgioRtstofC29H
 w5jCva3
IronPort-HdrOrdr: A9a23:98II1K8wMKaFTMv9Qwduk+F7db1zdoMgy1knxilNoENuH/Bwxv
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
X-IronPort-AV: E=Sophos;i="5.93,294,1654574400"; 
   d="scan'208";a="79597746"
Received: from mail-bn8nam12lp2172.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.172])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Sep 2022 19:00:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CeUg5sP5mFZwlKcsWIsyPlgmYlsCA2y8cKM1LQTJY6ZBC4fMgvidrEyl4z/RedLHucOS9e+fac7yKzq4V9/rExk1NJkg6kDX9rivGJJqgESB7kSvh3xtCwC13eG0E+yesS0yl+kgnbEzXYgki7DLxVqJw3juvJGl9yoNlj9KbRHqSjNfmi9rC+XkrmVxyabauzu4csXfrRyiIdrRqV3qF8NqKoua8/FA8BY8KRqallKVzqRS86015fWxHfQOgf87LiSP+z0UFUtYsnH2GD+O2Xo9zngKLJ7sw38KxLhg7v1zDuL/Urktbtg4HDqpVMqIfUb9vsURrI7OtewbfKD/4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r5GEIp9GOi8KaTHVSJyUN+iBQjGYAjMsn6VgY48TNvA=;
 b=DQJWCiKE9u1oOMHRBsUXstlmbhXKqArkJvFqkB5dM2A++SaP4w/n9g2rObi+5pyjzHA8Hr6gpttU2+tXvDXY/gVDSIP+bwPQbNm+p1PSk83/hNj0POT8MEV8y2b8GfMhClJERp1cKEfAdCtDX1hafLv1kgl61XlHsd1lEFZ+AwhHy8esIg0BwaAXFoPOd5kuk0arKD2F1oyrh7T0feZv5PbXObHPYNjT72qvMF+03+VkSXyXfnwASY4+8jcayjWOFiquKG/U2jfBTcn3vNmg4HIhnFRKW8CNhUpRJ22F0kpC6Cltit2GUxi1P94sNVSYNSSQPYE1sepJVu35EstuaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r5GEIp9GOi8KaTHVSJyUN+iBQjGYAjMsn6VgY48TNvA=;
 b=Vb02+tLGOq44uzJctQ8t9XKyldHZ2tpCOiv51iR9OfHdgv1kAOINUNoAESg1WZwSAXA1nuduIQWRqnidcB9JHybzkR0jnBF7ST0Pt61s+800GqS8NnK0G5WvH7ag+4wfhLFHN1BorHmYsCBHjSNAB1DS7IXPixIIGhS1t9fB3co=
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by DM4PR03MB6192.namprd03.prod.outlook.com (2603:10b6:5:39c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 6 Sep
 2022 23:00:08 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::b9c9:c866:817c:60dd]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::b9c9:c866:817c:60dd%4]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 23:00:08 +0000
From:   Andrew Cooper <Andrew.Cooper3@citrix.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Hans de Goede <hdegoede@redhat.com>
CC:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>
Subject: Re: [PATCH] x86/cpu: Avoid writing MSR_IA32_TSX_CTRL when writing it
 is not supported
Thread-Topic: [PATCH] x86/cpu: Avoid writing MSR_IA32_TSX_CTRL when writing it
 is not supported
Thread-Index: AQHYwkHHCzBeZjOWqECnhF3StKRjaa3TBEyA
Date:   Tue, 6 Sep 2022 23:00:08 +0000
Message-ID: <c076b593-815b-f7b2-4eab-9d2087580a71@citrix.com>
References: <20220906201743.436091-1-hdegoede@redhat.com>
 <YxexAl+i+6MGjf7K@hirez.programming.kicks-ass.net>
 <6ff23930-325b-4207-12fc-4d8fd5bea1ff@redhat.com>
 <Yxe09Bk7tNwa6OsO@hirez.programming.kicks-ass.net>
In-Reply-To: <Yxe09Bk7tNwa6OsO@hirez.programming.kicks-ass.net>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8d344ba7-94cb-4a89-0bce-08da905b8b55
x-ms-traffictypediagnostic: DM4PR03MB6192:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0wrpDNdybwbA6fSskIaYTDxoQgiiwRUKsLw+HdTvAF7qV6Aa3h9bN5HUuKvfSP5fmIYo6BnrPvgTfD+QNSLhONPY9mkYKQG3yzd1LG9gWZgz+Zb8IXMQGuIRutxGNxVntoyWY6EOzJQbNtVwacE7JQH4A4cbQMHI04JGxs7B54aFB55X/cCscILZy7K9b+/w1v/JYaYOBCNmdgvEQbeHvzk+4oZooqza/94dWgpoRSAEQ0UCghUONJgWE+KFXEZEn8iXqtXTCAOImOjzuotBDnGIPemXNSjTs85A4Y6e9YlMm3YOe1XtFX0oeLRmolQ7LP47lksuZToBOIBUMnNd6pRYDPt4bw9rYSFOuNifkXPJWrrfcy7eGYUHC3VccFYLe89WDp8EKBvD5z/MqWsjYx2eOA5lRjjFSROFD49WPLWmAYtg+JHRdFUq69Lu+Z62Dp4Dx/LKP+KdVbMijUayfpAzerXYT+qGCGb18soW+YOXdKmVscZdyyVsYusDW8rVngUdg15ZA/s7fEu2fUOhXhhJrRls/6KhoPpX6isKbKGoYERHAsmwCmBXOzWWw53QB9PfoOgfIb4oLEUtB3dpeuj1i7JoNXp+5+c/1G+Vrn+tOr2KsA3T3OF+8Mix0If+YJFxMeA0FNkzIBWwCJPVfQDVh++qHUt11FANG34SfOaN8GzdwRkucpJGEdXBhUhPhAgK15K47MfPGBOOYgM7ZfbSQPCQJyOQf5VVte2V3H1GuO5Nhq6eos/58e8h7rtyKqlRVVrBrOXTJiBCX89lLF0tfPQiPMXlYA24WFZ76U5tGIl/EjEN9NoQoK08NXXzixDab1ZqEl/B5XEBV3PxDQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(346002)(366004)(39860400002)(376002)(36756003)(2616005)(71200400001)(6506007)(186003)(31686004)(5660300002)(31696002)(7416002)(8936002)(53546011)(86362001)(478600001)(41300700001)(6512007)(6486002)(26005)(107886003)(82960400001)(38070700005)(122000001)(316002)(83380400001)(54906003)(64756008)(8676002)(2906002)(66476007)(110136005)(66446008)(4326008)(66556008)(66946007)(91956017)(76116006)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L0tLTk5CYWw0cWtoZzdGL05Ub1c3SkxYQUs4VHF0cnlodlNNYU9IRjd1Rnpl?=
 =?utf-8?B?OWJYdDR5dDhSUU5kckF0eERpSWhrN1VEMHlCc2c3ODBKRUl3VkZDOE84c0Yw?=
 =?utf-8?B?a2R0SnFhbUZjeS9GMXFKRnQrSjdPVFJlWmRHNXYrSVBuYmdtZmtZNkk5S1NU?=
 =?utf-8?B?MjdacTlrRzdWWFRxdjRQWmgraktUeXZKUU9zWlYySFNHWk0zcXlqV0hJMEpG?=
 =?utf-8?B?YU5kY1VVQ2pZNU51YUlhL2JET3B6MlIwY3B4K0t0OGh1Z2IrazlUL2VweWd5?=
 =?utf-8?B?VllIVVM2VGVkblo3ZS93UjhmRlBaYmpycnpKUExBNjBqVC9TV05PWWhmQVFx?=
 =?utf-8?B?YXFrZ21xaUJzOVIxOEpUei9KSXdpb1o2bVdZOTE1QXQwdHVlbzhsYllSMHhl?=
 =?utf-8?B?cW5UdjArZU5hQ2d4b08vcWxqSVNSZE9FNWh2Tld5aWRsaS9RQ3lrdzRnUW1V?=
 =?utf-8?B?cHRNY2ZITTF3TjJPRHlkOE1qWkxSMEdwNzMrQTZ1akllQWdja2hIZHZPUWM5?=
 =?utf-8?B?bDN1aGFoMEdJSEhMWUxwR21POFlsK1VaeFRLWGc2cisxZnNndThZWEptYVQ4?=
 =?utf-8?B?S2daclRqdDNoZlBsU2lZTTBOdzlpbTVRdWdNUzZ2K3ZuRUVIRlpFMFpWZGUy?=
 =?utf-8?B?b2dBWVNzNENmd016aXRjQWpBYmNmSndFQXowRmZsM3YrZjhzbUlkK2RTWEt4?=
 =?utf-8?B?R1hkN1kzclF6VTY0VUREd2tld1VIcmF3SkdCdWxsVVNDK0xPcklQU3dXaWx2?=
 =?utf-8?B?RFZiTjE5dXI4R2IwYk13dittR1pFb3NzcmRsQk1qT1Rkdk5KSEdvTG56ZDFG?=
 =?utf-8?B?QW5MZTFnTWV3bk1hZU1mdkk1cmVWRjEwRzdldE1mbXlBWHB3VHkxYUk5d1BU?=
 =?utf-8?B?eHZFcEQ1YS9QdXQzMjc1QmRjaGVINU5XaUJSZzNiVEhnWVlnTTJxZmZ4NDlN?=
 =?utf-8?B?a2R1bFZPdFZTek5Oc0ppUnU2MCtQMXJBNDA0OStVRVlBV2pJbTAxTlVMQUg4?=
 =?utf-8?B?Q1pIblhvaTA3UCtQZVhubVprQ1NLd002U1Q0UlFCTHJScVB6bGxId1RnMUZE?=
 =?utf-8?B?ZEpqSk5LV1lLdW5tYjh0MzM2dGRMd1VDbWxoZ0NDMnc1c21zUmdCQVRDd0hH?=
 =?utf-8?B?U01lWmp3d2pOck9QS3RWVU5vUHdPZGJ0UDRZWjJBUTFWNVh5OTBaZmltNjMv?=
 =?utf-8?B?V2F4Z2NEZ0J3b1hOcllLeU1BQWNCbGI0RHlIWFNXMnZCc2hrQzR2VFNuWis3?=
 =?utf-8?B?eW05R3NXeEZPejRhL0NvQzBqZFp6RjdxVmk5cjlOZ3EyNUduRDMvWVlWVjVV?=
 =?utf-8?B?THNpR0t6aVRNTGhvaUFIRU9XNmYzOTlUQUwxTVRoVzUwcXRIR3pqbGxaMjE0?=
 =?utf-8?B?Q2ZOUGowVVRtMmRvYWRmUTRBTVFKUEI4MG0vNExmRU9PMng1VGhIbyswUnpm?=
 =?utf-8?B?blhOcjB2QVhZWVd3SnVOS3VLOTRmL0pFeHV1T3hjWStFZjVFZVZNR2krc0xH?=
 =?utf-8?B?L3NTMlY1NDZIMUUybWdVU2FEUGQ0Uk14ZGZyN3lQaFlhWXQyU0J6Y3NqUnJL?=
 =?utf-8?B?YWJjMHN5d1dtaU84TEZ3VENrNy9iM1BKWGJmbm5yMjBUcHl5UmNpMnZWVDFj?=
 =?utf-8?B?b01FQXNra1JjTXM2RE1rVUtyd1ROcTRJMC84SXZjcWtqdU1lclUzbVlNbVlX?=
 =?utf-8?B?cVkzV1RUNUs5SmozeHpZelUyelpBdHV0UlZHUmFpOGZmN0tSZkNqdVovNkVW?=
 =?utf-8?B?RjRlY3pUYXNOT25CcndiRFJzSTZtcXo1SU4waUdENmtCTERRb1RMQ2h3aFpv?=
 =?utf-8?B?SEw2Qzl6eWxieXVXMzFvSTFsUDJoYWRDc2RleEg5aG9Pc2FkU1pKaWN0ZjdK?=
 =?utf-8?B?bnY3eFJwd0VTNGpmRWxYc2xQSGRuM2M4S05La2JyeVljUTRwdnpTbUR6ZTVH?=
 =?utf-8?B?RGVSV2VldThnVy9RVXB2UXo4d1hqR09scDRuZGpjc2hMbDBRam1qbmdjT1Ew?=
 =?utf-8?B?OGtGNDFVZ01aekp0VmhlQmhiK3VVbERKRUUvbXllQ2tGR3RzWExyU3pxT0Qw?=
 =?utf-8?B?VGJnc2JhY1Z2anNiT0dWN3RkNnBFVERvdDF4L0R2YVJOWTJ3K1ZXQVM1Nmx3?=
 =?utf-8?Q?Qkd7pyHx8Z/tszpe03lMTHcqW?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <365F23C8371F994FA7E73BEB1B9B9979@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d344ba7-94cb-4a89-0bce-08da905b8b55
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 23:00:08.0221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: znnVRk/bI3ZfaYlW2BelhxaXbeH6FiBCped9MWTRMlCZPXIa1CTFTEYZj8jmeAcaRpyf0HpipImdJhB6mZsJFCPpjqOPSkKAEjMJxDFSI6k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6192
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDYvMDkvMjAyMiAyMjowMCwgUGV0ZXIgWmlqbHN0cmEgd3JvdGU6DQo+IE9uIFR1ZSwgU2Vw
IDA2LCAyMDIyIGF0IDEwOjU2OjQ3UE0gKzAyMDAsIEhhbnMgZGUgR29lZGUgd3JvdGU6DQo+PiBI
aSwNCj4+DQo+PiBPbiA5LzYvMjIgMjI6NDMsIFBldGVyIFppamxzdHJhIHdyb3RlOg0KPj4+IE9u
IFR1ZSwgU2VwIDA2LCAyMDIyIGF0IDEwOjE3OjQzUE0gKzAyMDAsIEhhbnMgZGUgR29lZGUgd3Jv
dGU6DQo+Pj4+IE9uIGFuIEludGVsIEF0b20gTjI2MDAgKGFuZCBwcmVzdW1hYmxlIG90aGVyIENl
ZGFyIFRyYWlsIG1vZGVscykNCj4+Pj4gTVNSX0lBMzJfVFNYX0NUUkwgY2FuIGJlIHJlYWQsIGNh
dXNpbmcgc2F2ZWRfbXNyLnZhbGlkIHRvIGJlIHNldCBmb3IgaXQNCj4+Pj4gYnkgbXNyX2J1aWxk
X2NvbnRleHQoKS4NCj4+Pj4NCj4+Pj4gVGhpcyBjYXVzZXMgcmVzdG9yZV9wcm9jZXNzb3Jfc3Rh
dGUoKSB0byB0cnkgYW5kIHJlc3RvcmUgaXQsIGJ1dCB3cml0aW5nDQo+Pj4+IHRoaXMgTVNSIGlz
IG5vdCBhbGxvd2VkIG9uIHRoZSBJbnRlbCBBdG9tIE4yNjAwIGxlYWRpbmcgdG86DQo+Pj4gRldJ
VywgdmlydCB0ZW5kcyB0byBkbyB0aGlzIHNhbWUgdGhpbmcgYSBsb3QuIFRoZXknbGwgYWxsb3cg
cmVhZGluZw0KPj4+IHJhbmRvbSBNU1JzIGFuZCBvbmx5IGZhaWwgb24gd3JpdGUuDQo+PiBSaWdo
dC4gU28gSSBndWVzcyBJIHNob3VsZCBzZW5kIGEgdjIgd2l0aCBhbiB1cGRhdGVkIGNvbW1pdA0K
Pj4gbWVzc2FnZSBtZW50aW9uaW5nIHRoaXMgPw0KPiBOYWgsIGp1c3Qgc2F5aW5nIHRoaXMgaXMg
YSBzb21ld2hhdCBjb21tb24gcGF0dGVybiB3aXRoIE1TUnMuDQo+DQo+IFRoZSBiZXN0IG9uZXMg
YXJlIHRoZSBvbmUgd2hlcmUgd3JpdGluZyB0aGUgdmFsdWUgcmVhZCBpcyBpbnZhbGlkIDovIG9y
DQo+IHRob3NlIHdobyBhbHNvIHNpbGVudGx5IGVhdCBhIDAgd3JpdGUganVzdCBmb3IgZ2lnZ2xl
cy4gTHVja2lseSB0aGF0DQo+IGRvZXNuJ3QgaGFwcGVuIG9mdGVuLg0KDQpTZXZlcmFsIGNvbW1l
bnRzLsKgIEZpcnN0IG9mIGFsbCwgTVNSX1RTWF9DVFJMIGlzIGEgZnVsbHkgcmVhZC93cml0ZQ0K
TVNSLsKgIElmIHZpcnQgaXMgZG9pbmcgdGhpcyB3cm9uZywgZml4IHRoZSBoeXBlcnZpc29yLsKg
IEJ1dCB0aGlzIGRvZXNuJ3QNCmxvb2sgdmlydCByZWxhdGVkPw0KDQpNb3JlIGltcG9ydGFudGx5
LCBNU1JfVFNYX0NUUkwgZG9lcyBub3QgcGxhdXNpYmx5IGV4aXN0IG9uIGFuIEF0b20NCk4yNjAw
LCBhcyBpdCBpcyBtb3JlIHRoYW4gYSBkZWNhZGUgb2xkLg0KDQpNU1JfVFNYX0NUUkwgd2FzIHJl
dHJvZml0dGVkIGluIG1pY3JvY29kZSB0byB0aGUgTURTX05PLCBUQUEtdnVsbmVyYWJsZQ0KQ1BV
cyB3aGljaCBpcyBhIHZlcnkgbmFycm93IHJhbmdlIGZyb20gYWJvdXQgMSBxdWFydGVyIG9mIDIw
MTkgd2hpY2gNCmluY2x1ZGVzIENhc2NhZGUgTGFrZSwgYW5kIHRoZW4gaW5jbHVkZWQgYXJjaGl0
ZWN0dXJhbGx5IG9uIHN1YnNlcXVlbnQNCnBhcnRzIHdoaWNoIHN1cHBvcnQgVFNYLg0KDQpwbV9z
YXZlX3NwZWNfbXNyKCkgaXMgdG90YWxseSBicm9rZW4uwqAgSXQncyBwb2tpbmcgTVNScyBibGlu
ZGx5IHdpdGhvdXQNCmNoZWNraW5nIHRoZSBlbnVtZXJhdGlvbiBvZiB0aGUgY2FwYWJpbGl0eSBm
aXJzdC4NCg0KSW4gdGhpcyBjYXNlLCBJIGJldCB0aGUgTjI2MDAgaGFzIGEgbW9kZWwgc3BlY2lm
aWMgTVNSIGxpdmluZyBhdCBpbmRleA0KMHgxMjIgd2hpY2ggaGFzIGFic29sdXRlbHkgbm90aGlu
ZyBhdCBhbGwgdG8gZG8gd2l0aCBUU1guDQoNCn5BbmRyZXcNCg==
