Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078DD4C2D1B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 14:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234999AbiBXNdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 08:33:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235117AbiBXNdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 08:33:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F163D4B9;
        Thu, 24 Feb 2022 05:32:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1D7B6B81878;
        Thu, 24 Feb 2022 13:32:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1B80C340EC;
        Thu, 24 Feb 2022 13:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645709549;
        bh=SgGMnecg09ErfQo6Q/uEdth6PBMve0iYq5uuAS6ZHec=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=R32dRsAuPBg7Uhg5NEFR8h9XAqTdWzDOdgAkVtQiF4rWxCzfY81enVna8jwBN6cpo
         XF3BfMPiU3nRJg8uWUlb2vGSPtsNSAms3F7fhEyGhkEJqTMsMAPmMtz36XwOcLN0oT
         QCjLlQVNBSP48Vp0OlBLpZjludQd8DETTPybCHmoXiMnJyYSClaqVxky/85ZTBfIez
         7jRXepjuLErrD7PtJFwMumrfly5VlSSEMP66jOZyWXjsZbZBCxIoNGbmYUEpBxhLHa
         1qlCWyxskSTwYxjNLy9lfhMqkgkJSd9ZxWaK74+EptwiggV87RyNCL4PC1gv+8Bggk
         8QT6sziDB3wSA==
Received: by mail-ej1-f50.google.com with SMTP id lw4so4311526ejb.12;
        Thu, 24 Feb 2022 05:32:29 -0800 (PST)
X-Gm-Message-State: AOAM530O7TrH/YNBZoh0T/A3pEf96nEvRYSiGjWQ2QHJ1u0EMsHXpMv+
        wj03PSLiin0ekLrNSO919jgqzLEl3jhNNt0XqA==
X-Google-Smtp-Source: ABdhPJxaf0MKZ4M+LqN3z5YECxlhfw3GLarZPyG5domGJgD4pARWd/0ZP19xXsIyyHfbWq5bBwG8Q4xGGXnzV11I0y0=
X-Received: by 2002:a17:906:f6d9:b0:6ce:e7d:5f3a with SMTP id
 jo25-20020a170906f6d900b006ce0e7d5f3amr2260021ejb.20.1645709547978; Thu, 24
 Feb 2022 05:32:27 -0800 (PST)
MIME-Version: 1.0
References: <1640164346-26818-1-git-send-email-vincent.sunplus@gmail.com> <1640164346-26818-3-git-send-email-vincent.sunplus@gmail.com>
In-Reply-To: <1640164346-26818-3-git-send-email-vincent.sunplus@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 24 Feb 2022 07:32:16 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJK2ka8H_RzjYfBW9UXn9Q9DCnZC3Mdo66XSsk4=ZcEzA@mail.gmail.com>
Message-ID: <CAL_JsqJK2ka8H_RzjYfBW9UXn9Q9DCnZC3Mdo66XSsk4=ZcEzA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] dt-bindings: nvmem: Add bindings doc for Sunplus
 OCOTP driver
To:     Vincent Shih <vincent.sunplus@gmail.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        =?UTF-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>,
        Vincent Shih <vincent.shih@sunplus.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 3:12 AM Vincent Shih <vincent.sunplus@gmail.com> wrote:
>
> Add bindings doc for Sunplus OCOTP driver
>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Vincent Shih <vincent.sunplus@gmail.com>
> ---
> Changes in v3
>  - No change
>
>  .../bindings/nvmem/sunplus,sp7021-ocotp.yaml       | 86 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 87 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/sunplus,sp7021-ocotp.yaml

This is now failing in linux-next:

/builds/robherring/linux-dt/Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.example.dt.yaml:
spi@9C002D80: 'clocks-names' is a required property
From schema: /builds/robherring/linux-dt/Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml
Documentation/devicetree/bindings/nvmem/sunplus,sp7021-ocotp.example.dts:19:18:
fatal error: dt-bindings/clock/sp-sp7021.h: No such file or directory
   19 |         #include <dt-bindings/clock/sp-sp7021.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.

Please send a fix ASAP.

Rob
