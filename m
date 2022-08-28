Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE3D5A3D13
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 11:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiH1J6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 05:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiH1J43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 05:56:29 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9804952FDD;
        Sun, 28 Aug 2022 02:56:28 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id i188-20020a1c3bc5000000b003a7b6ae4eb2so1690226wma.4;
        Sun, 28 Aug 2022 02:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=uF1cBWnD9V/6QV2r1LkXOLqZB9ABkh9yZksOLuQoa44=;
        b=nwu6Q0fs/GRqHRUdjnJP1FjlGAL69zA9WwsQmQwq/J9QwNzh8+Ij66BtBS5yLFSDaU
         O32mZYa4STFSz8AuMEVn6fZPoF5iM7+e28ooYlWc7sFkp64/e4Q73QJO8VH5uaz3kD0p
         /WRqkB8GQpjcRkKfQEJT9aRTnnL9BMGQgMNFVHANGJ5av4z45WQWI8j2XZtCWD05PUSp
         Cw8zYJVKVKydgyMejjvI77VwwR9qPl+42rh7ncFTVWWvq0P1NvQxnP7mDOw1dw2fNy79
         ufkdElcBYv88+L1Tp39ZwoblwW+r8YquF6Y75tsEOmVWTlRccAkT99jNqri+09konGMQ
         MmYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=uF1cBWnD9V/6QV2r1LkXOLqZB9ABkh9yZksOLuQoa44=;
        b=zxc2YAa3/EZB75ppNxjTAecqHVTvNE+ljayXsrnSjm1sGwjDV+Xqo3LUI/dpU1e+i/
         Fbzd5yGn6lwxJ1ch/FcimiW0ksFDMtx+DmFuKC49LmpVpvgl6XT5ZdSMK+/g3VV2fXSn
         n+cbU6AMqMuq9PLtr4V2R5ovKVrw8QHzZ4iaFyV/OnSI1N/Gchk6ZXBir+GNXwhlxeej
         VZNZRzrwoF1dMhhq2CocnGZ8YjHtdxOmifq073jCRGKuPZDf9qUA1XY0QYJW5fFKI2pV
         EF0LBOkQybq6CIaDh6W8Mg5s93uehIRJl3LtQ1B+DnmGM3/29lV4U5Uyc5gwlV1tKB6L
         a6kA==
X-Gm-Message-State: ACgBeo3klJNwLONbIFGQzyoRtHhwdFnb6pMA8T8aOQ3cv7jszrFJoj26
        j/kUvZldmzrT2ROMZ+w0sm0=
X-Google-Smtp-Source: AA6agR45gLdtzUdh1r3scAU1iZySoMqcZfZRVPLICI/RT5+UjVYJfeO7s15X8O2geEJpk9/W2iKzvg==
X-Received: by 2002:a05:600c:1e88:b0:3a6:2ca2:e34f with SMTP id be8-20020a05600c1e8800b003a62ca2e34fmr4175835wmb.146.1661680587091;
        Sun, 28 Aug 2022 02:56:27 -0700 (PDT)
Received: from elementary ([94.73.32.249])
        by smtp.gmail.com with ESMTPSA id h15-20020a5d548f000000b0020e6ce4dabdsm4122020wrv.103.2022.08.28.02.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Aug 2022 02:56:26 -0700 (PDT)
Date:   Sun, 28 Aug 2022 11:56:24 +0200
From:   =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Stefan Hansson <newbie13xd@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: input: fix uclogic tablets
Message-ID: <20220828095624.GA4121@elementary>
References: <20220822062247.1146141-1-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822062247.1146141-1-benjamin.tissoires@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

On Mon, Aug 22, 2022 at 08:22:47AM +0200, Benjamin Tissoires wrote:
> commit 87562fcd1342 ("HID: input: remove the need for HID_QUIRK_INVERT")
> made the assumption that it was the only one handling tablets and thus
> kept an internal state regarding the tool.
> 
> Turns out that the uclogic driver has a timer to release the in range
> bit, effectively making hid-input ignoring all in range information
> after the very first one.
> 
> Fix that by having a more rationale approach which consists in forwarding
> every event and let the input stack filter out the duplicates.

Apologies for the delayed response, I was on holiday.

Tested on the affected device (HUION H640P) and I can confirm that the
issue is fixed.

I also tested in other non-Wacom tablets and they keep working as
expected.

Best wishes,
Jose

> Reported-by: Stefan Hansson <newbie13xd@gmail.com>
> Fixes: 87562fcd1342 ("HID: input: remove the need for HID_QUIRK_INVERT")
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
>  drivers/hid/hid-input.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index 48c1c02c69f4..871a185a0f1f 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -1532,7 +1532,10 @@ void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct
>  			 * assume ours
>  			 */
>  			if (!report->tool)
> -				hid_report_set_tool(report, input, usage->code);
> +				report->tool = usage->code;
> +
> +			/* drivers may have changed the value behind our back, resend it */
> +			hid_report_set_tool(report, input, report->tool);
>  		} else {
>  			hid_report_release_tool(report, input, usage->code);
>  		}
> -- 
> 2.37.1
> 
