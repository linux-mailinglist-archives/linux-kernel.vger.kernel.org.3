Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8950B473492
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 20:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242047AbhLMTCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 14:02:09 -0500
Received: from mail-oi1-f178.google.com ([209.85.167.178]:36610 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232697AbhLMTCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 14:02:08 -0500
Received: by mail-oi1-f178.google.com with SMTP id t23so24456883oiw.3;
        Mon, 13 Dec 2021 11:02:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tEbAdn5YlO0byAH0oTEvYwIYFWP4wTzxxA3rKsMqgPI=;
        b=u36KqmyV6dkY02q5LDaZEHXGo8MV8d4BQeUxcGScFTcLU6lHR5Xjwq4QSme7yeijbn
         Q3sveiw2kawjod1CYcDx7h1zMqobyMJWctqZdKgQe1jLA+9KGbkLQgFrmKn7XADT9YlO
         B3IrT+ChlxamKQdJAz8UbU0AeZj8tMUeGjCQq9/OEAaRIcxTdvK/Hbj8S09kmy6J0l/N
         zvzsc7Z1VMSHrfxd/wy5MXWRsCCdRGU3YZolgNaZhW3CXOfv+Ed9Y4NfpDFNDLikEsQw
         rs1NtuBZf75q5H6SzflXmtYhYVwS5jKQOqJb/psa3Ajz7caOOzd7KEfw3SprmsD/x4Ce
         TMpg==
X-Gm-Message-State: AOAM531vZwjKKFh2dLhB9KeN7wpS6ZhXin4h32hwY5//ATbJkw2o+kSE
        cDoRFKGr3Eeyn6uJdWxw2MTRnW5GYw==
X-Google-Smtp-Source: ABdhPJwfmZKhTcyermRckjwVUR51Q+PIrNv5i9wFZsuWFt3sXBmR8hmteTCR1F2dx8sSDJV29rTUsg==
X-Received: by 2002:aca:581:: with SMTP id 123mr440392oif.13.1639422127396;
        Mon, 13 Dec 2021 11:02:07 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id a17sm2989012oiw.43.2021.12.13.11.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 11:02:06 -0800 (PST)
Received: (nullmailer pid 1386389 invoked by uid 1000);
        Mon, 13 Dec 2021 19:02:05 -0000
Date:   Mon, 13 Dec 2021 13:02:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: arm-smmu: Add compatible for SM8450 SoC
Message-ID: <YbeYrZmavBECxE/O@robh.at.kernel.org>
References: <20211201073943.3969549-1-vkoul@kernel.org>
 <20211201073943.3969549-2-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211201073943.3969549-2-vkoul@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Dec 2021 13:09:42 +0530, Vinod Koul wrote:
> Add the SoC specific compatible for SM8450 implementing
> arm,mmu-500.
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
