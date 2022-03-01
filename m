Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E46644C8696
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 09:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233428AbiCAIfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 03:35:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233413AbiCAIey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 03:34:54 -0500
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 01 Mar 2022 00:34:11 PST
Received: from esa1.fujitsucc.c3s2.iphmx.com (esa1.fujitsucc.c3s2.iphmx.com [68.232.152.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3702839169;
        Tue,  1 Mar 2022 00:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1646123652; x=1677659652;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xCZWvwGlbSP1waenpChKuNYIa3KWSVRfmu3SSZoPldk=;
  b=KYErsoIn46pm6s/3usmAiSl6OIt/HtHcPr+4eh9pbrT11h8DR+gfuh0X
   LXCGtA9aKykVg73TdUt9dG+WqD4HTb8sCO23Cu57OyR1dfDPVB2x1hCFo
   OK0ga0PjdXCBuI7VfL2I39zlOXz14g7GZnEgagyh18cmiSMRz7eIlspEH
   o2VRIIiIDCUN3JWT1HC7g/x1u1vxuiuH2amtPQvXezJokZTdB0O3ObHGC
   v8h7pTTSRLg5J45UgJdWFZEx0iJInFHaYy4QrdwGKjPlTBMgu0Kj2LXWM
   4bZ9s5wCpiGQiEIdMF3UuPhOzE+hXGyX7SKQGHDxHFBS2+8J4usL4p/hx
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="58919115"
X-IronPort-AV: E=Sophos;i="5.90,145,1643641200"; 
   d="scan'208";a="58919115"
Received: from mail-os0jpn01lp2111.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.111])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 17:33:03 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZLeliBBpxw4hqkR71SbeYhyFSqNnorHy//YOEGZGF9io4/+tLi8Y6A9U/yeaSpHTQOTJdpVZIqOL0SMPYELdGnWgTQ3fEt2TeigrBOYPD8H6A5svFMzcoT+ROIhdjK0zk/X9p3/iufoUjtgdH+jz98Xg4uZy/qhW73rvB6x+C2ii7ChKrFQSpn2g6FYW3Vg7wqVsBOmo9PHF6UpZfTpS1ZRzJab2Q1w/DeoxMbVLoLPj/tVXu7O9nlGJb4sUSKjYsp2i5taDzc03LlQne+SRIJG3sppXgMpesuMKcJKRCVRzxI5W0zttDpIGfZB5QqePoaRd25pcGAu4Ri8RbIdpvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6clJOOVgvGf/g+OFyk7hBV8lQRhSgfLTw+LJ8JC5f7E=;
 b=Tb5VC4Z8XYdCXB9gjYhP/i4mmyOgyHVQryntJWWC+dFW8cHc6niUf5EGqTbVMp9vpT8G4WBQvKUW3mR7RHrcuzGbEwyv3MJ2YlNilWVvT/C4u/tBNd5dEJz441eBCHTBStBbzn/IRfliUv+peCK6gcWpcMG46w0psVhswPch6PU2grNSYCpcRwGR3spNb6wjyJ6bTZjbXVCAvCpGs65gnlhUnxEQ4MylghYfCX+hbtW0lMp/gYlkbOd3tDcYmMtsxL5I//nPQ775VZNyhk2BVvVa+2UfZ4dlEBYcPA5QR/I5ZEtUm6jlH/AAAwKPOV8mVnZmiWQgO7TaG9mDULuuHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6clJOOVgvGf/g+OFyk7hBV8lQRhSgfLTw+LJ8JC5f7E=;
 b=BY5qyWvs+SfYmpJo9gn4m90pZRfW0DUMWQgKqdE93LMoz5im0TW+9Uhfrh83l+iRPto+ZuvMV7xD/jyFSmc6JyJDVg5yIo9zxTKdtKwmb5mpW82OanCIeT7yaF3PBPvPEcyR5eevk/UAPC+3yY7yP4NwhakuaAOP6y6yV+Ungec=
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com (2603:1096:604:7e::12)
 by OSAPR01MB4004.jpnprd01.prod.outlook.com (2603:1096:604:58::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Tue, 1 Mar
 2022 08:32:59 +0000
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::e420:80f:5b29:5668]) by OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::e420:80f:5b29:5668%4]) with mapi id 15.20.5017.027; Tue, 1 Mar 2022
 08:32:59 +0000
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
Subject: RE: [RFC PATCH 0/7] libperf: Add overflow detection of sampling
 events
Thread-Topic: [RFC PATCH 0/7] libperf: Add overflow detection of sampling
 events
Thread-Index: AQHYKzWWF17GnbIfdUudqZsx+PT3oqyqMePg
Date:   Tue, 1 Mar 2022 08:32:59 +0000
Message-ID: <OSBPR01MB4600BC13514B3D5326FD6F93F7029@OSBPR01MB4600.jpnprd01.prod.outlook.com>
References: <20220225103114.144239-1-nakamura.shun@fujitsu.com>
 <Yhph/u/Jxl31uXew@krava>
In-Reply-To: <Yhph/u/Jxl31uXew@krava>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6d3153d9-5b05-4312-7016-08d9fb5e17ed
x-ms-traffictypediagnostic: OSAPR01MB4004:EE_
x-microsoft-antispam-prvs: <OSAPR01MB40040784F31E817ACF7338A1F7029@OSAPR01MB4004.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r5+Kp9+/NR8NlYptn/TzSOIp5EHnZGuPUSEGPv1Jp71a5T0zIzlg0ZYviqf+gbXiPpyig1pRxLmZHcofYN+/uS/OSsE4PS+A3cLX7+t9ZvD/fBFNqi2KIfBpxsPjtqpajXaZfWknayUVBwICWqrgazBXfJA/X4DyGC4ljE+8BQuO5e9TxHXi6l1TomcNFGFHpTEhQC96d0TSTvJsQhKtorBrSBb5S97nfsV8cvD5n67pDrDCUoWmOEGYVjfuhLrmrT1jRzVH9EBWBR6HCNtEa9sfzWOpoY7E4/iogPGGwZAtEIdlxfml62lo9C7n3gpJA5CSYAGKD23TIdt5L1M+qGT4BeyRzDD5UO3rvA86jp8kuu1EyAyYu/X/JS9Wu4EFrpwhV15wLG0Y8Emaa7IiDGPB+dxE4ESTXeWipJkMkS5Ai3cEb1ooJzQ8ukyaddlNmDQ3GedTSEuaTmf3rjijUVe4HcVhtS4avWvwk+zfymzrN/8EvjGzyHSJ9K+lVQstz8MIs8Bm5yKPhVnFqZKTvQxcbyVRj58/KsAZxDhr9pcCxsoDs+4pPw1C12FOiJGckWWkcbbAbB9w2Ou1tntkf5LrBNR43IwhSPYnukxOA6uUYshtJhs4DcEPVb96vSXdjV8kUaIwgoosu7xJL856TtitY6s9ttfJAG8KLRYi59RUHCx4F2SOJqkj151JpA/P2zKa/cKlWjiWgVS/s1aR5g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB4600.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(26005)(186003)(122000001)(83380400001)(33656002)(55016003)(8936002)(7416002)(52536014)(85182001)(5660300002)(2906002)(76116006)(71200400001)(66946007)(9686003)(508600001)(6506007)(38070700005)(7696005)(54906003)(82960400001)(6916009)(86362001)(66556008)(66476007)(66446008)(64756008)(8676002)(4326008)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?aXBjdUljVGlleFArMVZmcVFhMkY0QVV6bXpGamxTTWhyZm9OVWFWc1Rq?=
 =?iso-2022-jp?B?UERGa2xSaDRkRVNkWitvL2ZEOWpYaW9STUlzcFBYdmhhMnE4TkxMa0Zn?=
 =?iso-2022-jp?B?TUcwNFF2VThQRUZCNmlPZ0ZTaCt3cnN6SmZZd1E5aC9BcVhSQUJ1K0p6?=
 =?iso-2022-jp?B?Y0tzcURCN3hHRVFtdUVDZCtRMmlkS0FFMDFtZnhHY2IxWXBOdWt1UU9X?=
 =?iso-2022-jp?B?Vm94ZDJsRFU2c0RhK0VjbVFab0FhZ2g5WHRLVmlORGFzbEw0SVlhYWN4?=
 =?iso-2022-jp?B?cVJnRENmRTVZQUN3Um5YdjRDME5RSEdsVnRMYkJrbUw3bGFpbUpuYlFO?=
 =?iso-2022-jp?B?YTZRdWZEVVhHQVpYNVRSZ1pIaC9Lak9GdktpOEs0bEx0bWdlLzNoNFBt?=
 =?iso-2022-jp?B?VmxhUEN0TGdrVDl5QUtIVnhCSTdidjltbkg1Mmh0U2wvTUVsOC91djdV?=
 =?iso-2022-jp?B?Q2hFT2g4bXVmVnpBcW9WTFhLUnNTNmpLZ0FpTXQ5Y3FRNFZWYm51SUNx?=
 =?iso-2022-jp?B?bzFNMHl1QmN5T3JNSU5RWDMydk1EeXZ2eXIyVDJvaDBmc2FRUzZVZ2I1?=
 =?iso-2022-jp?B?RWg1TDM0cU9PMnVjR2l2WFY2SG4rcW40UUUxQmlHV2c1Y2RDNm1ha1VD?=
 =?iso-2022-jp?B?dkI2MkhNdmVhVjdrTnpKNklFZjVEQkJYNlErSFpjMHMvZDVKZTE2cHpU?=
 =?iso-2022-jp?B?bzI2Nm5wcFZYekN2WnB1WHI5UFRDSzdsNjNuUHVQZFlQeU9zWE1pdU5W?=
 =?iso-2022-jp?B?Ty9aTklld1dmd0lieldmUmRKT3ZXdTVUSVNKQmZSdU9JcDhMbjdxNU91?=
 =?iso-2022-jp?B?U2NsR2dMZ2d6TmpwUTZqSzZOSWhxUTlISHVyOU83UjdKZzBLaWxtTWJL?=
 =?iso-2022-jp?B?amlMTXlITVZ3RFBseUpKU0VTa1dTQmR5VEdPcUR6NEVQSlh5SDNwbHdx?=
 =?iso-2022-jp?B?TGlWTjVBMWxMTzNuV3V0RWZqaEJLeHlGWm53LzhCc2RlaGkvdDM2Mjla?=
 =?iso-2022-jp?B?aWFlU2NyNDBUYjFUVG92YlZ5REtSR1BmQkM5ZlFYQnFJakw1U0xJR0xQ?=
 =?iso-2022-jp?B?N3BvSlhKVEtYd2VoUjE1VDhRQkF6QUltODJJRURSUVBtT0UwQyt4YUcv?=
 =?iso-2022-jp?B?dkQrb1phR3FITjdCVnNJUzVyb1I2THBDWU92dmtRU3BObjBjdEpTYXZh?=
 =?iso-2022-jp?B?YkVGZ1BlV0dZcjFPQWhXMjlHL1oyN29vRVNrcUsyaEQ0dXZsMHQ2ak4v?=
 =?iso-2022-jp?B?SlFlM3h0bkFsZWI0c3J0YmUzREFxTHBCejEzR3p0OTRXZHJ1SDBjZWZS?=
 =?iso-2022-jp?B?NGljSk5Hb2t1VVZOYkhTSDBma1VYcDNlYWJlQi9mdUc4V3h5Y2h5MUtD?=
 =?iso-2022-jp?B?NlIwY2xnRFRjK2lMcmRSNXZHdDZnbk1USVkzR3FVcVF6YStNcXJxTDhv?=
 =?iso-2022-jp?B?aHJlSUM2OXRvbmo1aExLZWoyVTRQZjV5bG9UcXhqWGErQnBCWU55Yi9w?=
 =?iso-2022-jp?B?TFFDUk9MajJFMVBPaGpkSFFwaEdUMWp5T2E1NTBEcjUrc2Z3TnNYMWtZ?=
 =?iso-2022-jp?B?NExFOVBuV0YwcFlSNVZpanNzSEhodTNaK25xSVQyendkY20yT2I1TVRq?=
 =?iso-2022-jp?B?bjhyclJ3S0pxRDFHdHNqVllGVk5Hb3I2aWpwVi9RWmxRTGpWaXk4VWV4?=
 =?iso-2022-jp?B?RzYwWmo5MW9sU1NmZEtRUXNzaEc4K0dNejFsSi92R2wxOEhHbXBXM3k1?=
 =?iso-2022-jp?B?R1VGdU9leG9xMVRyejI1UHRGT3BoSnVSSDJDZ3Fpcks0UEk4NjBnWXVp?=
 =?iso-2022-jp?B?b3h4T01wZVlMMUpHblVwakhqR0xybm9LSUprNGxRNWRvR05hYnl1cEt5?=
 =?iso-2022-jp?B?eCtZNmhjODJKZ1B5bjFDQ0NoTDVBamdpelEwTitlaEtldjNLaGJzakU0?=
 =?iso-2022-jp?B?RjlkM2xxWTNSdVFFbWdzWUJuZDRqTGcxV2s1b1hJcG9KQXpkaUFVdERz?=
 =?iso-2022-jp?B?WWQwc0lyOGZycmt2UDI2VGlBemdrNFJsQkFSUHcycU5ybFdUSWpJOUpP?=
 =?iso-2022-jp?B?RzJVbmV0WmNRcDd4K0d1dWcrQkg4ZFVRK3BXZ1JOcnJxNTdWODdrMUlv?=
 =?iso-2022-jp?B?azk0emw4cDRzUFpBWUNSQXl4ZlJYVHpxcHpCUkJTNm1KWUdZYVlOaE5i?=
 =?iso-2022-jp?B?cUtLKzNicHNkZld4WkV6bHBocGhKUHpqNTlYZ0J0UDZ1eVRmNGhIUTEx?=
 =?iso-2022-jp?B?RkJPOWNxWEExdkRwUzBoMHFBeEdnQzErTlFDblJrb3l4MkpxdS9ncm9x?=
 =?iso-2022-jp?B?dFphdGh1aXZMdUNkZUJWV2RGL0RRUE9hYmo1SitUbEhRZDJZLzZzaFRh?=
 =?iso-2022-jp?B?QTJFQkxya0JDSmM1ck8vVzZYN29hZkhPaFNhcUR2N2lJSHN0Ums1TEpn?=
 =?iso-2022-jp?B?RU9BYlJRPT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4600.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d3153d9-5b05-4312-7016-08d9fb5e17ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2022 08:32:59.5788
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YmPxkGfRZAYTIeRuqhHM8Pt6TOj0KCMpS0lNFjIrB+wTwpUoAe7q1nOE7RalLf431b7kM34S8NwUac2XqUx/W2PSEhTTRx4TPqdM1QYMKME=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4004
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

> On Fri, Feb 25, 2022 at 07:31:07PM +0900, Shunsuke wrote:
> > From: Shunsuke Nakamura <nakamura.shun@fujitsu.com>
> >
> > This patch series adds sampling event overflow detection capability to
> > libperf.
> >
> > First patch fixes a typo in the error message that I noticed.
> >
> > Second patch  adds a interface to set PERF_FLAG_FD_CLOEXEC
> >
> > Third patch adds a interface to perform IOC_REFRESH and IOC_PERIOD.
> >
> > Fourth patch adds a interface to set the signal handler.
> >
> > Fifth patch adds a interface to detect overflowed events.
> >
> > Sixth and seventh patch adds tests.
> >
> > Shunsuke Nakamura (7):
> >   libperf tests: Fix typo in the error message "evsel" -> "evlist"
> >   libperf: Add perf_evsel__set_close_on_exec() function
> >   libperf: Add perf_evsel__refresh()/period() functions
> >   libperf: Add perf_evsel__set_signal() functions
> >   libperf: Add perf_evsel__check_fd() functions
> >   libperf test: Add test_stat_overflow()
> >   libperf test: Add test_detect_overflow_event()
>=20
> hi,
> I think the interface might be more clear if we use additional options fo=
r new and
> open functions, same way like it's done in libbpf
>=20
> how about adding following interface:
>=20
>   - perf_evsel__new_opts would allow to setup needed attr fields before o=
pening
>=20
>     struct perf_evsel_new_opts {
>       /* size of this struct, for forward/backward compatiblity */
>       size_t sz;
>=20
>       int open_flags;
>       int sample_period;
>     }
>=20
>     struct perf_evsel *perf_evsel__new_opts(struct perf_event_attr *attr,
>                                             struct perf_evsel_new_opts
> *opts);
>=20
>   - perf_evlist__open_opts would do additional setup 'after' the event
>     is open and we have file descriptor available
>=20
>=20
>     struct perf_evsel_open_opts {
>       /* size of this struct, for forward/backward compatiblity */
>       size_t sz;
>=20
>       int flags; /* fcntl flags */
>       int signal;
>       int owner_type;
>     }
>=20
>     int perf_evlist__open_opts(struct perf_evlist *evlist,
>                                struct perf_evsel_open_opts *opts);)
>=20
>     int perf_evsel__open_opts(struct perf_evsel *evsel,
>                               struct perf_cpu_map *cpus,
>                               struct perf_thread_map *threads,
>                               struct perf_evsel_open_opts *opts)
>=20
>     not sure we want special opts for evlist.. the evlist open
>     is just a wrapper and I don't think there's special open
>     info just for evlist
>=20
> I did not analyze your usecases deeply, so I might be missing some case w=
here
> above API would need some adjustment, but from the quick look this could =
fit and
> I think it's better than special functions for each feature
>=20
> there are additional macros like DECLARE_LIBBPF_OPTS that allows to defin=
e
> the opts structures in backward compatible way, we'd need to 'borrow' tha=
t as well
>=20
> thoughts?

Thank you for your comment. I'll consider about it.

Best Regards
Shunsuke
