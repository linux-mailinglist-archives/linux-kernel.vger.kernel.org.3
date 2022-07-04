Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AADE564FB7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 10:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbiGDI1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 04:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233278AbiGDI1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 04:27:45 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A90B1DA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 01:27:43 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id t24so14537215lfr.4
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 01:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=QxkXeeXIDgCAJcCiLPbW+EshYmQoT7+KSy0IFBhHhnY=;
        b=DDqSh3qtr335XHKRUnH4RUgMMkcM4+eXLjC0UKeobB5w8nfZRGTD+MfNmQvN3cFg4a
         BcLJS2lyCqym+w8Bwzy/anWUht5NkBajMXYbofy0oN5kjYPJXL/862LHCJOY1eqeUpMT
         z4648TtMdlU2NDyXjBkscBZR3PdVJ4xaH6U/h+g6z3cSkdgzUzsCd2vErziuxaa2wW/+
         xf17J9GRTJj4CR6ksOEqCKtJ4jPJErCFIu7hQXqi92xIXMHTKjNv7ZWhzP72oBOFOm0S
         9mJPRfMIlF9eA+l30/A522E2v19BabDkaDroeU2YORnYBV/BMd0pET+tEDMLYufB+P7b
         StWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QxkXeeXIDgCAJcCiLPbW+EshYmQoT7+KSy0IFBhHhnY=;
        b=D2hA8TYX8fLmZxVAIrEKvwFhUsaL845uOqPKgpgDaGQScV1/ALNRTOjUnnkAWWEyxv
         oNDeEqqeoPVmiBYP5E+K3/mG+Q6OyzYdqC35NuiV7p4BIzy8HZx0oOJo6RuZ805ek8uy
         r/dKoe1wDmbY7XEZlNx+RCyeS9RS0dsh6+P60ByQvcOVh3u46LEKBTGrs5+GdFbMhX6n
         nKAaebOK6yCRZEQ2ghgPRDcjpoLlbRDJPxugU8F/lyl9tLejPRZyiVfGo92fVHOpGV/m
         /1K5Mc+1V4MSScQyKpUVcDYtDLvdf4YPFHIigddo3bHoUPjna123tl0l2SB3rPx0zHEP
         zHpQ==
X-Gm-Message-State: AJIora/ngt9H7ONQxzxUfukYBI8hNsThlLSsJ83YWaTs8wfxi421O/v0
        q7v0bGWYjRrfkyT8PD3xRu2oyw==
X-Google-Smtp-Source: AGRyM1tvKKdcqAXHO5VhMXu0iwj0PbF+/USazXfbbEoZGizh+75B2u/lIZYQWxC0TVNj1b1QBHz0sw==
X-Received: by 2002:a05:6512:2314:b0:481:1694:f888 with SMTP id o20-20020a056512231400b004811694f888mr17103853lfu.562.1656923262041;
        Mon, 04 Jul 2022 01:27:42 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id q185-20020a2e5cc2000000b0025a891f7b8dsm4839763ljb.32.2022.07.04.01.27.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 01:27:41 -0700 (PDT)
Message-ID: <9448e378-35cd-a39c-869c-845605cbee84@linaro.org>
Date:   Mon, 4 Jul 2022 10:27:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 1/4] arm64: dts: ls1028a: Update SFP binding to include
 clock
Content-Language: en-US
To:     Sean Anderson <sean.anderson@seco.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Walle <michael@walle.cc>
References: <20220630223207.1687329-1-sean.anderson@seco.com>
 <20220630223207.1687329-2-sean.anderson@seco.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220630223207.1687329-2-sean.anderson@seco.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/07/2022 00:32, Sean Anderson wrote:
> The clocks property is now mandatory. Add it.
> 
> Fixes: eba5bea8f37f ("arm64: dts: ls1028a: add efuse node")
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> Reviewed-by: Michael Walle <michael@walle.cc>

The subjects of all these 4 patches are confusing - you did not
update/add any binding here. These are not bindings.

Best regards,
Krzysztof
