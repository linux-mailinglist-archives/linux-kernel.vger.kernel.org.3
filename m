Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833364E3FC1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 14:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235818AbiCVNpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 09:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232683AbiCVNpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 09:45:03 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2AD6145;
        Tue, 22 Mar 2022 06:43:33 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id l7-20020a05600c1d0700b0038c99618859so2623190wms.2;
        Tue, 22 Mar 2022 06:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sUWPIP8GGlUV6VTKUliU0ZHihvV6xHZFMDP/CthCS1Y=;
        b=kMiThXn0nYgm8kE9/5EMEUd8O+PbiR58lHQyKuCcXR9EnM/D1SqqpTE6RCdV1X25G2
         l8g7Afpgbu7uEWO6cMsOHaLUqgVcBvc0UXE8VLy71Jk3gEYaBmmZ7YQZjq0peIwRN7YS
         pcSSh+oSHkWK8j2mMr8q3Pt4Qq/Nmb57vctQQo1ezBtCy/Lqhv9mNTujciIcBFiR/cj3
         wv0Tg48dt1Olollfdfo/Pz6efrGjhW/lDlryryfodStI2ZGKmrzW9iFiWhYGXh3lutEc
         9GlyHsqdnLtFABWLXE5RSc20zOcjMWcMuonTzDhuXa+RyZaIN7qHUEyjT+PcdlgUmaRJ
         9rfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sUWPIP8GGlUV6VTKUliU0ZHihvV6xHZFMDP/CthCS1Y=;
        b=7ODUo15p9XCkFbB+nG6vPcELnwoSldNEWAX73/9T4b6HWmf6bIRlanLebpDkuoho+K
         9NvtXKH93faIVkD7y8GodlZseYfkMFS/c+yUMgwXuXMdQIc40YCB1olThR8srZHq43q8
         uheAnUjIbifsK0OnixDTwxsah7nsqfACscIJ31NNHS2MUFaqRY4TNvBBVSHBPuY59lTj
         w4rpEPyl5SJS1hzHmiaWvdfVdtXMEOFVNJ3GgAFu4cZ74Cw4Uv8GGZlLYPoXGIzYJfbV
         SWz1UHlbe58idW6u2G6l83cpd7M73kl5JToghQRUcuvHKj/f+Db8yiuYcfyanCdRW/oR
         hgcQ==
X-Gm-Message-State: AOAM531X/R7YSpx67qmSUiGBOQPl7ombJH80VCQ4n33PJHjRBMPVy6K1
        td13WZcph53KmXUP77hCZHI=
X-Google-Smtp-Source: ABdhPJzLfbPQALu/tIjINp547kjDW6t8wUr3vl4gLrMN21/OlnP9ymOVeRnzDdJSQWmTLH34IZu+cw==
X-Received: by 2002:adf:908e:0:b0:1e7:bea7:3486 with SMTP id i14-20020adf908e000000b001e7bea73486mr21814271wri.401.1647956612387;
        Tue, 22 Mar 2022 06:43:32 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.gmail.com with ESMTPSA id 189-20020a1c02c6000000b0038c57df82aasm1961561wmc.20.2022.03.22.06.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 06:43:31 -0700 (PDT)
Date:   Tue, 22 Mar 2022 14:43:31 +0100
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v6 00/18] Modernize rest of the krait drivers
Message-ID: <YjnSg1NixXzjyXX9@Ansuel-xps.localdomain>
References: <20220321231548.14276-1-ansuelsmth@gmail.com>
 <CAL_JsqKbgZ39XBbT3nueN+vs9GdL9+mejJKYqB-o8-A3xti6jQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqKbgZ39XBbT3nueN+vs9GdL9+mejJKYqB-o8-A3xti6jQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 08:56:13PM -0500, Rob Herring wrote:
> On Mon, Mar 21, 2022 at 6:45 PM Ansuel Smith <ansuelsmth@gmail.com> wrote:
> >
> > This is a follow-up to the ipq806x gcc modernize series. Manu cleanup
> > changes and also some discoveries of wrong definition notice only with
> > all these conversions.
> >
> > The first patch is an improvement of the clk_hw_get_parent_index. The
> > original idea of clk_hw_get_parent_index was to give a way to access the
> > parent index but for some reason the final version limited it to the
> > current index. We change it to give the current parent if is not
> > provided and to give the requested parent if provided. Any user of this
> > function is updated to follow the new implementation.
> >
> > The patch 2 and 3 are some additional fixes for gcc.
> > The first one is a fix that register the pxo and cxo fixed clock only if
> > they are not defined in DTS.
> > The patch 3 require some explaination. In short is a big HACK to prevent
> > kernel panic with this series.
> >
> > The kpss-xcc driver is a mess.
> > The Documentation declare that the clocks should be provided but for some
> > reason it was never followed.
> > In fact in the ipq8064 DTSI only the clocks for l2cc are declared but
> > for cpu0 and cpu1 the clocks are not defined.
> > The kpss-xcc driver use parent_names so the clks are ignored and never
> > used so till now it wasn't a problem (ignoring the fact that they
> > doesn't follow documentation at all)
> > On top of that, the l2cc node declare the pxo clock in a really strange
> > way. It's declared using the PXO_SRC gcc clock that is never defined in
> > the gcc ipq8064 clock table. (the correct way was to declare a fixed
> > clock in dts and reference that)
> > To prevent any kind of problem we use the patch 3 and provide the clk
> > for PXO_SRC in the gcc clock table. We manually provide the clk after
> > gcc probe.
> >
> > Patch 4 is just a minor cleanup where we use the poll macro
> >
> > Patch 5 is the actually kpss-xcc conversion to parent data
> >
> > Patch 6-7 should be a fixup of a real conver case
> >
> > Patch 8 converts the krait-cc to parent_data
> > Patch 9 give some love to the code with some minor fixup
> > Patch 10 drop the hardcoded safe sel and use the new
> > clk_hw_get_parent_index to get the safe parent index.
> > (also I discovered that the parent order was wrong)
> >
> > Patch 11 is an additional fixup to force the reset of the muxes even
> > more.
> >
> > Patch 12-13 are some additiona taken from the qsdk that were missing in
> > the upstream driver
> >
> > Patch 14 converts krait-cc to yaml
> >
> > Patch 15 add to krait-cc Documentation the L2 clocks
> >
> > Patch 16 converts the kpss-acc driver to yaml and fix some Documentation
> > error
> >
> > Patch 17 convets the kpss-gcc driver to yaml
> >
> > Patch 18 finally adds all this stuff to the ipq8064 dtsi (and fix the
> > stupid PXO_SRC phandle)
> >
> > I tested this series on a ipq8064 SoC by running a cache benchmark test
> > to make sure the changes are correct and we don't silently cause
> > regressions. Also I compared the output of the clk_summary every time
> > and we finally have a sane output where the mux are correctly placed in
> > the correct parent. (till now we had the cpu aux clock all over the
> > place, probably never cause problems but who knows.)
> >
> > v6:
> > - Move dts patch as last patch
> > - Address commencts from Rob
> > - Fix warning from make dtbs_check
> > v5:
> > - Address comments from Krzysztof
> > v4:
> > - Fix more dt-bindings bog errors
> > v3:
> > - Split Documentation files for kpss and krait-cc
> > v2:
> > - introduce new API instead of fixing the existing one
> > - do not reorganize variables in krait-cc
> > - fix some comments error and improve it
> > - return better error for patch 7
> > - fix missing new line on patch 16
> 
> 6 versions in a week is too many, especially with the merge window
> starting. Please give some time for review of all the patches and by
> more than one person. It doesn't look like any of the clk driver
> patches have been reviewed since v1 for example.
> 
> Rob

Yes sorry. There was an initial review for the clk driver from v1 to
v2 but nothing else. I was trying to make the Documentation ready while
I wait for a second review of the clk code.

Will wait for clk code review to send v7 hoping it will be the final
version.

-- 
	Ansuel
