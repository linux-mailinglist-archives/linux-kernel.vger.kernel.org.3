Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B784F56D47E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 08:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiGKGHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 02:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiGKGHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 02:07:05 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620C213EA6
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 23:07:04 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id o5-20020a17090a3d4500b001ef76490983so4001834pjf.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 23:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XpzsPidAPfjCOoLLidMBXIMpImKGY8yfEDKssc9VWVY=;
        b=VzmGKkQZlrxKSxJz9/mG0qS8kVYg047CltSY/fdE594YI4Hc79D+GBi4UI14LLs2+a
         P3PJ31ZLRXYFBtm4r7WPqPVC40Q7j7yFlb2mqdQzs38V9yQtpjb8cQCEjeEpcQj65YNw
         0ke/+HvnHr+yaOJvrxoRNWfkirxoEGrWIbAcBGrM12/XHoUZ2DEpcRV+88m9mT2cCSqt
         FfyTESXioihsbu3wF6fItt/WLKZr3SgquHL8X2k0ukQLugurvXcmctwpmyoMYNUAOxfv
         6QsYKMrnuXMb5gZoa6/RkM8ETPJpE1FWPYPd8qfC5K7GU+Y2UCFaeEF7bJJvZ6MBauUU
         sEBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XpzsPidAPfjCOoLLidMBXIMpImKGY8yfEDKssc9VWVY=;
        b=sGfdbyuLVsYLEA3xy95C4Z1z7xy+bPJUG/blHn47pVY97d4CeaKyo0RE113+XRezSL
         KolSpV8zPnhZazJSIqtz550GwBdlEumsvzwNzNqFHRJw0NLMo3bSai82DsL/TNpDEcF6
         dd/ciS+J5px1vvdWmaSDM/xrwGsyuNg/O2U3Fmup/CrWzCcpVdYIvNbkkDSFALMP5ait
         W7SR4M8YgbUlLk6krWgb5GAf7UBrPzD1BnjxBzo0YuQStbIxVEAhXVkKd/laVgF5iOI6
         518kFdNWJVWpSZ1hVqkSK7j8eYs0CNsAx4d7WGU0s4hEMQPt1EZRXjKEyiLVYWk8NzEl
         SAkA==
X-Gm-Message-State: AJIora/BZg3qnD0+YHCbf+zzLk5S2EKeuS/ess2isV6dGxtUnzxp16mo
        t+eSXT3Q6bqRdkWZAC2U8jFhrtZD9hMA+fPdRxwTVUtQTAM=
X-Google-Smtp-Source: AGRyM1sPMrfsvE+twajHmWeIWpS5RkrGh3B/z7EZ87iUrCOqgDQJlfYKyYC17mpDJ/sDE3P3CWB8jnWtVHZaArtxtb4=
X-Received: by 2002:a17:90a:4b89:b0:1ee:e6b0:ee80 with SMTP id
 i9-20020a17090a4b8900b001eee6b0ee80mr15712917pjh.16.1657519623895; Sun, 10
 Jul 2022 23:07:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220621161648.20117-1-jiangjian@cdjrlc.com>
In-Reply-To: <20220621161648.20117-1-jiangjian@cdjrlc.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Mon, 11 Jul 2022 08:06:53 +0200
Message-ID: <CAHUa44GLAJttfW+6m5O8ds=FRXAmOEWK5=rqe8+QOoLMskC=5g@mail.gmail.com>
Subject: Re: [PATCH] optee: Remove duplicate 'of' in two places.
To:     Jiang Jian <jiangjian@cdjrlc.com>
Cc:     sumit.garg@linaro.org, op-tee@lists.trustedfirmware.org,
        linux-kernel@vger.kernel.org
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

On Tue, Jun 21, 2022 at 6:18 PM Jiang Jian <jiangjian@cdjrlc.com> wrote:
>
> file: ./drivers/tee/optee/optee_smc.h
> line: 192
>  * a2   Size of of SHM
> chanegd to
>  * a2   Size of SHM
>
> Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
> ---
>  drivers/tee/optee/optee_smc.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I'm picking up this.

Thanks,
Jens

>
> diff --git a/drivers/tee/optee/optee_smc.h b/drivers/tee/optee/optee_smc.h
> index c60896cf71cb..73b5e7760d10 100644
> --- a/drivers/tee/optee/optee_smc.h
> +++ b/drivers/tee/optee/optee_smc.h
> @@ -189,7 +189,7 @@ struct optee_smc_call_get_os_revision_result {
>   * Have config return register usage:
>   * a0  OPTEE_SMC_RETURN_OK
>   * a1  Physical address of start of SHM
> - * a2  Size of of SHM
> + * a2  Size of SHM
>   * a3  Cache settings of memory, as defined by the
>   *     OPTEE_SMC_SHM_* values above
>   * a4-7        Preserved
> --
> 2.17.1
>
