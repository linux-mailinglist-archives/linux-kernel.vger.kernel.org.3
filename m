Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7684EBC40
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 10:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244015AbiC3IEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 04:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239731AbiC3IEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 04:04:05 -0400
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03BE52657E
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 01:02:20 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id x34so23401675ede.8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 01:02:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0nhYzrk89CFYhP0OL9hhz1b8TpKXi7qnAX0VfrTasFU=;
        b=fxFVlobZv/QKQvwY7TNixezWelOuZ+KAboMy0IUYVHKTY/iusApUx7yA8TuFBHfS0J
         5pejcUbIZMbL0HHoXEWo8acO61EcGZNJakjainy/wWOLYdClklGu4ZcFUGT1rNhuSDfQ
         lFae56eyBlRHouq0OYSeBqSSLa4gEsS3jS9Er559ET7lE0afQCUR0aUORvaKswYGRRmC
         sf4opZy7ZfYtVY5xZpLEHytENHsF8iDjRKY2PN8kNoMEmDOJ1jBwd554aWmOTn6rnnRx
         VKP5e6SQAM3CdendyxhE3TT45n+4hVNJf/MovsYeJm6YXE282wQeXenhhQoVaOkDtOwF
         HuJA==
X-Gm-Message-State: AOAM532uSrnmW9CuLrlH5oaT+ELyMBzeAlDJV4bWhXoVcGopAlVI3XGC
        PGJmnTMQJ/Ra1nSnMnaedXs=
X-Google-Smtp-Source: ABdhPJx+jLhT7yt4Ec4HKq1/sZa+KCGnRWXebnA30Qq39MunDzYYqU8wVc6jku+/XPAqTN0Zy83YrA==
X-Received: by 2002:a05:6402:b7a:b0:419:3046:3abb with SMTP id cb26-20020a0564020b7a00b0041930463abbmr9076948edb.257.1648627338356;
        Wed, 30 Mar 2022 01:02:18 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id u9-20020a170906124900b006ce88a505a1sm8147711eja.179.2022.03.30.01.02.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 01:02:17 -0700 (PDT)
Message-ID: <292d7225-5ac2-71f0-08bc-8c33217fb93f@kernel.org>
Date:   Wed, 30 Mar 2022 10:02:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: mainline: qemu_arm64 boot failed - Failed to start Hostname
 Service - Stopped Serial Getty on ttyAMA0
Content-Language: en-US
To:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, regressions@lists.linux.dev,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
References: <CA+G9fYtk6rpp=0WG9LyfQRCsMbbvf=P7uhMuon4RzZz3UjYVYQ@mail.gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <CA+G9fYtk6rpp=0WG9LyfQRCsMbbvf=P7uhMuon4RzZz3UjYVYQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am not sure what this report is good for. See below.

On 30. 03. 22, 9:16, Naresh Kamboju wrote:
> Linux mainline kernel booting qemu_arm64 and Raspberry Pi 4 boot
> failed [1] and [2].
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
>           Starting Hostname Service...
> [FAILED] Failed to start Hostname Service.
> See 'systemctl status systemd-hostnamed.service' for details.

One failure here.

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

So NM is unable to start -- another networking failure.

> ...
> running for Network Manager (25s / 1min 30s)[  OK  ] Started Network
> Manager.
> [  OK  ] Listening on Load/Save RF Kill Switch Status /dev/rfkill Watch.
>           Starting Network Manager Script Dispatcher Service...
> [   27.359980] kauditd_printk_skb: 11 callbacks suppressed
> [   27.359988] audit: type=1701 audit(1648621070.228:22):
> auid=4294967295 uid=0 gid=0 ses=4294967295 pid=313 comm=\"(spatcher)\"
> exe=\"/lib/systemd/systemd\" sig=6 res=1
> [  OK  ] Reached target Network.
>           Starting DNS forwarder and DHCP server...
> [   27.367248] audit: type=1701 audit(1648621070.232:23):
> auid=4294967295 uid=0 gid=0 ses=4294967295 pid=315 comm=\"(dnsmasq)\"
> exe=\"/lib/systemd/systemd\" sig=6 res=1
>           Starting Permit User Sessions...
> [   27.371110] audit: type=1701 audit(1648621070.240:24):
> auid=4294967295 uid=0 gid=0 ses=4294967295 pid=317 comm=\"(sessions)\"
> exe=\"/lib/systemd/systemd\" sig=6 res=1
> [FAILED] Failed to start Network Manager Script Dispatcher Service.
> See 'systemctl status NetworkManager-dispatcher.service' for details.

And finally NM failed here. And it also tells you what to do for further 
investigation.

> [FAILED] Failed to start DNS forwarder and DHCP server.
> See 'systemctl status dnsmasq.service' for details.

Again, a network service.

> [FAILED] Failed to start Permit User Sessions.
> See 'systemctl status systemd-user-sessions.service' for details.
> [  OK  ] Started Getty on tty1.
> [  OK  ] Started Serial Getty on ttyAMA0.
> [  OK  ] Reached target Login Prompts.
> [  OK  ] Reached target Multi-User System.
>           Starting Update UTMP about System Runlevel Changes...
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

      ^^ This one is "OK", so I see no connection to serial layer at all 
as the Subject and CCed people list suggest. Am I missing something?

regards,
-- 
js
suse labs
