Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E635515849
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 00:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381457AbiD2WV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 18:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357045AbiD2WVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 18:21:54 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953D3C4025;
        Fri, 29 Apr 2022 15:18:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C5119CE333A;
        Fri, 29 Apr 2022 22:18:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ACA9C385A7;
        Fri, 29 Apr 2022 22:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651270712;
        bh=orklPr3chRXd+CkgmB4r2vxYU2PqIaQz0OLUeBUV2jM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=C733QFiM0ygrOsuam42kfCor2Bqic7z4vg6Mx8CnU8qS+SH3VW1NsQfPXVwbGx/2Q
         0hUUD/wImsWL3C1tukw3+9wCQiUzQ4Q230TknKhIl/ZjRHWUuWMKijGWCo9xdudhLW
         B0TB64aBqXoIeJsloUVKnAK2aSgGhyWR9Q/H7S6CIj+Odjns3QrIiJeqtAIoJWERr/
         VQs9yXdfkmUgMzny4EYR7zMteTONnlmibQxsFKizVFTsIgZo8dJhNODcOdvMSdXhNs
         9LsVBeuRK2x6pH//09vz3Fc82keXxEaLemHTEOtkAkkP8PEYsygfGL/zsQEYgHgmpJ
         70Px6RsgQJh3A==
Received: by mail-pj1-f44.google.com with SMTP id qe3-20020a17090b4f8300b001dc24e4da73so230569pjb.1;
        Fri, 29 Apr 2022 15:18:32 -0700 (PDT)
X-Gm-Message-State: AOAM533liUKQ2ZzmFxOqlhIfx58oN2baLIFmLdB08SO4HaS0cbXM65Md
        QNnqUUiXiJs19xoejLN0eZ6vvFMWwY21OF+PaA==
X-Google-Smtp-Source: ABdhPJwJHY+2//c7gdKbC34It8ySf88URcOmVqTdd1A7LDixQZFe61mBCMaEQMuGtI5EpwvQoGcvVSQn2eJ7yJd9qf8=
X-Received: by 2002:a17:902:e481:b0:15c:dc24:64e8 with SMTP id
 i1-20020a170902e48100b0015cdc2464e8mr1414396ple.35.1651270711654; Fri, 29 Apr
 2022 15:18:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220426200741.712842-1-dfustini@baylibre.com> <20220426200741.712842-2-dfustini@baylibre.com>
In-Reply-To: <20220426200741.712842-2-dfustini@baylibre.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 29 Apr 2022 17:18:20 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJqYU891uDex2moe=Q4XsJ4t0dUnCvcpiNBdT5HhZ1dAg@mail.gmail.com>
Message-ID: <CAL_JsqJqYU891uDex2moe=Q4XsJ4t0dUnCvcpiNBdT5HhZ1dAg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: wkup-m3-ipc: Add firmware-name property
To:     Drew Fustini <dfustini@baylibre.com>
Cc:     Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Dave Gerlach <d-gerlach@ti.com>,
        Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Keerthy <j-keerthy@ti.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 3:07 PM Drew Fustini <dfustini@baylibre.com> wrote:
>
> From: Dave Gerlach <d-gerlach@ti.com>
>
> Document that the firmware-name property can be used to indicate a file
> contains I2C sequences for PMIC voltage scaling during deep sleep.
>
> Based on previous work by Russ Dill.
>
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> [dfustini: split from driver patch and convert to json-schema]
> Signed-off-by: Drew Fustini <dfustini@baylibre.com>
> ---
> Changes from v2:
> - fix the property name in this commit message
>
> Changes from v1:
> - change 'ti,scale-data-fw' to 'firmware-name'
> - add 'firmware-name' property to the examples
>
>  .../devicetree/bindings/soc/ti/wkup-m3-ipc.yaml      | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Applied, thanks!
