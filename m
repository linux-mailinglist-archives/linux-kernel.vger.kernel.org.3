Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 486664EA81E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 08:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233163AbiC2Gzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 02:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbiC2Gzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 02:55:47 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61AD21707A;
        Mon, 28 Mar 2022 23:54:04 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a02:3030:a:f397:f6bc:b726:2678:839f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 80A071F43635;
        Tue, 29 Mar 2022 07:54:01 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648536841;
        bh=Xpx3U6mOBehpoSrK6i7CEVapGWneCtBaLxoygKFuPgQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R8DeTYomlc8xvrJf5lRwFd3JMajS7q073SDqjJ3Ir5/FH7Qw8LBfo7D8pZnilMedk
         cSprB1oPwlrAragYBSwrGOl/+JSq9FHRDRTgI3j4UGZvyJ3TwOm5X3AJ/bEwlPYUDO
         nDJ9x4snyFGwYtTrsvuKgAroOswMq91hGUEuF0SR8FnbJKSrZ6QbZYuOAzoZigF9AO
         AwSOEj0u7vD12Y6BcyIdaVntGtDJTUyDSDfcahAtqubsX8XJzUe3vdxl2BXohL8hPd
         CtcWQH1AqwLv45/5FAM8qlUMRcaxn4h1peBJMPDTSRU5mJWipvyo+LnIkPeTfctZXq
         W74ghBkXXPfoQ==
Date:   Tue, 29 Mar 2022 08:53:57 +0200
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
To:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc:     linux-media@vger.kernel.org, acourbot@chromium.org,
        tfiga@chromium.org, hverkuil-cisco@xs4all.nl,
        Maxime Ripard <mripard@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chen-Yu Tsai <wens@csie.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Allwinner sunXi SoC support" 
        <linux-sunxi@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v3 2/2] staging: media: cedrus: Rename H265 to HEVC
Message-ID: <20220329065357.h3tx3nm5osmmgxfs@basti-XPS-13-9310>
References: <20220327084308.9053-1-sebastian.fricke@collabora.com>
 <20220327084308.9053-3-sebastian.fricke@collabora.com>
 <4697363.GXAFRqVoOG@jernej-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4697363.GXAFRqVoOG@jernej-laptop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Jernej,

On 28.03.2022 19:09, Jernej Škrabec wrote:
>Hi Sebastian!
>
>Dne nedelja, 27. marec 2022 ob 10:43:10 CEST je Sebastian Fricke napisal(a):
>> Rename all instances where the identifier H265 is used with HEVC.
>> The codec has multiple identifiers H.265 (ITU-T), MPEG-H Part 2 (ISO),
>> but the actual name of the codec is HEVC (High Efficiency Video Coding).
>> Also nearly all other related drivers use the term HEVC instead of H265.
>>
>> Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
>
>This patch is not constructive. I admit, it's unfortunate it's not using same
>name as other drivers, but anyone dealing with HEVC will know H265 is synonym
>for it. This patch doesn't improve anything and actually makes any fix harder
>to backport, if something cames up. According to diffstat, this rewrites more
>than 50% of cedrus_h265.c, including renaming the file. Additionally, it's easy
>to miss something to rename and we could play this game in the future too, for
>no real benefit.
>
>So NAK.

Alright, thank you for presenting your view on that topic. I'll drop this patch.

>
>Best regard,
>Jernej
>
>P.S. Please wait at least few days before resending patches, even if you find
>something. After all, RFC patches are meant to get some response, it's not
>expected they will be perfect.

Thanks for the tip, I'll be honest, I was bascically just ashamed that I
missed those variables even after extensive grepping that I thought I
better fix this up quickly instead of dumping trash on the mailing list.

Greetings,
Sebastian

>
>> ---
>>  drivers/staging/media/sunxi/cedrus/Makefile   |   2 +-
>>  drivers/staging/media/sunxi/cedrus/cedrus.c   |  30 +-
>>  drivers/staging/media/sunxi/cedrus/cedrus.h   |  14 +-
>>  .../staging/media/sunxi/cedrus/cedrus_dec.c   |  10 +-
>>  .../cedrus/{cedrus_h265.c => cedrus_hevc.c}   | 438 +++++++++---------
>>  .../staging/media/sunxi/cedrus/cedrus_hw.c    |   4 +-
>>  .../staging/media/sunxi/cedrus/cedrus_regs.h  | 394 ++++++++--------
>>  .../staging/media/sunxi/cedrus/cedrus_video.c |   4 +-
>>  8 files changed, 448 insertions(+), 448 deletions(-)
>>  rename drivers/staging/media/sunxi/cedrus/{cedrus_h265.c => cedrus_hevc.c}
>> (53%)
>
>
>
