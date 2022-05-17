Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC8CF52ADDB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 00:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbiEQWMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 18:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbiEQWM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 18:12:28 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD93D37AA7
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 15:12:26 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id q8so493068oif.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 15:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VcfAZinHlGFZ9Ka0EwGfmwNQcnOvK5QvS3DNltTPy4Q=;
        b=Redk3xYSoZYNgImQk/QEe4rpG0PT9L6UF1pSNMJC0M8QgBbDp66S//563qgFm6rfRM
         FCMsWa6EazZsqYsG7yjH+7WB4WijCqJG64oZpjBJMvBT6gfYLt5rzdYI1Uk+14m9Xen8
         WW1bOOZo26aI/rl/MMumcTveGS64WY0NdYUsM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=VcfAZinHlGFZ9Ka0EwGfmwNQcnOvK5QvS3DNltTPy4Q=;
        b=aLWGVoMB66lXKGFxxrRJkgkfTGBi9VxCNk/68oEIoRnRBo3MQU+Si0Pzi/FACbHF/6
         I2kC7nHzVqOMlfteMoykHD9fzNSDFKYkRUTCpInTdZJVrEQ/f2ls1tIzgSEjDQnzA1P1
         KK4/YsNURxMcsbixBNjNXf5/L1+OFKPiHPqpsX1sm2ltn7+gd3KnDoB+TNmPRtwwvWEA
         oMVc1KcpYuJq2lEqu0dCWmmDpNEaeBkDCnsNwP7vC6Kg4H7ke6qYzJQxME21e8z8BtG7
         YiOAnfGKCyLGTKmdXUcN2O1WudOu8ykCkacNnpjSL63qn/w44/wHPXDD3T5b44hXwixv
         Egeg==
X-Gm-Message-State: AOAM530uEnRkqg20mO8KQT8wLlA8iAIbkJSg6dvdkEePhnsvM1bAIpTZ
        U+CoK7Lu4yc4/nKtzPZEDAyjkA==
X-Google-Smtp-Source: ABdhPJxJWNaxLq329I3YOe6hnv9KAKfsG1BPHpCHrkaycjgJnFdd+1ssTnhRHt4xpj7egsSH2Q5cBA==
X-Received: by 2002:a05:6808:ecf:b0:2f9:f0b1:7ee8 with SMTP id q15-20020a0568080ecf00b002f9f0b17ee8mr11365329oiv.225.1652825546075;
        Tue, 17 May 2022 15:12:26 -0700 (PDT)
Received: from fedora64.linuxtx.org (104-189-158-32.lightspeed.rcsntx.sbcglobal.net. [104.189.158.32])
        by smtp.gmail.com with ESMTPSA id n4-20020a9d64c4000000b006060322124esm229794otl.30.2022.05.17.15.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 15:12:25 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date:   Tue, 17 May 2022 17:12:23 -0500
From:   Justin Forbes <jforbes@fedoraproject.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        slade@sladewatkins.com
Subject: Re: [PATCH 5.17 000/114] 5.17.9-rc1 review
Message-ID: <YoQdx540mnollWaK@fedora64.linuxtx.org>
References: <20220516193625.489108457@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516193625.489108457@linuxfoundation.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 09:35:34PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.17.9 release.
> There are 114 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 18 May 2022 19:36:02 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.17.9-rc1.gz
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
