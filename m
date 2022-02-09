Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 085124AFC32
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 19:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241571AbiBIS5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 13:57:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241326AbiBIS4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 13:56:48 -0500
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1104FC050CF8;
        Wed,  9 Feb 2022 10:56:05 -0800 (PST)
Received: by mail-oo1-f41.google.com with SMTP id u25-20020a4ad0d9000000b002e8d4370689so3504886oor.12;
        Wed, 09 Feb 2022 10:56:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U1a6J1Ei0HXyrs5g5n3HqCU8XGgHDhvfeppc0HOYcD4=;
        b=gt3UtY37iC64UICYxNCT8l6JlQ/efR3xZAr5jhvX9mZiV6glqkpW2GpelKimZYeody
         g6hMo7kFrtAgzx9eHCj2Jkr2GAfrdf+BBMTfBxJnc1Sxjrjb3xQquGio6dXPGlDHZEbW
         zKoVMmcs6ab5HIIHlIPi50zxSJP4aIzLzKoAS8f4L4Cf95sXdAkrdTnn+B8J6UWjFE69
         MjWduVo/ZuzDEEZzUaL3OYiKSQRrForDpVMtDLtnha8pEdCrx9kIkLwOL+X9wdoOQS1n
         BMTMenDPUAJBV1vUR6T/ktNQueZA7/XW3Nm5UvhcucJyfB4JWrUUYPhKGwHOy8EVDfDQ
         qfbA==
X-Gm-Message-State: AOAM531kCxXk/mosNElg4CFIc3CO8y3fsEomr6mOEFuV4CGVR9f9y0VN
        OOcUdNlnYma2XUZp7lrfTQ==
X-Google-Smtp-Source: ABdhPJyvDSkFU1hxl/DhxagKGRQyWKE93eZjYQ3eZApgX/m0JXhMm6dM/Ah+IGAufOFalmSRhA1enw==
X-Received: by 2002:a05:6870:c7a9:: with SMTP id dy41mr1296625oab.137.1644432964382;
        Wed, 09 Feb 2022 10:56:04 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id ay42sm7402537oib.5.2022.02.09.10.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 10:56:03 -0800 (PST)
Received: (nullmailer pid 689284 invoked by uid 1000);
        Wed, 09 Feb 2022 18:56:02 -0000
Date:   Wed, 9 Feb 2022 12:56:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
Cc:     kernel-list@raspberrypi.com, tomi.valkeinen@ideasonboard.com,
        dave.stevenson@raspberrypi.com, devicetree@vger.kernel.org,
        laurent.pinchart@ideasonboard.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mchehab@kernel.org, naush@raspberrypi.com, stefan.wahren@i2se.com,
        bcm-kernel-feedback-list@broadcom.com, lukasz@jany.st,
        linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH v5 03/11] dt-bindings: media: Add bindings for
 bcm2835-unicam
Message-ID: <YgQOQneSD3+9eS37@robh.at.kernel.org>
References: <20220208155027.891055-1-jeanmichel.hautbois@ideasonboard.com>
 <20220208155027.891055-4-jeanmichel.hautbois@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208155027.891055-4-jeanmichel.hautbois@ideasonboard.com>
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

On Tue, 08 Feb 2022 16:50:19 +0100, Jean-Michel Hautbois wrote:
> Introduce the dt-bindings documentation for bcm2835 CCP2/CSI2 Unicam
> camera interface.
> 
> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> Signed-off-by: Naushir Patuck <naush@raspberrypi.com>
> Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> ---
> v4:
> - make MAINTAINERS its own patch
> - describe the reg and clocks correctly
> - use a vendor entry for the number of data lanes
> ---
>  .../bindings/media/brcm,bcm2835-unicam.yaml   | 117 ++++++++++++++++++
>  1 file changed, 117 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/brcm,bcm2835-unicam.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
