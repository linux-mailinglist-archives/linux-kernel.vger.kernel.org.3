Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1708E48DBC0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 17:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236674AbiAMQ3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 11:29:38 -0500
Received: from mail-oi1-f177.google.com ([209.85.167.177]:39932 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236708AbiAMQ3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 11:29:36 -0500
Received: by mail-oi1-f177.google.com with SMTP id e81so8350313oia.6;
        Thu, 13 Jan 2022 08:29:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=V3d/hILCp5fIw9k9NOmkPJsjVgyDwsccH/2QdR1VqC4=;
        b=mjD4BEochRljOAEW5mSdVfg82o+lQDBTiBxMcpwin4yEBk19Cj/q1TxA+nA5i6k0rb
         6tVwscKUZz2U74H6J4Jk1J0XiqYUt4LaRKMRmel5NLlm3pmVSgT0v0uhYoKuVWX3Z98q
         rknsTNYZWwoP5c7pdFcXCuimeM+Xhu6u7HayvE+9Q2JSUDwV6xJHvMpg04XMoGJPeRh5
         I31hCZfu8tfLgLyX68zIG7395gksaVeYU12crs2XjwT0B65WxB6PmhTbLaP8lkP0sDSW
         w1GxPlfkAqfg3vLsH22WL1rJw1mqYURqTf9Y8Sooe4gSk06RsXlOn96m80b/XbgjXOdX
         E0bQ==
X-Gm-Message-State: AOAM533wuZU7KTF0rMJG/XGwE8pUQiC1jqI65hCXbcM114FCdTtuX0UT
        ud1+uZziTFZW1C2y5oTVNQ==
X-Google-Smtp-Source: ABdhPJx+WdBeR9L7ggGsVpRxHTG4QcOu+1F01WaEvxC+JcemfuD0FySeENYbqDCyL9DMiten2OOBLQ==
X-Received: by 2002:a05:6808:1aa7:: with SMTP id bm39mr1545727oib.24.1642091375793;
        Thu, 13 Jan 2022 08:29:35 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id m26sm377867otp.13.2022.01.13.08.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 08:29:35 -0800 (PST)
Received: (nullmailer pid 3647182 invoked by uid 1000);
        Thu, 13 Jan 2022 16:29:34 -0000
From:   Rob Herring <robh@kernel.org>
To:     Daniel Beer <daniel.beer@igorinstitute.com>
Cc:     devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Andy Liu <andy-liu@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Derek Simkowiak <derek.simkowiak@igorinstitute.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <2eb938b60d232dfc48fcc53e3c87d1f773b3bf2d.1642063121.git.daniel.beer@igorinstitute.com>
References: <cover.1642063121.git.daniel.beer@igorinstitute.com> <2eb938b60d232dfc48fcc53e3c87d1f773b3bf2d.1642063121.git.daniel.beer@igorinstitute.com>
Subject: Re: [PATCH v2 2/2] ASoC: dt-bindings: add bindings for TI TAS5805M.
Date:   Thu, 13 Jan 2022 10:29:34 -0600
Message-Id: <1642091374.227294.3647181.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jan 2022 13:00:09 +1300, Daniel Beer wrote:
> The TAS5805M is a class D speaker amplifier with integrated DSP. The
> example here includes a tested flat configuration for mono (PBTL)
> output.
> 
> Signed-off-by: Daniel Beer <daniel.beer@igorinstitute.com>
> ---
>  .../devicetree/bindings/sound/tas5805m.yaml   | 204 ++++++++++++++++++
>  1 file changed, 204 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/tas5805m.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/tas5805m.example.dt.yaml: tas5805m@2c: status:0: 'ok' is not one of ['okay', 'disabled', 'reserved']
	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/dt-core.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1579511

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

