Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6610A517A4F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 01:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234814AbiEBXG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 19:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235890AbiEBXGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 19:06:24 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5642E09E;
        Mon,  2 May 2022 16:02:51 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-e2442907a1so15710228fac.8;
        Mon, 02 May 2022 16:02:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8IspzxFERsjs7LWJZpaODsneW32XlcgqODx6/89mEyA=;
        b=z6R2+WAZpCKsxl63U813D5VptQWh+yZf/sYLzQUHRy81qSZ712//XrFpg8ANcO4uUg
         f8mrz3gJSyon4v4yfGgp8Pe9VMtXjyinSlWzy+rH43q5H13QT2OwNLzDlb7BwE50SuBz
         LkItSfEXN0foUWhecGlfsVBAJiBnd5ykXwzQi5+kugRTqv2oETXbIGxx7cFNddlRig+/
         ryQ+fvN8IxF1yxr+Jvuc/rSAW0TcdHb3dmDJh+EAtNev2qnUKmlAVmly4otRlFEaX+bm
         guNcznlISlELczrxfEhb10hquZJx7n9qGteUmaUbFbpbsUconQjHphmbvzTFb9zR4Pl6
         jrjg==
X-Gm-Message-State: AOAM533JlUZfpVjXSvuHIesiaT/b8EIBnvBe2AcDUOcBvOan6fdl/ZDA
        RLF8TqIxhcVaIOq7NkHC8mi6L+6rxw==
X-Google-Smtp-Source: ABdhPJwQfGK5FsZDVaTzCNCXyNiXx5vtTSbwkLOnrcW53NjjUhXEtmJRE3zq4UZYvrUnP/Bgut2bmQ==
X-Received: by 2002:a05:6870:f601:b0:e8:c1bb:3843 with SMTP id ek1-20020a056870f60100b000e8c1bb3843mr664299oab.4.1651532570352;
        Mon, 02 May 2022 16:02:50 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m13-20020a9d73cd000000b0060613c844adsm2137012otk.10.2022.05.02.16.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 16:02:49 -0700 (PDT)
Received: (nullmailer pid 1964955 invoked by uid 1000);
        Mon, 02 May 2022 23:02:49 -0000
Date:   Mon, 2 May 2022 18:02:49 -0500
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: gnss: Add Broacom BCM4751 family bindings
Message-ID: <YnBjGW2ODC3nMbse@robh.at.kernel.org>
References: <20220425132215.1309216-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425132215.1309216-1-linus.walleij@linaro.org>
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

On Mon, 25 Apr 2022 15:22:15 +0200, Linus Walleij wrote:
> The Broadcom BCM4751 family of (A-)GPS chips have been around for
> some years. The latest iteration BCM4753 is for example mounted
> on the Huawei HiKey970.
> 
> Cc: devicetree@vger.kernel.org
> Cc: phone-devel@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Switch do dual GPL/BSD license.
> ---
>  .../bindings/gnss/brcm,bcm4751.yaml           | 69 +++++++++++++++++++
>  1 file changed, 69 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gnss/brcm,bcm4751.yaml
> 

Applied, thanks!
