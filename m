Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF19956778C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 21:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233604AbiGETLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 15:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233528AbiGETLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 15:11:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78FD2181E;
        Tue,  5 Jul 2022 12:11:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 643D161ADA;
        Tue,  5 Jul 2022 19:11:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9C65C341D2;
        Tue,  5 Jul 2022 19:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657048276;
        bh=fW6C85SfnGr4A/MwSnxUmQCvBcZVw+MsgZ3ZwmdhE0E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JWaEsRn8eq53I+E50vwnXBV19bE9m21GJyq7wE4aRHf3HWaLGBZMa6NTnCO4NI2RS
         +wMXF+WBcEsec1l980shmfFvjeWGIP/Fuo9Ieo5ZOPRTMsJsvTgtIzta9cF1ljfRpM
         8gEnFKGqFmkCt12frB6EcRtusb0tzFJ5zPs5WnXZ1Y6yen7yJ3eMlhb9AsWrmZNkq4
         okYvca3md0qqwHOX/DvNXSECRk48CgE6qX4C2xaMfPSpjFjffTuCId/hnN2Q0GSgLx
         06CE/MHMaq2yljh6DkhLgzCu0dBRB2RtWkjpdmSaMRHLL4Rt6FNMvwgzJ34V43lRxj
         gcluacKVOqcIw==
Received: by mail-vs1-f47.google.com with SMTP id 189so12955591vsh.2;
        Tue, 05 Jul 2022 12:11:16 -0700 (PDT)
X-Gm-Message-State: AJIora9Pmp3q/DDsc+N7LKj8O9VJug9hFPk5tFehpzhTX3dlCPsNzwwx
        7qR4nb2WK7EJy/SSRtaf0ocm0Oixs/OEdu7o1A==
X-Google-Smtp-Source: AGRyM1smAAr46pC+2jkK1C2hlhgHoXOtu3SuwNiMuxKguIFPRWzEUMwGqg7poY9MJJUB74wAkJrodAeIv6S9zEDVTjc=
X-Received: by 2002:a67:e18e:0:b0:354:4c38:11dd with SMTP id
 e14-20020a67e18e000000b003544c3811ddmr19555806vsl.6.1657048275773; Tue, 05
 Jul 2022 12:11:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220705120356.94876-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220705120356.94876-1-krzysztof.kozlowski@linaro.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 5 Jul 2022 13:11:04 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+LepF_67SJUqQ5mUO-TZAd-46LB+aYE5rZmnmmwMg=bw@mail.gmail.com>
Message-ID: <CAL_Jsq+LepF_67SJUqQ5mUO-TZAd-46LB+aYE5rZmnmmwMg=bw@mail.gmail.com>
Subject: Re: [RESEND PATCH v3 0/3] dt-bindings: input: gpio-keys: apply via DT tree
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux Input <linux-input@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Tue, Jul 5, 2022 at 6:04 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Hi Rob,
>
> Can you apply these directly? You already reviewed them, but I dropped
> the tag so you will see them in Patchwork. It seems these won't go in
> through input [1].
>
> [1] https://lore.kernel.org/all/c2c1cf0c-9462-9ba5-a297-70d13a063de1@linaro.org/

Will give Dmitry a few more days first before I take both series.

Rob
