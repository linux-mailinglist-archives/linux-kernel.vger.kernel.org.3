Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B44AF463407
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 13:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241479AbhK3MVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 07:21:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241477AbhK3MU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 07:20:58 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF163C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 04:17:39 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id g19so20415091pfb.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 04:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hXu04+QUxNwriCyATe0mYK4V2fWk7rKeUqQfH4ZzNho=;
        b=NFz49q4CXrhyY7CXbxV3z2ldVJwzaldxtc/oUsdRBVtBiXC0KM/JK9hjV95JGIcdR3
         XDGcDJ+EiGuf4DJ3sc1r8SPmbPHtA01T9BCHnE04fetiIF5bEeO5kMv+Jr7yO/x0BLOV
         Ih1gTcjC2GEXmWtPZxbvoDVwheVuXdxr7s+SKf5xLZXfPd4SmywfW4UM1xZt3Zfb+4Ja
         LgC1VaiZ3Ttp+29Rd7+1JBOZOCzIGe+JmkD3y7WyBsDSV7ACAYLlHUF9HslcRP/2pbnV
         v5jmy3VYLzwITHpHxo3kYxv45vgBs5BUH8ahHHnLp8P38JAI5Fttzm1opmXGLem+cWcF
         YCIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hXu04+QUxNwriCyATe0mYK4V2fWk7rKeUqQfH4ZzNho=;
        b=BSn4AbnBmMkUwsRfl4WXAQ+EDMA3HqmDbIUooqpXz0gJQiXAeSrvxQrjr4iQKQkGRc
         Sel5RTo6Vxwdja3cOLsr4w6+vdUyRCKeYC6ZY7REFS2kxrmuAUz7U9vMJe8mA1D9Uruw
         8Y95+B5q4wuauFJwwgbiolF7Sg/RBf1UZuEcTLYWJlWLIB9LJ358hRMNzZuv3fA9jTPJ
         oDwpxdsOSpMyNRMdBaQkbTeCy1vw8XFCP4GIErV7VolIC9CUMnyL2xWmZ53HbJC5W+zP
         BulhHItrd4tUSTWxbDpfYWb1fF8asDweDeEeNt0gc28kBzG3jaQuRGxitZKz2UfdbbhM
         p0uw==
X-Gm-Message-State: AOAM530cUK3cCihBk/uG9qeayyCnUSsqZ4+LOWP/xHpNYwGPlv7wBqX6
        IXPzW00Sskr3ZffopRzLwOLS/7daWqZ7+NjwQlXUMg==
X-Google-Smtp-Source: ABdhPJxXQvjuI9DOLtLA4qoREyXeCJL3uZPQt563tGuuhXX60ozlJ15yWahFJlZ5ASNrD3Cz92l7mKSjcN1q2dr7D/4=
X-Received: by 2002:a63:414:: with SMTP id 20mr39830109pge.178.1638274659171;
 Tue, 30 Nov 2021 04:17:39 -0800 (PST)
MIME-Version: 1.0
References: <20211117020724.2647769-1-pcc@google.com> <YaW3Cff+AJqT8tS/@matsya>
In-Reply-To: <YaW3Cff+AJqT8tS/@matsya>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Tue, 30 Nov 2021 13:17:28 +0100
Message-ID: <CAG3jFyt802J8nxtc_iifgfbTJk0-Mtu_18aY0cEcjyJDaNLjaA@mail.gmail.com>
Subject: Re: [PATCH] lontium-lt9611: check a different register bit for HDMI sensing
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Peter Collingbourne <pcc@google.com>,
        John Stultz <john.stultz@linaro.org>,
        Anibal Limon <anibal.limon@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Nov 2021 at 06:30, Vinod Koul <vkoul@kernel.org> wrote:
>
> On 16-11-21, 18:07, Peter Collingbourne wrote:
> > It has been observed that with certain monitors such as the HP Z27n,
> > the register 0x825e reads a value of 0x79 when the HDMI cable is
> > connected and 0x78 when it is disconnected, i.e. bit 0 appears
> > to correspond to the HDMI connection status and bit 2 is never
> > set. Therefore, change the driver to check bit 0 instead of bit 2.
>
> So we have got limited information on this but BIT-2 seems to be related
> to HPD and empirical data from various monitors supports this, so this
> seems the right thing to do.
>
> Reviewed-by: Vinod Koul <vkoul@kernel.org>
>

Applied to drm-misc-next
