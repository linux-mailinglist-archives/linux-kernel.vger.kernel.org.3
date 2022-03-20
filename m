Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 998CD4E1D7B
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 19:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343555AbiCTS42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 14:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343548AbiCTS41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 14:56:27 -0400
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC71A27F2;
        Sun, 20 Mar 2022 11:55:02 -0700 (PDT)
Received: by mail-qk1-f169.google.com with SMTP id b189so10355674qkf.11;
        Sun, 20 Mar 2022 11:55:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PzA7nYjRIh6r+PsqCtYkbJPZK+SyOILVZEN9JB/lN+o=;
        b=x+01/mN2ArBYZDJZno3mo1+1aDncmySbV58TAWhkvcRxRFyUut1+xS3r+uz+irPtJS
         jpIyvCCj5Bum/qBmtKHVsqSoQXDbmQqUiolzJ00DoYzpvwrZYmXaudxg+tVi0oJT9Gse
         74fissWkOX0K1TQ+3e2ja4Hmv8N+dZG8zaoBx4NaGTcDyWpMAmQgnzMhJNAzw/ZyPC7G
         3Glwcus8A70qr/KVNz3nvCjnn0yHPf5SSSO8uv8IIeSre0EUbh/mzJ5vBSAkxMEwJVAb
         k2hh5J2ImVKQn7Qnhpbf18/hqBIgs8v1LowOZ6z/GkVNuWuHBTcyoFTEIPZkY6vdgDHG
         SsoQ==
X-Gm-Message-State: AOAM531+OHymPGJcVFOKYiaQGx65nVN4nBCH04CjaZoiAy1J+xTa0t+K
        gTL89sKZ1O4wIxVW2PZ23w==
X-Google-Smtp-Source: ABdhPJzFeYD+h7+uoq/Sdsfx1gatLHHYhKJRhHz1bOHCqC0CPTLrXtEN1M7s9cWYx4UEnQuIiAfZlg==
X-Received: by 2002:a37:a308:0:b0:67e:428:bfa with SMTP id m8-20020a37a308000000b0067e04280bfamr10982283qke.546.1647802501692;
        Sun, 20 Mar 2022 11:55:01 -0700 (PDT)
Received: from robh.at.kernel.org ([2607:fb90:c6d:21ec:c4f5:bb3:5269:3b0e])
        by smtp.gmail.com with ESMTPSA id v7-20020ac85787000000b002e1c8376517sm10319879qta.22.2022.03.20.11.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 11:55:00 -0700 (PDT)
Received: (nullmailer pid 3208349 invoked by uid 1000);
        Sun, 20 Mar 2022 18:54:58 -0000
Date:   Sun, 20 Mar 2022 14:54:58 -0400
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     devicetree@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 2/5 v2] dt-bindings: gnss: Modify u-blox to use common
 bindings
Message-ID: <Yjd4goQBA1AJqW5/@robh.at.kernel.org>
References: <20220317225844.1262643-1-linus.walleij@linaro.org>
 <20220317225844.1262643-2-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220317225844.1262643-2-linus.walleij@linaro.org>
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

On Thu, 17 Mar 2022 23:58:41 +0100, Linus Walleij wrote:
> This modifies the existing U-Blox GNSS bindings to reference
> the common GNSS YAML bindings.
> 
> Fixed an unrelated whitespace error while at it.
> 
> Cc: devicetree@vger.kernel.org
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Change additionalProperties to unevaluatedProperties and
>   cut the :true insertion of properties from the common
>   props so new common properties get available immediately.
> ---
>  .../devicetree/bindings/gnss/u-blox,neo-6m.yaml    | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 

Applied, thanks!
