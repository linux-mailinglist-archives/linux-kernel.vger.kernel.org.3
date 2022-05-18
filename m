Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABFB052B344
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 09:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbiERHTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 03:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbiERHTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 03:19:37 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E506C9C2E2
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 00:19:35 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id bq30so2068072lfb.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 00:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=uE38ie4dSRzW9FDj6U1cSKtlpjyoAmfqSD8WeGqIZ6w=;
        b=V4tVnXW4I9FGwv3pHQXWH7Sx8fdLQJwrMstJPHl9bZRUUYOg2pcGBpvWAR+dvhZaUJ
         dqmWA2BlaNO3fm+y75NRnNuQyxlnntvgL1ujn80JTsUEXmH+5rBDJ/4GlLB0JtH9XvUA
         kPCVtHBTX9rsDDOu4JfQ2Y/gMoBwvuYRwVYcHxO4ZnW1LabVY7w9weZE/IAE1bfyH3Ea
         qNS0Bs1SqwJfcCWeEuf0HDdyAM+WdyWOEjb6g4y1S/LJkRh24jBpAtnRleUXIjQ7ftq6
         iNrbhJD3wgUAD8gLTWCFvF12RdQeYlc3uGh1Y3wex7Zj7s79ZZU2FZFFn+Z3l5bGtRkS
         VR7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uE38ie4dSRzW9FDj6U1cSKtlpjyoAmfqSD8WeGqIZ6w=;
        b=nGBHVEw+8maBbNMTHugOCk5DYmB+YwZBKvrtDl5HMYfn5QkZAVnjHqL2WfCEwt5VpA
         m+oPGXHK6RBfM2d9x//PBdLHz2dKIC2SXmrpe0asAggpR4Qz3T1/w4Fm6wjlwNHNQB9e
         dX9grKRuxzZnth7lIxtlHYi6tDuF81JAomgvuVCUcqoxLPOXbbKQSM5gK9GOUcWc9oC+
         /G/PRhb242tACKNAtNs184obhK3wRROwDP9Fzok94Nar5T0Q38dctFA01qJZ4TD4h9k3
         H8lmjvTk/FiTb+B5xVV1RRIk7T3zzLw2ff2kdjuO5WZhKPbNTf5Uka7IbmgXtmJTwlZn
         KGnw==
X-Gm-Message-State: AOAM5339kG1zsTpGLPxq5R44ivxekHYQlrXY6iz6N+P0maAmy8iXqjGt
        XuWoVmZk5ubGziRB9bTEivXARA==
X-Google-Smtp-Source: ABdhPJzvx8mjcJx30Zvd3j2WPSo0iXGfy8QxdtkLmD+nJl8zb+xMYGpxRy5mCBgHUmVpkdiN9sT7QA==
X-Received: by 2002:a05:6512:3183:b0:473:dffc:18ac with SMTP id i3-20020a056512318300b00473dffc18acmr18907162lfe.217.1652858374048;
        Wed, 18 May 2022 00:19:34 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id h21-20020ac250d5000000b00477b7264806sm125962lfm.9.2022.05.18.00.19.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 00:19:33 -0700 (PDT)
Message-ID: <018b97c2-efab-699d-653d-c220a98f5ec3@linaro.org>
Date:   Wed, 18 May 2022 09:19:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCHv2 6/6] thermal: exynos: Add runtime power management for
 tmu
Content-Language: en-US
To:     Anand Moon <linux.amoon@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
References: <20220515064126.1424-1-linux.amoon@gmail.com>
 <20220515064126.1424-7-linux.amoon@gmail.com>
 <79b727f8-0631-5a96-fbc6-6e5d637bab7d@linaro.org>
 <CANAwSgSY=4zOLjw22GN+a7cc5j=myWWkD7gEQ4_3sgEaTS74Rw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CANAwSgSY=4zOLjw22GN+a7cc5j=myWWkD7gEQ4_3sgEaTS74Rw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/2022 20:45, Anand Moon wrote:
> Hi Krzysztof,
> 
> On Sun, 15 May 2022 at 15:18, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 15/05/2022 08:41, Anand Moon wrote:
>>> Add runtime power management for exynos thermal driver.
>>
>> First of all - why? Second, I do not see it being added. Where are the
>> runtime callbacks?
>>
> 
> To control runtime control PMU, did I miss something?

Controlling runtime PM by itself is not a goal. What does it change if
it is enabled?

> I looked into imx thermal driver # drivers/thermal/imx_thermal.c
> to enable run-time power management for exynos driver.

So you have runtime PM enabled and then what happens? Where is the power
saving? Since you did not implement the callbacks, all this should be
explained in commit msg.


Best regards,
Krzysztof
