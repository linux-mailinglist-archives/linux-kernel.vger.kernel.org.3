Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22DB4B7D52
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 03:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343607AbiBPCK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 21:10:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236614AbiBPCK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 21:10:57 -0500
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720D9FBA59
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 18:10:46 -0800 (PST)
Received: by mail-oo1-xc2b.google.com with SMTP id i10-20020a4aab0a000000b002fccf890d5fso885772oon.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 18:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=eOGRLRkS3e6dTdy4+VsuInylNMPOPtypXWpw081JkCE=;
        b=d3EOKXLfn2QjqppU+AbsJVRiA9w27o8GUwtOTW7lMqgN6+D8QDhBJKyNgzBVV2EibR
         DLQUjHF4BGcIoJ47MhqRcU0S7Dwy8i2sW2j2LseP9rQPKq5sO2TTk4Vy6qtEaCn+t6u6
         dBgM1T5YWbsxE0AO3PH6jBptWbRx24mBTJOBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=eOGRLRkS3e6dTdy4+VsuInylNMPOPtypXWpw081JkCE=;
        b=csc+1n9ALEFNqCG0g7YmE4fSSQ23bUdk4CLxp4QRHGbnCcpd/dA2YfgAW3/4bui2BO
         lHpJXKIlnnE9cEdzKvNv4nB5TIZFgGsxbmemBP19T3PPmnX2i0GclxgtUDqNhHYqYPOV
         enSXGVB4BhKKZzLCK8c8dk1lMREnQpuRe+8lyIbSJVMs3USzuJIXXKJ3V0VIwG8g+aT9
         //xqugLjI+m7zmNOzEdZvxMZGlWldGFUZYBf8PdS2N6OSv7zyMiTlkLHnYofUJnWaZlL
         zliFs9FL2TYwL9rTltX9xizrfZnCqNMbCrGhAlxdawunhOb1jsEHd0La1fi9HmJ0oZfd
         QZDQ==
X-Gm-Message-State: AOAM533USQM8U8C0fRkLw8j4K+MkGbSPlFxNejbPliRyWbIFpBqpLHWp
        6jSFtMqgPa0FM9zLDTEgbI/5+g09rS38eKqNH1kAUg==
X-Google-Smtp-Source: ABdhPJzrN3Y1q7CHe3i8jMiQafAjvoaP/zBlEg6kWGGDyJQIBmexLpOXeN8Dr09gBIW5TjNknaxnK8JYghcdA6EzEfU=
X-Received: by 2002:a05:6870:631a:b0:d1:7d97:806 with SMTP id
 s26-20020a056870631a00b000d17d970806mr278296oao.8.1644977445823; Tue, 15 Feb
 2022 18:10:45 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 15 Feb 2022 18:10:45 -0800
MIME-Version: 1.0
In-Reply-To: <f1b4b389-12f9-7c21-b117-f2fe6df58a89@linaro.org>
References: <1644952755-15527-1-git-send-email-quic_c_sanm@quicinc.com>
 <1644952755-15527-2-git-send-email-quic_c_sanm@quicinc.com> <f1b4b389-12f9-7c21-b117-f2fe6df58a89@linaro.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 15 Feb 2022 18:10:45 -0800
Message-ID: <CAE-0n52G6Cu8douv_KuQEeVM-3vnwGT4dhai8kmiLJ4Fd9Qz8A@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: phy: qcom,usb-snps-femto-v2: Add phy
 override params bindings
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Doug Anderson <dianders@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sandeep Maheswaram <quic_c_sanm@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>,
        Wesley Cheng <wcheng@codeaurora.org>
Cc:     evicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-usb@vger.kernel.org, quic_pkondeti@quicinc.com,
        quic_ppratap@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dmitry Baryshkov (2022-02-15 11:55:18)
> On 15/02/2022 22:19, Sandeep Maheswaram wrote:
> > Add support for overriding SNPS phy tuning parameters in device tree
> > bindings.
>
> This does not really benefit the users and does not help developers.
> Could you please change the dt bindings to specify values for
> thresholds, durations, impedance, etc. The values should be represented
> in the human units (e.g. us, Ohms, mV), not in the internal register
> 'bits' representation.

+1
