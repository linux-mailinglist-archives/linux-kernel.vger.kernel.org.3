Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0D24ACC15
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 23:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244594AbiBGWe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 17:34:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238052AbiBGWe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 17:34:28 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4DDC0612A4
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 14:34:27 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id m10so18707868oie.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 14:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jZpXna9RakCKkgXGAFhti4wc05ngWfCJ4E7jcKRY2H4=;
        b=eZanaDLiv1hJcEwlxqmy0AJ7x+q9T4OvmtYZ8B2Yc55juThoXIGjgkg8RYy1qxJuXx
         JHAEaTni7L8CZqYwNGrDoo5LUyjO6Y5vnqsVfR0P9W0Y40jCMS6mfD6vnl7ic4L086Dt
         Jlcf9lTGh9S5tJpRQizAahaC+b88QiEWGNl+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jZpXna9RakCKkgXGAFhti4wc05ngWfCJ4E7jcKRY2H4=;
        b=QVw+8qLAHUebQrRWNGcW+rfaKCi9/1XoyuD4n5+UQQgta0BRIkB09Li0M5DE/h/0id
         WZL/dmBsVJJuCjgquG/VVxKoAbRxVNglFnhoTBNtL6YxnQXXCNIp1Wn1vQ//UQzhFqQo
         pb4XlDMOngOQtyMrwItSa1U+4YH5ZmDjpN+8CrTbm5OK1iFobb/9rLzC1KrcNvj38nQi
         ztrzfXtxMPZEe2ransSwPYqBa1eB7kMH4/I7ltxiUGIMudrD5kk8AeZxwk9nkjqWE4VO
         EDvQY4MknYdPXWUwEQg9kcZ/uWy9E1NJQLOLtybmcU9naHBbx7yxSnXcRneB6/O+5SV8
         pvfg==
X-Gm-Message-State: AOAM533Al2rKNp3N+UauvLlVw0BBfUUI31bxP6ndrAzqiFVeLGAcTzXn
        Ibk4gkS9YEzzOfgVnSI4WcKanQ==
X-Google-Smtp-Source: ABdhPJz8cJPnojSXGkuYGPCtnTXScbq+YaH87iccoI/UR4HFfH/DkAwdJhhFBXNp6jCFhJLpeQuGrA==
X-Received: by 2002:aca:41c5:: with SMTP id o188mr534669oia.160.1644273267306;
        Mon, 07 Feb 2022 14:34:27 -0800 (PST)
Received: from fedora64.linuxtx.org (104-189-158-32.lightspeed.rcsntx.sbcglobal.net. [104.189.158.32])
        by smtp.gmail.com with ESMTPSA id d21sm4452745otq.68.2022.02.07.14.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 14:34:26 -0800 (PST)
Date:   Mon, 7 Feb 2022 16:34:25 -0600
From:   Justin Forbes <jmforbes@linuxtx.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        slade@sladewatkins.com
Subject: Re: [PATCH 5.16 000/127] 5.16.8-rc2 review
Message-ID: <YgGecQQ6T1+W0s8s@fedora64.linuxtx.org>
References: <20220207133856.644483064@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207133856.644483064@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 03:04:44PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.16.8 release.
> There are 127 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 09 Feb 2022 13:38:34 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.16.8-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.16.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Tested rc2 against the Fedora build system (aarch64, armv7, ppc64le,
s390x, x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>
