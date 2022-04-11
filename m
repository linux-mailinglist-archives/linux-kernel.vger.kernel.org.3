Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9A44FC4B7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 21:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349427AbiDKTJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 15:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343566AbiDKTIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 15:08:43 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF27836334
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 12:06:22 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id v75so16824103oie.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 12:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=RdbC5zZXK0Z4kBByxzvgYOMlUHgPAJvUgEWB8Fum0Hc=;
        b=Ym8Fal3cYlNCBLVdzfE20kPQyKyhsTo96BrRzYwKRtgPDso/8SVHyyvUWtudn9JVVp
         +6iQeiM14p1K90i2N7kqrjAgNGGAT4fV5qQPfsZ0kTMY89bK5vFxrIv6EW7ytmG3SDge
         QKP5D0ON66P+E5Lm/S70IF0R27OL9hbyiOXz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=RdbC5zZXK0Z4kBByxzvgYOMlUHgPAJvUgEWB8Fum0Hc=;
        b=g+xVGEtb7UzbyMCS+O1HyXhUECrwrG/y+3Xt7mG4TNriQOw7yWm7RYYFMbwnZ4NV6x
         j+OB4u/suMe0MI9gUAFda2agJyKfHw5uR9/L7ZFyrq9DPupsur3bGNv3GpbmssdIBmPR
         O+j9giF+NFgBIIasF5wH9W3CfVy2KKyIIZYGDNK/5SJ7Ug4cJ7RTE3YkWCp7g/3SPBur
         QeIwlITdudF4F4060nQfVkdEKp6XalGGof4G5GtBU2IuHbcgmjJJkRCXTJTLSsjlQS0+
         v+ILJ2ogc8DTgOx7sHC597z+tYd1pHbwj6qu6iBAJa63i+ljWI7gKneme6knzSHplhdV
         8cog==
X-Gm-Message-State: AOAM532kglZKKXx26HtfCFGTZKrWb8LlNd9GC5Xjv9lRNd+u1X6S92az
        c++Bh28tEtUb7zUQ1FJxLQJBWyFEd7b/zcPDLlVIhw==
X-Google-Smtp-Source: ABdhPJwlBI/fFYx01i38B5hEvQXoeEWMkBRWkDrBkzl4iwCNeX1GWbC4RdmhHPzCP/ubzgsGtJGFozK8iNyTRy06Fyo=
X-Received: by 2002:aca:bd41:0:b0:2ec:ff42:814f with SMTP id
 n62-20020acabd41000000b002ecff42814fmr268281oif.63.1649703980184; Mon, 11 Apr
 2022 12:06:20 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 11 Apr 2022 12:06:19 -0700
MIME-Version: 1.0
In-Reply-To: <a96a010d-9bd7-f760-3c03-d842feef41aa@linaro.org>
References: <20211125174751.25317-1-djakov@kernel.org> <CAE-0n51xeigKFS9Zek44HZGD9cdc4Em91aQ5HHzuy7P1FBmfFg@mail.gmail.com>
 <a96a010d-9bd7-f760-3c03-d842feef41aa@linaro.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 11 Apr 2022 12:06:19 -0700
Message-ID: <CAE-0n51-hpG_5O11FbGrHaMr_mN0ZAky8CVzZNmDj29aK8wGog@mail.gmail.com>
Subject: Re: [PATCH v3] interconnect: qcom: icc-rpmh: Add BCMs to commit list
 in pre_aggregate
To:     Alex Elder <elder@linaro.org>, djakov@kernel.org,
        okukatla@codeaurora.org, quic_mdtipton@quicinc.com
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mike Tipton <mdtipton@codeaurora.org>, mka@chromium.org,
        dianders@chromium.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alex Elder (2022-04-11 08:59:07)
> On 4/5/22 6:00 PM, Stephen Boyd wrote:
> > Quoting Georgi Djakov (2021-11-25 09:47:51)
> >> From: Mike Tipton <mdtipton@codeaurora.org>
> >>
> >> We're only adding BCMs to the commit list in aggregate(), but there are
> >> cases where pre_aggregate() is called without subsequently calling
> >> aggregate(). In particular, in icc_sync_state() when a node with initial
> >> BW has zero requests. Since BCMs aren't added to the commit list in
> >> these cases, we don't actually send the zero BW request to HW. So the
> >> resources remain on unnecessarily.
> >>
> >> Add BCMs to the commit list in pre_aggregate() instead, which is always
> >> called even when there are no requests.
> >>
> >> Signed-off-by: Mike Tipton <mdtipton@codeaurora.org>
> >> [georgi: remove icc_sync_state for platforms with incomplete support]
> >> Signed-off-by: Georgi Djakov <djakov@kernel.org>
>
> I'm back from vacation and am finally giving proper attention to
> this.  I want to make sure I understand the problem, because there
> are (at least) two parts to it.
>
> - The first problem you observe is that you are not seeing XO
>    shutdown on suspend on a Lazor device.
> - You didn't say this directly but I think you are seeing this
>    on Linux v5.15.y (the 5.15 LTS branch), or perhaps on something
>    derived from that branch.

Yes.

> - You find that if you back-port (or cherry-pick?) the commit
>    that landed upstream as b95b668eaaa2 ("interconnect: qcom:
>    icc-rpmh: Add BCMs to commit list in pre_aggregate
> "), you
>    *do* see XO shutdown on suspend, as desired.

Correct.

>
> Here's what I understand that commit to do:
> - In some cases, the bus clock managers (BCMs) are configured
>    by the boot loader so that some interconnects have non-zero
>    initial bandwidth.
> - There is no sense in keeping an interconnect active if Linux
>    has nothing that requires its use.  So we would like Linux to
>    ensure the configured bandwidth for an *unused* interconnect
>    is zero.
> - Prior to that commit, BCM-managed hardware was only queued
>    to update its configuration when the ->aggregate interconnect
>    provider function was called.  After that commit, updates were
>    queued by the ->pre_aggregate provider function.

Also before that commit interconnects are maxed out, which doesn't
really matter for XO shutdown but it means that we're running faster
than what the bootloader configures if boot is slower.

> - Unlike the ->aggregate callback, the ->pre_aggregate provider
>    function queues updates to the hardware configuration whether
>    or not they have active users.
> - The result of this commit is that the hardware configuration
>    for all defined BCM-managed interconnects is updated, and in
>    particular, the configured bandwidth for unused interconnects
>    is set to zero.

Yep.

>
> When unused interconnects are configured for zero bandwidth, they
> do not require an active main XO clock, and so with this commit
> it becomes possible for the XO clock to be shut down.
>
> And that's why this commit addresses your XO shutdown problem on
> the Linux 5.15 LTS branch.
>
> Is the above an accurate description?

Yeah pretty much. Without the interconnect patch I can't get XO
shutdown.

>
> Looking at that branch, I see this commit:  f753067494c27
> ("Revert "interconnect: qcom: icc-rpmh: Add BCMs to commit
> list in pre_aggregate"
> ").  Which shows that an attempt was made
> to include this commit in the 5.15 LTS branch, but it caused
> some *other* regressions.  That suggests this might not be
> easy to fix.

Indeed. The commit was reverted because it broke reboot for me. I see it
was reintroduced a few months later though when I was eating
Thanksgiving dinner and I didn't notice until now. Interestingly the
reboot issue is gone. Here's the crash from back then.

 SError Interrupt on CPU6, code 0xbe000411 -- SError
 CPU: 6 PID: 8772 Comm: reboot Not tainted 5.14.0-rc5-next-20210810+ #1
 Hardware name: Google Lazor (rev3+) with KB Backlight (DT)
 pstate: 004000c9 (nzcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 pc : el1_interrupt+0x20/0x60
 lr : el1h_64_irq_handler+0x18/0x24
 sp : ffffffc0114139c0
 x29: ffffffc0114139c0 x28: ffffff808a8b2240 x27: 0000000000000000
 x26: ffffff80817ec018 x25: ffffffd79e8f0000 x24: ffffffd79e957000
 x23: 0000000000400009 x22: ffffffd79dac527c x21: ffffffc011413b40
 x20: ffffffd79d6100f8 x19: ffffffc0114139f0 x18: 0000000000022a07
 x17: 0000000000000000 x16: ffffffd79dac52e4 x15: ffffff80d291fe80
 x14: 0000000000000580 x13: 000000000000300c x12: ffffff80b4f7ed10
 x11: 0000000000000003 x10: 00000000c0000000 x9 : 0000000000000003
 x8 : 00000000000000c0 x7 : bbbbbbbbbbbbbbbb x6 : 0000000000000001
 x5 : 0000000000170006 x4 : ffffff80d291bcc0 x3 : ffffffd79e429b41
 x2 : 0000000000000002 x1 : ffffffd79d6100f8 x0 : ffffffc0114139f0
 Kernel panic - not syncing: Asynchronous SError Interrupt
 CPU: 6 PID: 8772 Comm: reboot Not tainted 5.14.0-rc5-next-20210810+ #1
 Hardware name: Google Lazor (rev3+) with KB Backlight (DT)
 Call trace:
  dump_backtrace+0x0/0x1d4
  show_stack+0x24/0x30
  dump_stack_lvl+0x64/0x7c
  dump_stack+0x18/0x38
  panic+0x150/0x38c
  nmi_panic+0x88/0xa0
  arm64_serror_panic+0x74/0x80
  is_valid_bugaddr+0x0/0x1c
  el1h_64_error_handler+0x30/0x48
  el1h_64_error+0x78/0x7c
  el1_interrupt+0x20/0x60
  el1h_64_irq_handler+0x18/0x24
  el1h_64_irq+0x78/0x7c
  refcount_dec_not_one+0x48/0xb0
  refcount_dec_and_mutex_lock+0x1c/0xb4
  ipa_clock_put+0x34/0x74 [ipa]
  ipa_uc_deconfig+0x4c/0x5c [ipa]
  ipa_deconfig+0x30/0x90 [ipa]
  ipa_remove+0xbc/0x11c [ipa]
  platform_shutdown+0x30/0x3c
  device_shutdown+0x150/0x208
  kernel_restart_prepare+0x44/0x50

>
> ---
>
> The second problem you have is exhibited by the IPA driver if
> the "fix" commit (upstream b95b668eaaa2) is back-ported to the
> Linux 5.10.y LTS branch (along with some other prerequisite
> commits).  We can conclude that applying the above commit
> makes the bandwidth for an unused interconnect (or perhaps
> the rate for the IPA core clock) get set to zero.  And in that
> case, an attempt to access IPA hardware leads to the crash you
> observed.
>
> The IPA driver does not implement runtime power management
> until Linux v5.15.  You later said you thought enabling that
> might ensure the clock and interconnects were active when
> needed by the IPA driver, and I concur (but there could be a
> little more to it).

Is the runtime PM patch series necessary to enable the IPA clk and
interconnects? Things don't look good on 5.10.y and I'm not sure it will
be workable. Commit b1d681d8d324 ("interconnect: Add sync state
support") was introduced in v5.10 and that seems to be the commit that
broke suspend on Lazor.

>
> In any case, based on the time stamp in your log, it seems
> this problem is likely occurring upon the first access to IPA
> hardware.
>
> I have a hunch about what might be happening here.  There is
> some synchronization that must occur between the AP and modem
> when IPA is starting up.  Until that synchronization step has
> completed, we can't allow the IPA network device to be opened.

Is there a commit that implements this? Or how is the synchronization
done? I can debug more and see if that synchronization is happening.

> In later kernels I think this is precluded, but perhaps in
> Linux v5.10 it isn't.  Until I look a little more closely I'm
> not sure what would happen, but it *could* be this.
>
> I'm going to look a little how the particular access that
> caused the crash is prevented in newer kernels.  It could
> be that back-porting that (or re-implementing it for the
> older kernel) will address the crash you're seeing.
>
