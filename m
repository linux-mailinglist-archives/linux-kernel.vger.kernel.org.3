Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994294C4EBE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 20:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234694AbiBYT1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 14:27:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234581AbiBYT1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 14:27:31 -0500
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ECE51EF367;
        Fri, 25 Feb 2022 11:26:59 -0800 (PST)
Received: by mail-ot1-f43.google.com with SMTP id u17-20020a056830231100b005ad13358af9so4293447ote.11;
        Fri, 25 Feb 2022 11:26:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d4ZYSRW1dAUfXWRROJzyzdU8p+UwgSZW2avfzTgdLkg=;
        b=IRrKzdfBa+B+IvJtseuVRdZJmW9FeGt9JmILqq/8xvHbkdocfSeVyJjV9qal2kekCd
         3iJFYjh6leuLQKfugzVO2R8YVWkE+ujagoVuXAbYBNsXXhF0WoR+HtHkWLf7s0JxyiWi
         Vt97uebtg/fgqbuyWlr1sF7bMwbyk8CDBy0C3oCBtPw/CvoZe6G9q3h+GdPvJ4G8Wu18
         RpaW2bdUJ81ioY+XLy3w/c3VldJnEfyFi3FJNxRNpM10s3nwuT4DCm3xUzn0+3ww02ec
         eVq2/QwXpvmKwpAS5PBNpLi6C+nNPpH0eGlDhewtKSoCPDqCBoaEnzcVJ/sTU36sAZqu
         3wxQ==
X-Gm-Message-State: AOAM530HenKqacMUU36tti+dI1O4AMYW+hVJkLyW6stgBNzqsvX2eGwi
        tXUB+drvg9FZKpsQwbnuHA==
X-Google-Smtp-Source: ABdhPJyOvYxoHLRFxKgWDc1DweI/wNLPky/0k/5i7fDXZ+qQxiY2uSCuUbWDlvOvGLxWpeCxGE7TKA==
X-Received: by 2002:a9d:6c8e:0:b0:5af:5113:1bd9 with SMTP id c14-20020a9d6c8e000000b005af51131bd9mr3493550otr.86.1645817218931;
        Fri, 25 Feb 2022 11:26:58 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id x3-20020a056808144300b002d4dedfc1ebsm1887396oiv.20.2022.02.25.11.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 11:26:58 -0800 (PST)
Received: (nullmailer pid 1289030 invoked by uid 1000);
        Fri, 25 Feb 2022 19:26:57 -0000
Date:   Fri, 25 Feb 2022 13:26:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Yaniv Gardi <ygardi@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, Avri Altman <avri.altman@wdc.com>,
        Andy Gross <agross@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-samsung-soc@vger.kernel.org, Tero Kristo <kristo@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, Li Wei <liwei213@huawei.com>,
        Nishanth Menon <nm@ti.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Jan Kotas <jank@cadence.com>, linux-scsi@vger.kernel.org,
        Wei Xu <xuwei5@hisilicon.com>
Subject: Re: [PATCH v2 02/15] dt-bindings: ufs: samsung,exynos-ufs: use
 common bindings
Message-ID: <Yhktgf/IKHIPjr56@robh.at.kernel.org>
References: <20220222145854.358646-1-krzysztof.kozlowski@canonical.com>
 <20220222145854.358646-3-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222145854.358646-3-krzysztof.kozlowski@canonical.com>
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

On Tue, 22 Feb 2022 15:58:41 +0100, Krzysztof Kozlowski wrote:
> Use common UFS bindings in Samsung Exynos UFS to cover generic/common
> properties in DTS.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../devicetree/bindings/ufs/samsung,exynos-ufs.yaml | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
