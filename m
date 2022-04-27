Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5AD51129F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 09:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358918AbiD0HjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 03:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358887AbiD0Hik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 03:38:40 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B737939A4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 00:35:29 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id bg25so625375wmb.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 00:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=muUs/1r9ptuJbX+Vh9bf6M6IYHJPt62nbZRMFin7LdA=;
        b=QJQzpzK87eIOm203lDLMli33vwjYXCAqHCNurNsGhL+iVdJU4yyNXz7iQD6IQFash4
         ysFXU7Ee6y4J+shKrgxRa9hjm/Kr8W7R6h2DX+e6obBMfzhiNQtYhE57bth4cX9I6SIF
         auXeKcPx3G3pcdwXnbG+D6Vs6Ybclvbap12lfU4c5lKIpko95azN3kwTONqTdNYwH0fr
         nQRiF4aGEkVwjf+6IqI53V+h0lZYWgINIaxZ3AtYoNWjnDOsv985txovtWypJIVA0gXE
         bYPhp0zAUUmH4BK6AP5OcN8dOaui8WbZcJaUS1valtt3RVRpnCZSsXYe9uz3Aaxs/fcy
         pOMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=muUs/1r9ptuJbX+Vh9bf6M6IYHJPt62nbZRMFin7LdA=;
        b=LJuk0XfnfzLLjF0FGzOK7krcSC5to72zxRt8mH0G8Clk/ZNFCkmjjF44VB/NhTtbNB
         ucY6qPN/hDDoMQ26zgqcxaJH2GIcGaXGhVpun3gIDy3ktIdT757lmCKBewNLaaW10/on
         WpB81Qpzs/L4sKxddjKDi+PG4nepboh8wGXwxLoqvT9mYIi9u9Hb3zoLSd/F6oUa9PEi
         0bD8gc/Q5/oZAOK1jyOp5urrCqCd6b8wY/M6cuJlfE5ppNpbSkBygxUERDRvbX340TMm
         OMOY5M7D2a3Ju6/3rYmDktmXKA2fuDYP9OiOjfXcH7HvSfvZ25fQ7Ix8F9lfNqhj+LX9
         BvxA==
X-Gm-Message-State: AOAM532WO/W12L73Z+PUAaPPSqC4AfMzE3qXbzOlVajcCsjftu3pOcR+
        6uzqIR5FBoeJz18sn7oXT5fmTsudJxVqfg==
X-Google-Smtp-Source: ABdhPJwCFigJLocUXJ/JkTw6VAdQ/g9b/r/592gJWjQfhB+Ek5mVkeCgP2mRsrVFvwkXPjNwvWpEHA==
X-Received: by 2002:a7b:c0d0:0:b0:392:a02c:28ab with SMTP id s16-20020a7bc0d0000000b00392a02c28abmr33748563wmh.2.1651044927893;
        Wed, 27 Apr 2022 00:35:27 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id w12-20020adfbacc000000b0020aeed10962sm958731wrg.61.2022.04.27.00.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 00:35:27 -0700 (PDT)
Date:   Wed, 27 Apr 2022 08:35:25 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Fabien Parent <fparent@baylibre.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the input tree
Message-ID: <YmjyPSliv+WncweU@google.com>
References: <20220427104825.15a04680@canb.auug.org.au>
 <20220427065318.bdn5h6rdcvdpxdd2@radium>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220427065318.bdn5h6rdcvdpxdd2@radium>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Apr 2022, Fabien Parent wrote:

> Hi,
> 
> On Wed, Apr 27, 2022 at 10:48:25AM +1000, Stephen Rothwell wrote:
> > Hi all,
> > 
> > After merging the input tree, today's linux-next build (x86_64
> > allmodconfig) failed like this:
> > 
> > drivers/input/keyboard/mtk-pmic-keys.c:93:36: error: 'MT6359_TOPSTATUS' undeclared here (not in a function); did you mean 'MT6358_TOPSTATUS'?
> >    93 |                 MTK_PMIC_KEYS_REGS(MT6359_TOPSTATUS,
> >       |                                    ^~~~~~~~~~~~~~~~
> > drivers/input/keyboard/mtk-pmic-keys.c:48:35: note: in definition of macro 'MTK_PMIC_KEYS_REGS'
> >    48 |         .deb_reg                = _deb_reg,             \
> >       |                                   ^~~~~~~~
> > drivers/input/keyboard/mtk-pmic-keys.c:98:25: error: 'MT6359_TOP_RST_MISC' undeclared here (not in a function); did you mean 'MT6358_TOP_RST_MISC'?
> >    98 |         .pmic_rst_reg = MT6359_TOP_RST_MISC,
> >       |                         ^~~~~~~~~~~~~~~~~~~
> >       |                         MT6358_TOP_RST_MISC
> > 
> > Caused by commit
> > 
> >   0f97adf64314 ("Input: mtk-pmic-keys - add support for MT6359")
> > 
> > I have used the input tree from next-20220426 for today.
> 
> The commit is depending on another commit from the same patch serie: [0]. That
> patch has been merged in the tree of the MFD maintainer: [1].
> 
> [0] https://lore.kernel.org/all/20220426135313.245466-3-fparent@baylibre.com/
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git/log/?h=for-mfd-next

Looks like you only sent me 2 of the 8 patches in the set.

In future, if there are dependencies between patches, you must send
all of the patches to everyone.  That way, we can organise a merge
strategy that does not break -next, or worse Mainline during the
merge-window.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
