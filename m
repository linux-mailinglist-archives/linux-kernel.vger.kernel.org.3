Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59F153EE84
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 21:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbiFFTXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 15:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbiFFTW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 15:22:58 -0400
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B801CFCF;
        Mon,  6 Jun 2022 12:22:56 -0700 (PDT)
Received: by mail-il1-f176.google.com with SMTP id d6so1825424ilm.4;
        Mon, 06 Jun 2022 12:22:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=igqJ6dHQr5YcAlveo+prNgh7gR56A9+URnq8E5u+gNg=;
        b=T+S3FPzuQEnDbsAsT8sbMM1LPQNuI48dM6+TYok7w5SoXzwbg01Q8uld0rHl0B6VFL
         bAqphqcy/ygYKJLvboYK4PQXNkJ1wPMlh9oO7VBjx75lQ80HlS7SNQrX0oXc6zI+8wwr
         PL0k8CgSvmic3PySMYDSGb/OxoshxI3kbKGySZu8EIFFOmI90pvQqX8jN8UWa41L/lyo
         8xgvF7LAxIcrsmqb6PxoWQHFDGfT4d5Cw8O6ML7bE53JvfYZpBemHG/1RtFqWkuZX/7P
         7ml4LzlVCHT2Z3ron/EkuKYB3Kr13EObmTWJiBkyGS4Cok+IqlcilwVImMhisBl+WnnZ
         4oiw==
X-Gm-Message-State: AOAM532rGPxEja09YK7DR7d+cM4BrILRS4xjBIzip8yXOuO0LyWzWJqQ
        MI7S3Vz2XiQ/Noq2OdhGAg==
X-Google-Smtp-Source: ABdhPJxCcKVuvKSNVEEpGpz2jpx7c2xLaCtMwOmcYjdVDfde+NPC5xKUdC2Cs+uEbOzHCaJz1JP2NQ==
X-Received: by 2002:a92:c94e:0:b0:2d3:be50:3e2f with SMTP id i14-20020a92c94e000000b002d3be503e2fmr14793916ilq.143.1654543376225;
        Mon, 06 Jun 2022 12:22:56 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id w10-20020a02394a000000b0032e79d23f8fsm5934333jae.156.2022.06.06.12.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 12:22:55 -0700 (PDT)
Received: (nullmailer pid 1112900 invoked by uid 1000);
        Mon, 06 Jun 2022 19:22:53 -0000
Date:   Mon, 6 Jun 2022 14:22:53 -0500
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dri-devel@lists.freedesktop.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: display: bridge: sil,sii9022: Convert to
 json-schema
Message-ID: <20220606192253.GA1112705-robh@kernel.org>
References: <2f8e12b4980a82788c1dd413ceedf8d144fdca91.1652967387.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f8e12b4980a82788c1dd413ceedf8d144fdca91.1652967387.git.geert+renesas@glider.be>
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

On Thu, 19 May 2022 15:41:06 +0200, Geert Uytterhoeven wrote:
> Convert the Silicon Image sii902x HDMI bridge Device Tree binding
> documentation to json-schema.
> 
> Add missing sil,sii9022-cpi and sil,sii9022-tpi compatible values.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v3:
>   - Add comments clarifying CPI/TPI,
>   - Improve wording,
>   - Drop port@2,
>   - Add port descriptions,
>   - Add schema references to individual ports.
> 
> v2:
>   - Rework sil,i2s-data-lanes,
>   - Add schema reference to ports.
> ---
>  .../bindings/display/bridge/sii902x.txt       |  78 -----------
>  .../bindings/display/bridge/sil,sii9022.yaml  | 131 ++++++++++++++++++
>  2 files changed, 131 insertions(+), 78 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/bridge/sii902x.txt
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/sil,sii9022.yaml
> 

Applied, thanks!
