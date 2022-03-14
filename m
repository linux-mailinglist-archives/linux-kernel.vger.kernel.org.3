Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90A144D8DC8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 21:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244914AbiCNUHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 16:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234180AbiCNUHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 16:07:04 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC17403ED
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 13:05:54 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id n5-20020a4a9545000000b0031d45a442feso21804659ooi.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 13:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iL+bTF+IsJj2jfqqbh63XbPYr229OTSdVOr9HvKPCW0=;
        b=TvMuOAeIRfWytcYVW6/pg0KYzYrx9Tkxdo4o5kJKp1AwbBur9neOONvgjXK7aCQowK
         qvKd4xqhAUQZfT9YjahbL9ca2ZzjkajQUPO/zkPl36ooh449iOMz0Rrpk7DUj0zH1PqI
         VmTjLtNHvo36r8ScufR7fwNxUecCfr+qp7+yg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iL+bTF+IsJj2jfqqbh63XbPYr229OTSdVOr9HvKPCW0=;
        b=Xd66CkajuuAMgAPDaVFrl0/2n0NV65doa/FMAg6wBr5JEOzFmxv6LT5LWFu/kvWHcS
         f4PqBPeD9UDfoFPMsBCMWf8TNu/ZymWxlCNkfSH68kHbIXuka3xwriEmX4atKxLOSQS5
         px+035RJstOqd/zCLPlnUdLx76R1kHKHG9Ngx7W5fRBp0B8PhOQPKJYW9k3P0OMdwgvS
         ER3w9K6SWxrRZeTEjPFCizoevb1sJSNRy3sJkV2lL3kmT8ldianuKJaPJuksvdQI/NYC
         YSucX9HYboceZgaUddb0DAth1z2H/kVMyuFlHbSigrxPmrxRQmcKbFFXNQYNQ7j8qv6u
         pnCA==
X-Gm-Message-State: AOAM532RHTpTDQ/73Kf2Q4R8QFNoJyEvsIC1LOpbB8IN11cSuMVDreI9
        IfMUYT3Jinit3EQlQ6fptZwmKA==
X-Google-Smtp-Source: ABdhPJy0s8+oSNomesaZ0ulF3NtaDRMWwTOCjPz1yaBWqLDcyEb0YpB2dblrbvA9Ii/MbMTDfH0M2Q==
X-Received: by 2002:a05:6870:e74b:b0:db:2768:f169 with SMTP id t11-20020a056870e74b00b000db2768f169mr375879oak.120.1647288353793;
        Mon, 14 Mar 2022 13:05:53 -0700 (PDT)
Received: from fedora64.linuxtx.org (104-189-158-32.lightspeed.rcsntx.sbcglobal.net. [104.189.158.32])
        by smtp.gmail.com with ESMTPSA id n11-20020a9d710b000000b005af4ceeaac1sm8074726otj.37.2022.03.14.13.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 13:05:52 -0700 (PDT)
Date:   Mon, 14 Mar 2022 15:05:51 -0500
From:   Justin Forbes <jmforbes@linuxtx.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        slade@sladewatkins.com
Subject: Re: [PATCH 5.16 000/121] 5.16.15-rc1 review
Message-ID: <Yi+gH+yWc5td2rR8@fedora64.linuxtx.org>
References: <20220314112744.120491875@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220314112744.120491875@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 12:53:03PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.16.15 release.
> There are 121 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 16 Mar 2022 11:27:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.16.15-rc1.gz
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
