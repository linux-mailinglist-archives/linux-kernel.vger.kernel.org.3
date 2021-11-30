Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B57FE463D16
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 18:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245068AbhK3Rqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 12:46:33 -0500
Received: from mail-oi1-f172.google.com ([209.85.167.172]:40581 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245054AbhK3Rq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 12:46:27 -0500
Received: by mail-oi1-f172.google.com with SMTP id bk14so42754535oib.7;
        Tue, 30 Nov 2021 09:43:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=KOr9fOym22LN3Vmi79Rc9gKhOAdZkrFN5TntEcaqynU=;
        b=m9RZopGugw3bMARD1esCkCes++1uJ6uLhN65dATc8kvnLMjX+f+L9HvI+eGWDvFiEx
         jTiWVEAsYpSTfSfsHxxY5ObQAmRCqopllHRaw2q6rzxAxbAoDxVMWKMkhBjh7FwJvXMR
         OynCL5EMfL2sSK261gV65ZlXfHdH6XSX5LgS4lU/YSNplSE8NCBXJvPMpqt7E/diuCkh
         yUmfMvbOKXTfDNR3pn/G5HHu4/wx06d9kJ/dV4bT1e/Sfnjy1gDkPHv+u43uKyoW0W9d
         cVS5qFslUTl0x+ghzevJy+IsgdblsqLQm8DhsDkvLTkieT4YdoL0e/rQRC7B2gn07SSK
         CSYw==
X-Gm-Message-State: AOAM531Mh4e+NEiSk2kgJzFyFUsAVI61wRXrTx7SnV5Af2OGvfYlUXGt
        sXu3/Uz6k066/6K5IwN+dPlmxbiqEg==
X-Google-Smtp-Source: ABdhPJyoSeMBzjlATY+tg+5Yr2+nzO4zZxmIP4ZpLhfbvN/2xFF+jJXqBStE3svx6EQo6MQVR2lOCw==
X-Received: by 2002:aca:5b87:: with SMTP id p129mr402512oib.30.1638294187809;
        Tue, 30 Nov 2021 09:43:07 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 111sm3214603otu.55.2021.11.30.09.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 09:43:06 -0800 (PST)
Received: (nullmailer pid 2713646 invoked by uid 1000);
        Tue, 30 Nov 2021 17:43:04 -0000
From:   Rob Herring <robh@kernel.org>
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>, devicetree@vger.kernel.org,
        Peter Rosin <peda@axentia.se>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20211130121847.11112-2-a-govindraju@ti.com>
References: <20211130121847.11112-1-a-govindraju@ti.com> <20211130121847.11112-2-a-govindraju@ti.com>
Subject: Re: [PATCH 1/2] dt-bindings: mux: Document mux-states property
Date:   Tue, 30 Nov 2021 11:43:04 -0600
Message-Id: <1638294184.190493.2713645.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Nov 2021 17:48:46 +0530, Aswath Govindraju wrote:
> In some cases, it is required to provide the state to which the mux
> controller has be set to, from the consumer device tree node. Document the
> property mux-states that can be used for adding this support.
> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---
>  .../devicetree/bindings/mux/gpio-mux.yaml     | 11 ++++++--
>  .../devicetree/bindings/mux/mux-consumer.yaml | 14 ++++++++++
>  .../bindings/mux/mux-controller.yaml          | 26 ++++++++++++++++++-
>  3 files changed, 48 insertions(+), 3 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mux/mux-controller.example.dt.yaml: can-phy4: 'mux-states' does not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1561624

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

