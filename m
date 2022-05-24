Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD34532DC9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 17:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239035AbiEXPqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 11:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239027AbiEXPqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 11:46:11 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8E61262B
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 08:46:08 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-e5e433d66dso22723084fac.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 08:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FyDDPQu3O41CbXdlWbKh5ZJsr7XwF3sPnUxGkoR/4J0=;
        b=A2mvnXd9khO4n+5qtrNEeHwWUV+PxeNy3I5VtJESXcA0NMINdV2kw3z3hY++cUNeEd
         IWR9dOieMgPnGBGKTg250NN9iv+Gj8FVD6l94DeKLyr9CRwDrD7ZOu84AaB8WrHqn7OB
         JOSL7bJ6fkjUfgSxVW4JReu12zjksxsUP/aNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=FyDDPQu3O41CbXdlWbKh5ZJsr7XwF3sPnUxGkoR/4J0=;
        b=IJn9tJ11aXfBxE0OozNXoA2PWeuxXFnZH4r4dk5NJvxDKHXj6Q8MW2jN/XWMXmW2DU
         uj9oRGk0yBwqrgPRCfl6RPHpwHvGHvcLRG3hSfMZu27zzNB6DCNzPJWfTP4tu/0sZrVa
         CLvpv3W2EedHWc1gtxqpNy/aRCtbWFNiytgg5hm5c3XYrG9zL2HcalmTWZR0NelodHOf
         dPeziNrdmS8P2xDOdGlKeCYC38XFJaR8AaL9azF94Hz2xssc+OvUT72q3mH4904yB/3s
         PN+nPWHIuStEnvaCsPZdXSjgkxeC3M64XSlwP4qvdMVnYHxdlQstTSaxMmZIrvMyDiJC
         VlNw==
X-Gm-Message-State: AOAM530PZa+1vSC0FyVPUIr5ly2CCJk+L9xOLhofz8mYlHrvQYrxoj9k
        yU8l8vkt0u4GgXNNiuDu2wJV4g==
X-Google-Smtp-Source: ABdhPJzfJKyNSkwYp6ZImwtVdnAcSgzraPXT05rIw5hxvUJ0bJZ90+XD6Kwkh+R1pA8VQDo5QI16AA==
X-Received: by 2002:a05:6870:2111:b0:e9:768:f288 with SMTP id f17-20020a056870211100b000e90768f288mr2682058oae.45.1653407167699;
        Tue, 24 May 2022 08:46:07 -0700 (PDT)
Received: from fedora64.linuxtx.org (104-189-158-32.lightspeed.rcsntx.sbcglobal.net. [104.189.158.32])
        by smtp.gmail.com with ESMTPSA id n126-20020acaef84000000b00326d2cba5d3sm5243569oih.8.2022.05.24.08.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 08:46:07 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date:   Tue, 24 May 2022 10:46:05 -0500
From:   Justin Forbes <jforbes@fedoraproject.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        slade@sladewatkins.com
Subject: Re: [PATCH 5.17 000/158] 5.17.10-rc1 review
Message-ID: <Yoz9vS6+9hF0EY1Y@fedora64.linuxtx.org>
References: <20220523165830.581652127@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523165830.581652127@linuxfoundation.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 07:02:37PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.17.10 release.
> There are 158 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 25 May 2022 16:56:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.17.10-rc1.gz
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
