Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5204AFFC0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 23:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234598AbiBIV7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 16:59:48 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:55650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234785AbiBIV7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 16:59:34 -0500
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F33E01CC9C;
        Wed,  9 Feb 2022 13:59:09 -0800 (PST)
Received: by mail-oi1-f182.google.com with SMTP id q8so3983443oiw.7;
        Wed, 09 Feb 2022 13:59:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=z8KVjJ5YMZsWj0+qXpyhv4FVnHtYHJwMnCI4kKdn1H8=;
        b=FfgvyvH8waUztJp5elCJtjqMsqZI8xFhplOQHoliDK8sbPY3VGHKPyh45ho8UTKGke
         ZwXHKompjqdG7wWNKWuRfSzqXI7xzcyDATlgl5jAwyNbcdO0jL3TrU4S1szcKUnz4+Si
         1zu0yGCl7RKjgE323GmM2NDLIAtpwgfvifY5qoajfR/pNEiNZAbp/ZQSNFZCbRP/o36i
         BrmKk0x+pZpC4DPj8gcHvm+qOnymeiAHrZomd8qfKVAmZfESFAZXXXpo0LPvwaRgRPr3
         u/iMlQsvLiK9bM/sxSqLv4pNaZp5kCdn5kqcllunxhqPN2OO7lDOIUOfjDFdU0MWPKHx
         szlw==
X-Gm-Message-State: AOAM533KzBWNm51GPUJp+UzRORmM3QXgAiMKPAilnFSxN46cEJVXRRV9
        dcQ7EVhsyLExI5uZDDrA5g==
X-Google-Smtp-Source: ABdhPJzOpApcPzhvNaWeRS6CJQZPcBE3aZneE7hwOHcT25g1OIsY37b5DUDUfwJaU9NCShY3TF3OoQ==
X-Received: by 2002:a05:6808:99b:: with SMTP id a27mr2435308oic.299.1644443948582;
        Wed, 09 Feb 2022 13:59:08 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id y2sm3219696oao.10.2022.02.09.13.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 13:59:07 -0800 (PST)
Received: (nullmailer pid 1001493 invoked by uid 1000);
        Wed, 09 Feb 2022 21:59:06 -0000
Date:   Wed, 9 Feb 2022 15:59:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 2/4] dt-bindings: usb: Add WUSB3801 Type-C Port
 Controller
Message-ID: <YgQ5KrP52+eCFD8X@robh.at.kernel.org>
References: <20220202221948.5690-1-samuel@sholland.org>
 <20220202221948.5690-3-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202221948.5690-3-samuel@sholland.org>
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

On Wed, 02 Feb 2022 16:19:45 -0600, Samuel Holland wrote:
> Add devicetree support for the Will Semiconductor WUSB3801. This is a
> basic non-PD Type-C port controller.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
> (no changes since v1)
> 
>  .../bindings/usb/willsemi,wusb3801.yaml       | 75 +++++++++++++++++++
>  1 file changed, 75 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/willsemi,wusb3801.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
