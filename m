Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7D7484445
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 16:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234689AbiADPJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 10:09:44 -0500
Received: from mail-ot1-f44.google.com ([209.85.210.44]:41933 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbiADPJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 10:09:44 -0500
Received: by mail-ot1-f44.google.com with SMTP id n17-20020a9d64d1000000b00579cf677301so6757395otl.8;
        Tue, 04 Jan 2022 07:09:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3fNpTZaUUWS8pNu7Z1i39rMhdF3vva9BPhlRLzG5t3U=;
        b=M88rwpFApHyVIx+aq26NR3wL+6ZOdojnDeEeq4JwK64YbC9/4XICQNqtBhp0QAoUKZ
         kDIyRi/ZCXFLaBf3hiX0dBd4zzXKf4ZRjUwtWvbDDixcM3kCJYmf1sXWfxW0hqza36cW
         Gf9PjkZe2+K0gq33jA6AShr8H7qS8LBOusYXfNu1/0pF1FdCk5TGW6qVj4mQjuH5xZWz
         rxuc7cEZYbQg8mXivsppaPbkQTT6A7GTxYiQbxQ5hkf9545pOaO2XQyNWdq3wfWmsEl9
         ySfC7yUxjUA8fxspxfPJM/OGzxsW5de0+uLwYDuIDl9fOVAbmUZKdN20uVxBtH+nUk4C
         cmEg==
X-Gm-Message-State: AOAM530AC/odDxz7TqOPEsVePpdzE3sNcwBzXDmfyP9tlUv/sYGrSzU+
        k1QzP6S1YJF7HlphgsPrNg==
X-Google-Smtp-Source: ABdhPJxXjg4g63hJgQsj67dfIJjSpRy5lUSjbL2UcU2zKSTRR4cRKv47dMOhfrj6TDa5dpCSeI05/w==
X-Received: by 2002:a05:6830:4d6:: with SMTP id s22mr36640079otd.270.1641308983233;
        Tue, 04 Jan 2022 07:09:43 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id q5sm9981694oiv.2.2022.01.04.07.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 07:09:42 -0800 (PST)
Received: (nullmailer pid 840400 invoked by uid 1000);
        Tue, 04 Jan 2022 15:09:41 -0000
Date:   Tue, 4 Jan 2022 09:09:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Mark Brown <broonie@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Sebastian Reichel <sre@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: leds: maxim,max77693: convert to
 dtschema
Message-ID: <YdRjNUMht6HjVM7s@robh.at.kernel.org>
References: <20211228163930.35524-1-krzysztof.kozlowski@canonical.com>
 <20211228163930.35524-2-krzysztof.kozlowski@canonical.com>
 <1640799296.482933.824019.nullmailer@robh.at.kernel.org>
 <bedc4126-7536-a7f9-b833-d06f383ec15d@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bedc4126-7536-a7f9-b833-d06f383ec15d@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 30, 2021 at 11:53:37AM +0100, Krzysztof Kozlowski wrote:
> On 29/12/2021 18:34, Rob Herring wrote:
> > On Tue, 28 Dec 2021 17:39:27 +0100, Krzysztof Kozlowski wrote:
> >> Convert the LEDs bindings of Maxim MAX77693 MUIC to DT schema format.
> >> The existing bindings were defined in ../bindings/mfd/max77693.txt.
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> >> ---
> >>  .../bindings/leds/maxim,max77693.yaml         | 105 ++++++++++++++++++
> >>  1 file changed, 105 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/leds/maxim,max77693.yaml
> >>
> > 
> > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> > 
> > yamllint warnings/errors:
> > 
> > dtschema/dtc warnings/errors:
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/leds/common.example.dt.yaml: led-controller@0: 'reg' does not match any of the regexes: '^([a-z]+-)?led[01]?$', 'pinctrl-[0-9]+'
> > 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/leds/maxim,max77693.yaml
> > 
> > doc reference errors (make refcheckdocs):
> > Documentation/devicetree/bindings/leds/maxim,max77693.yaml: Documentation/devicetree/bindings/mfd/maxim,max77693.yaml
> > 
> > See https://patchwork.ozlabs.org/patch/1573762
> > 
> > This check can fail if there are any dependencies. The base for a patch
> > series is generally the most recent rc1.
> > 
> 
> I updated my yamllint and dtschema, run with DT_CHECKER_FLAGS=-m but
> still cannot reproduce it. Probably because I based on linux-next, so
> maybe this was a fixed issue in leds/common.yaml.

Are you setting DT_SCHEMA_FILES, because the error is in 
common.yaml but caused by this schema.

Clearly, 'reg' is not defined here. And there is no change to 
common.yaml in next.

Rob
