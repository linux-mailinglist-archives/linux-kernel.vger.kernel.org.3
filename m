Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46EBE596EE2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 15:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239463AbiHQM5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 08:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236727AbiHQM5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 08:57:14 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9274BD0F
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 05:57:13 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id c185so15260774oia.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 05:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=kYVMcc70nCFaHFOhzZqmhFFWh6V1ggsN7VZR4hDDDj8=;
        b=ZuGKm62ZEMuX/I+GI5JIejpRdQvxnRqDlEhzcTdwfo4Pi98S9j2gO08DSKFqj2Yz83
         yGSshjBBMHD2Au58bOv85JIUOli+x+ooP2wLNfAM/OZFfbza8kNnjYxkvPbuSkSMMFIt
         6EnAOMI84eHV6skjZBR/P6k204A7bnrTrfbA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=kYVMcc70nCFaHFOhzZqmhFFWh6V1ggsN7VZR4hDDDj8=;
        b=gRXwtdo4Qt/2VLmOM0taoNN9kcifEjwkIhA1Vny6O8iU2YgsFA2b8rnt9jKXx863uK
         /uKUPIWpfMJablWim0QNzKr3McUmF7031d5YT2loI0G136IoH2mmloWyunQxi9TPYO1x
         IKlUrulm8lDsGHeA3ZGYGi7DwKepq427KiGPC+MEFXD8Yjh8qS0FmGT1yxrKqaagPc7U
         lCPlW+sJutnOto+cN3xO+ggnfiIc//1wLUY/1J8oLd0fnHLaXkMF7P6++lfDR36mfUWn
         WDDgtXuWa8CxH93zR6Y6L+8cG+7SxUtCKmGdWFkGtIW0pG1hc0obeyI+qvIrs08i/5Hn
         kXWw==
X-Gm-Message-State: ACgBeo0kO5U0H268IV7CZKx/CBd9xTh654PNHKWHGCf9F3c3Hg6v/KCt
        Yz3Yxb227Cz8H4Tr0eW8QCiE7g==
X-Google-Smtp-Source: AA6agR4rAgEDOG/KauWkVFYjNGuS6fuYUzstIMmZICv2eMW37+NrJJEbxBGmlr2+MKDG/qFt+wW/zw==
X-Received: by 2002:a05:6808:1706:b0:335:1715:f33e with SMTP id bc6-20020a056808170600b003351715f33emr1370823oib.174.1660741032698;
        Wed, 17 Aug 2022 05:57:12 -0700 (PDT)
Received: from fedora64.linuxtx.org (99-47-93-78.lightspeed.rcsntx.sbcglobal.net. [99.47.93.78])
        by smtp.gmail.com with ESMTPSA id f38-20020a9d2c29000000b0063736db0ae9sm3325163otb.15.2022.08.17.05.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 05:57:12 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date:   Wed, 17 Aug 2022 07:57:10 -0500
From:   Justin Forbes <jforbes@fedoraproject.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        slade@sladewatkins.com
Subject: Re: [PATCH 5.18 0000/1094] 5.18.18-rc2 review
Message-ID: <YvzlphC02BmJZ74F@fedora64.linuxtx.org>
References: <20220816124604.978842485@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816124604.978842485@linuxfoundation.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 02:59:27PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.18.18 release.
> There are 1094 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 18 Aug 2022 12:43:14 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.18.18-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.18.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc2 against the Fedora build system (aarch64, armv7, ppc64le,
s390x, x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>
