Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1ECA5A6EE3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 23:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbiH3VKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 17:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiH3VKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 17:10:00 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC75DF5E
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 14:09:56 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-11eb44f520dso15554027fac.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 14:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=0myU2lj6GLw0m9FfQ38bL2g8d6PYMhpEJWoCAJ89vPg=;
        b=iwjI4db3R+xk/yQfIKjtScjvReVMxvdHa0tSswqO43bMR29KnBxP9BbK34YAhsK/TX
         46+eRNK8d4zBiwnSNOCn60hlS38r4mfXScoYgXRfR35xmJG2vnsrCKuM75HDa6f+fO3S
         gCPjnIG+SkBJ1b+nywj4/dYPi4PoW71ub6vvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=0myU2lj6GLw0m9FfQ38bL2g8d6PYMhpEJWoCAJ89vPg=;
        b=l0myv04aCSY4BliGcbC9CH/zluRBC8E+T7pYW4rYTqBtBhGrpbifyF62y0xHqB0bs7
         i5PrK7NI4widFJzOE2wTZtm1uHCnEiiEBzebocgoibLJAzfFtWoMB5WIYnRQznoHnzkC
         GoBpSOLermc81uO8BQQTPCFIyxlMh4adxlmtUzbDKKerr886YXvknamv+guDpMK8PtOc
         NiMVgFEyum2HPe+0WnhV7YTSdRHJqsMCnlOnoYtc6YulonvL5I3WTLR6rCo2is8iOzBM
         mszme1DjtEv3d/HSi6ZquKEZPtluZgn84+ZeX6rY3XYRpb77MDQ7+god4PvhW/zMW6ag
         IYYg==
X-Gm-Message-State: ACgBeo31WViwRQA99jbDK9xa6IK0vuu4gHt3EJE6HPRHEECgTrQ2JRQ+
        v66ysjdn/+f1wXpr7NAe0oF41hpoqo4LhRknbvU=
X-Google-Smtp-Source: AA6agR4DlDH0IW1BL3mu/n9fne/GDmNCq+4CtD0SOVbz3LGZP/ZFH181KLjmAwtXPNB0NNK916tbJg==
X-Received: by 2002:a05:6870:b14d:b0:11f:3460:c22e with SMTP id a13-20020a056870b14d00b0011f3460c22emr48971oal.203.1661893796074;
        Tue, 30 Aug 2022 14:09:56 -0700 (PDT)
Received: from fedora64.linuxtx.org (99-47-93-78.lightspeed.rcsntx.sbcglobal.net. [99.47.93.78])
        by smtp.gmail.com with ESMTPSA id r65-20020a4a3744000000b00445313616aesm7130076oor.21.2022.08.30.14.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 14:09:54 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date:   Tue, 30 Aug 2022 16:09:52 -0500
From:   Justin Forbes <jforbes@fedoraproject.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        slade@sladewatkins.com
Subject: Re: [PATCH 5.19 000/158] 5.19.6-rc1 review
Message-ID: <Yw58oMa793tCnYPi@fedora64.linuxtx.org>
References: <20220829105808.828227973@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220829105808.828227973@linuxfoundation.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 12:57:30PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.19.6 release.
> There are 158 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 31 Aug 2022 10:57:37 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.19.6-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.19.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, armv7, ppc64le,
s390x, x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>
