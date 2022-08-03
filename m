Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839145894CC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 01:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238213AbiHCX1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 19:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiHCX1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 19:27:31 -0400
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D3A33402;
        Wed,  3 Aug 2022 16:27:31 -0700 (PDT)
Received: by mail-il1-f169.google.com with SMTP id g14so4587143ile.11;
        Wed, 03 Aug 2022 16:27:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=8+lW0Y9sDchs80Qq4T1qb7tTF0HJKWej7kYS8TzYu58=;
        b=T8mBU4/mTZY8Z5Gca73pGQpMkp1Fo3XtNNgZTUaP6//MI/Bkpt8pg44Oetf449Q1Rk
         n4g/JYMfIoEZn2aNp5cD3cT/fSkb4L4fMpAUwHbCsbx8CpGSVVFY2voUFabqTjbH5O3q
         ASe2jbL0E+9uYdoT+1ESJyLpwsK9+r0PFKc85Uqu778j6ilpXTFEmtpLnENx144dL7cn
         8mOHyqQ6J5XAl1+gQGa9Uu84yvpwRjc8BN1SGWX/mHayiCI9gPSx93qom6O4FqXRiNlS
         g4KSYyc3T81S6Iapypgo5IwO3cCmzOUJJr0Njjv0ufjn69nnqQgsW3GvqsUsrAryUnNf
         6YKg==
X-Gm-Message-State: ACgBeo3q7rrVccKpaNZxD2dfIiG1a/GAxP3kKbUAxsGuXt+DH72zVU7u
        /WAsbBuDv2rCuLiUvIs8WEobv6o02w==
X-Google-Smtp-Source: AA6agR4bXBAZCfXW1r/LVpF8cB9be1xlAxDX9s0E7aARWO/rzdLNYCLPOX6JoM0tH/h4aemZjwiYyw==
X-Received: by 2002:a05:6e02:b4c:b0:2de:de3e:6c5a with SMTP id f12-20020a056e020b4c00b002dede3e6c5amr5212701ilu.6.1659569250712;
        Wed, 03 Aug 2022 16:27:30 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id t26-20020a02ccba000000b0034276516a5asm4245948jap.9.2022.08.03.16.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 16:27:29 -0700 (PDT)
Received: (nullmailer pid 2810185 invoked by uid 1000);
        Wed, 03 Aug 2022 23:27:27 -0000
Date:   Wed, 3 Aug 2022 17:27:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     linux-usb@vger.kernel.org, Andy Gross <agross@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>,
        Felipe Balbi <balbi@kernel.org>, quic_ppratap@quicinc.com,
        Rob Herring <robh+dt@kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        devicetree@vger.kernel.org, quic_vpulyala@quicinc.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-kernel@vger.kernel.org,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH 6/8] dt-bindings: usb: qcom,dwc3: add wakeup-source
 property
Message-ID: <20220803232727.GA2810152-robh@kernel.org>
References: <20220802151404.1797-1-johan+linaro@kernel.org>
 <20220802151404.1797-7-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802151404.1797-7-johan+linaro@kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 Aug 2022 17:14:02 +0200, Johan Hovold wrote:
> Add a wakeup-source property to the binding to describe whether the
> wakeup interrupts can wake the system from suspend.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  Documentation/devicetree/bindings/usb/qcom,dwc3.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
