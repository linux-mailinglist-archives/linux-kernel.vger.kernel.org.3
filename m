Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37072531E50
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 00:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbiEWWCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 18:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiEWWCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 18:02:47 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064916FD26;
        Mon, 23 May 2022 15:02:47 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id fw21-20020a17090b129500b001df9f62edd6so786133pjb.0;
        Mon, 23 May 2022 15:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZEKMyEh/E8SYLhxTN5ZGor0b8jTi1kpeB5E+5XqApgE=;
        b=LzKQDUdQD7/u24gLVGuSHe7ENL4hlq+AwB/ZI4SJpmuU4YOmNI0zTLHJInEjsaMpcS
         mxiW1DjEr5BAIPwjdBO/rX72TYH1K6vuk4Y9Gyy4JjJHc76oEvnCeFs/KopdvlGMQQZq
         r6y+bHQlMaOiOOX3Q9vfUwYyEg6hvVAuxtTyrGbd30T8RoaQkaas8YMHN0Y4vgblTip8
         LVwpiEnGHONzomtH1jgyqi9Vh0rH/hM/zVXpGjkO4laYELhAov+cVhfeYRFPP3nftEER
         MmjpagFsq3LW/Zdl5FPBVZllvRjsTnnK5SDz2PBv+6icxDzwDnXpQ2ywkzTWHh0Up3BI
         2vJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZEKMyEh/E8SYLhxTN5ZGor0b8jTi1kpeB5E+5XqApgE=;
        b=7MMYd98YfXQNoYl4eyIEQCOgfRUf9FawCBMCa+mIrQfXHI+1uehGetbqqHGyRNtrb8
         PLIsDqAfirqpns/rBSUBg/G6UvxYXBslOZpvcOfGwGvma0SpLlIIQtpHN3bOUMYFgOyK
         BFFU0UJjji1mlIlTsIg2f7jJcWDPa9aicpyLiVsYUwzzOQQBHcz2LiG4LDVKuvNGQizK
         3URPydNNTjN2NGuzmhWSKm4VTUDIhTwZuHTbK7Cmdwa1l32eqDNZIctJDbtC6TJ/RmdT
         gJegKDsu1feUE7IaZORzsWtZ1vm8ENBcRGwpY0YZJZVW+VwcIlt8OH1tCFpSpEUq5Xv6
         6O+Q==
X-Gm-Message-State: AOAM532PEHBuB3Cvm4fXqsr3wXWbQB61vMEh7joETR3R0hShJ+GPxHFg
        EVUt1VPfl5gf2wivuEJVFeM=
X-Google-Smtp-Source: ABdhPJwN/7mXyn+nlRmJJvbHbIxxftDyw/uoYFxuJZBEMbyzBhlx3lLwCqu4ydEqlV/SIMsvyCwhHQ==
X-Received: by 2002:a17:902:f253:b0:161:d61e:7d3c with SMTP id j19-20020a170902f25300b00161d61e7d3cmr24159593plc.33.1653343366362;
        Mon, 23 May 2022 15:02:46 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:ce25:f34f:c90d:61fa])
        by smtp.gmail.com with ESMTPSA id o15-20020a17090a420f00b001d92e2e5694sm191192pjg.1.2022.05.23.15.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 15:02:45 -0700 (PDT)
Date:   Mon, 23 May 2022 15:02:42 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Robin van der Gracht <robin@protonic.nl>,
        Miguel Ojeda <ojeda@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Olof Johansson <olof@lixom.net>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: input: matrix-keymap: Add common
 'linux,no-autorepeat' property
Message-ID: <YowEgvwBOSEK+kd2@google.com>
References: <20220523170449.1763039-1-robh@kernel.org>
 <YovWpSvabyhcYnzL@google.com>
 <20220523194503.GA2004570-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523194503.GA2004570-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 02:45:03PM -0500, Rob Herring wrote:
> On Mon, May 23, 2022 at 11:47:01AM -0700, Dmitry Torokhov wrote:
> > On Mon, May 23, 2022 at 12:04:49PM -0500, Rob Herring wrote:
> > > 'linux,no-autorepeat' is a common property used in multiple bindings,
> > > but doesn't have a common type definition nor description. Add a common
> > > definition and drop the now redundant description from
> > > holtek,ht16k33.yaml.
> > 
> > We have "autorepeat" in the common input binding description, should we
> > not promote it over "no-autorepeat"?
> 
> We're kind of stuck with it I think. We can't just deprecate one and 
> switch existing users as what would neither property present mean?

I agree, we should not change existng bindings.

> 
> Hopefully, documented in input.yaml vs. matrix-keypad.yaml is enough to 
> say which one is preferred for new users. 

So this is what I have issue with, as I think it will introduce
confusion: we have drivers/input/matrix-keymap.c and corresponding
binding Documentation/devicetree/bindings/input/matrix-keymap.yaml that
deals with parsing keymap-related properties for various matrix keypads.
It does not specify autorepeat handling one way or another. Then we have
drivers/input/keyboard/matrix_keypad.c that is one implementation of
matrix keypads, and it does have linux,no-autorepeat, but it does not
mean that other devices resembling matrix keypad are forced to use
linux,no-autorepeat. And that is why I think putting this property into
the generic binding
Documentation/devicetree/bindings/input/matrix-keymap.yaml is not a good
idea.

Thanks.

-- 
Dmitry
