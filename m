Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 872F547FA53
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 06:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhL0F0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 00:26:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbhL0F0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 00:26:07 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4055C06173E
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 21:26:06 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id a23-20020a9d4717000000b0056c15d6d0caso19317065otf.12
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 21:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fQfrEhf4JgkLRpVypOrU6Fj/bpWrK2qDmRRv89nSiuY=;
        b=O5Zo1BsYgrDbtkM5mJZoO6K4bwuVRvq54CC2da+kflBLRtctTw3Y6Zu3BDATvWs7dV
         wCXvDy39k5ks99uh9XvvMqNqHRgg4OnKqP7xPZ+Xstm9ieEoyGoI1rTe4SVp5ih0cilk
         7M7qe+9YKPWfnGAFiwxMEpU3IGAu68sajQW8g478Ro2kURVLXq1zrdNrf7vOYVJps1Bk
         wfzNxERZJfkteLJ5WGR1y6wLrPlM30gwe8xJa9KNifY0hVDECvRz+KV+AWFYReYoG9Ms
         aAA36adhvGs2nKCWcInxZnxNdkSSylXGsXiIiCofxXJab5vvDvv6T3gf9uY2D3DhUE/H
         XtIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=fQfrEhf4JgkLRpVypOrU6Fj/bpWrK2qDmRRv89nSiuY=;
        b=C/zrqV3qfiDzSuk9s9DFIvPpK0Ux7q/DvgZw1qJBmPunTqOgSQOrzSsAc+bu+9luiP
         BJ5M4JWt9EZ6xg5zgfMjAPOtn+jMD4Ijol4Fl9bxCHufGDlWGS/gbDL0k9raVWyc4Z/p
         1jATCWn0VAgN8B8gVZ59tdup2O9ogrc6QGPPwoPpcWac+xh0zsh7IbvGqHchyy1oBoBd
         kjyIabpfYGsdwEJ/TsxwaK3cT2IW3zLiFmgCJQB2yJbgOI5z1+c+gjJxzegwzaWpdMxQ
         K4z6OJeZ6O7061pK1Z6UqH6AUcl/5Hicy/fK8NcCvfg9v9IaypyvR+NBpLC0HCYJ8hou
         PXiA==
X-Gm-Message-State: AOAM531C/F+OmNXdClkQmZraS1fjMrYxBv70mlFzwJPN83QKLqBMQ0Uy
        Z3mTzX4FT2km7BVaKiek/tWScoSy7SE=
X-Google-Smtp-Source: ABdhPJyaPUrvjQbHr9vRSUXwtFGxIU+mSWqW3i6YDSXnG614t9cOF5CI9SkQm5hAsDvmQ8eQofP/Fg==
X-Received: by 2002:a9d:65c7:: with SMTP id z7mr11535182oth.305.1640582764232;
        Sun, 26 Dec 2021 21:26:04 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o19sm3115793oiw.22.2021.12.26.21.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Dec 2021 21:26:03 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 26 Dec 2021 21:26:01 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.16-rc7
Message-ID: <20211227052601.GA433206@roeck-us.net>
References: <CAHk-=wgV_v+Enop3TwRFtJY74UjQtw=kfOzGXTQscLx2syW6Eg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgV_v+Enop3TwRFtJY74UjQtw=kfOzGXTQscLx2syW6Eg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 26, 2021 at 01:30:55PM -0800, Linus Torvalds wrote:
> To the surprise of absolutely nobody, this rc7 is fairly small.
> 
> The stats look pretty normal, with about three quarters being drivers
> (networking, input, sound, tee, hwmon, rdma..). Somewhat unusually, we
> have a PC keyboard controller (not USB - the old legacy kind) fix in
> here - one of the earliest supported hardware still hangs around, and
> still gets some probe-time changes for odd hardware.
> 
> The rest is mainly some kvm and networking fixes, and a few random
> stragglers elsewhere.
> 
> Obviously the holidays are a big reason it's all small, so it's not
> like this is a sign of us having found all bugs, and we'll keep at
> this for at least two more weeks.
> 
> Hope everybody had a good Xmas (or insert your preferred alternative
> holiday) and I'll wish you a happy new year in advance. Because I
> suspect the upcoming week will be even quieter since at least _some_
> of this past week was "this is my last pull request before xmas".
> 
> Shortlog appended, please do give this a whirl.
> 

Build results:
	total: 153 pass: 153 fail: 0
Qemu test results:
	total: 480 pass: 480 fail: 0

Guenter
