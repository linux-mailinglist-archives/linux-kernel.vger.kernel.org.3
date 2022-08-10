Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE6A958EE2C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 16:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbiHJOXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 10:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbiHJOXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 10:23:09 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E6812779
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 07:23:08 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220810142304epoutp013d02e2654f4328f315164fcabbc80289~KAcsJ61Xq1435914359epoutp01e
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 14:23:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220810142304epoutp013d02e2654f4328f315164fcabbc80289~KAcsJ61Xq1435914359epoutp01e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1660141384;
        bh=Ev88MQ5uLReWxbJsELeSQQo8xG3mkh5CK9bpYQqLB/A=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=iQQ4c9HBmhfgpPV+PT4qX4iJolQ4drm/702zbMvTPKqknW9YV+uXwafRxEp/b0CUl
         m3Gjkh5Usw9RClNwv+qKsAlU/04oVCWQFheKvOBaW+P47xJIJXs+vAavJHkvyX0kAu
         M7GQJEUSCJeUQbKRVMUr2lo9YBIG2hsBlAtcSb2k=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220810142303epcas5p3d65e361ddd40f943a2860120821b626d~KAcrjFty50471104711epcas5p3V;
        Wed, 10 Aug 2022 14:23:03 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4M2sbn4ndgz4x9Pp; Wed, 10 Aug
        2022 14:23:01 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        82.7D.49150.54FB3F26; Wed, 10 Aug 2022 23:23:01 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220810113945epcas5p1c9922b33c3db16ef697653dde5e50c89~J_OF87uBH0373103731epcas5p1O;
        Wed, 10 Aug 2022 11:39:45 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220810113944epsmtrp2b06ab655dbd7c5da416c50f10a584fcd~J_OF8Iq5d0236102361epsmtrp2M;
        Wed, 10 Aug 2022 11:39:44 +0000 (GMT)
X-AuditID: b6c32a4b-393ff7000000bffe-5a-62f3bf4518e3
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        77.01.08905.00993F26; Wed, 10 Aug 2022 20:39:44 +0900 (KST)
Received: from mshams02 (unknown [107.122.12.94]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220810113942epsmtip1f5da3307ac6599f24181b7994437e887~J_OD93JD40602906029epsmtip10;
        Wed, 10 Aug 2022 11:39:42 +0000 (GMT)
From:   "m.shams" <m.shams@samsung.com>
To:     =?iso-8859-1?Q?'Uwe_Kleine-K=F6nig'?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     <thierry.reding@gmail.com>, <lee.jones@linaro.org>,
        <linux-pwm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alim.akhtar@samsung.com>
In-Reply-To: <20220808174842.jiato34jzqstchdn@pengutronix.de>
Subject: RE: [PATCH] pwm: removes period check from pwm_apply_state()
Date:   Wed, 10 Aug 2022 17:09:30 +0530
Message-ID: <004301d8acad$e31fee70$a95fcb50$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQE14N23Ecc1n6hvU/1TooO9Vl2YEgEF3maVAoBW2yoC+wqOdQK9h22TrqOiL9A=
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCJsWRmVeSWpSXmKPExsWy7bCmhq7r/s9JBm0rVSwezNvGZnH/61FG
        i8u75rBZ3L27itHi5655LBa3J05mdGDz2DnrLrvHnWt72Dz6/xp49G1ZxejxeZNcAGtUtk1G
        amJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0AFKCmWJOaVA
        oYDE4mIlfTubovzSklSFjPziElul1IKUnAKTAr3ixNzi0rx0vbzUEitDAwMjU6DChOyM37dL
        C26qVszu7mRrYNwi28XIySEhYCIxcd9a9i5GLg4hgd2MEm+W32GFcD4xSjxtfsEE4XxjlHix
        u4UdpmX23C5GiMReRokzM2dCtTxjlFg2pwuohYODTUBVYsdNEZAGEQEvibmXd4PtYBaYxCjx
        o/8YK0iCU8BWonPbXBaQemEBV4mPvxhBTBag1qbzPiAmr4ClxMdtkSDFvAKCEidnPmEBsZkF
        9CRuTJ3CBmHLS2x/O4cZ4jQFiZ9Pl7FCbPWTmNLzgAmiRlzi6M8eZpALJAQmckgcm7WSBaLB
        ReLStBusELawxKvjW6B+lJL4/G4vG4SdLjH3YS8ThF0gsWzXd6gae4kDV+ZAzZGVmHpqHdQy
        Pone30+g6nkldsyDsRUl/u/uh+oVl3i3YgrrBEalWUh+m4Xkt1lIfpuF5IcFjCyrGCVTC4pz
        01OLTQuM81LL4fGdnJ+7iRGcPLW8dzA+evBB7xAjEwfjIUYJDmYlEd6yRZ+ThHhTEiurUovy
        44tKc1KLDzGaAsN7IrOUaHI+MH3nlcQbmlgamJiZmZlYGpsZKonzel3dlCQkkJ5YkpqdmlqQ
        WgTTx8TBKdXA1Fz+2n72c4cPN3yezL4rHx6Zrlgrajptqp6rwaInv4+HyPFxnuBibD287lxl
        VcoOu68xSSczpr179pXvjqxei1TsROGzD9KkdmXK6p41f7JJMP/8y1tXPu/k/iJWWPbj0rs9
        t1pWux7jbLbwmaxXuP+Qi+v/I3abjjycsH1euJ3EodbX4vU3Hxu+1W0PFvxZz/FIJsYheE9y
        0twYRiPTo4v8V28ofbrxEV/TaWbfyqqvOX73Q2Tdj61XE7127SPHPd0/lRW3Zb8rHLjzyeWo
        uE3j38hlHy4dVfCO2eUj2p+8LvXI233Lnj7ga217ffiWydHoo3bHI/q98nIu1f7urkw9voTx
        zJ74L9PjbrfGPVFiKc5INNRiLipOBACEyeLqJwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFLMWRmVeSWpSXmKPExsWy7bCSnC7DzM9JBr9bTC0ezNvGZnH/61FG
        i8u75rBZ3L27itHi5655LBa3J05mdGDz2DnrLrvHnWt72Dz6/xp49G1ZxejxeZNcAGsUl01K
        ak5mWWqRvl0CV8bv26UFN1UrZnd3sjUwbpHtYuTkkBAwkZg9t4uxi5GLQ0hgN6NE6+obTBAJ
        cYlpv/YzQtjCEiv/PWeHKHrCKHHq7222LkYODjYBVYkdN0VAakQEvCTmXt4NVsMsMI1RYurt
        u1BTZzFJNExZxg5SxSlgK9G5bS4LSLOwgKvEx1+MICYL0Jym8z4gJq+ApcTHbZEgxbwCghIn
        Zz5hAbGZBQwk7h/qYIWw5SW2v53DDHGagsTPp8tYIU7wk5jS84AJokZc4ujPHuYJjMKzkIya
        hWTULCSjZiFpWcDIsopRMrWgODc9t9iwwDAvtVyvODG3uDQvXS85P3cTIzh6tDR3MG5f9UHv
        ECMTB+MhRgkOZiUR3iNr3ycJ8aYkVlalFuXHF5XmpBYfYpTmYFES573QdTJeSCA9sSQ1OzW1
        ILUIJsvEwSnVwFR82nTDj+knEi1X+P9ONe9jiVjSty/D3nddadGlCTyuc345b1nPGPF2mkFz
        pVSvR+LqYu3jT5Z8/tB+Tk9bW2jTynvO1/7IKi3Yzsp0/N3Jowt/1DF9Cdh9enX/WqsH5Y6f
        GUOurd7MfOeiyiQBdn4xjzcRFyWZddKymtiquIyyJshe2SPetXPbTV/xr/NNnj/K/F0pG/VR
        6fmH3pPik05Lnw4+w5D+cHGUgcy5JE7Vi3zdj5veuRXnaN+TMIyZvGeH6t9rvOoTxZ3t0wN8
        Nh/NmO61n4fNbeUrY6u7pitY3fk5+fuNNgs95lnDfc27ZlN6AOvcS14fZS2dep5w+Kb6iVre
        PH/JguvzzGsLniuxFGckGmoxFxUnAgDOgNSsDQMAAA==
X-CMS-MailID: 20220810113945epcas5p1c9922b33c3db16ef697653dde5e50c89
X-Msg-Generator: CA
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220805102056epcas5p29f22d42c854bebe6d0301b56094cf3ea
References: <CGME20220805102056epcas5p29f22d42c854bebe6d0301b56094cf3ea@epcas5p2.samsung.com>
        <20220805101125.47955-1-m.shams@samsung.com>
        <20220805155509.edqwxcvyoqfic4pn@pengutronix.de>
        <019701d8ab31$94c86d60$be594820$@samsung.com>
        <20220808174842.jiato34jzqstchdn@pengutronix.de>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Uwe,

> Hello,
> 
> I fixed up the quoting for you in this mail. Please fix your mailer to not
break
> quotes, this is quite annoying. (Looking at the headers of your mail
you're using
> Outlook. Then your only viable option is to switch to a saner client.)
> 

Sorry for the inconvenience. I have fixed my mailer.

> On Mon, Aug 08, 2022 at 07:47:03PM +0530, m.shams wrote:
> > On Fri, Aug 05, 2022 at 03:41:25PM +0530, Tamseel Shams wrote:
> > > > There may be situation when PWM is exported using sysfs, but at
> > > > that point PWM period is not set. At this situation if we issue a
> > > > system suspend, it calls pwm_class_suspend which in turn calls
> > > > pwm_apply_state, where PWM period value is checked which returns
> > > > an invalid argument error casuing Kernel to panic. So, check for
> > > > PWM period value is removed so as to fix the kernel panic observed
> > > > during suspend.
> > >
> > > This looks and sounds wrong. One thing I would accept is:
> > >
> > > diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c index
> > > 0e042410f6b9..075bbcdad6c1 100644
> > > --- a/drivers/pwm/core.c
> > > +++ b/drivers/pwm/core.c
> > > @@ -557,8 +557,8 @@ int pwm_apply_state(struct pwm_device *pwm,
> const struct pwm_state *state)
> > > 	 */
> > > 	might_sleep();
> > >
> > > -	if (!pwm || !state || !state->period ||
> > > -	    state->duty_cycle > state->period)
> > > +	if (!pwm || !state || state->enabled && (!state->period ||
> > > +	    state->duty_cycle > state->period))
> > >  		return -EINVAL;
> > >
> > > 	chip = pwm->chip;
> > >
> > > That is, don't refuse calling pwm_apply_state() for state->period =
> > > 0 and even state->duty_cycle > state->period if the > > PWM is not
enabled.
> >
> > By this do you mean doing it following way?
> >
> > if (!pwm || !state || (pwm && !state->period) ||
> > 	    (pwm && state->duty_cycle > state->period))
> > 		return -EINVAL;
> 
> No. Your expression is logically equivalent to what we already have. I
> meant:
> 
> 	if (!pwm || !state || state->enabled && (!state->period ||
> 	    state->duty_cycle > state->period))
> 		return -EINVAL;
> 
> Learning to read diffs (maybe Outlook scrambled the view for you, too?) is
a
> nice capability you should master.
> 
> > > But anyhow, even without that the kernel should not panic. So I ask
> > > you to research and provide some more info about > > the problem.
> > > (Which hardware does it affect? Where does it panic? ...)
> >
> > Observing Kernel panic in exynos SoC when we issue system suspend.
> > Following is the snippet of error:
> >
> > # echo mem > /sys/power/state
> > [   29.224784] 010: Kernel panic - not syncing: pwm pwmchip0:
> > dpm_run_callback failure
> > [   29.240134] 010: Call trace:
> > [   29.242993] 010:  dump_backtrace+0x0/0x1b8
> > [   29.247067] 010:  show_stack+0x24/0x30
> > [   29.250793] 010:  dump_stack+0xb8/0x114
> > [   29.254606] 010:  panic+0x180/0x398
> > [   29.258073] 010:  dpm_run_callback+0x270/0x278
> > [   29.262493] 010:  __device_suspend+0x15c/0x628
> > [   29.266913] 010:  dpm_suspend+0x124/0x3b0
> > [   29.270899] 010:  dpm_suspend_start+0xa0/0xa8
> > [   29.275233] 010:  suspend_devices_and_enter+0x110/0x968
> > [   29.280433] 010:  pm_suspend+0x308/0x3d8
> > [   29.284333] 010:  state_store+0x8c/0x110
> > [   29.288233] 010:  kobj_attr_store+0x14/0x28
> > [   29.292393] 010:  sysfs_kf_write+0x5c/0x78
> > [   29.296466] 010:  kernfs_fop_write+0x10c/0x220
> > [   29.300886] 010:  __vfs_write+0x48/0x90
> > [   29.304699] 010:  vfs_write+0xb8/0x1c0
> > [   29.308426] 010:  ksys_write+0x74/0x100
> > [   29.312240] 010:  __arm64_sys_write+0x24/0x30
> > [   29.316573] 010:  el0_svc_handler+0x110/0x1b8
> > [   29.320906] 010:  el0_svc+0x8/0x1bc
> > [   29.324374] 010: SMP: stopping secondary CPUs
> > [   29.328711] 010: Kernel Offset: disabled
> > [   29.332607] 010: CPU features: 0x0002,00006008
> > [   29.337026] 010: Memory Limit: none
> > [   29.343949] 010: Rebooting in 1 seconds..
> > [   30.344539] 010: Disabling non-boot CPUs ...
> 
> Just locking at that and starring at drivers/base/power/main.c for a while
> doesn't make this clearer to me. Are you using a mainline kernel?
> Which version?
> 

Looks like I had some local patch which was causing the error to trigger
Kernel Panic (sorry about that).
On removing those local changes, I do not observe kernel panic, but observe
following error and then suspend fails.

[   63.963063] pwm pwmchip0: PM: dpm_run_callback ():
pwm_class_suspend+0x0/0xf8 returns -22
[   63.963079] pwm pwmchip0: PM: failed to suspend: error -22

So, as to fix this issue I will post a new version of patch containing
change suggested by you.

Best Regards,
Tamseel Shams

