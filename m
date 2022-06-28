Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2AA55DD86
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243501AbiF1CuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 22:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343818AbiF1Ctv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 22:49:51 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B813AE65
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 19:49:47 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-101e1a33fe3so15351813fac.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 19:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=omhesUeqSl6JODFUBkHgNv2EMm6rR/1o7aoGMnPTWAc=;
        b=KRRqPxOE6TtTEnKo4/F9m2Kq/wHr7oCufMYzyjfVPFKzj7QN1FR52G83rdmffkNOu0
         8E4S4ZDaJ2JiwIfTpVsa2sFP6qclOcdt9BZYj9qDYMS9CjsiDQ31VaUdU+iofhxLdOA/
         gjniueTH8mpQr2Gb3Ru84pwE80Nl1ja+cYnPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=omhesUeqSl6JODFUBkHgNv2EMm6rR/1o7aoGMnPTWAc=;
        b=r9CPaQzDPmFj5SehFFepUkI7XeIIaKLDSHoHcIEebolFmcm7C/yz6oey8jTHZYuW5m
         5E5kahuIKctc9mARtoRnH4neLGVLPuWSkcPpFn+Y1XEu5gSj8hdzpK6LN8BjHmkc1kno
         93n0FR8kQ8i316WQOMmbe5OQGAmfFrXf0Y0d6peZg4olY3R0Wkca0pqq8CKLiAVWikZ4
         X5hmINd1V2zrKSlgYM7hXvCdwGENH627kjemI4HLDIaelfqvzAy89+FRgk4X5fQfN28t
         B08UBV8WOg82BSN3spU+pUvQbPzWXkPpjxqrDFRO2WO9Z6sIkfFzAurXSSzHJlsRU0j0
         r7NQ==
X-Gm-Message-State: AJIora8DNqXIyc3aUxehxICRvApcUBgnzlDcxr2RjXtPaWuAIy3xsmsv
        nz/FqRwrN6198tT07LSDgA4uzA==
X-Google-Smtp-Source: AGRyM1uH55IwiERIY2IjWQ3oihHykzMB6Fx6gt+EEsvFU3RsRMNVUHvx2/sZ7VVZLkYphtLL2TtsFw==
X-Received: by 2002:a05:6870:5809:b0:101:ce10:b267 with SMTP id r9-20020a056870580900b00101ce10b267mr12329014oap.83.1656384586506;
        Mon, 27 Jun 2022 19:49:46 -0700 (PDT)
Received: from fedora64.linuxtx.org (99-47-93-78.lightspeed.rcsntx.sbcglobal.net. [99.47.93.78])
        by smtp.gmail.com with ESMTPSA id w70-20020acaad49000000b003351fa55a58sm6217794oie.16.2022.06.27.19.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 19:49:45 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date:   Mon, 27 Jun 2022 21:49:43 -0500
From:   Justin Forbes <jforbes@fedoraproject.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        slade@sladewatkins.com
Subject: Re: [PATCH 5.18 000/181] 5.18.8-rc1 review
Message-ID: <YrpsRzmt+O4/gvdi@fedora64.linuxtx.org>
References: <20220627111944.553492442@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627111944.553492442@linuxfoundation.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 01:19:33PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.18.8 release.
> There are 181 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 29 Jun 2022 11:19:09 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.18.8-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.18.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, armv7, ppc64le,
s390x, x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>
