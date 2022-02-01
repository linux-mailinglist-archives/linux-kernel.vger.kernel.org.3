Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7DC14A631F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 19:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241700AbiBASCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 13:02:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241685AbiBASCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 13:02:41 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1EACC06173D
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 10:02:40 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id d5so17810909pjk.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 10:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7tCuLpr8/2LBd/9CIpx4oGmqp37+2g63+QcCiU/FCcw=;
        b=WRl/nbwxyaq3khTLqkQsbbrLAhitrAJ2FYxxMArSCY2yDpkbMexbTkPQ/RuZnaYkNi
         ZnBhgIuT6IIHsyKJmz6cPqPsJRwux/Azf8/l4yOhwuFiLcToLfsWkWjcrbZqfuDNhxTK
         vCh0Iq5VxbmUxjgw3QAtq94h2KC0Fdq8wF0RA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7tCuLpr8/2LBd/9CIpx4oGmqp37+2g63+QcCiU/FCcw=;
        b=gYnCN55RrVh7j4uaszM7cxGV177BGQoAWhVYf+lPRo/w2OfxHoMeOtcgH6K8wUK5VB
         bflJluf9Ipdu6SbGm1uOZzfAo6hGT6u3m3JhhKcOOFtcF9PhggSDC2XMW2LA4ana2fAT
         wkEFt++6RaOUNHyYwGdCCOv0UDmh+j0JVjZgc8gUXstmhSegVoQXYFYXT99nR7tn0Lde
         tgZq5SktegcMpBs581k1JVp43MEVhfHsqyaTyyrIJioom/Uc6WsAhzgpmS99++fNz+UE
         2AgWmtLpGZcMA5uI6zvlPAIvTx6NXYs8Q/HUbtG8Em1nw/ojM/8irg/UXaoXCuEr032N
         Dqow==
X-Gm-Message-State: AOAM531nce8QGwvKQ+6fGl0Ip2TtFzC2wwBOBMfZmLntZad3LnYeGhSW
        fR+dLQNfFKGQgZNvYnVIfv6qCQ==
X-Google-Smtp-Source: ABdhPJzkP0PD5MmdFUYKdgkq732oNkEdLisECygqJK28T1AYcbgd81rLTJ3aIVEd+HlxmG9dQz1XkA==
X-Received: by 2002:a17:902:e803:: with SMTP id u3mr27005923plg.151.1643738560350;
        Tue, 01 Feb 2022 10:02:40 -0800 (PST)
Received: from localhost ([2620:15c:202:201:aca9:b3a5:6f80:8fb5])
        by smtp.gmail.com with UTF8SMTPSA id h5sm23127901pfi.111.2022.02.01.10.02.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 10:02:40 -0800 (PST)
Date:   Tue, 1 Feb 2022 10:02:38 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Shaik Sajida Bhanu <sbhanu@codeaurora.org>,
        swboyd@chromium.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] arm64: dts: qcom: sc7280: Properly sort sdc pinctrl
 lines
Message-ID: <Yfl1vnHvmoLt6ATK@google.com>
References: <20220201001042.3724523-1-dianders@chromium.org>
 <20220131161034.3.I6ae594129a8ad3d18af9f5ebffd895b4f6353a0a@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220131161034.3.I6ae594129a8ad3d18af9f5ebffd895b4f6353a0a@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 04:10:40PM -0800, Douglas Anderson wrote:
> The sdc1 / sdc2 pinctrl lines were randomly stuffed in the middle of
> the qup pinctrl lines. Sort them properly. This is a no-op
> change. Just code movement.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
