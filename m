Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10285468BF0
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 16:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235924AbhLEPqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 10:46:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236221AbhLEPqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 10:46:06 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F63C061714;
        Sun,  5 Dec 2021 07:42:39 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id e3so32870670edu.4;
        Sun, 05 Dec 2021 07:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=uPhNvczeuSunjNtIHb635StOQzdWe5hSGlJOVerCe70=;
        b=AShHHdFzo/7Fw5V2v01+h5zTFl1DEJtXY04/5Pd6XjF5unBpg8/mpkD3FT6C/j//lV
         CCqHG5v/6IWhxdkhfkJSyoB3PPcjKYhUTqd2xETGDp7439V/12PKg1Gjwr5ncwna14RI
         ns1kd+8GIpIfPpUpRTYxEydmp+fda9uABXPUXYD5BOdmSM6u+hePrY68GiQKokNIeaQ+
         u4m1fPU8jRZ9cakLFzmTNSGK4iyBrVtnBplS+QaS5rSCrLa0zRrEHDvg1xqQUtNTPPkP
         PvGAxBzs0sL7wseo6l/jts4SDBFdBo5go7+IStpQtb7YYN0l0X8PU+LSPlaQObUN4c/j
         XRJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=uPhNvczeuSunjNtIHb635StOQzdWe5hSGlJOVerCe70=;
        b=dF95hcaF50Q70GYDzXjyJCxPIzBDeChuOPoiVYuv7vQIjg0J5fsREJjRneytvQOSfQ
         AZJihnbdRIVd5EouFFGhhKcWFPuNz6vtNUlLGRUPzm7eRSo0ogmT0jUmtAcCiSLAqDSq
         alp+noBT0B3fw+3dutyvRSLQAvx6hN4PrcRtF7js1NHgsSvu393hAzxYKLEm4filsDo2
         Ble+Qobn87Z1lAzRPJytnvJq713qk6aKTbDyXemo78OYuaDqp94Cs3TLSIKzsnULRuAB
         uevmBZGzGtZl3hOZ9OKtmmLgZDA4f228iGkEd4M2uYBKRkr9D+ojxlPqlhnGtz2hl7y4
         4b2g==
X-Gm-Message-State: AOAM530joAK0ShT7RwDVv1gywnJjb0Qy5EDF4xi4U0Sz61DKLL/OoAIB
        eQibF0WD8BIcwBySXT6VDNw=
X-Google-Smtp-Source: ABdhPJyDvq3mVFxjeVmdQzh+3GTCIxa+91K4K5U0Tont7GnRAgOdwRKi2+kgf1u5AInXTiwrz1ZWoQ==
X-Received: by 2002:a17:906:d930:: with SMTP id rn16mr40668186ejb.223.1638718957716;
        Sun, 05 Dec 2021 07:42:37 -0800 (PST)
Received: from ?IPv6:2a02:ab88:368f:2080:eab:126a:947d:3008? ([2a02:ab88:368f:2080:eab:126a:947d:3008])
        by smtp.gmail.com with ESMTPSA id j4sm5991820edk.64.2021.12.05.07.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 07:42:37 -0800 (PST)
Message-ID: <b5d698b430b45b1b29e28b33b62702dd7deeaa76.camel@gmail.com>
Subject: Re: [PATCH 0/6] Initial Samsung Galaxy A8 (2018) support
From:   David Virag <virag.david003@gmail.com>
To:     Sam Protsenko <semen.protsenko@linaro.org>
Cc:     Sam Protsenko <semen.protsenko@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Date:   Sun, 05 Dec 2021 16:41:53 +0100
In-Reply-To: <20211205153302.76418-1-virag.david003@gmail.com>
References: <20211205153302.76418-1-virag.david003@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I accidentally forgot to CC Sam Protsenko, so I'll CC him in this
email, so hopefully it gets to him!

I think it would have been important to CC him as he is the author of
the original Exynos850 clock driver that the initial 7885 clock driver
included in this series was based on. I just realized I didn't do it
while the emails were already being sent.

Best Regards,
David
