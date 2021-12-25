Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2C947F389
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 15:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbhLYOtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 09:49:10 -0500
Received: from mail-qk1-f182.google.com ([209.85.222.182]:41926 "EHLO
        mail-qk1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231983AbhLYOs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 09:48:56 -0500
Received: by mail-qk1-f182.google.com with SMTP id m2so8936862qkd.8;
        Sat, 25 Dec 2021 06:48:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=R1JDD4xzjoppkmMrdMNvIsTxQPbbgQDJd30wDWgFjJc=;
        b=trSorZDnnj7Geg1wf+1k+p0mPx+qupiiM42F+as3BElvkO/D4xqxxn386t1mwTp5XD
         84Pjomy5hzTv25+0vJ0PeMKZ1k6aBKq/Aq8WphJnaexDxa45y1YNXLZAMdrSpGPZ2ymH
         MhcXTmA5oO00/orsnpoD83ssswstT+0kgfhVvmfLxluGRoESu8JAD9uZn59FWU3Z+hkP
         kfz9KI4oNC32nKj0K5q42QpTkvNyRrHYM7P7r/wc/0AQ9zdM5lR48wG7CMIgmWj5BYoh
         rO04gVvx/2JZSQooJQQ7SNpyTzAVBpVbZ8EBVT/ZU9YFazyV6FTNuC2tyOLvmFo+29DX
         wxxQ==
X-Gm-Message-State: AOAM531XDBRAMQ42LSys8qfxCLLBZn9sp+gY/2PJ3mwj6ISYqxZzUwfF
        luoIlhZQ5XkupJlvAeMRug==
X-Google-Smtp-Source: ABdhPJy41bN2OKCs6DRMAzWHlgY67Qfln27TTdFRrlIAkav1HNHHQAdAArVH3yuVG3xO4nKXFdFazQ==
X-Received: by 2002:a37:b744:: with SMTP id h65mr7542309qkf.131.1640443736011;
        Sat, 25 Dec 2021 06:48:56 -0800 (PST)
Received: from robh.at.kernel.org ([24.55.105.145])
        by smtp.gmail.com with ESMTPSA id z4sm9002675qtj.42.2021.12.25.06.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Dec 2021 06:48:55 -0800 (PST)
Received: (nullmailer pid 363349 invoked by uid 1000);
        Sat, 25 Dec 2021 14:48:42 -0000
From:   Rob Herring <robh@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~okias/devicetree@lists.sr.ht
In-Reply-To: <20211224144835.39193-1-david@ixit.cz>
References: <20211224144835.39193-1-david@ixit.cz>
Subject: Re: [PATCH v3] dt-bindings: arm: merge qcom,idle-state with idle-state
Date:   Sat, 25 Dec 2021 10:48:42 -0400
Message-Id: <1640443722.937725.363348.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Dec 2021 15:48:34 +0100, David Heidelberg wrote:
> Merge Qualcomm specific idle-state binding with generic one.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> 
> ---
> v3:
>  - integrate into idle-state.yml
>  - orig. patch name was:
>    "[v2] dt-bindings: arm/msm/qcom,idle-state convert to YAML"
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  .../devicetree/bindings/arm/idle-states.yaml  | 107 ++++++++++++++++++
>  .../bindings/arm/msm/qcom,idle-state.txt      |  84 --------------
>  2 files changed, 107 insertions(+), 84 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,idle-state.txt
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/1573055


idle-states: 'clusteroff_b', 'clusteroff_l', 'cpuoff_b', 'cpuoff_l' do not match any of the regexes: '^(cpu|cluster)-', '^(ret|spc|pc)$', 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/mediatek/mt8192-evb.dt.yaml

idle-states: 'cluster_pd', 'core_pd' do not match any of the regexes: '^(cpu|cluster)-', '^(ret|spc|pc)$', 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/sprd/sp9860g-1h10.dt.yaml

idle-states: 'core-pd' does not match any of the regexes: '^(cpu|cluster)-', '^(ret|spc|pc)$', 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/sprd/sp9863a-1h10.dt.yaml

idle-states: cpu-sleep-0:compatible:0: 'arm,idle-state' was expected
	arch/arm/boot/dts/qcom-msm8916-samsung-serranove.dt.yaml

idle-states: entry-method:0: 'psci' was expected
	arch/arm64/boot/dts/mediatek/mt8192-evb.dt.yaml

idle-states: 'mpu_gate' does not match any of the regexes: '^(cpu|cluster)-', '^(ret|spc|pc)$', 'pinctrl-[0-9]+'
	arch/arm/boot/dts/am335x-baltos-ir2110.dt.yaml
	arch/arm/boot/dts/am335x-baltos-ir3220.dt.yaml
	arch/arm/boot/dts/am335x-baltos-ir5221.dt.yaml
	arch/arm/boot/dts/am335x-base0033.dt.yaml
	arch/arm/boot/dts/am335x-boneblack.dt.yaml
	arch/arm/boot/dts/am335x-boneblack-wireless.dt.yaml
	arch/arm/boot/dts/am335x-boneblue.dt.yaml
	arch/arm/boot/dts/am335x-bone.dt.yaml
	arch/arm/boot/dts/am335x-bonegreen.dt.yaml
	arch/arm/boot/dts/am335x-bonegreen-wireless.dt.yaml
	arch/arm/boot/dts/am335x-chiliboard.dt.yaml
	arch/arm/boot/dts/am335x-cm-t335.dt.yaml
	arch/arm/boot/dts/am335x-evm.dt.yaml
	arch/arm/boot/dts/am335x-evmsk.dt.yaml
	arch/arm/boot/dts/am335x-guardian.dt.yaml
	arch/arm/boot/dts/am335x-icev2.dt.yaml
	arch/arm/boot/dts/am335x-lxm.dt.yaml
	arch/arm/boot/dts/am335x-moxa-uc-2101.dt.yaml
	arch/arm/boot/dts/am335x-moxa-uc-8100-me-t.dt.yaml
	arch/arm/boot/dts/am335x-myirtech-myd.dt.yaml
	arch/arm/boot/dts/am335x-nano.dt.yaml
	arch/arm/boot/dts/am335x-netcan-plus-1xx.dt.yaml
	arch/arm/boot/dts/am335x-netcom-plus-2xx.dt.yaml
	arch/arm/boot/dts/am335x-netcom-plus-8xx.dt.yaml
	arch/arm/boot/dts/am335x-osd3358-sm-red.dt.yaml
	arch/arm/boot/dts/am335x-pdu001.dt.yaml
	arch/arm/boot/dts/am335x-pepper.dt.yaml
	arch/arm/boot/dts/am335x-phycore-rdk.dt.yaml
	arch/arm/boot/dts/am335x-pocketbeagle.dt.yaml
	arch/arm/boot/dts/am335x-regor-rdk.dt.yaml
	arch/arm/boot/dts/am335x-sancloud-bbe.dt.yaml
	arch/arm/boot/dts/am335x-sancloud-bbe-lite.dt.yaml
	arch/arm/boot/dts/am335x-sbc-t335.dt.yaml
	arch/arm/boot/dts/am335x-shc.dt.yaml
	arch/arm/boot/dts/am335x-sl50.dt.yaml
	arch/arm/boot/dts/am335x-wega-rdk.dt.yaml
	arch/arm/boot/dts/am437x-cm-t43.dt.yaml
	arch/arm/boot/dts/am437x-gp-evm.dt.yaml
	arch/arm/boot/dts/am437x-idk-evm.dt.yaml
	arch/arm/boot/dts/am437x-sbc-t43.dt.yaml
	arch/arm/boot/dts/am437x-sk-evm.dt.yaml
	arch/arm/boot/dts/am43x-epos-evm.dt.yaml

