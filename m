Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3C451A300
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 17:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351848AbiEDPG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 11:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351832AbiEDPGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 11:06:41 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7477030550
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 08:02:53 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id q23so2436949wra.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 08:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=HvKytfFVFBCLTWsgYnAEqf+taainONYbWgLIzFqsqvE=;
        b=jnvLNfD/C3XvayK8cffWffFkU/EgtmnJKH5doqpaeg/QFaNr3qM0X0paUDDKaEZQdv
         2SGb9d3dPMIdpHz0vbrqttnWBf2oCvB5aiLFNNgI1D+oBHIFCk3TmXkXMrL0mqyBUnmL
         GugQGx0/JOFqw3XJUot/P6FMDcLUIJZZ/6abLg3LJIEvKR50DG/cMTWjgtMUEC9caSn8
         MHXRTAdq8c1EUdT0foO0gfgBHCPjWMLyLDYhH1uk1/CGzGuwUJMCzj9kaRzwm4WH7PfA
         W1qFySec5m/LjyG2xIYZQ/ySL5KGzNscv81JZ0xHIB9ZexcVziGmTfWkTDCrahCdsho6
         VWAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HvKytfFVFBCLTWsgYnAEqf+taainONYbWgLIzFqsqvE=;
        b=Y0eXVlY69A4Q5xrIewbvKaq87BNmzpDUJf2vGahi3ZS2fGhmqD0ubjP+vY0CuJWKAu
         Irahn9QA3F0M0z77VE3r0sqfmZCWjNk4uq421jJIidNbCVendkDpiD9T4U8nEyBhAAAd
         0ZF+FZV+rK1/Mi61n7MOKex6nMYS7wJaNUoaINaa3KvqJV+WM7LWMnGCKaDgGi/4U2rs
         qEzvLbyMBn+dJrcDKxmwfe71EP15KwwhchikFEJF/Q++DMuqpHM84OmULh0yB+Sp7kTj
         PmpGc+qY0TzzxsZP0AGRYI5nkjV4cl6CBOy6GnM/CCvqMHUJWFckBNS7sTfkI9FZF64P
         byKA==
X-Gm-Message-State: AOAM532IcZPI1DpLDRQ1BrRA1jovrga9sPxRLCImq1e+9EgpmNdrl+aZ
        rXV808DIm681XmZCjSJmsxYo2A==
X-Google-Smtp-Source: ABdhPJz97z6SmdLoZhUDViG7Bw4YlE09bEU4XO7JZFqg5IWbW4bRwmyUtF9zN8hWdA3uWII5eYnWog==
X-Received: by 2002:a05:6000:1565:b0:20c:611d:7fec with SMTP id 5-20020a056000156500b0020c611d7fecmr11749015wrz.387.1651676572081;
        Wed, 04 May 2022 08:02:52 -0700 (PDT)
Received: from [192.168.0.215] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id m6-20020adfc586000000b0020c5253d908sm12590770wrg.84.2022.05.04.08.02.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 08:02:51 -0700 (PDT)
Message-ID: <608ba746-9116-3f36-d640-07eb8b5d793e@linaro.org>
Date:   Wed, 4 May 2022 17:02:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 3/3] arm64: dts: intel: add device tree for n6000
Content-Language: en-US
To:     matthew.gerlach@linux.intel.com, dinguyen@kernel.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org
References: <20220503194546.1287679-1-matthew.gerlach@linux.intel.com>
 <20220503194546.1287679-4-matthew.gerlach@linux.intel.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220503194546.1287679-4-matthew.gerlach@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/2022 21:45, matthew.gerlach@linux.intel.com wrote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> 
> Add a device tree for the n6000 instantiation of Agilex
> Hard Processor System (HPS).
> 
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>

> +
> +	soc {
> +		agilex_hps_bridges: bus@80000000 {
> +			compatible = "simple-bus";
> +			reg = <0x80000000 0x60000000>,
> +				<0xf9000000 0x00100000>;
> +			reg-names = "axi_h2f", "axi_h2f_lw";
> +			#address-cells = <0x2>;
> +			#size-cells = <0x1>;
> +			ranges = <0x00000000 0x00000000 0xf9000000 0x00001000>;
> +
> +			hps_cp_eng@0 {

No underscores in node names.  dtc W=1 should complain about it.
The node name should be generic, matching class of a device. What is
this exactly?

Best regards,
Krzysztof
