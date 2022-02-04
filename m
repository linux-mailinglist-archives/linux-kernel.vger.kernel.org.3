Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6384AA38B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 23:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353719AbiBDWu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 17:50:27 -0500
Received: from mail-oo1-f50.google.com ([209.85.161.50]:43942 "EHLO
        mail-oo1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236013AbiBDWu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 17:50:26 -0500
Received: by mail-oo1-f50.google.com with SMTP id v17-20020a4ac911000000b002eac41bb3f4so6268953ooq.10;
        Fri, 04 Feb 2022 14:50:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AvbucQDEFjinAdRwwOgjGSsbKX2qsrrC6adh1LZlXSg=;
        b=0V6tfWwbjQe7zwQh/cJ8FzH8QgRQwwdYk3te5yEZW7tSfyETNJdt4MjzGLPZPx+IMD
         FyeY7qs0oAtrcP2MkcMN12H4rvE9Psc/qPW0ms8zD901/urnpcKHsf2iG74NRsNCvfXE
         TZ9j0exYiGn7cHLYYpgTksLYkT0xdH86xytj7V5i9R1+djNPrNgFcBiWLER0ERkOWqpE
         kYY7JDH/s52aFKznV89s94Mrq0DWbZGDnDPvjW6+2+IWNcoSpJNhi5e+M3rSFJL9fD3/
         6uQd8A9HxgFRE2bNtIVp8Vq5B6gbL78q1F5xkPe2tJEevzTEKSIw/BukPLWcNEdlqAm2
         AjrQ==
X-Gm-Message-State: AOAM533CrbzGgPB5rEGbdww5FLRSB82ZOE1lPEmyWGqAvDtEsoUj5SC2
        0cD2C2EoG6jg7Te1Om85yA==
X-Google-Smtp-Source: ABdhPJyKbQ5XhmSZdxwGFvkH2pRYUfJIyNahUJA0wuOOlVKLPIKsmJ5Qa5+DNkk4uS8oPdj/0H/jPg==
X-Received: by 2002:a05:6870:36c1:: with SMTP id u1mr338765oak.159.1644015025791;
        Fri, 04 Feb 2022 14:50:25 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id v78sm1354836oie.18.2022.02.04.14.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 14:50:25 -0800 (PST)
Received: (nullmailer pid 3329417 invoked by uid 1000);
        Fri, 04 Feb 2022 22:50:24 -0000
Date:   Fri, 4 Feb 2022 16:50:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Cc:     quic_pheragu@quicinc.com, quic_sibis@quicinc.com,
        quic_saipraka@quicinc.com, quic_tsoni@quicinc.com,
        quic_satyap@quicinc.com, linux-usb@vger.kernel.org,
        bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, greg@kroah.com,
        quic_psodagud@quicinc.com, quic_rjendra@quicinc.com,
        devicetree@vger.kernel.org, pure.logic@nexus-software.ie
Subject: Re: [PATCH V5 2/6] bindings: usb: dwc3: Update dwc3 properties for
 EUD connector
Message-ID: <Yf2tsL2X3DVlfs2G@robh.at.kernel.org>
References: <cover.1643880577.git.quic_schowdhu@quicinc.com>
 <48672133dbd76b2b274533b030233e7ba2db8fa6.1643880577.git.quic_schowdhu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48672133dbd76b2b274533b030233e7ba2db8fa6.1643880577.git.quic_schowdhu@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 03 Feb 2022 16:04:31 +0530, Souradeep Chowdhury wrote:
> Add the ports property for dwc3 node. This port can be used
> by the Embedded USB Debugger for role switching the controller
> from device to host mode and vice versa.
> 
> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> ---
>  Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
