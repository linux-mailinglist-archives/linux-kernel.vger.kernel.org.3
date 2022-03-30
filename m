Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B194EBB9D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 09:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243741AbiC3HUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 03:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbiC3HUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 03:20:31 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947D718F20D
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 00:18:46 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-2e5e176e1b6so208046717b3.13
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 00:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/p7whsLBrJDzlLPKukpCC+zZhIvPp6QD/9IfTIUVO/k=;
        b=WYxBqmBRte9I3qaul6d0E/TgxsEWvxFeVpzDhDH8+mR07IEXoXjrZ5LyOPDPgTus0q
         MSl6FzeJ9gwUMdCg+r0EfDJjl3czj9PD0munrBgRBvSzuK/LOJDli2dzCV4lWpCLBCgV
         sMxWK4Cgj3tTgN6FmJQEGN5KIG4A8fUTMvuTG2jH5wJ8FCr9mSdiXMpJkoFc3YPVPtob
         RbmsEX+sjbDo4qBDp/xr0JjpdjBBVKvdYzJv3PHGvKaK+subs1JMF0Pyht7UoN6H+uA0
         2/P7KsAcUeGOE8AsziGBi16OvrHoFm72m64pf3Wj2mbB23HaDfhxDxoa0L5kEmHNXTXH
         OETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/p7whsLBrJDzlLPKukpCC+zZhIvPp6QD/9IfTIUVO/k=;
        b=5/crPXNNGmrJjXv9fr8JCTiknF3DsJxwwx5ST/DOvfX5/8NYdLvP3AcPkqHWydhLNn
         CpoFHJwuqw5OjfqMFOTjZQ8Zqt8B/+mhcoTcE5xQshoMlfuFqIOY/FRIGtHlrnm45ej7
         bFAogtFllU+x1T2icH01QTKLTF15wCMUewl31sWbsaeDxKWc5K/bjZB7WAUjwGZbzQyR
         Lvk8eH9Io7AVW8O6ltqJrruQKxNn3B6xozhuJxGkW91rkdDOY3ETksKkqu7rxkIJYfoP
         YYfMTko7pXBBnHVrMS85wxIghxXD5v5f5KQunkK2uFarY1NXcRcTLYJkCyUHbBdR6BEJ
         T7sw==
X-Gm-Message-State: AOAM531CWOwNSjlqUQRbP2Nis27ocFfivvDM2mMl17m0JT3biTCK7NME
        qrS8myoUXiAsaFH9tZ9bvRQ5dJh84KBVvbjbBFBmX7h0ZbISfC43
X-Google-Smtp-Source: ABdhPJznwHQN5FMNpEZZnY2reh0XgsyH3yNmaoHIJfsgewbmBIMcE4I52hWoVknM4VV05eHx9iYMTHrya1XNBLdIx70=
X-Received: by 2002:a81:7812:0:b0:2d0:8c2c:5159 with SMTP id
 t18-20020a817812000000b002d08c2c5159mr34297551ywc.120.1648624725188; Wed, 30
 Mar 2022 00:18:45 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYtk6rpp=0WG9LyfQRCsMbbvf=P7uhMuon4RzZz3UjYVYQ@mail.gmail.com>
In-Reply-To: <CA+G9fYtk6rpp=0WG9LyfQRCsMbbvf=P7uhMuon4RzZz3UjYVYQ@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 30 Mar 2022 12:48:33 +0530
Message-ID: <CA+G9fYsnw3TEvqtP+sH812Sbzm8ZH1sTS4RkuX07Fyd-PTkf6g@mail.gmail.com>
Subject: Re: mainline: qemu_arm64 boot failed - Failed to start Hostname
 Service - Stopped Serial Getty on ttyAMA0
To:     open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, regressions@lists.linux.dev,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Mar 2022 at 12:46, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> Linux mainline kernel booting qemu_arm64 and Raspberry Pi 4 boot
> failed [1] and [2].

metadata:
  git_ref: master
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/torvalds/linux-mainline
  git_sha: 965181d7ef7e1a863477536dc328c23a7ebc8a1d
  git_describe: v5.17-13033-g965181d7ef7e
  kernel_version: 5.17.0
  kernel-config: https://builds.tuxbuild.com/275QxOAreyw3SRwLZ39TW5KVdRa/config

>
> Boot log:
> [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x413fd0c1]
> [    0.000000] Linux version 5.17.0 (tuxmake@tuxmake)
> (aarch64-linux-gnu-gcc (Debian 11.2.0-18) 11.2.0, GNU ld (GNU Binutils
> for Debian) 2.38) #1 SMP PREEMPT @1648607824
> [    0.000000] Machine model: linux,dummy-virt
>
> <trim>
>
>          Starting Hostname Service...
> [FAILED] Failed to start Hostname Service.
> See 'systemctl status systemd-hostnamed.service' for details.
> [    2.453172] random: crng init done
> [    2.453522] random: 7 urandom warning(s) missed due to ratelimiting
> [    2.483013] audit: type=1334 audit(1648621045.348:8): prog-id=0 op=UNLOAD
> [    2.483953] audit: type=1334 audit(1648621045.348:9): prog-id=0 op=UNLOAD
> [    2.609230] audit: type=1334 audit(1648621045.476:10): prog-id=10 op=LOAD
> [  OK  ] Started Resize root filesystem to fit available disk space.
> [     ] A start job is running for Network Manager (6s / 1min 30s)
> ] A start job is running for Network Manager (7s / 1min 30s)[   ] A
> start job is running for Network Manager (7s / 1min 30s)[   ] A start
> job is running for Network Manager (8s / 1min 30s)[   ] A start job is
> running for Network Manager (9s / 1min 30s)[   ] A start job is
> running for Network Manager (9s / 1min 30s)[    [ A start job is
> running for Network Manager (10s / 1min 30s)[     ] A start job is
> running for Network Manager (10s / 1min 30s)[    [ A start job is
> running for Network Manager (11s / 1min 30s)[   ] A start job is
> running for Network Manager (12s / 1min 30s)[   ] A start job is
> running for Network Manager (12s / 1min 30s)[   ] A start job is
> running for Network Manager (13s / 1min 30s)[   ] A start job is
> running for Network Manager (13s / 1min 30s)    ] A start job is
> running for Network Manager (14s / 1min 30s)[     ] A start job is
> running for Network Manager (14s / 1min 30s)    ] A start job is
> running for Network Manager (15s / 1min 30s)[   ] A start job is
> running for Network Manager (16s / 1min 30s)[   ] A start job is
> running for Network Manager (16s / 1min 30s)[   ] A start job is
> running for Network Manager (17s / 1min 30s)[   ] A start job is
> running for Network Manager (17s / 1min 30s)[    [ A start job is
> running for Network Manager (18s / 1min 30s)[     ] A start job is
> running for Network Manager (19s / 1min 30s)[    [ A start job is
> running for Network Manager (19s / 1min 30s)[   ] A start job is
> running for Network Manager (19s / 1min 30s)[   ] A start job is
> running for Network Manager (20s / 1min 30s)[   ] A start job is
> running for Network Manager (20s / 1min 30s)[   ] A start job is
> running for Network Manager (21s / 1min 30s)    ] A start job is
> running for Network Manager (21s / 1min 30s)[     ] A start job is
> running for Network Manager (22s / 1min 30s)    ] A start job is
> running for Network Manager (22s / 1min 30s)[   ] A start job is
> running for Network Manager (23s / 1min 30s)[   ] A start job is
> running for Network Manager (23s / 1min 30s)[   ] A start job is
> running for Network Manager (24s / 1min 30s)[   ] A start job is
> running for Network Manager (24s / 1min 30s)[    [ A start job is
> running for Network Manager (25s / 1min 30s)[     ] A start job is
> running for Network Manager (25s / 1min 30s)[  OK  ] Started Network
> Manager.
> [  OK  ] Listening on Load/Save RF Kill Switch Status /dev/rfkill Watch.
>          Starting Network Manager Script Dispatcher Service...
> [   27.359980] kauditd_printk_skb: 11 callbacks suppressed
> [   27.359988] audit: type=1701 audit(1648621070.228:22):
> auid=4294967295 uid=0 gid=0 ses=4294967295 pid=313 comm=\"(spatcher)\"
> exe=\"/lib/systemd/systemd\" sig=6 res=1
> [  OK  ] Reached target Network.
>          Starting DNS forwarder and DHCP server...
> [   27.367248] audit: type=1701 audit(1648621070.232:23):
> auid=4294967295 uid=0 gid=0 ses=4294967295 pid=315 comm=\"(dnsmasq)\"
> exe=\"/lib/systemd/systemd\" sig=6 res=1
>          Starting Permit User Sessions...
> [   27.371110] audit: type=1701 audit(1648621070.240:24):
> auid=4294967295 uid=0 gid=0 ses=4294967295 pid=317 comm=\"(sessions)\"
> exe=\"/lib/systemd/systemd\" sig=6 res=1
> [FAILED] Failed to start Network Manager Script Dispatcher Service.
> See 'systemctl status NetworkManager-dispatcher.service' for details.
> [FAILED] Failed to start DNS forwarder and DHCP server.
> See 'systemctl status dnsmasq.service' for details.
> [FAILED] Failed to start Permit User Sessions.
> See 'systemctl status systemd-user-sessions.service' for details.
> [  OK  ] Started Getty on tty1.
> [  OK  ] Started Serial Getty on ttyAMA0.
> [  OK  ] Reached target Login Prompts.
> [  OK  ] Reached target Multi-User System.
>          Starting Update UTMP about System Runlevel Changes...
> [   27.402975] audit: type=1701 audit(1648621070.268:25):
> auid=4294967295 uid=0 gid=0 ses=4294967295 pid=322 comm=\"(ate-utmp)\"
> exe=\"/lib/systemd/systemd\" sig=6 res=1
> [FAILED] Failed to start Update UTMP about System Runlevel Changes.
> See 'systemctl status systemd-update-utmp-runlevel.service' for details.
> [   32.398140] audit: type=1701 audit(1648621075.264:26):
> auid=4294967295 uid=0 gid=0 ses=4294967295 pid=320 comm=\"(agetty)\"
> exe=\"/lib/systemd/systemd\" sig=6 res=1
> [   32.399187] audit: type=1701 audit(1648621075.264:27):
> auid=4294967295 uid=0 gid=0 ses=4294967295 pid=321 comm=\"(agetty)\"
> exe=\"/lib/systemd/systemd\" sig=6 res=1
> [  OK  ] Stopped Serial Getty on ttyAMA0.
> [  OK  ] Started Serial Getty on ttyAMA0.
> [  OK  ] Stopped Getty on tty1.
> [  OK  ] Started Getty on tty1.
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> --
> Linaro LKFT
> https://lkft.linaro.org
>
> [1] https://lkft.validation.linaro.org/scheduler/job/4809453#L252
> [2] https://lkft.validation.linaro.org/scheduler/job/4809125#L386
