Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D44CC4FB5FA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 10:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343823AbiDKIba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 04:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343815AbiDKIb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 04:31:27 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 11 Apr 2022 01:29:10 PDT
Received: from esa4.fujitsucc.c3s2.iphmx.com (esa4.fujitsucc.c3s2.iphmx.com [68.232.151.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0531CC19;
        Mon, 11 Apr 2022 01:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1649665753; x=1681201753;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mlf9Byh0MFWV7C01vFgHZTq1Z/xFko9wgqCAm0Mh/dE=;
  b=o3B7VOMV7cj6rf6GKUf23J1UD0OQjlFFqtQrI+a0KQCi9iOALGhkRMTO
   l6lJsKJHB28MS9B3MmMPLiYYBpD7GRFqpB6qjTW7OuW5f4j5PUEdkJW86
   1xSl0nl5/XokTOIge/l4V3seE7cSBnvFl8RVOjo4zBW1xqp7FZ4XuxRyU
   G+wEYqtSB71Auh9Gh56OZwyyQHlBa6UOBEmPaxMEN+9THeD2xu1W1EIqC
   qldCDSO2vdY5YjeHoSnmKfcvBOehLe4Ui8C7S+4qh8h3V2QVgKI871YE4
   MKoMpzpB4neBkf1fDj94Tn8xb9oPEcEnf1B/rvoQPJNb07AXGrU/EBr5Q
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10313"; a="61536851"
X-IronPort-AV: E=Sophos;i="5.90,251,1643641200"; 
   d="scan'208";a="61536851"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 17:28:01 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NLDmxrs39ZxA4IEzBvg5eqGt/e/EdOxlVlN5ruDHoahZXX4nMgDpMdcgjbyvApiLGbJH8II3VUqpL/KGsVhQvFbOVYiCXWd7IkfWaR1aHSNBHi9aU11bJYpMS5Pr/ka5PwetgaQkWZ1qIgsu1uSKcgeFUmf45Hdq4ovdjRNkRYmUjIsY7QTwfsr/KawkG3NIpvVyMPDlMDdBHNG9G3wll6Fyu1+MqGNuB0TwiC8qlEEeY5WvlaUPfFxzk1AUpR/lA91wo+jnUU06npCBv4SPLElqVswyu313LeMNh6qPffONkZa0tlLtbB2TNDm6rE5MwYPkScYKX189moOl+fO3AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h9/LSM5/1Y0kBd/nutjvEleRGmX9K/SWJjJb1yoVbTE=;
 b=dt/T8JaLcxc7ELbgqeHrqSXgnRiP0y37qSSLR9tt67MYMz8IQQ+MHkA11gWE28V8RRCNrtoOAWdMKEIs4RGQ0DxwfyhEeyuP4PD+A0c09mWjY17H0Yz8LJVELHTXTeEipNviN+3FokaUR7nP315e5toW6aLTrs3XIkiCrYzgZsLqRE0mPMbBJxOPohxamKj/neavADNDrwjUA9o30e/GokMtQ1MRoEnP0ekQWDs2aP2XHfvlwYjiuIOFGoPURQjBd2Hj61FZKyF2FmdulzHqTrGM5/rD77XjgEVQl4eyZ/X6PqLMMWT5PJXuPeRbcK/ySBlKjoO5zIOk2a1RE0VxxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h9/LSM5/1Y0kBd/nutjvEleRGmX9K/SWJjJb1yoVbTE=;
 b=JYspHQb7cOIe60BnDiQVHWRBE+cQcJbEIi3cj/BzTdAIdRXW5uBxdI6xFf1GgxTsMD2prlQ9KZTzFD8zkSLRUnvnxV6b1WG9eXDy/VC8AECnxmVnq97rW45yGrRwJqiE1Ghn7P5Er3qlaf8Gui5d6ElGo7G2/WfptKR8U2qDh+0=
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com (2603:1096:604:7e::12)
 by TYCPR01MB8568.jpnprd01.prod.outlook.com (2603:1096:400:138::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 08:27:57 +0000
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::5db:a021:ce3e:8244]) by OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::5db:a021:ce3e:8244%4]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 08:27:56 +0000
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
Subject: RE: [RFC PATCH v2 2/7] libperf: Move 'open_flags' from tools/perf to
 evsel::open_flags
Thread-Topic: [RFC PATCH v2 2/7] libperf: Move 'open_flags' from tools/perf to
 evsel::open_flags
Thread-Index: AQHYRD0ZVj53OsTQsken6htt1zG29azqcpdg
Date:   Mon, 11 Apr 2022 08:27:56 +0000
Message-ID: <OSBPR01MB46006C8A00D51EFD498E0EACF7EA9@OSBPR01MB4600.jpnprd01.prod.outlook.com>
References: <20220325043829.224045-1-nakamura.shun@fujitsu.com>
 <20220325043829.224045-3-nakamura.shun@fujitsu.com> <YkRgFdWdW0HyqIno@krava>
In-Reply-To: <YkRgFdWdW0HyqIno@krava>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 65117eb2-8caf-4d50-50cf-08da1b952e73
x-ms-traffictypediagnostic: TYCPR01MB8568:EE_
x-microsoft-antispam-prvs: <TYCPR01MB8568EE3379D73E6D513919B7F7EA9@TYCPR01MB8568.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VkTmUoCtXiMZQT0zDQ1COisSLCLEy9gDt2fx0bzkiH+nSu8iwcwkayeO0twl91PAf3wbEhgwl6vF0z7TyhUNniDPY/Wjf3zIFgahJS3tvrJY8Qe4OlOWPUGkWrkd7YPAAO5H4c6rt86Kq1oxUBiAJTgYeDsAvV/gi4jORRsVYm66tWrLEMAJVRYkSk1DHUEaXoC9PX/obJPMyb1MvgjqwhQzX6PSiPOyIDWf1u65AoGhbq8MdzY1jC+dCafmvBRWIML009qIXnh0H3yNVBFA8ymoFR6ZhQ2d/dGeIhw4dx6dQhpbJUX34PVtOmDSo4hOnEhE3+8kMyIJLD+tst2TOEBojE9nwSKtxa9+JwhKnyD+SgidZSDp7tO4okHlQwaNuKgS9Fth9yEyFVVaGzVyNI06aJGsX5PtlugDjjjZdOWcE3Fhx+TcpCY0sAV0yxeVpkujgXAfh6yxaaoKud4rajtGgPNYewf95/H6Wz4RvyPmXYJGH+MbaSX5Zai4k8kJ1Gp3uWURAXKKZ9xq0sOyNNjiJMhyK8YlOma6NN2gn0kNCPaW1XNh3+CyzmweqUtCxl4iCdTT1If4yJHQHsMpVRl24EPFpFpY2uN2onMTcv302MaTj+RntLdrQqg3zggKHaDcklx7fEHFWoEt44WS86iE5zH5MGzugMM9su+fL24fbLoPwl9IVrU+99s/6855+wwaTjTQ3dksjpGlhylZEw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB4600.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66446008)(4326008)(122000001)(66946007)(64756008)(8676002)(508600001)(82960400001)(86362001)(38100700002)(9686003)(52536014)(33656002)(8936002)(76116006)(71200400001)(55016003)(54906003)(38070700005)(66476007)(6916009)(66556008)(316002)(2906002)(6506007)(7696005)(4744005)(7416002)(26005)(186003)(5660300002)(85182001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?blpCcGRGWGNiRkFMRmVuQlU5aU96QWVBdHpEWFllSjlZWUU5Q09lMkZ0?=
 =?iso-2022-jp?B?b1AyWXJBSjRaaGkrTmozY2ZsRmowU0VGSlhrM3lWa2YwbWc4M1JWQWtY?=
 =?iso-2022-jp?B?ZlEwc1E1VU0wTEpZNUYwdUtNL3pvL05ZSnhyZWtnZ3RGU0cwbTg1MWEv?=
 =?iso-2022-jp?B?Uk56UVJDZCtLL0s1YW1LTVZhUWViU3gvUnhzVExCanhNR3hldlpkVGlZ?=
 =?iso-2022-jp?B?a0V6eHQ3bnFXVDRMNFhwRWpPRFNxWUVhd09XdktmMnBaSXVvUThvSjJ2?=
 =?iso-2022-jp?B?eUdHZ2lsVG1mMi9hTUNXZlBuU1prbU1vVkpUUzE5a01ZRlVocVBKaXpl?=
 =?iso-2022-jp?B?S1cxOVplaU9vai9BcUFMN3ZSekFrMVZCRkZhQWM4TVZuSnVzL3dQYSts?=
 =?iso-2022-jp?B?ZGJIQTY5MGZJeWVYWW5UOFlwdlA2T2lsYkxzcHh5bXoxcUxJeWZIdEor?=
 =?iso-2022-jp?B?U2ZFTzlCaTBzTUs0RXBiNEFkRVJvNTF2UmpCTzlDeFd4NTllWThWM1Yy?=
 =?iso-2022-jp?B?ZDRSY3RUSnVWOUk4c01CQmxFaEpwWWI1YWMyTXd5Qm0rRkNIS3dOd3hm?=
 =?iso-2022-jp?B?SVZGbjdIQURoL09ucXdSQTlVSnZieTlYbGtaSTRnWGNQNWM3d2FVVzhy?=
 =?iso-2022-jp?B?VWtYeVhNWU9kY2xNMnFuWWRXbnNiaWhvTHFVcnlQd3NCR2dpdkNWd3hP?=
 =?iso-2022-jp?B?MVYyM0F3VklvQWJQYkJUNHNQcmkyT29sY2g0TnJqZVpaYjlpK2h5Ulps?=
 =?iso-2022-jp?B?Q0VYcjU5NlZUNVlneDFreUZYbnFsL2ZQeEFYN09LYXJFR2pLWWpXc1lL?=
 =?iso-2022-jp?B?UmFqRHA5SjhCSnM0Tms2UnA0ckhZR045UHZKS1FsdityQjlrV1NhcUsz?=
 =?iso-2022-jp?B?QWVMd3RHa085YlRKSWw4dHU3VlVrdFFta2JaTExsR3RxcmdvWVIrL0lv?=
 =?iso-2022-jp?B?eE5BZVY4Y0FUd0JjS1VzZzBNUmY3VjdydEQvQ2Y5dGJKbU5MWXV2Smcv?=
 =?iso-2022-jp?B?Y21vdXpxOHlpZjNTR0pmeDd4bGwzMGtudmlBbGppSURLV3ZvL0xOVFJR?=
 =?iso-2022-jp?B?WGx3dG9OUWlCUFdGQnU3dFVHdjF3OWozck8yVHhuWUo0aUlvVU5oenFq?=
 =?iso-2022-jp?B?VmlueTZzVFcyUHRsREt0TVozaDJZc1dSb3o4MXdHZmdpNlhDcFZSMlA2?=
 =?iso-2022-jp?B?Uk5ZaitXMjJya3VhSWdNVmJMVnlaVW9JeGRsTzZnMmlMQUh2dFp3YUs4?=
 =?iso-2022-jp?B?MVgzVnlxRHNQaEwzWnM3eEQ2alJDT3BFKzNjdnpqUlQwUmRTR3ZnVFFy?=
 =?iso-2022-jp?B?Nnh1MVlGZzFOOGdPT1RhQUwrSlpzS3Nqb0NWTzVxdklkQWhPdW5rZis5?=
 =?iso-2022-jp?B?bnpFRDlQVXlqRGpGbjRHdFFoWGc0M1lHc2lkb1crWW9LODJ6U1JObWla?=
 =?iso-2022-jp?B?dVptSHRxS0FzcjhMNGZZWEo3LytTcDBJZUNMVEtjRmE1UVZwS2U0MFJw?=
 =?iso-2022-jp?B?UzNkakx1bE4vMVRLeTZWYlRaWmgwQXFNQ1dMRmFrVHZkTENaRmxWZ1Rr?=
 =?iso-2022-jp?B?a29jT1duL3RSR0pMSUp5cU5sQWduTWZ6bm8yYXhKc1NIQ09XenFKZFIx?=
 =?iso-2022-jp?B?cEd1VytRakRTUHZSeGEwd2J0eWhvZlBGVWYyQ21WTHd0cXp1NGFnMCtw?=
 =?iso-2022-jp?B?Ym94VHEvVW0yNUJTQUFKeW1Yclh4SEVSdmhieDlDNyt6MTdGSEJlSmJp?=
 =?iso-2022-jp?B?VkdiY1Q1MWU2eHFmUXNGN0RNYzVUZ1pjbnZ0bzMxS0c3dExVdHcrTFhu?=
 =?iso-2022-jp?B?L0lRaXNoVENKM1hCb0NjSnJIYXFqQjJPMjNGVlpGWjlUYlcrWFlIOGsx?=
 =?iso-2022-jp?B?R21Ra3ZuZ3VLMERsUnhQbDkrSWF1ZWpKYVhaSTlYZkpIWmZHSzZ0SDI4?=
 =?iso-2022-jp?B?eXJsTXdhOVRQaHJ4L2JBSng1V3lVaHFFdU10YUFpZnRzVzBWWUg0MXB2?=
 =?iso-2022-jp?B?M0wyRGZ6aXFvTkQ5TG5FYjRHVVE1Yld3bkJUbGk3bTU0ejAzYmJnL2NE?=
 =?iso-2022-jp?B?b3g5MmYvMDk1MlEwNXFlZStlYjVXdXl2ck1HVk9UR0RMc29sdVllVjBs?=
 =?iso-2022-jp?B?Q3cxN0VxVzZzTHZPYzF2R0d0NEh3R0lmaXNLeGU1Rnp6dVB3a0pwMDJ2?=
 =?iso-2022-jp?B?SktHMlhIME9sZytFd3VjR0tLQVBNMlFTSVN4V0F4ZUZnd3NSUm0rY01h?=
 =?iso-2022-jp?B?UGN2eFNMai94SXl1OHNudnNlSjdiTDJmdjBjRTlhZGhOL3liT1Awa0JK?=
 =?iso-2022-jp?B?eWVKRlNPWmlTOWU2clp5YUZXOVQ5Sk8vRmNJOUUxSllsK0R2dUNHSlZG?=
 =?iso-2022-jp?B?Z0NvdWo4Q0hYZS9WbEcrZzdWbmNNTkJJanJDVm9SZUVSKy8wZjBEc1JB?=
 =?iso-2022-jp?B?RllRUXdGeEI5Z2l1dXc3VzRuUEl2Q3V4bWFvYS8xc2V3SWlLZzFqcDVH?=
 =?iso-2022-jp?B?c25LTHpOR3pFSHIzcHVtUEl0WjV4ZWJBV3c5U25LQWVUaUtYU0hVTVFh?=
 =?iso-2022-jp?B?aUNsdDEyTT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4600.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65117eb2-8caf-4d50-50cf-08da1b952e73
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2022 08:27:56.9264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YW+tCYn9XnmetmR59rSN0RSCVkhbnWfBbcVBXP1kEP6NFSyMi9ti9TozUDbz7EUyFwciQXQoaxEFnB5P8+K8tspHRxBGOt+P1GBrOl2jkZg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8568
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi jirka

> >  struct perf_evsel *perf_evsel__new(struct perf_event_attr *attr) @@
> > -158,7 +159,7 @@ int perf_evsel__open(struct perf_evsel *evsel, struct
> > perf_cpu_map *cpus,
> >
> >  			fd =3D sys_perf_event_open(&evsel->attr,
> >  						 threads->map[thread].pid,
> > -						 cpu, group_fd, 0);
> > +						 cpu, group_fd,
> evsel->open_flags);
>=20
> please keep this change just open_flags field move, this change should go=
 to
> later patch
>=20
I'll fix it.


Best Regards
Shunsuke
