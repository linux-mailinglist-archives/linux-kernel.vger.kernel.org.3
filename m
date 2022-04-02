Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E814F04CF
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 18:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357953AbiDBQW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 12:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357947AbiDBQW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 12:22:26 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3102583B9;
        Sat,  2 Apr 2022 09:20:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6313ECE094D;
        Sat,  2 Apr 2022 16:20:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2845C340EC;
        Sat,  2 Apr 2022 16:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648916431;
        bh=XgXaNNuEeJ937JoBXfirPFs0iHTDR3KVxroTM16ZOXU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vPb4/LeXLtPgTtnh7SrubheryX+KZ17p/OHrO4TkrXgkO9FhxVggv5bJT9FYBWDrq
         aX80NsOmWenz6OU8e9MeBUpt9eM1o/xRzR4aMdWW3XEdLd7p3eWfolcg+xSuyfd60B
         n5JblRKN3D6nc5uLOCywV5qK78+9yFd+FcFAwAnUQLfk0ZaPMwuQcM9Q9LOoX7fV5K
         7Kv5IGozbe4fWdJ4UGunY6520k0GykjiGT1PqlGyK1DWkv22CdDNf/ftWTFqS1/UJV
         vmK0qLUku6ASQSQuYINzy5BNWPBxfQhm+voxZoWDjDNa51CgFNI67kAIbUb4hnMQpw
         TjnqwWrgwZwyQ==
Date:   Sat, 2 Apr 2022 17:28:14 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Paul Lemmermann <thepaulodoom@thepaulodoom.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IIO: accel: dmard09: fixed code styling issues
Message-ID: <20220402172814.5117cdb7@jic23-huawei>
In-Reply-To: <YkItIE5sp3P4sZdY@hp-amd-paul>
References: <YkItIE5sp3P4sZdY@hp-amd-paul>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
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

On Mon, 28 Mar 2022 16:48:16 -0500
Paul Lemmermann <thepaulodoom@thepaulodoom.com> wrote:

> Cleaning up code.
> 
> Signed-off-by: Paul Lemmermann <thepaulodoom@thepaulodoom.com>
Applied to the togreg branch of iio.git and pushed out as testing
for 0-day to see if it can find anything we did wrong.

BTW.  You seem to have sent two identical copies of this patch.
I randomly decided to apply this second one.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/dmard09.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/dmard09.c b/drivers/iio/accel/dmard09.c
> index 53ab6078c..cb0246ca7 100644
> --- a/drivers/iio/accel/dmard09.c
> +++ b/drivers/iio/accel/dmard09.c
> @@ -24,7 +24,7 @@
>  #define DMARD09_AXIS_Y 1
>  #define DMARD09_AXIS_Z 2
>  #define DMARD09_AXIS_X_OFFSET ((DMARD09_AXIS_X + 1) * 2)
> -#define DMARD09_AXIS_Y_OFFSET ((DMARD09_AXIS_Y + 1 )* 2)
> +#define DMARD09_AXIS_Y_OFFSET ((DMARD09_AXIS_Y + 1) * 2)
>  #define DMARD09_AXIS_Z_OFFSET ((DMARD09_AXIS_Z + 1) * 2)
>  
>  struct dmard09_data {

