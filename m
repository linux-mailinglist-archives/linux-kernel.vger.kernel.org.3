Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C536563B20
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 22:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbiGAUQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 16:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiGAUQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 16:16:45 -0400
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C912BE35;
        Fri,  1 Jul 2022 13:16:44 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id h85so3304026iof.4;
        Fri, 01 Jul 2022 13:16:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iai4M0Qdr1FOx8lEHtRcXeLjjaSNw8WkrWJ5/mveph8=;
        b=KJ0uNdjI9/59sbfTFaMUEQeObAYKgQFM0MISPVgl9BbncAmFxNVVY5QYARgo6zVO42
         Q6DTtAYn8mLMxvMHYh+MVte7f9+mj5yxq4QTVUb1ehngbgPGCtI2fjE0xMPW/7eHRSVu
         WWPmt0touFazQG6dZgCAwKAHA4oN7f6GpQjOa1ALrvgWjbuM3O1wsThQGnWMxaSINM2s
         zgSrmkZXWELe9KBCk/3wfWCuK9aSJn/xh7IhqhnIvxuwUseOEPNcsIctD+Ym3OD2t3xx
         ONyJii8dVuE0OyYpoBEztUxKBCoH1E1Qc5UfO/lmpFN+7aVghF3aZG8qd44NBiE8u0fN
         zfIw==
X-Gm-Message-State: AJIora8HWfR650rZJ9QH8S7KLrTdYNovmEHzxgQ1E8cgGhHpAyUDooFf
        d1zOuR4mXTNX6+PIDas4Iw==
X-Google-Smtp-Source: AGRyM1uaZN/DnLFYf6p+gTHuGH7e0vRFkxMe8V6s93gu4NO90M6hf4FCyXXOCiD+WjgHsmQ5PQkUzg==
X-Received: by 2002:a05:6638:3385:b0:339:ea59:a31f with SMTP id h5-20020a056638338500b00339ea59a31fmr9322712jav.55.1656706603440;
        Fri, 01 Jul 2022 13:16:43 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id s10-20020a5ec64a000000b0067520155dedsm8721425ioo.15.2022.07.01.13.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 13:16:42 -0700 (PDT)
Received: (nullmailer pid 1448435 invoked by uid 1000);
        Fri, 01 Jul 2022 20:16:40 -0000
Date:   Fri, 1 Jul 2022 14:16:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Roger Quadros <rogerq@kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-usb@vger.kernel.org,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Peter Chen <peter.chen@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH v24 2/4] dt-bindings: usb: rts5411: Rename property
 'companion-hub' to 'peer-hub'
Message-ID: <20220701201640.GA1448375-robh@kernel.org>
References: <20220630193530.2608178-1-mka@chromium.org>
 <20220630123445.v24.2.Ie2bbbd3f690826404b8f1059d24edcab33ed898f@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220630123445.v24.2.Ie2bbbd3f690826404b8f1059d24edcab33ed898f@changeid>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Jun 2022 12:35:28 -0700, Matthias Kaehlcke wrote:
> In the context of USB the term 'companion-hub' is misleading, change the
> name of the property to 'peer-hub'.
> 
> There are no upstream users of the 'companion-hub' property, neither in
> the device tree, nor on the driver side, so renaming it shouldn't cause
> any compatibility issues with existing device trees.
> 
> Changes in v24:
> - patch added to the series
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> 
> (no changes since v1)
> 
>  .../devicetree/bindings/usb/realtek,rts5411.yaml       | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
