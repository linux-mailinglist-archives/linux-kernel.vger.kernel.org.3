Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBCDE597E68
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 08:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243551AbiHRGKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 02:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243540AbiHRGKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 02:10:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA15E8FD6C;
        Wed, 17 Aug 2022 23:10:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18CF3610A7;
        Thu, 18 Aug 2022 06:10:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0DB7C433D6;
        Thu, 18 Aug 2022 06:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660802999;
        bh=OD8oMo72p4wxFRHbyCifSgKk0dJKWaCqqQFilPDohkw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cjOtuvyadF4vFjOWxcnzk3IQVlBgD+RuJmPGsdkQyXqHlM1czMU5TZ94t/MdIqbGN
         AAT5InxwnVObM2L25DWwOPrlJ1I52udFM7ke5d+BigEaGwf8mH90COjXcX/j4xP1iO
         wdHez1/+/5hIY1uvhdOuN+xR3hhoZPSjH+PjGFHMt/RRBDVQ/uu0mrc19GdIfjThIu
         O2bKDGBUvYir0wcsvwO1xYjl2SYmpvztcwwS64yNee5CrExFUij2LHCLVeLI/U5VNz
         R1NiuI8YcW+6GUuLKu2f4B4CfCPOc7C1aFeDB6szRtmL5JfHTkcOmhNng677kW7nKm
         HsFd2Rer120tw==
Message-ID: <427c0198-850c-17a7-f0d7-954a8252b11a@kernel.org>
Date:   Thu, 18 Aug 2022 09:09:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [krzk-mem-ctrl:for-v6.1/brcm-stb 1/3] htmldocs: Warning:
 Documentation/devicetree/bindings/arm/bcm/brcm,brcmstb.txt references a file
 that doesn't exist:
 Documentation/devicetree/bindings/memory-controllers/brcm,memc.yaml
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>, linux-doc@vger.kernel.org
References: <202208180941.oGoLuq8U-lkp@intel.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <202208180941.oGoLuq8U-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/08/2022 04:59, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git for-v6.1/brcm-stb
> head:   65991a63d02decf269e7d5334620df0dd5919762
> commit: 0da0b6bf854dcfb047fec70bbbadabb7ff0fcb3e [1/3] dt-bindings: memory-controller: Document Broadcom STB MEMC
> reproduce: make htmldocs
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>>> Warning: Documentation/devicetree/bindings/arm/bcm/brcm,brcmstb.txt references a file that doesn't exist: Documentation/devicetree/bindings/memory-controllers/brcm,memc.yaml

I'll fixup the commit.

Florian,
It's useful also to have own development trees covered by LKP.

Best regards,
Krzysztof
