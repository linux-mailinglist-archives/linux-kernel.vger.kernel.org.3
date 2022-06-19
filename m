Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7990E550D67
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 00:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233584AbiFSWTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 18:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiFSWTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 18:19:09 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ABFF6552;
        Sun, 19 Jun 2022 15:19:08 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id g25so17760527ejh.9;
        Sun, 19 Jun 2022 15:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=on0POvUCgt7GzsArUGW4gwOgE1bTFwJ7z64WkTG3Qx8=;
        b=gB2ud1jrw/PXXoe9fnyF9IWSci8cSnQv3vT1MCbcp4nEakH9tam9BEsq6IulL3deZC
         odXgPMHQoImifTqAhlVpZbLTHBthxuA2OHgFfsBjf8oHN2TdOGgBurIRLDzJREEpKbYu
         klO/J+wGIBVYw3aOwyZP64upnwG/PX6WJY90Tt5Cx3C+2Jt+TlHpB65l4KN63AApO79r
         i9CpH+gDQaFaHzJQMC7KTco5Ift3m0OxKDtGXPyJ+Qhc2Qm4iU+QLmbIWRWmhyHFR2dU
         dtNDJBpyQfskoL1biJIRp+adAH7ZYOPdyxAQTsW4QggVhl+kj7Bh8Co1sRNJU8hHXHpL
         D1CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=on0POvUCgt7GzsArUGW4gwOgE1bTFwJ7z64WkTG3Qx8=;
        b=WwJe1ex4RKeu2sZMpCo40MXgnY/GD30sX3fZryItPWMfFcCFCThQrl4FZApBH8cEku
         cuyaPqSQd6u6oYWijxBvX9FUyp7dzmx/7YhfwtImQVcGGuTg1oJO+9XMHNgDZbetEgYN
         m+G4PJGO8L/IMm8YH9eFl0nUIpdR/AKxR2EPhIEijxadNnJ/9GAyAkaMR34lJaXkw4i5
         LZ7Cl7x2mtnb5GL+v+dDdeiRe0YX42LPakJzJMIgPZGzlVMl9bXnC6k1CHg5a0YYU1t9
         1ID8BDGyD7Epu/gkdSJe7hFA+TFX2oMNFtWb4g05wPQnDNUdd6tvozz7O5/inAf2E6Db
         7TVQ==
X-Gm-Message-State: AJIora8Qp4y5io7ycNfOpAxflp//pb3U5GMaJb1p5wGHcAWj7UhcfmtC
        izqZHbDWsihqX7F9v1WBQLI=
X-Google-Smtp-Source: AGRyM1vJeoH7rtWYt4CDGqPZLZsKX662tw5idl9nOSvnNEsDC1gJYghnkuW6UwSQD2SByZ3+KK9Hbw==
X-Received: by 2002:a17:907:94cb:b0:721:252c:d4bb with SMTP id dn11-20020a17090794cb00b00721252cd4bbmr7536400ejc.148.1655677146627;
        Sun, 19 Jun 2022 15:19:06 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.gmail.com with ESMTPSA id z6-20020a17090665c600b006feb6dee4absm5021204ejn.137.2022.06.19.15.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 15:19:06 -0700 (PDT)
Message-ID: <62afa0da.1c69fb81.34f6.96c4@mx.google.com>
X-Google-Original-Message-ID: <Yq+g132NKP/GhP54@Ansuel-xps.>
Date:   Mon, 20 Jun 2022 00:19:03 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Chanwoo Choi <cwchoi00@gmail.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        Saravana Kannan <skannan@codeaurora.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/4] PM / devfreq: Fix kernel warning with cpufreq
 passive register fail
References: <20220614230950.426-1-ansuelsmth@gmail.com>
 <20220614230950.426-3-ansuelsmth@gmail.com>
 <5848a10e-e5bf-108f-3e3e-15e16332922d@gmail.com>
 <62a9af8f.1c69fb81.56ead.2c48@mx.google.com>
 <8ec38d8c-2ece-dfbb-8435-5963d7e80049@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ec38d8c-2ece-dfbb-8435-5963d7e80049@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 18, 2022 at 04:08:35AM +0900, Chanwoo Choi wrote:
> On 22. 6. 15. 18:20, Ansuel Smith wrote:
> > On Wed, Jun 15, 2022 at 04:11:13PM +0900, Chanwoo Choi wrote:
> >> On 22. 6. 15. 08:09, Christian 'Ansuel' Marangi wrote:
> >>> When the cpufreq passive register path from the passive governor fails,
> >>> the cpufreq_passive_unregister is called and a kernel WARNING is always
> >>> reported.
> 
> >>> This is caused by the fact that the devfreq driver already call the
> >>> governor unregister with the GOV_STOP, for this reason the second
> >>> cpufreq_passive_unregister always return error and a WARN is printed
> >>> from the WARN_ON function.
> 
> >>> Remove the unregister call from the error handling of the cpufreq register
> >>> notifier as it's fundamentally wrong and already handled by the devfreq
> >>> core code.
> 
> If possible, could you make the patch description more simply?
> 
> >>>
> >>> Fixes: a03dacb0316f ("PM / devfreq: Add cpu based scaling support to passive governor")
> >>> Signed-off-by: Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
> >>> ---
> >>>  drivers/devfreq/governor_passive.c | 1 -
> >>>  1 file changed, 1 deletion(-)
> >>>
> >>> diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
> >>> index 95de336f20d5..dcc9dd518197 100644
> >>> --- a/drivers/devfreq/governor_passive.c
> >>> +++ b/drivers/devfreq/governor_passive.c
> >>> @@ -331,7 +331,6 @@ static int cpufreq_passive_register_notifier(struct devfreq *devfreq)
> >>>  err_put_policy:
> >>>  	cpufreq_cpu_put(policy);
> >>>  err:
> >>> -	WARN_ON(cpufreq_passive_unregister_notifier(devfreq));
> >>>  
> >>>  	return ret;
> >>>  }
> >>
> >> I think that it is necessary to free the resource when error happen.
> > 
> > Thing is that it should not be done in the register. Following the flow
> > of the devfreq core code, if a gov fails to START, the gov STOP is
> > called and we correctly free our resources. In the current
> > implementation we call the free 2 times and the second time will always
> > print error as the notifier is already unregistered.
> > 
> >> Also, after merging the your patch1, I think that cpufreq_passive_unregister_notifier(devfreq)
> >> will not return error. Instead, just 0 for success.
> > 
> > With path1 we removed the error with the parent_cpu_data deletion but
> > the unregister error is still there.
> > 
> >>
> >> Instead, 'err_free_cpu_data' and 'err_put_policy' goto statement are wrong exception
> >> handling. If fix the exception handling code in cpufreq_passive_register_notifier
> >> as following and with your patch1, I'll handle the resource for free/un-registration
> >> when error happen during cpufreq_passive_register_notifier.
> >>
> > 
> > Don't know the main problem here is calling unregister 2 times.
> 
> Ah. I understood. To fix the error path handling with unregister function
> is called twice, I think that need to to fix it as following:
> 
> 
> diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
> index a35b39ac656c..8f38a63beefc 100644
> --- a/drivers/devfreq/governor_passive.c
> +++ b/drivers/devfreq/governor_passive.c
> @@ -289,22 +289,25 @@ static int cpufreq_passive_register_notifier(struct devfreq *devfreq)
>                 parent_cpu_data = kzalloc(sizeof(*parent_cpu_data),
>                                                 GFP_KERNEL);
>                 if (!parent_cpu_data) {
> +                       cpufreq_cpu_put(policy);
>                         ret = -ENOMEM;
> -                       goto err_put_policy;
> +                       goto err;
>                 }
>  
>                 cpu_dev = get_cpu_device(cpu);
>                 if (!cpu_dev) {
>                         dev_err(dev, "failed to get cpu device\n");
> +                       cpufreq_cpu_put(policy);
>                         ret = -ENODEV;
> -                       goto err_free_cpu_data;
> +                       goto err;
>                 }
>  
>                 opp_table = dev_pm_opp_get_opp_table(cpu_dev);
>                 if (IS_ERR(opp_table)) {
>                         dev_err(dev, "failed to get opp_table of cpu%d\n", cpu);
> +                       cpufreq_cpu_put(policy);
>                         ret = PTR_ERR(opp_table);
> -                       goto err_free_cpu_data;
> +                       goto err;
>                 }
>  
>                 parent_cpu_data->dev = cpu_dev;
> @@ -324,15 +327,7 @@ static int cpufreq_passive_register_notifier(struct devfreq *devfreq)
>         if (ret)
>                 dev_err(dev, "failed to update the frequency\n");
>  
> -       return ret;
> -
> -err_free_cpu_data:
> -       kfree(parent_cpu_data);

Wait! This would leak the just allocated parent_cpu_data in case of
error since we return before it's added to the cpu_data_list and it
won't be freed on the unregister function.

I'm sending this patch (since the other got merged) with the description
reworked. Think there isn't another way to have the code linear and
remove the ""double return"".

> -err_put_policy:
> -       cpufreq_cpu_put(policy);
>  err:
> -       WARN_ON(cpufreq_passive_unregister_notifier(devfreq));
> -
>         return ret;
>  }
> 
> 
> -- 
> Best Regards,
> Samsung Electronics
> Chanwoo Choi

-- 
	Ansuel
