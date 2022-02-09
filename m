Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51AE04AE719
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 03:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235074AbiBICmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 21:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242935AbiBICNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 21:13:43 -0500
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905C8C06157B;
        Tue,  8 Feb 2022 18:13:42 -0800 (PST)
Received: by mail-oo1-f42.google.com with SMTP id t75-20020a4a3e4e000000b002e9c0821d78so886701oot.4;
        Tue, 08 Feb 2022 18:13:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nIaW4qu/5KIfaweGLotozwrFMLHgcllMEMmVd3jpnnQ=;
        b=TQjkt7HKL8fq40KmZjtKzLipSYoAyh0fyMdH0cgMzTnAteR+gdVgErA6dtKxSjc12V
         FtmtcisltPAQ7ziNY6q8tzEcDQszoGvXBugflyENoDtwalIMf2CX0pEoiOumc/145oT+
         nPCM8MBCTTR9l31BfB/OW6apVtdq2FGzbH5g/t6CfKjVMmp6Z3I0cjjbxiW7PpbfXQg7
         XxsJpXkKTFL60C4hCTanqjdWd5XcYGcYuxDwxXs5XnhUogpaE9UQXWT0d7jNUiu+CE87
         y6YIYnLZhWP9GSPnk5g8JyhVEyrkXHHsT027+hUk529D8ItSYW/X6hV05fbIrPY7FJT3
         uJgw==
X-Gm-Message-State: AOAM531TAdqZPWuJZjI4dn3CsqmPZCDXtVtfUVXUmlrazznvgX37iXfG
        KyeNrVW2SgGDi9VgYPSiSQ==
X-Google-Smtp-Source: ABdhPJwM0FgcPhcdDiEuQVbj6A1+LlYF41lbFX5B1ioSc3CFF3NvbJJOKEqqS/3M6sH9PpfZe1bgZg==
X-Received: by 2002:a05:6871:506:: with SMTP id s6mr69126oal.62.1644372821873;
        Tue, 08 Feb 2022 18:13:41 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bx41sm3324683oib.7.2022.02.08.18.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 18:13:41 -0800 (PST)
Received: (nullmailer pid 3466961 invoked by uid 1000);
        Wed, 09 Feb 2022 02:13:40 -0000
Date:   Tue, 8 Feb 2022 20:13:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        phone-devel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH 07/15] dt-bindings: usb: qcom,dwc3: Add msm8953 compatible
Message-ID: <YgMjVCGpFjJ2hkOO@robh.at.kernel.org>
References: <20220112194118.178026-1-luca@z3ntu.xyz>
 <20220112194118.178026-8-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220112194118.178026-8-luca@z3ntu.xyz>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jan 2022 20:40:56 +0100, Luca Weiss wrote:
> Document the compatible string for the DWC3 controller in msm8953.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> Acked-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
>  Documentation/devicetree/bindings/usb/qcom,dwc3.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
