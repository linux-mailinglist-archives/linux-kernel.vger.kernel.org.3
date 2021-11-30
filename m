Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85C03463FD7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 22:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344051AbhK3VYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 16:24:49 -0500
Received: from mail-oi1-f170.google.com ([209.85.167.170]:43943 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343986AbhK3VY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 16:24:28 -0500
Received: by mail-oi1-f170.google.com with SMTP id o4so43917721oia.10;
        Tue, 30 Nov 2021 13:21:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EnYmfx8giShC8GUrgXBqC90GxezVG9WH5oK6EegRgDM=;
        b=f6+RjPJxhKNPoNlJpOw0ZgdxPb+AKQxjlgItB71vjqbs64i19LHnw0OnGkm9DI6maE
         3e5Zfgq0rjymi++9Xd0HEiEUt136tmq6Qe+Em0rvKI3C2THEk89nMmqXu/Xe+axHxj+a
         TWLXVxzVYItYB9dIeEwWpYiqYxQD5XfaIatZNmgRfKO1iu9WtdufkuNKB5Y9JYuOh94m
         9AsRbF4pUPo8pqNaY2MZwuUkIS60MwQlJYw34M/Az6C1zFpT7prI9O6OkWwdF62lyQYW
         vQ0gJnzCLP+K7lfjNK+KLUIe+Sf6H5XdF0KGH3BWHKzTePZWqjbtcrkE0MjMZlpBLKu9
         VxOQ==
X-Gm-Message-State: AOAM533yg6pFg38ynFyA5yACR6qiOXuOAIhI54Qam0YcmQzSKQUCFX1X
        +2G+Z9mfxgoGc1oyAevdUQ==
X-Google-Smtp-Source: ABdhPJwqgJnjlll5pKM1eVokAMQhADor5WcEjU1sCUKxsLFRE16yTxFbtFpZW/mK1PWS2rvESLgAaA==
X-Received: by 2002:aca:eb53:: with SMTP id j80mr1508357oih.85.1638307268309;
        Tue, 30 Nov 2021 13:21:08 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id s17sm3353352otp.20.2021.11.30.13.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 13:21:07 -0800 (PST)
Received: (nullmailer pid 3031642 invoked by uid 1000);
        Tue, 30 Nov 2021 21:21:06 -0000
Date:   Tue, 30 Nov 2021 15:21:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Vincent Knecht <vincent.knecht@mailoo.org>
Cc:     linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, stephan@gerhold.net,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [RESEND PATCH 4/5] dt-bindings: input: touchscreen: msg2638:
 Document keys support
Message-ID: <YaaVwqCW7XgP6Srm@robh.at.kernel.org>
References: <20211123081433.2797395-1-vincent.knecht@mailoo.org>
 <20211123081433.2797395-5-vincent.knecht@mailoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123081433.2797395-5-vincent.knecht@mailoo.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Nov 2021 09:14:32 +0100, Vincent Knecht wrote:
> Document optional linux,keycodes support.
> 
> Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
> ---
>  .../devicetree/bindings/input/touchscreen/mstar,msg2638.yaml  | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
