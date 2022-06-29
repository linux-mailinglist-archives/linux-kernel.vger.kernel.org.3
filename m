Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8083560A53
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 21:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbiF2Tb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 15:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiF2Tb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 15:31:56 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33AE31402F;
        Wed, 29 Jun 2022 12:31:56 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id x1-20020a17090abc8100b001ec7f8a51f5so503288pjr.0;
        Wed, 29 Jun 2022 12:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=jYmbPjWKjblF3Fbvn5D7snSMKd9hjTzx+uVhX6b92oQ=;
        b=WH87GyqrupEFl05RzR4g5wzqLrb890Xo8u9ZNHJ+AIX97hcciUZdOgIZh87YWgdQm0
         T2o5WE4L2Qbac+DFg5E/EwuT79dqm9+s4L4DneL4z9jVaXvIFBmQXtm+MffVl+vsW0fT
         GRZibCs5H1LHbC9jHG/kCbpEJDupJt+lkWm/Yt8CqUoqKSCEov33m4PTef3JaQktE9Ry
         bpq8BYomvObC5cozfUf74rY9ULK7lyoMUS7myK+0wAHxRDt7Jn6GsAvHs3kO01swdmYE
         BqS9mqbRfyj/ufRA0x27ojiBczoUah5EHkhAlwhQKEasbjg9OssuCpOr9XvmOhAzD96t
         lxAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jYmbPjWKjblF3Fbvn5D7snSMKd9hjTzx+uVhX6b92oQ=;
        b=kun8BiiQl1XwT2pJbfCMqCWaBAlc9JghbUq3aQAa7Ein+kSkcwb7FzeAAvLTyv+rx1
         pFy7yDCuQMW+UXWuaO94qnPpojCATzRBmTdkWJHpgCUGNiNFIWZI1GUTXo/87vg8YPoA
         uW3zACnS7uHywHwaBiDQWdj278H+HZnXOiC7+EqdshjPAKIB7m1juWE855q0eSYswVDG
         321PTUvdHbszgGkhNm1aobge+DX18tYZw1ZXMdTiRaJ3M0boL5V8KuKUbCIFt+ElUuO/
         6VZnuFAdc1iaZi9zNXUwy4qvQe5LGnfG/PgMyAnjM3JDRyFvsG6BGs+BmZIxSY66Lx5L
         ht0A==
X-Gm-Message-State: AJIora/QflLzaMypjI5YwPdF8A3nwNH4Qf4yZyv5m82eNFPkFjZaQkUf
        FStyv5hg624g6vcXv6J+wjk=
X-Google-Smtp-Source: AGRyM1tDIKZpKQtLvsksnXuYUjag9Ap7LacWq35dvAXGQC0NZYh/aOQJoGkWbDlEwanzGB/U/NGszA==
X-Received: by 2002:a17:90b:4c86:b0:1ec:cc0f:32da with SMTP id my6-20020a17090b4c8600b001eccc0f32damr7507818pjb.66.1656531115687;
        Wed, 29 Jun 2022 12:31:55 -0700 (PDT)
Received: from [172.30.1.37] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id a8-20020a656048000000b003db7de758besm11796699pgp.5.2022.06.29.12.31.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 12:31:55 -0700 (PDT)
Message-ID: <b6abe557-029d-cf2b-db79-40630fafb5f1@gmail.com>
Date:   Thu, 30 Jun 2022 04:31:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 08/22] devfreq: shut up kernel-doc warnings
Content-Language: en-US
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <cover.1656409369.git.mchehab@kernel.org>
 <6a15081e17d78e914526c315d5bb53ea575edf90.1656409369.git.mchehab@kernel.org>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <6a15081e17d78e914526c315d5bb53ea575edf90.1656409369.git.mchehab@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22. 6. 28. 18:46, Mauro Carvalho Chehab wrote:
> There are 4 warnings there:
> 	drivers/devfreq/devfreq.c:707: warning: Function parameter or member 'val' not described in 'qos_min_notifier_call'
> 	drivers/devfreq/devfreq.c:707: warning: Function parameter or member 'ptr' not described in 'qos_min_notifier_call'
> 	drivers/devfreq/devfreq.c:717: warning: Function parameter or member 'val' not described in 'qos_max_notifier_call'
> 	drivers/devfreq/devfreq.c:717: warning: Function parameter or member 'ptr' not described in 'qos_max_notifier_call'
> 
> It turns that neither val nor ptr are actually used on those
> function, so document as such.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> ---
> 
> To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
> See [PATCH 00/22] at: https://lore.kernel.org/all/cover.1656409369.git.mchehab@kernel.org/
> 
>  drivers/devfreq/devfreq.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 01474daf4548..3020855d8400 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -700,6 +700,8 @@ static int qos_notifier_call(struct devfreq *devfreq)
>  /**
>   * qos_min_notifier_call() - Callback for QoS min_freq changes.
>   * @nb:		Should be devfreq->nb_min
> + * @val:	not used
> + * @ptr:	not used
>   */
>  static int qos_min_notifier_call(struct notifier_block *nb,
>  					 unsigned long val, void *ptr)
> @@ -710,6 +712,8 @@ static int qos_min_notifier_call(struct notifier_block *nb,
>  /**
>   * qos_max_notifier_call() - Callback for QoS max_freq changes.
>   * @nb:		Should be devfreq->nb_max
> + * @val:	not used
> + * @ptr:	not used
>   */
>  static int qos_max_notifier_call(struct notifier_block *nb,
>  					 unsigned long val, void *ptr)

Applied it. Thanks.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
