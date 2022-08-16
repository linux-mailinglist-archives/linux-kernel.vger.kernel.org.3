Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC9A75957A4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 12:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232790AbiHPKJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 06:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233918AbiHPKJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 06:09:23 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD19BFC71
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 01:41:58 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id kb8so17662888ejc.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 01:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=m7Ylrhpsm6OVfghN5qH4zCT0WFeKmrFF6mCDrHN6og0=;
        b=z75K1phbqPlNfL1Bdg7U4n5nvKu7v9Jn1AXWrXin10tH6qqLH5SNIXPBfRkvhCmCqR
         gWzNMB4cKuoGCJf5M02GSGsLsO2Mo76s7R/DaStA4YfuqiC8kd4maI5J3UPk/N1R6csp
         WbnecpfSKfO1CSkDfPejCzlSIFsf4pQBsdf0Lw/eEHku2pk6QsntrFaPuqp8RokxErVp
         TwC6PFV85a/gW/JImsk9hAODQ+9CYlqMZapgRLmvMCTBU3EV0VYsfjakmlWpQCed/SJf
         KSHDt2kuFiUPnx6uT4WkiHx8OXmoitZt9UVgpWR8cCmRTCAk9Yz9TUuFWU+7fv1dnU5a
         3jrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=m7Ylrhpsm6OVfghN5qH4zCT0WFeKmrFF6mCDrHN6og0=;
        b=5lKpuja2QCxEYjAzjh1YWCGriqj2qa7nSEct/Ybvi9xWNVk7szJb/Gaq5ZemJYby5r
         BdQztOPfjDVvlI+evg1m+GFBBRcd6781i3YefzKe//mfizlDdEeTzjXlwDtJoA2w2VPa
         8XABAvcdG40lMrhLuMYiyBNV9lk2NRTESGwpZepoAWrG2aKjI06pnieW9eCQnj4GrNnD
         aPIMtEja3wLfZvHT4WzZFuDpYsCJ8t7wHUEPmpnc+eakGO4T/Zu7OJEE+E6mq60kxRfU
         VvpfC4aXx4jt6/8s+TBcNEHpCYQJ/6uiW71KnJ+FLuYlfxn1tH+UdokEOuS1nemU4d13
         oCxQ==
X-Gm-Message-State: ACgBeo2+pBt4G7+PiSB6Rc2sR42DlLTiX02SnQ5o1c4wLOGUWRYIbAxW
        JY7bwMIYtDtFszMWZXZl6V++NfZDIzBWgGsTXn55Vg==
X-Google-Smtp-Source: AA6agR5WJcbhdI+a8fZ4r4PXRD9/RB3FMkf3bBU2V6bl986OSujcFf8WPx4pl8Erh1Ikff3d5PXSq+8N15Zu34T5E4o=
X-Received: by 2002:a17:907:2cd1:b0:730:a980:d593 with SMTP id
 hg17-20020a1709072cd100b00730a980d593mr12859182ejc.48.1660639316945; Tue, 16
 Aug 2022 01:41:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220815180337.130757997@linuxfoundation.org>
In-Reply-To: <20220815180337.130757997@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 16 Aug 2022 14:11:45 +0530
Message-ID: <CA+G9fYuXHvYQkWnDac6T8s9XnP_jctCbV=yEx3Z9EhWko2dPPg@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/779] 5.15.61-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        slade@sladewatkins.com,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Aug 2022 at 23:44, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.61 release.
> There are 779 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 17 Aug 2022 18:01:29 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.61-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The powerpc defconfig failed on stable-rc 5.15.

* powerpc, build
  - gcc-10-ppc6xx_defconfig
  - gcc-11-ppc6xx_defconfig
  - gcc-8-ppc6xx_defconfig
  - gcc-9-ppc6xx_defconfig

arch/powerpc/sysdev/fsl_pci.c: In function 'fsl_add_bridge':
arch/powerpc/sysdev/fsl_pci.c:601:39: error:
'PCI_CLASS_BRIDGE_PCI_NORMAL' undeclared (first use in this function);
did you mean 'PCI_CLASS_BRIDGE_PCI'?
  601 |                         class_code |= PCI_CLASS_BRIDGE_PCI_NORMAL << 8;
      |                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~
      |                                       PCI_CLASS_BRIDGE_PCI
arch/powerpc/sysdev/fsl_pci.c:601:39: note: each undeclared identifier
is reported only once for each function it appears in
make[3]: *** [scripts/Makefile.build:289: arch/powerpc/sysdev/fsl_pci.o] Error 1

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Steps to reproduce:
--------------------
# To install tuxmake on your system globally:
# sudo pip3 install -U tuxmake
#
# See https://docs.tuxmake.org/ for complete documentation.
# Original tuxmake command with fragments listed below.

tuxmake --runtime podman --target-arch powerpc --toolchain gcc-11
--kconfig ppc6xx_defconfig


--
Linaro LKFT
https://lkft.linaro.org
