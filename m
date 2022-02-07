Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340354ACA68
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 21:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242326AbiBGU1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 15:27:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232631AbiBGUYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 15:24:24 -0500
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73FCC0401DA;
        Mon,  7 Feb 2022 12:24:23 -0800 (PST)
Received: by mail-ot1-f51.google.com with SMTP id w27-20020a9d5a9b000000b005a17d68ae89so11720869oth.12;
        Mon, 07 Feb 2022 12:24:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EFWtFTnJpSwgLhq6r6w4pljMn11UZ/W2WRxEYkJ+EFo=;
        b=EWQYWDvMP14NMq9n9nT2w0JNJOKihtGznqMZHqLmgc2GI2r07Wx+d/ZEZnmhOPtIMk
         LWqwsCXx1KfgMp60WtJ3DFBGUsXkGHo8sPpzDn1+FtPYuDoLY/3NDrS51w2m0XngiNoR
         wPA4kubFYLDH0WfrN+NI1KaDANN75+bjcOE76QoLyxzB7eC5Ca7VgnsRcUeASwX8/yq+
         5MllNMpsy0G3VuRw9pvefvWnqhUFNANPHaQxtuC312R+K0MzNW0Nws6eViAizdO4+wRb
         ePqCvG6F+uBaMW2AAsyU4Qi8wffMK2V3hdzrD1P6U6KvQfLSzN9lsJif74al3l7OOX1/
         dECA==
X-Gm-Message-State: AOAM531r/GHZpkl+DAUUyEtTafBdCOIwRiy7F0S1bMYM4an5Rj/5f1F3
        fuS/09ZxqICGhyax1Ig6OA==
X-Google-Smtp-Source: ABdhPJzIJJnRLqMqAko/qcvW1Ml8GLbpjAmJwz23gPjyPp+3wC0WwIXhPvIoYhJfcemgMiOGVIFG9g==
X-Received: by 2002:a9d:6d07:: with SMTP id o7mr609746otp.363.1644265463239;
        Mon, 07 Feb 2022 12:24:23 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id c6sm4282542ooo.19.2022.02.07.12.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 12:24:22 -0800 (PST)
Received: (nullmailer pid 846789 invoked by uid 1000);
        Mon, 07 Feb 2022 20:24:21 -0000
Date:   Mon, 7 Feb 2022 14:24:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sander Vanheule <sander@svanheule.net>
Cc:     John Crispin <john@phrozen.org>, Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Bert Vermeulen <bert@biot.com>,
        Birger Koblitz <mail@birger-koblitz.de>
Subject: Re: [PATCH v4 1/3] dt-bindings: interrupt-controller:
 realtek,rtl-intc: require parents
Message-ID: <YgF/9bUh5WOjbd1e@robh.at.kernel.org>
References: <cover.1644165421.git.sander@svanheule.net>
 <d1920b7b0b882512e628b4e4e93fa8fef1b5364a.1644165421.git.sander@svanheule.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1920b7b0b882512e628b4e4e93fa8fef1b5364a.1644165421.git.sander@svanheule.net>
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

On Sun, 06 Feb 2022 17:41:51 +0100, Sander Vanheule wrote:
> The interrupt router has 32 inputs, and up to 15 outputs connected to
> the MIPS CPU's interrupts. The way these are mapped to each other is
> runtime configurable. This controller can also mask individual interrupt
> sources, and has a status register to indicate pending interrupts. This
> means the controller is not transparent, and the use of "interrupt-map"
> inappropriate. Instead, a list of parent interrupts should be specified.
> 
> Two-part compatibles are introduced to be able to require "interrupts"
> for new devicetrees. The relevant descriptions are extended or added to
> more clearly describe the functionality of this controller. The old
> compatible, with "interrupt-map" and "#address-cells", is deprecated.
> Interrupt specifiers for new compatibles will require two cells, to
> indicate the output selection.
> 
> To prevent spurious changes to the binding when more SoCs are added,
> "allOf" is used with one "if", and the compatible enum only has one
> item.
> 
> The example is updated to provide a correct example for RTL8380 SoCs.
> 
> Signed-off-by: Sander Vanheule <sander@svanheule.net>
> ---
> Changes in v4:
> - Indicate more clearly that the controller is not transparent.
> ---
>  .../realtek,rtl-intc.yaml                     | 82 ++++++++++++++-----
>  1 file changed, 62 insertions(+), 20 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
