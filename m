Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8505B4E7D48
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbiCYUEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 16:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbiCYUCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 16:02:51 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A1321A8A3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 12:53:57 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id d15-20020a9d72cf000000b005cda54187c3so6263360otk.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 12:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JPz6/u9uVJZWjST/GlaM0n3BZju2sh7hkRe9l60Le4c=;
        b=hKXFElzWVSZAlf46xzHe9eicEgGG5M1Nv4HdZSiV5BsODtUvxb5+JmXdXUfuxsRZiY
         dJPp+usSKS5KO5oBNDmfKwJd/Ify8WmQpnhzSpN9RYX2Pf6PaYfprDFAWE0sB/NQexR2
         gjKMkvikUXC0hH1u5WfXQlUjL2PAFf+h+EbFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=JPz6/u9uVJZWjST/GlaM0n3BZju2sh7hkRe9l60Le4c=;
        b=uNnMkXqSxDnm+HzPW1yrlxLZuJZOtcnyB8/Jrtga9sMQso9vQ8jGpOD3pq1jgKvoln
         SZymTC/oVvvxmBG2LCM6XNtZRkOgWvDcfMJABsExHvXfO3fZLULVpKsuxCPKUcqbnocj
         lbHZ5jK5/c8PA65bfgiMHOnrIRxcvWqYhiv0LbZHY/auUzlJNPnDL8eWFmg7BcommRH+
         hws0xD/nH0Y+GMyi08wg1W7zgXF4vnOr4a4Fym8xrKPqnmwbp/aut5f3kDHhGtLJ8Jsc
         vLIxQLAdze8CoobXa0P6Q6NH+IjWksbAPrrQyZiKk9aFlRBuu9b5hyZ+TMtosumoRHw8
         0HDA==
X-Gm-Message-State: AOAM532bNra/Z2Am0rdbiMz4sxrblcoS0KnI+kmCI32yVZ3xCAzvjOPB
        GXwBXvGzSO0vb+mjMWCPj38ymA==
X-Google-Smtp-Source: ABdhPJzxIXZREoCOR4kMQODizemJUjgbMxDfCz/hO2+oic2qx6M2KmXxBb/5uWgwpeS3pKr0HkyiWw==
X-Received: by 2002:a05:6830:1484:b0:5cb:4a65:c91b with SMTP id s4-20020a056830148400b005cb4a65c91bmr5207181otq.121.1648238036385;
        Fri, 25 Mar 2022 12:53:56 -0700 (PDT)
Received: from fedora64.linuxtx.org (104-189-158-32.lightspeed.rcsntx.sbcglobal.net. [104.189.158.32])
        by smtp.gmail.com with ESMTPSA id n124-20020aca4082000000b002ecd08d8497sm3220125oia.5.2022.03.25.12.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 12:53:55 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date:   Fri, 25 Mar 2022 14:53:54 -0500
From:   Justin Forbes <jforbes@fedoraproject.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        slade@sladewatkins.com
Subject: Re: [PATCH 5.16 00/37] 5.16.18-rc1 review
Message-ID: <Yj4d0p9OyUd6SDlT@fedora64.linuxtx.org>
References: <20220325150420.046488912@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220325150420.046488912@linuxfoundation.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2022 at 04:14:10PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.16.18 release.
> There are 37 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 27 Mar 2022 15:04:08 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.16.18-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.16.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, armv7, ppc64le,
s390x, x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>
