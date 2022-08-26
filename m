Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405635A2040
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 07:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbiHZFQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 01:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244794AbiHZFQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 01:16:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD266C104;
        Thu, 25 Aug 2022 22:16:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40C05614F1;
        Fri, 26 Aug 2022 05:16:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A36FFC4347C;
        Fri, 26 Aug 2022 05:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661490989;
        bh=uyZGmJwOBpkolJ9LNPlmylFgaRR16dpZi0zbiaPJQDc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=H6Umh6W3V62MsmhQL3pEdTB7G51zZw9JP1n0yUdMEmvIWohhN/63HjjiKxofbosKP
         5gap/Xyub6I/zCVucNhA4MfAkr//Y122zPsTdl5VclnbW7hMAN+X8lv3sYTVKd2o0p
         FrMOxSULupBuvz67LiS5rA9WlsLKG6oWFB3L+K60h1SLdb0RYKNTg9XHT8/FjdkwOV
         UJR5AWoljPhF+z5qinWKjMtsd8fZDLdlS4hO4RfkmomaqwucgnrNEeDjUhDlQbtsSK
         P5f00KMFwL3ElqFc8gn/i3gnP/DgIswpGA8gZrgI3latdZdLbncL5RnbTE0KDeyQ4r
         1m8QFElqyview==
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-333a4a5d495so9692177b3.10;
        Thu, 25 Aug 2022 22:16:29 -0700 (PDT)
X-Gm-Message-State: ACgBeo1AlQudMVmsEcNZqJIRzXjVOuNFP6XQ1QQ+HbNf+t7+drMWNfyK
        kv/KAibX3XdOX2oerGMLFp2BpKnjhzI2u3vSIYE=
X-Google-Smtp-Source: AA6agR4JCDmgsqn0pYnsxlp0bm/cfl9OT4FnXjsbXtnLeaiwrnUoQ9jpag9ZHTVqfL7OXbia5o9ZST9ke1eGxozHCuc=
X-Received: by 2002:a25:6003:0:b0:68c:870b:2405 with SMTP id
 u3-20020a256003000000b0068c870b2405mr6111336ybb.9.1661490988671; Thu, 25 Aug
 2022 22:16:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220705022617.12555-1-jiaming@nfschina.com> <20220826030800.10583-1-jiaming@nfschina.com>
In-Reply-To: <20220826030800.10583-1-jiaming@nfschina.com>
From:   Song Liu <song@kernel.org>
Date:   Thu, 25 Aug 2022 22:16:18 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7YuPCU-OG=Ux++sRzuHmztjUpPES0QOzBq=vbZAaaXqg@mail.gmail.com>
Message-ID: <CAPhsuW7YuPCU-OG=Ux++sRzuHmztjUpPES0QOzBq=vbZAaaXqg@mail.gmail.com>
Subject: Re: [PATCH v3] md/raid5-cache: Resolve patch confilcts
To:     Zhang Jiaming <jiaming@nfschina.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, liqiong@nfschina.com,
        renyu@nfschina.com, yuzhe@nfschina.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 8:09 PM Zhang Jiaming <jiaming@nfschina.com> wrote:
>
> Resolve conflicts when applying patches.

^^^^^^ this is not a proper commit log. If we need something that is part
of the patch/email, but not part of the commit log, we can add below

>
> Signed-off-by: Zhang Jiaming <jiaming@nfschina.com>

Signed-off-by: ...
---
git-am will remove the message here (between two '---').
---
drivers/md/raid5-cache.c | 12 ++++++------


> ---
>  drivers/md/raid5-cache.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
> index 058d82e..a4a84a0 100644
> --- a/drivers/md/raid5-cache.c
> +++ b/drivers/md/raid5-cache.c
> @@ -125,7 +125,7 @@ struct r5l_log {
>                                          * reclaimed.  if it's 0, reclaim spaces
>                                          * used by io_units which are in
>                                          * IO_UNIT_STRIPE_END state (eg, reclaim
> -                                        * dones't wait for specific io_unit
> +                                        * doesn't wait for specific io_unit
>                                          * switching to IO_UNIT_STRIPE_END
>                                          * state) */
>         wait_queue_head_t iounit_wait;
> @@ -1326,12 +1326,12 @@ static void r5l_write_super_and_discard_space(struct r5l_log *log,
>          * Discard could zero data, so before discard we must make sure
>          * superblock is updated to new log tail. Updating superblock (either
>          * directly call md_update_sb() or depend on md thread) must hold
> -        * reconfig mutex. On the other hand, raid5_quiesce is called with
> -        * reconfig_mutex hold. The first step of raid5_quiesce() is waiting
> -        * for all IO finish, hence waiting for reclaim thread, while reclaim
> -        * thread is calling this function and waiting for reconfig mutex. So
> +        * reconfig_mutex. On the other hand, raid5_quiesce is called with
> +        * reconfig_mutex held. The first step of raid5_quiesce() is waiting
> +        * for all IO to finish, hence waiting for reclaim thread, while reclaim
> +        * thread is calling this function and waiting for reconfig_mutex. So
>          * there is a deadlock. We workaround this issue with a trylock.
> -        * FIXME: we could miss discard if we can't take reconfig mutex
> +        * FIXME: we could miss discard if we can't take reconfig_mutex
>          */
>         set_mask_bits(&mddev->sb_flags, 0,
>                 BIT(MD_SB_CHANGE_DEVS) | BIT(MD_SB_CHANGE_PENDING));
> --
> 2.11.0
>
