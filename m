Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 308FC59EC19
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 21:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbiHWTVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 15:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234303AbiHWTUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 15:20:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42935A14D;
        Tue, 23 Aug 2022 10:59:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C57461683;
        Tue, 23 Aug 2022 17:59:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68132C433C1;
        Tue, 23 Aug 2022 17:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661277585;
        bh=RIY5fu0Ccv8YyiNMD6vYWY/HtMeFS+5JWc27tNQtnlM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qbqZ/L3vXIHP4Gddr5RSmGm4FUfTbNm+JJ+OeSQJs4xQwzy/n2R0Hug9huUw1HQOI
         MIoC0Q7Qy1nYY4czNRPpcCJLrq3AsvKnm2esp2ZtITTgJxwkQDYT808S+j5TNIcXTw
         yJpTp5Dq3cwY/i3rOqN11QsNa0924KynDX0KMdC4m/UfVTN3WKTzaCRgaOUGc4/qwm
         ruP4rAPIEWvjHLYRRnpK7DE72uG3JVQCt+xsIgMS64AfDfFO+MZ/7aADpjY7kBvQzk
         ykt4cRVRzvmXI8FI9UjIiA777x56fc4xHWUq45Yw850RI2HeGxdRrlMZn5PltyiHGz
         VHZ78y2gXkE/g==
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-3246910dac3so399434117b3.12;
        Tue, 23 Aug 2022 10:59:45 -0700 (PDT)
X-Gm-Message-State: ACgBeo1jPFdPbYPnkcyPG8WQXx3TkqzNcu/3LFWybOysq8+fZM3Qk6Wa
        sd77Q8T/DXpwVLq/Pq+Pe+8HNWA1NhI4B6eW6/Y=
X-Google-Smtp-Source: AA6agR5UEK7XZYEggA4k/pHG8nif74dsCS4nPFu6i2sptT8o7hzEBmPIm4r/Iz8JJIishkf4u9k0DulvOer5/uVTSHA=
X-Received: by 2002:a81:6143:0:b0:335:3076:168e with SMTP id
 v64-20020a816143000000b003353076168emr25966534ywb.460.1661277584419; Tue, 23
 Aug 2022 10:59:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220704012328.6507-1-jiaming@nfschina.com> <20220705022617.12555-1-jiaming@nfschina.com>
In-Reply-To: <20220705022617.12555-1-jiaming@nfschina.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 23 Aug 2022 10:59:33 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6H6Gyazn4o23UeYhfWtTFqcvw9dqS=Aqjpjf1o1qdMrg@mail.gmail.com>
Message-ID: <CAPhsuW6H6Gyazn4o23UeYhfWtTFqcvw9dqS=Aqjpjf1o1qdMrg@mail.gmail.com>
Subject: Re: [PATCH v2] block: Fix spelling mistakes in comments
To:     Zhang Jiaming <jiaming@nfschina.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, d@ja.vu,
        liqiong@nfschina.com, renyu@nfschina.com,
        Paul Menzel <pmenzel@molgen.mpg.de>
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

On Mon, Jul 4, 2022 at 7:26 PM Zhang Jiaming <jiaming@nfschina.com> wrote:
>
> Fix spelling of dones't and waitting in comments.
> Fix tense mistakes of hold and finsh in comments.
> Use underline to connecting reconfig and mutex.
>
> Signed-off-by: Zhang Jiaming <jiaming@nfschina.com>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>

Sorry for getting on this late.

AFAICT, this one doesn't apply any more (conflict with some of your
other fixes). Could you please resend?

Thanks,
Song

> ---
>  drivers/md/raid5-cache.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
> index 83c184eddbda..8d5154d94f86 100644
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
> -        * reconfig_mutex hold. The first step of raid5_quiesce() is waitting
> -        * for all IO finish, hence waitting for reclaim thread, while reclaim
> -        * thread is calling this function and waitting for reconfig mutex. So
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
> 2.34.1
>
