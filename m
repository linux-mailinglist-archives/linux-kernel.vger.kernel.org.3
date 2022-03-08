Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2155B4D0D5C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 02:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243176AbiCHBPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 20:15:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242880AbiCHBPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 20:15:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995FC366AA;
        Mon,  7 Mar 2022 17:14:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E47D66147F;
        Tue,  8 Mar 2022 01:14:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5078EC340F3;
        Tue,  8 Mar 2022 01:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646702062;
        bh=1qglWE6Qyntp4+5iBqYJn9FSC7zLrYE2uBaysE+LVpo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ln45tEvKKN7bmzDSLbiFD4I3kG6fo2hX5nwyoCraisBoIuyAQTYL6e7eRnT7Yld/U
         xwaRL3SqHpiXxEWzdg8SyfE5G0qrZFkO860eujO98yaAFvsPLigWRD0mUj5vU2WgxX
         YnknDPrv1D9uaOHjqz9rCuyjiYDInAhddeo8Wqdoh4loc6HcKU3aKLUj1mfI5diehG
         Fq7n1pSvwaVa1OoOBazxOSRHi6V8ZxPiulzMEGL9m9CjuqVv0ilDwipH79zq6nNse9
         tMsr91B8Vk3XQrOxDRQ4xkNpk21ktoupJSZkHsahjcHZibowtcSCh2RPvJdC7aeblC
         drPrlW/BEq2eQ==
Received: by mail-ej1-f48.google.com with SMTP id d10so35746342eje.10;
        Mon, 07 Mar 2022 17:14:22 -0800 (PST)
X-Gm-Message-State: AOAM532yLXRZbB5vMZFxR/jiyd9vLFQND8BQxDjc0AVHyCGq1XYmtLMx
        SrsZi87bwt25rWIQOec4uIn/G6pvPLDT+NsTmA==
X-Google-Smtp-Source: ABdhPJyDHQjQfv0hzPL91QLaRsWHNwv3Fsy1tXZozucl9SqIpik9BRrNCcIH7/f0RN1O7newERjcOlAjFmPhaOfcGdg=
X-Received: by 2002:a17:906:a38e:b0:6da:a1f9:f9ee with SMTP id
 k14-20020a170906a38e00b006daa1f9f9eemr10648069ejz.27.1646702060536; Mon, 07
 Mar 2022 17:14:20 -0800 (PST)
MIME-Version: 1.0
References: <20220307205357.66322-1-singh.kuldeep87k@gmail.com> <20220307205357.66322-2-singh.kuldeep87k@gmail.com>
In-Reply-To: <20220307205357.66322-2-singh.kuldeep87k@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 7 Mar 2022 19:14:09 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKrq-NtkPF=p8Qn-_63qE80_0FSQkbY5WxCfJUcrNxJuA@mail.gmail.com>
Message-ID: <CAL_JsqKrq-NtkPF=p8Qn-_63qE80_0FSQkbY5WxCfJUcrNxJuA@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm: dts: realview/versatile/ste: Update spi clock name
To:     Kuldeep Singh <singh.kuldeep87k@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 7, 2022 at 2:54 PM Kuldeep Singh <singh.kuldeep87k@gmail.com> wrote:
>
> SPI clock for pl022 is "sspclk" and meanwhile few platforms such as
> realview, versatile etc. specify "SSPCLK" as clock name. Even though
> bindings checks don't differentiate between the two names still keep
> same convention throughout i.e sspclk to align with other platforms.

I don't see the point in worrying about this. The binding already
allows both. Why? Because I wrote the schema and checked it against
all the in tree users. The resulting warnings are what should be fixed
in the dts files IMO. What's not warning doesn't need to be fixed.

Rob
