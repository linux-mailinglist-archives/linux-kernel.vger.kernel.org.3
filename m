Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D47548DBC5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 17:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236695AbiAMQ3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 11:29:41 -0500
Received: from mail-oi1-f173.google.com ([209.85.167.173]:45761 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236675AbiAMQ3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 11:29:40 -0500
Received: by mail-oi1-f173.google.com with SMTP id t9so8312525oie.12;
        Thu, 13 Jan 2022 08:29:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=HPY1d3LBzusi60LPkFQAJPHyy0tMLA3KHv2rcOpufdU=;
        b=hXLXs1KuTXHLZdSctoA8pcmaWayU7uuNZNbTAFGFaYbczHMlnRsPRJSpZ/LW8JPv4e
         MhHjx/4gVfk1f/cGvoz4hJh0l6K08B4pmRzSDqsceGiD4QGxo2Mhpp4h2Eb5kJDtXZym
         8VMFv86SaWAXh5PbgCeUjEHfJkEAPO9S8jsk1IW3r1VzGjFlckDx37AfBjcluZgLmXce
         b4tARyhXuWdBcdVScSsoRairJl2nd7GoRt9TxUrc2mVzDTx0LKFLjbUFSKiwK1y0upb1
         aYGZIh52LxV1xSBzpZu5FJYC8GpQ5N62eCc0eRoyKAz/suq2uTviiaKDfseiVnffuvks
         jvOw==
X-Gm-Message-State: AOAM532lvcc6uRB6PitL60ilErpZoxXX04PAa489hJcVBK0WuNV5uZ9d
        dP9P6+myAFd9ABQQscII4g==
X-Google-Smtp-Source: ABdhPJyTYyL8a/znyc0/EIpQtk1tXZE428dMD1N++wlm/cG2UjCETDsuEpTGIHZimgJsHIucC3Wlaw==
X-Received: by 2002:a54:4588:: with SMTP id z8mr5113850oib.108.1642091379811;
        Thu, 13 Jan 2022 08:29:39 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id t15sm569504otc.17.2022.01.13.08.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 08:29:39 -0800 (PST)
Received: (nullmailer pid 3647185 invoked by uid 1000);
        Thu, 13 Jan 2022 16:29:34 -0000
From:   Rob Herring <robh@kernel.org>
To:     Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
Cc:     linux-rpi-kernel@lists.infradead.org, kernel-list@raspberrypi.com,
        linux-kernel@vger.kernel.org, naush@raspberrypi.com,
        dave.stevenson@raspberrypi.com,
        linux-arm-kernel@lists.infradead.org, mchehab@kernel.org,
        laurent.pinchart@ideasonboard.com, lukasz@jany.st,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20220112172719.1178446-2-jeanmichel.hautbois@ideasonboard.com>
References: <20220112172719.1178446-1-jeanmichel.hautbois@ideasonboard.com> <20220112172719.1178446-2-jeanmichel.hautbois@ideasonboard.com>
Subject: Re: [RFC PATCH 1/3] media: dt-bindings: media: Add bindings for bcm2835-unicam
Date:   Thu, 13 Jan 2022 10:29:34 -0600
Message-Id: <1642091374.239763.3647184.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jan 2022 18:27:18 +0100, Jean-Michel Hautbois wrote:
> Introduce the dt-bindinds documentation for bcm2835 CCP2/CSI2 camera
> interface. Also add a MAINTAINERS entry for it.
> 
> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> Signed-off-by: Naushir Patuck <naush@raspberrypi.com>
> Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
> ---
> Dave: I assumed you were the maintainer for this file, as I based it on the
> bcm2835-unicam.txt file. Are  you happy to be added directly as the
> maintainer, or should this be specified as "Raspberry Pi Kernel
> Maintenance <kernel-list@raspberrypi.com>"
> ---
>  .../bindings/media/brcm,bcm2835-unicam.yaml   | 103 ++++++++++++++++++
>  MAINTAINERS                                   |   6 +
>  2 files changed, 109 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/brcm,bcm2835-unicam.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/media/brcm,bcm2835-unicam.example.dts:24.31-32 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:373: Documentation/devicetree/bindings/media/brcm,bcm2835-unicam.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1413: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1579262

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

