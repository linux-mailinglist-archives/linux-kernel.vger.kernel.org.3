Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0115A517B58
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 03:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbiECBDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 21:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiECBDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 21:03:22 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A8C4B1E5
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 17:59:43 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id s12-20020a0568301e0c00b00605f30530c2so6958023otr.9
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 17:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=PqPv3sukjDPfWFVVv2QmzL0BRFz4buvp3OmCyU+0818=;
        b=RAtI906hs/kp540GhWQ0A94Gkyla/8HnZVa1xTJKQ7MsrVFNPtwGGP8COs35R2rDzz
         WfMC+zIhqWmbvdC8q0RYd2/TUl/cYQ3WXAKtwqH9hzVha7UYJ9EE7y6rAZSK3ykOEX/n
         KxQKyP5GPlyNsVzOsEqacG/f4paG5MVhovcM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=PqPv3sukjDPfWFVVv2QmzL0BRFz4buvp3OmCyU+0818=;
        b=LUyXilqnXxr92FCq9AaZ7E65JJCbdGpuBwgG0fsV7lzfnv7230OpIqBBc/5O+ncWwM
         vXR2ZXhln8aTrF9ZGViyMF/zUxO+QPQ69YvsCpyozD6RVWhOKkEVOdlwUViq7Vqrtl41
         HtzfBHs9bz6kDwRMfJS8h4sEIGIxJseSeWf1lCeq3J0h8mx5KGFXhqSvOaP7gv28Z+zL
         lGaHneyi6GH97NCQihNbLNHmPjeSahbrfnbM41UunSSv3siaN8WFcGsvOQjFcj4Au9L0
         p9bnGAm/M80FmYMAKUYhHiPAihMwtPqpiAY6jIyIYTewEg+jB03VG89iSnajN7RNnl3R
         Ct5w==
X-Gm-Message-State: AOAM531szw2odSuQl31q9zYKh3S27Kab8bIv5FKN1mAY7pWtMk51XZh7
        Ty4JcHm8hUzZDOXSpMvQ+5tp/wB4EQ+golzFomg2Gg==
X-Google-Smtp-Source: ABdhPJwXC5LAmqwYvlZ/jur0av0/iVWc1WDfRVb3EUDIbC0lUKd0OVNWqhmTPQVo95mtyDwJY6OcGX5l/l1kozM+bo4=
X-Received: by 2002:a9d:20a1:0:b0:5e8:d2b6:f63f with SMTP id
 x30-20020a9d20a1000000b005e8d2b6f63fmr4960898ota.159.1651539297094; Mon, 02
 May 2022 17:54:57 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 2 May 2022 17:54:56 -0700
MIME-Version: 1.0
In-Reply-To: <CAPUE2usLO-sJLP64ZgBrzYBwuZf2tSvKvr9GxcVEiQk7d==OiQ@mail.gmail.com>
References: <20220503004156.3559940-1-swboyd@chromium.org> <20220503004156.3559940-2-swboyd@chromium.org>
 <CAPUE2usLO-sJLP64ZgBrzYBwuZf2tSvKvr9GxcVEiQk7d==OiQ@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 2 May 2022 17:54:56 -0700
Message-ID: <CAE-0n50neMUBqPbmne-AUT-K2KJZCV4GxQHQoShxveFj9kon6w@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: iio: sx9324: Add CS idle/sleep mode
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Gwendal Grignou (2022-05-02 17:50:02)
> Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
>
> Nit: you may want to add an example.

Good point. I can add to the example and resend. I'll do it tomorrow.
