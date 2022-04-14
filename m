Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76070501BE6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 21:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345401AbiDNT07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 15:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236098AbiDNT04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 15:26:56 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA31465F6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 12:24:29 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id q20so3784952wmq.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 12:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TzIdGf0orlPzlsnGm4d1/wOp9Ug675hNbMOMT58Ay5o=;
        b=anV+lLXHdPoCvNvo4uqR9yVnraezCiI/gR7f3+/73+6+e/d+CvXkykdbFlf45Cak9p
         yT/StOCyPW9e06boapRmdlJRlJoo9WnJYC5nAZfit00iz+WieHSZA23/C1Ws48LVJH7I
         o3k9PJAs5zpKNhfC1/M859nQEVYjTW6pQhAYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TzIdGf0orlPzlsnGm4d1/wOp9Ug675hNbMOMT58Ay5o=;
        b=neM4yDiHCI2FE3PyEiey+hyS2vZ/dt7J5FH75ofP4cs8KClyJYNerFUvgtnMfXMmsM
         b8Dw2ovaN4sUqY/MYwf1aCwo/hjwF0W6ePMJPkznDGpeTiVAw93VPkjpsR7qMjse/5sc
         +YeM+NSs7HF1JuFPW8LdaGZXIO4FxYMXJL8lqiQjOJ+J0bIjfHXmH4QZ+lPCpkbTRSMH
         nrOj6y13+GDdd2/VF7BSy/QiQM6PpXWhDzXv4VoFQoNMlOgIyYZ/0+fclA+skQr3BzrX
         45coK4/3X4SaV4XpZoDtuJQ1TxCPIK6BOxhjEbx2iX8CfFy5Rubjs37JT2fQBESf0EJQ
         7gRw==
X-Gm-Message-State: AOAM532mJTmqX1hrx7lvbljMbF5hkV/Mbr/RzYuLuaDE2dGhoJY2DjRe
        PVQauaYnJ0V+SRhddotEuSITxQ==
X-Google-Smtp-Source: ABdhPJxgazeepxjQX/HIuYCUv+KWXKHE1HKC70Rms9bSy5mDaYHGosh9IMV8XRSLBN/aN4BdLq7q8w==
X-Received: by 2002:a05:600c:1e85:b0:38c:ef05:ba5d with SMTP id be5-20020a05600c1e8500b0038cef05ba5dmr74515wmb.119.1649964268274;
        Thu, 14 Apr 2022 12:24:28 -0700 (PDT)
Received: from google.com ([37.228.205.1])
        by smtp.gmail.com with ESMTPSA id v13-20020adfe28d000000b0020375f27a5asm2608680wri.4.2022.04.14.12.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 12:24:27 -0700 (PDT)
Date:   Thu, 14 Apr 2022 19:24:25 +0000
From:   Fabio Baltieri <fabiobaltieri@chromium.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Guenter Roeck <groeck@chromium.org>, linux-pwm@vger.kernel.org,
        chrome-platform@lists.linux.dev
Subject: Re: [PATCH v4 3/4] dt-bindings: update google,cros-ec-pwm
 documentation
Message-ID: <Ylh06cG7bII6rG77@google.com>
References: <20220414092831.3717684-1-fabiobaltieri@chromium.org>
 <20220414092831.3717684-4-fabiobaltieri@chromium.org>
 <1649938809.993469.1698375.nullmailer@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1649938809.993469.1698375.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 07:20:09AM -0500, Rob Herring wrote:
> On Thu, 14 Apr 2022 09:28:30 +0000, Fabio Baltieri wrote:
> > Update google,cros-ec-pwm node documentation to mention the
> > google,cros-ec-pwm-type compatible.
> > 
> > Signed-off-by: Fabio Baltieri <fabiobaltieri@chromium.org>
> > ---
> >  .../devicetree/bindings/pwm/google,cros-ec-pwm.yaml      | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> ./Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml:27:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
> ./Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml:30:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
> 
> dtschema/dtc warnings/errors:
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/patch/
> 
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:

Missed out on that, will fix and resend.

Thanks!

> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit.
> 

-- 
Fabio Baltieri
