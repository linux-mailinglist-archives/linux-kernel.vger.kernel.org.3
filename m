Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20771523488
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 15:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244038AbiEKNm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 09:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243999AbiEKNmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 09:42:54 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FEB613483C;
        Wed, 11 May 2022 06:42:52 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-ed9ac77cbbso2869592fac.1;
        Wed, 11 May 2022 06:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LmKpLR3KpqpjhFrNdA9cs+ta9/b/YlHR5WXRY1TMskg=;
        b=ANJ9TCDF1OKYyfNeOvsA8MBtwBpDguU0QQxIWOGUvudSGL5OmTzf3AVmw4kvGJmDea
         ve2oPAAYI0Ss6dh3PSe0LFhX3509IZikdKJMzhWsCwlCqkhtiCRvKi23KgfNs2nLugII
         eQqd7Z1F5Ajc1aAZfv8MKrudg8AhoFrjjq/kLnXTG6s9DQHdUibUQPKvS57wzt+pD8rQ
         KL1QrX2Tix9PrcbC/n00g1ZZnakZZgX6oIg+fw7ZU3O7CjTXnzETh2gvWDH1Grdrn6iL
         UiAJLysUmVb3s7FqaLY0DIAu65gRryHR3WegDXnBvYh4LQU8fTVBnwC4QfyFbRasiF83
         D5WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LmKpLR3KpqpjhFrNdA9cs+ta9/b/YlHR5WXRY1TMskg=;
        b=vzPh6gznmeJAU+tT3vBROxrImi6APUlOLV6mdQ3Hy+9oBCP6Q8BH1i0z1IGohVzWVQ
         oKyLOtA9SOpDKsZT4zYWRHWQ/WQTR4A+BlWMtPalCyB32MnuBcQUl1G35xrI8pU/L0qe
         2hFMc7t3PNWryWrJiHL9fMd6PVXdl3RnS05/MNjzCZH88KbkQtbaoxgjyR4IJQBKVRqE
         MhvPSIawWhYMJ75L2SbTnYXYw7AadCqz7Hj0sMuqvozNXIOFhBP5S60UPLSp61tg9RWQ
         fc1PVPftakt18S5bSzWnxMhiUnmkQO/cWxfWvND8FlXiQL/CKuTTVfjVKTCpcrY9VFjH
         lBdw==
X-Gm-Message-State: AOAM532/Yj6WFu51zjDaAv5ysDX/KhwVnFiAAouwul3YvPBapwMTKWWL
        9AmqiRLKhTsyW6K1TdEBKczFDuouLgi95jHIhuKlZk8yUZa6kQ==
X-Google-Smtp-Source: ABdhPJw4C+c+9O2BdWMxl8BajjTI3V9PJaSjwsg6afy8m049UaRA2GEhGHc6WquyAKcySdkZyqhiCfYPTc9MDD0/x/4=
X-Received: by 2002:a05:6870:5b89:b0:e9:bb4c:a6f1 with SMTP id
 em9-20020a0568705b8900b000e9bb4ca6f1mr2767148oab.52.1652276571601; Wed, 11
 May 2022 06:42:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220510035259.5ep52sgahd2a6rie@vireshk-i7> <20220510154236.88753-1-schspa@gmail.com>
 <20220511043515.fn2gz6q3kcpdai5p@vireshk-i7> <CAMA88TpefB=rnqea2u1zEvNUJNE_kdj4mYito7SGCuMj-o071Q@mail.gmail.com>
 <20220511122114.wccgyur6g3qs6fps@vireshk-i7> <CAJZ5v0gN_yDFpvCXRXv8rN-i3TugCi-HKpBKK2z4eWU0Zm1GUg@mail.gmail.com>
 <CAJZ5v0id+7vkqMQEyVRe29oF_dRtzZ0EhoYUn8=yzeENDeABJw@mail.gmail.com>
In-Reply-To: <CAJZ5v0id+7vkqMQEyVRe29oF_dRtzZ0EhoYUn8=yzeENDeABJw@mail.gmail.com>
From:   Schspa Shi <schspa@gmail.com>
Date:   Wed, 11 May 2022 21:42:40 +0800
Message-ID: <CAMA88TpJuJY7oxPFW8xKzch60+n_2qRp7KO2r-YwZxiM7GXF3w@mail.gmail.com>
Subject: Re: [PATCH v3] cpufreq: fix race on cpufreq online
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Rafael J. Wysocki" <rafael@kernel.org> writes:

> On Wed, May 11, 2022 at 2:59 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>
>> On Wed, May 11, 2022 at 2:21 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> >
>> > On 11-05-22, 16:10, Schspa Shi wrote:
>> > > Viresh Kumar <viresh.kumar@linaro.org> writes:
>> > > > I am not sure, but maybe there were issues in calling init() with rwsem held, as
>> > > > it may want to call some API from there.
>> > > >
>> > >
>> > > I have checked all the init() implement of the fellowing files, It should be OK.
>> > > Function find command:
>> > >   ag "init[\s]+=" drivers/cpufreq
>> > >
>> > > All the init() implement only initialize policy object without holding this lock
>> > > and won't call cpufreq APIs need to hold this lock.
>> >
>> > Okay, we can see if someone complains later then :)
>> >
>> > > > I don't think you can do that safely. offline() or exit() may depend on
>> > > > policy->cpus being set to all CPUs.
>> > > OK, I will move this after exit(). and there will be no effect with those
>> > > two APIs. But policy->cpus must be clear before release policy->rwsem.
>> >
>> > Hmm, I don't think depending on the values of policy->cpus is a good idea to be
>> > honest. This design is inviting bugs to come in at another place. We need a
>> > clear flag for this, a new flag or something like policy_list.
>
> Why?
>
>> > Also I see the same bug happening while the policy is removed. The kobject is
>> > put after the rwsem is dropped.
>
> This shouldn't be a problem because of the wait_for_completion() in
> cpufreq_policy_put_kobj().  It is known that cpufreq_sysfs_release()
> has run when cpufreq_policy_put_kobj() returns, so it is safe to free
> the policy then.
>
>> > > >  static inline bool policy_is_inactive(struct cpufreq_policy *policy)
>> > > >  {
>> > > > -     return cpumask_empty(policy->cpus);
>> > > > +     return unlikely(cpumask_empty(policy->cpus) ||
>> > > > +                     list_empty(&policy->policy_list));
>> > > >  }
>> > > >
>> > >
>> > > I don't think this fully solves my problem.
>> > > 1. There is some case which cpufreq_online failed after the policy is added to
>> > >    cpufreq_policy_list.
>> >
>> > And I missed that :(
>> >
>> > > 2. policy->policy_list is not protected by &policy->rwsem, and we
>> > > can't relay on this to
>> > >    indict the policy is fine.
>> >
>> > Ahh..
>> >
>> > > >From this point of view, we can fix this problem through the state of
>> > > this linked list.
>> > > But the above two problems need to be solved first.
>> >
>> > I feel overriding policy_list for this is going to make it complex/messy.
>> >
>> > Maybe something like this then:
>>
>> There are two things.
>>
>> One is the possible race with respect to the sysfs access occurring
>> during failing initialization and the other is that ->offline() or
>> ->exit() can be called with or without holding the policy rwsem
>> depending on the code path.
>>
>> Namely, cpufreq_offline() calls them under the policy rwsem, but
>> cpufreq_remove_dev() calls ->exit() outside the rwsem.  Also they are
>> called outside the rwsem in cpufreq_online().
>>
>> Moreover, ->offline() and ->exit() cannot expect policy->cpus to be
>> populated, because they are called when it is empty from
>> cpufreq_offline().
>>
>> So the $subject patch is correct AFAICS even though it doesn't address
>> all of the above.
>
> TBH, I'm not sure why show() doesn't check policy_is_inactive() under the rwsem.
>

There is a exist bugs, and somebody try to fixed, please see commit
Fixes: 2f66196208c9 ("cpufreq: check if policy is inactive early in
__cpufreq_get()")

> Moreover, I'm not sure why the locking dance in store() is necessary.

The store interface hold cpu_hotplug_lock via
    cpus_read_trylock();
, cannot run in parallel with cpufreq_online() & cpufreq_offline().

---
BRs

Schspa Shi
