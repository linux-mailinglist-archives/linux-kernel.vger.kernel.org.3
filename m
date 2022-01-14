Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08EF448ED14
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 16:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242665AbiANPVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 10:21:55 -0500
Received: from mail-oi1-f171.google.com ([209.85.167.171]:36516 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233576AbiANPVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 10:21:54 -0500
Received: by mail-oi1-f171.google.com with SMTP id r138so12607430oie.3;
        Fri, 14 Jan 2022 07:21:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8AmhnGJCSNUDM/UIAtLN8wxR950/UA5KRmvr92Ibx+8=;
        b=1FMqDEkMJRAW9xplRWSoO92I2alGcL1/5GjySyV2dmJMcCTFei7Vr8/FDwVrAsMKsc
         rXZPkz3ySew9qe8QAnDK+LuQQWF5GyMmLrYRgI9HmRdmuCHuw+pTJklK0LmVEFlLuQpa
         89ChwYHIvArGzl4YJaKIhKrJEgmwH/TakJZi1Bw6mMPDFKIrq7HFCOn8VSv03mXXule0
         lycpen1pN8DT5CmyQYF5y27kXY05nPfIh7i9cz05Zk/5E21TR2x93V6XLLXZolsZND+Y
         ekr8bl7BPo98nwv1rxVRvyLlroo758sCnpfn8cg5kpZOtgFIRFbj6gnWDGWOuHyLM8+x
         vLMA==
X-Gm-Message-State: AOAM532CddcV19fFJXunkqVxat84eFIGNrKfFYjmGhWbiM8GBWL9qyoU
        /Fn66tIDqUKHHMRKbbuVVQ==
X-Google-Smtp-Source: ABdhPJxlq3i6SA4PZ5dIQhbus9aIYv4wQ/BdfdsGJ7GHav8yO5uKAoeBEGisosyhunf4TCZSoiKsmw==
X-Received: by 2002:a54:4601:: with SMTP id p1mr9285724oip.169.1642173713984;
        Fri, 14 Jan 2022 07:21:53 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id i5sm1842986otj.3.2022.01.14.07.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 07:21:53 -0800 (PST)
Received: (nullmailer pid 1913883 invoked by uid 1000);
        Fri, 14 Jan 2022 15:21:52 -0000
Date:   Fri, 14 Jan 2022 09:21:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stanislav Jakubek <stano.jakubek@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: trivial-devices: fix comment indentation
Message-ID: <YeGVEMl5aKgIHZIv@robh.at.kernel.org>
References: <cover.1642080090.git.stano.jakubek@gmail.com>
 <ea7e6b645fb1c2612f14ca62471180a38d51e9f9.1642080090.git.stano.jakubek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea7e6b645fb1c2612f14ca62471180a38d51e9f9.1642080090.git.stano.jakubek@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 02:39:40PM +0100, Stanislav Jakubek wrote:
> Indent comments the same as the content they describe.
> Fixes yamllint warnings like:
> 32:13     warning  comment not indented like content  (comments-indentation)

But that's not a warning we enable or is this something new in newer 
yamllint?

In any case, a change like this can only be done at the end of the merge 
window just before rc1. Otherwise, it is merge conflict hell. I would do 
that, but I really prefer it the way it is. The reason is it makes the 
'-' stand out more and those are easy to miss in yaml. For example, 
these look the same but are a bit different:

- items:
  - const: foo

- items:
    const: foo

> 
> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
> ---
>  .../devicetree/bindings/trivial-devices.yaml  | 314 +++++++++---------
>  1 file changed, 157 insertions(+), 157 deletions(-)
