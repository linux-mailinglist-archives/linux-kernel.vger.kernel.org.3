Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CAC25880E1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 19:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233676AbiHBRRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 13:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbiHBRRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 13:17:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C254D1D0E1;
        Tue,  2 Aug 2022 10:17:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69CEE611CB;
        Tue,  2 Aug 2022 17:17:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFE03C433C1;
        Tue,  2 Aug 2022 17:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659460655;
        bh=ezo/DMFL/JZvUXZGmbP9Yp6XteEVnCTIPlNYh1llQVE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=a/0QMhAwa99UhhzkA/GaZ6skt+cIxlFs8m4phu2lVbgEKs8dAuQajL3z/PhmuCPaM
         FDVa81594txuJ6Xr9STpLGFG7y+g07ES9nX30wKOpuL+gQ7zgDrUjDvJHTpe1A4m2m
         RDbcrd/tssUPIkaaWNEG4vIhBbaUyU6WWUeJwnQcg+SiDGhhWTaM1GLet9g376AV7n
         4Ek//phbCj5VOJKH/lMwneV582MPbDyHRh3KM/4EWS5Yt7fv03eq2eb4UMhxmcCJ4U
         +re1YFXDh1Ux02PHKxrlABplvVUqmFrmPRUWOJbRf+VA/RMft1hLs35Nl3qPvsy013
         W/CYZ7tl1w0Nw==
Received: by mail-ua1-f43.google.com with SMTP id c19so6049621uat.6;
        Tue, 02 Aug 2022 10:17:35 -0700 (PDT)
X-Gm-Message-State: ACgBeo19klTm7nkg3xVLYWntjoXIVqqGPELxu+K8cEGZFwzwGFViHj2a
        58pkbCOPEbRRsjmvua1xw1TnJbKGySIefMhZmw==
X-Google-Smtp-Source: AA6agR7y4buQNvya5WmrFhrh5GEnJcFBluchloSidybizQJCjyZ9Adx3yyIrlsqlhrS3nobQjHpb5sanNqcqWcHzULM=
X-Received: by 2002:ab0:2b06:0:b0:384:c4af:107c with SMTP id
 e6-20020ab02b06000000b00384c4af107cmr8357117uar.77.1659460654762; Tue, 02 Aug
 2022 10:17:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220802151404.1797-1-johan+linaro@kernel.org> <20220802151404.1797-6-johan+linaro@kernel.org>
In-Reply-To: <20220802151404.1797-6-johan+linaro@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 2 Aug 2022 11:17:22 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL5ZCzfd06rxOdQodFjk4G3QpDCsxA5heM71x0q5d-hCw@mail.gmail.com>
Message-ID: <CAL_JsqL5ZCzfd06rxOdQodFjk4G3QpDCsxA5heM71x0q5d-hCw@mail.gmail.com>
Subject: Re: [PATCH 5/8] Revert "dt-bindings: usb: dwc3: Add wakeup-source
 property support"
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 2, 2022 at 9:14 AM Johan Hovold <johan+linaro@kernel.org> wrote:
>
> This reverts commit 098c4d43b91a269e89f60331a26a3f3b914677ed.
>
> A devicetree binding should describe hardware capabilities and not be
> used to configure power-management policies (even if things are a bit
> blurry when it comes to "wakeup-source").

Whether a device's interrupt can cause a wakeup is a h/w feature.
That's not policy. If Linux also uses this to decide whether or not to
enable wakeup, then that's its policy.

> It should also not be used to
> work around Linux driver implementation issues such as how to coordinate
> the glue and core dwc3 drivers.
>
> For the Qualcomm dwc3 controllers, it is the glue device that manages
> the wakeup interrupts, which may or may not be able to wake the system
> up from system suspend.

While the reasoning to add this may have been for QCom, having this
property for other users makes sense. On some platforms, 'snps,dwc3'
is the only node (i.e. there's no wrapper node). So I don't think this
should be reverted.

Rob
