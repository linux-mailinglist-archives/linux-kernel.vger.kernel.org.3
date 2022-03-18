Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27144DE45C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 23:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241425AbiCRW6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 18:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234425AbiCRW6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 18:58:11 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3F52D41FD
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 15:56:51 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id w17-20020a056830111100b005b22c584b93so6511649otq.11
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 15:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PLzyPUSjfo0Qtpj5gmZd3aXs/ZxVVAJIrjiNg+OPCHg=;
        b=PWzsIQQCIcyveMJ9nhBODeJlRKnFyQEWhF7OC2D7N/QJkOdQ6YM/fOulb4LMqr/d+Y
         h2mK0uAXa4P+LglwFvAmALzFBYaR1c61ZVS4w18xGGfbSeb8ia4nzQmW6ycemHJk0/hH
         eFzCqha6TMLWYSgWiPBOObHDZFBVBYyKX82PA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=PLzyPUSjfo0Qtpj5gmZd3aXs/ZxVVAJIrjiNg+OPCHg=;
        b=KeR6pmrb5KzahTaZEWkDNRUea260AjuPd1vgnr/HP5PQhx/ns3M53uhd2R05v5Yn0M
         zCrhqdJtUgdUpOs7TxtFdZzS8/vz2Wfm7QFWwc21CUUx0eNcvitWiscgRZ+jqivP+ijr
         vmh0IgrCg+fb7ogZA9qyRD6Yc3Eg10kSa6va+/Ypu5IBhWTxY2ERO5cQLW2JXZNgs60v
         x36sO8aw4a5yTGQfTXnVEYQTfP+WeSARpGjf1H+ywRX0W4DHxgQ/E0jGGSMd3Pmj0nHW
         OawRqmfEtmvSm5dDog81ckGIwdfKiptnr2OygVAOGzZydb0jAVs0VpU6C9cZ9FMR+Tnt
         1CVA==
X-Gm-Message-State: AOAM532XLNbeOpetUAFLmvBDBaB5W4ZFJLka6UmUCw/3v24OuXdUkDZW
        nXeEiZ0Ciq7DxS1SZdlOhCbLvg==
X-Google-Smtp-Source: ABdhPJy4i5EDcsoUlN68saZ/09C4VCIsWJfAbzbGOa4yNvDkoFlpTvlK83YrW3J05AREmJlmyQVRGQ==
X-Received: by 2002:a05:6830:34aa:b0:5b2:613f:5523 with SMTP id c42-20020a05683034aa00b005b2613f5523mr4153857otu.40.1647644211102;
        Fri, 18 Mar 2022 15:56:51 -0700 (PDT)
Received: from fedora64.linuxtx.org (104-189-158-32.lightspeed.rcsntx.sbcglobal.net. [104.189.158.32])
        by smtp.gmail.com with ESMTPSA id 89-20020a9d0be2000000b005ae194ec5absm4316722oth.15.2022.03.18.15.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 15:56:50 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date:   Fri, 18 Mar 2022 17:56:48 -0500
From:   Justin Forbes <jforbes@fedoraproject.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        slade@sladewatkins.com
Subject: Re: [PATCH 5.16 00/28] 5.16.16-rc1 review
Message-ID: <YjUOMF6dvZ83YhSl@fedora64.linuxtx.org>
References: <20220317124526.768423926@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220317124526.768423926@linuxfoundation.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 01:45:51PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.16.16 release.
> There are 28 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 19 Mar 2022 12:45:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.16.16-rc1.gz
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
