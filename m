Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A65D543D83
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 22:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbiFHUXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 16:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbiFHUXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 16:23:35 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36A5158973
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 13:23:34 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-f2e0a41009so28668763fac.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 13:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1XIrvG/K8gITNy/52mX1MbIE/vLSDwOKBNkeFpE/ffE=;
        b=AavGPBavidx3kQ/yhXpB4T0Zie2jI/JYoTqULXlqWQNeA/krdSHe/bO7yRVHiOnLTi
         iH0VXpKVpix++Z8GJDlvo+i1S9W1mshbTs7E9U41mAhM3yzgoJxujtXNkleeX21G8sgW
         K7hU8njPji+4lsSaXidqUthqJ7E8a1MQrMx68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=1XIrvG/K8gITNy/52mX1MbIE/vLSDwOKBNkeFpE/ffE=;
        b=h2czfu1/y9MqdGoTkeGHXmZBRbaRTMy610So0FEe2FXhk7hQKa96kE46eZQ6/5Ap5z
         Noh9PdE9DyCGMrgoOsS8SSeJMO5+4zn96WP4FZ61reWQDiIEWMFXHpFRaPYJCzl2RMt0
         Hxgziwgc/LHzE9zFRkVKYB4uScoQ8ZsDT8FY60cAzijZhqkEk3EUcl6sK+s6+t66tLNE
         s+FRzIF13MhxBJQqIAbKnI5ABe58ZF4Uq5xn2O2kzRT1q+YGPgeeVnS8qVFuc6dIPcvq
         mFtb0FtcJY9pKIdJeEMFQYVXSklrXLcT3+vBDD3mYCO8d8etSeqbQBfMggLBWbRnKLhU
         WXIA==
X-Gm-Message-State: AOAM531O+jrSeCSDswsE52yOLb+jTfXqefUEiGcl/tEobFfCT4An5N5A
        SOEDfyvx0jdA+ztnyGwscjN50w==
X-Google-Smtp-Source: ABdhPJwhyoeZ3WMnKW4TlU881LEVRitdyIKXNBXw+1O2U3CKVjYvXVzjJprm2nRyqI6EcwDadmx8pw==
X-Received: by 2002:a05:6870:4188:b0:d9:eed0:5a41 with SMTP id y8-20020a056870418800b000d9eed05a41mr3570505oac.161.1654719814243;
        Wed, 08 Jun 2022 13:23:34 -0700 (PDT)
Received: from fedora64.linuxtx.org (99-47-93-78.lightspeed.rcsntx.sbcglobal.net. [99.47.93.78])
        by smtp.gmail.com with ESMTPSA id 91-20020a9d06e4000000b0060bc92bf0c9sm9229826otx.20.2022.06.08.13.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 13:23:33 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date:   Wed, 8 Jun 2022 15:23:32 -0500
From:   Justin Forbes <jforbes@fedoraproject.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        slade@sladewatkins.com
Subject: Re: [PATCH 5.17 000/772] 5.17.14-rc1 review
Message-ID: <YqEFRDpaUffEz6/1@fedora64.linuxtx.org>
References: <20220607164948.980838585@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607164948.980838585@linuxfoundation.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 06:53:12PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.17.14 release.
> There are 772 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 09 Jun 2022 16:48:02 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.17.14-rc1.gz
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
