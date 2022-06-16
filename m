Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D1054E127
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 14:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233297AbiFPMy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 08:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233271AbiFPMyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 08:54:52 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3883AA74
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 05:54:50 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1011df6971aso1787669fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 05:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+60kb7Jq0Ft63tpD8oZlYpWYfkxxSFBSQY8N/T0Hz5M=;
        b=GGBRnc5NAsPV9pSvXj3TWryUafn6St16NwJv/QTfQ2m4job2hZvC0YdOBzpqyUUPnn
         wt/abIcQpqvd/JPh8lHTmfrPYDF489B0C985ow1yl44G38bWUWaecJwhYFdVQUCm50WU
         fVm86SzU00ET0NNx/+SMO8+4bKZwQNQsWmBV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=+60kb7Jq0Ft63tpD8oZlYpWYfkxxSFBSQY8N/T0Hz5M=;
        b=fbPvunCECvLlaEQg9+i4+Tzdxgh6Ehixp08sRAKO5WXDsw/rp7zf1H0fvA5t2K87Co
         IWW7cmAe+EM6HXiV3U84f9n1GjLyzKXF3jSEW9AGtGTiFs03Qze5auTn5gSekeYE+pZL
         Gneh1fRRyn3TQb5W4gCO2jOmHlc1DTFs/F1lcR7TvPoods+Z1xB31ExNH8G0Wq2h7GTQ
         cw29/0tYtSVJbfirsbM++hji9qR6jTuASmJpsvksuqphpYku//QOsFJWToT0WVU1bc2k
         PGytVpE2ixrRLmUjvQeASmsbJ9x6vKjnrGRL3QOYwCBD2zkFPDPPvUn3w+99i8dbpxQA
         1Luw==
X-Gm-Message-State: AJIora+EiK0KrMW/iMQH048HJ7GpWGqTPMjKfT7k+O1gDKje5QjjJqYC
        YQ5GLaIyMxt1xNz7RMftVFjWiA==
X-Google-Smtp-Source: AGRyM1vfK2fVN9wsZ+r1rjRy8l70N3Ep7eu0AL5Bfe5UDTH73mGOvYUXdxUb1wRKj+TY91Aox+Hn4A==
X-Received: by 2002:a05:6870:8311:b0:100:ef5f:77b6 with SMTP id p17-20020a056870831100b00100ef5f77b6mr8048060oae.157.1655384089622;
        Thu, 16 Jun 2022 05:54:49 -0700 (PDT)
Received: from fedora64.linuxtx.org (99-47-93-78.lightspeed.rcsntx.sbcglobal.net. [99.47.93.78])
        by smtp.gmail.com with ESMTPSA id r187-20020acaa8c4000000b0032ec0af21a7sm795995oie.10.2022.06.16.05.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 05:54:48 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date:   Thu, 16 Jun 2022 07:54:47 -0500
From:   Justin Forbes <jforbes@fedoraproject.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        slade@sladewatkins.com
Subject: Re: [PATCH 5.18 00/11] 5.18.5-rc1 review
Message-ID: <YqsoF2SHMmgW7wSq@fedora64.linuxtx.org>
References: <20220614183720.861582392@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614183720.861582392@linuxfoundation.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 08:40:37PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.18.5 release.
> There are 11 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 16 Jun 2022 18:37:02 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.18.5-rc1.gz
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
