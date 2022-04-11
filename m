Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF4E54FB5EE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 10:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343750AbiDKI1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 04:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241583AbiDKI1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 04:27:19 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 11 Apr 2022 01:25:05 PDT
Received: from esa14.fujitsucc.c3s2.iphmx.com (esa14.fujitsucc.c3s2.iphmx.com [68.232.156.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09BAC12740;
        Mon, 11 Apr 2022 01:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1649665506; x=1681201506;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QaBq0wc8OTTVWk4XZtpK2kao44mmh20IrMnjs6a19+o=;
  b=GSkoz/n3R9IjwiZrsxP+vHuNG88ItId5LIdXHP2zaPDfODMriENXD1Dh
   GBFwQQMw/cgDGNrme4gvnddiE7f8rXH0JeYqFZS1Aejul/2jEux3I8CuN
   GT+GSfmSA/rpM9vbb0S5cLOT6uFzJokX/cC0nZnrKF5pd0Hy30lUSnW0K
   rAx8trp+L2fPZke8BkbD73kfpYbdvP2MUSK88sQHz1ltiie3DMdQEtwuC
   HPgRbOO+h8a6xuoLcYTrmUSebSOyF5L/C+85KadgCa1OUV4AlVL+CjDsk
   oF+wwdcXdzbEOY5cgu68cny48qaBPrK/+TRkd6GYJszrUE4+mx/RwMV58
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10313"; a="53489894"
X-IronPort-AV: E=Sophos;i="5.90,251,1643641200"; 
   d="scan'208";a="53489894"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 17:23:58 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WAmSb/z01akzX6AfT3wRau4AATjVkyPENi0IjG1nQHGVcGExAtCesSnmFkpWab2VfterFwedxCBZL5oGMGeeVYwTf1nDZR7Q1q6pJU07+6YzTGNcBLPL2jDHh3Kr3H2Ry0iFbVbEJ0OSg3YSFInnNI/rb4dIOIV72ANf7HCsJVYuZuYhS295rYBVllpcSOqR68ibP99waVwKO/UrQiovxc76mUWkYmP2UTkaomA5OkLFCXXiKV3rbm9Atj6+T74uaRmTpNbGRPotM2evr+GgLQqn9q3MHZ3sIKXFqsvMQXAU2pEOh2yd4gaV59HtyP7g8DzZz52+V305gZgyAeZxYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p6V6PCTdGrCZWgpZgCJwFVXOE5Q5NvzBHjVQVMyrBDc=;
 b=MHsDIOipvimMZKFfLkRJcQkJuBZnZpBtdZxYxZmCptEPT0OftpPspuvCi15DuR4OO04adozuc0EXVIymmJbnsIwgIce2jw3uDPgkdjzbW0LsIUKa+V1HPArkGsBthcwDpwYCRzGnIZ8BHKSTkc/UK6xqNnCEeT/pgoAZrw6smA+LPhBJ1aXTMCLUBddU4RD/huZdhKTqVmx/+vdkHcbcOx/33U/yU46tkpheD/6Y8x9F/p5Fr1UQA5GQxIOCcvEucfeeV20OVSjTKwYNgFxhTyjSCtQYCOTY4NwSyOsxZ/YE38CFTKfca7nawjq4NB2EOF14F7vbT7+NULXg5PjggA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p6V6PCTdGrCZWgpZgCJwFVXOE5Q5NvzBHjVQVMyrBDc=;
 b=mLf69de/3ohXugnoRmKyN7V0sCBzaINzASDnYokXGFB1M5JQCsooQDmjfkRNHJEi0FsMXkLDMcuRSsbMSY5DBXF1DUZ0GW0U8igX6kPedVVNZsHiAl5ceirtky5jF7JKih9begyGGHmH6UOcmY3mutn6Af9kM+lLUXIKK/lMM4M=
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com (2603:1096:604:7e::12)
 by TYCPR01MB8568.jpnprd01.prod.outlook.com (2603:1096:400:138::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 08:23:54 +0000
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::5db:a021:ce3e:8244]) by OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::5db:a021:ce3e:8244%4]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 08:23:54 +0000
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
Subject: RE: [RFC PATCH v2 0/7] libperf: Add interface for overflow check of
 sampling events
Thread-Topic: [RFC PATCH v2 0/7] libperf: Add interface for overflow check of
 sampling events
Thread-Index: AQHYRD0ckzCCT80/f0C9G/z6axerk6zqcc3Q
Date:   Mon, 11 Apr 2022 08:23:54 +0000
Message-ID: <OSBPR01MB460012B9516B2E67CBEEF0B1F7EA9@OSBPR01MB4600.jpnprd01.prod.outlook.com>
References: <20220325043829.224045-1-nakamura.shun@fujitsu.com>
 <YkRgDdI8PKH5C7lV@krava>
In-Reply-To: <YkRgDdI8PKH5C7lV@krava>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a551d39-e61e-4c19-6612-08da1b949deb
x-ms-traffictypediagnostic: TYCPR01MB8568:EE_
x-microsoft-antispam-prvs: <TYCPR01MB8568B2AEF042AC6B8BA2066AF7EA9@TYCPR01MB8568.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MBgcFHJG2X3yrmRQ5jQCynQNXyAHHzBYEdyy/Gv3DatSso4cBGPoBIL2Ud9E2kKPUKJCFjkCkXN2mnhn5cR9/SozPQLA12DVdunrtngBbgbSC8Ey0LUlswTVbhfSFIjDgKlCy0bCn75mi3iSgCUBuofJK3nUS2a8z4+n7MoRr1/Jn5XnSEwPPk4xgAOBExVdJ6xedn1kcNmi89LlQReLrkX/MrWCOF55U2rAjWLmTbbeLkbMnvujd3QU1QLA3cM5Dakm4JAiHrSGvk0MNxXIIhkfY1PZJE0eBVB9n1BqIIO0rnBHPAX5HzyZJDzxzU4IOAhmWIoSuabr6ENT3KCLIPNKNuCzT/ts09WhID2mbO88QniL6Nxy29XZuOI/lm0/5hPWximsDTHuDyKIPflgy2/mGnGfguPaayTsOENkitOBa77AhXb1MyrJGl4ikGSjuS9LceAgrUHojav/RtyPLhDqs7bl4/f0qYkUgm9l2M7amqcafNa4m87j6G1xhtfpAPOsM7Oc7/BEABXaOy7TKSL+pO9gf4ztDIkRh8D9uL1jBpMLakBbm9JFwGDEwhaJauHAilpcofsK2+KOC774Pyk6WeFc9BFE5G2Y7nhbbB05PO1zTiLsHerSrRwIA1cUqkmlhAvNR3tF82q5PlwtCoz9s71xT7+uVgyzwwfD/D8UpJaZwXvCZcwQD1koREHB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB4600.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66446008)(4326008)(122000001)(66946007)(64756008)(8676002)(508600001)(82960400001)(86362001)(38100700002)(9686003)(52536014)(33656002)(8936002)(76116006)(71200400001)(55016003)(54906003)(38070700005)(66476007)(6916009)(66556008)(316002)(2906002)(6506007)(7696005)(7416002)(26005)(83380400001)(186003)(5660300002)(85182001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?cGpTcWZ4UGRrYVU1c0x2NXNuSGZ0QWplbXJrSklwcnlpMzFQOVJsT3Z0?=
 =?iso-2022-jp?B?ME8xOUdDWXRHQ1NodWtEZ1lielhwdktHOE05UGI1b1h4a1FZdlNPL1lH?=
 =?iso-2022-jp?B?T0xSTGkvWHJUOGRBZ2FZcVVJR0RNcDlHQlp2TFpvNm5GSytQY1M0RXha?=
 =?iso-2022-jp?B?dmlBTEJMUjhJZFN0eS80R1hXWEtJYXRNN0VFNjZiSTJDbXliM1hnOU9z?=
 =?iso-2022-jp?B?ditZNzNaWVhSTUFBMU5vK2EwczJmMVo3RUl2TTN5UXBrUzVhMS9uMHBj?=
 =?iso-2022-jp?B?azFOSGNUcUFTMTR6aktTak8rdzZuOGFvZXNJZll2c2pLSmdXc0orWnQ1?=
 =?iso-2022-jp?B?UnM4WUx5SS9MbGZtYTdZQU9XTWFvb0tNZTJYVHJBQXlWZ3FFUkx2M2Ju?=
 =?iso-2022-jp?B?cEIrVHNib3IwNllmM01ib1FtNG9PT3J6eWR0d1g5YUhWUnBWanRSNCtS?=
 =?iso-2022-jp?B?VUdQaXdiTDlDcGh6bG5MVXA4Qm9PakVJUGxUQjBTNVc2TG1nWHZRZXI1?=
 =?iso-2022-jp?B?ZDlFdmg1Tk1XMy95Z2cyN0lkaUdMNW8zZ1l5SHRZRUQvcGZ6WS84VWdG?=
 =?iso-2022-jp?B?MllCT2tDcDlVS1dHZm1IR0dvTkMxS1BiOTR4RGNwdENuaGhRajlPU3c4?=
 =?iso-2022-jp?B?QXUxaHpyOGlZWWxzMHFhYTdaQytrcE5oQWMzM0tnVVM4QWt4Z1daVzB1?=
 =?iso-2022-jp?B?QnJDS0FZVjI2OTFDUU54UXlMK3drdE42ZWZVYkRmNkZLcWZDdUo2djR5?=
 =?iso-2022-jp?B?RkpDbnF4YUdINEpKa3JmYmlTMjJlN0F5b3RsMk5rY2JqSU9Rd1I5ZnRC?=
 =?iso-2022-jp?B?dnBhWnNOcGUvZk15NENrckd3YVAyaGZrNGlVcEI2SHlIVG80RjhiZzJ3?=
 =?iso-2022-jp?B?RWdZLzFNV3NYSlk0VmJyZ3dMb1BFNko5aHhLNHhiOXRCRVFjSUtBWFAv?=
 =?iso-2022-jp?B?eFZkdTB2dVVTd3RTUmd6Q2MyMVZJYmRCV2o0d08rTkZxZnBSQ3lJOXh2?=
 =?iso-2022-jp?B?MEhnVCtWd05DMHFhLzRpcjZ2N010NjFiN2RwYWpXelA2bkFTbllNVVFq?=
 =?iso-2022-jp?B?aWlXZ0EyNGR0TXk0K00rOHNnemlWNGJzV3dTQVVicWtlSkl5NWJHdjFZ?=
 =?iso-2022-jp?B?dlJvK3M2RUtqeVpQamJTQTFBdnM2eks5L0xzaUJ1Zitwb1BNNkZtQThY?=
 =?iso-2022-jp?B?TkUyOVFJMlhFOVZwUXhaTHBXNUVjUVhuVC9kK0cvYWtqQ1N5ZGovSmR4?=
 =?iso-2022-jp?B?YmhVZzBXQWdMVUcrZ0QydmdrUml5aC9YRnFMT0VwMGhnWFpKSnUxdEdC?=
 =?iso-2022-jp?B?anh5cG5FbWZyRnpUWDg4ZEFiVU1rWDNKNEttdUJ4cldTTlVPYVMyNncz?=
 =?iso-2022-jp?B?YnN2eUxDcUpZQ2poRlpXZ3MycXNEcTZyaTlzVHZGZFd2cHIrOG5ra1Er?=
 =?iso-2022-jp?B?eEZIT1g4MzBySUZreXdwZmdpeXh3WnlyY2JtSlQ5bEt4N1RMc3FxeFd3?=
 =?iso-2022-jp?B?dU1pbkVPYTRjTzZlUUMzZHFKeHZJZm91S04zUVhJOGlKZEVUZnBlYnZa?=
 =?iso-2022-jp?B?ci95cnpGTzlKeEswM0NVYUg1bktna2taS1NsNGNGeFdpeEFHZHc3eUlH?=
 =?iso-2022-jp?B?UFY3eDFkNUxWVWVlWDFFNjJjOFNsUktzQ05iUzJmSTlrZjRwWG5XWm0z?=
 =?iso-2022-jp?B?Rng5c1lleldqRExyRlptb2JaYVZ2ZC9kTWtNMGVKZTAxNGVSNWY2VFVs?=
 =?iso-2022-jp?B?SSt3T1N3Y2lTS1BhN25SUHBmcTJCUjcxUDI0VVMwNW9IaGh3OUtiZmlt?=
 =?iso-2022-jp?B?Qy9MTzNOUGhtUmZlNEN3UzJsb0N3SWk5UHdZMjZ1d2JNdjBuVXdjSlh0?=
 =?iso-2022-jp?B?WlZyeUUzVi9ycGZENWxDbUpia2NtS3hpKzgxSGlIZ3luNm5mZEhDSElt?=
 =?iso-2022-jp?B?NXFHUno5R0hPalBzZlEwWmRza0lMeGZXVndYQ0VXQ09BNEJkaFNIUmtG?=
 =?iso-2022-jp?B?Z0ZFaFZ1cFlCYXEzRktoMEdDNEZOYnl2V0Y2R090dDJ0OVM0VFBCNXVj?=
 =?iso-2022-jp?B?ZnYwV0VwT296U3E5TmFQNWlOaTI4MmlRTzZ6QWN1THUyVlErTGg5bjNn?=
 =?iso-2022-jp?B?QWF0STVPYWpHZHhvWVZTRGNqenQxbU1WbnlkWHRvQS96TTdJcENrTXZX?=
 =?iso-2022-jp?B?M0l1Ui9OWDE2bXFjRkpXZlNXMmxwRlB0MlBXdVNFSVI0NmYwdEo4SDdM?=
 =?iso-2022-jp?B?bmdNRDNaTmRUVDRzMXVEVjVmZ1dmOUU0cHJ2b1Mvb3prcHVCSE1rd0Z6?=
 =?iso-2022-jp?B?RG1DaEVWZWpTWkVwa0xMOTNXNHF0QVVxMFMzc2oxbGNSTjRqbDlsYXFy?=
 =?iso-2022-jp?B?NXFGdUFmaWNlYzRFZXArbTNXYjMvdlJvYW8xZkJXTlJVQ1cxSmlPaTI5?=
 =?iso-2022-jp?B?dGd5VWpiMll3bEU2SnNRdHBMUlBZeTNFVnVRQm4rYXlQaTVXd0ltMFBH?=
 =?iso-2022-jp?B?V01nNWM3S0xkeVVBUTk1cC83dnNJTlZxeXByUGg2bTZhYlJCRmNONkNS?=
 =?iso-2022-jp?B?cWtaaEYvRT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4600.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a551d39-e61e-4c19-6612-08da1b949deb
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2022 08:23:54.4125
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: othnXdtOwQdJ5zHKDLh5fqVKNVRD+wcz2PAFDohA5l/NLUtOGUN/3Jfgogb0cyxoklJrE2OXGVIjPBagN2R5ZjfYj1ElUXyNG4foGjXejLM=
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

Sorry for the late reply.

> >
> > Shunsuke Nakamura (7):
> >   libperf tests: Fix typo in the error message
> >   libperf: Move 'open_flags' from tools/perf to evsel::open_flags
> >   libperf: Add perf_evsel__{refresh, period}() functions
> >   libperf: Introduce perf_{evsel, evlist}__open_opt with extensible
> >     struct opts
> >   libperf: Add perf_evsel__check_overflow() functions
> >   libperf test: Add test_stat_overflow()
> >   libperf test: Add test_stat_overflow_event()
>=20
> I'm getting:
>=20
> [root@krava perf]# make tests
> running static:
> - running tests/test-cpumap.c...OK
> - running tests/test-threadmap.c...OK
> - running tests/test-evlist.c...OK
> - running tests/test-evsel.c...FAILED tests/test-evsel.c:286 failed to ov=
erflow
> count FAILED tests/test-evsel.c:286 failed to overflow count
>   FAILED (2)
> FAILED tests/main.c:13 test evsel
> make: *** [Makefile:162: tests] Error 255
>=20
Thanks for telling me.
However, we could not reproduce the test failure in our environment.
Could you please tell me the results of your test with the addition of V=3D=
1?


Best Regards
Shunsuke
