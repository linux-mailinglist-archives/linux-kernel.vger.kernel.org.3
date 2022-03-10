Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 432A54D52E1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 21:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244489AbiCJUKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 15:10:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234539AbiCJUKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 15:10:08 -0500
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A4E377CB;
        Thu, 10 Mar 2022 12:09:06 -0800 (PST)
Received: by mail-oi1-f175.google.com with SMTP id ay7so7113545oib.8;
        Thu, 10 Mar 2022 12:09:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DT1DTT9OY3mpRBjfgDr0/NfpmMBYaGRRhmQt4pBo3Is=;
        b=fgdd1r9K4jLdn155FANxI/+O97uvTrSYnwnAP4ItwSJbWVJsDtqUX1dn2OblZgGWXD
         6xfZNa/Y0y2STx8beSqjNQYnHkY1rlCkguCTgKug/h5vhXZDCYhXGEL1j1nxClMMbb19
         yb4ynDt1j/56FmWVNG6kfWNjU4Ry0WzNqE2LHzSIATkS1z9kJio8VIcOSPGWpqBwBtZt
         kkRIoRNbMNWXLP8qVxY7lsK5EopQtpf+0ryNKeSXCe4G3wTIlgjTS5G/MWgrqI34VZVE
         +oVxRMPDFZVqOhabHBV6tt3LCTlBePF0g/DwzDraZfrFwoEc5JaX95f5AsUxuxn/IMh+
         jTRA==
X-Gm-Message-State: AOAM532jf3PpxhmWK4yMQq+2zEiHz51BakIIVZRz15MHg0tXcyKy5MEs
        c7w3kQwgbZcFWMxC1ypc3w==
X-Google-Smtp-Source: ABdhPJy32wFFo5Lij7JfQ36/sCe7oerWZcH4QewFQn+eq0s0c8ghF/Vg83mOitjDkEKeyoa8PfQkzA==
X-Received: by 2002:a05:6808:1450:b0:2d9:dad1:a14e with SMTP id x16-20020a056808145000b002d9dad1a14emr10660190oiv.294.1646942946292;
        Thu, 10 Mar 2022 12:09:06 -0800 (PST)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a27-20020a4ae93b000000b0031be7c7d2d3sm2938462ooe.0.2022.03.10.12.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 12:09:05 -0800 (PST)
Received: (nullmailer pid 1979373 invoked by uid 1000);
        Thu, 10 Mar 2022 20:09:04 -0000
Date:   Thu, 10 Mar 2022 14:09:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     linuxfancy@googlegroups.com,
        Richard Leitner <richard.leitner@skidata.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: usb: usb251xb: add documentation for
 boost-up property
Message-ID: <Yipa4OLQR0kUctK/@robh.at.kernel.org>
References: <20220306184720.5350-1-tomm.merciai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220306184720.5350-1-tomm.merciai@gmail.com>
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

On Sun, Mar 06, 2022 at 07:47:20PM +0100, Tommaso Merciai wrote:
> Add documentation for the optional property boost-up.
> 
> Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
> ---
>  Documentation/devicetree/bindings/usb/usb251xb.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/usb251xb.txt b/Documentation/devicetree/bindings/usb/usb251xb.txt
> index 1a934eab175e..29b5d6521f3c 100644
> --- a/Documentation/devicetree/bindings/usb/usb251xb.txt
> +++ b/Documentation/devicetree/bindings/usb/usb251xb.txt
> @@ -67,6 +67,8 @@ Optional properties :
>  	power. The value is given in ms in a 0 - 510 range (default is 100ms).
>   - swap-dx-lanes : Specifies the ports which will swap the differential-pair
>  	(D+/D-), default is not-swapped.
> + - boost-up: Property control USB electrical drive strength. There are 4 possible
> +	modes: normal (0x00), low (0x01), medium (0x10), high (0x11). Normal default.

Needs a vendor prefix on the property name.

Rob

>  
>  Examples:
>  	usb2512b@2c {
> -- 
> 2.25.1
> 
> 
