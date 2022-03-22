Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86AAA4E3649
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 02:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235260AbiCVB6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 21:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235220AbiCVB5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 21:57:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8246519C;
        Mon, 21 Mar 2022 18:56:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 173D16009B;
        Tue, 22 Mar 2022 01:56:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74429C340F4;
        Tue, 22 Mar 2022 01:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647914187;
        bh=3aKRQ1zkvM86Ijua6KeR7j2uxQVTwLIN0qCoPo5MQiM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BXDlgssD9heDGT5bIdf3t7Pin8Qy04OUv5/nMSJ8eVe4ozOmKOy9KG5e9XNd5xTPe
         ZBv+1nJjgCMGEXXHyucHyErJJ5IABNAXu8n4yyB5h5DGmgYlphu9hYzzDPK0u1f1Ka
         Srt2LrxmHhbBKaaW9XzaVbuLI8FlzyQs53VBWgPNblEL2DIF0m6k6NrVK6Bjv2WuED
         CjHERo9QDNRLrWpuAX52LNDad8JW81WkIWBAOKJoF2DGG5NZD3inTdXaZ1JsUCAR4i
         s6kHN7foNjJFdqUsLUF+yg0veSgHXUaDG7i7Ad5vmfrxjVIYywcrOphUoeQDE1Q2Oe
         uHIURDN17IeDA==
Received: by mail-ed1-f44.google.com with SMTP id g20so19999867edw.6;
        Mon, 21 Mar 2022 18:56:27 -0700 (PDT)
X-Gm-Message-State: AOAM532o66isX8BaPXMZaeRNYu+N1C1jVzIJgSzGPCIr68Kg5qgH8vzP
        9R+GiWr26ey5VSfAQlyQuZlNCqpEW7dyFBc80Q==
X-Google-Smtp-Source: ABdhPJz4tPX9p4b3GLKy7LLsiapEu5y0SEDmr9YSAAyx9ifi28nTZYAtmi9lG05LIM8a/YU8KHwHA777z/Wfye+9kMo=
X-Received: by 2002:a05:6402:686:b0:418:edaa:9cbc with SMTP id
 f6-20020a056402068600b00418edaa9cbcmr26281291edy.67.1647914185579; Mon, 21
 Mar 2022 18:56:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220321231548.14276-1-ansuelsmth@gmail.com>
In-Reply-To: <20220321231548.14276-1-ansuelsmth@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 21 Mar 2022 20:56:13 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKbgZ39XBbT3nueN+vs9GdL9+mejJKYqB-o8-A3xti6jQ@mail.gmail.com>
Message-ID: <CAL_JsqKbgZ39XBbT3nueN+vs9GdL9+mejJKYqB-o8-A3xti6jQ@mail.gmail.com>
Subject: Re: [PATCH v6 00/18] Modernize rest of the krait drivers
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 6:45 PM Ansuel Smith <ansuelsmth@gmail.com> wrote:
>
> This is a follow-up to the ipq806x gcc modernize series. Manu cleanup
> changes and also some discoveries of wrong definition notice only with
> all these conversions.
>
> The first patch is an improvement of the clk_hw_get_parent_index. The
> original idea of clk_hw_get_parent_index was to give a way to access the
> parent index but for some reason the final version limited it to the
> current index. We change it to give the current parent if is not
> provided and to give the requested parent if provided. Any user of this
> function is updated to follow the new implementation.
>
> The patch 2 and 3 are some additional fixes for gcc.
> The first one is a fix that register the pxo and cxo fixed clock only if
> they are not defined in DTS.
> The patch 3 require some explaination. In short is a big HACK to prevent
> kernel panic with this series.
>
> The kpss-xcc driver is a mess.
> The Documentation declare that the clocks should be provided but for some
> reason it was never followed.
> In fact in the ipq8064 DTSI only the clocks for l2cc are declared but
> for cpu0 and cpu1 the clocks are not defined.
> The kpss-xcc driver use parent_names so the clks are ignored and never
> used so till now it wasn't a problem (ignoring the fact that they
> doesn't follow documentation at all)
> On top of that, the l2cc node declare the pxo clock in a really strange
> way. It's declared using the PXO_SRC gcc clock that is never defined in
> the gcc ipq8064 clock table. (the correct way was to declare a fixed
> clock in dts and reference that)
> To prevent any kind of problem we use the patch 3 and provide the clk
> for PXO_SRC in the gcc clock table. We manually provide the clk after
> gcc probe.
>
> Patch 4 is just a minor cleanup where we use the poll macro
>
> Patch 5 is the actually kpss-xcc conversion to parent data
>
> Patch 6-7 should be a fixup of a real conver case
>
> Patch 8 converts the krait-cc to parent_data
> Patch 9 give some love to the code with some minor fixup
> Patch 10 drop the hardcoded safe sel and use the new
> clk_hw_get_parent_index to get the safe parent index.
> (also I discovered that the parent order was wrong)
>
> Patch 11 is an additional fixup to force the reset of the muxes even
> more.
>
> Patch 12-13 are some additiona taken from the qsdk that were missing in
> the upstream driver
>
> Patch 14 converts krait-cc to yaml
>
> Patch 15 add to krait-cc Documentation the L2 clocks
>
> Patch 16 converts the kpss-acc driver to yaml and fix some Documentation
> error
>
> Patch 17 convets the kpss-gcc driver to yaml
>
> Patch 18 finally adds all this stuff to the ipq8064 dtsi (and fix the
> stupid PXO_SRC phandle)
>
> I tested this series on a ipq8064 SoC by running a cache benchmark test
> to make sure the changes are correct and we don't silently cause
> regressions. Also I compared the output of the clk_summary every time
> and we finally have a sane output where the mux are correctly placed in
> the correct parent. (till now we had the cpu aux clock all over the
> place, probably never cause problems but who knows.)
>
> v6:
> - Move dts patch as last patch
> - Address commencts from Rob
> - Fix warning from make dtbs_check
> v5:
> - Address comments from Krzysztof
> v4:
> - Fix more dt-bindings bog errors
> v3:
> - Split Documentation files for kpss and krait-cc
> v2:
> - introduce new API instead of fixing the existing one
> - do not reorganize variables in krait-cc
> - fix some comments error and improve it
> - return better error for patch 7
> - fix missing new line on patch 16

6 versions in a week is too many, especially with the merge window
starting. Please give some time for review of all the patches and by
more than one person. It doesn't look like any of the clk driver
patches have been reviewed since v1 for example.

Rob
