Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 817B15222E8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 19:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348302AbiEJRlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 13:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348336AbiEJRlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 13:41:09 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A82D59947
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 10:37:10 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id f6-20020a4ace86000000b0035f083d2216so3447960oos.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 10:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kimSJUw+1y3TWVKZKDRg/9WkCe2sjm3zwO8CY1sBvJw=;
        b=Q7c4aBhrqyZYYcQ7Qg84ae7RwvmJky/It4UGx3GRBGfnUWmV5ZtPh8iVP5W5vybGib
         K6qus722UFzQ9Jg+S6JyxMV9SY8pYuXjLpRjQjnv1shYXGCMWC5fPOVZpc69DF1/Guw3
         scJLUXwjyRk5MiI6UBlkXKiyBLsI6lZ6AReoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=kimSJUw+1y3TWVKZKDRg/9WkCe2sjm3zwO8CY1sBvJw=;
        b=6tl3VmCT5NSEQ9gjJKIrEDvD6PivLrRj1qG/7fCE4TNJ0SZje5YKxEJRfYaO4Ss7+s
         sR3pGPSh09AMJ983x62XKnElnDH+Ir9gHP21UTrKCoEtJ/HcfvHP19bYs7i2tX0BBDjh
         qDbcNgd2KiN9SBkxBrltSSQYmFvEDootWBQyICywy2PMbgPm02iycB6Eym676k8k43XC
         omQsFGI6kstfBdhX/i/9EJWhAPg7QDB3IgUCJ2cpsowL0Dhz1I7Tgzhf/YXE5frqYF/z
         GGA9f70dPPVbEBlO6I3usyDQwpjjI0lUfQ0xRWQ3eliSQC+LqAA9yXTjzo9JWZyRN7GN
         bqbg==
X-Gm-Message-State: AOAM533PTmlwdSHJXhnslbfFYLe3g7Epm2pkk9VdNvZ0eIGVcq0lmWAu
        XIBwqHR2jRXRGydOi5UwgLZp3A==
X-Google-Smtp-Source: ABdhPJy618OqAHTNYEB7Ht4AIljGWcZGcbRjXKXUWC0+tAvVjj9cleCBbxEWWKuaa3Cl/znWOfmqyQ==
X-Received: by 2002:a9d:1295:0:b0:605:fecb:3a68 with SMTP id g21-20020a9d1295000000b00605fecb3a68mr8341169otg.295.1652204229470;
        Tue, 10 May 2022 10:37:09 -0700 (PDT)
Received: from fedora64.linuxtx.org (104-189-158-32.lightspeed.rcsntx.sbcglobal.net. [104.189.158.32])
        by smtp.gmail.com with ESMTPSA id 17-20020aca1211000000b0032603df9d24sm5478412ois.47.2022.05.10.10.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 10:37:08 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date:   Tue, 10 May 2022 12:37:07 -0500
From:   Justin Forbes <jforbes@fedoraproject.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        slade@sladewatkins.com
Subject: Re: [PATCH 5.17 000/140] 5.17.7-rc1 review
Message-ID: <Ynqiw777zgkZUVVU@fedora64.linuxtx.org>
References: <20220510130741.600270947@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220510130741.600270947@linuxfoundation.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 03:06:30PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.17.7 release.
> There are 140 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 12 May 2022 13:07:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.17.7-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.17.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, armv7, ppc64le,
s390x, x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>
