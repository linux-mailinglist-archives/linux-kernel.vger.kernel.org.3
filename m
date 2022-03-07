Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B824D0BC6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 00:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343907AbiCGXL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 18:11:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343894AbiCGXL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 18:11:57 -0500
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9220336E0A;
        Mon,  7 Mar 2022 15:11:02 -0800 (PST)
Received: by mail-oi1-f177.google.com with SMTP id ay7so16989287oib.8;
        Mon, 07 Mar 2022 15:11:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YRfqFELcWVyg2C0Z8c/QbnMQFJjccSNmjBm3TiU5pg4=;
        b=a2ced1H45CwcO5twzpKJEqtjAxW+fapJZYUdR+6f3sS8GNexqAYu1M2qnwC85Amq8W
         bljT8G7wvLbZKAhUpBNdougDbld6Oe2S1jRQq2EpfAAUuWwjb4jTJK1keBYd0ooq5CkQ
         +D6o1jqcoHPwrwfYsUiP6P3Rr1SbzGhQKFEPEIKTwZnwD/GMw+QipBzud7cAbA6Ip423
         qUIH3gMsSEFlhLovrtIbtjESiXdPLRg0SSdbL7U83MpaIjtlhjXYxj4ayiN2AKYpoa2j
         yTSyZi1S4L0fr/WaXZXIZsH/AnoM0vsCL6Ly2WkidYfKYiyFCn2JW/Dl37ezCeG92qNG
         Wjjg==
X-Gm-Message-State: AOAM531PgilQONjrUwzB21Gtax2W+gxLPQESyBkJS6YO1nMxohDbMAwH
        iyvbU7o5GhlNu9USJDO4gQ==
X-Google-Smtp-Source: ABdhPJwmGbwU3z+c/gW7xfUYvON7donC6Vbtf+UOEihI0WuO7i7Qo6ieW2MkRh8sJ1tlVi9ZkNK9gA==
X-Received: by 2002:a05:6808:150c:b0:2d9:f976:3851 with SMTP id u12-20020a056808150c00b002d9f9763851mr881007oiw.85.1646694661748;
        Mon, 07 Mar 2022 15:11:01 -0800 (PST)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id c12-20020a9d75cc000000b005b24b061940sm307166otl.33.2022.03.07.15.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 15:11:00 -0800 (PST)
Received: (nullmailer pid 3435797 invoked by uid 1000);
        Mon, 07 Mar 2022 23:10:59 -0000
Date:   Mon, 7 Mar 2022 17:10:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        michael.riesch@wolfvision.net,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, jbx6244@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 3/8] dt-bindings: usb: add rk3568 compatible to
 rockchip, dwc3
Message-ID: <YiaRA/TrWENhntlz@robh.at.kernel.org>
References: <20220228135700.1089526-1-pgwipeout@gmail.com>
 <20220228135700.1089526-4-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228135700.1089526-4-pgwipeout@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Feb 2022 08:56:54 -0500, Peter Geis wrote:
> From: Michael Riesch <michael.riesch@wolfvision.net>
> 
> Add the compatible for the Rockchip RK3568 variant.
> 
> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
> ---
>  Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
