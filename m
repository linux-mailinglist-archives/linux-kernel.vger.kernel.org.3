Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC748570D42
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 00:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbiGKWTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 18:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiGKWTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 18:19:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB27D2A972
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 15:19:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 71D43B815F2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 22:19:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20B99C34115
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 22:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657577973;
        bh=LGLSsH08DHX7hTExbQG+GETVb+tRcxDggleTNnB8dKc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OPosPcZ1GoxqYhTeiD4rAT6iHTJVtF7tRT0W4Jl5W/Nxdhf367pj7Sx1Od52/qP7m
         1UXoA5KZ9z9PEJH5kSBSZmmu2s83hbCv6ittQ5NqNV2A91jU0Al5Aw9MPm7UkPK6lV
         w4YRrytyLb6HB09/pqDf6qR8jimW4kz2SVdLRLXozAotQw2wdNGipXT8GRzaRpHGBm
         HV8e/HnMtcSwkuL38xJAyV4tcZvp2kO9/O9KRUjhZ+ozYbuDMt9yM9iv/E4ZjrH0wN
         02XJUmRh6eZo9f1TvtmlNi6iapmD0FnJhmltprlOrPujFqEbMSP/iHlJji6o0HLb/G
         9BEpt7dcSmQfA==
Received: by mail-vs1-f44.google.com with SMTP id a184so6222723vsa.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 15:19:33 -0700 (PDT)
X-Gm-Message-State: AJIora8I8S8OOyB+6+jhGFZIeHEGkXobYp0C6BN65AG72Xixf02pi+Im
        bs7+JmlV0i1FG0kaz52YhsmyE+PKckcsxWtIEQ==
X-Google-Smtp-Source: AGRyM1uzFdX28Bckk4TwxkS2Gn6yCtnEQ4o5H/6GY0pvbiFULK429raKGjQMv7b6opxK5tv6ihpNHn+vsRc+J+RXj7c=
X-Received: by 2002:a67:f301:0:b0:357:1b13:2691 with SMTP id
 p1-20020a67f301000000b003571b132691mr6745053vsf.6.1657577972063; Mon, 11 Jul
 2022 15:19:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220707081826.953449-1-Naresh.Solanki@9elements.com> <20220707081826.953449-2-Naresh.Solanki@9elements.com>
In-Reply-To: <20220707081826.953449-2-Naresh.Solanki@9elements.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 11 Jul 2022 16:19:20 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ0pkcCmt_ER7cyU278aeTu=0Mu2HzEXMvU=DXsfms_6A@mail.gmail.com>
Message-ID: <CAL_JsqJ0pkcCmt_ER7cyU278aeTu=0Mu2HzEXMvU=DXsfms_6A@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] dt-bindings: vendor-prefixes: add 9elements
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 7, 2022 at 2:19 AM Naresh Solanki
<naresh.solanki@9elements.com> wrote:
>
> The vendor prefix for 9elements GmbH [1].

Use get_maintainers.pl to send to the right lists if you want this
reviewed and/or applied.

>
> [1] https://9elements.com/
>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index 0496773a3c4d..2b3c929b1332 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -29,6 +29,8 @@ patternProperties:
>      description: 70mai Co., Ltd.
>    "^8dev,.*":
>      description: 8devices, UAB
> +  "^9elements,.*":
> +    description: 9elements GmbH
>    "^abb,.*":
>      description: ABB
>    "^abilis,.*":
> --
> 2.35.3
>
