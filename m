Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D057048DC11
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 17:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbiAMQmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 11:42:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236831AbiAMQmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 11:42:38 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9221BC061574;
        Thu, 13 Jan 2022 08:42:38 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id bp39so7440729qtb.6;
        Thu, 13 Jan 2022 08:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YDBFBN45E0LghCivDsoa7Pk9qU2TzMpXvbqtD8ADANo=;
        b=M9GRXqJh3cFStpViu1P2owizAUgP4j/B5cl2eBO2Nplw5yzftWIB8mpT/RBIYG0iNA
         T4HYYXFJD1AeHE7sB7fnG/ZqJD1LJxPqxJwTiSoFfPI5jdAoDHRu+Xze6CB1pX9czBCn
         hVgC7uF0BmP/lSLSm2ldISI+7VRSfDo1XeczuB3/mbtFxdowxV26sdzyXocJkfSk9FfR
         +TMl4djexIg1rpexsT9ImxF1DF39h/fJtp8FnOGIrKtvGNIRrcugO1IZswe7CYkMwXZ/
         awQm8N6SQLX3Sqd10KkS4TmxjKOhWJrpLHsrW5fWAhvoMFRbDuUDe3mqCWIqf59f9JdA
         Rs7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YDBFBN45E0LghCivDsoa7Pk9qU2TzMpXvbqtD8ADANo=;
        b=h73tppLzuXMXLCHAlzXSoH6HPw8j2XGLGamb56E3ta2WhnVE4Y5HAu2PzgMYD6t9yR
         DsmxjI0ELO9i9eHR0vtzIto4zxcEulDtMheCJ+Ex3TXXUOrnfpqkNojB0nw818XOmJUk
         gl1ClbJ9gfr1U51Mk1vfxDUjkOL71lX9xJkSpfoSuYcRAHXbmLZQuLpRbof6WNbqiLX4
         B4yE0qrADyXMvmflVCdSq8VLVfp1TAhyBXIgHCQOSIKD3o0+9X+sJnIGmOFpM+MzfuBK
         xNJBlmp1SuOwSVuoudZA5D8Dzr+F49/UWCnDoQm9/hK5KlppE8sc2Gd3tfQV4YS2okIZ
         YnZg==
X-Gm-Message-State: AOAM530APMdABT7k5ye8K1e9KfZeUYF8Tc83rhwRlBoR5As+/giGzA7Q
        oKcfg4rVcXwhKx9BG3QmD80=
X-Google-Smtp-Source: ABdhPJwU79U0kwTzVyoc+56owTMIvspy8QysLsgYlzEwi7nv74KQOYMmACjDxFsTtm0WEtX6Ph3KeA==
X-Received: by 2002:a05:622a:652:: with SMTP id a18mr4285127qtb.10.1642092157657;
        Thu, 13 Jan 2022 08:42:37 -0800 (PST)
Received: from errol.ini.cmu.edu (pool-108-39-235-221.pitbpa.fios.verizon.net. [108.39.235.221])
        by smtp.gmail.com with ESMTPSA id h11sm2167272qko.59.2022.01.13.08.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 08:42:37 -0800 (PST)
Date:   Thu, 13 Jan 2022 11:42:34 -0500
From:   "Gabriel L. Somlo" <gsomlo@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     david.abdurachmanov@sifive.com, geert@linux-m68k.org,
        ulf.hansson@linaro.org, linux-kernel@vger.kernel.org,
        mdudek@internships.antmicro.com, shorne@gmail.com,
        paulus@ozlabs.org, joel@jms.id.au, andy.shevchenko@gmail.com,
        kgugala@antmicro.com, florent@enjoy-digital.fr, hdanton@sina.com,
        devicetree@vger.kernel.org, mholenko@antmicro.com,
        linux-mmc@vger.kernel.org, krakoczy@antmicro.com,
        robh+dt@kernel.org, rdunlap@infradead.org
Subject: Re: [PATCH v13 2/3] dt-bindings: mmc: Add bindings for LiteSDCard
Message-ID: <YeBWeqCAWxVXXrLE@errol.ini.cmu.edu>
References: <20220112222747.3135585-1-gsomlo@gmail.com>
 <20220112222747.3135585-3-gsomlo@gmail.com>
 <1642091374.254625.3647188.nullmailer@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1642091374.254625.3647188.nullmailer@robh.at.kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 10:29:34AM -0600, Rob Herring wrote:
> On Wed, 12 Jan 2022 17:27:46 -0500, Gabriel Somlo wrote:
> > LiteSDCard is a small footprint, configurable SDCard core for
> > FPGA based SoCs.
> > 
> > Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
> > Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Reviewed-by: Joel Stanley <joel@jms.id.au>
> > ---
> > 
> > New in v13:
> >   - add `vmmc-supply` requirement
> > 
> >  .../devicetree/bindings/mmc/litex,mmc.yaml    | 77 +++++++++++++++++++
> >  1 file changed, 77 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mmc/litex,mmc.yaml
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/litex,mmc.example.dt.yaml: mmc@12005000: 'vmmc-supply' is a required property

Oh, I forgot to add `vmmc-suply = ...` to the `examples` section --
sorry about that. Version 14 will be out shortly with a fix.

Thanks,
--Gabriel

> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/litex,mmc.yaml
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/patch/1579360
> 
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit.
> 
