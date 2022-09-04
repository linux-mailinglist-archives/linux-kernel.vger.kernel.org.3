Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5060D5AC59B
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 19:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234994AbiIDRMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 13:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiIDRMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 13:12:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01DFE1E3F3;
        Sun,  4 Sep 2022 10:12:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 97C87B80D5A;
        Sun,  4 Sep 2022 17:12:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B803BC433C1;
        Sun,  4 Sep 2022 17:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662311567;
        bh=O6rToCUb5zLmWDKVsvsmaT9CaDZVvE7JM7ebxX/EoGo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DUXlaObT+cCno0w2q1ivca9XjqDxKGW4ZGjqNi4Y77O4TNL11RJJq0N94FLqFBj5s
         dW5p5+dhqHTEQUgHkNPnpXGY+Ukpzvp1K3HVwfzLmXsvegPrtrVBL0QUXBJfusr8f+
         nAkqUA6+Bz2N52VjV2Fcd+opuEeNjL2eBssDjcVTzWuBJKfrDCZB7HuJC0zotThl8C
         yjMgBAcfjn3Xyb8GQ0F1t2b6g8NarjO1v/pL0BsUdWwcWT+z6pe/mj7GBnQOd2TJCo
         OOfLHXQQxstZY+fZBwWmsbe4dXYcKcFNVPgwoQNIYOJxzFG6aibxGTQENqquDziZyU
         GK4PKWqEmsjxA==
Date:   Sun, 4 Sep 2022 17:38:39 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     andy.shevchenko@gmail.com, hadess@hadess.net, hdegoede@redhat.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] iio: Add single and double tap events support
Message-ID: <20220904173839.226167ad@jic23-huawei>
In-Reply-To: <20220831063117.4141-1-jagathjog1996@gmail.com>
References: <20220831063117.4141-1-jagathjog1996@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Wed, 31 Aug 2022 12:01:15 +0530
Jagath Jog J <jagathjog1996@gmail.com> wrote:

> This patch series adds new event type for tap called gesture and direction
> is used to differentiate single and double tap. This series adds single
> and double tap support for bma400 accelerometer device driver.

Applied to the togreg branch of iio.git and initially pushed out as testing
for 0-day to see if it can find things we missed.

I'm still open for comments on this if anyone interested has a chance to look
at the ABI, but changes will need to come as patches after I push the
tree out as non rebasing later this week.

Thanks for your hard work on this Jagath - it's a hole that's been there
a very long time so good to fill it in :)


Jonathan
> 
> Changes since v3
> 1. Added a macro for the length of the tap configuration arrays.
> 2. Corrected a grammar mistake.
> 3. Arranged the local variables in reverse Xmas tree order.
> 
> Changes since v2
> 1. Replaced doubletap_tap_2min to doubletap_tap2_min.
> 2. Added ABI docs for available attributes which lists tap configurations
>    values.
> 3. Added 'tap' in the naming of available attributes which are related to
>    tap configurations.
> 5. Added check for channel type in _read_event_value() and
>    _write_event_value().
> 6. KernelVersion changed to 6.1.
> 7. Corrected typos.
> 
> Changes since v1
> 1. Included headers in alphabetical order.
> 2. Changing tap_event_en variable name to tap_event_en_bitmask since it is
>    used in bit manipulation operation.
> 3. Assigning boolean value to step_event_en and activity_event_en instead
>    of 0, since they are boolean type members.
> 4. Using local variable for regmap_read() instead for *val itself.
> 5. Correcting typos.
> 6. Remove of IIO_EV_INFO_PERIOD.
> 7. Now all 4 tap controls like threshold, quiet, tics_dt and quiet_dt can
>    be configured from the userspace.
> 8. Introducing new event info IIO_EV_INFO_RESET_TIMEOUT, and
>    IIO_EV_INFO_TAP_2MIN_DELAY into iio_event_info.
> 9. Creating custom read/write attributes for tics_dt called
>    in_accel_gesture_maxtomin_time.
> 10. Time based tap controls can be configured in seconds instead of raw
>     values.
> 11. Provided all available values for time base tap controls in seconds.
> 12. Adding one more MODULE_AUTHOR().
> 
> Changes since RFC
> 1. Corrected the "quite" typo to "quiet".
> 2. Added proper reference and name of the section from datasheet.
> 3. Changed the ABI documentation to make it more generic.
> 4. Added ABI documentation for double tap quiet period.
> 5. Added available list by registering new event attribute for tap
>    threshold values and double tap quiet period values.
> 6. Sending both single and double tap events separately.
> 8. Removed checking for tap enabled while changing data rate.
> 9. Returning invalid with error message if the input data rate is not
>    200Hz while enabling tap interrupts.
> 7. Added datasheet reference for interrupt engine overrun.
> 
> Jagath Jog J (2):
>   iio: Add new event type gesture and use direction for single and
>     double tap
>   iio: accel: bma400: Add support for single and double tap events
> 
>  Documentation/ABI/testing/sysfs-bus-iio |  69 +++++
>  drivers/iio/accel/bma400.h              |  14 +
>  drivers/iio/accel/bma400_core.c         | 343 +++++++++++++++++++++++-
>  drivers/iio/industrialio-event.c        |   7 +-
>  include/linux/iio/types.h               |   2 +
>  include/uapi/linux/iio/types.h          |   3 +
>  tools/iio/iio_event_monitor.c           |   8 +-
>  7 files changed, 434 insertions(+), 12 deletions(-)
> 

