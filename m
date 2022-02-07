Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB15F4AB2F1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 01:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242549AbiBGA2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 19:28:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbiBGA2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 19:28:33 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB48C06173B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 16:28:29 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id z18so2258066iln.2
        for <linux-kernel@vger.kernel.org>; Sun, 06 Feb 2022 16:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qJZH5SQWtAUvEuzB+xyORW/mnV48Z5NQWkLiyfybDVI=;
        b=M34RH6/hyZ1QU7svxl7FjHTy0BlLAW2Ieh8z72kkxjl38SJlL9PRUV9wwcCFc8npcI
         QpSf+SwxBMWimiTheHxEtqUVDPo+YGzyPX+jvAEtptq6omwiBnmjcGo3tNQ7hA491IGD
         CaYF7medc/8TqqWuXripPwEbx9wSMbgk6chL9z/BdC+na4iWovAqXtugNt34AdMIl4Jc
         9KI/9prVNuxw8wK4WzQF3A5VLH7Gc96W9Wm6sOXcFPheVcRGN4sl52ucCU5lJYVVvBtU
         uDTM+wCtie15uAKGUH0Tlo7I2dyctm/7S+G+tQW9DVS5kUi8d3Jrl8IkL76YReaZgnQ9
         0L7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qJZH5SQWtAUvEuzB+xyORW/mnV48Z5NQWkLiyfybDVI=;
        b=aDJOMHBVW9KxKUHI92AxuTJXLJEiR+7XDtVnYGCRXrsH6/K4XQGKuQvryfLFWmu9zB
         bYdiSR4hX+wPFI/L668RDRHxMXr9EVxVqa2wYQuIaLUO6qB2AtxqxWzp8OnxLrBAJXkI
         5Iv80jplEpbyh0StzKX5LSB6FhgTO/Udhfm11PsIx5IGbYTNNj3bb7ztKguDzfnARnCi
         X0JUKrvILoBZKUjYxRYJNac1JKvtJd/79eSGGTWCn2osW8dtUQU97bXxFixhB39kraV1
         NTicvD7lNVMMzDPNnyZvUgn23OiOt37L5NJB/thiMJuAKz5D24H6C2xFfMPuHRfJ5KLK
         kFnQ==
X-Gm-Message-State: AOAM530xI1F6+hrH96RJ+EdKxrlaIhcv9YN8+WgqwHeDX5d6k4rVOm7B
        uEZENfNDVqj6PkDDgSWRQezGxeawwnrJI4psjEkGZght
X-Google-Smtp-Source: ABdhPJwNmQaf1GY6ozhQGJDefveSTnHowIyn75jJu3yLAhX+HJm9kh2OBvIkzLIGt7MAyka798DN5ntZ492WBF4wOfc=
X-Received: by 2002:a92:da0b:: with SMTP id z11mr3889944ilm.321.1644193709339;
 Sun, 06 Feb 2022 16:28:29 -0800 (PST)
MIME-Version: 1.0
References: <202201310402.vCWP8CUS-lkp@intel.com>
In-Reply-To: <202201310402.vCWP8CUS-lkp@intel.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 7 Feb 2022 01:28:18 +0100
Message-ID: <CANiq72=0asxB4J97PpC3SibLLryDnJz09KroSeFY0ABmS5ztVQ@mail.gmail.com>
Subject: Re: [rust:rust 964/1016] warning: unknown warning option
 '-Wpacked-not-aligned'; did you mean '-Wover-aligned'? [-Wunknown-warning-option],
 err: false
To:     kernel test robot <lkp@intel.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>, kbuild-all@lists.01.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 30, 2022 at 9:13 PM kernel test robot <lkp@intel.com> wrote:
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>

This is fixed in the `rust` branch (the error and the other warnings).
Also, our CI is now under GCC 11.2 and enabling
`CONFIG_ZERO_CALL_USED_REGS` confirms it is fixed.

Thanks a lot for running some of the runs with Rust enabled!

By the way, it seems that for some reason the bot picked the warning
first, instead of the error.

Cheers,
Miguel
