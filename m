Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4136E470CE0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 23:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344614AbhLJWNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 17:13:48 -0500
Received: from mail-oi1-f175.google.com ([209.85.167.175]:39585 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbhLJWNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 17:13:46 -0500
Received: by mail-oi1-f175.google.com with SMTP id bf8so15121616oib.6;
        Fri, 10 Dec 2021 14:10:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UI69fhIlE5XSdCKJ2yMxqg1dIhXQ3tzeJCksSrXFyqs=;
        b=dZRbekPlPrQRu6qQjV/3j/hsdWXFRXCuueAZ+bh8cLVcr2yhLgCaqfmPcLRaotqNM8
         gvKVCPxzZAwzNDPhhHU78qYI9yUh4ocjMxmf+Aqy7F22NvpXjC+3dXk/uzUmyLRQJKaX
         CrKLaHbpXsCHtDYPOgMOGxingtVXEv1Q0ri518IpJSNO1Ik0hbVnh9LZv85i4puVwtPr
         W+mEefmyl929fSo97jB3TS2IZ8qzy6JXW0DDPgloz6+e/We6YBjH9KV9Lx2aR15uiQ5r
         aIiqEmUv0US9pUkRaZ1PNTpp2RI/6hJJ2JIwHVf5yYz/0KxNS8SckJXzhc9zeW6/0kd6
         Dxuw==
X-Gm-Message-State: AOAM531SYHtJXBhHFQe7Eoow9mgkVK+5dnf7M2nNJL+FDrBbh+4dVXkk
        y/0ypUXOHVEVKtMQU7Y/Yg==
X-Google-Smtp-Source: ABdhPJyuH5wrjmW02k4zGvufnnUCm+yF6g/3zXu5CgTcTDxczhAk1nmsNkvG9DN2qh3G2mtjVBOmkw==
X-Received: by 2002:a05:6808:1509:: with SMTP id u9mr15617399oiw.13.1639174210918;
        Fri, 10 Dec 2021 14:10:10 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id y17sm747594ote.48.2021.12.10.14.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 14:10:10 -0800 (PST)
Received: (nullmailer pid 2017305 invoked by uid 1000);
        Fri, 10 Dec 2021 22:10:09 -0000
Date:   Fri, 10 Dec 2021 16:10:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Fenglin Wu <quic_fenglinw@quicinc.com>
Cc:     sboyd@kernel.org, devicetree@vger.kernel.org,
        collinsd@codeaurora.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, subbaram@codeaurora.org,
        maz@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de
Subject: Re: [RESEND PATCH v3 07/10] bindings: spmi: spmi-pmic-arb: mark
 interrupt properties as optional
Message-ID: <YbPQQdXbJOO1gGDp@robh.at.kernel.org>
References: <1638403212-29265-1-git-send-email-quic_fenglinw@quicinc.com>
 <1638403212-29265-8-git-send-email-quic_fenglinw@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1638403212-29265-8-git-send-email-quic_fenglinw@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Dec 2021 08:00:09 +0800, Fenglin Wu wrote:
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
> 

Acked-by: Rob Herring <robh@kernel.org>
