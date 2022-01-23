Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 222B849727E
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 16:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiAWP2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 10:28:45 -0500
Received: from mail-oi1-f177.google.com ([209.85.167.177]:37712 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237553AbiAWP2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 10:28:44 -0500
Received: by mail-oi1-f177.google.com with SMTP id bf5so21451693oib.4;
        Sun, 23 Jan 2022 07:28:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mhtE1LVB3MQJZbryNo8dM4fDZs1igeneOauPP9QC/fo=;
        b=jEIW4aCdNP5wMiCu7yizPA4RvpMxhjbh/DuhLwX20lHfrqNlh9aUS5fKhURor0d18N
         sip7F+YDFXNMKnEBtaqkMgDVA9VwogQ04jiSM8AER3ZiB5wc2Ab3h4jhi9MZ3Gre0abh
         2M+qSEyoc8EfDmIROE6HEX+quoBOb3A3HjgQonJ6gKE+YaTgqYl4eIOktkwhRWAC5CeO
         RAZLoz6fCpZwvhok90RAN+uoe+b9B1h4v6eSu3MWTyGyAYiqvmjjtBtfUyZhDLOY12yO
         YIwdkodeBWjY6po4p+g1kmByiPACXV80ACczvXhkqnGurXU8fTxrmKHdiXDV/Cj7vdTJ
         pdCA==
X-Gm-Message-State: AOAM531KKcq7WqYFYZj1xzwnncKgHvfGNNWAKNytKtu3ysIsyKJzdbYd
        GShylCgrO70IkbNW8DEvAYxW+gc9ng==
X-Google-Smtp-Source: ABdhPJzBcK0ZrTr6KOnrHmelSHzv9xAuPFaR7EfAGDGFiYKPE7uCaTbp8MZVtNmr0Tj8PsN0KvcxWg==
X-Received: by 2002:a05:6808:6ce:: with SMTP id m14mr1691617oih.150.1642951723709;
        Sun, 23 Jan 2022 07:28:43 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id m4sm3755657otn.40.2022.01.23.07.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 07:28:43 -0800 (PST)
Received: (nullmailer pid 1427852 invoked by uid 1000);
        Sun, 23 Jan 2022 15:28:42 -0000
Date:   Sun, 23 Jan 2022 09:28:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kumar Thella <sthella@codeaurora.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] dt-bindings: nvmem: qcom,spmi-sdam: Drop child node
 schema
Message-ID: <Ye10KqH2AmL0fs/R@robh.at.kernel.org>
References: <20220119151135.3598392-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220119151135.3598392-1-robh@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jan 2022 09:11:35 -0600, Rob Herring wrote:
> Drop the child node schema. The schema for child nodes is already
> defined by nvmem.yaml and doesn't need to be duplicated in the
> qcom,spmi-sdam schema.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/nvmem/qcom,spmi-sdam.yaml        | 28 -------------------
>  1 file changed, 28 deletions(-)
> 

Applied, thanks!
