Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9949651866D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 16:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236971AbiECOWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 10:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236956AbiECOWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 10:22:18 -0400
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C8125E9E;
        Tue,  3 May 2022 07:18:46 -0700 (PDT)
Received: by mail-ot1-f47.google.com with SMTP id h10-20020a056830400a00b00605e92cc450so9769965ots.11;
        Tue, 03 May 2022 07:18:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/aMt+iUL1CVqIgS6yg9mheyNXMFTAG1uctDwp9jLpck=;
        b=Q0QTK4WNQAPlrFIeLia3/2cJGbVsHF1aLl2dgwpWT07gqFsVqL1hNNI3hnYTcumels
         TAUhHWzTB44wZvCLZKWEV7Qp0LBwqqQTQKJuSgGdJwNuIzOb6R71qe0vA6HSLCWIuR/M
         Y9scMmgqTytpq3pf+AMIyi5aPkRfXKWV7quV+YojAt+l6O67ZR9K1ALPlOAT9yjWFzEj
         yB0aOjrph+SUpmVmIdxqivp7zjkYcXGIJdkMdZ/422mrkfeX2u4RjkzUJZslaNtJdpO0
         EKEAnCF38+Qij8aGFGGcGxLpYfQpBzTzXI6XxmfzghhdzaJQV55RezlbfxuFubQmmc6s
         mz0A==
X-Gm-Message-State: AOAM533qinW4iQyuTYiNkPEV7CU8LW73KeGC2iV+N3ujCwCW/D+1MhD4
        lEh684E0J0FPP68tWAqePczVE+vOIw==
X-Google-Smtp-Source: ABdhPJy2p5eNvTSK+e4lPTi3BIf7IcquwGcze73MguD+vpeB8vzEjETxR5Ny0gGxkZHOQEReDlENHw==
X-Received: by 2002:a9d:5913:0:b0:5cd:a050:8f55 with SMTP id t19-20020a9d5913000000b005cda0508f55mr5967584oth.44.1651587525443;
        Tue, 03 May 2022 07:18:45 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l24-20020a056820031800b0035eb4e5a6b0sm4984867ooe.6.2022.05.03.07.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 07:18:44 -0700 (PDT)
Received: (nullmailer pid 3575356 invoked by uid 1000);
        Tue, 03 May 2022 14:18:44 -0000
Date:   Tue, 3 May 2022 09:18:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: iio: sx9324: Add CS idle/sleep mode
Message-ID: <YnE5xMS13oSuR5rx@robh.at.kernel.org>
References: <20220503004156.3559940-1-swboyd@chromium.org>
 <20220503004156.3559940-2-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503004156.3559940-2-swboyd@chromium.org>
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

On Mon, May 02, 2022 at 05:41:55PM -0700, Stephen Boyd wrote:
> We need to configure the sleep and idle mode of the CS pins for this
> device. Add a DT property to do this so pins are in a proper state
> during sleep (either hi-z, grounded, or pulled up to vdd).
> 
> Cc: Gwendal Grignou <gwendal@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  .../devicetree/bindings/iio/proximity/semtech,sx9324.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
> index d265eb5258c8..6cec3481c8b2 100644
> --- a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
> +++ b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
> @@ -126,6 +126,14 @@ properties:
>        UINT_MAX (4294967295) represents infinite. Other values
>        represent 1-1/N.
>  
> +  semtech,cs-idle-sleep:
> +    description:
> +      State of CS pins during sleep mode and idle time.
> +    enum:
> +      - hz

I was trying to figure out how Hertz was a pin state. 'hiz' or 'hi-z' 
instead?

> +      - gnd
> +      - vdd
> +
>    semtech,int-comp-resistor:
>      description:
>        Internal resistor setting for compensation.
> -- 
> https://chromeos.dev
> 
> 
