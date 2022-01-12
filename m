Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1694248BBE1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 01:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347213AbiALAcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 19:32:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236299AbiALAcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 19:32:32 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E78C06173F;
        Tue, 11 Jan 2022 16:32:31 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id h23so1270125iol.11;
        Tue, 11 Jan 2022 16:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xzRivGiDnFlH/NigKDtyx/5jSI6przCmRsoRUX9qzW4=;
        b=ECF3Q/SSeCeIXhQRldXxQpXI/q5uTMDtKLXT1zBBl1JNCGWkD0adGys7P49TM1Ckoy
         arXjylMaMFTeE4w9rjBUYs/+RSdbLOPqj/aKKwRQ0NzDXP+Bc9a7sekFkUAE0IOu4qRl
         BTZLX0/4xRmkPtFQiD4RYFVlGpo+XYtNl0AGUxWA/SFqBIa8B/bDkcSVzoS65X+fOk2N
         Z08qE2Cz+ZFhtkYpJb17NnPJoVyAZpWoULYS7OYk2GbRDf2WSJ0DmJvXZWQgJ1sHSX0x
         bYle2rl5p1GCDiMBXmNejRCVR462bxS29IgQdt4uUJnH0lqeNLaP0feesnzkZ+PBZEr6
         etBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xzRivGiDnFlH/NigKDtyx/5jSI6przCmRsoRUX9qzW4=;
        b=5CiOHqOTkNBoxxEKrdNNJ50kqV928vlYNsxvbAqX3qTjmCW4aaImZyI0oGhLRicuk/
         LfUDaCZniNKFqn23q/TUNNJJmxZYxCNpa8Zi+PmTXSFsiZt5qLlbWjgdSVTz2AAuWcvP
         qicVLmIp7evt8p4uUPc3HCgU9lmQloA7/vBWazXYoEf+UxxVYPUHU7oO7OIFFYj/dTO4
         AgqxyyKBZFcqbSjtyyFUMe6cGX8w2X8sBZWoAAlBkbi65MU7u2kCdFMpzoMys70roQae
         MBURmi+TB/Fgs4STsdiBrLF9iLR+RVlNWo/vngK6d5i2RZofbtyIr7q6VJm3a5TPRfKQ
         fj6g==
X-Gm-Message-State: AOAM531Ocly62USnmCB0UVI473aThtRf6JVSEmcx3YH13fRKYaUf7npv
        omv8v00xkNe1bnD2iYl7k/6zAeKYevWDJkJCjAk=
X-Google-Smtp-Source: ABdhPJxKhwcG0hnl29QpdnKHcbrr3/gJYspv2gQI/bfG3WAECR8HiBX6lovOe32Dk6eBpnHyoZ2HcOKpjz+Tig6YHr8=
X-Received: by 2002:a6b:e508:: with SMTP id y8mr3309614ioc.177.1641947551194;
 Tue, 11 Jan 2022 16:32:31 -0800 (PST)
MIME-Version: 1.0
References: <20220110085952.6137-1-sj@kernel.org> <CANiq72nysMx0tOHstkDFWV2wYnjiePDxvGeip=RU4bKkyAZbtw@mail.gmail.com>
In-Reply-To: <CANiq72nysMx0tOHstkDFWV2wYnjiePDxvGeip=RU4bKkyAZbtw@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 12 Jan 2022 01:32:20 +0100
Message-ID: <CANiq72=uZ58gQ5PmF5bXk7f47yGGzeL=WQnNbybeBPDZuQhijA@mail.gmail.com>
Subject: Re: [PATCH v2 for-rust-for-linux] init/Kconfig: Specify the
 interpreter for rust-version.sh
To:     SeongJae Park <sj@kernel.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Liu <wei.liu@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 11:13 AM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Picking it up, thanks!

This is now in linux-next (Jan 11) -- hopefully it is now better for you!

I will carry the patch in our rust-next branch but I won't put it in
the patch series, this way we won't need to revert it when merged into
mainline.

Cheers,
Miguel
