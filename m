Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA464C099E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 03:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbiBWCr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 21:47:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237576AbiBWCrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 21:47:17 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64425F4FA
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 18:45:05 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id s1so10625582wrg.10
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 18:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=trpEJbUaAoUHUXzraHCvZbmPHXTmssr8XxPA/Czuy7Q=;
        b=YjfGvfJmUOx66BnhtXdT7mh8HRI2QuaW2Nypv8ZqJDcXDhiupYJWc47iQEDWgoQA8K
         rVmw1smUgmGFRaghswn0NJyTOs3YIS5TYjdS+UjrUNGa4OSOqPB0K4JGmmmZ6eBLxIRP
         Als744SOL/T0l8fA0u0T0RJ3lY7QsnPPpPaZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=trpEJbUaAoUHUXzraHCvZbmPHXTmssr8XxPA/Czuy7Q=;
        b=J3D5rvFZEzfLFGfLP6lhTI85oivdFg3RXyql8Jo84ISRYJPt11ACT6aPDQCFVe9H0c
         +Iu4q3rx+Gseyzs4KQiUX7t6pg/fPEouwHjvzxw5taF7bZItNFXM7SSaiUhaK9iYVS4L
         KzxXXKVxLVUPPTFVPek1KPnD9tci8sRB9CeyjIEuQIWkbhIepaNRRJPUNGbc5xSMjS1o
         dEJY1+KxwbkIOSON7HLk2RPNbGTFnenWlBMuinQLWWG7R4Mbrl9s5Od1fE0S7xS6zDiZ
         5YGTKuY1YfpbF2USfbJZZEU9HwhBVUAOuVpHhiAx6x76nnMTN0+5CA5/tIZZU5dkoPkc
         V7DQ==
X-Gm-Message-State: AOAM5306pTxm3Y8/kjvbXM36JCZuqO1I0DgiWebmh0432cGYARhfsshQ
        HIXdIvQn6/i5OROQBU6qm6oS2GxivAuaqgNFRJ4nFA==
X-Google-Smtp-Source: ABdhPJy3OspjYsMc6sZbvjjucdf4g/jO3nXY1gAvytGBZ9BMC968K8xi4ndFVpLV3XUKns3jpNgSmk+1lzhwXy6Z0rs=
X-Received: by 2002:a05:6000:1292:b0:1e3:1497:be92 with SMTP id
 f18-20020a056000129200b001e31497be92mr21574751wrx.667.1645584304247; Tue, 22
 Feb 2022 18:45:04 -0800 (PST)
MIME-Version: 1.0
References: <20220219012457.2889385-1-jwerner@chromium.org> <9d33314e-97da-dc47-8361-2e45b75fa566@canonical.com>
In-Reply-To: <9d33314e-97da-dc47-8361-2e45b75fa566@canonical.com>
From:   Julius Werner <jwerner@chromium.org>
Date:   Tue, 22 Feb 2022 18:44:52 -0800
Message-ID: <CAODwPW_JbcppFGKvrooxf25dLJuvf5iWoWim1xSXZ2wqgL1k0A@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: memory: lpddr2: Adjust revision ID
 property to match lpddr3
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Julius Werner <jwerner@chromium.org>,
        Dmitry Osipenko <digetx@gmail.com>, devicetree@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +  revision-id:
> > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > +    minItems: 2
> > +    maxItems: 2
>
> You need maximum value under items.  See:
> Documentation/devicetree/bindings/arm/l2c2x0.yaml

Sorry, can you clarify how this is supposed to be? Do you want

 revision-id:
   minItems: 2
   maxItems: 2
   items:
     minItems: 2
     maxItems: 2

or just

 revision-id:
   items:
     minItems: 2
     maxItems: 2

I see examples of both in the file you linked (and also examples of
what my original patch did). Is there any authoritative documentation
somewhere I can read that specifies which of those is correct? (I
tried looking at
https://json-schema.org/understanding-json-schema/reference/array.html#length
but I'm not sure if that's relevant here.)

For updating existing DTSes, do you want that in the same patch or a
separate patch in a series?
