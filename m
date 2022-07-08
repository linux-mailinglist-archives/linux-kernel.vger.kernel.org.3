Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55EB856C1E5
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239714AbiGHTcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 15:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238588AbiGHTch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 15:32:37 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2445313B9
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 12:32:36 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id z12-20020a17090a7b8c00b001ef84000b8bso2909446pjc.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 12:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=fq4tZGudx4zMCT0nka8BGDxrCmNytAuDG61jPMZlIpo=;
        b=XEhQO2WWBWSdgCgIP3wK1Sx9RuMtx44CGhEkTwFflyhWmLl61zcFvSIQ/1c24IYJwX
         HdkQtxI7E0aCTQ7J4RUShPdrCA1bRypxsH1s3S5pG1zFkYP1eeGc/g1CAk6ZZHxpUwST
         E2xEIqeaa8hkrLJWvNfv2fQFqJURtGUMKE5JY73cF714gxQ4KXwioZdhpby/tPeupjDl
         pCvAJ8aI26v6C+OzN+L3uUoJKEBsevbTLltZrpFy+v7n1sSBuGQ/L5r/qCdGBcGCj4LH
         iotuHZdHxoHTULSWkKOcK0FaKF4UfayCba5qCqCbraJu3IPK5TAfVWSE9qEqkhw55MXv
         kMpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=fq4tZGudx4zMCT0nka8BGDxrCmNytAuDG61jPMZlIpo=;
        b=vRZH35wWUE1vVOVGZ5tswTAh7+HMz3QGgrtK+qzRWHYvUJ8CopdK8hHt2GpqoYqvXm
         DzpxKm2Rp5KLvSLyyP2lGYbXFF+1f9dcX3UPYIB1H6jkjONOQXHA7URwUSvZCD2Y2oP+
         99O/UxxRzDfhBuJSr6mJ9NBuf8atu4jlRom9gZt0A0q1i1boiNcugW+DD1CrLB4j0Vin
         zC7iCnM0qLz89c6+zt5zdfw4czHDmWO4orbunQS58o4r0sz0+JMsg+BAWNsX7ad87X6X
         1pOOUWHNfo48TWIU5AzmXGXez3/RRxemyeyKBevsxgahbsOCAZrwFylrkBB/cOgi7TRR
         rLIQ==
X-Gm-Message-State: AJIora+6jl1795oy2RpDtH/cp+2+KBjLOTp//4Jh2VdBbVTEIMYMRONC
        BTUqqbbDYIP7GAasjXhKUxktcNohTHe6gQ==
X-Google-Smtp-Source: AGRyM1sVnCOtJwD0hsJql4kn2fWn9Z4dPVo+9hdjKrFb3QrR2i1OzlWmGVdlbxdI5sZmrZrnwwI5DQ==
X-Received: by 2002:a17:90b:3e86:b0:1ec:f7e8:e4e4 with SMTP id rj6-20020a17090b3e8600b001ecf7e8e4e4mr1577962pjb.218.1657308755923;
        Fri, 08 Jul 2022 12:32:35 -0700 (PDT)
Received: from ArchLinux (ec2-13-59-0-164.us-east-2.compute.amazonaws.com. [13.59.0.164])
        by smtp.gmail.com with ESMTPSA id c3-20020a170902d48300b0016be702a535sm10951953plg.187.2022.07.08.12.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 12:32:35 -0700 (PDT)
References: <20220707165014.77127-1-schspa@gmail.com>
 <20220707135329.08cf74b0@gandalf.local.home> <m2h73snqja.fsf@gmail.com>
 <20220708140000.6aa75a50@gandalf.local.home> <m2ilo779f9.fsf@gmail.com>
 <20220708150614.2cda886d@gandalf.local.home>
User-agent: mu4e 1.7.5; emacs 28.1
From:   Schspa Shi <schspa@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] sched/rt: fix bad task migration for rt tasks
Date:   Sat, 09 Jul 2022 03:14:44 +0800
In-reply-to: <20220708150614.2cda886d@gandalf.local.home>
Message-ID: <m28rp3pfhz.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Steven Rostedt <rostedt@goodmis.org> writes:

> On Sat, 09 Jul 2022 02:19:42 +0800
> Schspa Shi <schspa@gmail.com> wrote:
>
>> Yes, it's what I did in the V1 patch.
>> Link: https://lore.kernel.org/all/20220623182932.58589-1-schspa@gmail.com/
>> 
>> But I think it's not the best solution for this problem.
>> In these scenarios, we still have a chance to make the task run faster
>> by retrying to retry to push the currently running task on this CPU away.
>> 
>> There is more details on V2 patch's replay message.
>> Link: https://lore.kernel.org/all/CAMA88TrZ-o4W81Yfw9Wcs3ghoxwpeAKtFejtMTt78GNB0tKaSA@mail.gmail.com/#t
>
> The thing is, this situation can only happen if we release the rq lock in
> find_lock_lowest_rq(), and we should not be checking for it in the other
> cases.
>

If we haven't unlock the rq in find_lock_lowest_rq(), it will return
NULL. It won't call this code added.

	if (unlikely(is_migration_disabled(next_task))) {
		put_task_struct(next_task);
		goto retry;
	}

	deactivate_task(rq, next_task, 0);
	set_task_cpu(next_task, lowest_rq->cpu);

Beside, find_lock_lowest_rq() return NULL doesn't means rq is rleased,
We need to add a _find_lock_lowest_rq to get the correct rq released
flags?

> Perhaps add the check in find_lock_lowest_rq() and also in the !lowest_rq
> case do:
>
> 		task = pick_next_pushable_task(rq);
> 		if (task == next_task) {
> +			/*
> +			 * If next task has now disabled migrating, see if we
> +			 * can push the current task.
> +			 */
> +			if (unlikely(is_migrate_disabled(task)))
> +				goto retry;

Ahh, It can be added, And do we need this to be a separate PATCH?

> 			/*
> 			 * The task hasn't migrated, and is still the next
> 			 * eligible task, but we failed to find a run-queue
> 			 * to push it to.  Do not retry in this case, since
> 			 * other CPUs will pull from us when ready.
> 			 */
> 			goto out;
> 		}
>
> -- Steve

-- 
BRs
Schspa Shi
