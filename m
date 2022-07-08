Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BAAC56C477
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238743AbiGHT6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 15:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbiGHT6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 15:58:02 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCD472EDB
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 12:58:01 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id e132so23188121pgc.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 12:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=ofSPSGyATRhw1QKz8Y/GGrQNjSANZL/ie3GH9UlS64Y=;
        b=oxp21k/UsKPN5dqxXY5NyplDH7cKXkzux45SO0j8uLAg1cN28MK2gN+lJZLHXZZMbR
         nHInZ0ItmpVY0MWu6e5wCOl0Djf04ea+gKfmM+wNj0AYVudM7qx0NRgUYw63af5SDR4X
         pA6wHJkRm333I2gAcCUJgSnwuFZ/qg2Lbq03d5KX7jIOGHbexeb9DVV8VmyhYRU4w6Gr
         WGe6JOuVkMZr9EgIyiYUT9wRK0E3QvCP+WDoGwLjoTilvmTv4Bn7GlayFt53kJfUgpp6
         iO9pXM6elWHM/q3jaoWGHPZ3OuByyRijYERxj5dT7bMHg2sLxdVbpukCu5RBIXPL47pH
         16iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=ofSPSGyATRhw1QKz8Y/GGrQNjSANZL/ie3GH9UlS64Y=;
        b=re6rEWygtSM8Grrnzizj9CCjKDB9zmfKOdLITkHRzOLBVEJsoDs4B4G7cvtUX1CegR
         6RKejuiFeHzuvn9o2k22qi4MHBULip+3WTmDjSyrBEHdIOIlumghnvNRdXKzpYZlybF5
         tnIiJUyaOjgDiWdE6etSn/y6IzTwUC7kcAl6lgAjCVCDmDSixrxQ8rTGhkFMhjGwuDQd
         GAVCY3YAF3JpBhpcTYm7boIEBn8QypM2HLn519Ogg/SmremUFhnbZUWLGmg4ihiMvQ9Y
         2ooYVP9AJtTv3istEvMuvHaN7UOgPl7Sni9pbnDH9zw+aaS706Cwva5T7hFraijUtuik
         xxng==
X-Gm-Message-State: AJIora81iZnhyM9x65XvwWYjnerx+0r3du/2+14P91+Vp1Qu2I32uKnu
        12vrXmiZs6DhZovqrydN0d5QiIUIEAS+tQ==
X-Google-Smtp-Source: AGRyM1s6miQK8tv1atCB45qytiMiphyjJKt7mdM1+Tlp5hlN64njzEC/+CvrVoieVaR2SJYzeZy7vw==
X-Received: by 2002:a05:6a00:ac7:b0:528:7acb:e445 with SMTP id c7-20020a056a000ac700b005287acbe445mr5616882pfl.14.1657310280701;
        Fri, 08 Jul 2022 12:58:00 -0700 (PDT)
Received: from ArchLinux (ec2-13-59-0-164.us-east-2.compute.amazonaws.com. [13.59.0.164])
        by smtp.gmail.com with ESMTPSA id s5-20020a170902988500b0015e8d4eb27esm30150470plp.200.2022.07.08.12.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 12:58:00 -0700 (PDT)
References: <20220707165014.77127-1-schspa@gmail.com>
 <20220707135329.08cf74b0@gandalf.local.home> <m2h73snqja.fsf@gmail.com>
 <20220708140000.6aa75a50@gandalf.local.home> <m2ilo779f9.fsf@gmail.com>
 <20220708150614.2cda886d@gandalf.local.home> <m28rp3pfhz.fsf@gmail.com>
 <20220708154111.36e662b2@gandalf.local.home>
User-agent: mu4e 1.7.5; emacs 28.1
From:   Schspa Shi <schspa@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] sched/rt: fix bad task migration for rt tasks
Date:   Sat, 09 Jul 2022 03:55:40 +0800
In-reply-to: <20220708154111.36e662b2@gandalf.local.home>
Message-ID: <m2v8s7nzr6.fsf@gmail.com>
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

> On Sat, 09 Jul 2022 03:14:44 +0800
> Schspa Shi <schspa@gmail.com> wrote:
>
>> Steven Rostedt <rostedt@goodmis.org> writes:
>> 
>> > On Sat, 09 Jul 2022 02:19:42 +0800
>> > Schspa Shi <schspa@gmail.com> wrote:
>> >  
>> >> Yes, it's what I did in the V1 patch.
>> >> Link: https://lore.kernel.org/all/20220623182932.58589-1-schspa@gmail.com/
>> >> 
>> >> But I think it's not the best solution for this problem.
>> >> In these scenarios, we still have a chance to make the task run faster
>> >> by retrying to retry to push the currently running task on this CPU away.
>> >> 
>> >> There is more details on V2 patch's replay message.
>> >> Link: https://lore.kernel.org/all/CAMA88TrZ-o4W81Yfw9Wcs3ghoxwpeAKtFejtMTt78GNB0tKaSA@mail.gmail.com/#t  
>> >
>> > The thing is, this situation can only happen if we release the rq lock in
>> > find_lock_lowest_rq(), and we should not be checking for it in the other
>> > cases.
>> >  
>> 
>> If we haven't unlock the rq in find_lock_lowest_rq(), it will return
>> NULL. It won't call this code added.
>> 
>> 	if (unlikely(is_migration_disabled(next_task))) {
>> 		put_task_struct(next_task);
>> 		goto retry;
>> 	}
>
> Because it doesn't need to. If it did not unlock the run queue, there's no
> way that next_task could have run, because we hold the rq lock for
> next_task. Which means that its "migrate_disable" state would not have
> changed from the first time we checked.
>

OK, I get it.

>> 
>> 	deactivate_task(rq, next_task, 0);
>> 	set_task_cpu(next_task, lowest_rq->cpu);
>> 
>> Beside, find_lock_lowest_rq() return NULL doesn't means rq is rleased,
>> We need to add a _find_lock_lowest_rq to get the correct rq released
>> flags?
>
> It it returns NULL it either means that the rq lock was released or that it
> did not find a rq to push to. Which means there's nothing more to do anyway.
>
>> 
>> > Perhaps add the check in find_lock_lowest_rq() and also in the !lowest_rq
>> > case do:
>> >
>> > 		task = pick_next_pushable_task(rq);
>> > 		if (task == next_task) {
>> > +			/*
>> > +			 * If next task has now disabled migrating, see if we
>> > +			 * can push the current task.
>> > +			 */
>> > +			if (unlikely(is_migrate_disabled(task)))
>> > +				goto retry;  
>> 
>> Ahh, It can be added, And do we need this to be a separate PATCH?
>
> Sure.
>
> The "fix" to the crash you see should be in the find_lock_lowest_rq() as I
> suggested. And then you can add this as an optimization.

OK, I will make a V4 patch for this, Please review it then.

>
> -- Steve
>
>> 
>> > 			/*
>> > 			 * The task hasn't migrated, and is still the next
>> > 			 * eligible task, but we failed to find a run-queue
>> > 			 * to push it to.  Do not retry in this case, since
>> > 			 * other CPUs will pull from us when ready.
>> > 			 */
>> > 			goto out;
>> > 		}
>> >
>> > -- Steve  
>> 

-- 
BRs
Schspa Shi
