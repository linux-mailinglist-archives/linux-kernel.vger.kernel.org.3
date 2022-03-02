Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4EC74CB19A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 22:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245430AbiCBVzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 16:55:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235341AbiCBVzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 16:55:07 -0500
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7C35C863;
        Wed,  2 Mar 2022 13:54:23 -0800 (PST)
Received: by mail-oi1-f175.google.com with SMTP id z7so3071483oid.4;
        Wed, 02 Mar 2022 13:54:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FT7qXkd3XFxv8GYIIHo4RitAFBU5L9E0sYaLEAc3SV8=;
        b=UpGheuEchrK5bQWBykeuE0tbdAOXXV7sNmsdp4zr2p8nWdGdZ2kTAaAUTWo1Lo1Ik8
         Qw49U2lD+DKvP0jLWcmNr4lj2ry3B517UfdO1DL6wNIHcw4NaOECD7RHq4SJcGqiDGcz
         vmiM1Kabu7HsiW99EP3kXuDrqj6TkA9vgyjE/WK8xuU5a80UaqLeDxFgZtU2gnQJpYxF
         0RjkQrSqQuRzjKrYtwgYiBjyGyTbOjpO2TtHlQoCVBZ0dqrJuoha7EkcXt8RCKDl6j2U
         BsDXyFf++IVPe8Z+RDH49qCCvYjpwYlgF3FGVQ5M5RcEaW34G3uM1iD2N2AlHS948VhP
         mhmw==
X-Gm-Message-State: AOAM531Ah8jDEAP9kbfYSokfP6JfoYwHCp6qQCnyLP3e6mY9QxDC1xjc
        mC56kog8I+uy6wYZcwLZxw==
X-Google-Smtp-Source: ABdhPJxECvNsWJt/n5xjiUpSjwKgUMd5ZuCLEID3xAjfwZicO5bFYzbFaHZ+FJejuPb9qOGrg3tA6Q==
X-Received: by 2002:a05:6808:179b:b0:2d9:6b9b:b24e with SMTP id bg27-20020a056808179b00b002d96b9bb24emr1770709oib.149.1646258062522;
        Wed, 02 Mar 2022 13:54:22 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id i2-20020a056870c1c200b000d7355852b3sm172623oad.19.2022.03.02.13.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 13:54:21 -0800 (PST)
Received: (nullmailer pid 125552 invoked by uid 1000);
        Wed, 02 Mar 2022 21:54:20 -0000
Date:   Wed, 2 Mar 2022 15:54:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tzung-Bi Shih <tzungbi@google.com>
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        bleung@chromium.org, linux-kernel@vger.kernel.org,
        chrome-platform@lists.linux.dev, groeck@chromium.org
Subject: Re: [PATCH 3/5] dt-bindings: add google,cros-kbd-led-backlight
Message-ID: <Yh/njNrNgy+MWtz0@robh.at.kernel.org>
References: <20220214053646.3088298-1-tzungbi@google.com>
 <20220214053646.3088298-4-tzungbi@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214053646.3088298-4-tzungbi@google.com>
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

On Mon, 14 Feb 2022 13:36:44 +0800, Tzung-Bi Shih wrote:
> Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
> ---
>  .../chrome/google,cros-kbd-led-backlight.yaml | 35 +++++++++++++++++++
>  .../bindings/mfd/google,cros-ec.yaml          |  3 ++
>  2 files changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/chrome/google,cros-kbd-led-backlight.yaml
> 

Acked-by: Rob Herring <robh@kernel.org>
