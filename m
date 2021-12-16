Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF60A4773AC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 14:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237251AbhLPNxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 08:53:13 -0500
Received: from mail-oo1-f42.google.com ([209.85.161.42]:43007 "EHLO
        mail-oo1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237025AbhLPNxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 08:53:09 -0500
Received: by mail-oo1-f42.google.com with SMTP id x1-20020a4aea01000000b002c296d82604so6928765ood.9;
        Thu, 16 Dec 2021 05:53:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=B88CYCFjwbaWOV3vKfQzOmcTf0Xm8Ner9hfCDTZa+HE=;
        b=NhS9WWhux7zSbGnd4Iea3XGwiaR5Bz4gYyTIweGiblvgObOHxGLVKZs/1WXVzsW7Xw
         Cpq8OBVT9qVT5nVKSjCm/sZl+uk9+7tbzFTm3s5DfwThE4PRMl9vDOpt8qPCC2KE9Tw8
         9CoFMWcSfCfmPv84fEEYD++0fOwzilnbn9J78nkBzXdB0JnqM1ZBGyO+ilJ/1fWzV8i2
         WjCjGkVKMLE6XslKY0WHqaFLwAjVj2qJ2+beRwFyTgs7KNBeLk9KjFlobRqOm//55fLH
         lkHxpcX0Fnzh9l7pXrLZDbJj8NifYmU57qQoaDeXGqM/44GIeb/1jVxEziPn9ATklEDY
         ipnA==
X-Gm-Message-State: AOAM530a1DIUTBjW89IPBTnprjK4uDuGbRpmh2RwaxEChFyuDOeyvNjt
        ibpAiLPcge005wwrQilfzg==
X-Google-Smtp-Source: ABdhPJwrH3DI4/PnTg5MUfd+8UPsCHqVPUfNp95zLksVPxxuQvXT1eDHD1ytbHjBZzQhv38LlZDOiQ==
X-Received: by 2002:a4a:5a43:: with SMTP id v64mr11106831ooa.26.1639662789088;
        Thu, 16 Dec 2021 05:53:09 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id p10sm1034054otp.53.2021.12.16.05.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 05:53:08 -0800 (PST)
Received: (nullmailer pid 4004887 invoked by uid 1000);
        Thu, 16 Dec 2021 13:53:03 -0000
From:   Rob Herring <robh@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-rockchip@lists.infradead.org,
        Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>,
        benjamin.gaignard@collabora.com,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        aford@beaconembedded.com, Lucas Stach <l.stach@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        Fabio Estevam <festevam@gmail.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        abel.vesa@nxp.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, hverkuil-cisco@xs4all.nl
In-Reply-To: <20211216111256.2362683-5-aford173@gmail.com>
References: <20211216111256.2362683-1-aford173@gmail.com> <20211216111256.2362683-5-aford173@gmail.com>
Subject: Re: [PATCH V2 04/10] dt-bindings: media: nxp,imx8mq-vpu: Split G1 and G2 nodes
Date:   Thu, 16 Dec 2021 07:53:03 -0600
Message-Id: <1639662783.022719.4004886.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Dec 2021 05:12:49 -0600, Adam Ford wrote:
> The G1 and G2 are separate decoder blocks that are enabled by the
> vpu-blk-ctrl power-domain controller, which now has a proper driver.
> Update the bindings to support separate nodes for the G1 and G2
> decoders with vpu-blk-ctrl power-domain support.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/media/nxp,imx8mq-vpu.yaml:18:6: [warning] wrong indentation: expected 4 but found 5 (indentation)
./Documentation/devicetree/bindings/media/nxp,imx8mq-vpu.yaml:19:7: [warning] wrong indentation: expected 7 but found 6 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1569050

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

