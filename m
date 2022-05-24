Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8FD532B56
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 15:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237827AbiEXNbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 09:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235112AbiEXNbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 09:31:20 -0400
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50BC29803;
        Tue, 24 May 2022 06:31:19 -0700 (PDT)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-f1d2ea701dso22208934fac.10;
        Tue, 24 May 2022 06:31:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p5cQmQBkb3a2eE/BfwyjgVPm7Utat6ARsNInbYc/VSU=;
        b=CbKJy1bRX1t8tUkg6X0tuy8UTHiXPobesiBf6LKnS3bHaK2lCcoj3Gp9I8a7VWZim7
         RctKcriHOOy1pysmzTaId4+Z1IqxRc8emhduyKkaHCP4StskjyGTuhAXAV6LeFmdHx4M
         qVJ1LEGRyy4NJtqBVCWIBLid4HMiBJ3IrYwI7jbUu0SvvWqzhSMxYliyFWDCqajeuzWY
         G23bLQQRmnF8ElLTR9ESfBJawpAp3unxVwwvWQqtF5h8kZ/GhsggAboov2lqyZ9MQy2i
         SGnF26NEMDEcvu6GN3fODwOY+GjAbXt/aGBQeLjYdAaUR/ImZwHmz+x+clvdIN9yQNyD
         aVxA==
X-Gm-Message-State: AOAM530c0uCAcNihmzJkcApoQzpO7Xm3F+6geVWgbLU1exTMiqySXL/p
        70i6a+HJg3oLzqQWhMuzSQ==
X-Google-Smtp-Source: ABdhPJweQLv5lRGuc/KW8gl+tSohsv9m24as7ZDSR5WrD70i/q60K9ei/NBZoFTt66bRcJMeIXepIw==
X-Received: by 2002:a05:6870:c8a5:b0:f1:65c3:b1e9 with SMTP id er37-20020a056870c8a500b000f165c3b1e9mr2507727oab.36.1653399079185;
        Tue, 24 May 2022 06:31:19 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id mv15-20020a0568706a8f00b000f29b86f448sm603444oab.38.2022.05.24.06.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 06:31:18 -0700 (PDT)
Received: (nullmailer pid 3633153 invoked by uid 1000);
        Tue, 24 May 2022 13:31:17 -0000
Date:   Tue, 24 May 2022 08:31:17 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Robin van der Gracht <robin@protonic.nl>,
        Miguel Ojeda <ojeda@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Olof Johansson <olof@lixom.net>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: input: matrix-keymap: Add common
 'linux,no-autorepeat' property
Message-ID: <20220524133117.GA3592577-robh@kernel.org>
References: <20220523170449.1763039-1-robh@kernel.org>
 <YovWpSvabyhcYnzL@google.com>
 <20220523194503.GA2004570-robh@kernel.org>
 <YowEgvwBOSEK+kd2@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YowEgvwBOSEK+kd2@google.com>
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

On Mon, May 23, 2022 at 03:02:42PM -0700, Dmitry Torokhov wrote:
> On Mon, May 23, 2022 at 02:45:03PM -0500, Rob Herring wrote:
> > On Mon, May 23, 2022 at 11:47:01AM -0700, Dmitry Torokhov wrote:
> > > On Mon, May 23, 2022 at 12:04:49PM -0500, Rob Herring wrote:
> > > > 'linux,no-autorepeat' is a common property used in multiple bindings,
> > > > but doesn't have a common type definition nor description. Add a common
> > > > definition and drop the now redundant description from
> > > > holtek,ht16k33.yaml.
> > > 
> > > We have "autorepeat" in the common input binding description, should we
> > > not promote it over "no-autorepeat"?
> > 
> > We're kind of stuck with it I think. We can't just deprecate one and 
> > switch existing users as what would neither property present mean?
> 
> I agree, we should not change existng bindings.
> 
> > 
> > Hopefully, documented in input.yaml vs. matrix-keypad.yaml is enough to 
> > say which one is preferred for new users. 
> 
> So this is what I have issue with, as I think it will introduce
> confusion: we have drivers/input/matrix-keymap.c and corresponding
> binding Documentation/devicetree/bindings/input/matrix-keymap.yaml that
> deals with parsing keymap-related properties for various matrix keypads.
> It does not specify autorepeat handling one way or another. Then we have
> drivers/input/keyboard/matrix_keypad.c that is one implementation of
> matrix keypads, and it does have linux,no-autorepeat, but it does not
> mean that other devices resembling matrix keypad are forced to use
> linux,no-autorepeat. And that is why I think putting this property into
> the generic binding
> Documentation/devicetree/bindings/input/matrix-keymap.yaml is not a good
> idea.

You are right. As it looks like there are only 3 users of 
linux,no-autorepeat, we can live with multiple definitions. Looks like 
we have a variety of other autorepeat properties too.

Rob
