Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7614473D35
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 07:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbhLNG2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 01:28:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbhLNG2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 01:28:30 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32C6C061574;
        Mon, 13 Dec 2021 22:28:29 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id z8so26848152ljz.9;
        Mon, 13 Dec 2021 22:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7Qe23kprRPn15Qn9MlkcTQ60k8cJNysIu/IrgKrQFE8=;
        b=Cng1NsrqT214GmKegZwoXMErHG1XberzdF7SZ7bfQxLzqqqJAF+dWQq+RBi58/6GLR
         6vg0eb7oNky+q6kOBcMIT7Li4m9Lsi27/2wPOeidCDtYftpRdiy4gTGb554lgG1a8Lwf
         1VXAze3bErCnJiaxwiQn/7UTPma5mQbCMKGflVw4YVX99vWEtIIP31sO9QyQV5w9ybml
         bmAYdPX1p9nNuSNlxzr0h0H2xcSRL3lhGV/L6OY8yr2LiHolfmA5tqndp37IhsAW7aEP
         h+/n9MmftXuUyYrwSICBA4sFQCztqr0wZqjexr7QILWTleNV08oOthvwAV8D8vipQrD1
         CCdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7Qe23kprRPn15Qn9MlkcTQ60k8cJNysIu/IrgKrQFE8=;
        b=og2rE0AFA7KqxXYGKzXpla+asye6iu6YEWcHZFm5wzSumrEc5GKkVnOojt3xnR29x5
         96NQWCthKEB5Ax9/PL6MnCO2TnMsscgtknkF3g2Fxduy/te3lQiM6adECEDszK5KJew9
         QNoAK9vxdFDjQlyaFiIZk+itbVKWL3MjV2ncarBkNnS0WUNyP70SlX0e9kHlH8OZ2dMt
         07owPdpx2f2f/W+O7i3jyYq/0Kz0WbOtdcbOubL5ua/mtNCVIJiGCNIIpP3vg/jkVSsD
         1Gl4p3dOSZD5JFf5uO42Vd8jh9Qik8TFFPCCy0pcbkNfqW/wssgTvSXXPdJlA/RU7Ech
         Y/Jw==
X-Gm-Message-State: AOAM53089svImQwgwLuNx2PjKkBEyvL+AHIfZ5aLtPSorza944SKEw3+
        i5BFtzK+72iBrHgeiK0VQ4AYD6LUhT4=
X-Google-Smtp-Source: ABdhPJw5lks3O7sQuk+B+k3101CPYXFP98k09hURVGzhxtsLlNzyxbkJlo7tEMo5LHxb8Lknbv7+1A==
X-Received: by 2002:a2e:a795:: with SMTP id c21mr3113631ljf.239.1639463307855;
        Mon, 13 Dec 2021 22:28:27 -0800 (PST)
Received: from [192.168.2.145] (94-29-63-156.dynamic.spd-mgts.ru. [94.29.63.156])
        by smtp.googlemail.com with ESMTPSA id i3sm1709217lfu.156.2021.12.13.22.28.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Dec 2021 22:28:27 -0800 (PST)
Subject: Re: [PATCH] cpuidle: tegra: fix typo in a comment
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Jason Wang <wangborong@cdjrlc.com>, daniel.lezcano@linaro.org
Cc:     rafael@kernel.org, thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211212033130.64032-1-wangborong@cdjrlc.com>
 <be88a80f-251f-638d-bf29-a0423db53e06@gmail.com>
Message-ID: <1249c2ae-a7f0-3313-5fb1-06840a4f703b@gmail.com>
Date:   Tue, 14 Dec 2021 09:28:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <be88a80f-251f-638d-bf29-a0423db53e06@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

14.12.2021 09:02, Dmitry Osipenko пишет:
> 12.12.2021 06:31, Jason Wang пишет:
>> The double `that' in the comment in line 275 is repeated. Remove one
>> of them from the comment.
>>
>> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
>> ---
>>  drivers/cpuidle/cpuidle-tegra.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/cpuidle/cpuidle-tegra.c b/drivers/cpuidle/cpuidle-tegra.c
>> index 9845629aeb6d..93ed4b8e164a 100644
>> --- a/drivers/cpuidle/cpuidle-tegra.c
>> +++ b/drivers/cpuidle/cpuidle-tegra.c
>> @@ -272,7 +272,7 @@ static int tegra114_enter_s2idle(struct cpuidle_device *dev,
>>   * LP2 | C7	(CPU core power gating)
>>   * LP2 | CC6	(CPU cluster power gating)
>>   *
>> - * Note that that the older CPUIDLE driver versions didn't explicitly
>> + * Note that the older CPUIDLE driver versions didn't explicitly
>>   * differentiate the LP2 states because these states either used the same
>>   * code path or because CC6 wasn't supported.
>>   */
>>
> 
> This might be a candidate for <trivial@kernel.org>.
> 
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#select-the-recipients-for-your-patch
> 

Although, probably not, because documentation should mean only
Documentation/.
