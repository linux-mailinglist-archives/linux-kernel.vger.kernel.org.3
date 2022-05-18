Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB9452B6A2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 12:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234260AbiERJaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 05:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234248AbiERJaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 05:30:09 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 18 May 2022 02:29:56 PDT
Received: from esa18.fujitsucc.c3s2.iphmx.com (esa18.fujitsucc.c3s2.iphmx.com [216.71.158.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2EA18B22
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 02:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1652866197; x=1684402197;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=MOARR3nI+Pj58nuRJ1oXWz6o0YFddfpe0JHm+y0OZ44=;
  b=oRnKmdO3Z8mejbdoIvObcSdgM9DWXXfKdZiR05o3d4SR2JB34eau0Qh7
   9o+srTx+mme8QAAvmnehPy3ZrN3TfLLzttQ7oSWQ1j2HLNknboLqBRwxY
   e40N98Wi8vhE+t8VoYdwS6hjaEBgnKiC8mQ6rI99Af6SuYpVz4rSeBTX9
   J1NJIAMioYZHAryXYv7YoKLKgas1ATcG+b3DK05Z9g7yuU75XSBa9eRX2
   ggvGZSDo4e4cFObJFwgfSUMIX82kNyo40rnZLaQEEQOhnMXDaaj2BMFRS
   juMG5Anjhm8s+xudogXF6nQhWJebNfGK0A8lNdabl1f0EE/LT282FDi5F
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="57392295"
X-IronPort-AV: E=Sophos;i="5.91,234,1647270000"; 
   d="scan'208";a="57392295"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 18:28:49 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lOy+S1mxMykZUmkFHOzvrRSjCVIwtx3u0foe/nxM8BOnftm8i5KFDQnPnZQK54gtRndJqlJyNiPEtKj/bz/GfBrm3pWtes8Rn5CdrcS2mH9g1AmNYf58d22Fy4r51wMo10vXhzOdH1CX+JD7GkrbKkZr0bHst51IbcTRzg7wUYIWhQDSv9x4VXcSm4Eb/pf9CBfg+qvr4rumbcu3+a65JLmCKJ4ARsV8+RqZYpxzd4I9psUnevB5Su3t4j7Uyd8vVSxxuwfxogASNgATRCVPOZdrVjhntC4ExvhCVmWkBvlgviV6QlLKVOhqXaAAm22Y5ydiLtEFdurrICb2ZeeeuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MOARR3nI+Pj58nuRJ1oXWz6o0YFddfpe0JHm+y0OZ44=;
 b=h0ihy2ad0Q7KRP7MSqzPRTaywAL/3yq/+e7W3lXMqruOJaumL7R40mp1uZUXxjq/cNON6fiX+H1wyIWpLnvBmg9ihovvQ9Au+k9y9uAVv1lJRQDxWNdeH289jrrmLwZEyfULZekNWdY78hy2+I0XPFRMT8VuVexW7WNTDFAbmCBS/r4NesgmtM0pZM8zo5NPXDnYhbTPkRubIqXQn5j+ir8CqvlbslNLNJ3VmI51IYN0iT5LwBe5KPKOJSb3w9O90mYSMnFnMMs0BOBHAh90NB4VVnCrVouuhMEfZuveraNLuxUqqCWtKYRJ2WoZSRVOB27UEjtNaQ9BK9yA/aXJGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MOARR3nI+Pj58nuRJ1oXWz6o0YFddfpe0JHm+y0OZ44=;
 b=pqqfaVnwv6NTW3q10nrtqvdJIJ6PCs4ma8aF0NcuXxJGXf5nucQgciYYP5/1BwteURN2+joWIElB/l4YPAeYXRbz1nK6AcaCVAdFo1neMEpBNQzdciQj1vqmGf0pZuosuFYe3Ng0IRMRw8aaasD5IlyGupmXrZfoqULu561ATnY=
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com (2603:1096:604:7e::12)
 by TY2PR01MB5129.jpnprd01.prod.outlook.com (2603:1096:404:11a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.17; Wed, 18 May
 2022 09:28:46 +0000
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::f44e:cb18:cb18:e247]) by OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::f44e:cb18:cb18:e247%4]) with mapi id 15.20.5273.014; Wed, 18 May 2022
 09:28:45 +0000
From:   "nakamura.shun@fujitsu.com" <nakamura.shun@fujitsu.com>
To:     'Jiri Olsa' <olsajiri@gmail.com>
CC:     "'peterz@infradead.org'" <peterz@infradead.org>,
        "'mingo@redhat.com'" <mingo@redhat.com>,
        "'acme@kernel.org'" <acme@kernel.org>,
        "'mark.rutland@arm.com'" <mark.rutland@arm.com>,
        "'alexander.shishkin@linux.intel.com'" 
        <alexander.shishkin@linux.intel.com>,
        "'jolsa@redhat.com'" <jolsa@redhat.com>,
        "'namhyung@kernel.org'" <namhyung@kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'linux-perf-users@vger.kernel.org'" 
        <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH 0/7] libperf: Add interface for overflow check of sampling
 events
Thread-Topic: Re: [PATCH 0/7] libperf: Add interface for overflow check of
 sampling events
Thread-Index: Adhql+qIcS4TlJL7Rmm0mhE+FWh7sg==
Date:   Wed, 18 May 2022 09:28:45 +0000
Message-ID: <OSBPR01MB4600D5DA317696E3DAACC3CFF7D19@OSBPR01MB4600.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5879eb43-fe19-40ec-201f-08da38b0ce66
x-ms-traffictypediagnostic: TY2PR01MB5129:EE_
x-microsoft-antispam-prvs: <TY2PR01MB51298FC58E2B19EA3E5A15F9F7D19@TY2PR01MB5129.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ENBLQVRMecqKOmySPkQygIaeNg6htJ9B43XXq8VoWP1231Tzf2P9rTzQU/fyx5Pul1q9+6ms0Ot8IL2pjMsGp6T4YziSobFUprpAKyVWgmtTSD42LznzK6oVU6l1916wtoYetIQ/lny0iyuRFimcD19DU6v5HmiEkVsZhlDmBrIA+h6gwv5hAhlMfUo3uuNJm1JTc6dxHJrqt/IL9yn73UCDzkGtLQxdKNgg7sKTxpWNeGM+4N/UALS4X/ywYKPYAAMsYDt10iXUWMg2Z/weWK/RdswKSnQgegd4NRFTFTgp5TyYXk0BGMmocbMAzI2QZOeVzkcNo5JtBCdIDhMPW+/3zG3LsL/lX0Vu/cL/qZ2yM/n2ryf5Jx+ee3MUFogvPPqY8L+miMfeTM5r21JvJPwbskxchOA0V2fwALDzFuYO/6Ob0IdVT/Ee8gHaXdJsv6Xqa1UEhVeaKg4Fn+Z4bjtpB9y9rZeAwTjLInozWok77Vlh0GB1QU0yqO0rCGUKGeybCjCrLvOUY8BDc7RrV3pKZAU7z6/bxpICF9KCVKNWJJZVrvBG7utF8flHD0bX/0iD0Mciak9ghUbQLO0Rnnp1rGFFmtJxqfnhDdc+5MWj4Ruw7TIQXHObL1lra7qLx4Lyrn6hloHKtIZSzBUMmrXWd89dFNrlLv8GlxFh0L6TEfhXK64DdU9BCDQGfvWwQSpgXo8ZMS9i3R916fxzRA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB4600.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(64756008)(38100700002)(38070700005)(66476007)(122000001)(4326008)(82960400001)(8676002)(86362001)(66946007)(5660300002)(66446008)(7416002)(76116006)(55016003)(6506007)(54906003)(8936002)(508600001)(85182001)(71200400001)(33656002)(83380400001)(186003)(316002)(66556008)(9686003)(26005)(7696005)(2906002)(52536014)(6916009)(4744005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?R1I2K2J1bzlnaldtMU56d1dZaENoVG9UKzNrbmxQdEMvclhwaVE0Rk9N?=
 =?iso-2022-jp?B?QlJ2UzlXYUg0WWF1RXFIQ21NUnhwRitEcUNIdUorVnBuWjhwd3dpNzF0?=
 =?iso-2022-jp?B?aHVRSWFXWDVMLzRxM0ZZUVpicDlVS0Mza0twRnV4RHI2eklRL2NPcVJv?=
 =?iso-2022-jp?B?c2greHIyZzhMaVkyL3B6V09EeGtJUzFDaFRHdzIxNktvK3k2T09obDRs?=
 =?iso-2022-jp?B?ZTV3OVlsUjZDQzZpSXBaUlZ5and6VjFUZ2xOOHV0Z09JY08ydmhjcWxG?=
 =?iso-2022-jp?B?eGVsd0ZnOWxyN2w1Y1BwMm9ldkl3T3ZycCthcXdFTlcxVlZGNHh5Q0hz?=
 =?iso-2022-jp?B?KzBNbFJPd3c3ZmxSYWRIOU1UVTZUbVlLYnRjRVNySDQ2anpKZkpjK3ll?=
 =?iso-2022-jp?B?U3pMWUxud0RnbS9kaUMvQjQ0TmhuWnRScTQ5dWIxZGwrZGsvRDNvcWpu?=
 =?iso-2022-jp?B?TnFRTTdqazl3am4vZ3p2aGZwRE1lckUzeUg0Y3V0OFZydDIwQ3RESzdy?=
 =?iso-2022-jp?B?dmVUU2VrTEtOQStsRi9zSEFiVXFsZzZCcFRzQTM2L2ZxSnNIbCtNRFNY?=
 =?iso-2022-jp?B?VFV0M2xhM0dPejdIakhVcTZVck9mVTcxMnZqR01WUXJGcTJCcnQrdlo1?=
 =?iso-2022-jp?B?WmtOYlV0eW5iZlY0dE94WnNmM1NGNHlVeWNYWURWNHhjQzdicExOSVBu?=
 =?iso-2022-jp?B?ZWV6eGlPWDhXSndIN1ZkZUZTNStUMThzNW0ySW9kVVJVSEJmanNJTzFu?=
 =?iso-2022-jp?B?aCtKVWFKOHV3NmZtTEZaZWYvTXVPc0hGdDZ0d29BcU4xbTMzcnkyNWpE?=
 =?iso-2022-jp?B?UURBWHhYMy9mOTJFSms5cnhQMGkxQXFlMyt3Z09tcWRRTWM5dTFhZ2RU?=
 =?iso-2022-jp?B?RFVtekJNMEFKWG1iU25WL3pkWmp0KzhIS1pyTHZEbFBJTzVicTM0TEE2?=
 =?iso-2022-jp?B?MElkNlVuS2JMN0lhMEdMZ0J1WWJkRitaQXo0YTYxdnBBWC96S0xsemhN?=
 =?iso-2022-jp?B?eWU1NUY2QndyTXIxdklYdzJhTjFrNEtBOXk3UCtNVGF2dHQwNG5QNkw1?=
 =?iso-2022-jp?B?bk1JV3VuZUZ3RTZKRTNPOW9VaGJMSXpFVmxUalR2b1FMVS8wSVFTZldO?=
 =?iso-2022-jp?B?bGJrU2RpSEFUanNkcjRSYWVOaEtISmZZS3Fzc1d5dUVBZ3h4S1BvTks2?=
 =?iso-2022-jp?B?YjUvQXJEeDR4UW5xRjhpMzNFK2I3MFdNNnNiVi9ld3FTUWRFVW9Gd0pK?=
 =?iso-2022-jp?B?RmVpOXgraGc0NDhTOStvcURFTDFKcCt0K2FXV3FDejdLUnRLZU9pR05q?=
 =?iso-2022-jp?B?N1BReHJIV1NMdXZXRGpOVG1nYU0zS25IRE56VHZXOEFjUldpZkZaeEJ2?=
 =?iso-2022-jp?B?eVVqMG1ZQktVN2duYWYrYW5CeUhPOFBiK1ZpTlBmZlAzZk9WTjVTZGxs?=
 =?iso-2022-jp?B?Vzkzb0JHQW5VUS8vcXAwdDJZTnUxSm82WnNaREE3bE1MQytPNXpOOXVh?=
 =?iso-2022-jp?B?S0pEWk56dzVLU1ZmNjFHZjlZK1FjNE0rektiZzlRa1dmTE5UUE1hQ0Fs?=
 =?iso-2022-jp?B?WnlNa3ZPQUttU2NJcndEcjdET0hMbTEwTC93V2E1cGxoUmJwdnh3cjNt?=
 =?iso-2022-jp?B?dEFPRW10TVNpQ1JYYjVyWWgyb1hVM0RvYXlSMzV3elZiMmVYVnBrOUto?=
 =?iso-2022-jp?B?V29qUFArYXV2bVpBM0gvNUtKNVF5THlBQk5iYW02TXZhUzh1TnRGZkEz?=
 =?iso-2022-jp?B?N0RoaU45NWFDdkhjamVPd1Yrb1VZWk53dWNLSURoM2FwNHp6dFc4Z1NO?=
 =?iso-2022-jp?B?U1FKUkp5Yi9wMm0vdXloMUdZcTBQV0Z6aHpXUkpvMENXaVFsRlFRK3Zy?=
 =?iso-2022-jp?B?bjhVZktzNWJ1dUhGYVJlaE4yRFZDYlcvVHlSdUZ3WDM2Wmd4WUZPaUdl?=
 =?iso-2022-jp?B?Qlc5SVFCVXNyR1A2cmd3RndrZ3NnekZzMVZtdmpHeDVoYWhqTjd3Z1ZY?=
 =?iso-2022-jp?B?aEkySTl1TldCNlJ0TUpNQUVmYjJZRXUrTzZKK3hhNWprOG5mNjhsWGRC?=
 =?iso-2022-jp?B?Q0NGNk5RZHFGdUsxNkJxZlhFN0psc3RzKzJUQVgrSjlxK0xFcGxNR0xi?=
 =?iso-2022-jp?B?TnZXakppM0pJdUZLN3NXdDBCeFZHdXlrYUlQWTlINldxVzdGNEl2ck91?=
 =?iso-2022-jp?B?SWxnNmplNjFtZ2J3b1pHbWVCWU12c3RxTHdvUWY0enNsVG5PaGpDSk0x?=
 =?iso-2022-jp?B?NGlFWUVKWGw4MFhmUjNHL05Ed0RDSEVYSVR4cTNTV1J4TlJ6K1B3QnI5?=
 =?iso-2022-jp?B?UjdZQ3JMMzYxaFRhVXhGcFFscGM4RUFzbitkYTYvbEYzd1YvNVFVb3lH?=
 =?iso-2022-jp?B?Y0QxNmw2S0ZoRkk5YmgwRmJid1VSa0xVZTIyOXZHNURQTVovdFJJUEx1?=
 =?iso-2022-jp?B?YTk2aEdlWnpkblo0dHE1KzRNRit0bjFjWjM0R0FyelArWVdBeEFiQTJR?=
 =?iso-2022-jp?B?ZUJkazltKzB4VUtIRXlYRURjdUtYSmZNYS8ranNmZ1Y3MVhQMThjS3VK?=
 =?iso-2022-jp?B?WkpYK0xjQT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4600.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5879eb43-fe19-40ec-201f-08da38b0ce66
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2022 09:28:45.4389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5+JBDwZirPxYHceJgedJB4lgINXpuiCY0Fh5kyh46/0C1iY9WrZ2tPky2KMOt5nYVaArn9OmDTH4OXRVmLd19/6htyAU1/zWoIf7ouKYFBg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB5129
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jirka.

>This patch series adds interface for overflow check of sampling events
>to libperf.
>
>First patch move 'open_flags' from tools/perf to evsel::open_flags.
>
>Second patch introduce perf_{evsel, evlist}__open_opt() with extensible
>structure opts.
>
>Third patch add support for overflow handling of sampling events.
>
>Fourth patch adds a interface to check overflowed events.
>
>Fifth patch adds a interface to perform IOC_REFRESH and IOC_PERIOD.
>
>Sixth and seventh patch adds tests.
>
Do you have any comments?
If nothing else, I will rebase the patch to 5.18-rc7 and post the v2 patch.

Best Regards
Shunsuke

