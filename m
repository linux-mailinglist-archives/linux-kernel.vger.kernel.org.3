Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8E9463D17
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 18:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245102AbhK3Rqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 12:46:36 -0500
Received: from mail-oi1-f177.google.com ([209.85.167.177]:44718 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245069AbhK3Rq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 12:46:29 -0500
Received: by mail-oi1-f177.google.com with SMTP id be32so42689654oib.11;
        Tue, 30 Nov 2021 09:43:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=sRiUXiOlT2Ve+gr84A0lFsHe7uYfdTdxUD9C9/YzIbA=;
        b=ztkb0I748Ihx3aNal0pm1d8P1gxSx4Vt+Lcr6wGAKblLe9MB/tSqJMnjwWncfjgF5y
         1f39Cw1z1UuuAb2tSdF2UKpWo86KQGalZvQ2ubXAUQYaLpIQ0gnKywDpPnW7B1h/gHX7
         p5R7gYSWjeFkX2H6RNtSmGuy1vNbmjQkWVWDQblnmgwNtNWyVMu7M3F1wmvDDvto9Q/o
         qSchZPnFG9GlrdhxAGJbpkjHZD+2GHXO7n4pfPW1vudjjPZ7ybV7SRnfHO1fi3LcUihp
         5ooERXd/waaLXvmaF23B14Us4D9xeHlR7hhbb5k1BUE8+Bbgox8IoensVRzEqWPP5eDU
         u+pw==
X-Gm-Message-State: AOAM531h989vOmd2NG1Z4wAoTgRLNSCjO7c1zDqm7x9J0BiK40EUsmru
        3rVdcpuPtmQVXUg2gbU8Sw==
X-Google-Smtp-Source: ABdhPJwyGYMhtxYm6pMgV0MXwp6PSGDn61hIwC4lTQAgVaDvf7Qz6uhyI+g7sggB5OSOJcExU05/VA==
X-Received: by 2002:aca:502:: with SMTP id 2mr333374oif.121.1638294189464;
        Tue, 30 Nov 2021 09:43:09 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id t3sm3283873otk.44.2021.11.30.09.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 09:43:08 -0800 (PST)
Received: (nullmailer pid 2713648 invoked by uid 1000);
        Tue, 30 Nov 2021 17:43:04 -0000
From:   Rob Herring <robh@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        jeyr@codeaurora.org, bkumar@qti.qualcomm.com,
        gregkh@linuxfoundation.org, ekangupt@qti.qualcomm.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20211130092846.18804-1-srinivas.kandagatla@linaro.org>
References: <20211130092846.18804-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v3] dt-bindings: misc: fastrpc convert bindings to yaml
Date:   Tue, 30 Nov 2021 11:43:04 -0600
Message-Id: <1638294184.202173.2713647.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Nov 2021 09:28:46 +0000, Srinivas Kandagatla wrote:
> Convert Qualcomm FastRPC bindings to yaml format, so that we could validate
> dt-entries correctly and any future additions can go into yaml format.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
> 
> Changes since v2:
>  fixed typo in pil compatible string
>  added required properties for pil example node
> 
>  .../devicetree/bindings/misc/qcom,fastrpc.txt |  78 -------------
>  .../bindings/misc/qcom,fastrpc.yaml           | 104 ++++++++++++++++++
>  2 files changed, 104 insertions(+), 78 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
>  create mode 100644 Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/1561468


fastrpc: 'compute-cb@1', 'compute-cb@2', 'compute-cb@3', 'compute-cb@4', 'compute-cb@5', 'compute-cb@6', 'compute-cb@7', 'compute-cb@8', 'qcom,glink-channels' do not match any of the regexes: '^cb@[0-9a-f]$', 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/qcom/qrb5165-rb5.dt.yaml
	arch/arm64/boot/dts/qcom/sa8155p-adp.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-db845c.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-mtp.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dt.yaml
	arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dt.yaml
	arch/arm64/boot/dts/qcom/sm8150-hdk.dt.yaml
	arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dt.yaml
	arch/arm64/boot/dts/qcom/sm8150-mtp.dt.yaml
	arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano-bahamut.dt.yaml
	arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano-griffin.dt.yaml
	arch/arm64/boot/dts/qcom/sm8250-hdk.dt.yaml
	arch/arm64/boot/dts/qcom/sm8250-mtp.dt.yaml
	arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx203.dt.yaml
	arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx206.dt.yaml
	arch/arm64/boot/dts/qcom/sm8350-hdk.dt.yaml
	arch/arm64/boot/dts/qcom/sm8350-mtp.dt.yaml

fastrpc: 'compute-cb@1', 'compute-cb@2', 'compute-cb@3', 'qcom,glink-channels' do not match any of the regexes: '^cb@[0-9a-f]$', 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/qcom/qrb5165-rb5.dt.yaml
	arch/arm64/boot/dts/qcom/sa8155p-adp.dt.yaml
	arch/arm64/boot/dts/qcom/sm8150-hdk.dt.yaml
	arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dt.yaml
	arch/arm64/boot/dts/qcom/sm8150-mtp.dt.yaml
	arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano-bahamut.dt.yaml
	arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano-griffin.dt.yaml
	arch/arm64/boot/dts/qcom/sm8250-hdk.dt.yaml
	arch/arm64/boot/dts/qcom/sm8250-mtp.dt.yaml
	arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx203.dt.yaml
	arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx206.dt.yaml
	arch/arm64/boot/dts/qcom/sm8350-hdk.dt.yaml
	arch/arm64/boot/dts/qcom/sm8350-mtp.dt.yaml

fastrpc: 'compute-cb@3', 'compute-cb@4', 'compute-cb@5', 'qcom,glink-channels' do not match any of the regexes: '^cb@[0-9a-f]$', 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/qcom/qrb5165-rb5.dt.yaml
	arch/arm64/boot/dts/qcom/sa8155p-adp.dt.yaml
	arch/arm64/boot/dts/qcom/sm8150-hdk.dt.yaml
	arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dt.yaml
	arch/arm64/boot/dts/qcom/sm8150-mtp.dt.yaml
	arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano-bahamut.dt.yaml
	arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano-griffin.dt.yaml
	arch/arm64/boot/dts/qcom/sm8250-hdk.dt.yaml
	arch/arm64/boot/dts/qcom/sm8250-mtp.dt.yaml
	arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx203.dt.yaml
	arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx206.dt.yaml
	arch/arm64/boot/dts/qcom/sm8350-hdk.dt.yaml
	arch/arm64/boot/dts/qcom/sm8350-mtp.dt.yaml

fastrpc: 'compute-cb@3', 'compute-cb@4', 'qcom,glink-channels' do not match any of the regexes: '^cb@[0-9a-f]$', 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/qcom/sdm845-cheza-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-cheza-r2.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-cheza-r3.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-db845c.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-mtp.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dt.yaml
	arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dt.yaml

fastrpc: 'qcom,smd-channels' does not match any of the regexes: '^cb@[0-9a-f]$', 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/qcom/apq8016-sbc.dt.yaml
	arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dt.yaml
	arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dt.yaml
	arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dt.yaml
	arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dt.yaml
	arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dt.yaml
	arch/arm64/boot/dts/qcom/msm8916-mtp.dt.yaml
	arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dt.yaml
	arch/arm64/boot/dts/qcom/msm8916-samsung-a5u-eur.dt.yaml
	arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dt.yaml
	arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dt.yaml
	arch/arm/boot/dts/qcom-msm8916-samsung-serranove.dt.yaml

