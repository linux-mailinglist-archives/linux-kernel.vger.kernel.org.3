Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3108549B19
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 20:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244752AbiFMSH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 14:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244569AbiFMSHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 14:07:13 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86FA2B27D
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 06:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655128534; x=1686664534;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=C8XbKPtSlM/OlS8JUw+BEhvmk+nlIyzmsxlFug7yrdQ=;
  b=TZt7f0uGi5ZobF0V+zuL7biTlB59Oc3YVsk5WUEsioxqYk4D6BOaUeI6
   6AB9C/JNpBQi9qxHlKOPR7e00DvJPip+meFjG2Owlk2H4FJm3hDFI3lgW
   2MMzn1U7Hc72+Z4LLpp7Ysds158WkBQ7JqJGK0a1hmv9SSq9Ymdj0EXtB
   AmmDgMNa+oBfH8yzjMYQyLtalmqk46gbpvIu1HI+q1KjhJnxOKL71CJPT
   F7VTuyOp1Ktw0xmFxVPDsJLM6jMl0Ir0ZSZ76vX5I0QRjDN/2jbIrgOpO
   au6j5PvCmaGo0kmjxJ9yYo4/K1qslborMTxPvHO2/Tm1kO6gJ/wgNNrGx
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10376"; a="364619591"
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="364619591"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 06:55:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="673308480"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Jun 2022 06:55:34 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 13 Jun 2022 06:55:33 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 13 Jun 2022 06:55:33 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 13 Jun 2022 06:55:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DSVgqQ93v9jPpQp5a1YPFBbgfgz/6yke/QyYbkd6IbRCTEGOj6altrisFZq/WfxlWa2ev3atDfWL0Sbqg4AvLJXiodP1IC9OEC0CdFMDeVNXpPWpaPxFSzLQzijPmiyVPuKpuzb6PhMmlB9AqLSYFDGy8+vVixiX3AbW5pGcLlybCiTSbiVGDOVgOjTKzi5aHiw49qGLWXVusoeX99+WAmgF+iBePq72+YC5yo+LhgRhf0U+tHq6rL9cTo5ECXxgD81I5v9aGGJ7wH/UJVC/TRF60HVHwVTX8u5JCkgXG5L65GpHYZjqcyoXjlTvDvD/wKkVgNCJVBNDIIfwhNaOjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b/O7M2WDq+i1RLmUJZAFkYZpGbTdM66q772IXcdnCnI=;
 b=dfCHOgi0ErbIxN2WeXLPE7TE80M+pLj4JOWhgLatT+gGQUBdVul7/ye1tb0ZdgaxkqWdSp/QiWEmp1o+p2D1B4dJt6y/8Ix8qUNKWasZMRevnwya4YlF58ylbIWbtNnyhE90ACW3jPRdRLtKxUcPxWZIT+lShlZVB717RJPcZnap55sOZFjj88h8Dvp5iM17L3Rsd01TsUPzlD6iRzAMAUcwnpCUahgQIUqW4LaAtYGBzSjg9ApjcCTrAG+/dckA9ES3YrcDLxj6kJ8us8P0TnJay+HARS7JPP/dW1mHC8mIVSCNCNGvOlEYsA32UWnhzYyfNXwCmHmN538uJF+Gtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by DM5PR11MB1658.namprd11.prod.outlook.com (2603:10b6:4:8::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.16; Mon, 13 Jun 2022 13:55:31 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::a4a9:b58f:8246:5f72]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::a4a9:b58f:8246:5f72%7]) with mapi id 15.20.5332.020; Mon, 13 Jun 2022
 13:55:31 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
CC:     syzbot <syzbot+9bb26e7c5e8e4fa7e641@syzkaller.appspotmail.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>
Subject: RE: [syzbot] WARNING in exit_tasks_rcu_finish
Thread-Topic: [syzbot] WARNING in exit_tasks_rcu_finish
Thread-Index: AQHYfnKnPcEG5KPSqUKTUzyVmEvcrK1MN1mLgADFmMA=
Date:   Mon, 13 Jun 2022 13:55:31 +0000
Message-ID: <PH0PR11MB588027C1A486FCED7885C500DAAB9@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <000000000000e2fc3f05e141f930@google.com>
 <87bkux1yn4.fsf@email.froward.int.ebiederm.org>
 <20220612202204.GX1790663@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220612202204.GX1790663@paulmck-ThinkPad-P17-Gen-1>
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
x-ms-office365-filtering-correlation-id: 1d8cc3cc-724e-4be0-6a6c-08da4d446160
x-ms-traffictypediagnostic: DM5PR11MB1658:EE_
x-microsoft-antispam-prvs: <DM5PR11MB1658C8B67B89DBB53D189CDBDAAB9@DM5PR11MB1658.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tM9gVZmOG22OI/0sUVrJ4AwbVXBFM3MvDvrcDIaZq28XPKHsfbmk7d0LIsrCr9DtV9tfn8g8rMJLX9yfP4673bz0oHfZSD44GfK6Hbc97StOCO81KtZmKUPXz/Uk9Q2eh5cmZu58XrLnxgt4bg9qv6o/OUO+ThZKrSrLxd0LvPmjjdnzQUhQERn5e2n0scb+8K+IGHoTjm2RWA9tehTqsB2hXeN+KGlUhfqmz919ZzQmCs0I71Jg7nR9nRhB9WyFCZCakQhklkQ1LCgKylY5fzk/QB8Q+0uDs8/MbFCtxGaUho67zoSZftVmSROy2DlI5GnFLQem7vQEsE5z8DyEMMVc0aXwnUj/HI/DIxiIO/UEGzXnVp5FjvLNOzASXYkXpbyCgjh9boSDNcQ7Z56/ozdNV0iWg2XmLUmDuT3vyJFA1546sdrb6ZJhoGsRHXCPRf0wQvB8BJ/UYis9rHnH8XPg0fncKGklo2pzbMHYBHNiWOSnMrSqQs4y3bfbIc/r8ui3cNOY49LE/Of59wyqJq1cEoUyiyvjxfBYTseypviPZtsRo6tq/TLfT34IcSvYt16z0WDoTc3PM1UhS1yHvRwEDMb53PlogjBrYDHTEwgoFPRIzv+cW020bIxnPy4KCfDlK/Zkqr5Mk6a8AdEM/ap7PKBf5T3KmQEH0T/uR050uZ94Iu9pbG/c29SeCT8av643dPSiTW06tSxIs2ZwbBMCotLAwaCXEp7yznl40/CKlt5TNEy6aBSKDk+xfObe04YO/nrODvuowa4vGb6oQmcSsyr9q3EC8XaMb/hURfxai88JBp8uHQ/aq9Tt3sI38POcomTF26ypQGicx7lj0RJW/K+YWdAk5UD1XZnV0mI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(6506007)(7696005)(45080400002)(186003)(38070700005)(26005)(76116006)(508600001)(9686003)(38100700002)(83380400001)(82960400001)(122000001)(5660300002)(64756008)(86362001)(33656002)(66446008)(8676002)(4326008)(55016003)(966005)(316002)(2906002)(66476007)(66556008)(71200400001)(110136005)(8936002)(66946007)(54906003)(52536014)(99710200001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?J2S27FJ5EAxZVwdYkevvTrI3R90td68/m0NbWuYmBb374lOYCk0vmdXjTToF?=
 =?us-ascii?Q?6RIMyJaed1dx4nThLcGoX3S3K2VeFeC/XihEWBSP0vlIpN6gE7xZZ7kV593t?=
 =?us-ascii?Q?rF0uZHi75HaB52DqY2AE02AqnEZLH8/T5gvh1aEf6lsZs4CYwvuhu1JfzT8z?=
 =?us-ascii?Q?MDZaVaBVJSDHSjcwI77Chr5i8qXMWXvrwrIo2lXqkynv57w3gR8QKxCJkGqR?=
 =?us-ascii?Q?7K01nhPUC8Fiqlx/F8ql4bbm/pb0HVjuD0r0ASalLfs38mVXLphoPJCdrQ1Y?=
 =?us-ascii?Q?zRerJ348lw5qA7niDwd3lJfjMlV6Dku/S61B75HptJzYKni4xi3+QgT4NtI9?=
 =?us-ascii?Q?Rdnr6C9bcBRvlA4pCPU8XJIb01AeFgYijXDrsKHaadwQ80O+Rusyr6Sb2vop?=
 =?us-ascii?Q?BNLo2qxX8iEGZTaOAgP8Tqedk9HNOQTNHziiDGD75jqAK3A+SjleofHVFn1d?=
 =?us-ascii?Q?0oiMc4iKK7sy1BNQnVRcxxg6BvAWFjuxDJ9XvBg8unxZCuT4PpWB5SixhDsk?=
 =?us-ascii?Q?xXAX6e6t2uhWGibl25KbwiR1ET5bu2b3me7rkoVfjRf0eeQ8KhVzjRyOiG/u?=
 =?us-ascii?Q?irPJWwfDo2WWg7wv19TsODgmKio1UBgI0pGnwk5zq4rpVPZ3ceMtF6naDDuL?=
 =?us-ascii?Q?cClEwumPcPenqaTE+QWZPVxJ+XC0gm4fyXYePth4rs97Tby2rIjLRqpQ1yie?=
 =?us-ascii?Q?pvhh1fQGdZgLbpeY4AB5O0/tFdVuGCGfp8GOLPwrKWfBUtA9MVu4JcsMsOP+?=
 =?us-ascii?Q?JTBXlFmo0Ucq+BN/TCuX5q4W7DcxwpBnCCyhq4cMoRNKjb9DCoLQpwn3TOPV?=
 =?us-ascii?Q?TDIO6QU+k9f9fj/DnR6RK1ypAgXumFoZYGYajXT08cP3tsQrmyHsL2mab6nC?=
 =?us-ascii?Q?wPCbySRrHOswOUy9pQS0pzOyD7DlJjnnr+n+6SpfGULAgINZKLt4KIEPakSI?=
 =?us-ascii?Q?Ki6CvelcYNnbcZQF9g47ZK3FUxRiLSB3M468EuvA58x5v7TSolpe2zUWbPow?=
 =?us-ascii?Q?NGHvVQBWk67H2YGbTZwJc6kYXr0OuDJn4Fm84uL50ecsfETb6D3hHXE/akiJ?=
 =?us-ascii?Q?pc4P2FT+DLM/KrXVo5VJKxe8gq3T8BTgP8ReEGpMnMbfJdCu1LkzqKnGZI9P?=
 =?us-ascii?Q?OySonerNePzGDWR0lXBQlT/djSNJX53Fp8EeYNmNWx1fokwLzch59yzGCxYJ?=
 =?us-ascii?Q?gghjJuV33/C8DeUpKSEe50Zy13UJgyP4W2C/Y6Zr4yiJK21Pr+x0O3fZbkEI?=
 =?us-ascii?Q?8CRupRxwX15t/UUzc30VwXPDyNSwtAXNStDrubYnvC6ry52eMFIKKn9hTfyl?=
 =?us-ascii?Q?mvhycrcJn9z4jhpmsaRiMnjzJBT29R6v+ROAvXGfp0aUKyxc7ePGFG226MXW?=
 =?us-ascii?Q?onoevhrL4nVt/ZFNtB3Kzw35A9jtS7NgS42170+NZ5eLJZajxBuZsWQlwpEz?=
 =?us-ascii?Q?jv8tPg5JGUnca3QGa9JcFiJ42UPrFAgucKpCACW6nYj098Ztsh8K5S7rLRuN?=
 =?us-ascii?Q?sn8LIVinJb45zGgLMC0fD9TijSjfEPnXfQqTLuM/dbsoYeCvj18JN92bbNOw?=
 =?us-ascii?Q?kMGuLN0FrZS7+pt8/v5mVMucF1UTvtQQHV6TigNwWvmm96XRNqINJTOpVgxp?=
 =?us-ascii?Q?29H0ABTPjO2kbuiieVwAZy2ufBy/u7D8A1NYzG0igRuVbLzndZBAPmn+beb0?=
 =?us-ascii?Q?IxyqBXYyJY08d/YIoDSflBPJyp0r3G8IDLYaWQEsJYz4O21RX+Cp9xxB4OqV?=
 =?us-ascii?Q?I81KLabSNg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d8cc3cc-724e-4be0-6a6c-08da4d446160
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2022 13:55:31.2701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VL3noW0NVD2Ir9OjiRbtPidqGXsDSQykxGahBN41A4/+++mGQULpNDmX8Wz0T7PQ7A6MVPzurYzPXN90430rAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1658
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> syzbot <syzbot+9bb26e7c5e8e4fa7e641@syzkaller.appspotmail.com> writes:
>=20
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    6d0c80680317 Add linux-next specific files for 20220610
> > git tree:       linux-next
> > console output:=20
> > https://syzkaller.appspot.com/x/log.txt?x=3D13b52c2ff00000
> > kernel config: =20
> > https://syzkaller.appspot.com/x/.config?x=3Da30d6e3e814e5931
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D9bb26e7c5e8e4=
fa7e641
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binu=
tils for Debian) 2.35.2
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
>=20
> I don't understand what is going on in linux-next kernel/rcu/tasks.h=20
> looks different than in Linus's tree.  Paul does that mean you have=20
> some staged rcu changes?

>Less than 100 RCU-related patches in -rcu, so not all that bad.  ;-)
>
>But yes, this could possibly be an issue in one of those patches.

> Eric
>=20
>=20
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+9bb26e7c5e8e4fa7e641@syzkaller.appspotmail.com
> >
> > ------------[ cut here ]------------
> > WARNING: CPU: 1 PID: 28639 at kernel/rcu/tasks.h:1664=20
> > exit_tasks_rcu_finish_trace kernel/rcu/tasks.h:1664 [inline]
> > WARNING: CPU: 1 PID: 28639 at kernel/rcu/tasks.h:1664=20
> > exit_tasks_rcu_finish+0x122/0x1b0 kernel/rcu/tasks.h:1006

>The usual way for this warning to trigger is for these a task to exit whil=
e in an RCU Tasks Trace read-side critical section:
>
>	rcu_read_lock_trace();
>	do_something_that_causes_task_exit();
>

Hi Paul, wether the following scenarios be considered

rcu_read_unlock_trace_special
   ->if (trs.b.blocked)
       ->raw_spin_lock_irqsave_rcu_node
       ->list_del_init(&t->trc_blkd_node)
       ->WRITE_ONCE(t->trc_reader_special.b.blocked, false)
       ->raw_spin_unlock_irqrestore_rcu_node
                     ->Inerrrupt
                            ->schedule
                                ->rcu_note_context_switch
                                    ->rcu_tasks_trace_qs
                                         If (___rttq_nesting && !READ_ONCE(=
(t)->trc_reader_special.b.blocked)=20
                                                        /*___rttq_nesting  =
=3D=3D1    &&  (t)->trc_reader_special.b.blocked =3Dfalse*/
				rcu_tasks_trace_qs_blkd(t)    =20
   ->WRITE_ONCE(t->trc_reader_nesting, 0)
    .......
   -> exit_tasks_rcu_finish

Whether the following patch can fix it, or what am I missing?
Any thoughts?

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index f1209ce621c5..c607e4c914d3 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1247,6 +1247,7 @@ void rcu_read_unlock_trace_special(struct task_struct=
 *t)
        struct rcu_tasks_percpu *rtpcp;
        union rcu_special trs;

+       WRITE_ONCE(t->trc_reader_nesting, 0);
        // Open-coded full-word version of rcu_ld_need_qs().
        smp_mb(); // Enforce full grace-period ordering.
        trs =3D smp_load_acquire(&t->trc_reader_special);
@@ -1267,7 +1268,6 @@ void rcu_read_unlock_trace_special(struct task_struct=
 *t)
                WRITE_ONCE(t->trc_reader_special.b.blocked, false);
                raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
        }
-       WRITE_ONCE(t->trc_reader_nesting, 0);
 }
 EXPORT_SYMBOL_GPL(rcu_read_unlock_trace_special);



Thanks
Zqiang

> > Modules linked in:
> > CPU: 1 PID: 28639 Comm: syz-executor.3 Not tainted=20
> > 5.19.0-rc1-next-20220610-syzkaller #0 Hardware name: Google Google=20
> > Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > RIP: 0010:exit_tasks_rcu_finish_trace kernel/rcu/tasks.h:1664=20
> > [inline]
> > RIP: 0010:exit_tasks_rcu_finish+0x122/0x1b0 kernel/rcu/tasks.h:1006
> > Code: fc ff df 48 89 fa 48 c1 ea 03 0f b6 04 02 48 89 fa 83 e2 07 38=20
> > d0 7f 04 84 c0 75 62 0f b6 85 89 04 00 00 83 e0 01 08 d8 74 0e <0f>=20
> > 0b 5b 48 89 ef 5d 41 5c e9 00 d2 ff ff 48 b8 00 00 00 00 00 fc
> > RSP: 0018:ffffc9000a497b58 EFLAGS: 00010202
> > RAX: 0000000000000001 RBX: 0000000000000201 RCX: 1ffff11004213b89
> > RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff88802109dc49
> > RBP: ffff88802109d7c0 R08: 0000000000000005 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000001 R12: ffff88802109dc40
> > R13: dffffc0000000000 R14: ffff88802109d7c0 R15: ffff88802109ddd0
> > FS:  0000000000000000(0000) GS:ffff8880b9b00000(0000)=20
> > knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007f771379d090 CR3: 0000000051fd2000 CR4: 00000000003506e0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400=20
> > Call Trace:
> >  <TASK>
> >  do_exit+0x18f2/0x2a00 kernel/exit.c:844
> >  do_group_exit+0xd2/0x2f0 kernel/exit.c:925
> >  get_signal+0x2542/0x2600 kernel/signal.c:2857
>
>And in this case, the do_something_that_causes_task_exit() might be recept=
ion of a fatal signal...
>
> >  arch_do_signal_or_restart+0x82/0x2300 arch/x86/kernel/signal.c:869 =20
> > exit_to_user_mode_loop kernel/entry/common.c:166 [inline]
> >  exit_to_user_mode_prepare+0x15f/0x250 kernel/entry/common.c:201 =20
> > __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
> >  syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:294

>...but it is also impolite to exit to usermode while in an RCU Tasks read-=
side critical section.
>
>It looks like this kernel was built with CONFIG_PROVE_LOCKING=3Dy, which s=
hould have complained if someone was exiting to userspace while in an RCU T=
asks Trace read-side critical section.
>
>So, was there tracing of any kind in use during this test?
>
>							Thanx, Paul
>
> >  do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
> >  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> > RIP: 0033:0x7f7713689109
> > Code: Unable to access opcode bytes at RIP 0x7f77136890df.
> > RSP: 002b:00007f77125fe218 EFLAGS: 00000246 ORIG_RAX:=20
> > 00000000000000ca
> > RAX: 0000000000000001 RBX: 00007f771379bf68 RCX: 00007f7713689109
> > RDX: 00000000000f4240 RSI: 0000000000000081 RDI: 00007f771379bf6c
> > RBP: 00007f771379bf60 R08: 00007fff2278d080 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 00007f771379bf6c
> > R13: 00007fff22724c8f R14: 00007f77125fe300 R15: 0000000000022000 =20
> > </TASK>
> >
> >
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
