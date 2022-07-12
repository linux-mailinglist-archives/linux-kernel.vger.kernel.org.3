Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79A0657143D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 10:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232236AbiGLIRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 04:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbiGLIRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 04:17:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13FB2A2395;
        Tue, 12 Jul 2022 01:17:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ABBFDB8162F;
        Tue, 12 Jul 2022 08:17:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDEFCC3411E;
        Tue, 12 Jul 2022 08:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657613857;
        bh=/4FpR0s9G33GoZT2vsR7l1yUnYnNtqmg8K7NSFJYFEM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NJZpkIgZZm+Bq+pUoO4WkeuCZjQ1yVrcXTLoal5Gm7tEX7CyjIWajSdLj9FUx2JWj
         nECsmKLOBwUwOOVXYFycPIZtJXjKcc3MQbwVVgWicegxWMJ/E8OrDO8FQms63NxXCG
         5eS8bpOMZqhK/wL7L5Ab2BaLvem/AaNRgm+6/oDcfF/e87DBtGcmAoPmj4wVK1exfV
         42z9p6ci0Qcp1WD4B50J/1U3dWAIqNAEigpRvb8r3oBnVL/+Km4rIVjwN2IiHH3cd4
         cXo6/WxK+5dlLGnoAn1qAUOzZ7CtUVHw1awDk+n7gZiUhfant513F2OH9fPqNMTwoJ
         oIHUQ+Y9VUvmw==
Message-ID: <90c225d3-ed49-8399-770e-352c8f88001f@kernel.org>
Date:   Tue, 12 Jul 2022 10:17:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/3] media: dt-bindings: ak7375: Convert to DT schema
Content-Language: en-US
To:     Yassine Oudjana <yassine.oudjana@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Jacopo Mondi <jacopo@jmondi.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220711144039.232196-1-y.oudjana@protonmail.com>
 <20220711144039.232196-2-y.oudjana@protonmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220711144039.232196-2-y.oudjana@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/2022 16:40, Yassine Oudjana wrote:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Convert DT bindings document for AKM AK7375 VCM to DT schema
> format and add an example.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
