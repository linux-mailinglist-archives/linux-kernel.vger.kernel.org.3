Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D399E463FD0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 22:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343989AbhK3VYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 16:24:07 -0500
Received: from mail-ot1-f48.google.com ([209.85.210.48]:43639 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235943AbhK3VXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 16:23:47 -0500
Received: by mail-ot1-f48.google.com with SMTP id i5-20020a05683033e500b0057a369ac614so10632219otu.10;
        Tue, 30 Nov 2021 13:20:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uttqLLzkhZ5PvfjarafBrrsjvdkxiFqyLh0LB7EUbNE=;
        b=eqCgo3LhM+ICVjK1Khn9G+2HNvwSElJdSd5ETQVqddaOX1R0h0lHeEJBk5qvUvoHzU
         7Lll51fTXZ73zMc8sJ9SRmc/2D29/EqULf/omcq0wP3iEu3IRElPSReKp0wTWN899trv
         I/dVn/Wn4OVPIFAsvhVMkgiwtnB8ZA6YCr/I9CMaWRtUytgsn2yAlR4qLalbfMsVMlOx
         Bge0f/6t3fW6M+RIeNWFepE5DqjWFQvKK1g18CIxt0FMNNyxzda9ersvne7lcy3zTZkB
         5YWe0GXsnNEVGclx18ggSFGZ/oSwdWrktPmuAogylN6kKpqQTLxiQGVxlZFmIvkMeR9X
         YA3w==
X-Gm-Message-State: AOAM5330iUdajfBc4pmvDvFZ3sjMrvWggeZE74PjMOnS7gQt9FkBIuKw
        +dr65Cxa/OvvuYPZD6dnTi2g0CPP+Q==
X-Google-Smtp-Source: ABdhPJxtYMzDwKFXZgF6aNVjRjrm9pYF50V1isyFSgu9M5MJsu6PUWm59QiaYe0PF9rjZo7im+4BWQ==
X-Received: by 2002:a05:6830:4414:: with SMTP id q20mr1724487otv.14.1638307226913;
        Tue, 30 Nov 2021 13:20:26 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id i29sm3420074ots.49.2021.11.30.13.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 13:20:26 -0800 (PST)
Received: (nullmailer pid 3030663 invoked by uid 1000);
        Tue, 30 Nov 2021 21:20:25 -0000
Date:   Tue, 30 Nov 2021 15:20:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Vincent Knecht <vincent.knecht@mailoo.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, linux-input@vger.kernel.org,
        dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, stephan@gerhold.net
Subject: Re: [RESEND PATCH 2/5] dt-bindings: input: touchscreen: msg2638:
 Document msg2138 support
Message-ID: <YaaVmfK5X+xckmkB@robh.at.kernel.org>
References: <20211123081433.2797395-1-vincent.knecht@mailoo.org>
 <20211123081433.2797395-3-vincent.knecht@mailoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123081433.2797395-3-vincent.knecht@mailoo.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Nov 2021 09:14:30 +0100, Vincent Knecht wrote:
> Document msg2138 support by adding mstar,msg2138 compatible.
> 
> Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
> ---
>  .../devicetree/bindings/input/touchscreen/mstar,msg2638.yaml  | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
