Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6767B4DCE72
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 20:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237842AbiCQTF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 15:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235884AbiCQTFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 15:05:55 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFCE9173343
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 12:04:37 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id q189so6571066oia.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 12:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=PTrq+i/bGKZJZ1/dcLd05WBn7gQSypRU9ywl3uB8x7I=;
        b=EkYXPGMPsWiDCE2YFJ5w7Rgyi1LZqt8BGuoM++4ITvaiizidb42FtQf8qU9EFRRSOw
         yPFCcDdQ/oBlsJwV+AbUAlKkyam2vKkzTDye69FKm1N39eCDFTZ73z33ufSMZDLCE1xl
         bGcIbChB2r0RaN/TWWdRjHvEhlqg/Vdrimub0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=PTrq+i/bGKZJZ1/dcLd05WBn7gQSypRU9ywl3uB8x7I=;
        b=q3u79X/eT+5KLJ8z5d91glh0fU0SHh2RKYw2zxJuP4mGYxsZzRf0jn34o/ToGGEZxm
         //9rBPpFBxdz3LfNevRyR/1Fd043XGM1uBmjF4PormRElG1FXEdDSWfXbCclfL+tflxb
         +95iTJSai02EEfU1imUVXkBfe7+FIqtEeRY2gU3HIP/DlTBZDGv/PjBEVj3oRoZdCXGH
         XlEcn9eTPIuWwMEwBzVgWFPMcY5QFtqQeOFDpEAyCjl3rXBdLzONmF7RFkSIIZ5o8UU3
         VWutnLhgpGqfFcfqqNnXe23R9YBLHFWhYVwvYcAD1smtc5TMV3KfUPfOOrg/veuFxzYh
         0Exg==
X-Gm-Message-State: AOAM530VJ9JJ5m9bmlWfOY5bEB7IvLV60iZ5fK1ivIKRRbdZmUtntyAp
        zjdOSY6BqkO3qBjl05joOn2U4zFVPQB1nKfK0OXMTA==
X-Google-Smtp-Source: ABdhPJzNXndL6BEgQxqQ1axdwcYXSR/8mBVJGvam23HJ2pZ0beqB4k2Mv0rkedW7/iN/K/BzXIzmCSKIETFxyzSgiFs=
X-Received: by 2002:aca:bd41:0:b0:2ec:ff42:814f with SMTP id
 n62-20020acabd41000000b002ecff42814fmr2773961oif.63.1647543877066; Thu, 17
 Mar 2022 12:04:37 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 17 Mar 2022 15:04:36 -0400
MIME-Version: 1.0
In-Reply-To: <20220316172814.v1.4.I37bdb77fdd06fb4143056366d7ec35b929528002@changeid>
References: <20220316172814.v1.1.I2deda8f2cd6adfbb525a97d8fee008a8477b7b0e@changeid>
 <20220316172814.v1.4.I37bdb77fdd06fb4143056366d7ec35b929528002@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 17 Mar 2022 15:04:36 -0400
Message-ID: <CAE-0n51KiG8kw5fnwtRf=mv3zPtA0uZ7YiPd+Ga3wT=RHNnF1g@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] arm64: dts: qcom: sc7280: Add CRD rev5
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matthias Kaehlcke (2022-03-16 17:28:20)
> Add support for Qualcomm's SC7280 CRD rev5 (aka CRD 3.0/3.1).
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
