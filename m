Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77FDF4E2C68
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 16:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350344AbiCUPh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 11:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345364AbiCUPhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 11:37:24 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381694B430;
        Mon, 21 Mar 2022 08:35:59 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id q20so8794920wmq.1;
        Mon, 21 Mar 2022 08:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zeB3x3APdJn10Q/65pa9H4C06swtypRcP5k7mf1+6xM=;
        b=UW2i+3qFiir2ZAB+TP2REhqERmIxVwvkZQx95jQmct4AMuf7P7E4uGp78abhHld5Ls
         mrw9uo2WyxZiGDTiFruBC1l2CXYbRudjO7VFcFbMLcwkcqWGEWewNpXgBwoWDSRcfRNX
         R2nwKGFb/6O+rLecLJW/lGA0ZdYyndDmU/uZa14/Tnzycz2TBcXqS/h/bK9hTMwQut7P
         ryTujVsJUstA6eW3mwe8GjBReM5ZxtUyNzCPm7W4pD+/pJm0QKBQiKk9jjBs1wkIk892
         HBr0NWev80E+WWTl6m6w44eHdjwiwI7MaBdXXrYmhVibfQ70uPwNBKJynh8j4eSd+z3j
         Es4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zeB3x3APdJn10Q/65pa9H4C06swtypRcP5k7mf1+6xM=;
        b=aLXcoLHe37iTZD/uvqWTRK0nCwofVB6RbK4em2A34N41WEqhkDB70/xYiT1A3rJ9o7
         +TWnqPx26TKBmkx0geWQLJ2/LcLAmXvDczI3dyOJlIIOzu0e8dFZpaNZSjEa5LWawRBi
         yDf8dAr7rFQ4FgOzVL55VtAfRMlitmChWrC+uEmNqGIscH94SmOGpVdw0GXky23munxt
         zNyv0UEQN6xC1rbtVN3ryRYyJ2Hjyk7GQXhGK3VVPf/TTTKPDh7WXoKcam0Je8GtWEMU
         H/ipefnH3474jP31bqrxeu+tdMQFqrHGka0e6pGfOu9KkzTSG7qXPeBtXebo2zGBqg6X
         Zk0A==
X-Gm-Message-State: AOAM533qd4e+E+bQVqDQ5c32109G9i8PpIym7s0Hd6gScD0ylBljifpz
        pOpw65eMSOkQ0djReX7cIWcN4Lsg7P8=
X-Google-Smtp-Source: ABdhPJwNo4n+gak51bhFbPpO1rwKapfoWzj27hvrH6TGolCr6Aa9tUINJNwvSciiDzE2HYt2Mu9e0w==
X-Received: by 2002:a7b:cc12:0:b0:37c:1ae:100a with SMTP id f18-20020a7bcc12000000b0037c01ae100amr27344039wmh.54.1647876957649;
        Mon, 21 Mar 2022 08:35:57 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.gmail.com with ESMTPSA id g5-20020a5d64e5000000b00203914f5313sm13672805wri.114.2022.03.21.08.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 08:35:57 -0700 (PDT)
Date:   Mon, 21 Mar 2022 16:06:38 +0100
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v4 15/18] dt-bindings: clock: Add L2 clocks to
 qcom,krait-cc Documentation
Message-ID: <YjiUfln1MzDyTDHZ@Ansuel-xps.localdomain>
References: <20220321144825.11736-1-ansuelsmth@gmail.com>
 <20220321144825.11736-16-ansuelsmth@gmail.com>
 <3ee94d1d-4e16-a744-c217-c4bc69ad96b4@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ee94d1d-4e16-a744-c217-c4bc69ad96b4@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 04:33:02PM +0100, Krzysztof Kozlowski wrote:
> On 21/03/2022 15:48, Ansuel Smith wrote:
> > Krait-cc qcom driver provide also L2 clocks and require the acpu_l2_aux
> > and the hfpll_l2 clock to be provided. Add these missing clocks to the
> > Documentation.
> > 
> 
> Thanks. It would be also nice to see here short sentence about expected
> impact, e.g. there are no in-tree DTSes which would be affected, no out
> of tree known users etc.
> 
> Because basically with this requirement you change the ABI, so you might
> break some users.
> 
> I will leave it to platform maintainers to decide whether it is accepted
> or not.
> 
> 
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> 
> Best regards,
> Krzysztof

In the driver I keep support for both and also I tested the changes with
the old wrong implementation. Both works so we shouldn't have any
regression.

-- 
	Ansuel
