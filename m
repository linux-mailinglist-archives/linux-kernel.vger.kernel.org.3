Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABC074FB62E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 10:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343859AbiDKIi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 04:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232648AbiDKIi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 04:38:57 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 11 Apr 2022 01:36:42 PDT
Received: from esa17.fujitsucc.c3s2.iphmx.com (esa17.fujitsucc.c3s2.iphmx.com [216.71.158.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB34B3E5FF;
        Mon, 11 Apr 2022 01:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1649666204; x=1681202204;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iGpKy+gBRMcunAFC+4qDTZMw/GK2nGQ5+qIaEY7qEFM=;
  b=U3GRL3IuhDlXXVgndrfGm7TUDASlHPgH5mkDDdGeFYBzPMHkChRASEe5
   wSFgnnz3CeW2STMG2b3nqTI6iqd/4OjHPayIK59GYS374YXNHqEA3tE/y
   7GxnXeGB0h0ag8AwQiiieJa0p+Tm1xq4a5h08CiXO6w4d5CqNiEQFu5Ut
   N67l3dBxpjhZW44RZbV/VSP4vv29yzVMDjCmDJmx5X+Nml45CuETLOMNa
   iSQs2YiEFjcE2I9qAwg27zJRiOZlYxEQSHpJwqMv++xbhhHnIkV88ZoV5
   Dg5q6JqWE3ld0fJ9sgAYjehe8/OAadxsWoIihc38Z6WfZVZ2Ezr6R5LWD
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10313"; a="53631222"
X-IronPort-AV: E=Sophos;i="5.90,251,1643641200"; 
   d="scan'208";a="53631222"
Received: from mail-os0jpn01lp2106.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.106])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 17:35:36 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FXbK0iJwgGU75yUkTq6UuVqQNZof391dTPX7Y5rT4laiYy1bBfgJC5NKKC16aXbaPGmB79Blx0AJqUZS8MAWxG0gwIthKn9UXwcu4Gma0hGDlXunVz0Ol7wUteA/RyH6SHq6RhD/FgA2LYvG5dhfm/K7rMzeoVcpo5l35joGorcidK6ZxfN8rrWd2x7BB97LHIKTHttipaB+QcJIbjoGTs/+FDWhZoRY1MW2xe1yuVbtfW/4o54FVDUR0VUzmh2nrpVEYJxmN+APqJeMwcrPfTsGBn6vEVTp39t0B+t8dsgcjOYr4akfh+B0qopq9ZFNUSnEzmt5ztg9ZHx9ob0UZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vge4s+LA8h2jmrspqutVwtYQMpZpFt68IbiOK49GGuE=;
 b=dUF6KKO1TBapxppb/PD+gwkALDP2pZWn3mNrP+0ir1A1OVqBtOispP5OZlypRTzasAsH+J4rjYaH4leSMaXdQj2WGc41L0tvhE+VIlPYInG82U3XOd5aikah5WllgZPCgrYVmbwv9Qvsxqdp4WZh7OaxU17aDL9CIOMXvwrfgIOp69vVAIKOT83bdA/drSDn0hgiacdlNukpIKP+i53eh07tGceTw/WYCkJA9TsS19+imqXE4jib5ypDPWtkbh0qKvvkuClvfOH8TgHgEF8MPHPp2zqBHGSj/ct0AOMjjE2kpxvDREV9HoAfq1k1NRnWIkevTMtgu999SZrjZOOLEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vge4s+LA8h2jmrspqutVwtYQMpZpFt68IbiOK49GGuE=;
 b=eAP0L0CcY3ALxhZrUstqf0Zges1cNcIdQOtcDoumdLcRslFGf+XZT5fjNDbnqJjq4ped21ubIuDx6wYBwIp1dfSmteHmVIoWu9OAeXnL83LrRu6bOKGDSy8OabebLwyV4epsPvr78hS1mjZrSJBBEJC6ga+afS9+7sIer87DYoU=
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com (2603:1096:604:7e::12)
 by OSAPR01MB3316.jpnprd01.prod.outlook.com (2603:1096:604:5b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 08:35:32 +0000
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::5db:a021:ce3e:8244]) by OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::5db:a021:ce3e:8244%4]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 08:35:32 +0000
From:   "nakamura.shun@fujitsu.com" <nakamura.shun@fujitsu.com>
To:     'Jiri Olsa' <olsajiri@gmail.com>
CC:     "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: RE: [RFC PATCH v2 5/7] libperf: Add perf_evsel__check_overflow()
 functions
Thread-Topic: [RFC PATCH v2 5/7] libperf: Add perf_evsel__check_overflow()
 functions
Thread-Index: AQHYRD0nCXA2T4GG5UGkrEtp9vrZWqzqdW1A
Date:   Mon, 11 Apr 2022 08:35:32 +0000
Message-ID: <OSBPR01MB460018BDE6C3F4ABDFE2CBD7F7EA9@OSBPR01MB4600.jpnprd01.prod.outlook.com>
References: <20220325043829.224045-1-nakamura.shun@fujitsu.com>
 <20220325043829.224045-6-nakamura.shun@fujitsu.com> <YkRgLBTHVQbdX8rK@krava>
In-Reply-To: <YkRgLBTHVQbdX8rK@krava>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0aa849e7-6873-4a17-51b2-08da1b963df5
x-ms-traffictypediagnostic: OSAPR01MB3316:EE_
x-microsoft-antispam-prvs: <OSAPR01MB33160F4EFA6124C086C52AFFF7EA9@OSAPR01MB3316.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BbQZRbIwaw49hf/Op8kP2546OwhDyo7RLeNyUQ3DMsHCSx0GzjXG3aGERI90FsoiKLE9hzLgNTZ/WUCOUJZxR4cxlgIhazp4UQsvvW2XEot5exKlX4iqXA0z0az+39vWXzKCuvjODBF37BLIgWssLKf8KmOPaRKPBs51lQbpIyqKrJ2QtoUi7DVZdFzOG6gA5MTX5i6NG+xv6fhSNe15C7iAhoDo5uVXWhaLOgtqitED9Oy53TnE0s70VaOI5rBcJUPHKAocJUdgh3Isnw+nY02RoyaUY9d9nHlkw+ye33oUC3MUxBuj61+ZZUPZer1SEs3PifOLDfmtOdhm45qII1c3TWNKQrPt2MpV2f/zVpd4487K7t5WDdHAJe4cmHZf4HxGxbbGv1f7bHcKk0gTxiAvj52XHtP7bbZK6xlexN7PHi+ro5weNfCjDpjHgf8Ey2mwStk7KZgyG+m73DbVViXgUZT0fWULS4r1pvsbn1gTnGjOveuYSeSsI1YkWWQmcRZFAKqm3ryFOictpd6MhpHh0+wrnr0BsBs1xkC72WBVHsriVPb1obR0PU0Nwm8GTEnkr3Ed8eytTrg6u2nK54tg1QKAUgz0jb4+pwG7Vm0HXRQmqTfDOjBCBexVZ2O+M0pPJ+nGXtA8CceFCUGGvkoGnvz86nipvFHYqU7zrTCCRww2sfjG713atuI5HAzK3M3kE9BeE8i059rxVttYTDZQKwPQ4WpiqCwKtjk6YZJyO0z8XmgxB9cMK3cD7h89
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB4600.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7696005)(122000001)(9686003)(6506007)(82960400001)(2906002)(38100700002)(186003)(55016003)(26005)(33656002)(508600001)(316002)(52536014)(76116006)(66446008)(8936002)(66946007)(66556008)(64756008)(66476007)(8676002)(86362001)(38070700005)(6916009)(5660300002)(4326008)(85182001)(71200400001)(54906003)(7416002)(101420200003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?SUFlajUxYWRDTVdjTnlMZ1Bibys0MkZTOXVmUWdTRzg5bDJYNmRTbWVM?=
 =?iso-2022-jp?B?eEd2Slo1VUNHbjNmVVpOSHdYOHNKQ1Bla2hNUkJteHBwTnpsQS90SGdn?=
 =?iso-2022-jp?B?TytlOXg5TE11SVVWSk9hSmhBbkFjdkF3N2Q2NFNqdGNEK0k4NGJjbXBY?=
 =?iso-2022-jp?B?bzJuem5DUFRHTHBGVERkc1k1dHRObmJQQi8vUXhXRGd3WUw5WDlXNjhn?=
 =?iso-2022-jp?B?QjBqQnJUZXFNN0thWDlwV05jSUZyWUE5MlVZOWVKL1pIS3dvbHhjZmRk?=
 =?iso-2022-jp?B?bFlvNFpvN1RLTVBkd1BpZ1lyMmN1QnRhektGTTkxM1ZOWnZkTkVPemdW?=
 =?iso-2022-jp?B?QTc1dlVkZVc0SzE0VnZNeDVzTUkwUHFtdjAxUGZ1bnFwZnlnY3ZjOUxs?=
 =?iso-2022-jp?B?dGhCc3YvZyt1U2VyclFrdGxxT1h5c0Q3T2g2STlsVTBCUHpSRm1ySVVU?=
 =?iso-2022-jp?B?b1JJMmEzZTdNRlNiZzF2Y1FQa2h0dHFGdWRNZGdpTmhNaXZjaXk4NUNx?=
 =?iso-2022-jp?B?OCtuWHN5SGMyR0JpdHpZZmtjazNxblhzNVVwNmtEaWpKSVVFa01SS2tu?=
 =?iso-2022-jp?B?R2hCYm11ZlBsSWZ3R2haQ01CcXJRbjA3Yjg2bkVVc284V3JVSGt2N3pj?=
 =?iso-2022-jp?B?Q0NXZ1granNVaU1UaEF5anNmUTUwMmtybU5rS20zSDFRN1Z2aFFzUkp1?=
 =?iso-2022-jp?B?aVhwVjJPRmduQys0SDZyN2lEU25SaTB3ZDkzbkNJZHVJYXZFRGVXMzYr?=
 =?iso-2022-jp?B?b2orbFZVMU5haFNRSDF0akpHb3UrRjhjT3FjNzJQa1YxM3R5VGFuMHpE?=
 =?iso-2022-jp?B?Q2ZXYWZlaWlVemh4NUxWekVhYVEyYitwbjlPRWFOV2NXd3puSUtMeDdI?=
 =?iso-2022-jp?B?TCtoZnB0d1hmUTJ3VHcvTWQ2SEVGcGltRjJSdDljTktOeXNuTHhjT2NH?=
 =?iso-2022-jp?B?ejFCemZxaVRqWXhhYXpYdFEvNTE4M01obXRkVkRwQlV5WDRYM2k1bCt0?=
 =?iso-2022-jp?B?TnRNNFBLYWYvaFFNdDFkVmJoQ3JGWkpoS0M2RnJodlZSUTEveERIbnNq?=
 =?iso-2022-jp?B?eVZVVjFDZWQzZVovNzBqOFhzVUcreWhDaWNrTkQ2U3dOa05zdERyM0lT?=
 =?iso-2022-jp?B?QnVEdTBWNTUvd0c1RkFqSzVwWUVoTFFMa2syU2dHTWxGU2N0R2ZEVHJs?=
 =?iso-2022-jp?B?Rkw0b2tzMy8wa1V0V05xRUNkUmNEbmNYZzdreDNUOCtWVzZmZVZFZ0Fh?=
 =?iso-2022-jp?B?TTkyN2Ztd09tQmFjTFlpUGtoaTNqZ0xQajFndFVSTHVQOTVsc0xXSm1w?=
 =?iso-2022-jp?B?aGttaUtOYnp6NDlMQ1NyUFhSNFdoVWdTZWVnbFVCM3NCSFhiSHZWcHJj?=
 =?iso-2022-jp?B?bFFIUW4xMFNqR3Z5azJqZ29OL2pSL3lqQWJ3anl6dW5wUDNhZEZUNjV4?=
 =?iso-2022-jp?B?emsxR2tKc3FYMDdiUUR2QzBRL3Y1THZ6ZWtKM0JpTWZUQTVOSVlaWWJB?=
 =?iso-2022-jp?B?anpEWVZKSG81b3hxWjA4OHNHd3VvZWJVNDVuZ3dQY2Y3RVBUOUdKL0M2?=
 =?iso-2022-jp?B?KytwbUsxcTlJSHk0aHJjUE8wMUtZZjdRdVBwU2w5YWIySTBEWkZrMi80?=
 =?iso-2022-jp?B?MzllcXQ0R0dLci9aaGNCdTRTV2QxQ3ZncFpFZitDZjhqbExkTFhETEJa?=
 =?iso-2022-jp?B?WTlkaWVFZ3JEWE4yVTRHcVBTNjFCN29EdC9oN0ZtNWhqWHpGM3F6bW5a?=
 =?iso-2022-jp?B?cGs2UVVwSnN4TDIyWWMvTTZDeHU4NU84ZzIwUm1abENnb2dOSVJQRjc0?=
 =?iso-2022-jp?B?aEplWVBYdUIwUi9Qb1hqL2VaTWRFOHgzRERmZ2RDWG1ZS2lacklGNGhL?=
 =?iso-2022-jp?B?MGdzWTlla2hDNndnOGdxRjlDTm9VSWZZM1VjMlpRTWluWFJNMUI2ZS8w?=
 =?iso-2022-jp?B?RWpUZnFnUWIySlIwQTlwV2x1MFlXT01zZXE3VExUT1U1Z3A0VUFaNkFS?=
 =?iso-2022-jp?B?YW5DRnpJYmZ6WVlmaXZkVGtJL2FnN0cvWW9oMWd2OE0vb0xpcW43NWsy?=
 =?iso-2022-jp?B?Qk11TkF4VzhhZWlSTm5RMFdDTGpta2ZnOGp2RTlxajJpekxrajVISXZC?=
 =?iso-2022-jp?B?b2l3VFhTclhnbFd3ODU4Q25qcVlEVThBRkFXTmtGRTFvdDFIREdSZ1Rl?=
 =?iso-2022-jp?B?NEtLREYrb2lIL0l4Z01KeElqTWJiaWNyOHZUdVh5RkU2UmVkS0NBcUlU?=
 =?iso-2022-jp?B?Mm5DQ2ZBNTdCUFAzSmM2THVvenRuR3J2NzE3YnRGOFZuTmd0TU1jeWZs?=
 =?iso-2022-jp?B?TFRmNVJhRWFTMXJCRkh5MHBPVnhydFVmNTlSUW5mbC9iNEtVaTAva2FC?=
 =?iso-2022-jp?B?UFBvT1pGTFhiZGxsQXpoblV6YnU4T2tXVXJXZEJlTENUNUNDVGpKU2pw?=
 =?iso-2022-jp?B?NXphUVpuNXlVcmpNU3JrWmZPVkNYVmhiRVJGTGxralZQYVVFZUxKSXgw?=
 =?iso-2022-jp?B?Wk40aGJMTFVuclBTeUcvMFFCSTkzMVNmME0rTGhNbklGMEtPYzAxZHNW?=
 =?iso-2022-jp?B?eTFNYi9oYz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4600.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aa849e7-6873-4a17-51b2-08da1b963df5
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2022 08:35:32.4409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nJM4MUZY5Q7wRQ0aNn3+s6+oYV+j89XXRdmGJS5t3AKdReIH/EL3CsOrrmHTJybnQI/jpI8Retvg5vQyy6E095+tamaE8lrhkKLl/ccBXTE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3316
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi jirka

> On Fri, Mar 25, 2022 at 01:38:27PM +0900, Shunsuke Nakamura wrote:
> > Add the following functions:
> >
> >   perf_evsel__check_overflow
> >   perf_evsel__check_overflow_cpu
> >
> > to check for perf events with the file descriptor specified in the
> > argument.
> > These functions can be used in signal handlers to check overflow.
> >
> > Signed-off-by: Shunsuke Nakamura <nakamura.shun@fujitsu.com>
> > ---
> >  tools/lib/perf/Documentation/libperf.txt |  3 +++
> >  tools/lib/perf/evsel.c                   | 34
> ++++++++++++++++++++++++
> >  tools/lib/perf/include/perf/evsel.h      |  4 +++
> >  tools/lib/perf/libperf.map               |  2 ++
> >  4 files changed, 43 insertions(+)
> >
> > diff --git a/tools/lib/perf/Documentation/libperf.txt
> > b/tools/lib/perf/Documentation/libperf.txt
> > index 700c1ce15159..4ae8d738b948 100644
> > --- a/tools/lib/perf/Documentation/libperf.txt
> > +++ b/tools/lib/perf/Documentation/libperf.txt
> > @@ -165,6 +165,9 @@ SYNOPSIS
> >                                int cpu_map_idx);
> >    int perf_evsel__period(struct perf_evsel *evsel, int period);
> >    int perf_evsel__period_cpu(struct perf_evsel *evsel, int period,
> > int cpu_map_idx);
> > +  int perf_evsel__check_overflow(struct perf_evsel *evsel, int
> > + sig_fd, bool *overflow);  int perf_evsel__check_overflow_cpu(struct
> perf_evsel *evsel, int cpu_map_idx,
> > +                                     int sig_fd, bool *overflow);
>=20
> should this be more like:
>=20
>   perf_evsel__has_fd(struct perf_evsel *evsel, int fd)
>=20
I'll fix it.


> also why do we need to export *_cpu version for this?
> I don't see it used in the test
>=20
Sorry, not necessary.
I'll fix it.

> >    struct perf_cpu_map *perf_evsel__cpus(struct perf_evsel *evsel);
> >    struct perf_thread_map *perf_evsel__threads(struct perf_evsel *evsel=
);
> >    struct perf_event_attr *perf_evsel__attr(struct perf_evsel *evsel);
> > diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c index
> > db9b7274feb5..6ff3cf692df3 100644
> > --- a/tools/lib/perf/evsel.c
> > +++ b/tools/lib/perf/evsel.c
> > @@ -616,3 +616,37 @@ int perf_evsel__open_opts(struct perf_evsel
> > *evsel, struct perf_cpu_map *cpus,
> >
> >  	return err;
> >  }
> > +
> > +int perf_evsel__check_overflow_cpu(struct perf_evsel *evsel, int
> cpu_map_idx,
> > +				   int sig_fd, bool *overflow)
> > +{
> > +	int thread;
> > +	int *fd;
> > +	int err =3D 0;
> > +
> > +	if (!overflow)
> > +		return -EINVAL;
> > +
> > +	*overflow =3D false;
> > +
> > +	for (thread =3D 0; thread < xyarray__max_y(evsel->fd) && !err; ++thre=
ad)
> {
> > +		fd =3D FD(evsel, cpu_map_idx, thread);
> > +		if (sig_fd <=3D 0 || !fd || *fd < 0)
> > +			err =3D -EINVAL;
>=20
> sig_fd check should be before the loop
>=20
I'll fix it.


Best Regards
Shunsuke
