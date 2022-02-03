Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C7E4A89F6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 18:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352825AbiBCR0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 12:26:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236093AbiBCR0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 12:26:30 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6002FC06173B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 09:26:30 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id d5so3039295pjk.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 09:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Z6SpS9QptYU96quW9luTzw9ThNaE1HmoUOVZScoX36g=;
        b=cO9S4L0SWPKMhccbTIdc21tAwBVZPYZ4V/QD1uCNuaf8SjIddwmhxjQ6H7i8G2itm6
         Gde0gmJqNuKFz9twkijoCNPsB4Qlc4w0SDxyMVgLyRoXTWv87D4B/pHarhhAq4F+SGil
         UNM2+dhoTFjYs93VsquHUmK1z2Gei7SCykZps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z6SpS9QptYU96quW9luTzw9ThNaE1HmoUOVZScoX36g=;
        b=3soMZvxdizyrKokg5QBF8+h5HeAFNtFwamNErw7Gv+k3aEEw+NdgJsdBAdoDJju6xm
         D7Ksb8mQkyXNHY/WLtd8GfJWt27jv0oRpAn7JGkvQAZan478p4hJonCiw0aztColzHb1
         As3Xo8gEC/MPyvYI69SKDHT3TlB+Pr9rYiRt7s/xWPxxLqPws1kdNMONlPm5iNXYCsDl
         4zmfZHN6o+8mTXAuPBV74tjy/fK996asNoNHRqGw4ZtvBssnHrr1lWr0giT06g5j0f//
         +aOaJD0Prp3Aiz+Rw+hkn7XISPvdQYKLMpuBRDELgmswSGiE60gm1G32AYC1zKntMZyK
         IQ7g==
X-Gm-Message-State: AOAM533q93/+k8AtyGMvMq8rLurrxnen5YBBpZS7JvZN+Mx/NmdjCJhA
        9bc09SMdt/ug28iZlqNZcA1RVg==
X-Google-Smtp-Source: ABdhPJzeGUouAj32o44EnwlqzqpqVfqvlA0LCa8FGONduH5+BYREFp7ZXfsLIql1Ruv5KJfLE/mpqg==
X-Received: by 2002:a17:90b:350c:: with SMTP id ls12mr14795500pjb.44.1643909189886;
        Thu, 03 Feb 2022 09:26:29 -0800 (PST)
Received: from localhost ([2620:15c:202:201:c0cb:3065:aa0:d6c9])
        by smtp.gmail.com with UTF8SMTPSA id ip5sm11220315pjb.13.2022.02.03.09.26.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Feb 2022 09:26:29 -0800 (PST)
Date:   Thu, 3 Feb 2022 09:26:27 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        pmaliset@codeaurora.org, quic_rjendra@quicinc.com,
        Shaik Sajida Bhanu <sbhanu@codeaurora.org>,
        kgodara@codeaurora.org, konrad.dybcio@somainline.org,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        sibis@codeaurora.org, swboyd@chromium.org,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 11/14] arm64: dts: qcom: sc7280: Add a blank line in
 the dp node
Message-ID: <YfwQQ4vVfFr13lNc@google.com>
References: <20220202212348.1391534-1-dianders@chromium.org>
 <20220202132301.v3.11.Iecb7267402e697a5cfef4cd517116ea5b308ac9e@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220202132301.v3.11.Iecb7267402e697a5cfef4cd517116ea5b308ac9e@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2022 at 01:23:45PM -0800, Douglas Anderson wrote:
> It's weird that there's a blank line between the two port nodes but
> not between the attributes and the first port node. Add an extra blank
> line to make it look right.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
