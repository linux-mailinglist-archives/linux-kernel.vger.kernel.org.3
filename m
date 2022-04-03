Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C244F0A8D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 17:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344120AbiDCPN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 11:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238204AbiDCPNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 11:13:24 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9BB38BEF;
        Sun,  3 Apr 2022 08:11:30 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-d39f741ba0so7879479fac.13;
        Sun, 03 Apr 2022 08:11:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m1h55tSJf82mTXNy49E7xrgITJy4PuS1a1RbU7Daru8=;
        b=W9VJ8j1UiTuefRU2U/VnyKbgyH8dep9EZHcjaXjxbwUMZ0SeXPBAz0HXGiWH8qs2d5
         /9YObLo4ZzfmVfOZxBDZ0+p4hTzQZQ0xmD/sEJVkH4iKjLqc6fB+Ewopq84RRKs13I+b
         HYtzh0p4hnCJ+to8J6SLXfiVY+Ki5NHmggudfadHEbAFEC3qLxrH3OFXR2M45eRhXt+O
         ewJEd1hfYSAWIzR5GkSOHSPzG1Th6fzKDs3z85cO4Er0G1D5goMwvcUwNpn80DsJZVi/
         xOmTBgIhaxnEplIbyEB3PpoCVw4EXruqbBQVN8Rd4hCyTtB4lcsA4pGsa9oNibrhKeWM
         /w0A==
X-Gm-Message-State: AOAM532M3VBzXDjJIYOOsmS1Uh8kFWyXy8JfRoYnhF+lRvtbkpYZMUqH
        ZDa/h2u6vStrBuxhd+94040VXNI5YQ==
X-Google-Smtp-Source: ABdhPJwy/B5nwR3a6fzxCQA31lcGBi42z4c18Q1IvNY5UEMaWJqDMwLoOib6qOHIsTAqaouBM1AkDw==
X-Received: by 2002:a05:6870:c208:b0:dd:994e:3b98 with SMTP id z8-20020a056870c20800b000dd994e3b98mr8331704oae.259.1648998689749;
        Sun, 03 Apr 2022 08:11:29 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r129-20020acac187000000b002ef358c6e0esm3239158oif.49.2022.04.03.08.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 08:11:29 -0700 (PDT)
Received: (nullmailer pid 3096945 invoked by uid 1000);
        Sun, 03 Apr 2022 15:11:28 -0000
Date:   Sun, 3 Apr 2022 10:11:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/2] regulator: dt-bindings: maxim,max8997: correct array
 of voltages
Message-ID: <Ykm5IG2EUUSSotUF@robh.at.kernel.org>
References: <20220331211653.175200-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331211653.175200-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 11:16:52PM +0200, Krzysztof Kozlowski wrote:
> uint32-array with voltages should be within one bracket pair <>, not
> each number in its own <>.  Also the number of elements in the array
> should be defined within "items:".

Which encoding an array uses has been a source of pain.

> 
> This fixes DT schema warnings like:
> 
>   maxim,max8997.example.dtb: pmic@66: max8997,pmic-buck1-dvs-voltage:
>     [[1350000, 1300000, 1250000, 1200000, 1150000, 1100000, 1000000, 950000]] is too short

These exist due to the move from validating yaml files to DTBs and I 
haven't come up with how to fix the warning. The schema was correct as 
it was. The change leaks the encoding (everything is a matrix) into the 
schema which we don't want to do.

The issue is in the if/then schema, the tools don't know if the type is 
an array or matrix. It gets it wrong (or different from the top-level) 
and thus the warning. I think the fix will be using the extracted type 
information to do the right transformation. The code for all this is 
pretty horrible and I've lost count of how many times I've re-written 
it. I think a lot of it can be removed when/if support for yaml encoded 
DT is removed which I think can happen in a kernel cycle or 2.

Perhaps in the short term the example can just be removed or commented 
out though that doesn't help on dts files.

Rob
