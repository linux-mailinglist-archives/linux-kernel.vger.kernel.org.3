Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 978B34E5773
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 18:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343569AbiCWR3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 13:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239166AbiCWR3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 13:29:04 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B317B577;
        Wed, 23 Mar 2022 10:27:35 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id mp6-20020a17090b190600b001c6841b8a52so7059159pjb.5;
        Wed, 23 Mar 2022 10:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=W5pYT/F8t16XQbM3qlDKbbsJw4C6bC82sHdzEgCXN8E=;
        b=GDg1zhAMUcNSRBRWchOY916ZL3epaxVmXkOwkuzuKQh27+8rn28+zp63IOtKzzcDaR
         qJ0EAxLqtGRKCULxFdhyvoZpninXTBjsZhCdm/0zeDl3qMi7Lo910smtr51S5Q4v726y
         KkIqFYVtaNhSNfrTk9ZdNcPjVI1T50b/UlzKC491rFgm1viTIgUcguLH05dhbBLPfZge
         9iYPbqS8mTejy8qW6fRUrZTW1wno+JGhTjr8sc7SDCf0iGMJQ1sWxy7+RuvpMNuwi7RJ
         +SCn8AHuv0oee4AsUWDGN80dRSJWs3pYHm8ypSAIFIy0zJmP4Dy9U+T6wDPXm8AniFBY
         v7MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W5pYT/F8t16XQbM3qlDKbbsJw4C6bC82sHdzEgCXN8E=;
        b=b9cN6U0UtllqdkwLQDeWtrbqtZj8mHUxep4OHbIE7GfcmIw4Mi/NaIAonRhPshbXLB
         0Oa3Co0/I1eKmwD8jVIP869LbcMj8DQWQlnW3S7Mt/rL0JsaFdV5tmld4pUOKIBM4Uxp
         8+tRdTdCFw+QuZBCAw6e6QCQq8SaOJeNYuq2te9rcQrrwKHhrQ2NOZVdHlGM8DoY6q+y
         hX5QLPwGT6IJwmUVDneiztbZeSK9T9Zty86DwYAXkVRnP3BIMXj6NjhGfzz82RJGMzFP
         vINB7iL+WP6NXV7V/dblYwWkvw+VuzwPwQs4/V6NqcOOyZzljczvXDY02kRynGCWtHQ9
         ragA==
X-Gm-Message-State: AOAM530aL05TTfj66gahgAJCEdQh/bpFAOpKg6Pne7Hmf69CTJWbFZ+y
        dr04wTgl6cXLD5yke0hG9ds=
X-Google-Smtp-Source: ABdhPJxmn2IR2mFeOCj/Oi7mLw04WcTeNzzvDTl+Ne7JpdcB3OPU7XiQhd5xvXyxhHze1bIILNMI7A==
X-Received: by 2002:a17:902:cf0e:b0:14f:8a60:475c with SMTP id i14-20020a170902cf0e00b0014f8a60475cmr1176077plg.146.1648056454158;
        Wed, 23 Mar 2022 10:27:34 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:d52a:448a:8e0b:67f1])
        by smtp.gmail.com with ESMTPSA id h16-20020a056a001a5000b004fa343c2d0csm491499pfv.136.2022.03.23.10.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 10:27:32 -0700 (PDT)
Date:   Wed, 23 Mar 2022 10:27:30 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "jingle.wu" <jingle.wu@emc.com.tw>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        phoenix@emc.com.tw,
        "jingle.wu" <jingle.wu@elan.corp-partner.google.com>
Subject: Re: [PATCH] Input: trackpoint - Add Suspend mode for Elan TrackPoint
Message-ID: <YjtYgoBvytgQu/pn@google.com>
References: <20200904024231.26812-1-jingle.wu@emc.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904024231.26812-1-jingle.wu@emc.com.tw>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jingle,

On Fri, Sep 04, 2020 at 10:42:31AM +0800, jingle.wu wrote:
> From: "jingle.wu" <jingle.wu@elan.corp-partner.google.com>
> 
> Add suspend command for elan trackpoint

Could you please elaborate what this mode does to the trackpint?

Also, your signed-off-by is missing.

> ---
>  drivers/input/mouse/trackpoint.c | 16 ++++++++++++++++
>  drivers/input/mouse/trackpoint.h |  1 +
>  2 files changed, 17 insertions(+)
> 
> diff --git a/drivers/input/mouse/trackpoint.c b/drivers/input/mouse/trackpoint.c
> index 3eefee2ee2a1..b3cba973a4eb 100644
> --- a/drivers/input/mouse/trackpoint.c
> +++ b/drivers/input/mouse/trackpoint.c
> @@ -389,6 +389,20 @@ static int trackpoint_reconnect(struct psmouse *psmouse)
>  	return 0;
>  }
>  
> +static void trackpoint_cleanup(struct psmouse *psmouse)
> +{
> +	struct trackpoint_data *tp = psmouse->private;
> +	u8 param[3] = { TP_TOGGLE, TP_TOGGLE_BURST, TP_TOGGLE_ELAN_SLEEP };
> +
> +	if (tp->variant_id == TP_VARIANT_ELAN) {
> +		if (ps2_command(&psmouse->ps2dev, param,

I'd combine the 2 "ifs".

> +				MAKE_PS2_CMD(3, 0, TP_COMMAND))) {
> +			psmouse_err(psmouse,

psmouse_warn() since it is not a hard error.

> +				    "failed to suspend trackpont.\n");

I'd say "failed to suspend Elan trackpont\n".

> +		}
> +	}
> +}
> +
>  int trackpoint_detect(struct psmouse *psmouse, bool set_properties)
>  {
>  	struct ps2dev *ps2dev = &psmouse->ps2dev;
> @@ -421,6 +435,8 @@ int trackpoint_detect(struct psmouse *psmouse, bool set_properties)
>  	psmouse->reconnect = trackpoint_reconnect;
>  	psmouse->disconnect = trackpoint_disconnect;
>  
> +	psmouse->cleanup = trackpoint_cleanup;
> +
>  	if (variant_id != TP_VARIANT_IBM) {
>  		/* Newer variants do not support extended button query. */
>  		button_info = 0x33;
> diff --git a/drivers/input/mouse/trackpoint.h b/drivers/input/mouse/trackpoint.h
> index 5cb93ed26085..c7fa75452976 100644
> --- a/drivers/input/mouse/trackpoint.h
> +++ b/drivers/input/mouse/trackpoint.h
> @@ -107,6 +107,7 @@
>  #define TP_TOGGLE_EXT_TAG	0x22	/* Bit 3 of the first packet coming from the
>  					   external device will be forced to 1 */
>  #define TP_MASK_EXT_TAG			0x04
> +#define TP_TOGGLE_ELAN_SLEEP	0x8

It seems to me that TP_TOGGLE_ELAN_SLEEP is a bit in TP_TOGGLE_BURST
subcommand, so it is better to move it next to TP_MASK_BURST and call it
TP_MASK_ELAN_SLEEP to match the rest.

Thanks.

-- 
Dmitry
