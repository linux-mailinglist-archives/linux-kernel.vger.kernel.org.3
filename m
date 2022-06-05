Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C34AE53DC71
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 17:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345428AbiFEPIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 11:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbiFEPI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 11:08:27 -0400
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5841A3BD;
        Sun,  5 Jun 2022 08:08:26 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id y69so2896809oia.7;
        Sun, 05 Jun 2022 08:08:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=O/5Kk8YxDjFostjbu27e4DNO545UqELI2BQbep59s2c=;
        b=oh7eaC9q3U6mACTO0sS7N68mrFd6GU9k9/0NPyMB4joVVGeeH8h0/rhZ9ZFEAB/nV7
         8l5ye3c/V5l1jTuyKCSBCXcPc5OjQzO7r6zdl5M+xZI7ixdfkg2LPDAmS0edFPuLq4Cr
         PaKbZUH2vfDb/vxMLjB7KPImgzvoBK2bCsBshzWFryLc0c6FlL96D8qPbB0xTspCdyip
         RXVbWA6fKZqz3GOjY/0ooP7vgca6EH4cU7wjvO/Y83anYXnapo62mvuOZ9m9j5HDHXt+
         J7SCck2puUKNezFmnxEKrlpb5C4Jm/Qk2SjoXLNuq4k1hGYNJgdPEDef2ULLUsPnVcSm
         4+KQ==
X-Gm-Message-State: AOAM530NiI7Psf14Y0BsgQN16M0BwBak9h5RfZ+uu71Ec+5AfTLGTgEh
        gmkavHqt6FYKEd8hkvL9qQ==
X-Google-Smtp-Source: ABdhPJx0T/nvzT6nuhRLT97FJIW+iCS0LZ2al+osTrqDlbdxxKFzs9RA6AGcv/KMr5AHyyry1BS3pA==
X-Received: by 2002:a05:6808:e87:b0:32e:4789:d2c with SMTP id k7-20020a0568080e8700b0032e47890d2cmr8305390oil.193.1654441705815;
        Sun, 05 Jun 2022 08:08:25 -0700 (PDT)
Received: from robh.at.kernel.org ([2607:fb90:20d2:7c7e:bed3:ffa4:df1c:4ad2])
        by smtp.gmail.com with ESMTPSA id y14-20020a0568302a0e00b006060322127bsm6312321otu.75.2022.06.05.08.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 08:08:25 -0700 (PDT)
Received: (nullmailer pid 3508795 invoked by uid 1000);
        Sun, 05 Jun 2022 15:08:23 -0000
Date:   Sun, 5 Jun 2022 10:08:23 -0500
From:   Rob Herring <robh@kernel.org>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     robh+dt@kernel.org, kernel@pengutronix.de,
        krzysztof.kozlowski+dt@linaro.org, sam@ravnborg.org,
        daniel@ffwll.ch, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, thierry.reding@gmail.com,
        linux-kernel@vger.kernel.org, airlied@linux.ie
Subject: Re: [PATCH 1/2] dt-bindings: display: simple: add EDT ETML0700Y5DHA
 panel
Message-ID: <20220605150823.GA3508729-robh@kernel.org>
References: <20220530122407.918874-1-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220530122407.918874-1-m.felsch@pengutronix.de>
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

On Mon, 30 May 2022 14:24:06 +0200, Marco Felsch wrote:
> Add binding for the Emerging Display Technology ETML0700Y5DHA panel.
> It is a 7" WSVGA (1024x600) TFT LCD panel with:
>  - LVDS data interface,
>  - backlight and
>  - capacitive touch.
> 
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
>  .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
