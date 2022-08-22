Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD5459C7C8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 21:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237259AbiHVTCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 15:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238081AbiHVTBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 15:01:52 -0400
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796BD520AB;
        Mon, 22 Aug 2022 11:59:28 -0700 (PDT)
Received: by mail-ot1-f51.google.com with SMTP id t11-20020a05683014cb00b0063734a2a786so8297164otq.11;
        Mon, 22 Aug 2022 11:59:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=KC3mSExT2980nvsUpi0Nta2kzUEej10EfwvbkK4Vxig=;
        b=XSNZIAOzLEF4LfhNJax+k+Dp8utpNEOn4fM3wOy+xt7LweVtvIe+DHmaKqIDKuYCan
         bSZ25os/FglzgaTRqGJ5mH8Xdh6pSyZsH4uxX8f6ECfsVA/AGcBwg3HvdlvqGVKcijdG
         8O9k7J50ASMWMHvVzdiQB661EEAtimnADtyzLdy3cyQDYFX+CPIXPpof5vVNqpFeIizZ
         xRDtTspe8K1TMyVU/PQX+SjzUXG0IXEbCCo4bW+QsDYwX1MNTurqUNHvFXJyMbb45IO6
         L9hz/uE+urZHan6KBFML2RY5rJFme7wT+lerDI9zr2UJwjXHtbLthokq0X9+gjmagNYA
         dsQQ==
X-Gm-Message-State: ACgBeo1s54wkvRhn05HAKnbupm1lFCtQ5dJDNiNBRX175YGU1Guhuwv+
        aPBlEePsX/6YqS/PFLMBYQ==
X-Google-Smtp-Source: AA6agR7btQFmvQq0Xy9/DuWu4SwhzJqPzpfHfJhyCbe3cPr8MjiKVjCR+AbUoPv1GGenu7V4Fr40aw==
X-Received: by 2002:a05:6830:19a:b0:636:dbfe:4c36 with SMTP id q26-20020a056830019a00b00636dbfe4c36mr8070226ota.257.1661194767772;
        Mon, 22 Aug 2022 11:59:27 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z24-20020a4a8e58000000b004357ccfc8bfsm2633078ook.7.2022.08.22.11.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 11:59:27 -0700 (PDT)
Received: (nullmailer pid 170179 invoked by uid 1000);
        Mon, 22 Aug 2022 18:59:26 -0000
Date:   Mon, 22 Aug 2022 13:59:26 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        asahi@lists.linux.dev, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: sound: Add Apple MCA I2S transceiver
Message-ID: <20220822185926.GA146730-robh@kernel.org>
References: <20220819125430.4920-1-povik+lin@cutebit.org>
 <20220819125430.4920-2-povik+lin@cutebit.org>
 <AE646B68-CA14-483C-A1AB-30358560DAAD@cutebit.org>
 <8472463e-d99a-d0f6-9551-45a79a15f567@linaro.org>
 <737767DD-CB70-4941-8CF5-497333D3A801@cutebit.org>
 <a0a34ac8-4b62-4e69-f16f-7a51132a3987@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a0a34ac8-4b62-4e69-f16f-7a51132a3987@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2022 at 05:17:17PM +0300, Krzysztof Kozlowski wrote:
> On 19/08/2022 17:14, Martin Povišer wrote:
> >>> Since it was brought up last time but I didn’t respond: the
> >>> nonalphabetical order is as the chips were introduced (and
> >>> matches other schemas).
> >>
> >> Sure, just keep that order for future compatibles as well - so always
> >> put them according to verifiable time of market introduction...
> >>
> >> This is very poor reason, instead of alphabetical order. Even worse
> >> reason is repeating wrong pattern just because someone else did it.
> >>
> >> Best regards,
> >> Krzysztof
> >>
> > 
> > I don’t see it nearly as clear-cut. Adding to the end seems pretty
> > foolproof too, but OK, next submission will have it alphabet. ordered.
> 
> The concept is the same everywhere, be it Kconfig, Makefile or other
> lists. If everyone adds at the end, you increase the chances of
> conflicts. Having alphabetical order usually means simultaneous edits
> will happen in different places.

The difference for those cases is there is 0 control of when things are 
added with the source being all independent (different companies). For 
these, it's all one platform family and there's limits as to when one 
source can produce new entries.

I'd kind of like to know timeline order, but alphabetical is the only 
thing we can ever check easily and possibly automate (hint). 

Rob
