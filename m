Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7635346624E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 12:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357186AbhLBLa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 06:30:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357136AbhLBLaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 06:30:25 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02EAC061757
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 03:27:03 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id j11so16801012pgs.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 03:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zez1rxEqxUa6den/PlCBhFY8prK0HejZIbGceZPfSXw=;
        b=DPqxH0FMX4rAnAr1pchtyHSlHhAZYliOErJIo0K0K7vLF3KTx/rVN+v7emdLAf9sf9
         auuz3FeZsCPJCHzU0WDgMEIpbZ3dXphb7lTY6irmmiCwpgeEVv2ge7hAAL01VEbTZN8v
         SFjTMg/Sm9I9pR8sUzh6kjBUi2Sm/QLBlhtZy3iFnFfioHuM5DX+n+SE4sIoeoPc7X8i
         ob92gmZskSt6xlj8skPpk3CKl77HSXo/7RSy/yliK7Rpxv3WuF2a0UErbLk8HVrEXGR5
         dJUvdXEug8seUadTO2EuJIiEB3TatynOA4rRsM7sEEOdpKZ8stuWzk/1eh5gLOroW7uh
         qNuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zez1rxEqxUa6den/PlCBhFY8prK0HejZIbGceZPfSXw=;
        b=hwnKijSBYtTkmXZgsAPEaG6OrlPfvWZNoywZAqy4H45huyM1jpXs4YrppgRbd0K0Fa
         5OzLJ5YSZEWY5zuc5eji3R2PKLIw1DCtvPT3+uN+nyBajoko1MtkD44hDu/GU/IqMFQS
         iswq0XbvWZH8ArOpqlK/II4wHsmxCeicSf5Yvllp7wDNaWk+RgWzTBCne6znmdzl/XUN
         16AntZqeojAIHSR75a1pLGPM5X/jlS4+HkFe3fWIpqkMClsoav5jUpEtgWLbR/cq/48R
         rImsHzSdAiQws3jZhGbMgssQXIPJBHU3HreOrn6JYNWcLBKl0e3NREzBlFkCVf+Jw4R0
         iAwA==
X-Gm-Message-State: AOAM530Ps1Z3y2xRVSoaw8y/eiEXmxC8q5pqve+CATWdIPaxsR2NToaA
        l2KGv1Knxh5ltVVj+5XPzD9w7Q==
X-Google-Smtp-Source: ABdhPJzH/PVd9bNk2o5EkrDPPp9WP0TgzT0mzFmsPY/nBb6sSAzis/xMBXa0YhWn2cdLzqOn0SWqVA==
X-Received: by 2002:a63:5c05:: with SMTP id q5mr9153548pgb.599.1638444423086;
        Thu, 02 Dec 2021 03:27:03 -0800 (PST)
Received: from localhost ([106.201.42.111])
        by smtp.gmail.com with ESMTPSA id q5sm3528213pfu.66.2021.12.02.03.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 03:27:02 -0800 (PST)
Date:   Thu, 2 Dec 2021 16:57:00 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>, soc@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 0/6] spear: Fix SPEAr3XX plgpio support
Message-ID: <20211202112700.mkjmwibabj2cpr6u@vireshk-i7>
References: <20211202095255.165797-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211202095255.165797-1-herve.codina@bootlin.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-12-21, 10:52, Herve Codina wrote:
> Hi,
> 
> This patch series fixes the plgpio support on SPEAr3xx SOCs.
> 
> The first four patches of this series fixes a ressources
> sharing issue between the plgpio driver and the pinmux
> driver.
> Indeed, these two drivers can use the same IO address range
> on some SPEAr3xx SOCs.
> To solve the issue, a regmap (syscon managed) is used in both
> drivers and the plgpio driver can reference the pinmux regmap
> to use it.
> 
> The second part of this series is related to IRQs.
> The plgpio on SPEAr320s SOC uses an IRQ line in the reserve
> range (from SPEAr320 point of view).
> This issue is fixed enabling all the 'reserved' IRQs and
> adding a dtsi file for the SPEAr320s with the correct interrupt
> for the plgpio node.

Are these changes backwards compatible ? I mean new kernel will work
with old DTBs ? It may be quite important to not break that here.

-- 
viresh
