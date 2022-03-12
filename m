Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A704D6E93
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 13:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbiCLMGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 07:06:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiCLMGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 07:06:11 -0500
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991C23C48E;
        Sat, 12 Mar 2022 04:05:05 -0800 (PST)
Received: by mail-wr1-f48.google.com with SMTP id j26so16782207wrb.1;
        Sat, 12 Mar 2022 04:05:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZKGaYYerdbWBJGeucH7XwXR+zyNCr4xDH2MU71MfP98=;
        b=m6ur3o9A/AvOSdxm3RkzRz7QyxNB00D78rHz0Yyr5Gsc30vPXLbuzruONyblCartoo
         +FZVEPeMiM6vuU3GniTRAmw7VeOMIpRM5dGdQktPM9c+GYacSWNSTiHNF+FELlGGCKob
         yboy+b7FctPTH0fBcmv2hXRjunI/7TBPDT6teuRoGb9HnuzJvA7itKCBNLyu9H7TWGuO
         pIvGtupds+2+Eq5wpC8JS/H/JhDuC/sX9l4Lp1cRgaZCM7qm/0aHdt87crli5T3Em1hP
         5cq9odaPmUKB/rJ3E+Dl0I+rYDC4QB9IiOZ3R1Dp/Qgqb2Qc78klr7GOG2XXwISYauri
         fVeg==
X-Gm-Message-State: AOAM5332/UfTwe6POoJsQjWX9mDd+Hrr8+CGTuQ3Ejq5cjpOAQA8P91V
        gRZH/XLU32d7pv+d/pK1rwU=
X-Google-Smtp-Source: ABdhPJwirxuw/aJHDS9bJW/y6AhtTClHMwW2mGG40jIKmVoUrPhfF2PEvdlz3c+4KvcE+F3Oed9cFw==
X-Received: by 2002:a05:6000:144c:b0:1f1:f24b:a70b with SMTP id v12-20020a056000144c00b001f1f24ba70bmr10696191wrx.541.1647086704156;
        Sat, 12 Mar 2022 04:05:04 -0800 (PST)
Received: from [192.168.0.148] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.googlemail.com with ESMTPSA id h15-20020a05600c350f00b00389e7897190sm5795435wmq.3.2022.03.12.04.05.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Mar 2022 04:05:03 -0800 (PST)
Message-ID: <2a4bddac-dca3-0e9a-5d84-00dc39b31699@kernel.org>
Date:   Sat, 12 Mar 2022 13:05:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] arm64: dts: intel: add device tree for n6010
Content-Language: en-US
To:     tien.sung.ang@intel.com, dinguyen@kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     niravkumar.l.rabara@intel.com
References: <20220312080127.1528190-1-tien.sung.ang@intel.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220312080127.1528190-1-tien.sung.ang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/03/2022 09:01, tien.sung.ang@intel.com wrote:
> From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> 
> Add a dts file for the Silicom FPGA SmartNIC N6010/N6011,
> which is based on the Intel Agliex platform.
> 
> Acked-by: Dinh Nguyen <dinguyen@kernel.org>
> Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> ---
>  arch/arm64/boot/dts/intel/Makefile            |  1 +
>  .../boot/dts/intel/socfpga_agilex_n6010.dts   | 83 +++++++++++++++++++
>  2 files changed, 84 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex_n6010.dts
> 

I understand this one should be abandoned?

Best regards,
Krzysztof
