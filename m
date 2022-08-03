Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 279BE5894C7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 01:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235960AbiHCX0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 19:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiHCX0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 19:26:48 -0400
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022772B606;
        Wed,  3 Aug 2022 16:26:48 -0700 (PDT)
Received: by mail-il1-f180.google.com with SMTP id j20so7775233ila.6;
        Wed, 03 Aug 2022 16:26:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=iN1Id1baZPRFNXkCffkRYWPs/AbLBF+FTy9vsZGV2nU=;
        b=aqV4mUhlkh/MlPBqLAYm2XwcrbaxBu+cyu4ke46+W6sphpv6ojMmQ+olizfVVVXnEw
         sCMK/GNazJ0iQgfMjXe7K9bQBbltCuxpST4Mgo0RlB6JkRI6bmZ4x77AKVFHRvckgIE8
         sj5xUYeV/knmgXguoDJWoGR0yGwkQi6IaTk2GrO9pldIV1nxavhzPjcz9XW7CacWuSYE
         19/LQJzbBuoK5QrXzdPUfgh97MGY+UYUtTQK7yFj7o8w6eygxBDtlae7tmwNtU7cOq49
         AG8tJSroMHxrnbTT2gidCXZq9dUJv39T+neZB9FdU+i0aywxPAjr/DYhFAvjbOSJ6ZdK
         z57g==
X-Gm-Message-State: ACgBeo0tL6CT/N5qdOHEdd+q9pgSq/MzhjmFlSTbvIu6QlFNWKwMUhzI
        76NNwjsMBVaOX4MuKv7MRQ==
X-Google-Smtp-Source: AA6agR6TnhlZAh+Daw8W3LesSdTNVNiSQ9J9g52rGwDCJ3TaEX/JcNzqCJr7fFYadLSNYrxKSENIMQ==
X-Received: by 2002:a05:6e02:12eb:b0:2df:401e:f86 with SMTP id l11-20020a056e0212eb00b002df401e0f86mr1107871iln.323.1659569207225;
        Wed, 03 Aug 2022 16:26:47 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id q30-20020a02b05e000000b0034271bbe3f1sm2524278jah.179.2022.08.03.16.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 16:26:46 -0700 (PDT)
Received: (nullmailer pid 2809126 invoked by uid 1000);
        Wed, 03 Aug 2022 23:26:44 -0000
Date:   Wed, 3 Aug 2022 17:26:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
        quic_ppratap@quicinc.com, quic_vpulyala@quicinc.com,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/8] Revert "dt-bindings: usb: dwc3: Add wakeup-source
 property support"
Message-ID: <20220803232644.GA2806113-robh@kernel.org>
References: <20220802151404.1797-1-johan+linaro@kernel.org>
 <20220802151404.1797-6-johan+linaro@kernel.org>
 <CAL_JsqL5ZCzfd06rxOdQodFjk4G3QpDCsxA5heM71x0q5d-hCw@mail.gmail.com>
 <YuokOn0KHEqv/CR4@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuokOn0KHEqv/CR4@hovoldconsulting.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2022 at 09:31:06AM +0200, Johan Hovold wrote:
> On Tue, Aug 02, 2022 at 11:17:22AM -0600, Rob Herring wrote:
> > On Tue, Aug 2, 2022 at 9:14 AM Johan Hovold <johan+linaro@kernel.org> wrote:
> 
> > > It should also not be used to
> > > work around Linux driver implementation issues such as how to coordinate
> > > the glue and core dwc3 drivers.
> > >
> > > For the Qualcomm dwc3 controllers, it is the glue device that manages
> > > the wakeup interrupts, which may or may not be able to wake the system
> > > up from system suspend.
> > 
> > While the reasoning to add this may have been for QCom, having this
> > property for other users makes sense. On some platforms, 'snps,dwc3'
> > is the only node (i.e. there's no wrapper node). So I don't think this
> > should be reverted.
> 
> Fair enough. Let's keep it in the core child node then where we can
> still retrieve from the glue parent directly.
> 
> (I assume you're not suggesting also adding 'wakeup-source' to the qcom
> glue node, which is where the actual wakeup interrupts live.)

'wakeup-source' belongs wherever the interrupt that causes wakeup is 
defined.

Rob
