Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6F2D4A5447
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 01:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbiBAAtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 19:49:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbiBAAti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 19:49:38 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6729EC061714;
        Mon, 31 Jan 2022 16:49:38 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id p12so30549648edq.9;
        Mon, 31 Jan 2022 16:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=RARgbp3ziHgqJwdAQ5KpgTd/M+ZUGVAZa9+lSQVJ96k=;
        b=HtT6XDBMjS1UuNBFkJ0yT2Z3RDXoeYjbKE84Mjn1d6JDMP84LvoPeOGdhOsKk85xFI
         1wspImMxqaTwTg3c7o1WTfzbhxyR9S4XTt7KNWOEOtAJX4ztbQzq0QYW8cU1MLyj2SR9
         F/elTYQQpvw+xs+xIQ8XN7Aqk37qsj255jXuToupQ1YPhvUSLsQe0swqkPlLJj/GyO6B
         4GZAC7Rj6oD4Cx8nIRB+AMR0dauBA/Lbbm5S9Latn7oHcGc2JRzpt5oCQmOJvALujY4L
         ROTEGTpdUHKqcg/wIMHt0KgSptaomcEuCw1yXe34m0hBgCijVd4hAWzC17shN34NUTVf
         LLHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=RARgbp3ziHgqJwdAQ5KpgTd/M+ZUGVAZa9+lSQVJ96k=;
        b=k7sbRrM87B1cOfzX2WO7OJ6Xx8Jp2GtoKcCLREcBitvsutXQFr+WK8t1hpgIk67P/j
         xKZV7Qx0ASxc/0OB0fNKXTP0V+2lYNsJcNWTCqHiEwUHKXS/imHIPyoHQJGAn5gTC4wA
         p3xbY50IhR9SHEE4fjYkNRVN5KrOFF1NweJAgaNvt9lyqI4GngwRfLJmqH+PR0Q7GFwu
         QcRTSrgKJRaTfA8dAFlybyB0IRLMEdGql3fTg8+axuLQc+ul4FaGBJVgaSSq/tzfnEn9
         m30LMo9Jz8JP0au5zHyBcu29/x1q3dyJaRsPPPB0A7u69bqkRprGK6bJuRshm+50UuwP
         Garw==
X-Gm-Message-State: AOAM531lphOsR+lJYmsj5SCqjAJdrv+15h/8FGKZH75ci1VyBfTSlo1q
        eeKozVXEZcEwPDweByiucx0=
X-Google-Smtp-Source: ABdhPJyXKIGyslT2Qo6ReOdkNzk+C59P6xyAbbDYfL2TOdwpxgU8+m/yIHNBwxH75J1z3CVchti63g==
X-Received: by 2002:aa7:d312:: with SMTP id p18mr22152047edq.49.1643676576936;
        Mon, 31 Jan 2022 16:49:36 -0800 (PST)
Received: from ?IPv6:2a02:ab88:368f:2080:eab:126a:947d:3008? ([2a02:ab88:368f:2080:eab:126a:947d:3008])
        by smtp.gmail.com with ESMTPSA id lt12sm13858809ejb.166.2022.01.31.16.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 16:49:36 -0800 (PST)
Message-ID: <5e6a3b378f08a809a05933b3c978a6a320ffe3f2.camel@gmail.com>
Subject: Re: [PATCH v4 7/7] arm64: dts: exynos: Add initial device tree
 support for Exynos7885 SoC
From:   David Virag <virag.david003@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Sam Protsenko <semen.protsenko@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Date:   Tue, 01 Feb 2022 01:47:56 +0100
In-Reply-To: <7941a6b8-4bca-797e-2fa9-ebd82bed70fa@canonical.com>
References: <20211206153124.427102-1-virag.david003@gmail.com>
         <20211206153124.427102-8-virag.david003@gmail.com>
         <7941a6b8-4bca-797e-2fa9-ebd82bed70fa@canonical.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-01-31 at 16:35 +0100, Krzysztof Kozlowski wrote:
> Hi David,
> 
> I hope you are well and did not get discouraged with this patchset.
> The
> clock changes got merged, so if you fix the comments pointed here, I
> could merge it.
> 
> One more change will be needed - use "-gpio-bank" suffix, like here:
> https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git/commit/?h=for-v5.18/dt-pinctrl&id=71b8d1253b7fe0be0ecf79a7249389c8711f0f94
> 
> 
> Best regards,
> Krzysztof

Hi Krzysztof, thanks for reaching out!

I did not get discouraged, in fact I'm excited to be able to do this.
I will send the dts for sure, I just haven't had the time right now for
personal reasons. I expect to be able to send it in a few days!

Thanks, and best regards,
David
