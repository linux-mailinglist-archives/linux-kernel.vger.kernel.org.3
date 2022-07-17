Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00CA6577290
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 02:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiGQAWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 20:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiGQAWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 20:22:46 -0400
Received: from esa3.hc3370-68.iphmx.com (esa3.hc3370-68.iphmx.com [216.71.145.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443481AD84
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 17:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1658017364;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=nkASFcS8YWoA3phZe5EVY4iZ7pbfNYxeh1jpl5Szs2g=;
  b=U1h/oRXBZZJ/Ui7KUF8THEfxKY2Y8Da4w9AzwtXkXDBc8wIDXbQtpz4P
   zcIwatKk6BE+frtGKC94yBKG/WGWcXPSCqUeTSNjTc/c8yirPGEOYEjJO
   JJd8XRSNR4mgR/aQHQSjH26FBhv5PJGEcRhwOqARxfB8PIgJnYH2iwt/7
   U=;
X-IronPort-RemoteIP: 104.47.66.47
X-IronPort-MID: 75962156
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:BKENXaw9c51PzpaK5Qx6t+cdxirEfRIJ4+MujC+fZmUNrF6WrkVVy
 msXUD3XOf/bamakeIp0O4zn8k0HvJXVzoJmGVZlqSAxQypGp/SeCIXCJC8cHc8zwu4v7q5Dx
 59DAjUVBJlsFhcwnj/0bv676yEUOZigHtLUEPTDNj16WThqQSIgjQMLs+Mii8tjjMPR7zml4
 LsemOWCfg7/s9JIGjhMsfjb90ox5K+aVA4w5TTSW9ga5DcyqFFNZH4vDfnZB2f1RIBSAtm7S
 47rpF1u1jqEl/uFIorNfofTKiXmcJaLVeS9oiM+t5yZqgpDvkQPPpMTb5LwX6v1ZwKhxLidw
 P0V3XC5pJxA0qfkwIzxWDEAe81y0DEvFBYq7hFTvOTKp3AqfUcAzN13AG4SLIIT199zAEpf0
 O0ZLhsjawmq0rfeLLKTEoGAh+wFBeyyZsY6hSslyjvUS/E7XZrEXqPGo8dC2ys9jdxPGvCYY
 NcFbT1ob1LLZBgn1lU/Ucpi2rv3wCehNWEHwL6WjfNfD2z75Qp9yrXydvHSfcSHX559lUeEv
 GPWuW/+B3n2MfTAlGvbqCvx2Icjmwv9Z6gjMuSi9sJwo2yT2yswMzwGexiS9KzRZkmWHog3x
 1Yv0jYhqbga8E2tU8XnWBu5sDiIs3Y0X9tWDv1/6wyXzKfQyxiWC3JCTTNbbtEi8sgsSlQCx
 g/Xt9DkHzpitPuSU3313quTty27PSQOBWsDYzIUCAUC/t/vqZ0yiRSJScxseIapj9izEnf7w
 z2MhCw/gagDy88Ny6i/u1vAhlqEpIDOTws/4Qj/XW+/6A59Iom/aOSA8VHE5PAGL5ucR0PHs
 2Uch8G26OEIEIHLlSqRTeFLF7asj96GLzzfh1N1N5Q99ybr8H7LVYlU8SplLQFsM8IOZCXvS
 EvSvx5Bop5VIHauK6RwZuqZCc0sy6jIGtPiWfTZKNFJZ/BZdA2Duj1pYkqL92/omUko16o4P
 P+zc8GlCjAfDr5qzSC/b+YbzbIvgCs5wAv7R5fgwgynl7yDdnucT58ENkeDaqYy66bsiB/S6
 MpSO9eixBJYXOj/eW/Q64F7ELwRBX0yBJSzrtMNcOeGe1BiADt5V6CXxq49cYt4magTjv3P4
 ny2Rk5fzhz4mGHDLgKJLHtkbdsDQKpCkJ7yBgR0VX7A5pTpSd/HAHs3H3fvQYQayQ==
IronPort-HdrOrdr: A9a23:CDx9QKxrhgSb2YLXOjN9KrPxj+skLtp133Aq2lEZdPULSKGlfp
 GV9sjziyWetN9IYgBapTiBUJPwIk81bfZOkMQs1MSZLXPbUQyTXc1fBOrZsnfd8kjFmtK1up
 0QFJSWZOeQMbE+t7eD3ODaKadu/DDkytHPuQ629R4EIm9XguNbnn5E422gYy9LrXx9dP4E/e
 2nl696TlSbGUg/X4CePD0oTuLDr9rEmNbNehgdHSMq7wGIkHeB9KP6OwLw5GZebxp/hZMZtU
 TVmQ3w4auu99uhzAXH6mPV55NK3PP819p4AtCWgMR9EESttu/oXvUjZ1SxhkFxnAid0idvrD
 AKmWZmAy1H0QKSQohym2qq5+Cv6kd215ao8y7kvZKqm72EeNt9MbsOuWsRSGqm16Jr1usMr5
 5jziaXsYFaAgjHmzm479/UVwtynk7xunY6l/UP5kYvGLf2RYUh2rD3xnklZqsoDWb/8sQqAe
 NuBMbT6LJfdk6bdWnQui1qzMa3Vno+Ex+aSgxa0/blmAR+jTR81Q8V1cYflnAP+NY0TIRF/f
 3NNuBtmKtVRsEbYKphDKMKQNexCGbKXRXQWVjiaWjPBeUCITbAupT36LI66KWjf4EJ1oI7nN
 DbXFZRpQcJCjbT4A21reh2Gzz2MRWAtG7Wu7BjDrBCy87BbauuNzGfQ1YzlMblq+kDA6TgKo
 SOBK4=
X-IronPort-AV: E=Sophos;i="5.92,278,1650945600"; 
   d="scan'208";a="75962156"
Received: from mail-mw2nam12lp2047.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.47])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jul 2022 20:22:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S0TG/H4cyGZxx/YFq8o/UHTJ8gXuPlzBe82Pp4Ibd6jrKTNcqaMb/dAR3RvRoEzEbK2u/03x8ZOTfwyXzC3OdR+BbBLB5Wp+De0E0xBMrblHdIY1O6xS3lucvWYLtqeGSx6hvYYvBH0RpblNOt3E4fC3ZLUcKD53dI915MwI2ubS/91lwCCsRt0CRf2L+V5oUSWilUhEVKLU2hUsPJMPE/U0q+WGqL2avrlJ+3aITRCCiRweDjgajcxUJ4x0p+IEION+Q8BgxLuy8RPOH3wfHO429JWLm6ELfzeCWLWvozFBQ6TXzS+Y55cBFpZ8E77gNYa+U4jhNnX3K/D1qB5POw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nkASFcS8YWoA3phZe5EVY4iZ7pbfNYxeh1jpl5Szs2g=;
 b=UFXd5FI7FxDhBZg9hnSVJHuxhZWKp8onuKhIJGlImGSwrRYlOgs9M6B35jvuOdND/KG8E7JBev0ccemin7AEiMkiRex/6vCMjs9jjiCHtN8AfQSeE38qovjMx8olIJ/NJbgTd2lodHIN7ZXylOBiPt2R2xpgwnt+2dxk1UJ9Cg73p1zvl4rx1weoMqkpEZyAAleutRyEMe4R6P+cnli1z32kyV/ce644gAghwFoQZOHK/rETr9gCzvysYRzPb6pilDN/klCWxeCVPyz5yCE2IwDdbKRDXovvmPGfdQO4V/SW3jqNamtSOPRv+K5Y7d6osn+UQ+/qy1L2KAuif6osfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nkASFcS8YWoA3phZe5EVY4iZ7pbfNYxeh1jpl5Szs2g=;
 b=pcnrhkDMLcSEdOaJeIALo3h7oR+LZ444UtuxbieCnhhw+hEqvxibatO+3KP/Pn/HxgjjmFCECA9R3jQcNRQLv6MzLN+G9U/NO0j831SqhrYynsadywm6mVI7HFZmY7ulDhnzgpIrPeHAs1LsCeizC7c/6EdzW87WDx5mf0j10Bk=
Received: from BN7PR03MB3618.namprd03.prod.outlook.com (2603:10b6:406:c3::27)
 by PH7PR03MB6996.namprd03.prod.outlook.com (2603:10b6:510:15c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.15; Sun, 17 Jul
 2022 00:22:40 +0000
Received: from BN7PR03MB3618.namprd03.prod.outlook.com
 ([fe80::ec74:68a1:2448:721b]) by BN7PR03MB3618.namprd03.prod.outlook.com
 ([fe80::ec74:68a1:2448:721b%6]) with mapi id 15.20.5438.021; Sun, 17 Jul 2022
 00:22:40 +0000
From:   Andrew Cooper <Andrew.Cooper3@citrix.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch 02/38] x86/cpu: Use native_wrmsrl() in
 load_percpu_segment()
Thread-Topic: [patch 02/38] x86/cpu: Use native_wrmsrl() in
 load_percpu_segment()
Thread-Index: AQHYmWoxQRsn7JfDi0+XSrnVp4iWn62Bs9CA
Date:   Sun, 17 Jul 2022 00:22:40 +0000
Message-ID: <0bec8fe2-d1e3-f01c-6e52-06ab542efdd8@citrix.com>
References: <20220716230344.239749011@linutronix.de>
 <20220716230952.787452088@linutronix.de>
In-Reply-To: <20220716230952.787452088@linutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4d8f3e72-d00b-4402-d708-08da678a75aa
x-ms-traffictypediagnostic: PH7PR03MB6996:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JLKc5kRqfLKQRg0yBmXNDLa5ZNIzVEW5NKfi7bDm+OutoyteQDM+Fh7tBrHSIEuTQwzk+TkF4Wv9Ft32463fEuvnYA23+QR5dHmzyIWwMBx2R5yT4kri26gM7J0KSfBzBXbxSqCz7mF7nWUq0bxqfhvmH+bLV/v7UXVTd9iHJ53IipAKIEqXn00zjk6Ru7CDnJmHqgz1nyhxRtNA1mRKUdzxqgYBH3Bho1YYi6aRERwfhPOpFPdzEW54YK75EzgVlQWdFuOXh4QwkyA/LprE8NBBUHSm3BZv6lCRRMN/AaI9oU8ixvARRv6JC/BKHdxEN55L++WQjVEt3qAuI+rvBxlXuZRD/XJfhHF7HX3/L59zevmuartfJrB0/SivG1cbfT9VwLIvb/HjyWHKn/9E1enSuT8g0PPLmUrFXgEnJ570FxJA3kbuecTvK7BALDv6u9IhsHvyRaRYK6oKUYzKtDHsGxRgAQJZGjZDjugfwnplC+KF1BXLPOAuafBwAcpvLlcP9VHhmmGkUVd07m6UR7OmtUx8dRPeyzBm7FucpNwvnNaJDlEHhd6g3mNAF77WUhc0W2iiunpttqHnWldWX3OirbT3mh4qBQcEgxZU7DbZ3cJ2q7dulSn/2Rm37G0UVvtRtfb2Grj0nT+zgLl2QmnIpy0lxB1CJ6gRgU6CXXIK4wJDFksOyC+uoiaQHsj420phqtCuR/0ZLCs1oNv0+l2nPljI+9ggb7iF81rglNmU41qHhyy2Rw1H2MugoAOn0rZImA73NL4pqGryI0wewi52SEI2zjctYqSA0FE4swVbhDyR36M+oEgcYhEZrNeCravycLtvNTsqZWgCH/6VQpHxJA4X8JrDWGVnQoY8ruq+0ZMfmKtgjSbXzSGyOWJf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR03MB3618.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39860400002)(396003)(346002)(136003)(376002)(82960400001)(83380400001)(38070700005)(38100700002)(86362001)(31696002)(122000001)(4326008)(36756003)(66946007)(5660300002)(76116006)(8936002)(31686004)(26005)(2906002)(7416002)(478600001)(8676002)(41300700001)(64756008)(6506007)(2616005)(6486002)(110136005)(71200400001)(91956017)(66476007)(66446008)(186003)(54906003)(316002)(66556008)(53546011)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T1Y3cDBLQWROaXVWYmpkK05EakxZekpWS1VjUXJaQnJ2Wm80ZWppUEU0b1cw?=
 =?utf-8?B?dmRhdzlIT21VZ1ZtUW1hMjRTVXloYkcreXZPOG1hTnFvaHU4bEVJVnljNnA2?=
 =?utf-8?B?K09Yck0wYTlHVnpxTnlzak1jVWxXOGhJeSt3UW5rM2F4eGZnbWR5WVQ3UUoy?=
 =?utf-8?B?YW1ObHlNd0YvU29oS295VkdsbnptTkZXNkhIeTN4UGRiUXBkeFFHaEE4QXBV?=
 =?utf-8?B?NFRoSkhTY0dHSlhoRzBZR3dJSVFGK1dUZG5hZzhyMTRkcUNjY1htQmdFdnFi?=
 =?utf-8?B?Z2ZFMlZQcjlIM01HMHQwa0Q2NUNWT2pzWk12MEhwRDE3QjJwcWQxcnNUM2lB?=
 =?utf-8?B?OVV4SjZEeUZ6a043SWhnTDR3aFBmVmlxSDdJS1lFL3hiN1h1cGNGWGZ6dWJ3?=
 =?utf-8?B?UVRUdURxenRiNllaVEN4ZXpLRmViY0d0dGhjT1dwN2F1NlNZeFZIMDNhRUNz?=
 =?utf-8?B?NTNnY3pjeldNdXhUNWVpcmwvcVN4WWxic1BnZUV0U0JKTG5aSUdVZFl0dTF1?=
 =?utf-8?B?V0lGZ2s2WUpRYTkwKzdabnFRdXIyazZDQS9DTlNrV2Rwelk1Rkg1aUNTQlZz?=
 =?utf-8?B?eldGM3JiQThkemk0V0Y0V1RiRFR0alRsSnQxZmtxNHdiME8rUHFTcFVjQk9N?=
 =?utf-8?B?c2lOOFMrMUt4U2NBTzJGd3duRkR6VXJ1MmdEclg1eDB6akZoRFg0aWJNZHZ1?=
 =?utf-8?B?TmdubjcwV2hMaUE5NjVWbjJ3VUhiQzFGQzFHUE02OXRsajVLOU5UZld6bXZh?=
 =?utf-8?B?amRkc01ZbTlzRGpWUUc2Z2VyTTU4MzJJOUlQQVZYUTh0WkpsVkpGaGpwRjB6?=
 =?utf-8?B?TGtnWFpOVEJqNHpoU010RDRXUmRwbzFpQ2h2V2w1dHJlVHE0TGpVVVZXRWVv?=
 =?utf-8?B?dzltSGZxakV6S0lEazJNNjJJM3UrVTFHbW5iQ2lRMUttSzJSOG9LQzY4WFRj?=
 =?utf-8?B?OWtLbzBKYi9QTFQ1c2oyMkRoMk9ZYjNRVEQyUFMxZFl0WEhNZGxxLzJOT0w2?=
 =?utf-8?B?amhwQnFZd0dtM0ltWmF1d2NDc0ZaSGRPQVBETE1FS2ZxK1hlNXh2dElPVDRC?=
 =?utf-8?B?NUUveFpXdDVBSmtKcjE4OTcyVE5SSlBySU1JRHM4d285bXJyTHZIVXdidW5P?=
 =?utf-8?B?YTdlTXlUM2JRaTBpSHFmZm12WmY5VGkyME14a0xNVDhXeXdzVlVyS3BIbEVV?=
 =?utf-8?B?TWEySHZvM0lGRmJKNkpMUjRDNHNDSTM5UnhLQ3R0Rjh4ZkFJZk5BL1pUa0R6?=
 =?utf-8?B?cFp2ODFZZlN3K1dTL2Y5RWZmZXozSmdCaVAvSVViQmdQRWVXRFAvb0dPckgv?=
 =?utf-8?B?QWl2bHJTd0lFRjdhb2Z3aTkvaStuWHJHWjNoYllDazBnQVpFYUgxU1RnUnZi?=
 =?utf-8?B?dlpSNHBFaWpVQ3VWMFlneHdNT0FZZ3pVM1c0QXJENzFma0FIV040TFBWN1Ur?=
 =?utf-8?B?QnNFaGQrb2dkTU8xbi9VWC93MFRVNTRLWjRSWmhOc3IzZVpLTEwrL2tOV3FX?=
 =?utf-8?B?cjJEQkFTMHE4Nm5idCs2UitQd2pkRVZDRGZKUUZRdFN5N0JiN3hqQkZ1S1hN?=
 =?utf-8?B?a05NbTdrRXMweE9Td1JGdjE5Sk8rTGZlM2dKaFE2R3VXK3JOTk5HL3NUUmdH?=
 =?utf-8?B?Nk91MGJxbi90RW4wblhWQ3NKQlF0VUFtdE9hazdYQ3BFZk5lL05jMnRXZWlt?=
 =?utf-8?B?eURJNGxiVnNlWmI5dm0yWHhJRkZOemR5MlZWQ2pmUXRxTUUzUFVNbkdGZTl6?=
 =?utf-8?B?K0J5VHUydkgrYzBoUUdrUTFSWnVUd0xtZTZZcUhGdjZzaG9RblduNXBuTnBZ?=
 =?utf-8?B?NWNzT3d5NmFkcTRrRVdmNktCUjc2dEIydytYSjZ3bVpZOU5USklvcjBkSWtq?=
 =?utf-8?B?TnZNTmpWUkJuamx0emtrdVpBOURjTytCV0p2U1VGRENoRlY5Z2NNdGc4WlZo?=
 =?utf-8?B?dndYeVhuK2NHS2t4RndFS2ZiVVQ0NFFVVyswZmFFc2IwVnQydDE3QkxLWElj?=
 =?utf-8?B?aENDcVYwQVdHT2IrSTUxM2dMVUpEb0EwYWtzOThsQS9ST0N0MHhTUEs2d0w2?=
 =?utf-8?B?d0Q1bzNLYTEvSGQ4VUZoY0ljelA3VmZXRzFMRlRFQmQyUy9WVnJvTHQ5VW1w?=
 =?utf-8?Q?WV/BS4+ir86wuuO2F2EKiHtpU?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <163E1C0F4C53F04CACDD42CA6C65B28E@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR03MB3618.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d8f3e72-d00b-4402-d708-08da678a75aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2022 00:22:40.3312
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QSKhX6BmWDcHIeKR2ihdVOQeq/z9KtZ0djxICprJjdzUV0gVJNG3JLGJmzN7M6dRJBWQrOKpyPRRyJgBjByyfobGDs0ivM4hdkaEeqrlzN0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB6996
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTcvMDcvMjAyMiAwMDoxNywgVGhvbWFzIEdsZWl4bmVyIHdyb3RlOg0KPiBsb2FkX3BlcmNw
dV9zZWdtZW50KCkgaXMgdXNpbmcgd3Jtc3IoKSB3aGljaCBpcyBwYXJhdmlydHVhbGl6ZWQuIFRo
YXQncyBhbg0KPiBpc3N1ZSBiZWNhdXNlIHRoZSBjb2RlIHNlcXVlbmNlIGlzOg0KPg0KPiAgICAg
ICAgIF9fbG9hZHNlZ21lbnRfc2ltcGxlKGdzLCAwKTsNCj4gCXdybXNybChNU1JfR1NfQkFTRSwg
Y3B1X2tlcm5lbG1vZGVfZ3NfYmFzZShjcHUpKTsNCj4NCj4gU28gYW55dGhpbmcgd2hpY2ggdXNl
cyBhIHBlciBDUFUgdmFyaWFibGUgYmV0d2VlbiBzZXR0aW5nIEdTIHRvIDAgYW5kDQo+IHdyaXRp
bmcgR1NCQVNFIGlzIGdvaW5nIHRvIGVuZCB1cCBpbiBhIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5j
ZS4gVGhhdCdzDQo+IGNhbiBiZSB0cmlnZ2VyZWQgd2l0aCBpbnN0cnVtZW50YXRpb24gYW5kIGlz
IGd1YXJhbnRlZWQgdG8gYmUgdHJpZ2dlcmVkDQo+IHdpdGggY2FsbHRodW5rcyBmb3IgY2FsbCBk
ZXB0aCB0cmFja2luZy4NCj4NCj4gVXNlIG5hdGl2ZV93cm1zcmwoKSBpbnN0ZWFkLiBYRU5fUFYg
d2lsbCB0cmFwIGFuZCBlbXVsYXRlLCBidXQgdGhhdCdzIG5vdCBhDQo+IGhvdCBwYXRoLg0KPg0K
PiBBbHNvIG1ha2UgaXQgc3RhdGljIGFuZCBtYXJrIGl0IG5vaW5zdHIgc28gbmVpdGhlciBrcHJv
YmVzLCBzYW5pdGl6ZXJzIG9yDQo+IHdoYXRldmVyIGNhbiB0b3VjaCBpdC4NCj4NCj4gU2lnbmVk
LW9mZi1ieTogVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+DQo+IC0tLQ0KPiAg
YXJjaC94ODYvaW5jbHVkZS9hc20vcHJvY2Vzc29yLmggfCAgICAxIC0NCj4gIGFyY2gveDg2L2tl
cm5lbC9jcHUvY29tbW9uLmMgICAgIHwgICAxMiArKysrKysrKysrLS0NCj4gIDIgZmlsZXMgY2hh
bmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4NCj4gLS0tIGEvYXJjaC94
ODYvaW5jbHVkZS9hc20vcHJvY2Vzc29yLmgNCj4gKysrIGIvYXJjaC94ODYvaW5jbHVkZS9hc20v
cHJvY2Vzc29yLmgNCj4gQEAgLTY3Myw3ICs2NzMsNiBAQCBleHRlcm4gc3RydWN0IGRlc2NfcHRy
CQllYXJseV9nZHRfZGVzY3I7DQo+ICBleHRlcm4gdm9pZCBzd2l0Y2hfdG9fbmV3X2dkdChpbnQp
Ow0KPiAgZXh0ZXJuIHZvaWQgbG9hZF9kaXJlY3RfZ2R0KGludCk7DQo+ICBleHRlcm4gdm9pZCBs
b2FkX2ZpeG1hcF9nZHQoaW50KTsNCj4gLWV4dGVybiB2b2lkIGxvYWRfcGVyY3B1X3NlZ21lbnQo
aW50KTsNCj4gIGV4dGVybiB2b2lkIGNwdV9pbml0KHZvaWQpOw0KPiAgZXh0ZXJuIHZvaWQgY3B1
X2luaXRfc2Vjb25kYXJ5KHZvaWQpOw0KPiAgZXh0ZXJuIHZvaWQgY3B1X2luaXRfZXhjZXB0aW9u
X2hhbmRsaW5nKHZvaWQpOw0KPiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L2NvbW1vbi5jDQo+
ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvY29tbW9uLmMNCj4gQEAgLTcwMSwxMyArNzAxLDIx
IEBAIHN0YXRpYyBjb25zdCBjaGFyICp0YWJsZV9sb29rdXBfbW9kZWwoc3QNCj4gIF9fdTMyIGNw
dV9jYXBzX2NsZWFyZWRbTkNBUElOVFMgKyBOQlVHSU5UU10gX19hbGlnbmVkKHNpemVvZih1bnNp
Z25lZCBsb25nKSk7DQo+ICBfX3UzMiBjcHVfY2Fwc19zZXRbTkNBUElOVFMgKyBOQlVHSU5UU10g
X19hbGlnbmVkKHNpemVvZih1bnNpZ25lZCBsb25nKSk7DQo+ICANCj4gLXZvaWQgbG9hZF9wZXJj
cHVfc2VnbWVudChpbnQgY3B1KQ0KPiArc3RhdGljIG5vaW5zdHIgdm9pZCBsb2FkX3BlcmNwdV9z
ZWdtZW50KGludCBjcHUpDQo+ICB7DQo+ICAjaWZkZWYgQ09ORklHX1g4Nl8zMg0KPiAgCWxvYWRz
ZWdtZW50KGZzLCBfX0tFUk5FTF9QRVJDUFUpOw0KPiAgI2Vsc2UNCj4gIAlfX2xvYWRzZWdtZW50
X3NpbXBsZShncywgMCk7DQo+IC0Jd3Jtc3JsKE1TUl9HU19CQVNFLCBjcHVfa2VybmVsbW9kZV9n
c19iYXNlKGNwdSkpOw0KPiArCS8qDQo+ICsJICogQmVjYXVzZSBvZiB0aGUgX19sb2Fkc2VnbWVu
dF9zaW1wbGUoZ3MsIDApIGFib3ZlLCBhbnkgR1MtcHJlZml4ZWQNCj4gKwkgKiBpbnN0cnVjdGlv
biB3aWxsIGV4cGxvZGUgcmlnaHQgYWJvdXQgaGVyZS4gQXMgc3VjaCwgd2UgbXVzdCBub3QgaGF2
ZQ0KPiArCSAqIGFueSBDQUxMLXRodW5rcyB1c2luZyBwZXItY3B1IGRhdGEuDQo+ICsJICoNCj4g
KwkgKiBUaGVyZWZvcmUsIHVzZSBuYXRpdmVfd3Jtc3JsKCkgYW5kIGhhdmUgWGVuUFYgdGFrZSB0
aGUgZmF1bHQgYW5kDQo+ICsJICogZW11bGF0ZS4NCj4gKwkgKi8NCj4gKwluYXRpdmVfd3Jtc3Js
KE1TUl9HU19CQVNFLCBjcHVfa2VybmVsbW9kZV9nc19iYXNlKGNwdSkpOw0KPiAgI2VuZGlmDQoN
CkxvdmVseSA6LS8NCg0KQnV0IEkgc3RpbGwgZG9uJ3Qgc2VlIGhvdyB0aGF0IHdvcmtzLCBiZWNh
dXNlIF9fbG9hZHNlZ21lbnRfc2ltcGxlKCkgaXMNCmEgbWVtb3J5IGNsb2JiZXIgYW5kIGNwdV9r
ZXJuZWxtb2RlX2dzX2Jhc2UoKSBoYXMgYSBwZXItY3B1IGxvb2t1cCBpbiBpdC4NCg0KVGhhdCBz
YWlkLCB0aGlzIG9ubHkgaGFzIGEgc29sZSBjYWxsZXIsIGFuZCBpbiBjb250ZXh0LCBpdCdzIGJv
Z3VzIGZvcg0KNjRiaXQuwqAgQ2FuJ3Qgd2UgZml4IGFsbCB0aGUgcHJvYmxlbXMgYnkganVzdCBk
b2luZyB0aGlzOg0KDQpkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2NwdS9jb21tb24uYyBi
L2FyY2gveDg2L2tlcm5lbC9jcHUvY29tbW9uLmMNCmluZGV4IDczNjI2MmE3NmExMi4uNmYzOTNi
YzlkODlkIDEwMDY0NA0KLS0tIGEvYXJjaC94ODYva2VybmVsL2NwdS9jb21tb24uYw0KKysrIGIv
YXJjaC94ODYva2VybmVsL2NwdS9jb21tb24uYw0KQEAgLTcwMSwxNiArNzAxLDYgQEAgc3RhdGlj
IGNvbnN0IGNoYXIgKnRhYmxlX2xvb2t1cF9tb2RlbChzdHJ1Y3QNCmNwdWluZm9feDg2ICpjKQ0K
wqBfX3UzMiBjcHVfY2Fwc19jbGVhcmVkW05DQVBJTlRTICsgTkJVR0lOVFNdIF9fYWxpZ25lZChz
aXplb2YodW5zaWduZWQNCmxvbmcpKTsNCsKgX191MzIgY3B1X2NhcHNfc2V0W05DQVBJTlRTICsg
TkJVR0lOVFNdIF9fYWxpZ25lZChzaXplb2YodW5zaWduZWQgbG9uZykpOw0KwqANCi12b2lkIGxv
YWRfcGVyY3B1X3NlZ21lbnQoaW50IGNwdSkNCi17DQotI2lmZGVmIENPTkZJR19YODZfMzINCi3C
oMKgwqDCoMKgwqAgbG9hZHNlZ21lbnQoZnMsIF9fS0VSTkVMX1BFUkNQVSk7DQotI2Vsc2UNCi3C
oMKgwqDCoMKgwqAgX19sb2Fkc2VnbWVudF9zaW1wbGUoZ3MsIDApOw0KLcKgwqDCoMKgwqDCoCB3
cm1zcmwoTVNSX0dTX0JBU0UsIGNwdV9rZXJuZWxtb2RlX2dzX2Jhc2UoY3B1KSk7DQotI2VuZGlm
DQotfQ0KLQ0KwqAjaWZkZWYgQ09ORklHX1g4Nl8zMg0KwqAvKiBUaGUgMzItYml0IGVudHJ5IGNv
ZGUgbmVlZHMgdG8gZmluZCBjcHVfZW50cnlfYXJlYS4gKi8NCsKgREVGSU5FX1BFUl9DUFUoc3Ry
dWN0IGNwdV9lbnRyeV9hcmVhICosIGNwdV9lbnRyeV9hcmVhKTsNCkBAIC03NDIsMTIgKzczMiwx
NSBAQCBFWFBPUlRfU1lNQk9MX0dQTChsb2FkX2ZpeG1hcF9nZHQpOw0KwqAgKiBDdXJyZW50IGdk
dCBwb2ludHMgJWZzIGF0IHRoZSAibWFzdGVyIiBwZXItY3B1IGFyZWE6IGFmdGVyIHRoaXMsDQrC
oCAqIGl0J3Mgb24gdGhlIHJlYWwgb25lLg0KwqAgKi8NCi12b2lkIHN3aXRjaF90b19uZXdfZ2R0
KGludCBjcHUpDQordm9pZCBfX25vaW5zdHIgc3dpdGNoX3RvX25ld19nZHQoaW50IGNwdSkNCsKg
ew0KwqDCoMKgwqDCoMKgwqAgLyogTG9hZCB0aGUgb3JpZ2luYWwgR0RUICovDQrCoMKgwqDCoMKg
wqDCoCBsb2FkX2RpcmVjdF9nZHQoY3B1KTsNCisNCisjaWZkZWYgQ09ORklHX1g4Nl8zMg0KwqDC
oMKgwqDCoMKgwqAgLyogUmVsb2FkIHRoZSBwZXItY3B1IGJhc2UgKi8NCi3CoMKgwqDCoMKgwqAg
bG9hZF9wZXJjcHVfc2VnbWVudChjcHUpOw0KK8KgwqDCoMKgwqDCoCBsb2Fkc2VnbWVudChmcywg
X19LRVJORUxfUEVSQ1BVKTsNCisjZW5kaWYNCsKgfQ0KwqANCsKgc3RhdGljIGNvbnN0IHN0cnVj
dCBjcHVfZGV2ICpjcHVfZGV2c1tYODZfVkVORE9SX05VTV0gPSB7fTsNCg0KDQpJdCdzIG9ubHkg
MzJiaXQgd2hlcmUgdGhlIHBlcmNwdSBwb2ludGVyIGlzIHRpZWQgdG8gdGhlIEdEVC7CoCBPbiA2
NGJpdCwNCmdzYmFzZSBpcyBnb29kIGJlZm9yZSB0aGlzLCBhbmQgcmVtYWlucyBnb29kIGFmdGVy
Lg0KDQpXaXRoIHRoaXMgY2hhbmdlLA0KDQojIE1ha2Ugc3VyZSBsb2FkX3BlcmNwdV9zZWdtZW50
IGhhcyBubyBzdGFja3Byb3RlY3Rvcg0KQ0ZMQUdTX2NvbW1vbi5vwqDCoMKgwqDCoMKgwqDCoCA6
PSAtZm5vLXN0YWNrLXByb3RlY3Rvcg0KDQpjb21lcyB1cCBmb3IgcmUtZXZhbHVhdGlvbiB0b28u
DQoNCn5BbmRyZXcNCg==
