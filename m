Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703FB4DCE06
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 19:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237679AbiCQSxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 14:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237673AbiCQSxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 14:53:17 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0C4221BBF
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 11:51:58 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id x26-20020a4a9b9a000000b003211029e80fso7579471ooj.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 11:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=Ln5X3FYiET6quLutW+fBa5PAa2R/NGbsBbvlqsFX1AM=;
        b=eapkJ4LZQY8T81pdnb187KvmOcaFP3Md1t6sfp1G8G5IWg2d+1ijy0HUIQ/Rhtr9Pf
         3i5adY8bAYnRNC2pTJL6939FgWt2BAmYngpDRoOW/xazsRctafz1SHRzzhEz033at/HX
         HkR2YNNeBCqsp6DbDcwqnq+n/HBd9PtSJAEA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=Ln5X3FYiET6quLutW+fBa5PAa2R/NGbsBbvlqsFX1AM=;
        b=HqzbXyzEKWfd/X0xvmQTi1/XmE4VKGxZ7wuIZe3qbpeDe8zuDKdMv0e5SoDEl9wygo
         JzmfeF2x4usmVYWbtpwehWuhOYhNPMYmrb0zn9NlUInCWpAzqeF7DJ2cJ2QQgAX5kZfg
         4bmZ7GKcVGwW6YWMKSou/j6I86h1Vkgf12wcJPt/eozxhM065Z6AcYxxmWBpBeOya60B
         QD/azvsKKxRkx32yl1xDrBGHa8dUpq2z11x1Cj+R9Xa4Mq5akw1eWkEQiSkz1UH3Ypxo
         OI1Xbm+AiQcx6I//2iSjJOKpT2d3Tamb/8/hY9TixxRaTGD60godn1ThlwMVaRbaiKZy
         dOLA==
X-Gm-Message-State: AOAM531CdPffOCh+VfZyy2vjXovE1Wo0dNBpqT1iDjsla/uwhWoTTe3G
        bBNB80RKzJdJP7aUVGazpa2vwXhMRS3r7hKtFSY7Tw==
X-Google-Smtp-Source: ABdhPJwMlEAWZFipgY1vRYdu6iNFOqREpoDQgz2PJ1HtzdTvNDo0OlteL+UgXaH2WcO7uGn8L+oyNE0EVybinDppK4w=
X-Received: by 2002:a05:6820:199a:b0:324:15f5:a205 with SMTP id
 bp26-20020a056820199a00b0032415f5a205mr1823338oob.25.1647543117996; Thu, 17
 Mar 2022 11:51:57 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 17 Mar 2022 14:51:57 -0400
MIME-Version: 1.0
In-Reply-To: <20220316172814.v1.2.Ib0fbb7e5218201c81a2d064ff13c9bc1b0863212@changeid>
References: <20220316172814.v1.1.I2deda8f2cd6adfbb525a97d8fee008a8477b7b0e@changeid>
 <20220316172814.v1.2.Ib0fbb7e5218201c81a2d064ff13c9bc1b0863212@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 17 Mar 2022 14:51:57 -0400
Message-ID: <CAE-0n516_kKzdfqz2NYw2ROEAd8_Zu+L_Rb2Kg-RhZAjnKTy5w@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] arm64: dts: qcom: sc7280: Add 'piglin' to the
 crd-r3 compatible strings
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matthias Kaehlcke (2022-03-16 17:28:18)
> With newer bootloader versions the crd-r3 (aka CRD 1.0 and 2.0) is
> identified as a 'piglin' board (like the IDP2 board), instead of 'hoglin'
> Add the compatible strings 'google,piglin-rev{3,4}'. The hoglin entries
> are kept to make sure the board keeps booting with older bootloader
> versions.
>
> The compatible string 'google,piglin' (without revision information) is
> still used by the IDP2 board, which is not expected to evolve further.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
