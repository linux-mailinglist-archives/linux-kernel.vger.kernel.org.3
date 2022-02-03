Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0D84A88A9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 17:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352256AbiBCQgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 11:36:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352246AbiBCQf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 11:35:58 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40BA1C06173B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 08:35:58 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id m6so10589611ybc.9
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 08:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AH05FNi0eHjnyKWHpwP6aP5DMLc/YvS0qJ8PqKU0jks=;
        b=QnqDWAnXrKKAOcPkQk92Iauc3sa9kAsuMyDMKrp9zQJCzCD2su7lvlStR+xujSpkIH
         D9LVMXEG+GBwzkmTgqTn7PAkEBZZv5OpoXv85f0Aiaxp6ZCuR9SX8f0ppco88eHt/0XH
         n//IrSfq86J1V6SqQg4iF9b1R/Ot5LfCIj8/KiLEW0MaVcZu7w8jztwfPd/mKkm/ldLw
         HotMlGjgYvtRkK31Z8Sc8C7nEd/t19B0rfXJbPAHex0e/zWBYlWjAZ7eF+xQKa3SXXAN
         Xh5S9QAlYHjII1UhFOhQap7oPyfvauq8csAI2C34WU5L+ACo6v0/RXsAHolDjPDX3eVI
         EtCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AH05FNi0eHjnyKWHpwP6aP5DMLc/YvS0qJ8PqKU0jks=;
        b=eWKZH6XUQL0umDzhq+DA5mMqgx7oXcYlbewoEZZjjEaGPAe/TCdDzJGcSUkfyKVcaR
         RphfcbdMyJafaxEO0qQ6m86rfkfqcGw1l27bEYNJOzh0TB/8Ds7IHw3o49khwYOpMXCT
         +ZUZur8+xRS5HFJkFcX2nsnEkdW84H73qmR4af/KVhMkXtRfbhMo5f7bbTx1v1oU3hGu
         9519mjcFh2EdB7jlIRB9D+Xj9y+dXk0tv8iKDLdIhKsIK1aFqdy1Eb/h7PGLMfmLjzRd
         fY3uKlzIXkAlQCE60vmY1EDrD5dsuHpk14dahQq2v+/Uj6FXn8gMO/4hm9RvkAoTYjSJ
         wzFA==
X-Gm-Message-State: AOAM530/Q0t5myl+/bg6ux7A/wIqCnMHZ+GOdKnpf0S5HkmZG903EOj5
        gjRKm8hIucEt8JRpSZ8J4qxfs/zDFNVGRvLlSIFA3A==
X-Google-Smtp-Source: ABdhPJwa+7BO2viz+KvmyLlQG2IVqXMRSJ54OwUetrl3DIY0CC33McuCotiiQ+uVGoEhh/EeBwIAcM3UMG8Wov2yhEQ=
X-Received: by 2002:a05:6902:72f:: with SMTP id l15mr3454839ybt.511.1643906157537;
 Thu, 03 Feb 2022 08:35:57 -0800 (PST)
MIME-Version: 1.0
References: <20220202235049.8051-1-samuel@sholland.org> <20220202235049.8051-3-samuel@sholland.org>
In-Reply-To: <20220202235049.8051-3-samuel@sholland.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 3 Feb 2022 17:35:46 +0100
Message-ID: <CACRpkdYZD5-Tyx=QsT=nfSLHk9_ngSYALJdwyi=S1=n8e6vPUA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: iio: st: Add Silan SC7A20 accelerometer
To:     Samuel Holland <samuel@sholland.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Denis Ciocca <denis.ciocca@st.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 3, 2022 at 12:50 AM Samuel Holland <samuel@sholland.org> wrote:

> This chip is not an ST part, but it appears to be register-compatible
> with the LIS2DH, so it can use the same binding.
>
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
