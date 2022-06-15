Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4A154C279
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 09:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345988AbiFOHL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 03:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346072AbiFOHLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 03:11:19 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D2645AC9;
        Wed, 15 Jun 2022 00:11:18 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id t3-20020a17090a510300b001ea87ef9a3dso1189960pjh.4;
        Wed, 15 Jun 2022 00:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=GMOK2pdGM9oBo0DGilUdzXqbnHYsB6SYWCWDSNKdZOw=;
        b=ZrQ7LY8ytWI1IHWrHOJxAIMxwrLeNe2D9sJtl67o/S5gDFIrQo7hp3jtCtgnJ4v/2v
         /GDAgmj3Y06vlmR6Hu4Q6jJXoyhFmwa2iyOkv0GTGH24g6DcJjaFTMDdIFJt/9FH7mqC
         xdJkbmY+2wFIbgK7VjaU+H2/E3pmRorapsItFuKzEDyrEt0UYGLH4GDNnuyurN77otB0
         45ZeoDRTpWNVuUkqA8Y+D5x3glKhHlqbU2MaHS0VOcy9lfXlquITRGZ3iakmmd8JnxA9
         nXPC7OUH+KtkixpKEF1VXyANqK6LvIgwCZ6Zrc5CoO5g2KYQ8ipEbKsrThY4eCbXSsuC
         xBjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GMOK2pdGM9oBo0DGilUdzXqbnHYsB6SYWCWDSNKdZOw=;
        b=ASga3gVwpMyYe3qJiTOji8E3AlYm1KSTAL/J2gZa7NiHB4lPMZCqF4ZJZzVcd0pvPq
         DClhDcsjChgEmiGOpfyruu5xmimWj1OJUREmKMStXqNU3pK1IYdJqSCbdDO2WIRshLZi
         s1Z3/sXTvqrVjROPWnC7qp8cd6UJ1uq+tu9+sd95+vBnOK0fy0lkoPCCnYpB7IC8Hm7/
         wQwFVicq9S8+Zh+1mrFOp1CdsEjYpkBXaR9fv2nm5DrLQZqa8WqEmaZEgmSPpBYoF3eQ
         ZTLMyLJmgUMB9LVg+TTGNCrisP7Sl/bMpYm2HXiy1lXOjCIv8TgeHfl3otWwCFQsuP02
         cR2A==
X-Gm-Message-State: AJIora/0QtngOxZVcSbTetD9djZhLZ6uvMluZlylLZbOBmVy7ArItkw7
        L79pLwr+tjXdXu5FNf9cpOw=
X-Google-Smtp-Source: AGRyM1sdvhA4GDMk4e4uKjEzjKHVXpTkcA0sx91u7LeLf+6i0AW/sj0gfsL2Eo/9qsTvdENMBkYb7A==
X-Received: by 2002:a17:902:9f98:b0:168:abe3:c23d with SMTP id g24-20020a1709029f9800b00168abe3c23dmr8145323plq.131.1655277077392;
        Wed, 15 Jun 2022 00:11:17 -0700 (PDT)
Received: from [172.30.1.37] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id x29-20020aa79a5d000000b0050dc76281a2sm8916595pfj.124.2022.06.15.00.11.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 00:11:16 -0700 (PDT)
Message-ID: <5848a10e-e5bf-108f-3e3e-15e16332922d@gmail.com>
Date:   Wed, 15 Jun 2022 16:11:13 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 2/4] PM / devfreq: Fix kernel warning with cpufreq
 passive register fail
Content-Language: en-US
To:     Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        Saravana Kannan <skannan@codeaurora.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220614230950.426-1-ansuelsmth@gmail.com>
 <20220614230950.426-3-ansuelsmth@gmail.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <20220614230950.426-3-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22. 6. 15. 08:09, Christian 'Ansuel' Marangi wrote:
> When the cpufreq passive register path from the passive governor fails,
> the cpufreq_passive_unregister is called and a kernel WARNING is always
> reported.
> This is caused by the fact that the devfreq driver already call the
> governor unregister with the GOV_STOP, for this reason the second
> cpufreq_passive_unregister always return error and a WARN is printed
> from the WARN_ON function.
> Remove the unregister call from the error handling of the cpufreq register
> notifier as it's fundamentally wrong and already handled by the devfreq
> core code.
> 
> Fixes: a03dacb0316f ("PM / devfreq: Add cpu based scaling support to passive governor")
> Signed-off-by: Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/devfreq/governor_passive.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
> index 95de336f20d5..dcc9dd518197 100644
> --- a/drivers/devfreq/governor_passive.c
> +++ b/drivers/devfreq/governor_passive.c
> @@ -331,7 +331,6 @@ static int cpufreq_passive_register_notifier(struct devfreq *devfreq)
>  err_put_policy:
>  	cpufreq_cpu_put(policy);
>  err:
> -	WARN_ON(cpufreq_passive_unregister_notifier(devfreq));
>  
>  	return ret;
>  }

I think that it is necessary to free the resource when error happen.
Also, after merging the your patch1, I think that cpufreq_passive_unregister_notifier(devfreq)
will not return error. Instead, just 0 for success.

Instead, 'err_free_cpu_data' and 'err_put_policy' goto statement are wrong exception
handling. If fix the exception handling code in cpufreq_passive_register_notifier
as following and with your patch1, I'll handle the resource for free/un-registration
when error happen during cpufreq_passive_register_notifier.


diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
index a35b39ac656c..0246e0731fc0 100644
--- a/drivers/devfreq/governor_passive.c
+++ b/drivers/devfreq/governor_passive.c
@@ -289,22 +289,23 @@ static int cpufreq_passive_register_notifier(struct devfreq *devfreq)
                parent_cpu_data = kzalloc(sizeof(*parent_cpu_data),
                                                GFP_KERNEL);
                if (!parent_cpu_data) {
+                       cpufreq_cpu_put(policy);
                        ret = -ENOMEM;
-                       goto err_put_policy;
+                       goto err;
                }
 
                cpu_dev = get_cpu_device(cpu);
                if (!cpu_dev) {
                        dev_err(dev, "failed to get cpu device\n");
                        ret = -ENODEV;
-                       goto err_free_cpu_data;
+                       goto err;
                }
 
                opp_table = dev_pm_opp_get_opp_table(cpu_dev);
                if (IS_ERR(opp_table)) {
                        dev_err(dev, "failed to get opp_table of cpu%d\n", cpu);
                        ret = PTR_ERR(opp_table);
-                       goto err_free_cpu_data;
+                       goto err;
                }
 
                parent_cpu_data->dev = cpu_dev;
@@ -326,10 +327,6 @@ static int cpufreq_passive_register_notifier(struct devfreq *devfreq)
 
        return ret;
 
-err_free_cpu_data:
-       kfree(parent_cpu_data);
-err_put_policy:
-       cpufreq_cpu_put(policy);
 err:
        WARN_ON(cpufreq_passive_unregister_notifier(devfreq));
 



-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
