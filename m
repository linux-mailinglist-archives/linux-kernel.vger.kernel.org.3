Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8B8347C05D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 14:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238071AbhLUNDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 08:03:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbhLUNDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 08:03:42 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32281C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 05:03:42 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id g11so29262761lfu.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 05:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t0Xg3orseU+YFr+9C6yP7N5i5w90bmFHlz28JSF7k/M=;
        b=dS44wMzmgN92SH1GoeY5sHqQjlqo4Bm5r4ZXHFiW+SAkKnuXd93oMfKxWGG2ehBMNa
         AJKSkU9MPdw7C6astpdL+7BbK5YvRjmsFwtv218435gNiSoPeSu+rmHqu5JN04Oq3qd5
         Cdxk1nxVxsLL7ImtKC3iKBauwPQJ7YY3yf+tS0L/57uiX9uyPrCFFMWWxRE0pKFh5Pg2
         6aNXvTN3KW7mc8MW7jpGUevhsWf0feJ9UpozwkfM0OiE6v/ISzGVYdsYATyacJXXtfLI
         8yFvCezNVmOlZcXLmlDbdcxAhy2KckC5RF5jcCjzEiX6QsiiouZYNDmInjY+lEYQr1qZ
         n93A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t0Xg3orseU+YFr+9C6yP7N5i5w90bmFHlz28JSF7k/M=;
        b=fA6N27bTeGcjD3vllRSL04Ml9++njsi/KwyJvKOmGpYMwfIYokFBwfBtiOzkOqyLID
         96QgMiNswsbMKm8AH4P12qj4viDWh3KRwF5nik+8CszguIsACM1C0v6OK1S6BzeqK6qW
         coqJwnuwmvJF3WeM7xQwySIvBy6aauPEWXvJ7gzpd2R7lU1AUxZKjzGla0PdDPv1BKJM
         wcZDeKyzqWJt/l9ymxe9Od5P9vaFg+F+X1qeIfmvcZm0AomUal1XmEjrIbBWR9wYge8X
         qrbEoQjO7Ygz2HFbznBI8KlZEkVrfl6/t0uMzBcqtQUG18hklOOFx0YOgpADo706Trd1
         nXwQ==
X-Gm-Message-State: AOAM533PQg3W3lTJu+EpqsuZ3m+Pjov+MBP4JafTsRh4eg5UH9C9hGnp
        o/DVyrIQgWnXChZMcPa6b4NbLSg11BOFVllyCWo4Ww==
X-Google-Smtp-Source: ABdhPJxG3uHqZH08DUdXd3BNJXX2KbKVBHTRtUnPbDdcp5BZXQjy3wBHGptH5UNs341UHXUYM5ZmO8yNCUzrkWzfPD8=
X-Received: by 2002:ac2:5966:: with SMTP id h6mr2989371lfp.358.1640091820496;
 Tue, 21 Dec 2021 05:03:40 -0800 (PST)
MIME-Version: 1.0
References: <20211215161045.38843-1-marcan@marcan.st>
In-Reply-To: <20211215161045.38843-1-marcan@marcan.st>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 21 Dec 2021 14:03:03 +0100
Message-ID: <CAPDyKFoGEqBZ3XbGzc5E4QvWFcQN6nM7Envq5cM7Wmdp+jZSvw@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] mmc: sdhci-pci-gli: GL9755: Quirks for Apple ARM platforms
To:     Hector Martin <marcan@marcan.st>
Cc:     Ben Chuang <benchuanggli@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Sven Peter <sven@svenpeter.dev>, Marc Zyngier <maz@kernel.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Dec 2021 at 17:16, Hector Martin <marcan@marcan.st> wrote:
>
> Hi folks,
>
> This short series adds a few quirks needed to make the card readers in
> Apple M1 Pro/Max MacBook laptops work properly.
>
> The first patch should be straightforward; it just allows configuring
> the CD/WP polarity based on device tree settings. There is already a
> standard DT binding for this.
>
> The second patch works around an issue with 8/16-bit MMIO reads that
> only affects these platforms, for some reason.
>
> Changes since v2:
>  - Style fixes
>
> Hector Martin (2):
>   mmc: sdhci-pci-gli: GL9755: Support for CD/WP inversion on OF
>     platforms
>   mmc: sdhci-pci-gli: GL975[50]: Issue 8/16-bit MMIO reads as 32-bit
>     reads.
>
>  drivers/mmc/host/sdhci-pci-gli.c | 34 ++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>

Applied for next, thanks!

Kind regards
Uffe
