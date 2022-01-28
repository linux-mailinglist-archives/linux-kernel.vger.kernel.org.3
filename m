Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14F5B49F1B7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 04:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345674AbiA1DQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 22:16:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345661AbiA1DQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 22:16:02 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE014C061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 19:16:01 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id i62so14577806ybg.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 19:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=howett-net.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=COyInZQXwILZTT25hzhUeQ1XuTLuXQIWejVrRlfCgcQ=;
        b=LMxF23M2bcmje+nqRcOn9lD5Urckqw937LxXGIqVZHEv3xcz2iC8haX4zDzUubXuNy
         HwH9Zfx1wVrMfBnEy7WrKlIBcEjynSZxQ5WpHFYz8UzfAh61AUHOYo5qXZnX+VBf9Jyb
         wf1G3wjPzSZFMvu8BtwpKji3fD0nwxUCYnTHTDn1lW7/d1riIooMa/CcadsBULH7j4gV
         7sdN1Vl2QYfzpi3CD6KDlVjQ0YjjODKVw5nyh8Pwo3DPC1UNJAXmRbo9P5LQAJU3Lznc
         xmScIPcoaDcOZcw7FoMzjU0NS8Su9ovQ6rx5nYenj6hO8Gzu34NNvJD1ckjQYPF3+hOD
         vBng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=COyInZQXwILZTT25hzhUeQ1XuTLuXQIWejVrRlfCgcQ=;
        b=eyAdUPRIauKxKLezkA42XmfJSh7Cq63j5IfpDKlqMCiFZ0uk5eCCQLh8Rtv0OhVrzs
         JZspLQiMQkWdJCq2MvNhTk5l8Gh4oPARJicQYuMHdBfgLqy1qrYchyEnRLzKyI9nd8wp
         6nbFfuXcGYssRVPUGoE1Hl0YvO2EvQgg9G23wUA8E05ZI0ChAqShTfAyl3yNOmLZpvCv
         fGSHZ9JYldUdJR7clNWJjruv2C4t2X/KBZ/rBOQWNkuAVVg5gHAC9URDSmtlli6t/qJl
         FKgaWHw1c7T1Ue+GH1IjMgeYc4uRCu8FFb2OgSyMep9ra1LNmLsXdZAyrcLER/AmeNeX
         PRuQ==
X-Gm-Message-State: AOAM531XtQ98z1HwZzmaUkaRaoUgq1axq0AR+/QnwaGUwfkkIukOrzoE
        lFYluHEELwtByDRfAgvFIAll1qrSq6Ib8gE58X51Kbu4Dsw4sYw+W8c=
X-Google-Smtp-Source: ABdhPJxUr+jVGrl30j7jxb7MJahg5gGsyiSwfZEqtjTxrMm9SMehVwjbAYS2xrG/xy0asKy9KQJZCwLDmcOwoazbC+k=
X-Received: by 2002:a25:ace0:: with SMTP id x32mr10198292ybd.255.1643339761175;
 Thu, 27 Jan 2022 19:16:01 -0800 (PST)
MIME-Version: 1.0
References: <20220126180020.15873-1-dustin@howett.net> <20220126180020.15873-3-dustin@howett.net>
 <YfLqloFQpF7bURGi@chromium.org> <CA+BfgNKS_uGZVh5K=O5Q-Brj-wWyg+gn1Nx4-Gr5OVb46ZFi=A@mail.gmail.com>
 <YfLxw9r6VvbxijRM@chromium.org>
In-Reply-To: <YfLxw9r6VvbxijRM@chromium.org>
From:   Dustin Howett <dustin@howett.net>
Date:   Thu, 27 Jan 2022 21:15:53 -0600
Message-ID: <CA+BfgNKCYT6EnOK1JTsy+AJCzZ+p6UbYD+SgBZ=ANHCV1pC7oA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] platform/chrome: cros_ec_lpcs: reserve the MEC LPC
 I/O ports first
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Michael Niksa <michael.niksa@live.com>, aaboagye@chromium.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 1:25 PM Prashant Malani <pmalani@chromium.org> wrote:
>
> What source do Framework laptop ECs (MECs?) compile their EC firmware
> from?

They just released their source here:
https://github.com/FrameworkComputer/EmbeddedController

FWIW, this series was written before they went open, and you're not
likely to see a similar construct
over there.

> Yeah, I wasn't thinking about userland i/o port access, but just having
> this behaviour/different I/O port mapping described in the EC code base
> too.

Happy to submit this over there as well. Are cros_ec_commands.h (here)
and ec_commands.h (there)
intended to be kept in 1:1 sync?

As well, is this a blocking concern?

Thanks!
d
