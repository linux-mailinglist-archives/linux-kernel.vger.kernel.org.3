Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A21A648BC36
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 02:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347551AbiALBLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 20:11:21 -0500
Received: from mail-oi1-f176.google.com ([209.85.167.176]:39744 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235242AbiALBLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 20:11:20 -0500
Received: by mail-oi1-f176.google.com with SMTP id e81so1437111oia.6;
        Tue, 11 Jan 2022 17:11:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n6DSfu+PqF/GBnpXnbAGjaaR/CYTN7WoI/Xnkuo05eo=;
        b=UFswp2WSZ5JXk6pHuyFq+wsF5sJdShajcqnXhqr4D9xIfzhf3mfOMXgqvLcau7AGr4
         I0AupINok8iRLy0sGqmrimXkFhUPO9nUKtxR7IKuIvn67CBAnUTujsDNTkCfRweOvE4W
         u9WlFHTFdFQXvwcC4Ln1KstdP9rOUOALc9mRDZLJOHWLMIJPS+2fYaKXoCK0dyu2ze1+
         5Qb1XQYpAe4riOwIeVgW2sGBP416cEKkhCpX/ZmMZDwoA3QsGs70k9h4U6uf6wweE+vr
         bbDjzsqW5cIgEwMp/8GumDWW2TZDCQggm6hGtuZ1RJUT5IZw0/QKlPaJxm3RT0Q/rNUH
         LxpQ==
X-Gm-Message-State: AOAM533W8vBgoZ2XQCdBrS040FUctWZx7S4bkaCMnnqGwniAgqqo/dZf
        pcLzARzZIeWZJ0lHCaA1J2y3GtV6eA==
X-Google-Smtp-Source: ABdhPJxuZzLlvxUjetzMcRVw2DduJX7rF0WypNXDtBM7eYpP2cVW4BCJA5Jnybtp5naFmvJYBwlAUA==
X-Received: by 2002:aca:62d7:: with SMTP id w206mr3697686oib.90.1641949880022;
        Tue, 11 Jan 2022 17:11:20 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id y21sm1957777oix.56.2022.01.11.17.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 17:11:19 -0800 (PST)
Received: (nullmailer pid 3842508 invoked by uid 1000);
        Wed, 12 Jan 2022 01:11:18 -0000
Date:   Tue, 11 Jan 2022 19:11:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        Nishanth Menon <nm@ti.com>, Andy Gross <agross@kernel.org>,
        devicetree@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Niklas Cassel <nks@flawful.org>
Subject: Re: [PATCH 3/7] dt-bindings: opp: qcom-opp: Convert to DT schema
Message-ID: <Yd4qtkwFXchiY4eI@robh.at.kernel.org>
References: <20220104132618.391799-1-y.oudjana@protonmail.com>
 <20220104132618.391799-4-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220104132618.391799-4-y.oudjana@protonmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Jan 2022 13:28:36 +0000, Yassine Oudjana wrote:
> Convert qcom-opp.txt to DT schema format.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>  .../bindings/opp/opp-v2-qcom-level.yaml       | 60 +++++++++++++++++++
>  .../devicetree/bindings/opp/qcom-opp.txt      | 19 ------
>  2 files changed, 60 insertions(+), 19 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml
>  delete mode 100644 Documentation/devicetree/bindings/opp/qcom-opp.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
