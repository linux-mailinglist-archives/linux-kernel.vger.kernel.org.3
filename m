Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B629B462705
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 23:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235974AbhK2XAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 18:00:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235988AbhK2W7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:59:48 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E6DC03AD49
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 10:08:54 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id k4so6791927pgb.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 10:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rP+kmQ5wlVc+pR2GAaszPahOc1SeLyhDcPjEPnD8vp8=;
        b=Sx+Cd5E8JI8zEmKLPz+YRIFV82PQSl8DV4hUwC+cQ6uo3Vv6YiMyl7IU/7fFxvhdle
         rKahqkKvRC+hEKXAPC0QgJilRZsblIxkNdKQU5+dIUYaVWWHLQ0ngKa2u0efwtrHtlD1
         VtwZjctDXvZQ9/XYhrKHeSxb62V/LHMwNlzE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rP+kmQ5wlVc+pR2GAaszPahOc1SeLyhDcPjEPnD8vp8=;
        b=j6v8yLEGsLhKi1WnwAjmPEhqsEDWAyMNpwCwxnYROZBdOP9EUsWDyHZYWL4IJNwYgO
         X+unFw5X8PZaqTcEbf1+IsgXrK7MUoe8jTV+gYmWP6QxcW3GYjsI/dRrMffc7dam6LIr
         O1bDG8PdBCixxVljFlQcbK2lADsBHcdo1EubHvtrnU+/LNx5bkhYdGM7BmCnR9f4OtmF
         3lefqSQQYNPdC32CqbmEwJRNkC9LjFNvmFAM9kvKDdO6/03/+iNJ7DaFU5NWtcdl1JmK
         pl0SD6hAce2y4CIZdXBV9qaMcEuJri6hZnSEjXNzAqQswXSFJTU8bIBsqQ0JPBb+uC9S
         Xvxw==
X-Gm-Message-State: AOAM531SHBv9VBQmiqnsXBPPBvrdM7jkGiH019oMnspi7x3aqzg/h/0V
        q3KjDIYgmGlqOcy85mxmwoKaXQ==
X-Google-Smtp-Source: ABdhPJyBgug4oG2KvEUDqd0Zf+drGvUYuM0nyMa78y6ktglY2/5CuXmSrvYNfK42nb98+565lrPVAw==
X-Received: by 2002:a63:5308:: with SMTP id h8mr36326936pgb.287.1638209334244;
        Mon, 29 Nov 2021 10:08:54 -0800 (PST)
Received: from localhost ([2620:15c:202:201:d16f:3a09:ab7a:238e])
        by smtp.gmail.com with UTF8SMTPSA id g7sm18644943pfv.159.2021.11.29.10.08.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Nov 2021 10:08:53 -0800 (PST)
Date:   Mon, 29 Nov 2021 10:08:52 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rajendra Nayak <quic_rjendra@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dianders@chromium.org,
        kgodara@codeaurora.org
Subject: Re: [PATCH v2 1/4] dt-bindings: arm: qcom: Document qcom,sc7280-crd
 board
Message-ID: <YaUXNG0EEKsyfbPC@google.com>
References: <1638185497-26477-1-git-send-email-quic_rjendra@quicinc.com>
 <1638185497-26477-2-git-send-email-quic_rjendra@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1638185497-26477-2-git-send-email-quic_rjendra@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021 at 05:01:34PM +0530, Rajendra Nayak wrote:
> Document the qcom,sc7280-crd board based off sc7280 SoC,
> The board is also known as hoglin in the Chrome OS builds,
> so document the google,hoglin compatible as well.
> 
> Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
> index c8808e0..91937ab 100644
> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> @@ -203,6 +203,8 @@ properties:
>            - enum:
>                - qcom,sc7280-idp
>                - qcom,sc7280-idp2
> +              - qcom,sc7280-crd

nit: add in alphabetical order, i.e. before qcom,sc7280-idp

> +              - google,hoglin
>                - google,piglin
>                - google,senor
>            - const: qcom,sc7280

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
