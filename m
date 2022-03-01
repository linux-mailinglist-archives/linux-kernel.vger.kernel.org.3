Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6E524C8FA9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 17:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235239AbiCAQHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 11:07:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbiCAQHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 11:07:00 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389E821E27
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 08:06:19 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id s1-20020a056830148100b005acfdcb1f4bso12558464otq.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 08:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FjIe1KKKDE0QpJR+EX/tD4Xgs8J58UrfwdgzXopAHx0=;
        b=DxhqBPY2ZJvFRPNcfFL12VwJZ/aXUFAV2V8IB44VwjzZJ6VevVFo0Xd5JwZv5/3tyP
         fiSjMi+f+BCyxcQbVWAl2TLMWtuRkKljuEta7uAgDXQyKqq3mBFyZtCjVkmQJratgzq3
         P86SkEpvse89SsTdUbTkEG5k/HLRzN6MAxggc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FjIe1KKKDE0QpJR+EX/tD4Xgs8J58UrfwdgzXopAHx0=;
        b=hc8uKTx0O4qDOQzIaa+/QjNWTpcBfMhwrjZtvqmm1syKV/6Vvimp2lxeMP25b5Afkk
         LMKCJFrUSTdTgJMJTUzxyfinXwo5nLu+kAkXgHJ0xFW1FG1x2YwKI3r9XWZEg2gO3tRP
         sXgcIGSO1sVlpucPrUW22k6tdMvskJh9pgO/mAdQk1pCJWiEyhNnTfZbCbNIRnqEfSVc
         HT7ScFdtihRzQ01iF/fue25UjBiDLyq0LhfJ+dQa8219nZAfhQhNLRYglfS1bEAK0IVX
         t6W7d0SJDAVS0/Sj6uSaPsGI846Z+FgBo0j3sDyeDNKfp8aRVOUa1XzCudZyFA+roqlE
         dlMQ==
X-Gm-Message-State: AOAM533rhfpOCd6Nl6FMthMQ6TH3PQDF9IGq5bJ/i8YC+aldOLSNx9Cs
        7PQ2PlSl6cAYIgRCtK6rWfuAEA==
X-Google-Smtp-Source: ABdhPJwLe78NTYJKm38V5AVOnQMIUbVYK7mL7wvNoTuFdjZv0B5QM9fTBqOf5UQpU6Dgwlrjswfzlw==
X-Received: by 2002:a05:6830:5:b0:5af:7ed5:8f64 with SMTP id c5-20020a056830000500b005af7ed58f64mr12743319otp.257.1646150778490;
        Tue, 01 Mar 2022 08:06:18 -0800 (PST)
Received: from fedora64.linuxtx.org (104-189-158-32.lightspeed.rcsntx.sbcglobal.net. [104.189.158.32])
        by smtp.gmail.com with ESMTPSA id bf39-20020a056808192700b002d51f615f1csm8435165oib.34.2022.03.01.08.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 08:06:17 -0800 (PST)
Date:   Tue, 1 Mar 2022 10:06:16 -0600
From:   Justin Forbes <jmforbes@linuxtx.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        slade@sladewatkins.com
Subject: Re: [PATCH 5.16 000/164] 5.16.12-rc1 review
Message-ID: <Yh5EeJ/psXZrrJSk@fedora64.linuxtx.org>
References: <20220228172359.567256961@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228172359.567256961@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 06:22:42PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.16.12 release.
> There are 164 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 02 Mar 2022 17:20:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.16.12-rc1.gz
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
