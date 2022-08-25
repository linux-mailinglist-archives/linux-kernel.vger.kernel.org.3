Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D764D5A198F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 21:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241324AbiHYTcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 15:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiHYTcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 15:32:17 -0400
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADFBAE232;
        Thu, 25 Aug 2022 12:32:16 -0700 (PDT)
Received: by mail-oi1-f173.google.com with SMTP id v125so24546488oie.0;
        Thu, 25 Aug 2022 12:32:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=1jbLVYE4Xk4iZE8f+Sd1RkalFYsuUzAhPdP1wmfCPDc=;
        b=Y6M6ygF7ecSwk4MgakI0PG4illdnNLVYkkRnulBuuc6RmzcGpeH7MZoyBsaZVVhIoA
         D7LUZZP8ZuY6uyvTHGaGRLTjPNyROE5X1Y4I71Lp2PdriGwhbNFuArbhZv0b6p8HvBvZ
         gndnJM0CT9jBizm5vWcI02jkxbLNIfgJUB1jvJSzFjP1XfohZi0NWcItSSQ+Rw6fUjVp
         2vc+MhB13bJEqdyA4WTAWi3MkFRKkcZB16mbBlLmkSPAqKTklHmHe2/Hqwy0zxa4/ABO
         oViCQQjzVpV3wqfPVKn3Y+r0XnXban6WJ/ZFiFZnfZ6T2vtkrr7Azr1LRVvMEu4/DHwX
         Ls6A==
X-Gm-Message-State: ACgBeo3IY+YqZh38ZR/h6NCyxPaDZw1dpx06pZaSkzu2tRVTQnEvtKxD
        fHXK1P/R6gXTuRHgmYYBYg==
X-Google-Smtp-Source: AA6agR7/iR9O/8wGyf5tijYk4nti9ywGqLBLmEsMFqUUJj5poDlpKbQ7qLM7f/3TMarb7QGoG1oHYw==
X-Received: by 2002:a05:6808:1928:b0:345:3228:a797 with SMTP id bf40-20020a056808192800b003453228a797mr197156oib.125.1661455935918;
        Thu, 25 Aug 2022 12:32:15 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m12-20020a9d6acc000000b00636956b3080sm5711226otq.43.2022.08.25.12.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 12:32:15 -0700 (PDT)
Received: (nullmailer pid 1546883 invoked by uid 1000);
        Thu, 25 Aug 2022 19:32:14 -0000
Date:   Thu, 25 Aug 2022 14:32:14 -0500
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sricharan R <sricharan@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pinctrl: qcom,ipq6018: Fix example
 'gpio-ranges' size
Message-ID: <20220825193214.GA1545391-robh@kernel.org>
References: <20220809214556.2489822-1-robh@kernel.org>
 <CACRpkdbSycBG6ZiXfEHLquiyAMu=et81LAaGZbj38bhAccCSkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdbSycBG6ZiXfEHLquiyAMu=et81LAaGZbj38bhAccCSkw@mail.gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 01:07:48PM +0200, Linus Walleij wrote:
> On Tue, Aug 9, 2022 at 11:46 PM Rob Herring <robh@kernel.org> wrote:
> 
> > 'gpio-ranges' entries have a fixed size of 1 phandle plus arg 3 cells.
> > The qcom,ipq6018-pinctrl example is a cell short:
> >
> > Documentation/devicetree/bindings/pinctrl/qcom,ipq6018-pinctrl.example.dtb: pinctrl@1000000: gpio-ranges:0: [1, 0, 80] is too short
> >         From schema: /usr/local/lib/python3.10/dist-packages/dtschema/schemas/gpio/gpio.yaml
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> > Please ack and I can send to Linus before rc1.
> 
> Sorry for delay, was on vacation :/
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> I think as binding maintainer you can just submit this kind of smaller stuff
> without any subsystem consent, if you have it acked by Krzysztof, even more so.

Don't worry, I did. It is in rc1.

Rob
