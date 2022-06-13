Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F2F54A2EE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 01:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236147AbiFMXyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 19:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbiFMXyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 19:54:50 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9138120BD4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 16:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655164488; x=1686700488;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nl7CInBnObAppmP4vkZ6odg5TbVFYMdTNhOUUpsiP9g=;
  b=ZxjsJs9n5vGcOdsSabPEV/2N/y/NbAQ/WnBbSd5pr1p4Hk/rPmPLRiV1
   61/L/+VcTdAtWHHjoSMHmMcbnmHXuDr5HB+gcv10GBrw+N3tgGfEa1z6m
   Fs6Kjv699BPq3khMxbKpWwrDd+Bm4KyclRU2My2sgBJynFY8l9JK3NjPD
   5rWU+oBGiJQiWTNosCsB8XkWbrW4NPam9wCRTr0MqVoXFM2/blyb7Fdg4
   vySNFDpL/cMYqHggRoL2Z5lbLIk1M0POFajeA3f1lUyvO7TPiD3dJsYso
   KFsVwDHjBXRFmOfK3Gf2T54gD7arPmFJdIy1kc+5bPQwTxdGK6VVJvI+8
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="278481501"
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; 
   d="scan'208";a="278481501"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 16:54:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; 
   d="scan'208";a="830070122"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga006.fm.intel.com with ESMTP; 13 Jun 2022 16:54:48 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 13 Jun 2022 16:54:47 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 13 Jun 2022 16:54:47 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 13 Jun 2022 16:54:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k0xKryDP6487wf2lqnriVgdiZnO1a+nR6enyXnvsgfKjiHZXfgws+qouxHRJWa6WBqKfW3br40H/t2tY/vCIxs8eaKhxhOnBg8qMYANhujJxfw4olWgXAuH06RQ0zI0SQaKNLWWDhHgu+1V+Scw/0qFFiBOgQzrenlvPRKYU9iauJiB2ituEMFWmp+g6jgYcQWYd/sUzfPtaLAgXM/Xd9dqcABf56Bb9HKFSuuZu00vyvWkimcKsMLyDfD2fU/vl7diql4NG+yKK9v4MkbNEUhIaebMnB1Rxe3GwkG9KVEK5mN7PHhaQTTfQ24lu06CU7SX65dZNNNKaZ6pwFIBQTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7pRChGGFOdWbqwUz+zEmWqshTAreBOPRjgnybKciMe4=;
 b=eloWxr2DWn75vx6pc/GMzG7txNuqW3rN1fXyP1MduCC+/xnkr6LKkAKwuOdZYjzseVyBcHfwdsGCSvFFje9FgQEiIYtaMYTlyE80nRO+7JBqm0YWzwxA6nEbtQ2TfOMLto3wSGdVeCRO2uNk21j2GTcXzoTV4sN34YLC+/r9KeB2Uta6QosQTGIjUpzKeY5tbs8i6zRhpxCdaM+I3yOZZUEOBkYrXUdDU+avLAYgBxwg5/zN13kXCgQFdVTe6LjM3eRvVkX+J4+d3LRZop+EFTLrAnNrjyAVbfViF7NqleJeOZ+ke8AYC/RrM9ihjNyGQO6XD43uuB5O1oBnmECaIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by MN2PR11MB3696.namprd11.prod.outlook.com (2603:10b6:208:f6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Mon, 13 Jun
 2022 23:54:45 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::a4a9:b58f:8246:5f72]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::a4a9:b58f:8246:5f72%7]) with mapi id 15.20.5332.020; Mon, 13 Jun 2022
 23:54:45 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "Eric W. Biederman" <ebiederm@xmission.com>,
        syzbot <syzbot+9bb26e7c5e8e4fa7e641@syzkaller.appspotmail.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>
Subject: RE: [syzbot] WARNING in exit_tasks_rcu_finish
Thread-Topic: [syzbot] WARNING in exit_tasks_rcu_finish
Thread-Index: AQHYfnKnPcEG5KPSqUKTUzyVmEvcrK1MN1mLgADFmMCAAHlEgIAAboyggAAbjYCAAALO4A==
Date:   Mon, 13 Jun 2022 23:54:45 +0000
Message-ID: <PH0PR11MB58806FA43338A28D72540CB9DAAB9@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <000000000000e2fc3f05e141f930@google.com>
 <87bkux1yn4.fsf@email.froward.int.ebiederm.org>
 <20220612202204.GX1790663@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB588027C1A486FCED7885C500DAAB9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20220613152337.GD1790663@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB5880EB4D4F2B7D91C88BC852DAAB9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20220613233753.GK1790663@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220613233753.GK1790663@paulmck-ThinkPad-P17-Gen-1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.500.17
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 209cd6a5-ceca-404e-e7a3-08da4d9817b7
x-ms-traffictypediagnostic: MN2PR11MB3696:EE_
x-microsoft-antispam-prvs: <MN2PR11MB36965D76B43E332BE940511FDAAB9@MN2PR11MB3696.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7dnJiBKd924hUrG9bXbT62x4P4ZiOI6JH7j5NgfiWpeahyGsljPyvXQ83svdxspwSA3YitF9aqNSVW9IdroCjcecNn/WNAF2V8GNPm2Kpm6PxMCxkbQO74HvDnZ7D69rgMtVJi+46bktYNvbyuCUCJiXM+qqm9LaNaM3OfJbTqtSId4afAvvTNpVSC8iEjMMeeCkohZND1jySnFlCuyM6xRHZ9j8Qo6Q8y1oJAqEkva013OdPpS+dsKpFhWvIKdoT5RC4yzm6NbZ8+v2zug7oPT/uC7enGDkE3BnUIah0Nc4Nh5mbJWvZZ/MH9T3jB8eh+EdKdtDVLdrOtMByHziv9lJ23uf5XdEvilBW1vr8L7ZpqENVJ740W63rbvCRs39bRERl/60u7fa5zk3fzVsOmh1pk1vNWzqz+X4RhWv/F30WfVWTQKBlOit3erS/P92r0yqq4s9ffDSTXw6WTAIuFqThQf+CIyAf84Tfhbw6cqJ30RklXp+Ak60YLBgwOZIrbaMXelAuzij07oiAo0pfsQdv2VwrGivaxttuI+he1ChTwM9kwk2wIFQXHjsM9Ydy0chz6rnrmyYr0PK6sldevfws81kJdgmTxAdKyAqElciADwn4F+FlNScrUu37/p0e2MmpfDeYxXivH/8nkvB9ae6ZBvL9W5WqX9xS7cMKAzG0Lq+yjtX0+SLEsG871quUPnlmM6e969bb6OZZ/Ag48QUOLGdxe66OhBTxMSF9lHyxkeMJVTZNHNuHQ8VNyoat1O1LuzB4OWrYEOxsmW23CciymeMWmpuUXyiUAI9t//imzJ0kzH3CfDpN+vMfVWp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(8936002)(54906003)(66446008)(38070700005)(4326008)(71200400001)(86362001)(2906002)(38100700002)(64756008)(316002)(76116006)(8676002)(966005)(508600001)(55016003)(5660300002)(33656002)(6506007)(26005)(82960400001)(6916009)(9686003)(66946007)(83380400001)(186003)(66556008)(66476007)(7696005)(52536014)(122000001)(99710200001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7Yd0QzYECK7PljPJfMe3YQMCQnuVA62g4do2j+ZzaqXZfPPazFrscyaDBfv7?=
 =?us-ascii?Q?bGmWIvLQKPtFEQJqta+tn3q/7exfpeEQZsBmWokWHZ42JWve9ilw/b7U4JWF?=
 =?us-ascii?Q?TuWibskSk0kprFC8dbwa/xip4jVIwZ2lQ8SHVLlemkiz/AuER7CxTlfGhNvI?=
 =?us-ascii?Q?S5h9F9qZ5P6mpy/uib8bs+nOWMbNRC67SzYjSIOO9sGdXUrUUECdakCuh9Xb?=
 =?us-ascii?Q?czlKXVF0DkqRqBUImRr2vONFkSaaR5nnTHkWiJ6ZN6lUhcT0iTKyV4yGkmEk?=
 =?us-ascii?Q?TGj6N3+mSkerwTS8nM0HXE/CV3Z8zlMBFie/lvBgKDTMOp5breBp+b+vR0+R?=
 =?us-ascii?Q?w7ETpshwb9NUrlNGxLMDGJNv/+kEJpvG/TgK7qR2NuMOwlJXiEHNRfoMmTQP?=
 =?us-ascii?Q?eHXGjX4VZE7lNMbtExqrknfdFBaFfcUoDo8C4mdOdRX3RADJxURjUSsg0Ph0?=
 =?us-ascii?Q?jAW9KRhi3KPaFVd1qMubePhwEcO453xhoRabvZ3AmMBT2QcIiSlweqk6Ci4Z?=
 =?us-ascii?Q?yJRkap9pBoVQW9IU7CBLZ1u8K2TsNRqmr0KA+SWJnBl2zsIjuGRrLc3l3toi?=
 =?us-ascii?Q?0VZTerxYkJ4JzJI6zNOzZlnodSSbEpTxIeDkPk3lzMyw/BDMtQCAmlhCoTD1?=
 =?us-ascii?Q?C6uBMJb3BZdQwgeDjHHq2XjUpWpaJD4sb99RUGFcmMnK+5+u1Fy7CggNxlty?=
 =?us-ascii?Q?rXwd/mzWKOthg4lDOn3TIfT5We21XzsjcgKunouqLQF2RZjnb5X9p7Ie5TKx?=
 =?us-ascii?Q?EbRAHoisSessvr2GA3QveccTSSTKJoTsxFPlN1BmNEnmik/dncodvYYzTfBi?=
 =?us-ascii?Q?g4mvcxB6LryHcu6wl9H8MwBVK5brqiGecJDnYse8eEvBOF5v6L24TtzTqSWV?=
 =?us-ascii?Q?ISYYARv41sA3Jd1fbx3vvOxwJXh8RDwHqqaAnn9C1VEd79bcO2ubamZf9sIw?=
 =?us-ascii?Q?sZ8D3PpQAJYYfqlf6nIqAigFnbn9XrUkrGOjK5yphhjgeBcyGSgJiYxf1GI2?=
 =?us-ascii?Q?vpWD8Q+H8eXQ6jzC0mv2CI5TKONf2EQhI59tn7umEukKH6sf7U/F/kcquaH0?=
 =?us-ascii?Q?Xxe+z6qId2ROxmr6YGXGvdL1hXU6Oc2iSOqbfhr4G72ge0HXZ+iBi03ZJc6i?=
 =?us-ascii?Q?Yc7a9Ml0pWtR0FjQrrdhyJuB2oEf/tzTaldRr/SWnhkBzWd4TnAZCD9aUU52?=
 =?us-ascii?Q?il/R+y8zEugbDSj805i0YmMuwOccR6cjlHSX6i7XObrkxpoIVwaJTqZjPuG3?=
 =?us-ascii?Q?8FuGGCi0hnyFyGEGC0Ozi2A+dsX1tWx7/Ngg6MOPuKXT5r6n7kKuhM1mGvYM?=
 =?us-ascii?Q?mjGR3rujl+4uUuT1ML0XEorpKsL+OSp7hAcT0kcTHGBfy56+d9g1KqpWwQwt?=
 =?us-ascii?Q?2p1P8JuqYmFqs9cIP0u8mpr1BBZyqzWkQwlMxPMnF4pnk3SnOgMwKfEmzTuM?=
 =?us-ascii?Q?ejDJWr9QdsfRdW0P3Q0uRn+WANb1kP9Bq2S6TaJh/zSMc7KtU3fBJ//+bFnV?=
 =?us-ascii?Q?Iu+NFlzdTTl9VtExNEGRtfai9oEOqamEgoezV48ubJgcH4lZy8gb7YaKgRMD?=
 =?us-ascii?Q?YR6bRmft33maM3BtcWa3n5rwhMBnWUs2L5smk4msF+rQci2Ffiqe+/6Yvr7H?=
 =?us-ascii?Q?SiHOXIJtl7ilX6z+2SELxoXzBF55ycek10XQSRB4+/AaNJRN5a848RDSuB8s?=
 =?us-ascii?Q?ZLrvBy0yS6846JbNw38DEmiTYdkdWRwkEkq2+vEj6btWN9ws4dmLtrp59kCe?=
 =?us-ascii?Q?cgfhNqnMZg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 209cd6a5-ceca-404e-e7a3-08da4d9817b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2022 23:54:45.4017
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RQj4D7Y8GEdo0wHoXIHC0vYnV3ZVckQbOXSJcb/JduIEFpu8b7y0mnySpOKtO2dkRlO3JTesrfM91YQkM8aPIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3696
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 10:26:47PM +0000, Zhang, Qiang1 wrote:
> On Mon, Jun 13, 2022 at 01:55:31PM +0000, Zhang, Qiang1 wrote:
> > > syzbot <syzbot+9bb26e7c5e8e4fa7e641@syzkaller.appspotmail.com> writes=
:
> > >=20
> > > > Hello,
> > > >
> > > > syzbot found the following issue on:
> > > >
> > > > HEAD commit:    6d0c80680317 Add linux-next specific files for 2022=
0610
> > > > git tree:       linux-next
> > > > console output:=20
> > > > https://syzkaller.appspot.com/x/log.txt?x=3D13b52c2ff00000
> > > > kernel config: =20
> > > > https://syzkaller.appspot.com/x/.config?x=3Da30d6e3e814e5931
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=3D9bb26e7c5=
e8e4fa7e641
> > > > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU =
Binutils for Debian) 2.35.2
> > > >
> > > > Unfortunately, I don't have any reproducer for this issue yet.
> > >=20
> > > I don't understand what is going on in linux-next=20
> > > kernel/rcu/tasks.h looks different than in Linus's tree.  Paul=20
> > > does that mean you have some staged rcu changes?
> >=20
> > >Less than 100 RCU-related patches in -rcu, so not all that bad. =20
> > >;-)
> > >
> > >But yes, this could possibly be an issue in one of those patches.
> >=20
> > > Eric
> > >=20
> > >=20
> > > > IMPORTANT: if you fix the issue, please add the following tag to th=
e commit:
> > > > Reported-by:=20
> > > > syzbot+9bb26e7c5e8e4fa7e641@syzkaller.appspotmail.com
> > > >
> > > > ------------[ cut here ]------------
> > > > WARNING: CPU: 1 PID: 28639 at kernel/rcu/tasks.h:1664=20
> > > > exit_tasks_rcu_finish_trace kernel/rcu/tasks.h:1664 [inline]
> > > > WARNING: CPU: 1 PID: 28639 at kernel/rcu/tasks.h:1664
> > > > exit_tasks_rcu_finish+0x122/0x1b0 kernel/rcu/tasks.h:1006
> >=20
> > >The usual way for this warning to trigger is for these a task to exit =
while in an RCU Tasks Trace read-side critical section:
> > >
> > >	rcu_read_lock_trace();
> > >	do_something_that_causes_task_exit();
> > >
> >=20
> > Hi Paul, wether the following scenarios be considered
> >=20
> > rcu_read_unlock_trace_special
> >    ->if (trs.b.blocked)
> >        ->raw_spin_lock_irqsave_rcu_node
> >        ->list_del_init(&t->trc_blkd_node)
> >        ->WRITE_ONCE(t->trc_reader_special.b.blocked, false)
> >        ->raw_spin_unlock_irqrestore_rcu_node
> >                      ->Inerrrupt
> >                             ->schedule
> >                                 ->rcu_note_context_switch
> >                                     ->rcu_tasks_trace_qs
> >                                          If (___rttq_nesting && !READ_O=
NCE((t)->trc_reader_special.b.blocked)=20
> >                                                         /*___rttq_nesti=
ng  =3D=3D1    &&  (t)->trc_reader_special.b.blocked =3Dfalse*/
> > 				rcu_tasks_trace_qs_blkd(t)    =20
> >    ->WRITE_ONCE(t->trc_reader_nesting, 0)
> >     .......
> >    -> exit_tasks_rcu_finish
> >=20
> > Whether the following patch can fix it, or what am I missing?
> > Any thoughts?
> >=20
> > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h index
> > f1209ce621c5..c607e4c914d3 100644
> > --- a/kernel/rcu/tasks.h
> > +++ b/kernel/rcu/tasks.h
> > @@ -1247,6 +1247,7 @@ void rcu_read_unlock_trace_special(struct task_st=
ruct *t)
> >         struct rcu_tasks_percpu *rtpcp;
> >         union rcu_special trs;
> >=20
> > +       WRITE_ONCE(t->trc_reader_nesting, 0);
> >         // Open-coded full-word version of rcu_ld_need_qs().
> >         smp_mb(); // Enforce full grace-period ordering.
> >         trs =3D smp_load_acquire(&t->trc_reader_special);
> > @@ -1267,7 +1268,6 @@ void rcu_read_unlock_trace_special(struct task_st=
ruct *t)
> >                 WRITE_ONCE(t->trc_reader_special.b.blocked, false);
> >                 raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
> >         }
> > -       WRITE_ONCE(t->trc_reader_nesting, 0);
> >  }
> >  EXPORT_SYMBOL_GPL(rcu_read_unlock_trace_special);
>=20
> >Thank you for looking into this!
> >
> >You do have what I believe to be the correct failure scenario, but the a=
bove fix would break nested RCU Tasks Trace read-side critical sections.
>=20
> Hi Paul
>=20
> Break nested RCU Tasks Trace read-side critical sections? =20
> Does it mean the following?
>=20
> rcu_read_unlock_trace
>     -> WRITE_ONCE(t->trc_reader_nesting, INT_MIN);
>          /* t->trc_reader_special.s  =3D=3D 0*/
>     -> if (likely(!READ_ONCE(t->trc_reader_special.s)) || nesting)
>           -> Interrupt
>               -> schedule
>                  -> rcu_note_context_switch
>                      -> rcu_tasks_trace_qs
>                               /*___rttq_nesting  =3D=3D INT_MIN    &&  (t=
)->trc_reader_special.b.blocked =3D=3D false*/
>                           ->rcu_tasks_trace_qs_blkd(t)    =20
>              /*nesting =3D=3D 0*/
>          -> WRITE_ONCE(t->trc_reader_nesting, nesting);
>          -> return;
>  .........
>  exit_tasks_rcu_finish
>      trigger Warnings
>=20
> Or where am I misunderstanding?

>I suspect that you do in fact understand it.  Let's walk through the failu=
re scenario again and see.
>
>If that READ_ONCE(t->trc_reader_special.s) return zero as you suggest, and=
 then the interrupt and schedule happen as you suggest, then
>rcu_tasks_trace_qs_blkd() will see a non-zero ->trc_reader_nesting and a z=
ero .b.blocked.  It queues the task, but rcu_read_unlock_trace() won't chec=
k again.  It will set ->trc_reader_nesting to zero and continue.  As you no=
ted, if the task exits in that state, then
>exit_tasks_rcu_finish_trace() will trigger its WARN_ON_ONCE().

I understand the problem you describe, Just like the call flow I described =
above,=20
rcu_read_unlock_trace_special() may not be called.

Thanks
Zqiang
=20
>
>Your change won't affect this because rcu_read_unlock_trace_special() neve=
r gets called.
>
>Hence the approach in the patch below.
>
>Do you see any failure modes given the below patch?

> Thanks
> Zqiang
>=20
> >
> >But would you be willing to try out the patch shown below?
>=20
> I will try to test it.

>Thank you very much!
>
>						Thanx, Paul

> >---------------------------------------------------------------------
> >---
>=20
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h index=20
> 08059d8d4f5a7..937a58b3266bf 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -184,7 +184,7 @@ void rcu_tasks_trace_qs_blkd(struct task_struct *t);
>  		if (likely(!READ_ONCE((t)->trc_reader_special.b.need_qs)) &&	\
>  		    likely(!___rttq_nesting)) {					\
>  			rcu_trc_cmpxchg_need_qs((t), 0,	TRC_NEED_QS_CHECKED);	\
> -		} else if (___rttq_nesting &&					\
> +		} else if (___rttq_nesting && ___rttq_nesting !=3D INT_MIN &&	\
>  			   !READ_ONCE((t)->trc_reader_special.b.blocked)) {	\
>  			rcu_tasks_trace_qs_blkd(t);				\
>  		}								\
> diff --git a/include/linux/rcupdate_trace.h=20
> b/include/linux/rcupdate_trace.h index 6f9c358173989..9bc8cbb33340b=20
> 100644
> --- a/include/linux/rcupdate_trace.h
> +++ b/include/linux/rcupdate_trace.h
> @@ -75,7 +75,7 @@ static inline void rcu_read_unlock_trace(void)
>  	nesting =3D READ_ONCE(t->trc_reader_nesting) - 1;
>  	barrier(); // Critical section before disabling.
>  	// Disable IPI-based setting of .need_qs.
> -	WRITE_ONCE(t->trc_reader_nesting, INT_MIN);
> +	WRITE_ONCE(t->trc_reader_nesting, INT_MIN + nesting);
>  	if (likely(!READ_ONCE(t->trc_reader_special.s)) || nesting) {
>  		WRITE_ONCE(t->trc_reader_nesting, nesting);
>  		return;  // We assume shallow reader nesting.
