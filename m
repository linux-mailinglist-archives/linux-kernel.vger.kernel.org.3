Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC955673D6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 18:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbiGEQHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 12:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiGEQHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 12:07:15 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4A32BEF;
        Tue,  5 Jul 2022 09:07:14 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id e40so15913319eda.2;
        Tue, 05 Jul 2022 09:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=bx/EJggf6KcEWSl78VZFvCZA1bCij/Kz84s+ZwLTqgE=;
        b=hTAl5+5XREayMO4p+liGgfG2mSJNQTz7Ywte9M4phbuNT5HoVEWvDanjOcRaIUndY9
         ZlPjrPUjjpMdtA/P2ek1E0WeEF/I0ZV4fRoLEq/eNK1w2YF8gD3CmUfgenpY6jHj1Bor
         R70nRVOz6pl7SnO9wbri56gFpjoMErMHCpopBTmDi4Fnr90ad+dRzYXep6504hjLqhIr
         eNSF6BS7dJEFTxDPjepKU/BP/2Ve0GHXlv9NmZeyHIClKGthTFcqHIwAg6rgur6bHBGO
         fa1iE5lgXj50vCaYtDLq+zf2hsdXuN7bEeaaKhBlbTZ+NCXD7ebQ/bdOhpYhz618GqSM
         yGsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=bx/EJggf6KcEWSl78VZFvCZA1bCij/Kz84s+ZwLTqgE=;
        b=epyasN6hfkYAROsaTALzOHdySeXqzcn3I1W0hHJBuNwG3in2KEwDtWeRGJQuJgolcm
         ybJHFzusLGpv60BlGTkIs/KtI4QpmBmckhKzYpx/W9+mzamiv9L/X7a3dqf9u0ev024Y
         V0s7T2sEebisKLjGgQ+pNhWFN5Pms0ReUCuYEO6P/5D4OgGGbinmbrn/ZlU9qmHAP5SR
         Ky7JRVAZJDPd8HxC+doAdHRJ4tBD9r8tacWwG63s1bnaS/xqZH3Lzn3o6FckORBjrfZe
         urQfeP7iEk/sNKRe30nDwAUllqnbZjArbh6EON5dgaUoeq76o6ouWadO2OjiG45UhnDk
         T8Ag==
X-Gm-Message-State: AJIora8/AUEw80MZJ84yur3Lg6ihzLGW/PvZjZg5Z/KRzXXu3hUOcbrw
        sChkyaTXtTCF0+ooAc9BPmW05Frxb5Y=
X-Google-Smtp-Source: AGRyM1t7cwDBFosE8VpWeVc4hDn0LCZDbHk6DVnONl4LNonZMzby2vZMXem4aVvw9BGQej4CtP9y4Q==
X-Received: by 2002:a05:6402:5299:b0:435:61da:9bb9 with SMTP id en25-20020a056402529900b0043561da9bb9mr48015409edb.21.1657037232545;
        Tue, 05 Jul 2022 09:07:12 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.gmail.com with ESMTPSA id t4-20020a17090605c400b00706242d297fsm15813723ejt.212.2022.07.05.09.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 09:07:11 -0700 (PDT)
Message-ID: <62c461af.1c69fb81.25b26.c45e@mx.google.com>
X-Google-Original-Message-ID: <YsRbYtnp0A4+GZze@Ansuel-xps.>
Date:   Tue, 5 Jul 2022 17:40:18 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/13] Add ipq806x missing bindings
References: <20220705133917.8405-1-ansuelsmth@gmail.com>
 <e84bb14b-a3a5-728d-e3a4-9d2e898a7aca@linaro.org>
 <62c44b32.1c69fb81.c87b7.72ac@mx.google.com>
 <5625666e-a777-c4e6-ad91-5c27ebe3f3b5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5625666e-a777-c4e6-ad91-5c27ebe3f3b5@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 05:55:14PM +0200, Krzysztof Kozlowski wrote:
> On 05/07/2022 16:04, Christian Marangi wrote:
> > On Tue, Jul 05, 2022 at 04:28:47PM +0200, Krzysztof Kozlowski wrote:
> >> On 05/07/2022 15:39, Christian Marangi wrote:
> >>> This series try to add some of the missing bindings for ipq806x.
> >>>
> >>> This still lacks of the cpu bindings and all the bindings required
> >>> to scale cpu clk or L2. These will come later as the driver and
> >>> documentation require some changes.
> >>>
> >>> So for now we try to add bindings that can directly applied without
> >>> making changes to any drivers.
> >>
> >> You mention here and in subject bindings, but your patchset does not
> >> have any bindings.
> >>
> > 
> > What would be correct word? Node? Compatible?
> 
> "device node" or just "node"
> 

Ok will fix it in v2 and also in other patch where I used binding
instead of node.

-- 
	Ansuel
