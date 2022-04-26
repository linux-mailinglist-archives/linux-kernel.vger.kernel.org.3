Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64C1651024F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352658AbiDZP7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352662AbiDZP7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:59:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABA22FFFD;
        Tue, 26 Apr 2022 08:56:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2DA4DB820FF;
        Tue, 26 Apr 2022 15:56:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2A60C385AD;
        Tue, 26 Apr 2022 15:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650988565;
        bh=jL8Ex0fFj0YQ29/kq6HIIyXXk31sQ5fVS9jJUlgyQYg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=h8uFtL2NRwf0wz0eJdckSNfqFs1/O4WkdQLeFybJqG0SJWTriRShVdx9ivPwqlMnD
         aqX/uR55ROjFTxtARYEG6I0MwecElu32QE7oyTGEej79CbIWVfcUk69fg5dxuJ1dH6
         9WRiLDrdL+a8wIO1osIAyHmcQg73cx46fZNOK6v+z1dolhLX9syi8eKcp6181R40mg
         4Hf6AURPLFUd6M/eIrBABJ0CsupujGZQUtOLDa3tyD2SL8iaZfmQ0EQfwnvVST6sy2
         99Mr6uEcI1m19nPtsXxKA3qcQYawNNkDeV2low4iY912YAEymlb0Nxx8H3TfaZItmU
         am7vguinoEaoQ==
Received: by mail-pf1-f179.google.com with SMTP id j6so16031118pfe.13;
        Tue, 26 Apr 2022 08:56:05 -0700 (PDT)
X-Gm-Message-State: AOAM533g9gujNterBrR7MBR0Pe3d2vrZMbyTK1KmKCJ5kLPzph7wrtSO
        /1oXhgegjRou+kOeVdGA1F+THZZmtIqcPBYd6Q==
X-Google-Smtp-Source: ABdhPJzLlZRUfNOlW5FmxSJSpSkDcigzW7l4BJxuI87gnr9YrF5DfB5aNMdjDW4heZdFNZudm/CVIE4KbMlA9c8qj3o=
X-Received: by 2002:a63:88c8:0:b0:3ab:1871:13b4 with SMTP id
 l191-20020a6388c8000000b003ab187113b4mr12703553pgd.85.1650988565492; Tue, 26
 Apr 2022 08:56:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220426022413.885092-1-jerry.huang@nxp.com>
In-Reply-To: <20220426022413.885092-1-jerry.huang@nxp.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 26 Apr 2022 10:55:53 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLkUaNpxm0R15Yy7aTjOwK-+Y+o0h9p-kSwSHHyicCKBQ@mail.gmail.com>
Message-ID: <CAL_JsqLkUaNpxm0R15Yy7aTjOwK-+Y+o0h9p-kSwSHHyicCKBQ@mail.gmail.com>
Subject: Re: [PATCH 1/3 v5] dt-bindings: dspi: added for MikcroBus socket
To:     Changming Huang <jerry.huang@nxp.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Yang-Leo Li <leoyang.li@nxp.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 9:24 PM Changming Huang <jerry.huang@nxp.com> wrote:
>
> Signed-off-by: Changming Huang <jerry.huang@nxp.com>
> ---
> changes in v5:
>   - rename compatible name to mikcroe,mikcroe-socket

This is not right. The mikrobus socket is more than just SPI which was
already pointed out. I also sketched out how I think it needs to look.
Maybe it ends up looking a bit different, but fundamentally, how you
remap I2C, SPI, GPIO, PWM, etc. thru a connector in order to have
overlays which are independent of the base platform has to be solved.
So far, we have done interrupts and GPIOs.

Rob
