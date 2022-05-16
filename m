Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E174F528848
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 17:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245080AbiEPPQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 11:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245140AbiEPPQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 11:16:04 -0400
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657823BF80;
        Mon, 16 May 2022 08:15:58 -0700 (PDT)
Received: by mail-oi1-f181.google.com with SMTP id i66so18924865oia.11;
        Mon, 16 May 2022 08:15:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rpyUOc+Ph8OhqWWweb6POPRF3kJtOe+oRe+i16xzVGk=;
        b=WDngn2AEkT7HdKq4nGKwM9AiOtV4U+Z3B3CYwT688KkDejOJL0SYiGAcRWKid0GQpO
         83GofFiC4cVi+61vBrHfArw/UpZhYJDLftfm+16yyzyzH1INhSDmOKxTOJBykkGWYfBf
         a4oQyIdnQO+nZHnXmRkUuUSpdUYMJPx6TGoX1Ze2dnT0FymLNaZK9wgPakzB2cuIPQYX
         //yisVIcE98uIMmR+VEDkNaSGIkiNis2WXBCP7aqORwkgUI7WeCjSRumA/nAE3UaE9t6
         C/2sdUD6nI01+E1S9mgrsHxiCcy8MmgBFlk8yog/pBlp/wZha+IKM8X5UQgTq9MoWUdt
         VCcw==
X-Gm-Message-State: AOAM532u/gV/QlFSd6h2+x5JMJv0jKxqZ4hDoqqhFHe/3FpRUrxPN3Ia
        gCiQCuowrnvbCukqZOGAfw==
X-Google-Smtp-Source: ABdhPJx45RNkA2fwa4orCPJKw9hv/GNXxlNUhflyL24Pmr7ALmc9zOAHfZdEUnGx1c2vqPLz4LvIvg==
X-Received: by 2002:a05:6808:de1:b0:326:c5dc:dc28 with SMTP id g33-20020a0568080de100b00326c5dcdc28mr8145783oic.108.1652714157711;
        Mon, 16 May 2022 08:15:57 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l21-20020a4ae395000000b0035eb4e5a6bcsm4174094oov.18.2022.05.16.08.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 08:15:57 -0700 (PDT)
Received: (nullmailer pid 2660144 invoked by uid 1000);
        Mon, 16 May 2022 15:15:56 -0000
Date:   Mon, 16 May 2022 10:15:56 -0500
From:   Rob Herring <robh@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        chrome-platform@lists.linux.dev,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Craig Hesling <hesling@chromium.org>,
        Tom Hughes <tomhughes@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v5 1/3] dt-bindings: cros-ec: Fix a typo in description
Message-ID: <20220516151556.GA2659134-robh@kernel.org>
References: <20220512013921.164637-1-swboyd@chromium.org>
 <20220512013921.164637-2-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512013921.164637-2-swboyd@chromium.org>
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

On Wed, May 11, 2022 at 06:39:19PM -0700, Stephen Boyd wrote:
> A 's/pf/of/' on rpmsg-name description.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: <devicetree@vger.kernel.org>
> Cc: <chrome-platform@lists.linux.dev>
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Craig Hesling <hesling@chromium.org>
> Cc: Tom Hughes <tomhughes@chromium.org>
> Cc: Alexandru M Stan <amstan@chromium.org>
> Cc: Tzung-Bi Shih <tzungbi@kernel.org>
> Cc: Matthias Kaehlcke <mka@chromium.org>
> Cc: Benson Leung <bleung@chromium.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  Documentation/devicetree/bindings/mfd/google,cros-ec.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
