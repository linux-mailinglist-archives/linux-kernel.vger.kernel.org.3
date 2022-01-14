Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D83FE48EC58
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 16:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238509AbiANPLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 10:11:35 -0500
Received: from mail-oi1-f174.google.com ([209.85.167.174]:38858 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235467AbiANPLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 10:11:33 -0500
Received: by mail-oi1-f174.google.com with SMTP id g205so12557850oif.5;
        Fri, 14 Jan 2022 07:11:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OwE/kGLnS5iQbqtKSaybBo+aZ5yq0F8H0aHTUDEwdhE=;
        b=qMmY6s9VuqUNRRmD0CUfnS8QxO4bvHqm/TMrWsbSwujcFy23m0UC/Mus+KWR/+9eoM
         Ig65ICNRNo2U3ytTrHdhfjCwABoRzTuvb16zrOsLPnEqmBasvBTaUKxKuQ9DAQke/PLo
         aE8SKqx5CewSLw5/WoQ5br3R7ekA71aWxxD4hCICIsPrb9R+q3CmALiS23Q8JynhQitr
         A85gGX3S4/PPSNTVeeiOxN1686tgnLifCVnerYieB8dO2IX8GKLsuV3C869M3UkFxHk0
         SZsIWnHmHmD5MMMEIxYywvsCYxWPi0LqnFJybCGtRGL2Vr1GUhjcaMpN/2jqWCZL05/d
         //Yg==
X-Gm-Message-State: AOAM533uiRJtb6xi4PjpVwYL5asfGp4/o4aids5qPUQsuZvCGuw5lXhb
        JniNYnfzT86PjQGbit+9Q38w9BU9dA==
X-Google-Smtp-Source: ABdhPJyky5vFCsncViIHnHxC6rEvmbXf+yavENcKwCON9tp28EJ12J09c0Hlt7h+VTnHllmnj0V8Fw==
X-Received: by 2002:a05:6808:199a:: with SMTP id bj26mr13040326oib.98.1642173092903;
        Fri, 14 Jan 2022 07:11:32 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id i7sm2131864oig.15.2022.01.14.07.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 07:11:32 -0800 (PST)
Received: (nullmailer pid 1900294 invoked by uid 1000);
        Fri, 14 Jan 2022 15:11:31 -0000
Date:   Fri, 14 Jan 2022 09:11:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stanislav Jakubek <stano.jakubek@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: trivial-devices: fix double spaces in
 comments
Message-ID: <YeGSo++HtddDqTxt@robh.at.kernel.org>
References: <cover.1642080090.git.stano.jakubek@gmail.com>
 <13b3f66efd3b20f1d9bbb9eff1eca00757ac5367.1642080090.git.stano.jakubek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13b3f66efd3b20f1d9bbb9eff1eca00757ac5367.1642080090.git.stano.jakubek@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jan 2022 14:39:20 +0100, Stanislav Jakubek wrote:
> Cleanup double spaces in some of the comments.
> 
> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

Applied, thanks!
