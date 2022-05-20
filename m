Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A1A52EA2C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 12:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348272AbiETKsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 06:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbiETKsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 06:48:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C454AE19;
        Fri, 20 May 2022 03:48:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F3F2A61D45;
        Fri, 20 May 2022 10:48:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B74B9C385A9;
        Fri, 20 May 2022 10:48:28 +0000 (UTC)
Message-ID: <67deb2d6-cb04-ddb3-6c24-14d8ecb31ed9@xs4all.nl>
Date:   Fri, 20 May 2022 12:48:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] [v2] media/platform-wide: platform: Add moli to the match
 table
Content-Language: en-US
To:     Scott Chao <scott_chao@wistron.corp-partner.google.com>
Cc:     mchehab@kernel.org, bleung@chromium.org, groeck@chromium.org,
        zhuohao@chromium.org, linux-media@vger.kernel.org,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220520104253.26054-1-scott_chao@wistron.corp-partner.google.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20220520104253.26054-1-scott_chao@wistron.corp-partner.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Huh? The Subject is now *really* bad. I think you misunderstood my comment
on the original patch.

"[PATCH] media: platform: foo" suggests a patch touching on many drivers in
drivers/media/platform. But this patch only touches on a single driver, so:

"[PATCH] media: platform: cros-ec: foo"

That way the maintainer of that driver will see the name of the driver in the
subject as well, and might comment upon it.

Regards,

	Hans

On 5/20/22 12:42, Scott Chao wrote:
> The Google Moli device uses the same approach as the Google Brask
> which enables the HDMI CEC via the cros-ec-cec driver.
> 
> Signed-off-by: Scott Chao <scott_chao@wistron.corp-partner.google.com>
> ---
>  drivers/media/cec/platform/cros-ec/cros-ec-cec.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
> index 8c8d8fc5e63e..25dc7309beab 100644
> --- a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
> +++ b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
> @@ -217,6 +217,8 @@ static const struct cec_dmi_match cec_dmi_match_table[] = {
>  	{ "Google", "Fizz", "0000:00:02.0", "Port B" },
>  	/* Google Brask */
>  	{ "Google", "Brask", "0000:00:02.0", "Port B" },
> +	/* Google Moli */
> +	{ "Google", "Moli", "0000:00:02.0", "Port B" },
>  };
>  
>  static struct device *cros_ec_cec_find_hdmi_dev(struct device *dev,
