Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9F3246DBCE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 20:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233550AbhLHTLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 14:11:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232285AbhLHTLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 14:11:14 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503B7C061746;
        Wed,  8 Dec 2021 11:07:42 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id r25so11658450edq.7;
        Wed, 08 Dec 2021 11:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cqg6c8GPTNxn1iTThsV1QNq6rZCOvwgzQTX5X89ySUk=;
        b=XHiQEsBmyzP/7SVxSY7AILyfRrEFTfqtpmNl7wjz9YViTRdo8+B7LlBI44uCX3kJlE
         adZpj1psZPHnPxeDu9UYHm9Ly92vA9VmsozNJAQ5QkXdI9i9906OdF3g2zQ1govYvV5V
         m4iI4DihO+X9WwTakEkWv5WuuLQHrc7tlMXb6GXTuZaYSP9EJgD/kGSDkIT1v4gkdU5p
         1VzO/lk2n2PkJDb0cWvnOzBZ6mHIHrf7KA0y2wzwVbeO67xJXFr6eH8UV0Oa+wS8uVKj
         dnEZyZ244cs5M2n9bkS2BQ1dBxHud4DQ1S6XmCGuUXVgYVmLzN7g4eI8xPKlX5vtNaQ2
         mG0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cqg6c8GPTNxn1iTThsV1QNq6rZCOvwgzQTX5X89ySUk=;
        b=XaBXI8huqm19HsUDxFZK6wJD8ZhHHRvp1trgUFjIjQdTKSKxVBogRt5yVuYhClTZF+
         /Qp82Ihh5W/HOTqQGPRbZEsafrxlPJOI+Yfec6Fi5/Xq8mMs8Dx2nW5S+9658TC+bVmr
         Tk0aB3jcfT7UFRj6bRim2Yu6oxj31AypDDK8KjCLYybM/pbpSpD3M9SNEH0jYsiQEQbI
         K8SrR/bTi5Q50/FOlPEsnLCH6lC9qK1w24+5S/d1BBHcWsYf3cHiT5OtNftS9OYCnTKa
         VGVcdglUVIJd83kZv0639VMYCplY7M8pGxzvErjkjAW3qRU5DcP8IqUgxGM9Lwy6wcTI
         zyXA==
X-Gm-Message-State: AOAM531xgKWhH2IyRDygOtx5jxQFdcV+/lF7bOvfn5HL/j8HsHU96J5X
        r/KKucM0oS5HiOFtOB/tleVBcEPxT+RNOipP
X-Google-Smtp-Source: ABdhPJxHc2LJ8uXX6xkzahGJR7jfwPLp2bD6ZS76HCYbTrYh7XW2ljSlwjCIokkzYP/zznjTzo352A==
X-Received: by 2002:a17:907:6e91:: with SMTP id sh17mr10023526ejc.86.1638990460561;
        Wed, 08 Dec 2021 11:07:40 -0800 (PST)
Received: from [192.168.1.144] (91-139-201-119.stz.ddns.bulsat.com. [91.139.201.119])
        by smtp.gmail.com with ESMTPSA id x7sm2618328edd.28.2021.12.08.11.07.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Dec 2021 11:07:40 -0800 (PST)
Subject: Re: [PATCH] clk: qcom: gcc-msm8974: Modernize the driver
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-clk@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211118153107.8590-1-ivo.ivanov.ivanov1@gmail.com>
 <Ya40B1QkGmWmhSUX@builder.lan>
From:   Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
Message-ID: <8792e6d6-f5a2-3055-8011-4a2f5deb0220@gmail.com>
Date:   Wed, 8 Dec 2021 21:07:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <Ya40B1QkGmWmhSUX@builder.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn, thanks for the review!

> "xo_board" is actually the crystal feeding the PMIC with a reference
> clock, of interest here is that this is split up in the 2 digital and 3
> analog RPM_SMD_CX_{Dx,Ay} clocks. Out of these you have RPM_SMD_CXO_D0
> being wired up on the CXO pin on the msm8974.
> 
> Back when this was devices we didn't have the means of dealing with
> rpmcc as parent to gcc, so you can in gcc_msm8974_probe() find the
> registration of a clock "xo" which is a 19.2MHz clock parented by
> "xo_board".
> 
> As such, the appropriate .name here would be "xo".
> 
> Likewise "xo" (or actually "cxo") would be a better name for the
> DT-based input clock - and it should point to &rpmcc RPM_SMD_CXO_D0
> (iiuc).

I'll try to fix the mentioned issue and send a v2 in series of patches
with other gcc-msm8974 improvements.

Regards,
Ivaylo
