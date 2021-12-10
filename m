Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55DA6470C6D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 22:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243990AbhLJVWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 16:22:34 -0500
Received: from mail-ot1-f41.google.com ([209.85.210.41]:36813 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237810AbhLJVWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 16:22:33 -0500
Received: by mail-ot1-f41.google.com with SMTP id w6-20020a9d77c6000000b0055e804fa524so10923432otl.3;
        Fri, 10 Dec 2021 13:18:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Our/pN1IyVCtIS8mIewFtFMewda+bHas4rs49FN0p6s=;
        b=AuD+fk2nosTEh3Czs84hVGel+XuphL6XD0oHAoZvNTMmyuGgYU9ib5o7Xn21WIVLA2
         O31RA1ulWt9PdwwYSR8wwTlzDDURuIuBry6QAeBcxmXOC2wOCtahCLjzKAD+XlST2c8O
         BPMoRreQPOmTLApoiRuC//rWZtGaQGZQxTmKov5UCP049NHSMwICKx73V9TSjBs5Z5bU
         fTrtiOmHv1fIQGgodnAT4OSodD/tC/m+1QtgGSS/XVI2AtAU0gGE2pUsJiKYk5WkOz0v
         3NH4SjCVIJ+KeC4d+hCmpK0cEEq8FBtvPRShZe2H/XHfIBPlS2voOPcEbEYg6M7q3D8I
         mUWQ==
X-Gm-Message-State: AOAM532gW0RqLzV8ooRoJWeLPn3xTUc2GaxXEgvW4PW6LXSUbhzJ66Oo
        jFyCNzL/XMlnz0JSw9krprvrrh9tjQ==
X-Google-Smtp-Source: ABdhPJyHmK8KkTYDC8dC39vS4BDv14WHjiA1TtUa3WbDo5zSxnrrirNWYG/gK9DPHglZ1YKjtd2FmQ==
X-Received: by 2002:a9d:1e1:: with SMTP id e88mr12745468ote.75.1639171137206;
        Fri, 10 Dec 2021 13:18:57 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id x16sm741453otq.47.2021.12.10.13.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 13:18:56 -0800 (PST)
Received: (nullmailer pid 1916612 invoked by uid 1000);
        Fri, 10 Dec 2021 21:18:55 -0000
Date:   Fri, 10 Dec 2021 15:18:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tommy Haung <tommy_huang@aspeedtech.com>
Cc:     linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        airlied@linux.ie, linux-aspeed@lists.ozlabs.org,
        devicetree@vger.kernel.org, joel@jms.id.au,
        linux-kernel@vger.kernel.org, BMC-SW@aspeedtech.com,
        dri-devel@lists.freedesktop.org, daniel@ffwll.ch, andrew@aj.id.au
Subject: Re: [PATCH v5 7/7] dt-bindings:ast2600-clock Add CRT reset define
Message-ID: <YbPEP9VoYdDWitez@robh.at.kernel.org>
References: <20211208013337.13806-1-tommy_huang@aspeedtech.com>
 <20211208013337.13806-8-tommy_huang@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208013337.13806-8-tommy_huang@aspeedtech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Dec 2021 09:33:37 +0800, Tommy Haung wrote:
> Add new CRT reset define for ast2600.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Tommy Haung <tommy_huang@aspeedtech.com>
> ---
>  include/dt-bindings/clock/ast2600-clock.h | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
