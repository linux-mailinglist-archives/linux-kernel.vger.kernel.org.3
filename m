Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D23E651F9B3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 12:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbiEIKYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 06:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233788AbiEIKYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 06:24:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E420285AD0;
        Mon,  9 May 2022 03:20:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 82AA3B810F2;
        Mon,  9 May 2022 10:04:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E4BAC385AB;
        Mon,  9 May 2022 10:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652090663;
        bh=KRAr8NAr9HEhffjgiwK4Uw60pEgav6/jUA27cwEshUw=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=lnp1a43fnuMuxe/CY86/uHJMx+9RQ310fGLR4bv866phL0rSFo+n/duplpgIqZ566
         qd+Iliuv5LFd1W+h3GV3o1DyoJppsCfpOMJyxbaTHbAjLSG13T+yQBu4T0OwND7HVL
         Kli8QiYQdG77pMR/YNwimqzl7+028JaxkMxM9scYRKxXoe1QVSQnsnKjhwvIClGIIh
         8XYAjgehQ84qaQTjwYIu1Lf9OMfK3PEHfna+mcMDRMPkzPKc62fnGWHdEUbiy97OA1
         I010isfobv2am5LZy3U6Pu1M+YKcMirXPxc1aXoo4qb+At0OE+tjD/+NNdvStgFKdZ
         /4M31cGqBx9Ag==
Received: by mail-ua1-f51.google.com with SMTP id ay15so5241514uab.9;
        Mon, 09 May 2022 03:04:23 -0700 (PDT)
X-Gm-Message-State: AOAM530h/+zOOmcrXHtlqDvsG4MSqqzeWv7iQetGjrTtSbgDmEH1emZT
        UQJ0Ol5WnZpuXXZREQyWMz8uIuCXJpcgwSlayAE=
X-Google-Smtp-Source: ABdhPJze9Bj2vif80pdU9vnKaat0koYohXFjUE9PaOAFIxquVtTO15k2qJPF8nmLMdZuTxk4Wl6LoraCGSJ0kxfq0rU=
X-Received: by 2002:ab0:77d5:0:b0:352:42d7:88c2 with SMTP id
 y21-20020ab077d5000000b0035242d788c2mr7385929uar.1.1652090662208; Mon, 09 May
 2022 03:04:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a59:b691:0:b0:2ae:8ec8:872b with HTTP; Mon, 9 May 2022
 03:04:21 -0700 (PDT)
In-Reply-To: <YnVagPnKc+SDnkP/@linutronix.de>
References: <YnVagPnKc+SDnkP/@linutronix.de>
From:   Frederic Weisbecker <frederic@kernel.org>
Date:   Mon, 9 May 2022 12:04:21 +0200
X-Gmail-Original-Message-ID: <CAFTL4hxoGnTkXs4O4_L2bZafFjFJOPUH+U+h__zsfYOhLpsSGQ@mail.gmail.com>
Message-ID: <CAFTL4hxoGnTkXs4O4_L2bZafFjFJOPUH+U+h__zsfYOhLpsSGQ@mail.gmail.com>
Subject: Re: [ANNOUNCE] v5.18-rc5-rt5
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2022-05-06 19:27 UTC+02:00, Sebastian Andrzej Siewior <bigeasy@linutronix.de>:
> Dear RT folks!
>
> I'm pleased to announce the v5.18-rc5-rt5 patch set.
>
> Changes since v5.18-rc5-rt4:
>
>   - Replace the ptrace patch with v4 of Eric W. Biederman's rework plus
>     a smaller patch on top to get it to work.
>
>   - Drop get_cpu_light from the series:
>
>     - Replace the crypto/cryptd patch with an alternative version.
>
>     - Replace the nfs/sunrpc patch with an alternative version.
>
>     - Replace the vmalloc related patch with an alternative version.
>
>     - Replace the block-mq related patch with an alternative version.
>
>     - Replace the scsi/fcoe patch with two patches by Davidlohr Bueso plus
>       two additional patches in order to tackle two remaining issues in
>       that area.
>
>   - Drop the preempt-disable -> migrate-disable replacement in kvm on
>     arm64. It seems no longer to be needed.
>
>   - Drop the "delay sending signals in atomic context" on x86/arm64. It
>     is not needed to send a SIGTRAP for a breakpoint on x86 (the
>     original motivation). Lets see if something else pops up. This might
>     break ARM64 in that regard and will be investigated in a follow up
>     release.
>
> Known issues
>      - Valentin Schneider reported a few splats on ARM64, see

Please don't ignore
https://lore.kernel.org/all/20220405010752.1347437-1-frederic@kernel.org/
and https://lore.kernel.org/all/20220405010752.1347437-2-frederic@kernel.org/

Especially the second patch fixes a pretty serious issue!

Thanks.
