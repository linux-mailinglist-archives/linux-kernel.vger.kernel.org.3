Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C98C557A3DC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 17:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239682AbiGSP72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 11:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239700AbiGSP70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 11:59:26 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A565B7B8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 08:59:24 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id r186so13883048pgr.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 08:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BkXADhoZ3PrMurS+Fkws39i8gQMDegrACihLWlAJE+0=;
        b=e+vDG57tBE4LWjAEDnC32kddYMSayHrqR/j7fKLi8Ea+6eU+GE/nsFtzwKahnjFpV+
         gHFveQSMnBqT8ZeWEhWwd6JyxVtt+C+9Cfs2gc/4Lr8LVu6XpjF5pZUopcV+LMro3Pe0
         X13R1yr7+z5Q/D4VmfCQqRu8abYMFWoKQscp3YpPem+sQIYC0W4tZ94YmfezfrXrS0Wh
         +MFPd0lDx2VJckOuI3RR8WaWswhAUi3cZILkWPCck+1POvhUip4pWUezVEM+NfiM/3AA
         RkgfaYtqcgtEaoSQRlc6Fa2Jf8nCy1nWoYyedb2NKHMWvJwFzm/G8UvjGJRsO2zHnlM1
         eq1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BkXADhoZ3PrMurS+Fkws39i8gQMDegrACihLWlAJE+0=;
        b=yGq1bq8aBy6rfTnOjPSDKOvXPhsTWX6vDoO6z9fj8w11/t4S/Arrppy+4sBhwPBNvQ
         LlxbwSlsEbMdah5SmjG0rLaoqrqqFLPCkr35nxvyqlUQa0opBO3pwL2TcGAPdiNTHwXL
         itIHuWdllL/pSR5unWCn9x/VZ/K0rMUv1543mVL9+0Jucd+TGNBxb0DQimd4nbXUZPdH
         YCGPm7QwgRwDHqgEc2zgoWIvzHPoV6+AjsuSwWXyqcOBpLqOExrhDTQIp8z7iwQZuLnp
         IN0hV3vQux2RJb6YLlsbqmhTlM7X39fpcvlTJqT8dZY+MbuKu1CFhGuLQnB5a8B5RjRo
         10qQ==
X-Gm-Message-State: AJIora8tqBLg/E1a7qf/0SYbSt+b6yAUz+xSO5Cpc9rCL4qpcgFkCx4J
        bM8wZjgJxz2TTrTi3wPHAmQopptn6v3AJehXI6sHHg==
X-Google-Smtp-Source: AGRyM1sVsQD8x2S48ThUQZccr48K1ZqnJ9M7o2eTc0oOJZlWk2UAT1voE2YR2aFeRp8n4WMuOuikHt4EkdxaBF7ReEI=
X-Received: by 2002:a05:6a00:24c1:b0:51c:784:cb59 with SMTP id
 d1-20020a056a0024c100b0051c0784cb59mr34442782pfv.57.1658246364138; Tue, 19
 Jul 2022 08:59:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220705122244.472894-2-Naresh.Solanki@9elements.com>
 <20220705122244.472894-4-Naresh.Solanki@9elements.com> <c03fd83f-97b3-1837-b7fd-5f3f28c4b557@gmail.com>
In-Reply-To: <c03fd83f-97b3-1837-b7fd-5f3f28c4b557@gmail.com>
From:   Naresh Solanki <naresh.solanki@9elements.com>
Date:   Tue, 19 Jul 2022 21:29:15 +0530
Message-ID: <CABqG17gL=7TJHNowpM8OJD4Pmezp5iVmAKx4csmakrTpp5bUkA@mail.gmail.com>
Subject: Re: [PATCH 3/5] regulator: max597x: Add support for max597x regulator
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Marcello Sylvester Bauer <sylv@sylv.io>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I like the way the IRQ helpers have been used here. It'd be cool to hear
> how the rest of the system you're dealing with utilize the WARN level
> events :)
>
Userspace applications would receive sysfs notify for these events in realtime
(there is another patch that enables sysfs notify on regulator events)
This will enable taking necessary action if the regulator is not in good state.

> > +static int max597x_set_ocp(struct regulator_dev *rdev, int lim_uA,
> > +                        int severity, bool enable)
> > +{
> > +     int ret, val, reg;
> > +     unsigned int vthst, vthfst;
> > +
> > +     struct max597x_regulator *data = rdev_get_drvdata(rdev);
> > +     int rdev_id = rdev_get_id(rdev);
> > +     /*
> > +      * MAX5970 doesn't has enable control for ocp.
> > +      * If limit is specified but enable is not set then hold the value in
> > +      * variable & later use it when ocp needs to be enabled.
> > +      */
>
> Is this a possible scenario? I think that if a non zero limit is given
> in a "regulator-oc-protection-microamp"-property, then the protection
> should always be enabled. Am I overlooking something?
>
Yes in the current scenario, if non-zero ocp is provided then
protection should always be enabled.
But since there is an enable switch in function call, I felt like it
should be addressed in this way.

> > +static int max597x_irq_handler(int irq, struct regulator_irq_data *rid,
> > +                            unsigned long *dev_mask)
> > +{
> > +     struct regulator_err_state *stat;
> > +     struct max597x_regulator *d = (struct max597x_regulator *)rid->data;
> > +     int val, ret, i;
> > + > + ret = max597x_regmap_read_clear(d->regmap, MAX5970_REG_FAULT0, &val);
> > +     if (ret)
> > +             return REGULATOR_FAILED_RETRY;
>
> This "read_clear" smells like a race-by-design to me...
>
I'm not sure what best way would be to address this but if Under/Over
Voltage & Over current scenario
occurs then the interrupt line remains low until things are normal.
The fault register bit can be clear only if output is normal or power cycled.



> > +
> > +     *dev_mask = 0;
> > +     for (i = 0; i < d->num_switches; i++) {
> > +             stat = &rid->states[i];
> > +             stat->notifs = 0;
> > +             stat->errors = 0;
> > +     }
> > +
> > +     for (i = 0; i < d->num_switches; i++) {
> > +             stat = &rid->states[i];
> > +
> > +             if (val & UV_STATUS_CRIT(i)) {
> > +                     *dev_mask |= 1 << i;
> > +                     stat->notifs |= REGULATOR_EVENT_UNDER_VOLTAGE;
> > +                     stat->errors |= REGULATOR_ERROR_UNDER_VOLTAGE;
> > +             } else if (val & UV_STATUS_WARN(i)) {
> > +                     *dev_mask |= 1 << i;
> > +                     stat->notifs |= REGULATOR_EVENT_UNDER_VOLTAGE_WARN;
> > +                     stat->errors |= REGULATOR_ERROR_UNDER_VOLTAGE_WARN;
> > +             }
> > +     }
> > +
> > +     ret = max597x_regmap_read_clear(d->regmap, MAX5970_REG_FAULT1, &val);
> > +     if (ret)
> > +             return REGULATOR_FAILED_RETRY;
>
> ... and same here...
>
> > +
> > +     for (i = 0; i < d->num_switches; i++) {
> > +             stat = &rid->states[i];
> > +
> > +             if (val & OV_STATUS_CRIT(i)) {
> > +                     *dev_mask |= 1 << i;
> > +                     stat->notifs |= REGULATOR_EVENT_REGULATION_OUT;
> > +                     stat->errors |= REGULATOR_ERROR_REGULATION_OUT;
> > +             } else if (val & OV_STATUS_WARN(i)) {
> > +                     *dev_mask |= 1 << i;
> > +                     stat->notifs |= REGULATOR_EVENT_OVER_VOLTAGE_WARN;
> > +                     stat->errors |= REGULATOR_ERROR_OVER_VOLTAGE_WARN;
> > +             }
> > +     }
> > +
> > +     ret = max597x_regmap_read_clear(d->regmap, MAX5970_REG_FAULT2, &val);
> > +     if (ret)
> > +             return REGULATOR_FAILED_RETRY;
> > +
>
> ... and here. I wonder if the reason for "clearing" would be worth
> commenting?
>
> > +     for (i = 0; i < d->num_switches; i++) {
> > +             stat = &rid->states[i];
> > +
> > +             if (val & OC_STATUS_WARN(i)) {
> > +                     *dev_mask |= 1 << i;
> > +                     stat->notifs |= REGULATOR_EVENT_OVER_CURRENT_WARN;
> > +                     stat->errors |= REGULATOR_ERROR_OVER_CURRENT_WARN;
> > +             }
> > +     }
> > +
> > +     ret = regmap_read(d->regmap, MAX5970_REG_STATUS0, &val);
> > +     if (ret)
> > +             return REGULATOR_FAILED_RETRY;
> > +
> > +     for (i = 0; i < d->num_switches; i++) {
> > +             stat = &rid->states[i];
> > +
> > +             if ((val & MAX5970_CB_IFAULTF(i))
> > +                 || (val & MAX5970_CB_IFAULTS(i))) {
> > +                     *dev_mask |= 1 << i;
> > +                     stat->notifs |=
> > +                         REGULATOR_EVENT_OVER_CURRENT |
> > +                         REGULATOR_EVENT_DISABLE;
> > +                     stat->errors |=
> > +                         REGULATOR_ERROR_OVER_CURRENT | REGULATOR_ERROR_FAIL;
> > +
> > +                     /* Clear the sub-IRQ status */
> > +                     regulator_disable_regmap(stat->rdev);
> > +             }
> > +     }
> > +     return 0;
> > +}
> > +
>
> --
> Matti Vaittinen
> Linux kernel developer at ROHM Semiconductors
> Oulu Finland
>
> ~~ When things go utterly wrong vim users can always type :help! ~~
>
> Discuss - Estimate - Plan - Report and finally accomplish this:
> void do_work(int time) __attribute__ ((const));
>
