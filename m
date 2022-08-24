Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B835A0082
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 19:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240213AbiHXRhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 13:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiHXRhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 13:37:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024C875CFF;
        Wed, 24 Aug 2022 10:37:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A5C73B8260D;
        Wed, 24 Aug 2022 17:37:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FEE0C43140;
        Wed, 24 Aug 2022 17:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661362631;
        bh=XEp4WEEaIZJu4cxjBAP89J0kR7LVi8xu2VmJizUyMk8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fg/ebInffYOAKWgh1kQVDZBK+5nIyGkYoYhjt+mJAzpTwZ0Xq96RzZHXnhwfFKISk
         jS/2r867EP1cysXp8JCA144wXbG8jJybryH81XkWUIPVHQtmYvJgb4fiwbZdovqGdr
         AZohIeEkCTFjRNO+bFbb7OvbgdQtAqY4/qUKsH4d+ck5bbSDylMNRpsNba4hdpQbS/
         N1W6Ywi2iW/jYcoevfWPEM09D2KmDOkARy/oPDe8w1rCT8SqOyEGVnDuTJODPoX30f
         QgDPixTbNgKRlbrY0IndDn2FUM1xQmVC+Vw8Io/2xADAFqWytibbfMkkgCxJrD5Q/c
         sJVKf9h7spLHg==
Received: by mail-ua1-f54.google.com with SMTP id s5so7003687uar.1;
        Wed, 24 Aug 2022 10:37:11 -0700 (PDT)
X-Gm-Message-State: ACgBeo1znigP6Ewgo2n+OTFg2aUK7zNe2ueYXwmLQxEF8JNIs3HiLpBz
        WAP+AzI+komNAS7vwwJieqhsWTlgye9Bvg0DrQ==
X-Google-Smtp-Source: AA6agR4/lcXZZcMBKeIOLNScXE35WDwsYTv7ijHWXb7M3whnqRMtgTblOhuemcmBqyQ5QNolbu4ezY2ZwRt31A/Xciw=
X-Received: by 2002:ab0:1053:0:b0:391:9c29:7ca8 with SMTP id
 g19-20020ab01053000000b003919c297ca8mr18233uab.86.1661362630135; Wed, 24 Aug
 2022 10:37:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220823145649.3118479-13-robh@kernel.org> <20220823182756.GA13402@duo.ucw.cz>
In-Reply-To: <20220823182756.GA13402@duo.ucw.cz>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 24 Aug 2022 12:36:58 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL6rQLkTkgaf-uyvjxtWLd++CZ1nXHrqDu3M7ybOs5i4Q@mail.gmail.com>
Message-ID: <CAL_JsqL6rQLkTkgaf-uyvjxtWLd++CZ1nXHrqDu3M7ybOs5i4Q@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: leds: Add missing (unevaluated|additional)Properties
 on child nodes
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        Nikita Travkin <nikitos.tr@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Yi Xin <Yixin.zhu@intel.com>,
        Mallikarjuna reddy <mallikarjunax.reddy@intel.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        - NeilBrown <neilb@suse.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Tue, Aug 23, 2022 at 1:28 PM Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
>
> > In order to ensure only documented properties are present, node schemas
> > must have unevaluatedProperties or additionalProperties set to false
> > (typically).
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
>
> Patch does way more than that:

It only 'ensure only documented properties are present', but yeah, it
is sometimes more than just adding unevaluatedProperties.

> Can we get some explanation why that's correct?

...adds missing $ref if needed, and fixes resulting errors about
unevaluatedProperties.

BTW, these are just the simple ones. The led bindings with multi-led
nodes are more of a mess. I haven't decided exactly how to fix those.

Rob
