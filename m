Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC7F4FB366
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 08:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244820AbiDKGDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 02:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244817AbiDKGDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 02:03:03 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65CF33E17
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 23:00:50 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id s10so5440630plg.9
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 23:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TOrz2TYyKKln5WCCmCjdg2Bgm93TEWKafFMisAhjfgo=;
        b=uDKUMuBk+Zr5/6D3mpQDlD7lWnjM89KGeJd7wpYHIbDzTCmMEEbv4gzYPu+mrFUF8R
         /e1fvzqQIFvgaWr7KJng5KPikVRqS07l2vmjsF39/9hj4FPS4yYnyWsHxpHkfgIjGLSq
         MofXjUkmxK6eTU1CXHQ5fZPtlHn75XefVY5TcSwrMUl92BhW7gcJQuW+FxItHDAX8Iz8
         rU42CvawGyfJuWNlfIcVZCKc0masTO59K91oGj0/sqWpHwEtoQa8CIqTLCXLGapsXTaA
         K+cAD46UoErUo6n5PAaZ1EFciGA9RRMdLcHi5BrYLP1baMkKyVNLnPx78ZwUoHc2T4zh
         NxRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TOrz2TYyKKln5WCCmCjdg2Bgm93TEWKafFMisAhjfgo=;
        b=hdIjXljigZ1OpcJfPa4O03bc+dWRF62Aoe+aDHRZC3QqpSC8Gmxz5xZPR9bJxjDnAt
         6ieoyC5h9xVi9gy47uv0gjZBtxYUNqTBFiU2s5cQy+Uhw7MzSGdkGp2c6rlyrNzFNXb3
         6olqFLfbgfdxMA7IBBUImLXeVy8k7WYV6n10+wRbKHz+VuAgsola3DUmhZsXFoAXag1r
         7Y1Sf+bmnwCXlmfOVlrkCOdJLc6e90kbfPysezBVs8UJooZrVWEHQEH7riN0ZaZC/KvI
         l9QQhQztOpjSKVjmteWfv1iWM1bnfDROnx83Celt9xm6VHtt/mBnHUjlekBoUYFE4yMp
         USYw==
X-Gm-Message-State: AOAM53203JVas77SJyeZDceC2kVN3bDOrG3TQD2lAurTnb4GT8ENbsWj
        dVoMjDMUHD/en2ggfPSpqQQi
X-Google-Smtp-Source: ABdhPJymr2uHiw3rePGk47HXX4/TNLZfo6i2NSiXElg+EFB7Li4XBX7woodET5r2u9jQxv/rOEU/tQ==
X-Received: by 2002:a17:90a:8591:b0:1b9:da10:2127 with SMTP id m17-20020a17090a859100b001b9da102127mr34902852pjn.13.1649656850143;
        Sun, 10 Apr 2022 23:00:50 -0700 (PDT)
Received: from thinkpad ([117.217.182.106])
        by smtp.gmail.com with ESMTPSA id f4-20020a056a0022c400b004fb2292cd74sm34245714pfj.206.2022.04.10.23.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 23:00:49 -0700 (PDT)
Date:   Mon, 11 Apr 2022 11:30:46 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mhi@lists.linux.dev
Cc:     quic_hemantk@quicinc.com, quic_bbhatt@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Update Hemant's email id
Message-ID: <20220411060046.GA16845@thinkpad>
References: <20220404064226.59825-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220404064226.59825-1-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2022 at 12:12:26PM +0530, Manivannan Sadhasivam wrote:
> The codeaurora email domain is no longer available for Qualcomm employees.
> Qualcomm employees should now use the new email ids from quicinc domain for
> opensource contributions.
> 
> So let's use the new email id for Hemant.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Applied to mhi-next!

Thanks,
Mani

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fd768d43e048..d714313d5cb0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12793,7 +12793,7 @@ F:	arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
>  
>  MHI BUS
>  M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> -R:	Hemant Kumar <hemantk@codeaurora.org>
> +R:	Hemant Kumar <quic_hemantk@quicinc.com>
>  L:	mhi@lists.linux.dev
>  L:	linux-arm-msm@vger.kernel.org
>  S:	Maintained
> -- 
> 2.25.1
> 
