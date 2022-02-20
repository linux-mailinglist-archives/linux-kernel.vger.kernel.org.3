Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBE7A4BCEFA
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 15:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243996AbiBTO12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 09:27:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbiBTO1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 09:27:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E121EC42;
        Sun, 20 Feb 2022 06:27:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2ADBAB80D44;
        Sun, 20 Feb 2022 14:27:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D6FBC340E8;
        Sun, 20 Feb 2022 14:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645367218;
        bh=RTigvJDntL6YVrCZiZEnoHivr3No4Poo1ugUd6o9OOA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qZeLd9QNm+MvELxBeIy46L4kJE97lrRj+vtOl6ACAkDZN4nGM9TDoQuju06Xy2Z+D
         xBF1+jdwFExfnWWQBjCReGy3gJQp2OOjC702qMFzdtL4EP+GCT8RlCX4e5IQtq1rei
         ETA8iwYVato7MjgSUITt3wiYuU2/fvfegn0mgtPM3+0CbMV29PfQX6J88LH1fGGsdD
         upcm7NkRgYiMNige18VHZp/nW7uLYVBRnUzr0FkdLwWEnX1Kkyf049Ctz6gjLE2dgz
         Z5ni7iFZRFyoPaRSUE6uA5QMwzgezzW85Zk51EkCjtyqcsysJt+4Y+7RG+1QJE6ShP
         OXp5HlHRpNLUA==
Date:   Sun, 20 Feb 2022 14:33:48 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     lars@metafoo.de, andy.shevchenko@gmail.com, sst@poczta.fm,
        robh+dt@kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/7] iio: potentiometer: Add support for DS3502
Message-ID: <20220220143348.44f71d62@jic23-huawei>
In-Reply-To: <20220220024632.4183-1-jagathjog1996@gmail.com>
References: <20220220024632.4183-1-jagathjog1996@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Feb 2022 08:16:25 +0530
Jagath Jog J <jagathjog1996@gmail.com> wrote:

> Add dt-bindings and support for Maxim DS3502 into existing ds1803 driver.
> DS3502 is a 7 bit Nonvolatile Digital Potentiometer.

Looks good to me.  Will leave it on list a few more days though
to allow others to comment if they wish.

Nice work,

Thanks,

Jonathan

> 
> Changes since v3:
> 1. Dropped the chip type switch statement in read_raw function.
> 2. Added device specific read function pointer in their structure.
> 3. Added two separate functions to read values from two different types
>    of devices.
> 
> Changes since v2:
> 1. Addressed Andy Shevchenko comments.
> 2. Adding device name in Kconfig file.
> 3. Spliting up of patch into 3 patches.
> 4. Adding channel info into ds1803_cfg in separate patch.
> 5. Dropping the use of enum in firmware data instead using previous
>    pointer method for accessing device specific data.
> 6. Separate patch for using firmware provided data instead of 
>    id->driver_data.
> 7. Adding DS3502 support in separate patch.
> 
> Changes since v1:
> 1. Fixes the alignment to match the open parenthesis in separate patch.
> 2. Adding available functionality for ds1803 driver in separate patch.
> 3. Moving maxim_potentiometer members into ds1803_cfg structure.
> 4. Droping of the INFO_ENABLE channel type.
> 5. Firmware entry with data is used instead of id->driver_data to
>    to retrieve the chip specific data.
> 
> Jagath Jog J (7):
>   iio: potentiometer: Alignment to match the open parenthesis
>   iio: potentiometer: Add available functionality
>   iio: potentiometer: Add channel information in device data
>   iio: potentiometer: Change to firmware provided data
>   iio: potentiometer: Add device specific read_raw function
>   iio: potentiometer: Add support for Maxim DS3502
>   dt-bindings: iio: potentiometer: Add Maxim DS3502 in trivial-devices
> 
>  .../devicetree/bindings/trivial-devices.yaml  |   2 +
>  drivers/iio/potentiometer/Kconfig             |   6 +-
>  drivers/iio/potentiometer/ds1803.c            | 153 +++++++++++++-----
>  3 files changed, 121 insertions(+), 40 deletions(-)
> 

