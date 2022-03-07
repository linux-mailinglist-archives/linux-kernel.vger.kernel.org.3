Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A22964D0BC4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 00:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343682AbiCGXLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 18:11:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238182AbiCGXLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 18:11:50 -0500
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35108D7C;
        Mon,  7 Mar 2022 15:10:55 -0800 (PST)
Received: by mail-oo1-f48.google.com with SMTP id l24-20020a4a8558000000b00320d5a1f938so7197940ooh.8;
        Mon, 07 Mar 2022 15:10:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nkBLO48gzCNvI+IBClU5RK+7CoWNVNFHz100H8oEGdo=;
        b=0rVk1viQuvOXS4KxslH3dzUXbVW2ksrJ7MUzJpXy6D8LUqyz5Ngvo63zjFQUKjDs5o
         YGQ0h2uJVG93w10WjFdmJ3RQKh/FTmRRW2Ubpeyhy/LfvhF3bU9c1WfFVlvjAIypoFr+
         raBJw7yGsfyiNrUbKDqfds4lgfUSUXgYMcbe+O+47uVbwPyLO9sY/opm2WMZ+mQys939
         c1wps2WRwknHgr0tFrVqG2O+qqMZ57zVuF79oIejuav5K3GLrFXtSxIr5hSvxDk4aDRQ
         X5qv8rK4+oF5KrGSA3DrCUKIfKUejjp3s6crykuc9bipuudQ4f8JcwE+n5ydrW0HpEQQ
         MEnQ==
X-Gm-Message-State: AOAM530XW543jJDI531M1gYtvo8Cu82WwXk4evqbAATuBvjY2QmbCI0N
        aUMJF4txGbkUgZNYLNruNg==
X-Google-Smtp-Source: ABdhPJxrx7Hu4lAbfCKCKJ+t3ikxlnN3bhxU5XMx/wSCqgQ4Orqy580XHAv9NV5wA7tJvI0Q+ACOHA==
X-Received: by 2002:a05:6870:b016:b0:da:b3f:324a with SMTP id y22-20020a056870b01600b000da0b3f324amr755404oae.250.1646694654501;
        Mon, 07 Mar 2022 15:10:54 -0800 (PST)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 125-20020a4a1483000000b003175bffb677sm6309138ood.2.2022.03.07.15.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 15:10:53 -0800 (PST)
Received: (nullmailer pid 3435491 invoked by uid 1000);
        Mon, 07 Mar 2022 23:10:52 -0000
Date:   Mon, 7 Mar 2022 17:10:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     jbx6244@gmail.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        devicetree@vger.kernel.org, michael.riesch@wolfvision.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v4 2/8] dt-bindings: soc: grf: add rk3566-pipe-grf
 compatible
Message-ID: <YiaQ/DbBp+Ljwx7a@robh.at.kernel.org>
References: <20220228135700.1089526-1-pgwipeout@gmail.com>
 <20220228135700.1089526-3-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228135700.1089526-3-pgwipeout@gmail.com>
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

On Mon, 28 Feb 2022 08:56:53 -0500, Peter Geis wrote:
> The rk3566 requires special handling for the dwc3-otg clock in order for
> the port to function correctly.
> Add a binding for the rk3566-pipe-grf so we can handle setup with the
> grf driver.
> 
> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> ---
>  Documentation/devicetree/bindings/soc/rockchip/grf.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
