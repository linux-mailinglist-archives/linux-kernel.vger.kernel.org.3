Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4393158EAC0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 12:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbiHJKz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 06:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiHJKzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 06:55:53 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15DFD1C133
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 03:55:52 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id v5so7620394wmj.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 03:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=uLzHaOsqO+V47sNsu3NQ7eOVEKNreR7vrk1orA6ZleY=;
        b=fozMa+ze0kLO/rq0XhZh+UySZWY2WbbHTkW3ovbLOxDDjwkI/o2txXCccacp1NYYGd
         4zJjgRFOP94WG41v25ReDutUY1Pi/PTALr9UB/9rzNXkwMLCnagNw6rjik720Wyx/iSz
         C9cfZDxdPD1r2Kr00F+MoIBXkSWf17JWx44nbVpAkuNKqMRulWhMtdalwRF5ZO976jgW
         eHar4gwM5PODKbjx8AFgv0QEnbwffpiLPH92ugpONZlI52h8OngB0ACZwrJaQ9/v30gC
         AryZpXS7ecVDBHMfcOcFPRx2jQ+cyAYrYlGoI5yIOfOmeCfRwrUinb9tMQPRYwXEQLSr
         GvWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=uLzHaOsqO+V47sNsu3NQ7eOVEKNreR7vrk1orA6ZleY=;
        b=YKrOWsJQAjxrK3vGfIABGZVG/bjsig4weXxh2poP+A60GfawsEmFHLbtFaG8sC6/DT
         N51u4kEiII8lF0eLizqKbc/Cz+J+kV13prdHrnoAqxaVt+qzgjZQxFreQeTQfFNRN+kb
         IVR1hAWZVEJdQwNRi+S85AG+zLI1b3E+CCDOZ33PpwKPU6MAzhisjbM/95TgxTTAVzJ1
         gO2kBPaWr5I/qBiQlcLKmCIWn7dPsYfQ3SlC83PuNzSTx8nScU+VDW5VJYzbM4jAKFIR
         A+VfR/DmH3aqs8ruVG/Fm4U3o/0dzrjpQAnFOIk09H6myJa8DDm8dJG+wsPec3aiIcKc
         JPCQ==
X-Gm-Message-State: ACgBeo3zSkgTScv8EILPJmNAR/aQJ4MI9UQKxioiee8xL7P9BCtRb7PJ
        k57KkVFOImT1oS7Tzyfh47TYDg==
X-Google-Smtp-Source: AA6agR42eTIQeJpfVwcTcfO1vOI9DkuwkBCklpdyITuI2iuhyEyXlE1deKN+pkT+XQwsDg0XVmzLog==
X-Received: by 2002:a05:600c:4e51:b0:3a4:e094:2520 with SMTP id e17-20020a05600c4e5100b003a4e0942520mr1996068wmq.123.1660128950692;
        Wed, 10 Aug 2022 03:55:50 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id c16-20020adffb50000000b002205c907474sm15899709wrs.107.2022.08.10.03.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 03:55:50 -0700 (PDT)
Date:   Wed, 10 Aug 2022 11:55:48 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>
Subject: Re: [PATCH] dt-bindings: mfd: x-powers,axp152: Document the AXP228
 variant
Message-ID: <YvOOtGN7c7oBwZis@google.com>
References: <20220810013430.27061-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220810013430.27061-1-samuel@sholland.org>
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 Aug 2022, Samuel Holland wrote:

> AXP228 is a PMIC used on boards such as the Clockwork ClockworkPi and
> DevTerm. Its register map appears to be identical to the AXP221 variant.
> The only known difference is in the default values for regulator on/off
> states and voltages.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
>  Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml | 3 +++
>  1 file changed, 3 insertions(+)

Applied, thanks.

-- 
DEPRECATED: Please use lee@kernel.org
