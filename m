Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8CB54C23D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 08:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244076AbiFOG4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 02:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237644AbiFOG4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 02:56:37 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3EB3D4A6;
        Tue, 14 Jun 2022 23:56:36 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id i64so10600517pfc.8;
        Tue, 14 Jun 2022 23:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=CMgkFC4hro1vR5myJtP0m6DCab+9w+a2nWaK1KXDdg8=;
        b=DNU9JfpW9p0S0n702nniLd8FFhqCunhLuhEeexHgtNkFPJFCX0fY0sfydMzOcpcGPM
         ntrnKDPlnTR5pC3aBIRUY4rAJg8JTkZhWyl3DTMo8PNAE3YKlOmeS2r6TG4/96+Mfvoa
         hkeQzRVJOCV1So7nNpn9tG7H3DdeWac9OeWO+OEDj1qRCI/NZVNBOty0iE4Z0g7oiCEL
         XjqpdZoMMPIP64F8YGgUe6sGHdPEKfmJ9BsnUQVnc1S5MyaAtkKBHniACf2OhJKq9EuR
         srsF6e77+jhqKagL3GtOv0rqQYdhOdKorI5w4EDrbZ0DJ+EREuce85FVuBnK/Kt8SGdR
         CvHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CMgkFC4hro1vR5myJtP0m6DCab+9w+a2nWaK1KXDdg8=;
        b=k+eJJn6CkCzJ+K0a4Wz0LE61DAvX5hulqA31CFHaybP5ysij7lLeCn0g0f/3HYzL+o
         QAPgGov4inuV7VMeA7XKMGPVELhN7nl5F0eddgBBdeOh6l0BYpaWPiAT6ok8aI/yYKuM
         9KRfB5ONYw+JKM6Ig21CMwJUuLU2pmlPeIREEsRq9H4+tYVtQkvXZsaCRou2omHQQRr8
         OJ5wIJpeb4O4q4oRWpbu+1L3vEcxgJPs+yl78ajhKltrygGBGjse9ZNXzF1dnvXTGDA8
         Vei2xEiLMFMzhZY2pf6ucm8ll3SpkhBK6CMZ8gT3gtqC3X2XVhhILGLhc1wrOGFegb8s
         rPDQ==
X-Gm-Message-State: AOAM5304Um9O/ZNSt/fPo53NH1/NoQd4zyKSPWqkFP6Ee9yMUKQm2AS9
        Gri1tukJqATmZ7gnDa3/o0NmNI4GNbg=
X-Google-Smtp-Source: ABdhPJzdT9b8qTIuHlzzbvFYeiR1F9pWWRgB8ECWRvlf4Oha0//IBH+dkfoEt4ryc7oybrDqJHvp/g==
X-Received: by 2002:a63:6c42:0:b0:3fe:465:7a71 with SMTP id h63-20020a636c42000000b003fe04657a71mr7589011pgc.101.1655276195700;
        Tue, 14 Jun 2022 23:56:35 -0700 (PDT)
Received: from [172.30.1.37] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id j5-20020a17090a840500b001e2bd411079sm875733pjn.20.2022.06.14.23.56.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 23:56:35 -0700 (PDT)
Message-ID: <8dd8bfa2-0843-269b-2d55-e3cbdbf6a5e1@gmail.com>
Date:   Wed, 15 Jun 2022 15:56:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 4/4] PM / devfreq: Mute warning on governor PROBE_DEFER
Content-Language: en-US
To:     Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        Saravana Kannan <skannan@codeaurora.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220614230950.426-1-ansuelsmth@gmail.com>
 <20220614230950.426-5-ansuelsmth@gmail.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <20220614230950.426-5-ansuelsmth@gmail.com>
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
> Don't print warning when a governor PROBE_DEFER as it's not a real
> GOV_START fail.
> 
> Fixes: a03dacb0316f ("PM / devfreq: Add cpu based scaling support to passive governor")
> Signed-off-by: Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/devfreq/devfreq.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 2e2b3b414d67..6a39638ed064 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -931,8 +931,9 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  	err = devfreq->governor->event_handler(devfreq, DEVFREQ_GOV_START,
>  						NULL);
>  	if (err) {
> -		dev_err(dev, "%s: Unable to start governor for the device\n",
> -			__func__);
> +		dev_err_probe(dev, err,
> +			      "%s: Unable to start governor for the device\n",
> +			      __func__);
>  		goto err_init;
>  	}
>  	create_sysfs_files(devfreq, devfreq->governor);


In order to keep the left-align with above error log
when try_then_request_governor() is failed,
I recommend to use the tab without space indentation as following:

If you have no objection, I'll merge this change.

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 01474daf4548..80a1235ef8fb 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -932,8 +932,9 @@ struct devfreq *devfreq_add_device(struct device *dev,
        err = devfreq->governor->event_handler(devfreq, DEVFREQ_GOV_START,
                                                NULL);
        if (err) {
-               dev_err(dev, "%s: Unable to start governor for the device\n",
-                       __func__);
+               dev_err_probe(dev, err,
+                       "%s: Unable to start governor for the device\n",
+                        __func__);
                goto err_init;
        }
        create_sysfs_files(devfreq, devfreq->governor);





-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
