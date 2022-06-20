Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A729550EE5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 05:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237847AbiFTD0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 23:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbiFTD0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 23:26:19 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7D8635A
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 20:26:17 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id u37so9073931pfg.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 20:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Yl8TZSLlIrWnvtWBlkyCzwPO0B+9LO1vUzi/66N5xKk=;
        b=MEsuLci5DlfaBtPt4EaW6mCLFEEZ/OhWj0fZZIR9mPO+p/84fUvgYG/Y8kyMQGzpBn
         jM0k+QjSeIAlgHQ/7KkMTBYD9qAS4Cd50Gn89YKRswL4pHpxXUblWe2kiYwlHTiXxhEe
         JTTtgcNJut9GAonYal0InBIHRNuH0cUZxl/r7wubSPzXarrro0W+KM7a2yKaXV/cIJwN
         yOQ5qaoNEUx9ePz5GHac4twaACGNA8J4zgFQv2AeRIVmqWOX5Erg/lo18kqqd539L95T
         XnLHZJaFEu6pn1gdqy+SkN+GdyyhLE638iDDtaW4iS76lwpVYOMLjyhbQW9OGn5CE/T7
         hr/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Yl8TZSLlIrWnvtWBlkyCzwPO0B+9LO1vUzi/66N5xKk=;
        b=7QS8BlDOLKsl2hbJXUNZpVQQ95WybfOIBZLNUtieR9m3s68oFAoLmyTgtDP1hFrvQe
         ujfLOrrjgJQfMs8u1NUXKt6sYXgwFVYLJYCKjmEEapzHn0KjYBOhOuZgJgIZTjps9PlY
         mZeGZs7eAEhhS6AFsiQ66oLjbaY6GnDCOcuqP42svS4Bx3NVdNUU7I7qyfeNvq4yx0Zw
         /L2WCLfyVN6hTVx9Di4Xa8kmagoQ1f3ulbpTOqJ+f8jr4SnHH49aHuzETa5eNHIT4WyO
         7zsfMxNsdcBjqGu4+W7ZB3t2EmKZB9CZjKTjyVcmAH80SoXVGuABMvw0u1S6jROwbqNN
         yaHA==
X-Gm-Message-State: AJIora/shchcK+kyCOyfaQ5Q/lIk2WXMtIQyEFcD4h1d78gES1AupLAL
        TVF00N8WJAzJtSwldDWjsZZnI0F5LAM=
X-Google-Smtp-Source: AGRyM1v+3WHrnCshYu2Kxuslb12aijqfKPKxAhdSqERQjJ1EAc1eR7O0S/A+ZbuvZtbCzaIi0PgKEg==
X-Received: by 2002:a63:3803:0:b0:40c:78a2:75d6 with SMTP id f3-20020a633803000000b0040c78a275d6mr9101550pga.172.1655695577175;
        Sun, 19 Jun 2022 20:26:17 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 186-20020a6219c3000000b00525243d0dc6sm700426pfz.15.2022.06.19.20.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 20:26:16 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 19 Jun 2022 20:26:14 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.19-rc3
Message-ID: <20220620032614.GA3790004@roeck-us.net>
References: <CAHk-=wgErDgDFbU9astx+NTUu_KNi-jgzfF6RGup=cVee6+U=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgErDgDFbU9astx+NTUu_KNi-jgzfF6RGup=cVee6+U=g@mail.gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 19, 2022 at 03:38:26PM -0500, Linus Torvalds wrote:
> It's Sunday afternoon, which means it's time for another rc release.
> 
> 5.19-rc3 is fairly small, and just looking at the diffstat, a lot of
> it ends up being in the documentation subdirectory. With another chunk
> in selftests.
> 
> But we do have real code changes too, fairly evenly split between
> drivers, architecture fixes, and "other code". That other code is
> mostly filesystem fixes, but also some core kernel and networking.
> 
> Full shortlog appended for your enjoyment, but so far everything looks
> fine. Knock wood,
> 

Build results:
	total: 149 pass: 148 fail: 1
Failed builds:
	powerpc:allmodconfig
Qemu test results:
	total: 489 pass: 489 fail: 0

powerpc:allmodconfig build failures:

Error: External symbol 'memset' referenced from prom_init.c
make[3]: [arch/powerpc/kernel/Makefile:204: arch/powerpc/kernel/prom_init_check] Error 1 (ignored)
powerpc64-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.o uses hard float, drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_resource.o uses soft float
powerpc64-linux-ld: failed to merge target specific data of file drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_resource.o
powerpc64-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.o uses hard float, drivers/gpu/drm/amd/amdgpu/../display/dc/dcn315/dcn315_resource.o uses soft float
powerpc64-linux-ld: failed to merge target specific data of file drivers/gpu/drm/amd/amdgpu/../display/dc/dcn315/dcn315_resource.o
powerpc64-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.o uses hard float, drivers/gpu/drm/amd/amdgpu/../display/dc/dcn316/dcn316_resource.o uses soft float
powerpc64-linux-ld: failed to merge target specific data of file drivers/gpu/drm/amd/amdgpu/../display/dc/dcn316/dcn316_resource.o

as reported before. Patches to fix the problems have been submitted and
should hopefully find their way into mainline at some point.

There is also still the runtime warning

WARNING: CPU: 0 PID: 1 at lib/refcount.c:28 of_platform_bus_create+0x33c/0x3dc

seen with several arm qemu boot tests. It is fixed in -next.

Guenter
