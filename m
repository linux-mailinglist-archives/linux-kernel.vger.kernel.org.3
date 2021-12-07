Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39BA946C6A9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 22:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241860AbhLGV1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 16:27:12 -0500
Received: from mail-ot1-f47.google.com ([209.85.210.47]:44732 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232531AbhLGV1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 16:27:11 -0500
Received: by mail-ot1-f47.google.com with SMTP id u18-20020a9d7212000000b00560cb1dc10bso532655otj.11;
        Tue, 07 Dec 2021 13:23:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wLQUVhoOIrV+SG+OfV5ZhN+x+ayCKbri/7qd97/xTXE=;
        b=AigEuYBabWnDtamdMdWIbbSsxvqEAYQBNrffDMqcPDfyrkE4vEeS4cderx4O5D7C5o
         UgfmRGHduazb10C5PgjNfWp1erOrohvUGkOA2WmbSADGOFCJ2LDuzEaxOqWnmLPFyvb/
         jtFwDvqzLFZedS4v/dB5w4yWg3wOr7S4QwKBBCNpbjBCoJUuriGSs8cx8qZCoNOKTVQS
         Z9OLSr2EB5XatQHyayI3GhvB0uMTDg4pQzOzDRPQCHmB7rgJR0IDGARRDZC7+39SmYeb
         lj5RWSz1pRTb4DjfZQKOfKN5dS48dgd4VxhRX0ofCu+0ZXplbYkuIMKT8MOxp1aItisC
         OTFA==
X-Gm-Message-State: AOAM530F2cgpRVf9NN1xgYBfyVQ404GW4EY2lztLgeZU0PITZIyCc3J2
        XV7Z+FC+vDQ0cmRnydOf+g==
X-Google-Smtp-Source: ABdhPJyTL3O6ptXUFAKiAPyylqoTjSIYVcDq6UiJTyxMVOCdO27TZ8dpog3aaOBIPjPhG9TL27sZEQ==
X-Received: by 2002:a9d:6a84:: with SMTP id l4mr37543822otq.216.1638912220695;
        Tue, 07 Dec 2021 13:23:40 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id ay40sm187979oib.1.2021.12.07.13.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 13:23:40 -0800 (PST)
Received: (nullmailer pid 856815 invoked by uid 1000);
        Tue, 07 Dec 2021 21:23:39 -0000
Date:   Tue, 7 Dec 2021 15:23:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Christian Hewitt <christianshewitt@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Benoit Masson <yahoo@perenite.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFC PATCH 8/9] dt-bindings: arm: amlogic: add H96-Max bindings
Message-ID: <Ya/Q284LTMwVMEbE@robh.at.kernel.org>
References: <20211130060523.19161-1-christianshewitt@gmail.com>
 <20211130060523.19161-9-christianshewitt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130060523.19161-9-christianshewitt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Nov 2021 06:05:22 +0000, Christian Hewitt wrote:
> Add the board binding for the Haochuangyi H96-Max STB device.
> 
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
