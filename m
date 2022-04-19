Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 796CF507A26
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 21:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355608AbiDSTXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 15:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239634AbiDSTXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 15:23:33 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BF111148;
        Tue, 19 Apr 2022 12:20:49 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-e5c42b6e31so8618753fac.12;
        Tue, 19 Apr 2022 12:20:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hbpwhzSTJk/G9AFGud5nKQNNHhLWCRtxFkShRktEDi0=;
        b=xtubFfgQnKWtTKgtoIo9pgrMMoir3vDL0EtXGgR6RU+lkkq/CxVbXYhXI1vGBv/03J
         vr74l4HMUbYQNqzF5hNUMrKmw7b+hmai7kHltM6TGTLW6TSR7XO5tjdotlFkr/vmx7h7
         A0UD8dvydO8Xo3b/6RnRfeOHYUR6r4jmVZp8mRPkLXYyF1MhEV533L0EcujtnMA8tjx8
         lNLHl4PB7xynsPeMgtbm0YfjEjwpA5JOOI4TffVryjYYphUYgX6wyuS+GdmpM6dJ8VUA
         b0gc6AAe29nOU4SgeianowEpXShWuh/itmDQLumZZsj4XsvkYtoA1Nys1TViXWHeJ/YI
         MWZA==
X-Gm-Message-State: AOAM533qWx7bdV47mDKtLLlNqV7tmJViYn+2Gv0sh/Nz1oN5+5lDRDgr
        Sq9VQtCxaCbAOLPwN8H4WQ==
X-Google-Smtp-Source: ABdhPJykLcDZ4QeimuBRrMt9O9Uh+gIYBM38gFE01IbiPLnT0cZoWqtURSt6BzKkkGXxf3AowWaCog==
X-Received: by 2002:a05:6870:2190:b0:e6:26d2:abe0 with SMTP id l16-20020a056870219000b000e626d2abe0mr59745oae.15.1650396048318;
        Tue, 19 Apr 2022 12:20:48 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r205-20020acadad6000000b002ef824213c9sm5462273oig.55.2022.04.19.12.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 12:20:47 -0700 (PDT)
Received: (nullmailer pid 3258007 invoked by uid 1000);
        Tue, 19 Apr 2022 19:20:47 -0000
Date:   Tue, 19 Apr 2022 14:20:47 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] docs: dt: writing-schema: mention yamllint
Message-ID: <Yl8LjwRsDaSg8tSF@robh.at.kernel.org>
References: <20220419084942.27409-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419084942.27409-1-krzysztof.kozlowski@linaro.org>
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

On Tue, 19 Apr 2022 10:49:42 +0200, Krzysztof Kozlowski wrote:
> The dtschema uses yamllint, if present, to check the syntax of the
> files, so document this.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/writing-schema.rst | 2 ++
>  1 file changed, 2 insertions(+)
> 

Applied, thanks!
