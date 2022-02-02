Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF204A7BB4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 00:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245463AbiBBXck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 18:32:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiBBXcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 18:32:39 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3F4C061714
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 15:32:39 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id j2so3710992ybu.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 15:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=byrkm3UMSeryX4zV8ryjnY4LbjJvq7rOWthKpxmPjbI=;
        b=CWG5Yse863xA+HI1TXpjCjj1kERodLdayzjAOQv4TF/JrBx0nz/0KGEDQdjNqhzuJr
         1Cjk7gJydEldrj7bflgGPLMz1g8is2ys4Bj3Oda54N1oKkK609kKyeEeAr+0nYqNGg9n
         HYJPCfUhHvHV1dZc5SFt1xLbunJ3ambfE2E9+Mm0FPU/8UHUINjNG5KeJovCXX1WHbjV
         3fHEmt+s5hIwFS+ZDH5QFtA1aqhL1ljsP2xeZINXwBKrDwtRLWqvgk44gVMeWhTrETA1
         AF0PL/iS95FZnvdtSaLqhB+WKZUAD+Vmj5rMdzeLsC3t6XsfKcM0dNQqu8/wqaF5RKrC
         oswQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=byrkm3UMSeryX4zV8ryjnY4LbjJvq7rOWthKpxmPjbI=;
        b=OZ9B4J94nFLA41UAi3P5XQTjd1Ec3qk9W5V2rY+DbSg0pRlqvQ5FDXo59T9igMP9wS
         Xjw3J+4bgFsieMdTokbVQZLKT2/w/qzmz2qtLw05kl/RJIVmtsWIhuqcRV2LguzK+uQm
         AyLk1H4ooEw/iUZcxHB3XL9Cvp5GJ67U/mzEOHal6eF91MbDfv4LM67a8lbzOBgjlITP
         gVdzFizbcseHk7USESO0hfYzy5RUm7MGdo5ZEp4+Lb80mqxlwepdjWTn3nOUP3p4WduH
         CTtWpSyogOMpvW5TMRUzKud0zyeMG19ZE3OIaPc7HOIGdrTVPwGwFg+jllKyv71+nBiN
         Jgqw==
X-Gm-Message-State: AOAM5333HyO7j0I3LkYIv4dIc5k+KPSzXn2H7ysGeikiAErwrz4Av28v
        dsYSFCFjKx33kwpLed97P/DwTnqifvEz3BQoUn79NQ==
X-Google-Smtp-Source: ABdhPJzE6raW9cxMKVmdHpA5FX4Kla0UbbuW2dYlBBFWZs6vSDwPoSzDRkTZTpfzGN72b+38Z9DU9wgpEB5IXiKv8yQ=
X-Received: by 2002:a0d:f244:: with SMTP id b65mr2578966ywf.2.1643844758230;
 Wed, 02 Feb 2022 15:32:38 -0800 (PST)
MIME-Version: 1.0
References: <20220115002649.1526163-1-linus.walleij@linaro.org>
In-Reply-To: <20220115002649.1526163-1-linus.walleij@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 3 Feb 2022 00:32:26 +0100
Message-ID: <CACRpkdZPdg7koKf1RkRNzDgF_V-XsEod5C4JA10ps7G7fUwaXw@mail.gmail.com>
Subject: Re: [PATCH] mfd: ab8500: Rewrite bindings in YAML
To:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 15, 2022 at 1:28 AM Linus Walleij <linus.walleij@linaro.org> wrote:

> This rewrites the former text based AB8500 bindings in YAML.

Is this something we can merge?

These MFD bindings become large and complex so I
add Rob on the To-line so he can have a look if he has
time.

Yours,
Linus Walleij
