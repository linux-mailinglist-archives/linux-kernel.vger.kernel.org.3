Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E714CD5EE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 15:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239811AbiCDOIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 09:08:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239803AbiCDOIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 09:08:12 -0500
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06331B98B4;
        Fri,  4 Mar 2022 06:07:24 -0800 (PST)
Received: by mail-oi1-f176.google.com with SMTP id ay7so7899410oib.8;
        Fri, 04 Mar 2022 06:07:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ri3M9rEvbqOZtQYvLCw0kYxpmzURzsEZbFbaOsupS2s=;
        b=0CxaWSHe0/k/VmyK4TfUy//1oCz9pXmtX26BVk067+I3szWXPdkFvG8xknFlp9CloP
         lVyU2uFWyoCGdUz6Abrs/gbNOJhecef/bsR0EO1YT/QeyAVJiPfbIzLqiqD35AuV+mOw
         /axcDvQh6AK6jhzr0sxOGtSFUiHAEgpYYT7JUmbrCfUW6B+9CpU3hpl9i1NN0WctSEMl
         tlSWLemJIkS0ZxFdyI4CEaNDADjx+6uxjqBOuhhWQcGKkWpWeDYZBQgXuCzGcDPXkpCP
         ppadtwHcWatQx+HKQAKJ2dDxifA357khg+EfG2Z+DirA3hdnPrZ4CUdY9zLO922acopH
         qoYw==
X-Gm-Message-State: AOAM533Q3NOC+OPbgAbg30pn+6Ep5t7ofuV9pJb69JH23MBLI8m0gkjO
        lsdJD0S5ikQSalFYePzo/A==
X-Google-Smtp-Source: ABdhPJyci6UbkOLrwsWccGvun1sxcDyW/kMEWbKggLvHH1s6vVcgxC1dz4Bb6r88ow5hTuC9ncAQmQ==
X-Received: by 2002:a05:6808:d52:b0:2d7:4e5a:6edb with SMTP id w18-20020a0568080d5200b002d74e5a6edbmr9428953oik.131.1646402843673;
        Fri, 04 Mar 2022 06:07:23 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id a27-20020a4ae93b000000b0031be7c7d2d3sm2446568ooe.0.2022.03.04.06.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 06:07:23 -0800 (PST)
Received: (nullmailer pid 3842339 invoked by uid 1000);
        Fri, 04 Mar 2022 14:07:21 -0000
Date:   Fri, 4 Mar 2022 08:07:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <maxime@cerno.tech>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kbuild@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: kbuild: Use DTB files for validation
Message-ID: <YiIdGTcqDyaaC1i9@robh.at.kernel.org>
References: <20220303224237.2497570-1-robh@kernel.org>
 <20220303224237.2497570-3-robh@kernel.org>
 <YiH+Twl8JnwKPv3a@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiH+Twl8JnwKPv3a@pendragon.ideasonboard.com>
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

On Fri, Mar 04, 2022 at 01:55:59PM +0200, Laurent Pinchart wrote:
> Hi Rob,
> 
> Thank you for the patch.
> 
> On Thu, Mar 03, 2022 at 04:42:37PM -0600, Rob Herring wrote:
> > Switch the DT validation to use DTB files directly instead of a DTS to
> > YAML conversion.
> > 
> > The original motivation for supporting validation on DTB files was to
> > enable running validation on a running system (e.g. 'dt-validate
> > /sys/firmware/fdt') or other cases where the original source DTS is not
> > available.
> > 
> > The YAML format was not without issues. Using DTBs with the schema type
> > information solves some of those problems. The YAML format relies on the
> > DTS source level information including bracketing of properties, size
> > directives, and phandle tags all of which are lost in a DTB file. While
> > standardizing the bracketing is a good thing, it does cause a lot of
> > extra warnings and churn to fix them.
> 
> It does indeed, but it's a bit sad to let that feature go :-S

I agree, but I think that checking is better served with a DTS linter.

Rob
