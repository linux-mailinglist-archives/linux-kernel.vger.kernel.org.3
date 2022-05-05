Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5022B51C9C9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 21:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385509AbiEEUCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 16:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383706AbiEEUCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 16:02:16 -0400
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602CA5EBC9;
        Thu,  5 May 2022 12:58:34 -0700 (PDT)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-edeb6c3642so5287860fac.3;
        Thu, 05 May 2022 12:58:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oBgLJC6txoRH8efJ9A0HaDL743e4v3tUFLl4QcZh6fg=;
        b=tAz7gDIjj+liRx5as2qPfeS0ehNPLBlxvWbmO4xTma9zHvyZCJtPqO88HTkMwKgFKo
         i+tq7c/kk7hMrkjLqNoxO3PkMXKxIjiEAxF0MwA+AoXj/SYn/DbYarEoBP7EZB2qHsFL
         HCN0rV5GkvoDCD4KqJHiQ7upl8ufyHyNB+sFXLu/gncUaI/Sit7PmzqRRKl7eaLNgxby
         DFhvN0YLI+Lmp6uCfwpRh0nHH7d1HCYO13+KlIh35cUp6AQznPY7S7C3BBeivSwyLfTt
         LyM3naimg4GjnXb4nm0IR7I3IFQprvwro4eoa0nQjNhSThAlAewGqbgIxNfKXRxLvUfa
         nndg==
X-Gm-Message-State: AOAM531AejdrBDn7OcuIJqZKOAt9XC886Xym+0pJgL7R7GDxBUilCkq0
        8E+pJrTsIVKjsh5myQ2bjQ==
X-Google-Smtp-Source: ABdhPJwZrM0/FzDKiZrLq5mUOfVxF6AlSDCH+r6ocP91vWdO8W/w2KPkEt1c9NBOuD2DZTojloU5sw==
X-Received: by 2002:a05:6870:b62a:b0:dd:f3b0:96da with SMTP id cm42-20020a056870b62a00b000ddf3b096damr3027837oab.258.1651780713715;
        Thu, 05 May 2022 12:58:33 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q130-20020acad988000000b00324f24e623fsm993653oig.3.2022.05.05.12.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 12:58:33 -0700 (PDT)
Received: (nullmailer pid 94673 invoked by uid 1000);
        Thu, 05 May 2022 19:58:32 -0000
Date:   Thu, 5 May 2022 14:58:32 -0500
From:   Rob Herring <robh@kernel.org>
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     Martin Botka <martin.botka@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pavel Machek <pavel@ucw.cz>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-leds@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH 1/4] dt-bindings: leds: qcom-lpg: Add compatible for
 PM660L LPG block
Message-ID: <YnQsaMOM1ei6SB31@robh.at.kernel.org>
References: <20220504205704.699500-1-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504205704.699500-1-marijn.suijten@somainline.org>
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

On Wed, 04 May 2022 22:57:01 +0200, Marijn Suijten wrote:
> Document the availability of an LPG configuration for the PM660L PMIC in
> the Qualcomm Light Pulse Generator driver.
> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>  Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
