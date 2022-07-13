Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784035736C4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 15:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235540AbiGMNBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 09:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235148AbiGMNBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 09:01:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5F4EFE53
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 06:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657717267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c5tTaTQWdtIl7l1GJF3+E3vkHxBuOg16Ki+fSt3hNw8=;
        b=bcmcmnPF0rK2cH2cokmatFLEn7go4LfHZfmhlUe+c/cYrTCsqBlAt4k4cYSv8crlaEYEu1
        scnDmunvWGlD2+fVQWKUVA578bpzx6DNgAltd674irs683GYVgSGqxapTbMRBRmz+hvYFd
        AgmLZEeCAiNDaLLsg0WZgrUSQSdTT20=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-526-oWvjLATDPBW9S-f3McZg-A-1; Wed, 13 Jul 2022 09:01:05 -0400
X-MC-Unique: oWvjLATDPBW9S-f3McZg-A-1
Received: by mail-ed1-f71.google.com with SMTP id x21-20020a05640226d500b0043abb7ac086so8308752edd.14
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 06:01:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c5tTaTQWdtIl7l1GJF3+E3vkHxBuOg16Ki+fSt3hNw8=;
        b=h0yvdmM4FDYS1RP7oRm7c8awLFxiDA5PH6szROrSPAa3igqTHhiTfrEoFwPik/4TPH
         rdMc7DUpe8KhIzRowFDXKLH9aYi+o1L3EaTmqUxQDmryC6pYsoSNok6+C6ehB1bDUbDq
         7LRX4m2czdUMnbltY7sUY02QUcH9ksTY+skIOjLz9cGU82c/QWpu+Hvxbv5rreK1CdRM
         P42sKcpAAq0f1cXyuT3E3s+559R+2ix09WMwAptmxcnttt9XDttdVM3+oijKH/wqVZyo
         m2CStXJ7TnzJdlCLf7kJGJcp6cVpWdC+ntFO/he10uzZMxQ6tM1MWc5LVfy3uEyZoHyZ
         AwZA==
X-Gm-Message-State: AJIora9dUCplodEt7n40wvUMDrxS2Tl4QUi2RLyZoyTs0I2UlFK4GbUv
        EJt2QZyijXPeSrICOZK0pUTq0bVgM37HBdjz3D4Fm5GuK8fEi6FURTT+Orqa012LXpHDrJ8qCaf
        fisHL0RYQ1FSHUZRyU19/NNAIIxsZFOw+mYR6c21y
X-Received: by 2002:a17:907:168f:b0:72b:5571:2228 with SMTP id hc15-20020a170907168f00b0072b55712228mr3497009ejc.397.1657717264496;
        Wed, 13 Jul 2022 06:01:04 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sM/Q/qXIJtvyge1RBA27I1zfyOERWxp2hTuT6He8VnUbVBaCHWeBofNJRY+F3CAMZEc4y1/wzNTDwJ7jxzCyM=
X-Received: by 2002:a17:907:168f:b0:72b:5571:2228 with SMTP id
 hc15-20020a170907168f00b0072b55712228mr3496979ejc.397.1657717264233; Wed, 13
 Jul 2022 06:01:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220713085627.175604-1-bagasdotme@gmail.com> <20220713085627.175604-2-bagasdotme@gmail.com>
In-Reply-To: <20220713085627.175604-2-bagasdotme@gmail.com>
From:   Vlad Dronov <vdronov@redhat.com>
Date:   Wed, 13 Jul 2022 15:00:53 +0200
Message-ID: <CAMusb+S+JPJOzHYfuK+YvZydNxoQ9nvE_jGoudTPJiD2HfsTNw@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 1/2] Documentation: qat: Use code block for qat
 sysfs example
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-next@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Wojciech Ziemba <wojciech.ziemba@intel.com>,
        Adam Guerin <adam.guerin@intel.com>,
        Fiona Trahe <fiona.trahe@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Tomasz Kowallik <tomaszx.kowalik@intel.com>,
        linux-crypto@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jul 13, 2022 at 10:57 AM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> kernel test robot and Stephen Rothwell reported htmldocs warning:
>
> Documentation/ABI/testing/sysfs-driver-qat:24: WARNING: Unexpected indentation.
>
> The warning isn't caused by Date: field pointed by the warning, but rather
> by sysfs example that isn't in literal code block.
>
> Add the code block marker.
>
> Link: https://lore.kernel.org/linux-next/20220711204932.333379b4@canb.auug.org.au/
> Link: https://lore.kernel.org/linux-doc/202207090803.TEGI95qw-lkp@intel.com/
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Fixes: d4cfb144f60551 ("crypto: qat - expose device config through sysfs for 4xxx")
> Acked-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> Cc: Wojciech Ziemba <wojciech.ziemba@intel.com>
> Cc: Adam Guerin <adam.guerin@intel.com>
> Cc: Fiona Trahe <fiona.trahe@intel.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: Vladis Dronov <vdronov@redhat.com>
> Cc: Tomasz Kowallik <tomaszx.kowalik@intel.com>
> Cc: linux-crypto@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Documentation/ABI/testing/sysfs-driver-qat | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-driver-qat b/Documentation/ABI/testing/sysfs-driver-qat
> index a600531e95628f..43e081ec22cc4a 100644
> --- a/Documentation/ABI/testing/sysfs-driver-qat
> +++ b/Documentation/ABI/testing/sysfs-driver-qat
> @@ -46,7 +46,8 @@ Description:  Reports the current configuration of the QAT device and allows
>
>                 The following example shows how to change the configuration of
>                 a device configured for running crypto services in order to
> -               run data compression:
> +               run data compression::
> +
>                         # cat /sys/bus/pci/devices/<BDF>/qat/state
>                         up
>                         # cat /sys/bus/pci/devices/<BDF>/qat/cfg_services
> --

Acked-by: Vladis Dronov <vdronov@redhat.com>

Best regards,
Vladis Dronov | Red Hat, Inc. | The Core Kernel | Senior Software Engineer

