Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86F1247C2A8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 16:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239237AbhLUPTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 10:19:51 -0500
Received: from mail-qt1-f181.google.com ([209.85.160.181]:33615 "EHLO
        mail-qt1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239157AbhLUPTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 10:19:49 -0500
Received: by mail-qt1-f181.google.com with SMTP id n15so13216226qta.0;
        Tue, 21 Dec 2021 07:19:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jhn6L+LBMMGihOUvIcsbiibaFmeCSn1ijpCpfQZUYKo=;
        b=oxVC+EnVcOs7kxqvSbIcWn7ro4E0d4SNAGuhYu9PchMLP8prjPceIDDv23mL/4K6Z7
         6RAzuOw3gCLNH/+AdZRI7eEbdPq+yowTLczG6/rGZN5HNf1JVAFkTRzmwf7YhtvPAOHw
         czprYwhx6BAktP1+itlGCyxWtYt54YJE4XSYLrIp8yYKPvvByCKv993iQcKqPznraN51
         lN3f8cqVm7Nmy3NVUPAnJUrKFFLQia9oJG2i8qoUqfWV9Gu8jXdyoqyx0D0UgNLmqbKQ
         K3CaXpQEz6cUwKn/yalXDc6qKQCayAS1LasNk6utHI3mTq7SMnRTrxD8MUVxY8f+JZx3
         R2QQ==
X-Gm-Message-State: AOAM53310tqf4oifzMqdJVLUwW/+3JqfhS7fjGnERYwQ5ZRT6bJM1EKF
        /IfhuLxUFoPAJ8rDSovorw==
X-Google-Smtp-Source: ABdhPJy1YHPtDITAx99YSSbS+ZUmgpGbyenEdctyF6U5/LZg3Ybkqx4YHOsFy1ktK+IAsUpYwi8LaA==
X-Received: by 2002:ac8:7589:: with SMTP id s9mr2602203qtq.314.1640099988563;
        Tue, 21 Dec 2021 07:19:48 -0800 (PST)
Received: from robh.at.kernel.org ([24.55.105.145])
        by smtp.gmail.com with ESMTPSA id d1sm1096220qtn.56.2021.12.21.07.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 07:19:47 -0800 (PST)
Received: (nullmailer pid 1436571 invoked by uid 1000);
        Tue, 21 Dec 2021 15:19:46 -0000
Date:   Tue, 21 Dec 2021 11:19:46 -0400
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     linux-tegra@vger.kernel.org,
        Jonathan Hunter <jonathanh@nvidia.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, David Heidelberg <david@ixit.cz>,
        Thierry Reding <thierry.reding@gmail.com>,
        alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1] dt-bindings: sound: tegra-audio-rt5677: Correct
 example
Message-ID: <YcHwksy2hKFZj43h@robh.at.kernel.org>
References: <20211216160229.17049-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216160229.17049-1-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Dec 2021 19:02:29 +0300, Dmitry Osipenko wrote:
> Remove non-existent properties from the example of the binding. These
> properties were borrower from the old txt binding, but they were never
> used in practice and aren't documented in the new binding. They aren't
> reported by the binding checker because dtschema needs extra patch that
> hasn't been upstreamed yet to make unevaluatedProperties work properly.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../devicetree/bindings/sound/nvidia,tegra-audio-rt5677.yaml   | 3 ---
>  1 file changed, 3 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
