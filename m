Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6EC647C5B0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 19:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240819AbhLUSHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 13:07:04 -0500
Received: from mail-qk1-f170.google.com ([209.85.222.170]:41816 "EHLO
        mail-qk1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbhLUSHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 13:07:03 -0500
Received: by mail-qk1-f170.google.com with SMTP id t83so13351563qke.8;
        Tue, 21 Dec 2021 10:07:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9lm8wyAI+eUCiBJVOI9uD8VZTFeBdgclDLbUamGhzqs=;
        b=zxnSVL5zBTI6aNB4+9/XbF/0f78xiL6nB+19zMnK5Cvp62J4l3o8B/eFD14scmn8Kt
         aN2162nca3HoV/4utTsoBQaJ0gTBQY+b0eCUo5kaFWE0GQeEPlD59pgjAhBvRQxhoUex
         H+/UOvgXfdPZapN4wwKNu7ipaY18SwrPxSlkerMzK6b/UBc33mduaUGGx7s9wmijq1dH
         e9+NNxKlwcJF4gZXXOuG0rLbK/r/Wniw0LwG0NlBJVbkSRHJ8whIfyBVMwb5ihWE3tPt
         d9OwkldRnJqhShBSsYhM8d8VGnRPE/4LLtQuvRPXkyBGxPRb3LDyqyBzavOZ3yKZeoUv
         uiwg==
X-Gm-Message-State: AOAM531MFFVgehsur5o5syw0ZlHjz2gGNyZYk7lx2ZsuUs+agtM2zQmE
        RGxOH8zDW1JpzsDVExkeHg==
X-Google-Smtp-Source: ABdhPJwtxxelDVKz1HhtQyEdAFpHsZghF1LujIXHGb5Iy575nrVFSwsq+z/bK9LYmvQljz7pd19MoQ==
X-Received: by 2002:a05:620a:4044:: with SMTP id i4mr2895786qko.271.1640110023071;
        Tue, 21 Dec 2021 10:07:03 -0800 (PST)
Received: from robh.at.kernel.org ([24.55.105.145])
        by smtp.gmail.com with ESMTPSA id h9sm14551053qkp.106.2021.12.21.10.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 10:07:02 -0800 (PST)
Received: (nullmailer pid 1510771 invoked by uid 1000);
        Tue, 21 Dec 2021 18:06:59 -0000
Date:   Tue, 21 Dec 2021 14:06:59 -0400
From:   Rob Herring <robh@kernel.org>
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        romain.perier@gmail.com, livelwh@outlook.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: vendor-prefixes: Add prefix for 100ask
Message-ID: <YcIXw5Mmfo7mcroS@robh.at.kernel.org>
References: <20211217093510.3674590-1-daniel@0x0f.com>
 <20211217093510.3674590-2-daniel@0x0f.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211217093510.3674590-2-daniel@0x0f.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 06:35:08PM +0900, Daniel Palmer wrote:
> 100ask is Linux SBC/module/training provider.
> Add a prefix for them.
> 
> Link: https://www.100ask.net
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> ---
>  To Rob: One thing I have noticed is that dtbs_check
>  seems to be complaining about the prefix starting with
>  a digit. If it's a problem I can change the prefix I think.

Humm, we should relax that. I'll add a fix.

> 
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
