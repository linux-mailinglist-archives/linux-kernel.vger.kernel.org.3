Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90792476853
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 03:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233127AbhLPCwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 21:52:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233082AbhLPCwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 21:52:15 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E4CC061574;
        Wed, 15 Dec 2021 18:52:15 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id p8so36269384ljo.5;
        Wed, 15 Dec 2021 18:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xdliTs2c7a14RuIv4fQ6Gv/2gRZUaewMh1986gMRzTU=;
        b=JdzpyixQ2xNOQp1kobBa6dmn34VWHrmMYTVwUXGQSaVyVj5QVJDy4JjSTrjFE296mQ
         CqhG/ZJHjvykbtD8aRhdXgHW+5EnEpakNZxH9tupm40iWsE97QvdLlsriAmDxbK3YSCn
         EvcJw/ioGVLXy9UBVUwa/Hq8EGUxqaU08tz9K0liPFw8/3XP5+M2PwAypuru9/AtxXKN
         cOdyxo4xygp8Lgkp8e4AJBW0beG0Q9Cy8S6ZEYIEq+LcT5QmoNNxNZAash2TxA8QMJlE
         UvChP3emDP0SncFNgecakH5na4BlgfREMcuwDHzdWMp8tifU1OIZeYZ+jgSRIDl0pTPR
         /NVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xdliTs2c7a14RuIv4fQ6Gv/2gRZUaewMh1986gMRzTU=;
        b=YnPpdHKjBXnwuxsUw7ZS91zF2cChoxwWHbg9Z87Ia1mLTzNWa+skT08WubEr7Xthu3
         o24QNPs+UA0HvnUGjKU4q2eEGknWT6s/oFU+GFE3mbG/lVXYT62E81j0YWTXicoNhknj
         Z3DFqNCCEgmdO0OSYYwQ9ZSHLZvwjuEqwEPIVJ6X9KfsEmccATN0fCsntp+HR8Vlsov0
         6lXbW95jxd7XGmb2jUVslasq3s27mHzAt3HGBHpbnOEGQW4u8dDzpKSyBDdowwWZ0l+2
         KEPhmAKKR3SDv4qRlXPNKDA/k/frgJ3gwjzHSV2T5RWMrt6m4XC9aqjQVTGz82pCCUDy
         fObg==
X-Gm-Message-State: AOAM532e4/P/lmFkOu1NZ7QFPdDmLH04sYwnn+K7nIxTxCtqiSzpujHK
        1OHul6CeRSZq6ThjJ3S/HaSR25IJQ2E=
X-Google-Smtp-Source: ABdhPJxJTPdnQvFSNjW8VJ5MEa46UwKjQZuqfN3F0CKc5MARIiUKTXKvc2vfpEjqqHJMYASZmKS6Gw==
X-Received: by 2002:a2e:8e88:: with SMTP id z8mr12924139ljk.197.1639623133561;
        Wed, 15 Dec 2021 18:52:13 -0800 (PST)
Received: from [192.168.2.145] (94-29-63-156.dynamic.spd-mgts.ru. [94.29.63.156])
        by smtp.googlemail.com with ESMTPSA id k8sm613103lfv.179.2021.12.15.18.52.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Dec 2021 18:52:13 -0800 (PST)
Subject: Re: [PATCH v2] dt-bindings: sound: nvidia,tegra-audio: Convert
 multiple txt bindings to yaml
To:     David Heidelberg <david@ixit.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     ~okias/devicetree@lists.sr.ht, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211211224946.79875-1-david@ixit.cz>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <a84213cb-272a-f1b2-338f-ed8ed0bf133d@gmail.com>
Date:   Thu, 16 Dec 2021 05:52:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211211224946.79875-1-david@ixit.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

12.12.2021 01:49, David Heidelberg пишет:
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    sound {
> +        compatible = "nvidia,tegra-audio-rt5677-ryu",
> +                     "nvidia,tegra-audio-rt5677";
> +        nvidia,model = "NVIDIA Tegra Ryu";
> +
> +        nvidia,audio-routing =
> +                "Headphone", "LOUT2",
> +                "Headphone", "LOUT1",
> +                "Headset Mic", "MICBIAS1",
> +                "IN1P", "Headset Mic",
> +                "IN1N", "Headset Mic",
> +                "DMIC L1", "Internal Mic 1",
> +                "DMIC R1", "Internal Mic 1",
> +                "DMIC L2", "Internal Mic 2",
> +                "DMIC R2", "Internal Mic 2",
> +                "Speaker", "PDM1L",
> +                "Speaker", "PDM1R";
> +
> +        nvidia,i2s-controller = <&tegra_i2s1>;
> +        nvidia,audio-codec = <&rt5677>;
> +
> +        nvidia,hp-det-gpios = <&gpio 143 0>;
> +        nvidia,mic-present-gpios = <&gpio 132 1>;
> +        nvidia,hp-en-gpios = <&rt5677 1 0>;
> +        nvidia,dmic-clk-en-gpios = <&rt5677 2 1>;

I spotted that nvidia,dmic-clk-en-gpios is undocumented, but DTs and
binding are passing the validation. We will make another patch to fix it.

Rob, could you please tell whether this is because unevaluatedProperties
doesn't work yet or we're missing something?
