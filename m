Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0FDD470C94
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 22:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344405AbhLJVdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 16:33:42 -0500
Received: from mail-oi1-f173.google.com ([209.85.167.173]:33281 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239964AbhLJVdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 16:33:41 -0500
Received: by mail-oi1-f173.google.com with SMTP id q25so15107854oiw.0;
        Fri, 10 Dec 2021 13:30:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6v3vN5bs9G7pQvp2EOZLbvwUUvDXnLawwef/8iJSg/0=;
        b=Ecpc2c2B7WutVfOHpkO/5glFsuZlo5tqgZ5aICqcB5Pf8Bo4FSRhKsLM9NR6eQmg2d
         6RS47oVChldRNb6yaW54jMHqC9XZRebwY7AA2W/Nl+C25o6sfx4DVNXtwdgywFrmJM4P
         K7YKf4kMDpFASvUUEUQG74b/8Ypi10Eu/ai2W6tV6A22LBZV1OWzmHx6DW3gv1oKZcMx
         B7zPPeYjj7Pe0MHVxIHbg6EA0x8IY4dSqTByU8rs0pLeZOvRwnKyba36qDPWlkncMq5A
         BQ/2ee123k2Pljc3/qTtrVaMHvnNQwnyhW0HdUUu6z1Ram3j6isQ4+NOgaoax/WvdGT9
         sSVA==
X-Gm-Message-State: AOAM530jA1zF6loCNi2rKzlXwMrww8rjTrx+WAfrJ665p/JoaOpcnF7x
        bIVhSAo4m9vbekEgt3VKug==
X-Google-Smtp-Source: ABdhPJwy/OrkyQw56ZeeKtO0RyeKqKnvGMGF9EFgNo9NjmFHmDgnSGZxC4isABGYcBGzO/56rrJFIw==
X-Received: by 2002:a05:6808:3c2:: with SMTP id o2mr15202275oie.112.1639171805326;
        Fri, 10 Dec 2021 13:30:05 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id o14sm710550ote.41.2021.12.10.13.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 13:30:04 -0800 (PST)
Received: (nullmailer pid 1944929 invoked by uid 1000);
        Fri, 10 Dec 2021 21:30:03 -0000
Date:   Fri, 10 Dec 2021 15:30:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     David Virag <virag.david003@gmail.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Sam Protsenko <semen.protsenko@linaro.org>,
        linux-samsung-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Tomasz Figa <tomasz.figa@gmail.com>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH v4 3/7] dt-bindings: arm: samsung: document jackpotlte
 board binding
Message-ID: <YbPG27SFtOXa3NOH@robh.at.kernel.org>
References: <20211206153124.427102-1-virag.david003@gmail.com>
 <20211206153124.427102-4-virag.david003@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206153124.427102-4-virag.david003@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Dec 2021 16:31:17 +0100, David Virag wrote:
> Add binding for the jackpotlte board (Samsung Galaxy A8 (2018)).
> 
> Signed-off-by: David Virag <virag.david003@gmail.com>
> ---
> Changes in v2:
>   - Nothing
> 
> Changes in v3:
>   - Nothing
> 
> Changes in v4:
>   - Nothing
> 
>  .../devicetree/bindings/arm/samsung/samsung-boards.yaml     | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
