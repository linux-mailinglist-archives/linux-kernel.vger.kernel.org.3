Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D78A48BC4C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 02:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347627AbiALBRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 20:17:00 -0500
Received: from mail-oo1-f52.google.com ([209.85.161.52]:42513 "EHLO
        mail-oo1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347610AbiALBQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 20:16:58 -0500
Received: by mail-oo1-f52.google.com with SMTP id q16-20020a4a3010000000b002dde2463e66so99147oof.9;
        Tue, 11 Jan 2022 17:16:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MlDw3i8kdjl9wX1RFfl4cUNh8M1HeAl2+QgHjiytboc=;
        b=oXjh9HPHWpxyK3twS9YE/ut9L294OUcGN7WSoxtliFX54f21FXMaDCVr21tItKcmMU
         kZpFxBYnB4KSwb8wkuj6FXcS8ySq4HRxEI7sN45Nl8y5820F00fDytgoQY1OLFTw1Zx5
         RAcBfekTlJV+y5hSjVPUIR2JCrqohqXfFLm4x+qrrR9AIQoVkyo5G9zvKjM1f3vitP+x
         BJyxrr+5cXMxbywo6Pu+GkNEjxTPo6/RMwXeAsPOHp1GxPrYG+RavKvJW0lTPaNAxXrk
         GTF23QCUMHcc4424On2Q62FMDJG9SNcUFHP/GXy4Z6ajZF/tWPpWfWpkRyerQSsM0GHx
         CCrw==
X-Gm-Message-State: AOAM532KT9pM/6YwmrVh+sUo/tx2bfOSJVQV/JvQKSY5Rj0x8t0qs20J
        6gqE8dcWSeo+SklzKqP6XQ==
X-Google-Smtp-Source: ABdhPJwnqQ+I0Fv7SWKbP5NywS9MDe0YkIAqjgO8YNUxqtyWrEsANPd86lCTs2JitUuYDusVDfo8HA==
X-Received: by 2002:a4a:304b:: with SMTP id z11mr4778919ooz.74.1641950217868;
        Tue, 11 Jan 2022 17:16:57 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id w5sm2381059otp.38.2022.01.11.17.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 17:16:57 -0800 (PST)
Received: (nullmailer pid 3849865 invoked by uid 1000);
        Wed, 12 Jan 2022 01:16:56 -0000
Date:   Tue, 11 Jan 2022 19:16:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Niklas Cassel <nks@flawful.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>
Subject: Re: [PATCH v2 4/7] dt-bindings: opp: Convert qcom-nvmem-cpufreq to
 DT schema
Message-ID: <Yd4sCHPbkivYFibE@robh.at.kernel.org>
References: <20220104132618.391799-1-y.oudjana@protonmail.com>
 <20220104132618.391799-5-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220104132618.391799-5-y.oudjana@protonmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Jan 2022 13:28:59 +0000, Yassine Oudjana wrote:
> Convert qcom-nvmem-cpufreq to DT schema format, splitting it into
> an OPP schema and a CPUFreq schema in the process.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
> Changes since v1:
>  - Split the schema into an OPP schema and a CPUFreq schema.
> 
>  .../bindings/cpufreq/qcom-cpufreq-nvmem.yaml  | 166 ++++
>  .../bindings/opp/opp-v2-kryo-cpu.yaml         | 257 ++++++
>  .../bindings/opp/qcom-nvmem-cpufreq.txt       | 796 ------------------
>  MAINTAINERS                                   |   3 +-
>  4 files changed, 425 insertions(+), 797 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
>  create mode 100644 Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
>  delete mode 100644 Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
