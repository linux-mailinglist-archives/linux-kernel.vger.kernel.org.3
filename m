Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84E44DC7A9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 14:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234612AbiCQNfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 09:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234604AbiCQNfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 09:35:48 -0400
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4637E1D8327;
        Thu, 17 Mar 2022 06:34:32 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id m67so10263636ybm.4;
        Thu, 17 Mar 2022 06:34:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bVTYHCw+sIjTpGlaPwKVewFptDurXIS2uuawHeJHLLA=;
        b=BAtPILSFs0nOVFUgxIJXGVA8Vn2gs6IHJTl3UVn2oIYb07qBdvEcM+TxzOBQ0GUKyl
         PYwl10DDAgfPGI3peyrO21r47edXNngbEqLCpOS6lD7zBR9viMXpi4SxSMI5FYYLbybj
         yXfCxOj3QhZFyJFmIxsB3aLRjKHkHx0vSyBMohfyYNXR9lUwfxrisNCittoZAJpcmXsq
         MWy7dl5KV1R4TgfXyCrrF9hgHrOoh1jnLWxYBX+DPgySFJ7oWOnVmpBx4shF/ShP74n5
         iSkyc9MjSoT6ojrItTnPxRvzlIITWLjjIKfZTMBiCFtbw3kd7Nm1KYiEGaV8LfJQ3MuF
         JCsg==
X-Gm-Message-State: AOAM532mF7MR/mLo83auoMzkIy8EMx5E+Bj5cL9f5rP0GXZkHCBTav1J
        XKAwrpHxr3/crNABaPsFduh1W6/lvSllth6czm4=
X-Google-Smtp-Source: ABdhPJy6DKisf5GePZUAUsw10mXzY76VFI0VY63YMwwR6uG1gCWv7s4+Qd2m05v8v17o1iGhmVwXH1okd/5VI0MkbZc=
X-Received: by 2002:a25:3a41:0:b0:628:86a2:dbc with SMTP id
 h62-20020a253a41000000b0062886a20dbcmr4619617yba.633.1647524071539; Thu, 17
 Mar 2022 06:34:31 -0700 (PDT)
MIME-Version: 1.0
References: <2630560.mvXUDI8C0e@kreacher> <5558236.DvuYhMxLoT@kreacher>
In-Reply-To: <5558236.DvuYhMxLoT@kreacher>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 17 Mar 2022 14:34:20 +0100
Message-ID: <CAJZ5v0jEFdDdw3TLAFwwSjHrruk9ak4KNXjzZjcXz-7jyVFrxg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] cpuidle: intel_idle: Update intel_idle() kerneldoc comment
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 8:37 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Commit bf9282dc26e7 ("cpuidle: Make CPUIDLE_FLAG_TLB_FLUSHED generic")
> moved the leave_mm() call away from intel_idle(), but it didn't update
> its kerneldoc comment accordingly, so do that now.
>
> Fixes: bf9282dc26e7 ("cpuidle: Make CPUIDLE_FLAG_TLB_FLUSHED generic")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/idle/intel_idle.c |    3 ---
>  1 file changed, 3 deletions(-)
>
> Index: linux-pm/drivers/idle/intel_idle.c
> ===================================================================
> --- linux-pm.orig/drivers/idle/intel_idle.c
> +++ linux-pm/drivers/idle/intel_idle.c
> @@ -122,9 +122,6 @@ static unsigned int mwait_substates __in
>   * If the local APIC timer is not known to be reliable in the target idle state,
>   * enable one-shot tick broadcasting for the target CPU before executing MWAIT.
>   *
> - * Optionally call leave_mm() for the target CPU upfront to avoid wakeups due to
> - * flushing user TLBs.
> - *
>   * Must be called under local_irq_disable().
>   */
>  static __cpuidle int intel_idle(struct cpuidle_device *dev,
>

Assuming no objections, so applied.
