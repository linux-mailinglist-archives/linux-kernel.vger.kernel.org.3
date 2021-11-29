Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C706460F41
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 08:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236730AbhK2HWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 02:22:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236904AbhK2HUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 02:20:22 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD73C061757
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 23:16:57 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id r5so15148751pgi.6
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 23:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TiukkxJd2u5/WWxioXXy4ShXE8P1+xdGddfjXUn1Icg=;
        b=dcJkyWJO7W1+s1KYCfjUJz82f77/eJpXN0khWr4biU8luP/6Mzq8zTKTDb8/hF/XbU
         Cprsc8gtrtscd7yJEgB/r1AtqApYvBcFnDyFEVydTE6h4moCXhenJuP4j7NPr/fPG8x4
         DfnucW7NdN+cezNMzFBGCE3/VIydNLtrTnM/t8XryYSL3l6Iciz/CFhioXfo8+EhvT3n
         VQeYg49fiBGyf4GKC5Lcsc1qz1GHGKKvZOgclGEv/JVUB7A0Y+WtrcAeVaF0ymNHP2Ob
         0xs2LV3mxr10kRqLRstax8E+0DNBieYt1kjZVHVTvFT/bAO31McwSMVfDzximbncIvVp
         Feag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TiukkxJd2u5/WWxioXXy4ShXE8P1+xdGddfjXUn1Icg=;
        b=Rc/xQHEo5bWwQPLCXAtf3RFtrZ+uGLG/lheB/sDXlaqKermEth3ovsC2EIHl3qrh4+
         epqHRDhC+T8YTC6oa/A13z3G04O7cEdFYaFySsUAmNhu4+r7TeKtDNdaHLX93dcmQ5oi
         Bvfq9dY5RDY4NItbtsQDKU8KkVW/z8fAwFuZ4rJOoWLUx4Ecego+FIQNnVrxnXqX4JBg
         v6AlubI1RV9EN7QRhqWVLgRHDcL4u+HVWJDWUWZskVIMTsFGylk0SqyZQzhldERyIMAU
         1YosS8GF58Jbi5JKv5pe/7nOfeJX97Nac7eRZ+faBxcLK2PYgM4hPKyr4FjurfBRhJaM
         9rXA==
X-Gm-Message-State: AOAM5325W0kftt+zVi56Q8ZAohCwdftOBqVHumkE72Ci+fev4LPcFHje
        Pyg8EgoAm8b6T2skAuwdjoc=
X-Google-Smtp-Source: ABdhPJymx1QXcFImPYmofFDV6L/lpn9TBBFq2IkLt4RI4bewl6f0q86pIVDoJk1O09vmzxWlz6aDLA==
X-Received: by 2002:a62:5fc6:0:b0:4a2:ae6d:14cd with SMTP id t189-20020a625fc6000000b004a2ae6d14cdmr37345490pfb.26.1638170217149;
        Sun, 28 Nov 2021 23:16:57 -0800 (PST)
Received: from google.com ([2620:15c:202:201:f5d5:95ab:43b1:99a9])
        by smtp.gmail.com with ESMTPSA id h8sm16515205pfh.10.2021.11.28.23.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 23:16:56 -0800 (PST)
Date:   Sun, 28 Nov 2021 23:16:53 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     lianzhi chang <changlianzhi@uniontech.com>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, andriy.shevchenko@linux.intel.com,
        282827961@qq.com
Subject: Re: [PATCH v18] tty: Fix the keyboard led light display problem
Message-ID: <YaR+ZfOpmRbRUTMz@google.com>
References: <20211129040445.24134-1-changlianzhi@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211129040445.24134-1-changlianzhi@uniontech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Nov 29, 2021 at 12:04:45PM +0800, lianzhi chang wrote:
> +	/*
> +	 * When switching VT, according to the value of kb->kbdmode,
> +	 * judge whether it is necessary to force the keyboard light
> +	 * state to be issued.
> +	 */
> +	kb = kbd_table + fg_console;
> +	if (kb->kbdmode != VC_RAW ||
> +		 kb->kbdmode != VC_MEDIUMRAW ||
> +		 kb->kbdmode != VC_OFF) {

Please do not do that. Even if kbdmode is one of those states if might
be set up to show LED pattern set by ioctls (KDSETLED), so you still
want to restore LEDs.

Also, you are trying optimize something that happens pretty infrequently
and it is really easy to get it wrong. It is much safer to let the
kernel [re]set LEDs regardless of kbdmode and then let X do its own
thing.

Thanks.

-- 
Dmitry
