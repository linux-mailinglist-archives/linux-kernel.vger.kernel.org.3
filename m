Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CED751009C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 16:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244649AbiDZOlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 10:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiDZOlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 10:41:31 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5063017E237;
        Tue, 26 Apr 2022 07:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650983903; x=1682519903;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=14yHVXqcqrje3rs1NKf1Yn65ycn1yHcDDp+EJGlJkqg=;
  b=FHwQhPqPjXRaY2iceKWQjx/G4e+E+3OVKrF3/j8s/j5S9UEATZUCj5iS
   4QvtcwS0klqH1NDZNM9BEAoceRFrX0WZjH+dQWqRht2TnR3Jzpo77E9uA
   vN10wE0OrSKGQ6xUspnHxxOHy5SADD0aEuQRhEYSJMmxfX/CsOhOYC/ji
   bUq+jjLTZQYCCWXoQN4fOQhfuzmun8b0zx8LMI6YnmS14s37PHPiF8yXA
   0yTVdJidKAVavPSVY1tUDW2vFFEEzI+dQiMxuSMs36VBILwxDHLI3PiEH
   giXZGYTC6Eszbr5dZq17xqMS8rBOaxAh7/5J20cuHKr9I6V0G7+knF/Fz
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="265761009"
X-IronPort-AV: E=Sophos;i="5.90,291,1643702400"; 
   d="scan'208";a="265761009"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 07:38:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,291,1643702400"; 
   d="scan'208";a="538816565"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga002.jf.intel.com with ESMTP; 26 Apr 2022 07:38:22 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 26 Apr 2022 07:38:22 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 26 Apr 2022 07:38:22 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 26 Apr 2022 07:38:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T3C/mxvIxhi71hNhV6qjmQGPxHahmRWPBnWQjVJPSldXTq5I2QGjhZkG9DcDKH6lfKmacxL5aRjy4AS2lDa37y9OiWtsR6589P3sJe+Pg7rTiEDE14qchzOdYs+fFHpk7vL/M4v8it54zM1CpidFJjFj40+Ri0XzIQ7h/3QDZIAwHDOXGZODwpJhv5+dtBBLyjl5Nj7m/VAFvtaGxyvBJks9kjZ3dbtYujAkXmJJpw4ioSVXTBh9KggmC5HYNwPc2wnP9oU/3TBd3FkoYSc1JvZA0o2Q7Tk8yI8AEXH3FeQHEatzXcZuTzc8Gt3Sx/orxkJa067VB6tHQJpg10A2lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nMMAuXKKwh3GfPItmC9vQvEMkFbSHKyjORzdKPh5FnM=;
 b=iGZMnkLgtTi+vMgWXQyH20kXB+JaXvag/Q4OL4zfJqEvKLSZhiELjE1EQzCYOcb7/mlD/mjV64RGhWgjOXjo9HsHciE3WL3FFJflQ9uXS7BgFiLyurTodOanPWPh6dcYDr2RuOuyXKRkg9qSKPCf5F5yXVsjo6i92VRlmxMZHa8xSxvMShpj5cCUn6m+a/RVr3M48412fOceLyXt3NyrKrQC6zEg6cpUkpnKLGa3iWXNwLDuio3GS/kG3QhWOcKSJB5tAkVFmC9wOOpsDy6fdcIF6OT/6Tcz1VwqF+g83LEWq/f1Z3h4BKA1jV9Oh27REs0rBIEBjKrTFvBKh4T0vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by BL1PR11MB5253.namprd11.prod.outlook.com (2603:10b6:208:310::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Tue, 26 Apr
 2022 14:38:20 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::c579:f1c1:28b3:610f]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::c579:f1c1:28b3:610f%8]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 14:38:20 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4] rcu: Dump all rcuc kthreads status for CPUs that not
 report quiescent state
Thread-Topic: [PATCH v4] rcu: Dump all rcuc kthreads status for CPUs that not
 report quiescent state
Thread-Index: AQHYWEB6oQO0A/rD6EKnXzafiZz6Ja0Axn6AgAD56rCAAHfHAIAADPZQ
Date:   Tue, 26 Apr 2022 14:38:20 +0000
Message-ID: <PH0PR11MB588050E2A88BE7CEE6F8634DDAFB9@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20220425010404.3249118-1-qiang1.zhang@intel.com>
 <20220425154533.GT4285@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB5880A72D33DCB9CDC22DED19DAFB9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20220426134844.GC4285@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220426134844.GC4285@paulmck-ThinkPad-P17-Gen-1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.401.20
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3b7ba01b-9c97-440d-9967-08da279268c1
x-ms-traffictypediagnostic: BL1PR11MB5253:EE_
x-microsoft-antispam-prvs: <BL1PR11MB5253455987AF5AD240CEBE2FDAFB9@BL1PR11MB5253.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M2AdSoj0DWJkd+FRxS69GkU3c6+pfhm74vKZnq6fEntZ4zwBIo6jWcL3U02IWarVk6Xg+frMxgly+jWvfJm9ZifPiDSWZvzk2m5KbhtBCZ6tz+lk8YcxAvGV2lrmHkZep2kLSLZ+5ke39eoBZB3QXRfieYpIkrdKZs5oJFSHMXb40jppRh4BBKeOuB08veWloQ4YvGO8jZwi254nl6lVFikSajhx5l9CHt7r6KpLEAbNykGlO7y3YVxFloAjhju4NVh2mKoyzT8VPuxDvEtyVWpnnDGImxqzZnk5q3VHv+jLudPw2xPgIQuWr8lAbYFiSCUg6EvMKSFXWVLxue3bKr5bt1eS6h4HgE4lPi55zSaEUhsmEfhsCR1jrofyo4xmlkw3teWh41Tqm8UD830VOAhn0tjPjq3IEQyRADVsG7AxAEGCDCv2Ttlmo3fZpTcnejcpGRX6N+tEzW2t/OKrQXNCO2W8t2RWyAPgFNrjp+LLFvIl+ydnzY3cmsKSBY+KvVMGeoPaKkLv8z63Pvd75srKMb8nWyUTymDIbiTce1OX3cwB3H8+5mImj4l6awNsWRsUUSfU0yG9hNrSdATjnW9jGSIekn2r0jihVjGytmZQg2dsh27BBpByNh6mrC2OhxbHrZ3s3ZGUZKfqJ/0bKimm8ac9kuydGs0Oo1D68RuIuiWh7eCQBes6fbTrj7MeV70eIr+nFxJv2xwtqN+StbfaeipYg1jr3TcT0Y4UlE87j3dNCw7KAp9V2ZilVa78G+bZO0tBaHkqoc30ONAO0IvvL9RV2ZKQxMCJ8CeFMRA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(54906003)(186003)(71200400001)(66574015)(76116006)(55016003)(5660300002)(66556008)(66446008)(64756008)(66476007)(33656002)(6506007)(9686003)(7696005)(26005)(83380400001)(6916009)(316002)(66946007)(8676002)(52536014)(4326008)(8936002)(508600001)(122000001)(2906002)(38070700005)(38100700002)(86362001)(966005)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WagwixSJxpHtRaGtFf24ZuQWqABN24VUWsVQVVKolACLMhK4Ki6ShfgGhyDv?=
 =?us-ascii?Q?TZma18apG2PukBZPgSP8TAHjOHEM4fdGG8o+GCblK4x8CMkf4bOaklZayi1H?=
 =?us-ascii?Q?GFewZTMzTM2F9sAg3r9jEwJaJhrcjpIwnqDw5Z3d5rjBCGjibQ1RihkTzhGj?=
 =?us-ascii?Q?QIep8k/eSi7zzETkHVjJUu+3vtMTEb4LQXqpalc+VYOpw43uvG5Hgr/vw8Uw?=
 =?us-ascii?Q?3+e4WEkmLzG4pem/isKOf504rn3PHv83g3L6WCmAANvYQwpGjxeSixU/z+U7?=
 =?us-ascii?Q?gIngn4KxHi1gcvAa9TzLfnFo75uEKF/gyG4Lr074IkCom8hkOPwcUagDq0DS?=
 =?us-ascii?Q?4hpQpwT/mToGDiBWSnkHgq65F/9cXWi4vj9OYEQpe27RgBovenZibNKQLPVS?=
 =?us-ascii?Q?y8ktVFRVKcvKCHamEpiNYokJ0BaefCrE7OLKm7SOfLF9fIQsdiu2H7INPHab?=
 =?us-ascii?Q?bbhDEgTO3YZDlbelzUvEAGnoupv5i7yGBghNlu8eK6sK+voPDEMQ32wHPTTx?=
 =?us-ascii?Q?j0gRUS7881rTJd7kKn2mI7Zn/Bkl60/lfxnL/12beFHw2xzWBcPjtqTNzlxK?=
 =?us-ascii?Q?bCuz4LhKLWFCMLdIzqMV9MdPCpVQWaYoDMSUn0kf2DmrNSnYGC5VXJ8MwsmU?=
 =?us-ascii?Q?GjeH4lJFYwMce48B4gY87K+p/kh+Yqdeli+RLMdYaKXUygC34ynINSpPbVNa?=
 =?us-ascii?Q?R7NLY5b4+mdonLzjjhvKbuiZ0nzY3E9SBTjFpsqI2nU5oK71JUu3uyOsrSkT?=
 =?us-ascii?Q?GxD0eU/76Lrx2XoT9IN4aOtrY/yzkHZD2nMt92IwSpXOY3fjQXPfNn0iOMt6?=
 =?us-ascii?Q?L/JDO2Et/xhWytjRkf/Ivi01HJQgn+lvs+RYNqP08C92LFKdArUTpY/AJiyL?=
 =?us-ascii?Q?SgEBZZSp43dElmB0Lm0FsFxPpVSPEmY3UORCHURN9+vIAdwESHCWNvW+C/Ap?=
 =?us-ascii?Q?Z/95u1EBXMpKmvtTWrxOJeRQ+10htYCKBy4theYupaCY9y0LEnWy62QONBTH?=
 =?us-ascii?Q?XrUmeLoH7dkVIHcAHi60425RQuff8DtHNTqOLV8YRMirdIaqkvMYrY0hZqFS?=
 =?us-ascii?Q?TSVPE3krcjLMdQFDZPjEoCA95GsgU8hKHte0tSGZSyJUMm2j1eAIM62NUPA7?=
 =?us-ascii?Q?CbskPT3SFh153U3SWknc+8coxsUKRwttFSTar9gqS+Cyp1VTulE0FUdkOrls?=
 =?us-ascii?Q?780+APnWksXlszNHqHWO7L9TI+QDfPMWA3eDT4bZQTJQyU4aIFnRnQ0vYfby?=
 =?us-ascii?Q?Z8hIWlf+52Z5syaqGK0Z5PAJrMH664nYmloEJQH0pfqcKhM4DxAeqkqRf1hn?=
 =?us-ascii?Q?OxZP05rQad9o5Vjb/ZsDQht2gBxo/j4SIk3LqIsmQyDih4TK1XlDwC4Dzkct?=
 =?us-ascii?Q?rDIlqDA+/01HrdDwJIPSg++4Oq/9lSaT5unakLYqi7UsonG7sWDyhq2gTxWz?=
 =?us-ascii?Q?e6+0SRHmVUT1HeYEM+0ojPb6oesJN8C5PpW6Ndpk+MxuHQ28VZ1zdVwG9YHF?=
 =?us-ascii?Q?flvnEh39oAnzFqSJWR8czOkWprFypzAhYMfCHhijC0BJV3fJ2TnmODxBf7kc?=
 =?us-ascii?Q?QCflrOJyoMv/YTJAv8lTVsjEOmZB3y+BrJ7g/9tFfeNy11BNpc04fY/K98dM?=
 =?us-ascii?Q?/8W9ROxiPiCS5mVTpyKOxKI0qiMXgLm+j1+qUyEV1yFE6Om/PA5NzbQiwia5?=
 =?us-ascii?Q?s3BHM4rKoRle0Nc0gikwBzebllLMiYs7YlBZFhqdFyqFU3Y9X+GGBiu/aX34?=
 =?us-ascii?Q?+nc8UuVjAA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b7ba01b-9c97-440d-9967-08da279268c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 14:38:20.2104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sNl2NY+0ADWc5eofJdAQMSFd0iXsqybrSDfl115w6FHDdcS30oQN1sSGRF1qclRiGEBPpGFzde8jfyTa8wU7zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5253
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, Apr 26, 2022 at 06:44:46AM +0000, Zhang, Qiang1 wrote:
>=20
> On Mon, Apr 25, 2022 at 09:04:04AM +0800, Zqiang wrote:
> > If the rcutree.use_softirq is configured, when RCU Stall event=20
> > happened, dump status of all rcuc kthreads who due to starvation=20
> > prevented grace period ends on CPUs that not report quiescent state.
> >=20
> > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> > ---
> >  v1->v2:
> >  rework rcuc_kthread_dump function
> >  v2->v3:
> >  merge this rcuc-stalled information into print_cpu_stall_info()
> >  v3->v4:
> >  print rcuc info only when rcuc kthread is starved
> >=20
> >  kernel/rcu/tree_stall.h | 49
> > ++++++++++++++++++-----------------------
> >  1 file changed, 21 insertions(+), 28 deletions(-)
>=20
> >I have queued this for testing and further review, thank you!
> >
> >I did the usual wordsmithing, plus I got rid of a couple of space charac=
ters that are extraneous in the common case (one of yours and one pre-exist=
ing instance).
> >
> >Could you please generate an actual stall of this type?  You might need =
to add a delay to the rcuc code, but other than that, please see the rcutor=
ture blog series [1] and in particular the post on forcing stall warnings [=
2].
> >
> >							Thanx, Paul
> >
> >[1] https://paulmck.livejournal.com/61432.html
> >[2] https://paulmck.livejournal.com/58077.html
>=20
> I followed the instructions, add " rcutorture.stall_cpu=3D22=20
> rcutorture.fwd_progress=3D0"  and " rcutree.use_softirq=3D0"to bootargs, =
can trigger  RCU CPU stall warning:
>=20
> root@qemux86-64:/# dmesg
> [   37.556435] rcu: INFO: rcu_preempt self-detected stall on CPU
> [   37.556437] rcu:     3-....: (1 GPs behind) idle=3D269/1/0x40000000000=
00000 softirq=3D0/0 fqs=3D5631 rcuc=3D26004 jiffies(starved)
> [   37.556440]  (t=3D26000 jiffies g=3D3589 q=3D35403)
> [   37.556441] NMI backtrace for cpu 3
> [   37.556442] CPU: 3 PID: 117 Comm: rcu_torture_sta Tainted: G          =
   L    5.17.0-yoctodev-standard #16 7fe7533e7466875b0801ac148f921afcf57d38=
bc
> [   37.556443] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS r=
el-1.15.0-0-g2dd4b9b3f840-prebuilt.qemu.org 04/01/2014
> [   37.556444] Call Trace:
> [   37.556445]  <IRQ>
> [   37.556446]  dump_stack_lvl+0x5b/0x82
> [   37.556449]  dump_stack+0x10/0x12
> [   37.556451]  nmi_cpu_backtrace.cold+0x32/0x8a
> [   37.556452]  ? lapic_can_unplug_cpu+0x80/0x80
> [   37.556454]  nmi_trigger_cpumask_backtrace+0xce/0xe0
> [   37.556456]  arch_trigger_cpumask_backtrace+0x19/0x20
> [   37.556458]  rcu_dump_cpu_stacks+0xcd/0x140
> [   37.556460]  rcu_sched_clock_irq.cold+0x7a/0x3ba
> [   37.556463]  ? debug_smp_processor_id+0x17/0x20
> [   37.556466]  update_process_times+0x9b/0xd0
> [   37.556467]  tick_sched_handle.isra.0+0x25/0x50
> [   37.556469]  tick_sched_timer+0x79/0x90
> [   37.556470]  ? tick_sched_do_timer+0x60/0x60
> [   37.556471]  __hrtimer_run_queues+0x1d1/0x4c0
> [   37.556473]  hrtimer_interrupt+0x114/0x230
> [   37.556475]  ? rcu_read_lock_held_common+0x12/0x50
> [   37.556489]  __sysvec_apic_timer_interrupt+0xa4/0x280
> [   37.556491]  sysvec_apic_timer_interrupt+0x95/0xc0
> [   37.556492]  </IRQ>

>Excellent, thank you!!!
>
>Now could you please do the same thing for a use_softirq kernel to verify =
that it prints correctly when that message is not supposed to be shown?

The use_softirq is not set zero, log follow:

rcu: INFO: rcu_preempt self-detected stall on CPU=09
[   32.388910] rcu:     3-....: (20847 ticks this GP) idle=3D733/1/0x400000=
0000000000 softirq=3D4565/4565 fqs=3D4655
[   32.388913]  (t=3D21000 jiffies g=3D8113 q=3D12547)
[   32.388914] NMI backtrace for cpu 3
[   32.388914] CPU: 3 PID: 73 Comm: rcu_torture_sta Tainted: G             =
L    5.17.0-yoctodev-standard #2 05f26dfea00beb93d9714ba8d61bb77646676403
[   32.388915] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel=
-1.15.0-0-g2dd4b9b3f840-prebuilt.qemu.org 04/01/2014
[   32.388916] Call Trace:
[   32.388916]  <IRQ>
[   32.388917]  dump_stack_lvl+0x5b/0x82

Thanks
Zqiang

>
>							Thanx, Paul

> Thanks
> Zqiang
>=20
> >
> ----------------------------------------------------------------------
> --
>=20
> commit 66226e2acda8b31b60137b1ae71244df68541a01
> Author: Zqiang <qiang1.zhang@intel.com>
> Date:   Mon Apr 25 09:04:04 2022 +0800
>=20
>     rcu: Dump all rcuc kthreads status for CPUs that not report=20
> quiescent state
>    =20
>     If the rcutree.use_softirq kernel boot parameter is disabled, then it=
 is
>     possible that a RCU CPU stall is due to the rcuc kthreads being starv=
ed of
>     CPU time.  There is currently no easy way to infer this from the RCU =
CPU
>     stall warning output.  This commit therefore adds a string of the for=
m "
>     rcuc=3D%ld jiffies(starved)" to a given CPU's output if the correspon=
ding
>     rcuc kthread has been starved for more than two seconds.
>    =20
>     [ paulmck: Eliminate extraneous space characters. ]
>    =20
>     Signed-off-by: Zqiang <qiang1.zhang@intel.com>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>=20
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h index=20
> d7956c03edbd4..0a25a4ea6eef8 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -407,7 +407,19 @@ static bool rcu_is_gp_kthread_starving(unsigned=20
> long *jp)
> =20
>  static bool rcu_is_rcuc_kthread_starving(struct rcu_data *rdp, unsigned =
long *jp)  {
> -	unsigned long j =3D jiffies - READ_ONCE(rdp->rcuc_activity);
> +	int cpu;
> +	struct task_struct *rcuc;
> +	unsigned long j;
> +
> +	rcuc =3D rdp->rcu_cpu_kthread_task;
> +	if (!rcuc)
> +		return false;
> +
> +	cpu =3D task_cpu(rcuc);
> +	if (cpu_is_offline(cpu) || idle_cpu(cpu))
> +		return false;
> +
> +	j =3D jiffies - READ_ONCE(rdp->rcuc_activity);
> =20
>  	if (jp)
>  		*jp =3D j;
> @@ -432,6 +444,9 @@ static void print_cpu_stall_info(int cpu)
>  	struct rcu_data *rdp =3D per_cpu_ptr(&rcu_data, cpu);
>  	char *ticks_title;
>  	unsigned long ticks_value;
> +	bool rcuc_starved;
> +	unsigned long j;
> +	char buf[32];
> =20
>  	/*
>  	 * We could be printing a lot while holding a spinlock.  Avoid @@ -449,=
7 +464,10 @@ static void print_cpu_stall_info(int cpu)
>  	delta =3D rcu_seq_ctr(rdp->mynode->gp_seq - rdp->rcu_iw_gp_seq);
>  	falsepositive =3D rcu_is_gp_kthread_starving(NULL) &&
>  			rcu_dynticks_in_eqs(rcu_dynticks_snap(rdp));
> -	pr_err("\t%d-%c%c%c%c: (%lu %s) idle=3D%03x/%ld/%#lx softirq=3D%u/%u fq=
s=3D%ld %s\n",
> +	rcuc_starved =3D rcu_is_rcuc_kthread_starving(rdp, &j);
> +	if (rcuc_starved)
> +		sprintf(buf, " rcuc=3D%ld jiffies(starved)", j);
> +	pr_err("\t%d-%c%c%c%c: (%lu %s) idle=3D%03x/%ld/%#lx softirq=3D%u/%u=20
> +fqs=3D%ld%s%s\n",
>  	       cpu,
>  	       "O."[!!cpu_online(cpu)],
>  	       "o."[!!(rdp->grpmask & rdp->mynode->qsmaskinit)], @@ -462,32 +48=
0,10 @@ static void print_cpu_stall_info(int cpu)
>  	       rdp->dynticks_nesting, rdp->dynticks_nmi_nesting,
>  	       rdp->softirq_snap, kstat_softirqs_cpu(RCU_SOFTIRQ, cpu),
>  	       data_race(rcu_state.n_force_qs) -=20
> rcu_state.n_force_qs_gpstart,
> +	       rcuc_starved ? buf : "",
>  	       falsepositive ? " (false positive?)" : "");  }
> =20
> -static void rcuc_kthread_dump(struct rcu_data *rdp) -{
> -	int cpu;
> -	unsigned long j;
> -	struct task_struct *rcuc;
> -
> -	rcuc =3D rdp->rcu_cpu_kthread_task;
> -	if (!rcuc)
> -		return;
> -
> -	cpu =3D task_cpu(rcuc);
> -	if (cpu_is_offline(cpu) || idle_cpu(cpu))
> -		return;
> -
> -	if (!rcu_is_rcuc_kthread_starving(rdp, &j))
> -		return;
> -
> -	pr_err("%s kthread starved for %ld jiffies\n", rcuc->comm, j);
> -	sched_show_task(rcuc);
> -	if (!trigger_single_cpu_backtrace(cpu))
> -		dump_cpu_task(cpu);
> -}
> -
>  /* Complain about starvation of grace-period kthread.  */  static=20
> void rcu_check_gp_kthread_starvation(void)
>  {
> @@ -659,9 +655,6 @@ static void print_cpu_stall(unsigned long gps)
>  	rcu_check_gp_kthread_expired_fqs_timer();
>  	rcu_check_gp_kthread_starvation();
> =20
> -	if (!use_softirq)
> -		rcuc_kthread_dump(rdp);
> -
>  	rcu_dump_cpu_stacks();
> =20
>  	raw_spin_lock_irqsave_rcu_node(rnp, flags);
