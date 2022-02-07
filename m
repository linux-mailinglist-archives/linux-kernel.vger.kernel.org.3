Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE55A4AB7DB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 10:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245491AbiBGJfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 04:35:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245282AbiBGJdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 04:33:15 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63538C0401C0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 01:33:08 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id i15so1167316wrb.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 01:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=rBjYYVDfPJSH1BVq77LHmUbf5zvWji8qdpdwUm64Pcg=;
        b=NhD4MFPycqIBpOhwd8+jvRql2upsyK034+tQKBWW1HDFvOTTuQu0lom4xl1l/YGYdR
         NS1mJLu0MwwG2vZFKOi4k1tQe0gWQyfu6+frcfpc8aZn02P2FBH/i7fTXAcTqybXMdyY
         M9y0VZCQTuVie/Ex71UrKktMQgwYKAkbLftxT16PBRxcpAKqo1gu/MqVsEX+SpExYs4w
         9nw25Jry6zgct9e81Q/BH4tpx3K5mk1/MNcc3hugjKLMTIXSXzAWlj2QOUs6GFzEXo0+
         VkZZ6LFjm6JdVv3KcHaIxJJlugJq4i/iRM77D/PWhnDYVSn6ObiL7Xt4VoqS2tQl3/zQ
         aL8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=rBjYYVDfPJSH1BVq77LHmUbf5zvWji8qdpdwUm64Pcg=;
        b=dDhmBmm5ypBPFR6X0XGenlnvYQxG6mZf3zjfq0Arx90rSSH3u2PNbBMtSdOx2s1tXg
         v6uCzcIZK4YNtsWmSAfa6Silo0suivymGcNlTYSqtJMaelsXqoUmV6RIYTS+fTO0rmr3
         DI2N9f9PfP8UHKtvS8AVmsmQvmnPP+sN2XdTaUbBgi2TbydX/N4b+KtHI2hqzv50dR2G
         QWWcxHYR+CWGNQmb9Fb1l6pfd8xE2IwhZ/hPlL6u2RfO1RheHUIs1IvekKgqTP6/8CMV
         lBuGvNi1C46FFZXkWByT60q0xIG90ItlCW7cSJNGTECkR5fo1CM9C1uqbxj6ua8PcwTN
         6Raw==
X-Gm-Message-State: AOAM530+1uyEBw20Ws9bo+omvoHooPnMMh4tiV5sfmBuBbGRMPwCHpxs
        9FYBAPuXmGFQxQHA+wNqTeIlQA==
X-Google-Smtp-Source: ABdhPJxh2mvqeGHI9VwpCnxoxf60eD/D/VwhohJSXRkLkwKmdyolRzDLR+7kmAJg4PiqtpZcypaOOQ==
X-Received: by 2002:adf:e4c4:: with SMTP id v4mr9166828wrm.332.1644226386982;
        Mon, 07 Feb 2022 01:33:06 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id 5sm10359004wrb.113.2022.02.07.01.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 01:33:06 -0800 (PST)
Date:   Mon, 7 Feb 2022 09:33:04 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v2 0/5] mfd/extcon/regulators: max77843: add
 dtschema/bindings
Message-ID: <YgDnUNCNCO+JLyHU@google.com>
References: <20220111174805.223732-1-krzysztof.kozlowski@canonical.com>
 <1bebedb9-644f-783d-492c-84a5de91720d@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1bebedb9-644f-783d-492c-84a5de91720d@canonical.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 06 Feb 2022, Krzysztof Kozlowski wrote:

> On 11/01/2022 18:48, Krzysztof Kozlowski wrote:
> > Hi,
> > 
> > The max77843 shares some parts with max77693 but it lacked bindings.  All
> > its compatibles were undocumented.  Add basic bindings for max77843,
> > matching existing devicetree.  These are not complete bindings, but
> > rather reverse-engineered to match current state.
> > 
> > I do not have access to device with MAX77843, so if anyone else
> > volunteers to be the bindings maintainer, please join.
> > 
> > Changes since v1
> > ================
> > 1. MFD: Use absolute path to schemas.
> > 2. Regulator: mention all allowed properties,
> >    additionalProperties=false, add min/max values for voltages and
> >    current, don't use patternProperties when not needed.
> > 3. extcon: Use absolute path to schemas.
> > 
> > Dependencies
> > ============
> > 1. Patch 1/5 (dts): nothing depends on it, sending here so Rob's automatic
> >    checker won't complain about DTS.
> >    I will take it via Samsung SoC tree.
> > 
> > 2. The patch 4/5 (mfd bindings) depends on regulator and extcon, so they
> >    should come together (2+3+4+5).
> > 
> Dear Lee,
> 
> This patchset was reviewed and there are no outstanding issues. Could
> you pick up patches 2-5 (skipping DTS patch) via MFD tree?

Are the subsystem maintainers not going to review/ack?

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
