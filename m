Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58AE7561B43
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 15:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235077AbiF3N0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 09:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiF3N0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 09:26:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99EF53123C;
        Thu, 30 Jun 2022 06:26:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 46AF5B827E3;
        Thu, 30 Jun 2022 13:26:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0253C341CC;
        Thu, 30 Jun 2022 13:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656595563;
        bh=f1AhAEbtOQpKJYZkVMkLIr2pWM9nsIVxDq9aRJR/hYw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HjE4PD4jHcuAbPNQVuK/DimREx0njb1vMNpOmDmzZUTOkxk9ga/W/xctR4bJQy+Bm
         iMxIacFW8uaeKBNdy6VGOjebwnJeLyv8YsxT9M36utpXR0mJKVb9nZVpglKwfxtXlV
         Aihjr5IL/Pt5lSOr/ThJEaNI9KXNmqR8eXutv3kvmHEaz6LIL+UxV/O5ruBpnamBlL
         s2pN2dUKoZYYc7lKeAzqBD/muBOmQarggYHSPp/v1V8BIb0Dr7fT/qrg1yH1hWpPCN
         gUV2PPU0Crhow7wSCZ5blo/qWsFo37Hdm1J4np9n9RvL1pBVK5V7l2Z6evhreKeFnb
         F2q71K1LmuTPA==
Received: by mail-ua1-f48.google.com with SMTP id x21so6941625uat.2;
        Thu, 30 Jun 2022 06:26:02 -0700 (PDT)
X-Gm-Message-State: AJIora/X5HexBOMnKDzLzN5857FSEeyyHdKtIh48p1ZAPd8xDMWHeR8g
        i+XVvAJXNa/DXtP030kwwzF75tF7+JnWsr9rRA==
X-Google-Smtp-Source: AGRyM1u2FAdt1MdyKTOx7+K3CIj35ka7dcgH3rANVgZR2hKk8wO2rrhAVvOcMBkWDHtTJi4+RvoitfZzKWAXUJ+yRRM=
X-Received: by 2002:ab0:244f:0:b0:37f:2985:e620 with SMTP id
 g15-20020ab0244f000000b0037f2985e620mr4593945uan.36.1656595561967; Thu, 30
 Jun 2022 06:26:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220630173801.41bf22a2@canb.auug.org.au> <Yr14AyVYbhjmRa+b@debian.me>
In-Reply-To: <Yr14AyVYbhjmRa+b@debian.me>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 30 Jun 2022 07:25:50 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+BRV1vJ+kQ3mA9Ks-mMpub+vexXUD7oDUu1OmsKeXAXA@mail.gmail.com>
Message-ID: <CAL_Jsq+BRV1vJ+kQ3mA9Ks-mMpub+vexXUD7oDUu1OmsKeXAXA@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the coresight tree
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 4:16 AM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> On Thu, Jun 30, 2022 at 05:38:01PM +1000, Stephen Rothwell wrote:
> > Hi all,
> >
> > After merging the coresight tree, today's linux-next build (htmldocs)
> > produced this warning:
> >
> > Documentation/trace/coresight/coresight.rst:133: WARNING: Inline emphasis start-string without end-string.
> >
> > Introduced by commit
> >
> >   3c15fddf3121 ("dt-bindings: arm: Convert CoreSight bindings to DT schema")
> >
>
> I have sent the fix at [1]. Thanks.
>
> [1]: https://lore.kernel.org/linux-doc/20220630101317.102680-1-bagasdotme@gmail.com/

Thanks!

Rob
