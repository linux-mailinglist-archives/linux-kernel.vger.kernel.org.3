Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22CB44AA331
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 23:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350379AbiBDWgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 17:36:09 -0500
Received: from mail-oi1-f172.google.com ([209.85.167.172]:37716 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237867AbiBDWgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 17:36:08 -0500
Received: by mail-oi1-f172.google.com with SMTP id r27so10214895oiw.4;
        Fri, 04 Feb 2022 14:36:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MqC4XXsfy4OSQxTMHWMiNrSGa1Al6Yednc9CWOuRGdY=;
        b=b7XaWjDxKYwB50HR91Q8GG3Bpfd7iHh2YnP+gAksQvODVzGv2OGlMxm2eGjpUml/2b
         uol5+WP2iJow3CymgFznLdV3/XWnpnoBejFiWSojizlUVbJOfqJIT3iFL7wNPGXSLEox
         eyQYnVvyXWTVv8Vb2+uG13ZU0YoW2POGeOnoagS+oAbkjxBqDeNHtVySRv3nIKZUJRi2
         h+zvmvOWZzm7JfYY6wUCBDzAAx2jxLboMmrEAavcgESalUr6FBKXUK3rtOFVaQzqup50
         NNgpp+Ik3L/RGF30ScVz6orNozhYsfEygBDHyvvlATiAJPOKiI1+1HtiO+1rRASZITRq
         wHPw==
X-Gm-Message-State: AOAM532cynNQQ8Vf4qtejEzjx+TGXnoHzK0vvG0rrhdJQUkzXT0CQxhN
        q2q1gF4LaekJ1BKUPod2ZQ==
X-Google-Smtp-Source: ABdhPJzZc4Y0D4MVbBqCvKn1BX7lOTSIIrCE3xuG5Qvtfu5aTUoCVarqFItKADANNla6kGX1qln9HA==
X-Received: by 2002:a05:6808:1a86:: with SMTP id bm6mr574161oib.182.1644014167720;
        Fri, 04 Feb 2022 14:36:07 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id e92sm1233655ote.72.2022.02.04.14.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 14:36:07 -0800 (PST)
Received: (nullmailer pid 3308882 invoked by uid 1000);
        Fri, 04 Feb 2022 22:36:06 -0000
Date:   Fri, 4 Feb 2022 16:36:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Fenglin Wu <quic_fenglinw@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        sboyd@kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, collinsd@codeaurora.org,
        subbaram@codeaurora.org, tglx@linutronix.de, maz@kernel.org
Subject: Re: [PATCH v5 08/10] bindings: spmi: spmi-pmic-arb: mark interrupt
 properties as optional
Message-ID: <Yf2qVi8Xj/iYYRNm@robh.at.kernel.org>
References: <1643178713-17178-1-git-send-email-quic_fenglinw@quicinc.com>
 <1643178713-17178-9-git-send-email-quic_fenglinw@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1643178713-17178-9-git-send-email-quic_fenglinw@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 02:31:50PM +0800, Fenglin Wu wrote:
> From: David Collins <collinsd@codeaurora.org>
> 
> Mark all interrupt related properties as optional instead of
> required.  Some boards do not required PMIC IRQ support and it
> isn't needed to handle SPMI bus transactions, so specify it as
> optional.
> 
> Signed-off-by: David Collins <collinsd@codeaurora.org>
> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
> ---
>  Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.txt | 2 ++
>  1 file changed, 2 insertions(+)

This will collide with converting it to DT schema[1].

Rob

[1] https://lore.kernel.org/all/20220131172450.2528065-2-vkoul@kernel.org/
