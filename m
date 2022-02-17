Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077994BAADF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 21:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343576AbiBQU0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 15:26:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343574AbiBQU03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 15:26:29 -0500
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8434166E01;
        Thu, 17 Feb 2022 12:26:14 -0800 (PST)
Received: by mail-io1-f42.google.com with SMTP id w7so5124217ioj.5;
        Thu, 17 Feb 2022 12:26:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vor4YtyDZgpnRzyqF0dXDY/vRW7EOoRe/r5dnL1ZLQg=;
        b=vM4OQPyH+ozY5r/KgDCMUvF+PyU6mfL17TRHt4COMM1Yk1sHVvKg5JdSTCzC2CXNRH
         APs/E5Aml/ZHgf6YXHszbABZfo88LN+a3rc2flH+3KILEnQ2qqo4O9NYK4nyn1O1AtLU
         UgGySOj/a0+fmGL4u8fCPDjEbnh952U5z3Tyy6H6c7BTSmDLT97/xsOjFRV8WfzAyVx3
         z5WSuerphgA+SpJiGpWO6Udg7CX4o4ggLfWtrNPHX5vnm1R4jut+OTpwxqFEYpplW3Uw
         c1NTlzYpzql6jL1OEOsZ6LJano3M4lZ0nL6j9urLgaUhGRkKWyM3sZFlF54Lpfa0LFa+
         9B8Q==
X-Gm-Message-State: AOAM532aDQ5QcOYwsxGoGHQDHj7JGxc+Mh1ilFq7Vjiz1wWLGr6wFv4c
        e4IWryiIfThiVQDu1MXrjA==
X-Google-Smtp-Source: ABdhPJx0exKureLbCBomuzKVmB9EqkRlmaPsBk22Z2l1Z5ZFj3qJjE7J2WGMnPGZagmhxJLUrdJLpw==
X-Received: by 2002:a05:6638:1384:b0:311:985a:ee84 with SMTP id w4-20020a056638138400b00311985aee84mr3190230jad.222.1645129574263;
        Thu, 17 Feb 2022 12:26:14 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id w4sm2302324ilo.53.2022.02.17.12.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 12:26:13 -0800 (PST)
Received: (nullmailer pid 3717063 invoked by uid 1000);
        Thu, 17 Feb 2022 20:26:11 -0000
Date:   Thu, 17 Feb 2022 14:26:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     nick.hawkins@hpe.com
Cc:     verdun@hpe.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stanislav Jakubek <stano.jakubek@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Corentin Labbe <clabbe@baylibre.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hao Fang <fanghao11@huawei.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v1]dt-bindings: vendor-prefixes: add HPE Prefix
Message-ID: <Yg6vY6KTLg7GGpN7@robh.at.kernel.org>
References: <nick.hawkins@hpe.com>
 <20220210175912.102159-1-nick.hawkins@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210175912.102159-1-nick.hawkins@hpe.com>
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

On Thu, Feb 10, 2022 at 11:59:11AM -0600, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> Description: This patch adds the Hewlett Packard Enterprise prefix
> that will be used for upcoming support in the HPE BMC GXP.
> 
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Applied, thanks.

Rob
