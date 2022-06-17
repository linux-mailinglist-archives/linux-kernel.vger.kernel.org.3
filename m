Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC5A54FD55
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 21:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238148AbiFQTNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 15:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242080AbiFQTNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 15:13:44 -0400
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E04D517DC;
        Fri, 17 Jun 2022 12:13:44 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id n11so5466756iod.4;
        Fri, 17 Jun 2022 12:13:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FAlxY7C70942+6ZI8In0KZR6RDzNAw7pB8H0QURf/C0=;
        b=6YWRz1YxIFbHFozRkSmnp//BbhRoXupoVad3HtKDH0q4kOWeGoH6eLJZfoOusNsuq1
         pcR40JmTdj9IM9M7hY2g74Iu1UeNObaW132m5yU9W9KOn8+gBtIV7YwnZxcXweEW9UhO
         f92wVeFUgdrDq8ueASMDlsXNh+ilmZ2r/N/cg8Vu6m15d0XcaAeuRtsCGVXEsxMR+AF1
         z4w+k1Ej9TaBGuON/ohE7Y1me7xaI5rUwQl3ljzrT0tWViCTvXkHPxYGvo/MVmAYQzbZ
         lXbLBalQlbqLlLUSKYUfGoe4F64/tr3+oPfdV+nrNHOeqeUHknDZ8ZJ9fp3TqC4LKNFY
         melw==
X-Gm-Message-State: AJIora/AZ/KEk/tiAsgT4vKDxNHuJOJdhsSJVUmNt0cTkRsQN7RFQU13
        wBBr+D1PnbYiE5m7wz8xrQ==
X-Google-Smtp-Source: AGRyM1tN15Vyauv/t5I2I81uJqs0mSjvkhJPD/uPhy2wr2HRbI7QXMOLyrKAh0Z8TX5E/7FySM9zSg==
X-Received: by 2002:a05:6638:1c07:b0:331:a800:1062 with SMTP id ca7-20020a0566381c0700b00331a8001062mr6332880jab.4.1655493223286;
        Fri, 17 Jun 2022 12:13:43 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id g8-20020a056602242800b00665881f9182sm2875926iob.20.2022.06.17.12.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 12:13:42 -0700 (PDT)
Received: (nullmailer pid 2123808 invoked by uid 1000);
        Fri, 17 Jun 2022 19:13:41 -0000
Date:   Fri, 17 Jun 2022 13:13:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, Liviu Dudau <Liviu.Dudau@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andre Przywara <andre.przywara@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        dri-devel@lists.freedesktop.org,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2] dt-bindings: display: Add Arm virtual platforms
 display
Message-ID: <20220617191341.GA2123705-robh@kernel.org>
References: <20220613145709.3729053-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613145709.3729053-1-robh@kernel.org>
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

On Mon, 13 Jun 2022 08:57:09 -0600, Rob Herring wrote:
> 'arm,rtsm-display' is a panel for Arm, Ltd. virtual platforms (e.g. FVP).
> The binding has been in use for a long time, but was never documented.
> 
> Some users and an example have a 'panel-dpi' compatible, but that's not
> needed without a 'panel-timing' node which none of the users have since
> commit 928faf5e3e8d ("arm64: dts: fvp: Remove panel timings"). The
> example does have a 'panel-timing' node, but it should not for the
> same reasons the node was removed in the dts files. So update the
> example in arm,pl11x.yaml to match the schema.
> 
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Andre Przywara <andre.przywara@arm.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v2:
>  - Make arm,rtsm-display its own schema file instead of using
>    panel-simple.
> ---
>  .../bindings/display/arm,pl11x.yaml           | 15 +----------
>  .../display/panel/arm,rtsm-display.yaml       | 27 +++++++++++++++++++
>  2 files changed, 28 insertions(+), 14 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/arm,rtsm-display.yaml
> 

Applied, thanks!
