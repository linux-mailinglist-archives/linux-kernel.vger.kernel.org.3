Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D934D1122
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 08:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344634AbiCHHi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 02:38:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344627AbiCHHiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 02:38:23 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C0819E
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 23:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646725047; x=1678261047;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Qa9ZAQIc6cPGyNJ7+i6H3JaXJG1otS215msIxwXfztc=;
  b=Vubo+HbUrR0H6VWmy12FpejedSNL32DtHtyVf/o+PnsXRw3Zx/qu2jgu
   xcvZHb1jSIw2tFXn2bSQmhc7sROkv15T6cvITpynDfVcsBwBQJo61gaTD
   DC6gQFjcRVVwKpXwYdCPXdg3fe/rS2myJ0UhHtdwAu/YV2GEBe/ZThwPN
   Xi0N5RNHcsIpu5FTp267ClZW5ZkDf73FOCz3QHCFGw+clLlY33s4XUkC1
   tQ0XNf9xUT0WnbPLlZqpeNRhRFEwat7GSbAgNugIWPp6AKMoR/UTHgfqv
   xO2ExebRlJr1fQdHxL+iu6ZvxiwyWS2b7SK42c8Yntt51nQCvT+LMcl6+
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="234570779"
X-IronPort-AV: E=Sophos;i="5.90,163,1643702400"; 
   d="scan'208";a="234570779"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 23:37:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,163,1643702400"; 
   d="scan'208";a="813729990"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga005.fm.intel.com with ESMTP; 07 Mar 2022 23:37:27 -0800
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 7 Mar 2022 23:37:26 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Mon, 7 Mar 2022 23:37:26 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Mon, 7 Mar 2022 23:37:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bXcd5ZzL0SoYQPKhIvOBfHNl7iqjMe0QJJFkYKtfoaArn9JvMwjTAUmh5WnJ3ExVJ1wVasowI+wAwXo2S5mcvZFT5PtMm0iV2eZeziMLds1YaU4H0fGSHNpUvkAx0hScizUhcNWDz2NR0gidbD0zMaKCOS0T+b9UAf1aKHLT3qFWuiZxHtYeSd0N9K3UD4WhSrlq6hKc8+ujDnhXxCINzIwb+JPwYS0ygpdMVHYWiarxgYM0eLSjLpvIpVqfLLl63xSyhIVnWonsjxGfXU60Ol/iN1aVLLrTOEknMTB49RRhWhahsXjh4p4DS8+kQAFKWdPySQ2m9EA9kN0vCjcXyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lrjb2InWnC7soYj189X1fkg8A4a5ktHgYZ7BKxTGeFs=;
 b=CpaCf6yrBWxIsxZNQ1upsBELkbFLdKgiEriwnNZSEBWDPVtkJJp3fqEy6IuP8Pon8vbZQaq7owwg7XHkdR4yrofTVmhzVCwKFuxKuiPxEUz0PmF2V51wyWql9iI/KneHcOPfa3nH8i42hv8EBPsH3ipJSO9dA8E0+Wm7CSQZ6I6ak5Eh8+wqV9714cJvCLL0xF+j2ULzLT/fI33YCL9cz8rEGzlTU+nn7DH/5ODJebc/cA6q0bsdWhPGHGnwtrycuWMy8E0+M1WBbJ7VvLswnsjuSZkEDpvnArTJJSj3dhrfnvSBuVrQEMGO+oKYiwTh/LuHt2J+ZYn70OzCRPSHdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by MN2PR11MB3664.namprd11.prod.outlook.com (2603:10b6:208:f1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Tue, 8 Mar
 2022 07:37:24 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::5ccb:dfa1:626e:af2c]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::5ccb:dfa1:626e:af2c%8]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 07:37:24 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     Frederic Weisbecker <frederic@kernel.org>
CC:     "paulmck@kernel.org" <paulmck@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: RE: [PATCH] rcu/nocb: Clear rdp offloaded flags when rcuop/rcuog
 kthreads spawn failed
Thread-Topic: [PATCH] rcu/nocb: Clear rdp offloaded flags when rcuop/rcuog
 kthreads spawn failed
Thread-Index: AQHYLIaY7+I2utbBBk2DOZbNtjWjdKyt5C0AgAbbncA=
Date:   Tue, 8 Mar 2022 07:37:24 +0000
Message-ID: <PH0PR11MB5880F450C2DDD04D4C76F814DA099@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20220228093629.3746473-1-qiang1.zhang@intel.com>
 <20220303164914.GA87151@lothringen>
In-Reply-To: <20220303164914.GA87151@lothringen>
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
x-ms-office365-filtering-correlation-id: e68cdf1a-ba77-4599-5223-08da00d67d1a
x-ms-traffictypediagnostic: MN2PR11MB3664:EE_
x-microsoft-antispam-prvs: <MN2PR11MB36642C744FA479B5D0E9E37ADA099@MN2PR11MB3664.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Lr1GECTbNJeJya5RYJmbEBpcYXfax2Ca+5kB5ph4bXLQf0RsrzZukrNgslg+ITNSShMeOkrsfM9ohM/q9eM2UZ7q1ybQ64zKEiQZsbiSrfmPyrlz6NSpR04orTWViOfuDuoyDsxfle+Cby9JL19JlqgZPOGFasbvpgjE0UfLwhxgZfxb+jaWxpp46p4ZQaGN6BHOWX0ItPURA7FdlrDcfI/MbmhEivTW9T2m2E0eoXLIPA0XiPeGir1GYySDBjg7TmAc9X3boGTT9jNIwGFz0zY3dH5Gq4dAbWnlZs7wYgMPb9nqQXTvp4ZBDqcIoWKoAdZQvH0Mu+XJB9mcsZwo/RZm0cQDQOendWnMlaR759/2m+PqOVLhR/ZUyc6LR1WyYZf/hA8tePcGU0aGsooR6aqhQfE5jfw499AKDJSkaXtG7MDD5mlwkFtzNl9jkvJ+xhz+CmjdHU4qrNJzvUX+XdShYuiQR1Nxhw6oew+9nSX2Sffvmg2AkeGXXfwnUoV3kDGHhIAYOsVRA4QuApbQSvcw4G9ttSgJ2ncHuuODG2yHdiLszhYY9YtlOoLLQRwwkUs2VVOgCo3MbPnOuOGXaK8F9iqG0HSSoHm57dt5E6bz4y3aeLIf5qSYjdoK6+T1tJFkhvM36lRPlMQyz+z2ziW5b3/fp6q7meQRlkJIaSQ/o5lWObkucXA/OTuwhn7q2YurL+ky2eoPivMUW+mxCQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(83380400001)(54906003)(6506007)(6916009)(2906002)(316002)(7696005)(9686003)(82960400001)(8936002)(52536014)(508600001)(122000001)(71200400001)(55016003)(33656002)(38100700002)(5660300002)(66476007)(8676002)(64756008)(4326008)(66556008)(66446008)(66946007)(66574015)(76116006)(26005)(186003)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Food4gZI5Dx2DDvptBZyvCJi0IY/+pZWRjeSBYNzJbS8PaMlZo8+0wDY0y/1?=
 =?us-ascii?Q?dboxyjVD0rKEqLEH3wUfKpUa6yo75Bg7IX63o9MxbIIgkeDc21u1NfYMFWcZ?=
 =?us-ascii?Q?gwZm9MIvbhpcliRW1pziNwi+w8ywIZCnwJCzK6U/t6gB3jYg3SwURiuFDZmk?=
 =?us-ascii?Q?XrziMmg1KCP8KGKjgl7vipjWlvR6sq4X9LgL1uhg2vOK2XNax8Y2wyG0F1zf?=
 =?us-ascii?Q?H0V7aBKXR4B8Rh3Qfn+vaF7G1nJNARXSg+g6RvZOQjYmmNJIR9bEsWsAsV4H?=
 =?us-ascii?Q?mLXbAz/gUiy/jRqP9cW5fCaYz+KR0QLNYLhmnl9k5kUOKa2Uehvxd5+yzSE2?=
 =?us-ascii?Q?KGgeUPbWN+6541cR1COPomYVlT8SA9PA6nIrM+NxDqAj9T79FR/nG621dwlc?=
 =?us-ascii?Q?SNxH3WDBNJwBmUA8TTjMxZ5fWx2L9GJ1N64uuugQSPZ7WAT+5jtrF9OOKhxf?=
 =?us-ascii?Q?4juddHB39NBiKloey2IQg3zCzpgzZ29ptSK37AKiuKW1H8sDGnPkwdqN8E9R?=
 =?us-ascii?Q?4lpxP4xAx8tUAa+fda2BUmbkd1INbhKbnny5ErpnNgfWvtaZMcaWigsPQJ1P?=
 =?us-ascii?Q?ax30gu8Jpql9WOpUAqDw+p8xOP2LcgKusw2dJ10MpXXfxLXpwgxUEUo+PmRP?=
 =?us-ascii?Q?EvSoDp8l9rk8P1zz4ILnpHnBY9O7ZCph9tWUhD2+DNFWIO1Js0y2koWcqbhV?=
 =?us-ascii?Q?VrnstqNoAljCjc+ICmiDEMBASAJgpaXfuwiju2m8ZiLw1TUdsIRPYMJ2wSpG?=
 =?us-ascii?Q?Otlmx7506zTNTLsjqXHj9kCg+5qF9OF4w4k0wax6/0Wi/GjOilIQp9iF/s50?=
 =?us-ascii?Q?bF+gtc4vU1ey6yV4TSMC3DCZsTD/XtLwYcycDyax08U8vgIP+IWtn+urzALv?=
 =?us-ascii?Q?60RlG3+jQdVo2KVqnEkg85feP8CU6/S9hAiznge76MlqId+p5D+i8STI/Xkf?=
 =?us-ascii?Q?tF8V+aoKOCSnkT640TutRgDHfTtmyWctGDIutP4sA8mGD6shFe+Q6nXx+hQf?=
 =?us-ascii?Q?0piuF9Y9ZtdCApiAD+BfNhsYmfSIlYX6FzEAJBTeI/GKAJ1Tn7inMDcrO1jN?=
 =?us-ascii?Q?IiibateoJPeVUw3q8QCnBjf1O9Me0a3rqXyq/A99vZgnik3YcIMtm0MSKKeE?=
 =?us-ascii?Q?FF8c6nXVTtQ+k0X4+lXyPZ0QsOkyvV8sJN3wSdLwXCJECmnQTsjw26ryxZQP?=
 =?us-ascii?Q?jmSoRgbZwPXwu+LdRMcOSqhOx/GXBMoofBwB5JhH+pJ0RZsZHIGu4np8WAIh?=
 =?us-ascii?Q?ufPtuIuU4/egFI/dPUBW/XPdQeCNzjy2BdplulwJQa12q0qu+ST2w7rkqPyY?=
 =?us-ascii?Q?RTa5baI1BgqXgog/HwXDfyxcJwvNg7YBFEJUpj60VPiWiMMF09To2SrFHmFm?=
 =?us-ascii?Q?dVhVdAn+WrPWo3eWJ3eF3E0HESVMn1YcTcmw3yjYQEWyIK9OAQHKbeh2+5Me?=
 =?us-ascii?Q?KzxSVWS8Bs3Nv1OTOuCeJrx/rdNxw9oVbTs28z1gOWyn9tRdAiwnvtgx5w5N?=
 =?us-ascii?Q?lHHy9RMmC/au0ZxDbI3TnUOsDgbKI3zVPZY01NtSsQD4QAg5V/Gvyo1zmC5H?=
 =?us-ascii?Q?XncXfUoMEsCT5+dSJ1axh2lC4iiMP7VkVRRlaaiSMd8rSOoq2rAI6zBHIzZM?=
 =?us-ascii?Q?pA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e68cdf1a-ba77-4599-5223-08da00d67d1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2022 07:37:24.6975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CyVJLi+l3ixOcrd2XZoFJoGkNyIMFN3shPDGYMF4K8rZmx+EDaQQPvdTxgFRbY9WAGoqSjc5ainSb28rFZO3hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3664
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, Feb 28, 2022 at 05:36:29PM +0800, Zqiang wrote:
> When CONFIG_RCU_NOCB_CPU is enabled and 'rcu_nocbs' is set, the rcuop=20
> and rcuog kthreads is created. however the rcuop or rcuog kthreads=20
> creation may fail, if failed, clear rdp offloaded flags.
>=20
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> ---
>  kernel/rcu/tree_nocb.h | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>=20
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h index=20
> 46694e13398a..94b279147954 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -1246,7 +1246,7 @@ static void rcu_spawn_cpu_nocb_kthread(int cpu)
>  				"rcuog/%d", rdp_gp->cpu);
>  		if (WARN_ONCE(IS_ERR(t), "%s: Could not start rcuo GP kthread, OOM is =
now expected behavior\n", __func__)) {
>  			mutex_unlock(&rdp_gp->nocb_gp_kthread_mutex);
> -			return;
> +			goto end;
>  		}
>  		WRITE_ONCE(rdp_gp->nocb_gp_kthread, t);
>  		if (kthread_prio)
> @@ -1258,12 +1258,22 @@ static void rcu_spawn_cpu_nocb_kthread(int cpu)
>  	t =3D kthread_run(rcu_nocb_cb_kthread, rdp,
>  			"rcuo%c/%d", rcu_state.abbr, cpu);
>  	if (WARN_ONCE(IS_ERR(t), "%s: Could not start rcuo CB kthread, OOM is n=
ow expected behavior\n", __func__))
> -		return;
> +		goto end;
> =20
>  	if (kthread_prio)
>  		sched_setscheduler_nocheck(t, SCHED_FIFO, &sp);
>  	WRITE_ONCE(rdp->nocb_cb_kthread, t);
>  	WRITE_ONCE(rdp->nocb_gp_kthread, rdp_gp->nocb_gp_kthread);
> +	return;
> +end:
> +	if (cpumask_test_cpu(cpu, rcu_nocb_mask)) {
> +		rcu_segcblist_offload(&rdp->cblist, false);
> +		rcu_segcblist_clear_flags(&rdp->cblist,
> +				SEGCBLIST_KTHREAD_CB | SEGCBLIST_KTHREAD_GP);
> +		rcu_segcblist_clear_flags(&rdp->cblist, SEGCBLIST_LOCKING);
> +		rcu_segcblist_set_flags(&rdp->cblist, SEGCBLIST_RCU_CORE);
> +	}
>>
>>Thanks you, consequences are indeed bad otherwise because the target is c=
onsidered offloaded but nothing actually handles the callbacks.
>>
>>A few issues though:
>>
>>* The rdp_gp kthread may be running concurrently. If it's iterating this =
rdp and
>>  the SEGCBLIST_LOCKING flag is cleared in the middle, rcu_nocb_unlock() =
won't
>>  release (among many other possible issues).
>>
>>* we should clear the cpu from rcu_nocb_mask or we won't be able to later
>>  re-offload it.
>>
>>* we should then delete the rdp from the group list:
>>
>>     list_del_rcu(&rdp->nocb_entry_rdp);
>>
>>So ideally we should call rcu_nocb_rdp_deoffload(). But then bear in mind=
:
>>
>>1) We must lock rcu_state.barrier_mutex and hotplug read lock. But since =
we
>>   are calling rcutree_prepare_cpu(), we maybe holding hotplug write lock
>>   already.
>>
>>   Therefore we first need to invert the locking dependency order between
>>   rcu_state.barrier_mutex and hotplug lock and then just lock the barrie=
r_mutex
>>   before calling rcu_nocb_rdp_deoffload() from our failure path.
>>  =20
>>
>>2) On rcu_nocb_rdp_deoffload(), handle non-existing nocb_gp and/or nocb_c=
b
>>   kthreads. Make sure we are holding nocb_gp_kthread_mutex.

Sorry for my late reply,  Is the nocb_gp_kthread_mutex really necessary?
Because the cpu online/offline is serial operation,  It is protected by  cp=
us_write_lock()

Thanks
Zqiang

>>
>>I'm going to take your patch and adapt it along those lines.
>>
>>Thanks!
