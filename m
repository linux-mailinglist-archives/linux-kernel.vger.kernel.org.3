Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D285B52E108
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 02:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343907AbiETARf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 20:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343900AbiETARc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 20:17:32 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F88E4EA37
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 17:17:30 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id q8so8282237oif.13
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 17:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=g5XiutTaPMay4BnFO9HfDcF8oQ/jkp6cQRv3bNCI4Wk=;
        b=ZbXX/m2bMNzaPjDqUcHkf28qmML3E+inml+E4xWFcG6dWRG+iyU0G+nYA0hHqe8msV
         C3bKASpniuAGaIIK/TMUbijx1V+sTDrUTHjffZQzMaZzcVTldTK3Z8ckPpdTB6cypJ6b
         AavISvju5ob6s267fr3mtH5wFeSQhAuQ7bg48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=g5XiutTaPMay4BnFO9HfDcF8oQ/jkp6cQRv3bNCI4Wk=;
        b=A9thSceezzAaHEYg0MM8foudyDkZM1GKNQUAlXvvASGB1dPEs+dBYuObLEu1lNsTMD
         8QO8XC19J8WJGxpbkdgO7b8tpm5Ip/HeOWnuh6I9f3ZB2FRIxt3mJK8RE9ozsJluJs14
         eqa5m3Pib+0ICEvUrVCZeZS/WUdjaoGIKd8cWNazsmBNNo5TpfvcwBYl2CR5lr5nPqPp
         9CLROWKUopNVSJ/Dyc3AEUaqs1CfaMCDmIg+CJyBwzmZ7CJ+4xaPLnS+V3pQY047uKBy
         qv9v5pOUD+HGdhU/TamjFyAlTqEVfcCAESebV7yPLFauPzTDgBkJ5iCZnvVgonx79s+/
         YRVA==
X-Gm-Message-State: AOAM531SxdEc8hnY7N2n5iCM7XNaihYZ81IeHQDNp5mno5Dkr48ilRwU
        YxFuxftQZP+39p4HKlvOoC5sqMeEstK2Nlv6fkYgYg==
X-Google-Smtp-Source: ABdhPJyd13g7t+WPRnOquoFOd12gHlNQp38Z6Pf/XC3ZP6Ibo0ugtzK1MsJaWRsxBjjPvfeDyKXwrkCZvHva8m8e/r8=
X-Received: by 2002:a05:6808:14c2:b0:326:c129:d308 with SMTP id
 f2-20020a05680814c200b00326c129d308mr3784257oiw.193.1653005849460; Thu, 19
 May 2022 17:17:29 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 19 May 2022 17:17:29 -0700
MIME-Version: 1.0
In-Reply-To: <20220519164914.v3.1.I71e42c6174f1cec17da3024c9f73ba373263b9b6@changeid>
References: <20220519164914.v3.1.I71e42c6174f1cec17da3024c9f73ba373263b9b6@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 19 May 2022 17:17:29 -0700
Message-ID: <CAE-0n51g-G=ZoJmrvm3PeL3hk4CaBoo123MHa=yq251-yAsbQA@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] dt-bindings: Document how Chromebooks with
 depthcharge boot
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Alexandru M Stan <amstan@chromium.org>,
        "Joseph S . Barrera III" <joebar@chromium.org>,
        patches@lists.linux.dev, devicetree@vger.kernel.org,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Julius Werner <jwerner@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2022-05-19 16:51:05)
> diff --git a/Documentation/arm/google/chromebook-boot-flow.rst b/Documentation/arm/google/chromebook-boot-flow.rst
> new file mode 100644
> index 000000000000..92d8a658ceaa
> --- /dev/null
> +++ b/Documentation/arm/google/chromebook-boot-flow.rst
> @@ -0,0 +1,63 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +======================================
> +Chromebook Boot Flow
> +======================================
> +
> +Most recent Chromebooks that use device tree are using the opensource
> +depthcharge bootloader. Depthcharge expects the OS to be packaged as a "FIT

Is there a reference for depthcharge? I guess there's source browser[2] but
I was hoping for some README or something.

> +Image" which contains an OS image as well as a collection of device trees. It

Reference coreboot docs[1]?


> +is up to depthcharge to pick the right device tree from the FIT Image and
> +provide it to the OS.
> +
> +The scheme that depthcharge uses to pick the device tree takes into account
> +three variables:
> +- Board name, specified at compile time.

Which compile time? depthcharge compile time? Also mention "BOARD"
somehow so it corresponds to the list below.

> +- Board revision number, read from GPIO strappings at boot time.

Maybe just say "determined at runtime" as who knows if it may change
from GPIO to something else. Also mention "REV" somehow so it
corresponds to the list below.

> +- SKU number, read from GPIO strappings at boot time.
> +
> +For recent Chromebooks, depthcharge creates a match list that looks like this:
> +- google,$(BOARD)-rev$(REV)-sku$(SKU)
> +- google,$(BOARD)-rev$(REV)
> +- google,$(BOARD)-sku$(SKU)
> +- google,$(BOARD)
> +
> +Note that some older Chromebooks use a slightly different list that may
> +not include sku matching or may prioritize sku/rev differently.

s/sku/SKU/g

> +
> +Note that for some boards there may be extra board-specific logic to inject
> +extra compatibles into the list, but this is uncommon.
> +
> +Depthcharge will look through all device trees in the FIT image trying to
> +find one that matches the most specific compatible. It will then look
> +through all device trees in the FIT image trying to find the one that
> +matches the _second most_ specific compatible, etc.
> +
> +When searching for a device tree, depthcharge doesn't care where the
> +compatible falls within a given device tree. As an example, if we're on

where the compatible string falls within a device tree's root compatible
string array?

> +board "lazor", rev 4, sku 0 and we have two device trees:
> +- "google,lazor-rev5-sku0", "google,lazor-rev4-sku0", "qcom,sc7180"
> +- "google,lazor", "qcom,sc7180"
> +
> +Then depthcharge will pick the first device tree even though
> +"google,lazor-rev4-sku0" was the second compatible listed in that device tree.
> +This is because it is a more specific compatible than "google,lazor".
> +
> +It should be noted that depthcharge does not have any smarts to try to
> +match board or SKU revisions that are "close by". That is to say that
> +if depthcharge knows it's on "rev4" of a board but there is no "rev4"
> +device tree then depthcharge _won't_ look for a "rev3" device tree.
> +
> +In general when any significant changes are made to a board the board
> +revision number is increased even if none of those changes need to
> +be reflected in the device tree. Thus it's fairly common to see device
> +trees with multiple revisions.
> +
> +It should be noted that, taking into account the above system that
> +depthcharge has, the most flexibility is achieved if the device tree
> +supporting the newest revision(s) of a board omits the "-rev{REV}"
> +compatible strings. When this is done then if you get a new board
> +revision and try to run old software on it then we'll at pick the most

then we'll pick the most? These last two sentences confuse me.

> +reasonable device tree. If it turns out that the new revision actually
> +has no device-tree visible changes then we'll not only pick the most

There's 'device tree' and 'device-tree', please pick one, or use a new
one like 'devicetree'.

> +reasonable device tree, we'll pick the exact right one.

[1] https://doc.coreboot.org/lib/payloads/fit.html
[2] https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/platform/depthcharge/
