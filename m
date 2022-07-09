Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876FA56C8E6
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 12:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiGIKPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 06:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGIKO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 06:14:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40BA3CBF4;
        Sat,  9 Jul 2022 03:14:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AC7AEB819C8;
        Sat,  9 Jul 2022 10:14:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3137C3411C;
        Sat,  9 Jul 2022 10:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657361696;
        bh=MaZXRxOK6UJq6NwF+fwB1/nqC7zlw5QYTccaa+9Ayaw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WsaGeSqiIL5eSPoZZjxC5QZezQPx9Sb47SKeE4YEgd3DsuDB9BJbBu9peP8MZkvrm
         881Q2qPsk6lrzMghJszE9g24ys0Vn4hoESk/MqSwTba2foYSh4YxLO1VQTLiNGCfrx
         DQEuc2snQ2fhq5zNkB+WOMZIsJPFB6fULphu6rAscDeKlBjOeAR0fh+po2G9+YKUHm
         6kNEeqXzfst0hLnvY1VcIGyibDrqZKULauinZbOkpgOGxw8jAhbixZ1KZf9doop/yr
         ddFSijafi/bbZTH+e4aodsY4GonqVfYayVhMWUybcJBAYMsADymAIfqVxkRecAUmwb
         lvtey2U7SIpMA==
Date:   Sat, 9 Jul 2022 11:14:50 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        "Hans Verkuil" <hverkuil@xs4all.nl>
Subject: Re: [GIT PULL] Linux Media vimc update for 5.20-rc1
Message-ID: <20220709111450.12e1dd61@sal.lan>
In-Reply-To: <7e719640-80e6-b3ab-751a-156b8e74d87b@linuxfoundation.org>
References: <7e719640-80e6-b3ab-751a-156b8e74d87b@linuxfoundation.org>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shuah,

Em Thu, 7 Jul 2022 10:28:37 -0600
Shuah Khan <skhan@linuxfoundation.org> escreveu:

> Hi Mauro,
> 
> Please pull the following vimc update for Linux 5.20-rc1.
> 
> This vimc update Linux Media 5.20-rc1 consists of enhancement and
> cleanup patches:
> 
> - add lens to vimc driver and links it with sensors using ancillary
>    links.
> - add documentation for lens
> - changes to make the code readable and maintainable.
> 
> diff is attached.

Please also send the patches individually to the media ML, as reviews
happen using them.

Hans,

Please let me know if you prefer to apply those on your tree, or if
I should apply on mine a couple of days after Shuah post the patches
at the ML.

Regards,
Mauro

> 
> thanks,
> -- Shuah
> 
> ----------------------------------------------------------------
> The following changes since commit 03c765b0e3b4cb5063276b086c76f7a612856a9a:
> 
>    Linux 5.19-rc4 (2022-06-26 14:22:10 -0700)
> 
> are available in the Git repository at:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux tags/linux-vimc-5.20-rc1
> 
> for you to fetch changes up to 55c592e9cff59e0d1c4069b7fe649b02ddf6c36b:
> 
>    media: vimc: documentation for lens (2022-06-29 12:58:21 -0600)
> 
> ----------------------------------------------------------------
> linux-media-vimc-5.20-rc1
> 
> This vimc update Linux Media 5.20-rc1 consists of enhancement and
> cleanup patches:
> 
> - add lens to vimc driver and links it with sensors using ancillary
>    links.
> - add documentation for lens
> - changes to make the code readable and maintainable.
> 
> ----------------------------------------------------------------
> Daniel Oakley (3):
>        media: vimc: expand the names of vimc entity types
>        media: vimc: enumerate data link entities for clarity
>        media: vimc: use data link entities enum to index the ent_config array
> 
> Yunke Cao (2):
>        media: vimc: add ancillary lens
>        media: vimc: documentation for lens
> 
>   Documentation/admin-guide/media/vimc.dot       |   4 +
>   Documentation/admin-guide/media/vimc.rst       |  19 ++
>   drivers/media/test-drivers/vimc/Makefile       |   2 +-
>   drivers/media/test-drivers/vimc/vimc-capture.c | 270 ++++++++---------
>   drivers/media/test-drivers/vimc/vimc-common.h  |   9 +-
>   drivers/media/test-drivers/vimc/vimc-core.c    | 142 ++++++---
>   drivers/media/test-drivers/vimc/vimc-debayer.c | 393 +++++++++++++------------
>   drivers/media/test-drivers/vimc/vimc-lens.c    | 102 +++++++
>   drivers/media/test-drivers/vimc/vimc-scaler.c  | 216 +++++++-------
>   drivers/media/test-drivers/vimc/vimc-sensor.c  | 307 +++++++++----------
>   10 files changed, 830 insertions(+), 634 deletions(-)
>   create mode 100644 drivers/media/test-drivers/vimc/vimc-lens.c
> ----------------------------------------------------------------
