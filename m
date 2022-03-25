Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6744E6C38
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 02:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357627AbiCYBrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 21:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357623AbiCYBrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 21:47:32 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC67419A0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 18:45:57 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id k10so6807439oia.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 18:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=87syg5cqR3yLkq66KVMLox503xNIYaCuiAAmDxKHkEE=;
        b=EnCDpsIzebcOAG+z9D3OIIUMh21+PT1K71a9q+uY3pJu4Yvv9kYbWbGbnQMeqnRo3G
         fO1IW4T8eSxZC3+IR0e/XUBOcR7yckMsSFJE0/6ngZ8sYcyaSlt9Tw1WlpnhX80eqwzS
         oiJ3o6OZZK/vkVit7EeUo64a5b4FquISxLr4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=87syg5cqR3yLkq66KVMLox503xNIYaCuiAAmDxKHkEE=;
        b=oRHwD4vuvV/JMl1+XPXapq4Sv2zfBMttVpXesFwfkKEUM9MQLcGCuh9jNv4OnGyog9
         1WXxuyxK6l/dcIQO72y1nogIiL//NVav2N0+Wb2Q0Oc2nMBFVueuciarhkBM8LqqGa1N
         xosJiqAG+cPUrHsPOkssSri9Zi9dRsaZUtk8Hr/r5l/1y/REHyhEhTryCgXuMsq3U1nl
         LdVJG284ZpJlQXU3JUGRspBTJUkhxnXkLoBPPq7MJ+gCXIPbo3v7b6GD+bxKo+9fIMuG
         941CWiJht7HjEZB9afqHI5wxUC9xBe1i+dfKBsGxdePzmmReSQ0jqWG6/9QLp2Z+qP+j
         K19g==
X-Gm-Message-State: AOAM5313ALsBOvt4DJgjI/lY6URjd7D0pEl8Pc4oNgUBci0Qr6h5vWlc
        qJWg9SQYY3zqU5BBvb1DZBU3qUtPQPLYuyyNmxH9Fw==
X-Google-Smtp-Source: ABdhPJxGkk+jAlWe8yL/2J4MKfnO1ITZrJWDFkQJKnykWmEkhU1KAyMR7ZrNWYXsgjjpUquwglv2mrxLIJtibgrIqPM=
X-Received: by 2002:aca:a9c8:0:b0:2da:45b6:b796 with SMTP id
 s191-20020acaa9c8000000b002da45b6b796mr3843348oie.193.1648172756157; Thu, 24
 Mar 2022 18:45:56 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 24 Mar 2022 20:45:55 -0500
MIME-Version: 1.0
In-Reply-To: <20220324160222.v2.1.Iebdb5af0db7d3d6364cb229a27cd7c668f1063ae@changeid>
References: <20220324160222.v2.1.Iebdb5af0db7d3d6364cb229a27cd7c668f1063ae@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 24 Mar 2022 20:45:55 -0500
Message-ID: <CAE-0n52XzXDk2oJSN2G=GiWe+8QCizEp7rb3e=E9+FLagh5ZnQ@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: qcom: sc7280: Add device tree for
 herobrine villager
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matthias Kaehlcke (2022-03-24 16:02:28)
> Add a basic device tree for the herobrine villager board.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
