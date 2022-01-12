Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB3E48C010
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 09:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351691AbiALIhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 03:37:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351683AbiALIhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 03:37:00 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89DCC06173F;
        Wed, 12 Jan 2022 00:36:59 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id b1-20020a17090a990100b001b14bd47532so3452100pjp.0;
        Wed, 12 Jan 2022 00:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u/AGUJXTV3RJzKFVC/1AlVAFi3VGx3YRi9Fz4vF86OE=;
        b=kJGQzSA8wm9GUywxJv6Dh1yCd9QwyuFQT0nGHSeRYtlOqVIlQpuPc9idMLJlz7sh0/
         ppNlymZ/FjJyB3b6/axRb7LvLMnczhAj81o74/BBXKTiAVOS2Xs8qWpDCGV/fDm6soQw
         f+rUm6KPHKLk68YY7YWfEXVilHv20yioAA+j5Zkwqbbl7Ohqdfdz4hDrG8Je2rNiWcK3
         lZLwS/fubbsCfhsITXmClXayLn59+4YDXEAskzLZT6R5Tl1rdyPnEbkbPkjFy76/U8lj
         d+sq8ktyyLD9JuaQvrv0MA3oijLSiCZk0C3KQcQEaK1gj2E3rPcWW724ftDA/48E+O3T
         WASA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u/AGUJXTV3RJzKFVC/1AlVAFi3VGx3YRi9Fz4vF86OE=;
        b=rzUWoQIrGXuXJ7i93mMaop6nwkiNHxj5snwfeZtGvfqu/qNeJe6jLsWYzf+PqusOQR
         b7no0dHudoQislN8I5Z3SGf4ulu6JSCYZlUUizJpphtLYnQ51idnZVqtu+o9GeW7Ztfp
         PujZ4bTQSJiWGuuDLPmNuIyURH9nYTBQ0+Szqexe5dRgja1UUlUhm3MoUeXS/5rsneeA
         qzzBrG8Jl/K8SXWAXgA7y/kBO2hgIWW+6e+UwJXdCEyj5f9+Bi3wYxF/0UjeytGhXr3v
         ueZ+Y7dUUaDYEAnNgP5WtNA1z0kp5npKbixw0Zby9SQLw5+yovTIbXdxemgdY4WpM6ak
         lobg==
X-Gm-Message-State: AOAM5302QlDA3iB1qTgjwsUC5jnuxzwraIIyxCDhNNNSDJNgBZG47cGF
        OtF7wt05CFU1jz21pkQAWdbE3BLCcqSdILA8kBo=
X-Google-Smtp-Source: ABdhPJyNX2nArwYqWEzFXAMJOv5WPVJgHTKefluCjgIIR4PTGos3vmJacXniZc35MPudbVTB1ouwrVEs6/fg6ZdJqzQ=
X-Received: by 2002:a17:902:bcc1:b0:149:a13f:af62 with SMTP id
 o1-20020a170902bcc100b00149a13faf62mr8163903pls.147.1641976619148; Wed, 12
 Jan 2022 00:36:59 -0800 (PST)
MIME-Version: 1.0
References: <YcJZWiQ407ZxMM+y@bombadil.infradead.org> <20211222132332.7817-1-vimal.agrawal@sophos.com>
 <YcRRQCMZFepB/hzX@infradead.org> <CALkUMdRxTm6STT4CncTuvQ9hM_bez+B91TsuenEj71KPxFgMsg@mail.gmail.com>
 <YcVtG26b/sO9k7ox@infradead.org> <CALkUMdSY3XCHqhH9dDQ+0VHykv9AiBiqLgoC+cj5P=9Q1jdXrg@mail.gmail.com>
 <Yd2nJZRtc3OjPb0w@bombadil.infradead.org>
In-Reply-To: <Yd2nJZRtc3OjPb0w@bombadil.infradead.org>
From:   Vimal Agrawal <avimalin@gmail.com>
Date:   Wed, 12 Jan 2022 14:06:48 +0530
Message-ID: <CALkUMdSc8eNbqptTihwzqhpL9qhGS0xUFr=AFXs3COvpyBoQiw@mail.gmail.com>
Subject: Re: [PATCH v2] kernel/module.c: heuristic enhancement when
 INSTALL_MOD_STRIP= "--strip-unneeded" is used
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Vimal Agrawal <vimal.Agrawal@sophos.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jan Beulich <JBeulich@suse.com>, Jeff Mahoney <jeffm@suse.com>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kbuild@vger.kernel.org,
        jeyu@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 9:19 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> Yes but the point here is the heuristic you are adding for
> when "--strip-unneeded" is used is now *always* being used and
> we have no way of knowing this. So I'd agree with Christoph that
> if we want to support this it might make sense to make a kconfig
> option for enabling "--strip-unneeded" and then another for this
> heuristic.

This heuristic is applicable to any case when an address inside a
module can not be decoded to any known symbol. e.g. anyone can still
build with ----strip-all though module load fails with this option.
but one can add or remove symbols manually or use objcopy or some
other utility to play with symbols. It does not matter for
functionality much if symbols are available or not and it is just that
symbol decodes in traces are not providing help as it displays
absolute address in such cases.

There are several options in strip command and we can't have kconfig
for each such option. All options are supported currently unless the
module is so broken that it can even be loaded ( e.g. --strip-all
option).

Vimal
