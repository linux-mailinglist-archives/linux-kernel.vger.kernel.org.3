Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF8A596EE0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 15:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236852AbiHQMyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 08:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239355AbiHQMym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 08:54:42 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD0C4A10A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 05:54:38 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-11c5505dba2so1503418fac.13
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 05:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=VzhRylK/+DNQNkLT7Ej4ouC10Sn5B8Xt8H8jPqi1pzU=;
        b=K8C5VRTz4OxeScp41Jq1ELOW6wQZo+DPlGi/oZUW4S+IJ0hqRlLVQIIjl9smnic3V4
         XVoZp1xeOQI7y8PqDk1QXAdpI8UhbqlNtKVU57oJiAkKieLB/RfubuIuSH3RH8AHHvVi
         +qHtKUxumW08WOfEHAhuohx1mE+euCUi1AWW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=VzhRylK/+DNQNkLT7Ej4ouC10Sn5B8Xt8H8jPqi1pzU=;
        b=A/LOGvqZr/ADj3zFz3uzUMEvWb3aLSpwcGmLxV0ph2PGhUuejlyVpHXR1Vnf7LRIQ+
         KSJcf6AzCq9quMeGibZd23Tyl2RmT9WKP45UaxddDTevoO96q7onfXI3FKUB1IxQsm1r
         VGV415dXj8tEU/sCFsKVem+2KB86MjuaxqmJG4Rk1rnFJgGLId66FVo8wHAqOjjLMheq
         B+VKS2frmUE5r+ddk7zEduwelayjZLjJAJ/RLE7wav/dorA3ish+7VFb/HKmxnmPtFuL
         PybZTqVKnXgCYe7uQqA7Pb9M9Zj/iIpzwUwH1r0dTzbQ744vQsKsLfrAQNm5DHjEq6iT
         LQxQ==
X-Gm-Message-State: ACgBeo0ALf/2c3KhSJEa7r6bUICUaE3btCDdteX3tWD7wOWzMF23BW02
        rVErsXoFgx/g0hEQ8HY65ZmGhw==
X-Google-Smtp-Source: AA6agR7vFxlKYf9apeBCmmqfv/EDzQyvhO0OVVHHAaz6Rsr6WxZvARyIr6H/KlT71JkhA8ZxmiRVHA==
X-Received: by 2002:a05:6870:6086:b0:10b:8905:14c3 with SMTP id t6-20020a056870608600b0010b890514c3mr1542180oae.255.1660740877266;
        Wed, 17 Aug 2022 05:54:37 -0700 (PDT)
Received: from fedora64.linuxtx.org (99-47-93-78.lightspeed.rcsntx.sbcglobal.net. [99.47.93.78])
        by smtp.gmail.com with ESMTPSA id z24-20020a4ade58000000b0041ba884d42csm2980694oot.42.2022.08.17.05.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 05:54:36 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date:   Wed, 17 Aug 2022 07:54:34 -0500
From:   Justin Forbes <jforbes@fedoraproject.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        slade@sladewatkins.com
Subject: Re: [PATCH 5.19 0000/1157] 5.19.2-rc2 review
Message-ID: <YvzlClLuz6ELVPds@fedora64.linuxtx.org>
References: <20220816124610.393032991@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816124610.393032991@linuxfoundation.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 02:59:38PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.19.2 release.
> There are 1157 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 18 Aug 2022 12:43:10 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.19.2-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.19.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc2 against the Fedora build system (aarch64, armv7, ppc64le,
s390x, x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>
