Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2387C54CBC3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 16:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238643AbiFOOwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 10:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237185AbiFOOwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 10:52:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D504849B62;
        Wed, 15 Jun 2022 07:52:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6CAB360FB9;
        Wed, 15 Jun 2022 14:52:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 311F3C341C4;
        Wed, 15 Jun 2022 14:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655304726;
        bh=GxEyuT1ckbliX64EPOIw+Mu5ci7HRWE5Alba1shSmf8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=pSwqHeFjsHN2ANMyUTPywhZOudNwlMItxKyVwpOeTyRnDbiS8YOL6s12sg5ZjKRsZ
         5EAJ1aRW68m7hsrb1zyEFDMzkrM+dAUbn3q1SERn7OKulABZIHSH+Aksl946ExEPsv
         AjEs79pLY8ffGYFxfdLKUMBI/uQKCjB6Q/EBqVXga8p6SDgzhLEynbybxQibu1xyJT
         ygqRkoqQLilqwIwj2k0ORMjP88nboSqLeNAlmjBcACBcNhZpmI3cWIzz57G6eKOzXI
         37dalXE4d7R/DJR/JVbJ8lv01nY826IOHW+hBJIh2itrniyBa4006TqFFxJU6e+BO5
         DHDfBCHmBulXA==
Message-ID: <8b5126b5-a3a6-9698-4c43-9f1bfb6f6a9f@kernel.org>
Date:   Wed, 15 Jun 2022 09:52:03 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] dt-bindings: altera: document Stratix 10 SWVP compatibles
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        wen.ping.teh@intel.com, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220609025647.400998-1-wen.ping.teh@intel.com>
 <5eec5292-ea45-fe44-75ce-968742c2ee96@linaro.org>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <5eec5292-ea45-fe44-75ce-968742c2ee96@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/14/22 18:25, Krzysztof Kozlowski wrote:
> On 08/06/2022 19:56, wen.ping.teh@intel.com wrote:
>> From: Teh Wen Ping <wen.ping.teh@intel.com>
>>
>> Add compatible strings for Stratix 10 Software Virtual Platform
>>
>> Signed-off-by: Teh Wen Ping <wen.ping.teh@intel.com>
> 
> This must come together with the patch adding DTS.
> 
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> 

Applied!

Thanks,
Dinh
