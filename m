Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20C2E473CE3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 07:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbhLNGC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 01:02:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbhLNGCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 01:02:23 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEEDBC061574;
        Mon, 13 Dec 2021 22:02:22 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id k2so26806015lji.4;
        Mon, 13 Dec 2021 22:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JPox4HTFV1UZCnU6dN+2eTxEqhdNLrUL/tLAtf5dn78=;
        b=VXFuH2QL8D6R1sls6cI0em1DXONNojMqjdOeNB1qMOyQVk321RI7rldmLDXwPg35Wr
         M9zUkMLA3ftCdg5q9+UNuuR/h1x57Ic/wQ+fH9s6Xv9V20gj09g05+8fycvxaVabSjIg
         O8Oc5MWHPOnJVWASHUQ6be6iuzJF5hMUJSM/6HqsyWJY5U9eM4ZCpMjuc9Brf1VtOLe3
         FMnbyVsrIHxBFkmzPquUa8siW871hLCbFeL+lsqT4ctiRAfPI4ePBycs+WjU3UTRqb5e
         SP/VQdgz3FxBd8i2YQtCjU5gBwLhSm7oJhAyduWV7j2oXDfB0iDWCtxWXhO6mQPV+SmW
         s44Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JPox4HTFV1UZCnU6dN+2eTxEqhdNLrUL/tLAtf5dn78=;
        b=LMIlFvZQGJxDVUnkLifSYlSBoWJX2kT4D0X0yDyHINZ3FG+YWf5tYsiOxA2zr5uE3N
         5StqqtNS3gJmY0H1gw6keO1Jem0xrSsNLUk50roPP13583PGH7zbyYvm9BnfX3Dj/JuZ
         769P9xwdnRDI7Ms7kxUbUFz4r5eHVB70XWfxZeCjCZ/6dAp9fzcFZBttW1lAXLDGmWT8
         R5DHAceA8uMn+IXTu89mIPJMMtl6lmiSbOHdWPHofV31jcgrF5j97iUDE6UsJG/9ylC5
         OJh7+l5RZZsTX4uBnz6MoV/IQLSXZ13Z6xqBtXgRL/GBqC3f6eQ7coBHNkCmj1aYpN5T
         Drcw==
X-Gm-Message-State: AOAM530z9sq3X8nN4Hok8iBSoNfi1iR4SLvhENYHURtnJrxjURZbzX2b
        3FAyND97cN9cP/FuvljZ7OkaA3JyamE=
X-Google-Smtp-Source: ABdhPJxMrjUPQQkutrvXQpLlsZjiqHmlviNxJRoslXBAQEVDwo9/grFad43uvSFRe3LMKk8ExXNsuw==
X-Received: by 2002:a2e:8702:: with SMTP id m2mr2804842lji.55.1639461741017;
        Mon, 13 Dec 2021 22:02:21 -0800 (PST)
Received: from [192.168.2.145] (94-29-63-156.dynamic.spd-mgts.ru. [94.29.63.156])
        by smtp.googlemail.com with ESMTPSA id s15sm1697177lfp.252.2021.12.13.22.02.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Dec 2021 22:02:20 -0800 (PST)
Subject: Re: [PATCH] cpuidle: tegra: fix typo in a comment
To:     Jason Wang <wangborong@cdjrlc.com>, daniel.lezcano@linaro.org
Cc:     rafael@kernel.org, thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211212033130.64032-1-wangborong@cdjrlc.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <be88a80f-251f-638d-bf29-a0423db53e06@gmail.com>
Date:   Tue, 14 Dec 2021 09:02:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211212033130.64032-1-wangborong@cdjrlc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

12.12.2021 06:31, Jason Wang пишет:
> The double `that' in the comment in line 275 is repeated. Remove one
> of them from the comment.
> 
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
> ---
>  drivers/cpuidle/cpuidle-tegra.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpuidle/cpuidle-tegra.c b/drivers/cpuidle/cpuidle-tegra.c
> index 9845629aeb6d..93ed4b8e164a 100644
> --- a/drivers/cpuidle/cpuidle-tegra.c
> +++ b/drivers/cpuidle/cpuidle-tegra.c
> @@ -272,7 +272,7 @@ static int tegra114_enter_s2idle(struct cpuidle_device *dev,
>   * LP2 | C7	(CPU core power gating)
>   * LP2 | CC6	(CPU cluster power gating)
>   *
> - * Note that that the older CPUIDLE driver versions didn't explicitly
> + * Note that the older CPUIDLE driver versions didn't explicitly
>   * differentiate the LP2 states because these states either used the same
>   * code path or because CC6 wasn't supported.
>   */
> 

This might be a candidate for <trivial@kernel.org>.

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#select-the-recipients-for-your-patch
