Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 787D95206CB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 23:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiEIVnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 17:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbiEIVnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 17:43:37 -0400
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CCC135683;
        Mon,  9 May 2022 14:39:36 -0700 (PDT)
Received: by mail-ot1-f45.google.com with SMTP id m15-20020a9d608f000000b00606a788887aso986665otj.0;
        Mon, 09 May 2022 14:39:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+KkqknBI/2K3Eq7hGd53E0RZ8mZ5a02S480GCyvqwzM=;
        b=cuASTZQktzvZLQKVEMUiK3o557C4G9tnWtxWyr0cfyLRX+WZi82Vg0oqxIWmIA8/cy
         kFOh2QXu4BCs8CbQkIaF1i2/Z6GYv0Xtb8rVnOsoK2n9NmtM5VC110Kq5twreZPagTyS
         DeYxUZuguM4YKS5sSKLOzt71C7vpYjL+jxuqmcupr4UojIk5IHaNcqnhx8LwdRpUvcG9
         Xg5wmpEXcGB7JyzYfgoUE87DDS7Q7eAi0RFL8xu9W9PxEotzDgL8VnVNDkn2S5KeLSBh
         nIS+n/wwcp2WG+SF6olJaT8BHxOf1N476GiJczf3XfGEFgow6BWTwOI02IyrWUFIc59a
         b9dg==
X-Gm-Message-State: AOAM531ANc4kMdMwIpgfu6jBKcEyzt4Bnz25GoeYt748cechEeJN9kc0
        KnloIyDE/I0Klr2RzFdrNZRMUsfOZg==
X-Google-Smtp-Source: ABdhPJyBKwsYVpF+613L3NjhkodjdhNhTlNBEVF4zad8+lj7S3V5mZuzad0b7ALO+n88vjbc7x+Mqw==
X-Received: by 2002:a05:6830:310e:b0:606:638d:cf00 with SMTP id b14-20020a056830310e00b00606638dcf00mr6415474ots.76.1652132375719;
        Mon, 09 May 2022 14:39:35 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o24-20020a9d6d18000000b0060603221271sm5086642otp.65.2022.05.09.14.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 14:39:35 -0700 (PDT)
Received: (nullmailer pid 243241 invoked by uid 1000);
        Mon, 09 May 2022 21:39:34 -0000
Date:   Mon, 9 May 2022 16:39:34 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: sx9324: Add CS idle/sleep mode
Message-ID: <YnmKFiFqiR43I7Bb@robh.at.kernel.org>
References: <20220503193937.3794477-1-swboyd@chromium.org>
 <20220503193937.3794477-2-swboyd@chromium.org>
 <faaa4ab4-8190-3cff-998e-3b6a6d3ce27c@linaro.org>
 <YnKVzvAITXAHqSiX@robh.at.kernel.org>
 <8aef897f-fff0-526e-62d0-6a92c301eb08@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8aef897f-fff0-526e-62d0-6a92c301eb08@linaro.org>
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

On Wed, May 04, 2022 at 05:15:55PM +0200, Krzysztof Kozlowski wrote:
> On 04/05/2022 17:03, Rob Herring wrote:
> >>>  
> >>> +  semtech,cs-idle-sleep:
> >>> +    description:
> >>> +      State of CS pins during sleep mode and idle time.
> >>> +    enum:
> >>> +      - hi-z
> >>> +      - gnd
> >>> +      - vdd
> >>
> >> You need a ref to type (string).
> > 
> > Actually, it can be implicit for single strings.
> 
> Is this a generic preference?

I don't have a preference, just noting that both are allowed. I like 
having a smaller schema, but then it is a bit of a special case.

Rob
