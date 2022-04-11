Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE7474FB629
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 10:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343894AbiDKIhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 04:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343859AbiDKIgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 04:36:33 -0400
Received: from esa5.fujitsucc.c3s2.iphmx.com (esa5.fujitsucc.c3s2.iphmx.com [68.232.159.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C651A13EBE;
        Mon, 11 Apr 2022 01:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1649666060; x=1681202060;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=b72HxvR9xoGZZj49IuSlV7SRxZcVircGes1Z8uFduFU=;
  b=k1S2ncHABIgVP063QKjs61xJdsFh9Xk6JYQtZvpXIcsRTauZIh9ekcR3
   Gpc143za++n12HaoT22k3QILpoCnKs1ta9vxZVpHeW++EpmsCHRNXbF/d
   3lIWtGCbx/rD0E3c89LKCODVvHmx8nW9yDFxHfOD6/h8+Ggn5yzTdvGJA
   t2U1u888V+r6UfJ2xdvq0eebPwUvReAr8WCKAQvCtoSwzE1nuIDJjZHfi
   gYUbaJWc0PxCLy6rwcUB9BhKnPIyyJUTt4O9aaXEwO5YDGTlqWWxRxnvH
   85cK2PYywYxelhCS2j1FQhC7qkjvJANvOM51RjtVdi1SD/sUiSZyALGKu
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10313"; a="53758170"
X-IronPort-AV: E=Sophos;i="5.90,251,1643641200"; 
   d="scan'208";a="53758170"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 17:34:13 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iz/Vi19kijVI0qM2vxcVcPaS0DsmzNnnhfvohZn92M77exfPgku+CXIug3zipY9l2b4/KhINncQik0sTjR2KgLcjbuj5tn20UdAy7m+YUPjD03i2DmmkF05ATbMZUbUs1RyeZdkwYtdwvwZmQ7kdpgyzGF9fKL+xEJfNioJoMb1HhSGgc/nQs7eUyYvJXjUJ2pc58Nz+pb9pZ4WW5M+Pfo33uWtLW8+4c2DiBkPHrM0oitCv+k3W679ov4EXw1G1gCzjrerx0DhfhpmfzESY+OdtbzU+g75t7EWYlvB7R4LjQML020mYTE7iIFsPX4+PQbVtiL2zdLBWY7b9RgaAzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8e4PJykt1Xu0141KT95O1+wTtIzXwat0e63ayyce7Us=;
 b=e1v7FKyDPfILAw92wmyDAqWWBvA/2W8kmyjhmo9OksiXS1eudBJ7Rbj6Dbvf3Q7pvbBc6A/pN58laO5EuQ1Ho433gJVZvU6sZr6kJ7k4hxu3m6uNPKIt4u54O+/LgiwMGasEv1lCTEa9ZkwtwyS5TEhl+j2wi+RC9+kuOOF050RKEY/1wIk4uBXL1Eyrfj4Liq7AHLz4qK+E90e85JUv6Z5bpXkBWQ0uh11ApxE5TJEwe9r5YYWSbP+YXP0lKjL6iFYYuP/xVwK/rEj+4d8QuhRVjA/fqRvRHDAYWf5mPfPWJA1U7yw9Ru+3uHs5XnIQ/mADIHYOEPTVFWFZ7llKjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8e4PJykt1Xu0141KT95O1+wTtIzXwat0e63ayyce7Us=;
 b=kNxhBC1bPOk7a4Nsgoxj0sT7hq6fwiCiHbDy3bzF2zdswIAOCH0BD66FmWNfKUfKz/0bll3rRGAH5hysNLPYfSXW7O0nTaW7arsfGEYIjZTx2UoYnviwD4+l7ZDYDHBC9duonh7Xp2Iuib2FdKfkW4XEJY9M/k8nGZON9BrdPpk=
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com (2603:1096:604:7e::12)
 by OSAPR01MB3316.jpnprd01.prod.outlook.com (2603:1096:604:5b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 08:34:09 +0000
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::5db:a021:ce3e:8244]) by OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::5db:a021:ce3e:8244%4]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 08:34:09 +0000
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
Subject: RE: [RFC PATCH v2 4/7] libperf: Introduce perf_{evsel,
 evlist}__open_opt with extensible struct opts
Thread-Topic: [RFC PATCH v2 4/7] libperf: Introduce perf_{evsel,
 evlist}__open_opt with extensible struct opts
Thread-Index: AQHYRD0mlfomz6jCoE+uLALkEGmIQ6zqdMUA
Date:   Mon, 11 Apr 2022 08:34:09 +0000
Message-ID: <OSBPR01MB46001064CFA2AF85C1D161B8F7EA9@OSBPR01MB4600.jpnprd01.prod.outlook.com>
References: <20220325043829.224045-1-nakamura.shun@fujitsu.com>
 <20220325043829.224045-5-nakamura.shun@fujitsu.com> <YkRgM1obkBQsY2FR@krava>
In-Reply-To: <YkRgM1obkBQsY2FR@krava>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d275daea-98a7-471f-cc59-08da1b960c9e
x-ms-traffictypediagnostic: OSAPR01MB3316:EE_
x-microsoft-antispam-prvs: <OSAPR01MB33164839B8E66857500D8450F7EA9@OSAPR01MB3316.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +GMKqXBw0KzRbG6MJtRfSIIipLRT/4FbbI91hZ3shJJwx/PCDqK8ztX16ZdOCpj7V5qZbtyN1vT+8AAVZjrgnR0iT0HqCEUdUL9ocCgBQl5rqIGJCeuW78ecbWLCHxx7bkav//1MiKuioeOic943l9LhEV5eFQ0tSOiqqcy/JxjC3SOqNbwrUHRMim0t1qrKtmfxr5QX00u7FBNk6GjXMW0u1eiV8zuABoJPESThgyyNpwKIsqO5iJA/SwyESCv0qe1XPBGmH9a/qW6+Sf3ODXRnayOk55ALPegVpT/bMX591lgUfNVZMWjf0z8ydLslzwyJMA16RwtR+vW8CHuzn8rwlUQLSdammxF+jFfIriRryqnxEj/C+x4hS865YG9r303QjzPBYVSxK2ExA6wvziISzTL2GZGU79qGhRRqIQjRXUnTBDIn0RbSWELkjd4PguIbhlHwgLJinp/0RYL3nIzD8ZtYzGa4ZIfnj2vxbU+Nay0eBsWeCvTsRsCdUy8Obt5VIUJHg1ld6iLEN2G1/zHbjUh9VsnXlZxO56zG12A2n9pgVO2phiHxTdopBEgwvwWYHzu/H9p59YQLhZYnur27naypOpbUVt2I9gjx9rKMJV6aKSHZMcvwT7ehullDH7UwtcWGvp7Hp/7rdctWK8SXPGTmq6AiuMMfGbCnH9dyjN1kGatrBaI61YBxGKKkwqdjIDNv6A30bVmDbsIFMQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB4600.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7696005)(122000001)(9686003)(6506007)(82960400001)(2906002)(38100700002)(186003)(55016003)(26005)(33656002)(508600001)(316002)(52536014)(76116006)(66446008)(8936002)(66946007)(66556008)(64756008)(66476007)(8676002)(86362001)(38070700005)(6916009)(5660300002)(4326008)(85182001)(71200400001)(54906003)(7416002)(4744005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?enNqN3Rla2pBRWdON1ZCMlJ5TmNxemFhdjZ4QUlnWFpsQVBSMGszZEFi?=
 =?iso-2022-jp?B?V0N4S1JxSXUxd3NQOUk0WWVKVzBiWmh3WWVMR1VsSURjWWFhcUZWTWhR?=
 =?iso-2022-jp?B?R3MrN0owZzdIMGVxRGg0WDVuNW9sUEZHZDRaeW4zUW15b1RQSmpBK3BM?=
 =?iso-2022-jp?B?cWt4ZmFLRlE2Smp6ZnQ3dkdLVG8wVkVuK3NnVkNkWjJuSkM5TzBCWDVy?=
 =?iso-2022-jp?B?R0prZDhMQWRxekxDTTgrcmVPSlgxSkpDNlVOY1QrNU9hczNXSHVPcWlt?=
 =?iso-2022-jp?B?TW4zeFBVSEZoOGJmbTRoa2R1dE52QkU2cXBOU0xaZWI4V3dPeWNwK2RL?=
 =?iso-2022-jp?B?c1cwdTJvbjhSdVNzaThUMjJIMFZuM2ZFYmpPNlF0b3o2eXR3YWtubHN3?=
 =?iso-2022-jp?B?M1cwNjNlUTNSUDVsUTdJdkZmdnRuVHd1d1BPcFhnT0tQOEkrOExSbzBT?=
 =?iso-2022-jp?B?akxoQWc0OHJtUVFTTHpmMVYvZFdtcFFLenhtZ1ppdWdpUWFxVlI0QVhr?=
 =?iso-2022-jp?B?ODFNcFA3d2lueXMvL0dlV1pVNUY3YVFsdDcxOTNYRTNRRnF6MnA5S1ds?=
 =?iso-2022-jp?B?NW9uQnB4Z1BhSDVEQ2xxaU9TNnVWUWp1UnVEU1R1SU5lMzh6bDVqZGds?=
 =?iso-2022-jp?B?MWNhU242L002QVA2dVVIeUdCbFdzLzZFcFRGeGFPRWJpU3hJOWNyL2h1?=
 =?iso-2022-jp?B?UUtRajBITG0vZlV2dkUzb3pidDU2YVRCQkFrcDJva2xSWDEvdjQ1dGZp?=
 =?iso-2022-jp?B?czV6QWpSZkFoQVAveEJJRTNMNlc0RVJ1MWtIL29jbDl0ZFhuTG13bENV?=
 =?iso-2022-jp?B?R0xBRWRESit4WjlnRHZibktuQUpOUkpEbFJjSGFndUtITzdMOWJ2d2Ny?=
 =?iso-2022-jp?B?MmxLQzh0WEVPVitMdlZ4d2kxbWN4Mkg0UGdKVXRtQ3FSY1FRMnUwYVla?=
 =?iso-2022-jp?B?VUx2bHd2K0o1Nk5TUm42TEJua2NaY21mRk50UWhZOERSemd4WFd4MEJP?=
 =?iso-2022-jp?B?MUw4Y0tSa0NWV1ljby9GUC9KRFljb004R1JoRmpXZzNmdTlQcVU3THUz?=
 =?iso-2022-jp?B?MCtwM1NGQlhsekc5V3JMenFjbkJIQUlSZlAyYnVtUWN0TytPbHdvSFMx?=
 =?iso-2022-jp?B?K1V2ZkFsa2tpMmN1bE1FNHZIYThyRVpiR2FoUWNjbXpNajg2dSs4dzV1?=
 =?iso-2022-jp?B?eUgzNldxMjZKUDFiMUp0Z1NacEh4QUhaWk9KNUlzNkU2ZnRFbFVJMVkr?=
 =?iso-2022-jp?B?d2I4YTN1UzVJVFdoNzNHU3k4cmlRb3B1NXQ4WmdCUUUwUFcwR3VhemlP?=
 =?iso-2022-jp?B?Vjc1Nm9aeFcwdEpnS0hvUWdpRGpOS0g0ZCt1UWRhM3hBaE1FY3NqZitr?=
 =?iso-2022-jp?B?NjlGZ1BvSVBEWjduQUVuOFpVODhPT08rK3ZCOUdjSnVwaUhMbHYreUg2?=
 =?iso-2022-jp?B?T2hTd1N4VGxaS1dlaG84T1RSNHZ6bFRDWmIyK1oxdGI1R2MyVG9JUUJL?=
 =?iso-2022-jp?B?ZFVKWmxKRC9aUmhrZC9hWm4wM09zNStMUkRFaG9NYlRjSFByUWhLT0Fl?=
 =?iso-2022-jp?B?NnZGUG9raXdEdTI0Q0NKRHJ4N1Y4aGdDZ1ZnZmN0MlpEU2pDSE4zcW1P?=
 =?iso-2022-jp?B?N09WUmxGdkhGcXpsSG1hL1NDb0czdHpBVDU1MEEvZzZ6TjJDdVI4OHFx?=
 =?iso-2022-jp?B?WlhsdlhNVEhsbW1kTThZVXlDTmpSWjUveUFGTENwMFFqZUdYRHFRblVj?=
 =?iso-2022-jp?B?akdZZlA0a0d3b2V3amhTNXlleDhJL0ovcmNnUW5HV2dqUU53SjkwUUlP?=
 =?iso-2022-jp?B?UHJxK2o2alducVdpRkQveEtyKy94d1RKYnNLVHZJVzBNRGwrblRUN0RQ?=
 =?iso-2022-jp?B?ZE4ycTZNT01wWS94QXBBblA4dHpZWnNXUHlsRitOcit6M0pMYTVFV2Rh?=
 =?iso-2022-jp?B?VFVXR0YyWldkL0pldnd4a2Fua2FxbUlxcEpGRUQxRVVkTUJQWjkzajB2?=
 =?iso-2022-jp?B?YkpiaDRRVnBJNXpxMkYyMW15NEVqQmVlUnJYUXh4Z0RUYjRGc0l0V3Rr?=
 =?iso-2022-jp?B?aFFhSVQxOFYraWV0VEFYVENTcTNIamlJVVlXRWQ4VE4rSXRDNFdzNWMz?=
 =?iso-2022-jp?B?ZG5wSisxZ1R1MjBOU3ZiN3d0MVkrVlppWmoydnBFUzlydDNWYUJVdk5y?=
 =?iso-2022-jp?B?Zmp1bVpvcDZLYk5mcEVrVUpLOTBRTCtNNnNnem1ibXVrbEpXYk1hVzkz?=
 =?iso-2022-jp?B?cGs4ajhhTUpHdFFFUWM2RlpWTjJlbHNwUUpFOC9RU09vYWg3Tnp2UDVZ?=
 =?iso-2022-jp?B?OGZzMERoWHZ0VlpBZVJid250SGZETlJ3RXBqSHZiWlc5ald2QzhMRlRO?=
 =?iso-2022-jp?B?dThWMGF2VUZUUjJOQjJLL1FkaUZhYSt6M1VpR0xBV240bjAyS2JTQytJ?=
 =?iso-2022-jp?B?MDFKdmFhWlh5ZlZvV0o0T0pCdFRsYmNuaFVBTTMvRE83YUU2QmZ6NEla?=
 =?iso-2022-jp?B?OGFGaC85VWpsTHBhd0ZhZTBPdnpOUGZWUTRTRG5CSDZmdzZta2xVMDdR?=
 =?iso-2022-jp?B?aC8rL3U1OD0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4600.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d275daea-98a7-471f-cc59-08da1b960c9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2022 08:34:09.6343
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J4cW/oWuRuePfUbW0jhtchO7pbfZoAgIchaEhuh2p3tdm/cT/633SXC9xw+L9RdNmjLzVwjaAvJzXlhfxa3SDuYGdfpcylftqT5bfy8OCSU=
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

> On Fri, Mar 25, 2022 at 01:38:26PM +0900, Shunsuke Nakamura wrote:
>=20
> SNIP
>=20
> > diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c index
> > b17842581dea..db9b7274feb5 100644
> > --- a/tools/lib/perf/evsel.c
> > +++ b/tools/lib/perf/evsel.c
> > @@ -1,4 +1,7 @@
> >  // SPDX-License-Identifier: GPL-2.0
> > +#ifndef _GNU_SOURCE
> > +#define _GNU_SOURCE
> > +#endif
>=20
> I think we can make this global set in Makefile, like we do in perf
>=20
I'll fix it.


Best Regards
Shunsuke
