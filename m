Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1E0B56C289
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239395AbiGHWFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 18:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239136AbiGHWFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 18:05:10 -0400
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B4B9CE33;
        Fri,  8 Jul 2022 15:05:09 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id y3so229884iof.4;
        Fri, 08 Jul 2022 15:05:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5Rz9ss1apWYLiwK2Swa5YhYzk+HeapOWk50LvWWFvLY=;
        b=eqZSvOuf8pQGxI674QU5CmgZd8PamzInBwIb2Ir68fvYfQPAEJctlm+qW3RNbEqpLM
         ejh2OlL6zPGnfAwW0eLDwhwF5zxvZKrHeJIaxJjwU35dYDUOwr2z57OnnMF7Jzxuk2Or
         eKeCgkDjfY+9GrqES51HRJYUgs9nDa9zpgk1YL/try90vjYlikRZldjc8R69NhQPfFZ5
         Y1DYsIvF71JCfMO4OHm10dtp7nTmOnlrTTqcImu5EoseE+zc5ekVmXmW8jZseO9x7R+0
         qJN/cSXVy+cbWyLsfim1ezOtkJVr2oW3vx86OKxf8+eMLakXwaqH/xifz7YcICMq1Cx3
         ApsA==
X-Gm-Message-State: AJIora/O1kwARttdsdYUL3X4Gk9Up7nYadhlww9c9FdXtP/SvA5v/DlC
        Hkkvr2/GQD4n+gmYfMgNFg==
X-Google-Smtp-Source: AGRyM1uCZTA/9fsWbCIhKWnORtZ6n3s0D9rWOa74eKN2C621mxgYBaFokyWV+HmhbQVEXje2TLOw4g==
X-Received: by 2002:a5d:83c7:0:b0:66c:cc68:2f2d with SMTP id u7-20020a5d83c7000000b0066ccc682f2dmr3070624ior.74.1657317908824;
        Fri, 08 Jul 2022 15:05:08 -0700 (PDT)
Received: from robh.at.kernel.org ([98.38.210.73])
        by smtp.gmail.com with ESMTPSA id y22-20020a056638229600b00339e2f0a9bfsm2012983jas.13.2022.07.08.15.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 15:05:08 -0700 (PDT)
Received: (nullmailer pid 1560089 invoked by uid 1000);
        Fri, 08 Jul 2022 22:05:07 -0000
Date:   Fri, 8 Jul 2022 16:05:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux Input <linux-input@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH v3 0/3] dt-bindings: input: gpio-keys: apply via
 DT tree
Message-ID: <20220708220507.GA1557227-robh@kernel.org>
References: <20220705120356.94876-1-krzysztof.kozlowski@linaro.org>
 <CAL_Jsq+LepF_67SJUqQ5mUO-TZAd-46LB+aYE5rZmnmmwMg=bw@mail.gmail.com>
 <352f27e7-0da1-4a4a-83a4-ded370dfbd7f@linaro.org>
 <YsiVH41gCLeIMyd6@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsiVH41gCLeIMyd6@google.com>
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

On Fri, Jul 08, 2022 at 01:35:43PM -0700, Dmitry Torokhov wrote:
> Hi,
> 
> On Wed, Jul 06, 2022 at 08:30:54AM +0200, Krzysztof Kozlowski wrote:
> > On 05/07/2022 21:11, Rob Herring wrote:
> > > On Tue, Jul 5, 2022 at 6:04 AM Krzysztof Kozlowski
> > > <krzysztof.kozlowski@linaro.org> wrote:
> > >>
> > >> Hi Rob,
> > >>
> > >> Can you apply these directly? You already reviewed them, but I dropped
> > >> the tag so you will see them in Patchwork. It seems these won't go in
> > >> through input [1].
> > >>
> > >> [1] https://lore.kernel.org/all/c2c1cf0c-9462-9ba5-a297-70d13a063de1@linaro.org/
> > > 
> > > Will give Dmitry a few more days first before I take both series.
> > 
> > Then let's keep your Rb for entire patchset:
> > 
> > Reviewed-by: Rob Herring <robh@kernel.org>
> 
> I am sorry but what series/branch this series is based on? I tried
> applying but there are conflicts. The latest I have that is touching
> gpio-keys.yaml is:
> 
> 4fda8a2df83a dt-bindings: input: use generic node names

This one from me:

https://lore.kernel.org/all/20220608211207.2058487-1-robh@kernel.org/
