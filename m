Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB4A4BAD70
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 00:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiBQXwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 18:52:05 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:55900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiBQXwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 18:52:03 -0500
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051C53151E;
        Thu, 17 Feb 2022 15:51:48 -0800 (PST)
Received: by mail-io1-f45.google.com with SMTP id r7so235899iot.3;
        Thu, 17 Feb 2022 15:51:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VPqLTBNPDYhEbgZt/YdvKKlTQpPFS9QLFLj/eqQJfu0=;
        b=lX8Zljn9mAPbtcGw+jIEjRcYIFbfBHiGjlKHdvzlmk7E7n92Zc7UUk00oFCS4Th3Kn
         IbwauIKUzQb1eOpZqIjYN29SxdLskI7L7nQQd+rgpTZujSUtONpJkF1PiHMwz1PbhKya
         LGHrWcwd2qXGLlBp+AnHOMs5F3xhJS80HlzH6UgETRXWUyI6Agd8yh2QcjleSZPHHxkq
         bwp3q8w2O5GoI8hgZO/4t/Ob1Apg6gDwisJ7yp9FYZaofls54G8YEhfeYNWLfN3/OIao
         MOEwx/oTtDGg9Zxa/otQs9Z8+p/CFjGcHoNVZeyOYdDFh6wS3Ut0K6jpINiBUsB0Eqn4
         pEdg==
X-Gm-Message-State: AOAM530TFvO5Z1UfIvkbupdg+eZ4eQb+MI4Ex8BTA2qMnpfdQq3TFQB0
        yekfI7Q1Aey4hFUkboM8Td5mfDJrXQ==
X-Google-Smtp-Source: ABdhPJxnkBwBCsnctqo57J95u71yi9llEbgOjpOUuIN18GpsnSf52LyI6k4cwm2+E3jtbV1xtG/w0g==
X-Received: by 2002:a02:c953:0:b0:314:3463:f725 with SMTP id u19-20020a02c953000000b003143463f725mr3395005jao.275.1645141101018;
        Thu, 17 Feb 2022 15:38:21 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id h8sm2542911ile.22.2022.02.17.15.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 15:38:20 -0800 (PST)
Received: (nullmailer pid 3985592 invoked by uid 1000);
        Thu, 17 Feb 2022 23:38:17 -0000
Date:   Thu, 17 Feb 2022 17:38:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Maxime Ripard <mripard@kernel.org>,
        linux-kernel@vger.kernel.org, Samuel Holland <samuel@sholland.org>,
        Ondrej Jirman <megous@megous.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v10 11/18] dt-bindings: usb: Add H616 compatible string
Message-ID: <Yg7cadPGUwbiOk/K@robh.at.kernel.org>
References: <20220211122643.1343315-1-andre.przywara@arm.com>
 <20220211122643.1343315-12-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211122643.1343315-12-andre.przywara@arm.com>
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

On Fri, 11 Feb 2022 12:26:36 +0000, Andre Przywara wrote:
> The Allwinner H616 contains four fully OHCI/EHCI compatible USB host
> controllers, so just add their compatible strings to the list of
> generic OHCI/EHCI controllers.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  Documentation/devicetree/bindings/usb/generic-ehci.yaml | 1 +
>  Documentation/devicetree/bindings/usb/generic-ohci.yaml | 1 +
>  2 files changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
