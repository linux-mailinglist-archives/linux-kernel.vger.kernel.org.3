Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E59A4D4D7F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 16:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239284AbiCJPo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 10:44:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236938AbiCJPoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 10:44:24 -0500
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7A7159286;
        Thu, 10 Mar 2022 07:43:23 -0800 (PST)
Received: by mail-oi1-f170.google.com with SMTP id s207so6299003oie.11;
        Thu, 10 Mar 2022 07:43:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=soUttN/B2ZCnCYNnwWUyVbvZvUR85ol+lks3Y4uSs3A=;
        b=qSIU1x3rWNb6gAdYMjEzl55e3FRbyvbKCmhbd7jH3xT4AnCS0lE+1z0/DrokfuM+o5
         4K46mGc2celL/2dzaUqDc2XvqIROC2XtQyuugifod4LA7aaxMstW/RWiWBLYwdt+0SjV
         7x7eJcXHpU99E0xmJAoTkmgc/0cx/k3pmG8n4LxGxihh70EKCC8HhBwOyT0ud2plcUtE
         5cNIOhom9MDguriaezi8NtvcAjdImpkMeUb3W44bD/i7TrdYNYXWXxert3Hk77qaCU0i
         rniusVENO2tKjLYkGYe0pMSpjw/8eVUMmeQN6bmholdmf32M05zvaEXK7CkGjvJ3m3Bf
         nQOA==
X-Gm-Message-State: AOAM531ZcJKxEcquOnwo75Zgot9iGyIveCkxk4RxYzYwxNe1XYqMdFdl
        QkXpJLJgvo9bew74YLVayI0hzM22aw==
X-Google-Smtp-Source: ABdhPJx+RO+YLo1BVcqtSo3OVmm1tpYN5f4xdnCT6SLCcYDTlMGm/rRnaq3bxZF+sKnfJg0ZjUR2dw==
X-Received: by 2002:a05:6808:118e:b0:2d9:a01a:4896 with SMTP id j14-20020a056808118e00b002d9a01a4896mr9645757oil.225.1646927002392;
        Thu, 10 Mar 2022 07:43:22 -0800 (PST)
Received: from robh.at.kernel.org ([2607:fb90:20d2:449c:e413:94ed:2767:f2c4])
        by smtp.gmail.com with ESMTPSA id f10-20020a9d5e8a000000b0059fa2fa9b4bsm2455393otl.13.2022.03.10.07.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 07:43:21 -0800 (PST)
Received: (nullmailer pid 1686207 invoked by uid 1000);
        Thu, 10 Mar 2022 15:43:19 -0000
Date:   Thu, 10 Mar 2022 09:43:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/7] dt-bindings: interrupt-controller: apple,aic2:
 New binding for AICv2
Message-ID: <Yiocl203Ix7DLXKj@robh.at.kernel.org>
References: <20220309192123.152028-1-marcan@marcan.st>
 <20220309192123.152028-3-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309192123.152028-3-marcan@marcan.st>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 04:21:18AM +0900, Hector Martin wrote:
> This new incompatible revision of the AIC peripheral introduces
> multi-die support. This binding is based on apple,aic, but
> changes interrupt-cells to add a new die argument.
> 
> Also adds a second reg entry to specify the offset of the event
> register. Inexplicably, the capability registers allow us to compute
> other register offsets, but not this one. This allows us to keep
> forward-compatibility with future SoCs that will likely implement
> different die counts, thus shifting the event register. Apple also
> specify the offset explicitly in their their device tree...

their their

(checkpatch with codespell installed told me)

> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  .../interrupt-controller/apple,aic2.yaml      | 98 +++++++++++++++++++
>  MAINTAINERS                                   |  2 +-
>  2 files changed, 99 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/apple,aic2.yaml

With that,

Reviewed-by: Rob Herring <robh@kernel.org>
