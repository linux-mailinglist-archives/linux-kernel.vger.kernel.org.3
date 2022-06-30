Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED2F562616
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 00:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbiF3W3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 18:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiF3W3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 18:29:41 -0400
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A785D4D14C;
        Thu, 30 Jun 2022 15:29:40 -0700 (PDT)
Received: by mail-il1-f181.google.com with SMTP id h20so287203ilj.13;
        Thu, 30 Jun 2022 15:29:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FPpQ92LHvGCb21Eo1Xg56Gb8OHC60FU6DQIEzBzz8bk=;
        b=qSJTKRIosNdn6Amm/dbt094FOA4wp081+S128uqb8ptagrvtwIs9bQbfZ4PMBT0p9Z
         dTsjcV2R5i3YR3jmr5sotryi9OtoWZ7YJskx+s34I/KN1SFVLm+F4E7NGOT4KJaKPK5H
         3qGEXCvyyCI0ajZzsiRGA4h3KqauQ0GCrI1gw2pA4V02iHTHr1F5HOuCrwQjFGmy9LQj
         0gwNLFJRbGw6lI9mAYqJLOHlPvM1DvHazRJXXQyDgn0s/OZ7shEYowLp0ezi9zbTuUsa
         LLEti7ovBKqNzkYvR0z8jvu0lHo1cjd0t4ThPWHtXmWFU5UHebta9I6ZT7P/yMKbNpv6
         OqNg==
X-Gm-Message-State: AJIora82gWrO7/uh7cBuZrxxFsXYgsc1SxpNu9zy9K5g+5fSHi1RH1sh
        X+EP272NiXhwk1VC1wIwf/cGog4Hsg==
X-Google-Smtp-Source: AGRyM1uDs8Rh1HzeUuwi5KRhsefkWcp/s9ONBW7MuPoMTRj5qtRxkMGCDE0Vd3FTrSqZ7TFzzcn0vw==
X-Received: by 2002:a05:6e02:1c44:b0:2da:7918:2ae6 with SMTP id d4-20020a056e021c4400b002da79182ae6mr6927809ilg.96.1656628179983;
        Thu, 30 Jun 2022 15:29:39 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id s12-20020a92d90c000000b002d92c91da91sm8498189iln.77.2022.06.30.15.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 15:29:39 -0700 (PDT)
Received: (nullmailer pid 3440856 invoked by uid 1000);
        Thu, 30 Jun 2022 22:29:38 -0000
Date:   Thu, 30 Jun 2022 16:29:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: connector: usb: align example indentation
 to four-space
Message-ID: <20220630222938.GA3440776-robh@kernel.org>
References: <20220624162141.25890-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624162141.25890-1-krzysztof.kozlowski@linaro.org>
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

On Fri, 24 Jun 2022 18:21:41 +0200, Krzysztof Kozlowski wrote:
> One DTS example was using 8-space indentation, while others 2-space.
> For complex DTS with multiple levels, 2-space is not that readable and
> in DTS examples 4-space is preferred.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/connector/usb-connector.yaml     | 152 +++++++++---------
>  1 file changed, 76 insertions(+), 76 deletions(-)
> 

Applied, thanks!
