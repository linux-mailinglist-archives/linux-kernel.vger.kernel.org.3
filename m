Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD594A52A2
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 23:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233855AbiAaWvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 17:51:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbiAaWvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 17:51:14 -0500
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9B6C06173D
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 14:51:14 -0800 (PST)
Received: by mail-oo1-xc32.google.com with SMTP id q145-20020a4a3397000000b002e85c7234b1so3592305ooq.8
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 14:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nBrfpJzupkSShf4CWXDPtK4iaecwvZzucD4RhJBFXwk=;
        b=zBtEMTjVVb+YGqAcOSPVvMPv1Ocy7/1H8T1FVt43BwsxAUK32tnMeaZKTf4vZlTc4K
         +ZRlDJ9uMsDqhJ1Diu8SXbmt8AKixgtfKvZtDe5d/KyxMMPZJKnn2DuJmhHGAx/yL3kF
         NpPTuUJH6UnN7tRI833pF/YeC+TTleD8ugqCXqHtiS4vPEW0bq6qnrzUf2JmgIlB3ApO
         SH+GsWwMy4B8HzZSyGzktoAZR5OgYqxi1aTGhydpqX96FLkWYAMKBnLiL5SmHZYKuXxD
         evMNdzvZVmWgqY1EQaGFtPt01WoJ7+A5mQsmybBawyx+iT7qE9o9qEgU22e9Z1ghXdAZ
         rxqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nBrfpJzupkSShf4CWXDPtK4iaecwvZzucD4RhJBFXwk=;
        b=xRQqUxJxvblRLxiNjHTD/pTZdh3WcX6SM4x4jt/C1ztFFjR3aO0sbKf8LrT8MOGH7x
         f4ipOym4fMWdg1EmP8nJb2JfRZrUsSUfNdjsLIVpf5ZH9YoniJeh+w6wMe3OE1Zyvfvg
         TWnzwRDaLfbE9cLxkgQiOVRnnWoBF162i1CRfnuZ0CtSNGJt9wrJmOvCY3uSYJHPSrtz
         pC33V4azC0IY1mprtCMjGyJXX0Y53hTdY8aPH9lTNVi0Y3hp6ann5a6Uz6PjJOvgX/wf
         i/BzxJmLIfOtlP4KtTyq/R9SjkyhdGTmfNq2TzROmDHtYY0br+aZrlo9KvSlluQ90RZd
         z8Rw==
X-Gm-Message-State: AOAM53296aLQJp0+40wZ3F+/rzxx9z2Aj5eeTK0JKp0Ljb4C/nwXQoch
        ScD1aog4d/VlxDcSgwiZlr/4sA==
X-Google-Smtp-Source: ABdhPJxR9eHfsl198Tn9tTHqvNyyVXfT+TxvfXIUwvWRj0ljbCIlWA9U6ZaHID1pRgfHEbrnr8WrdQ==
X-Received: by 2002:a9d:40a:: with SMTP id 10mr8675863otc.319.1643669473716;
        Mon, 31 Jan 2022 14:51:13 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id l1sm12096073otd.18.2022.01.31.14.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 14:51:13 -0800 (PST)
Date:   Mon, 31 Jan 2022 16:51:11 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/17] Multiple addition to ipq8064 dtsi
Message-ID: <Yfhn3x6SYzlzZORx@builder.lan>
References: <20220118012051.21691-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220118012051.21691-1-ansuelsmth@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 17 Jan 19:20 CST 2022, Ansuel Smith wrote:

> This try to complete the ipq8064 dtsi and introduce 2 new dtsi
> ipq8064-v2 and ipq8065. While some node are still missing (cpufreq node,
> l2 scale node, fab scale node) this would add most of the missing node
> to make ipq8064 actually usable.
> 
> Some of the changes are the fix for the pci IO that cause any secondary
> wifi card with ath10k to fail init.
> Adds regulators definition for RPM.
> Adds many missing gsbi nodes used by all the devices.
> Enable the usb phy by default as they are actually enabled internally by
> xlate only if the dwc3 driver is used.
> Add opp table and declare idle state for ipq8064.
> Fix some dtc warning.
> 
> This also add the ipq8064-v2.0 dtsi and the ipq8065 dtsi used by more
> recent devices based on this SoC.
> 

From the look of the series I suspect that you format-patch'ed a series
with 16 patches, then fixed something and re-ran it now with 17 patches.

Can you please resubmit the series to make it clear what you would like
me to apply. (Preferably with that one commit message clarified)

Regards,
Bjorn

> Ansuel Smith (17):
>   ARM: dts: qcom: add multiple missing pin definition for ipq8064
>   ARM: dts: qcom: add gsbi6 missing definition for ipq8064
>   ARM: dts: qcom: add missing rpm regulators and cells for ipq8064
>   ARM: dts: qcom: add missing snps,dwmac compatible for gmac ipq8064
>   ARM: dts: qcom: enable usb phy by default for ipq8064
>   ARM: dts: qcom: reduce pci IO size to 64K for ipq8064
>   ARM: dts: qcom: fix dtc warning for missing #address-cells for ipq8064
>   ARM: dts: qcom: add smem node for ipq8064
>   ARM: dts: qcom: add saw for l2 cache and kraitcc for ipq8064
>   ARM: dts: qcom: add sic non secure node for ipq8064
>   ARM: dts: qcom: fix and add some missing gsbi node for ipq8064
>   ARM: dts: qcom: add opp table for cpu and l2 for ipq8064
>   ARM: dts: qcom: add speedbin efuse nvmem binding
>   ARM: dts: qcom: add multiple missing binding for cpu and l2 for
>     ipq8064
>   ARM: dts: qcom: remove redundant binding from ipq8064 rb3011 dts
>   ARM: dts: qcom: add ipq8064-v2.0 dtsi
>   ARM: dts: qcom: add ipq8065 dtsi
> 
>  arch/arm/boot/dts/qcom-ipq8064-rb3011.dts |  17 --
>  arch/arm/boot/dts/qcom-ipq8064-v2.0.dtsi  |  70 +++++
>  arch/arm/boot/dts/qcom-ipq8064.dtsi       | 344 +++++++++++++++++++++-
>  arch/arm/boot/dts/qcom-ipq8065.dtsi       | 168 +++++++++++
>  4 files changed, 568 insertions(+), 31 deletions(-)
>  create mode 100644 arch/arm/boot/dts/qcom-ipq8064-v2.0.dtsi
>  create mode 100644 arch/arm/boot/dts/qcom-ipq8065.dtsi
> 
> -- 
> 2.33.1
> 
