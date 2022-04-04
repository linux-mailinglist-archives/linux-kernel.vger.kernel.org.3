Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0F434F0FBF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 09:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377588AbiDDHHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 03:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377585AbiDDHHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 03:07:44 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F83335AB4
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 00:05:48 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id k14so7650750pga.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 00:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9RGv/LS+O2kSbyuxARrBEe2LVUddokYjQQ+aO586TDo=;
        b=QYIsZEs0UGdLrC0ERwEndhrqseOZ352Yv5Lld/YINfgm+IR1Wagq9ChtL85zJcY0be
         HL/llDeOtvM36bW4wU7hZE1qRIjnyTyRqqQj3DpFUY0u2KZav+PvH/6lx3vs3MC2p6T/
         +RiZrQTbaeH9sG3LfWtFn5AgpG2dDiiv7MAxpf6IIPKMdLp+XJSdQ3RWx/u8+7kIhIi1
         /jFglwi6Rg5vhkdnSCEQQiIWTUcSZj2X9DF7ADNMyCkPNzNZzZEQpEC/07t4xyq+xPJw
         p3uaYKKZY6XqQ14vUEgYh0Z1Xnvg+shEfK8gVca8wqe3I3cNt9s5Zk5IVZEN1DdvLyMC
         iFHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9RGv/LS+O2kSbyuxARrBEe2LVUddokYjQQ+aO586TDo=;
        b=2X5jur38rB4VCcKRJTP7NwWJ83NdLeBL7XhKIo9DHcVbpw2Qz6TdL0AO3Ux4zynIzk
         Xi+ypzm54hfGFoF/IQXnNnYDVs4DLkIQ36IfFKKG+Vb4eCIllU+3u581BJvc37te/1pe
         Ki7MOfZMikDvuncW2k/MtwokHZNUIOt1bX0hSNm9sZWU2bOcocrYRbxjQDK/z+p+sXca
         UgIveNeX3tENEKSqtWHTk7gT1ddgCdrBRqcDV1z+noDo3Nf86anq9DS/abbhut1wKF3T
         6g7+M0vTicxocLZMlVjGO/4ae8R7tNUK6kFUu00crQ4U6w5QqqUJw81JUKvWc6p6KWt6
         IU0Q==
X-Gm-Message-State: AOAM530uu8JXiPveEyigaPqUhr9fykchEylN2jYd21028eZJhAZw943g
        Sk8hALNDq+jvyWYrCM39BOOXzaH2GfsIglFVSqECmg==
X-Google-Smtp-Source: ABdhPJyr4EJ2GdaFWB3CtMS0IRaG/2gAwTeGZSFZmtrO3ONGcy5UJ5F/eR3/A5L+mlokCqLTIzlFUAiUQIlnWsqQYpw=
X-Received: by 2002:a63:5747:0:b0:381:54b9:b083 with SMTP id
 h7-20020a635747000000b0038154b9b083mr24407473pgm.178.1649055947667; Mon, 04
 Apr 2022 00:05:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220404064149.59634-1-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20220404064149.59634-1-manivannan.sadhasivam@linaro.org>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Mon, 4 Apr 2022 09:05:11 +0200
Message-ID: <CAMZdPi9LppZCpf3zvbSXEtmwSEip4VqBN3Z+JLLqbLrz1HtHiA@mail.gmail.com>
Subject: Re: [PATCH] bus: mhi: host: pci_generic: Add missing poweroff() PM callback
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     mhi@lists.linux.dev, quic_hemantk@quicinc.com,
        quic_bbhatt@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Apr 2022 at 08:41, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> During hibernation process, once thaw() stage completes, the MHI endpoint
> devices will be in M0 state post recovery. After that, the devices will be
> powered down so that the system can enter the target sleep state. During
> this stage, the PCI core will put the devices in D3hot. But this transition
> is allowed by the MHI spec. The devices can only enter D3hot when it is in
> M3 state.
>
> So for fixing this issue, let's add the poweroff() callback that will get
> executed before putting the system in target sleep state during
> hibernation. This callback will put the device in M3 state and that would
> allow it to receive the D3hot afterwards.
>
> Cc: stable@vger.kernel.org
> Fixes: 5f0c2ee1fe8d ("bus: mhi: pci-generic: Fix hibernation")
> Reported-by: Hemant Kumar <quic_hemantk@quicinc.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Reviewed-by: Loic Poulain <loic.poulain@linaro.org>


> ---
>  drivers/bus/mhi/host/pci_generic.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
> index 9527b7d63840..b1c0a8887496 100644
> --- a/drivers/bus/mhi/host/pci_generic.c
> +++ b/drivers/bus/mhi/host/pci_generic.c
> @@ -1085,6 +1085,7 @@ static const struct dev_pm_ops mhi_pci_pm_ops = {
>         .resume = mhi_pci_resume,
>         .freeze = mhi_pci_freeze,
>         .thaw = mhi_pci_restore,
> +       .poweroff = mhi_pci_suspend,
>         .restore = mhi_pci_restore,
>  #endif
>  };
> --
> 2.25.1
>
