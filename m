Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5468A52B831
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 12:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235260AbiERKuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 06:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235188AbiERKuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 06:50:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07EAA777E;
        Wed, 18 May 2022 03:49:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19C946182C;
        Wed, 18 May 2022 10:49:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08578C385A5;
        Wed, 18 May 2022 10:49:55 +0000 (UTC)
Message-ID: <394bbfb1-9d05-0637-725a-c641bcf2fd45@xs4all.nl>
Date:   Wed, 18 May 2022 12:49:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] media: platform: Add moli to the match table
Content-Language: en-US
To:     Scott Chao <scott_chao@wistron.corp-partner.google.com>
Cc:     mchehab@kernel.org, bleung@chromium.org, groeck@chromium.org,
        zhuohao@chromium.org, linux-media@vger.kernel.org,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220511085442.23915-1-scott_chao@wistron.corp-partner.google.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20220511085442.23915-1-scott_chao@wistron.corp-partner.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Always mention the driver in the Subject. The current subject suggests
that this patch makes media/platform-wide changes.

Please post a v2.

Regards,

	Hans

On 5/11/22 10:54, Scott Chao wrote:
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
