Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C526A53127F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238380AbiEWQFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 12:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236298AbiEWQFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 12:05:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B2B62238;
        Mon, 23 May 2022 09:05:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8597BB811A2;
        Mon, 23 May 2022 16:05:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 489ACC36AE3;
        Mon, 23 May 2022 16:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653321935;
        bh=OQknoF9VpzvIZOY+XfmMknd+82/rB4Mw5f9LQzZr21Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=THwzKKHSSjXQ77sXx2/mcpyvFaPmuwRjPtkf+6ygcLIjgJnIBDkpbIoGiZwMJ+D5o
         T+Os+h+SfRSSB5mynrbHyKySYMlSc9gbVdbaFYm2rk3wjS+IFV9gUMNMjSv7IcPYcW
         anNXO9XUerx4AkqTQX0GuBwMZWJjJIt5SqG4Ryvu8vfzwx/oyUzm70pzl95EWk78lM
         33y9fonnxN9UYmmowYJB8ebFwBbut1+jBF6rpsdduGTN4vnn5Ct04VIu3raTOiQUU5
         zeVoBDObR5HIeoamYW7nQ6gjrZcQ1JfiGx7/YY/I1vKX8RMg0l/zT02dHb6ucB3tOi
         EuOU4h84/5hiA==
Received: by mail-ej1-f42.google.com with SMTP id ck4so25538207ejb.8;
        Mon, 23 May 2022 09:05:35 -0700 (PDT)
X-Gm-Message-State: AOAM531Vo4GYndTrQnp8GDI+ukiL9F9CYL9O1qP8lkLvvjPMiyI3U6gB
        G+AvvAcgoQq+ce42F5HCpXJBtf0jGAU59lv5bA==
X-Google-Smtp-Source: ABdhPJx7argSut+Sqp7lIRuDcjTyItCqa5o12h2lr1vEuWwVcH/nUd/NPi8fuqbbhlq5GK8h0nlhoLXJMdNNwiovOJQ=
X-Received: by 2002:a17:907:3e8f:b0:6fe:d023:e147 with SMTP id
 hs15-20020a1709073e8f00b006fed023e147mr6512591ejc.270.1653321933416; Mon, 23
 May 2022 09:05:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220512175011.28753-1-dipenp@nvidia.com> <20220518003508.GA1948162-robh@kernel.org>
In-Reply-To: <20220518003508.GA1948162-robh@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 23 May 2022 11:05:21 -0500
X-Gmail-Original-Message-ID: <CAL_JsqK8hKVWChDNdmH7pB4kj2RafmEN0jFZSfi+i37uAPXhZw@mail.gmail.com>
Message-ID: <CAL_JsqK8hKVWChDNdmH7pB4kj2RafmEN0jFZSfi+i37uAPXhZw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Renamed hte directory to timestamp
To:     Dipen Patel <dipenp@nvidia.com>
Cc:     linux-tegra <linux-tegra@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 7:35 PM Rob Herring <robh@kernel.org> wrote:
>
> On Thu, 12 May 2022 10:50:11 -0700, Dipen Patel wrote:
> > Renamed hte dt binding directory to timestamp according review comment.
> > Addressed minor comment about having HTE acronym first in the common dt
> > binding document.
> >
> > The change reflects above renaming in MAINTAINERS files too.
> >
> > Signed-off-by: Dipen Patel <dipenp@nvidia.com>
> > ---
> > This patch is on top of old series (Intro to Hardware timestamping
> > engine V6) present in linux-next tentatively in preparation for
> > merge.
> >
> >  .../{hte => timestamp}/hardware-timestamps-common.yaml      | 6 +++---
> >  .../bindings/{hte => timestamp}/hte-consumer.yaml           | 0
> >  .../bindings/{hte => timestamp}/nvidia,tegra194-hte.yaml    | 0
> >  MAINTAINERS                                                 | 2 +-
> >  4 files changed, 4 insertions(+), 4 deletions(-)
> >  rename Documentation/devicetree/bindings/{hte => timestamp}/hardware-timestamps-common.yaml (71%)
> >  rename Documentation/devicetree/bindings/{hte => timestamp}/hte-consumer.yaml (100%)
> >  rename Documentation/devicetree/bindings/{hte => timestamp}/nvidia,tegra194-hte.yaml (100%)
> >
>
> Acked-by: Rob Herring <robh@kernel.org>

I take that back:

./Documentation/devicetree/bindings/timestamp/hte-consumer.yaml: $id:
relative path/filename doesn't match actual path or filename
expected: http://devicetree.org/schemas/timestamp/hte-consumer.yaml#
./Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml:
$id: relative path/filename doesn't match actual path or filename
expected: http://devicetree.org/schemas/timestamp/nvidia,tegra194-hte.yaml#
./Documentation/devicetree/bindings/timestamp/hardware-timestamps-common.yaml:
$id: relative path/filename doesn't match actual path or filename
expected: http://devicetree.org/schemas/timestamp/hardware-timestamps-common.yaml#


I was wondering why a new common binding was already in next without a
Reviewed-by, but I let that slide. Now I regret doing that.

Rob
