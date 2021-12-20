Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE98A47B5DC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 23:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbhLTWZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 17:25:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbhLTWZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 17:25:45 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47BE3C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 14:25:45 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id z6so9159329plk.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 14:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WhHan/P3Id000y7TKidbql/t1fQORYAY/iPLj24Ndbs=;
        b=S2sdkGB4VqVc66qNNupKTihUmt8KPKK29ar2rBj4ylOu1ItNRxI93h3t7CmSXPgcMw
         HhEStR2Sg0J4ZPI6kikffyXZOd1qBzGM7hp3JgInYQqKyB9YSbHx7zuwt6uvaNHAn7uB
         7b13ILDaoU4zKNnjsidnw3J/XmHQlBz7SrP8BOuw0vKwUKQ9OFP41w6EiTx/rX30L4mb
         tmZeHetvg2hHo6bZAHnhrPGo2knUsLAReltg8Up5UE8kRlH2Jv60hoV3tRYqTuwR7xxF
         REVeQ8XqTY2RuCfDPzax93298IlZ6CeWJRmBRk9v7atH+o8cklRl/J06qUXZtBViTxhQ
         dP2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WhHan/P3Id000y7TKidbql/t1fQORYAY/iPLj24Ndbs=;
        b=pHzqNBSBpBG0g/ZsHKRVPUyVa2X9kqKKXHqGIxAKHypP0gODJqC0Y+vh5RBH+EHK4b
         1y4nCE2sEy86FxbEjd0HK2svKfM60LiXSG8fG+KvAuzKVFRF7PElfjh7muWx2Hc0Vouf
         WmfoVCqXQhCqxyj3kL3vztZ98bkGdbveLoUThb7RlX+DFQU1SL5ikMKFvsi83DCvD7jJ
         zHgApeSq86up1nMAU8BjUOo9wLK8s2Rb7RHeWLpvsW81MHfe5dgjvImPbA75kwRAGI3e
         WFAu6Ek8DVeWLbqd2+/Hkv2bGZBqRQEX/LAx3krBeSZoq2cRGH+o1rFfoW60gnWXb0qd
         ezCg==
X-Gm-Message-State: AOAM532jaxyhGZ9BHVNxxAR7bfCpahJS37+cjD+Di72z+/U+NIRNKKxK
        Xj/U1TJuVKz4qXl2kr61cmw=
X-Google-Smtp-Source: ABdhPJwQjOil6JRfFkqPcb+BLX0At2eOudw8SbBhBcd4WCyZx3VjcMz4WC5jbjS+BcM68IttUE5hxg==
X-Received: by 2002:a17:90a:4a06:: with SMTP id e6mr369219pjh.228.1640039144631;
        Mon, 20 Dec 2021 14:25:44 -0800 (PST)
Received: from google.com ([2620:15c:202:201:9632:a1c4:968a:6f66])
        by smtp.gmail.com with ESMTPSA id 13sm18703636pfm.161.2021.12.20.14.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 14:25:43 -0800 (PST)
Date:   Mon, 20 Dec 2021 14:25:41 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     lianzhi chang <changlianzhi@uniontech.com>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, andriy.shevchenko@linux.intel.com,
        282827961@qq.com
Subject: Re: [PATCH v22] tty: Fix the keyboard led light display problem
Message-ID: <YcEC5XOdRwWHz1di@google.com>
References: <20211215125125.10554-1-changlianzhi@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215125125.10554-1-changlianzhi@uniontech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 08:51:25PM +0800, lianzhi chang wrote:
> Use the "ctrl+alt+Fn" key combination to switch the system from tty to
> desktop or switch the system from desktop to tty. After the switch is
> completed, it is found that the state of the keyboard lock is
> inconsistent with the state of the keyboard Led light.The reasons are
> as follows:
> 
> * The desktop environment (Xorg and other services) is bound to a tty
>   (assuming it is tty1), and the kb->kbdmode attribute value of tty1
>   will be set to VC_OFF. According to the current code logic, in the
>   desktop environment, the values of ledstate and kb->ledflagstate
>   of tty1 will not be modified anymore, so they are always 0.
> 
> * When switching between each tty, the final value of ledstate set by
>   the previous tty is compared with the kb->ledflagstate value of the
>   current tty to determine whether to set the state of the keyboard
>   light. The process of switching between desktop and tty is also the
>   process of switching between tty1 and other ttys. There are two
>   situations:
> 
>   - (1) In the desktop environment, tty1 will not set the ledstate,
>   which will cause when switching from the desktop to other ttys,
>   if the desktop lights up the keyboard's led, after the switch is
>   completed, the keyboard's led light will always be on;
> 
>   - (2) When switching from another tty to the desktop, this
>   mechanism will trigger tty1 to set the led state. If other tty
>   lights up the led of the keyboard before switching to the desktop,
>   the led will be forcibly turned off. This situation should
>   be avoided.
> 
> * The current patch is to solve these problems: When VT is switched,
>   the keyboard led needs to be set once.Ensure that after the
>   switch is completed, the state of the keyboard LED is consistent
>   with the state of the keyboard lock.
> 
> Signed-off-by: lianzhi chang <changlianzhi@uniontech.com>
> Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> ---
>  v22:
>  Return to the v19 plan, remove the judgment condition in
>  the vt_set_leds_compute_shiftstate() function.

Thank you for making the changes. The patch looks OK to me now.

>  
>  drivers/tty/vt/keyboard.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
> index c7fbbcdcc346..00283ba9a9e4 100644
> --- a/drivers/tty/vt/keyboard.c
> +++ b/drivers/tty/vt/keyboard.c
> @@ -153,6 +153,7 @@ static int shift_state = 0;
>  
>  static unsigned int ledstate = -1U;			/* undefined */
>  static unsigned char ledioctl;
> +static bool vt_switch;
>  
>  /*
>   * Notifier list for console keyboard events
> @@ -414,6 +415,12 @@ void vt_set_leds_compute_shiftstate(void)
>  {
>  	unsigned long flags;
>  
> +	/*
> +	 * When VT is switched, the keyboard led needs to be set once.
> +	 * Ensure that after the switch is completed, the state of the
> +	 * keyboard LED is consistent with the state of the keyboard lock.
> +	 */
> +	vt_switch = true;
>  	set_leds();
>  
>  	spin_lock_irqsave(&kbd_event_lock, flags);
> @@ -1255,6 +1262,11 @@ static void kbd_bh(struct tasklet_struct *unused)
>  	leds |= (unsigned int)kbd->lockstate << 8;
>  	spin_unlock_irqrestore(&led_lock, flags);
>  
> +	if (vt_switch) {
> +		ledstate = ~leds;
> +		vt_switch = false;
> +	}
> +
>  	if (leds != ledstate) {
>  		kbd_propagate_led_state(ledstate, leds);
>  		ledstate = leds;
> -- 
> 2.20.1
> 
> 
> 

-- 
Dmitry
