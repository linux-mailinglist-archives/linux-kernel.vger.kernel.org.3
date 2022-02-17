Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC444BAD3C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 00:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbiBQX0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 18:26:52 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:49020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiBQX0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 18:26:50 -0500
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF4B41611;
        Thu, 17 Feb 2022 15:26:26 -0800 (PST)
Received: by mail-il1-f175.google.com with SMTP id p11so3442997ils.1;
        Thu, 17 Feb 2022 15:26:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CBVOwnbmoloPGwFVKHueD8/Nvd+YkNpZVKFIo7AUGX4=;
        b=1QoJJ3D2ZVHbwof5Qn52tUC3P2WZmOrXhhoGf4Yw0cCK12N7Dz8bit6FS+g7l4fNyG
         7KXyF9faIp+iV5na5ust02Qp8DQVtoypjxneZVUhr663SpAfnl1S1DqARxkaW7ZyumQG
         vgjAZcJbd75q2y5W3T9HKja09KuXIGxs8mxWtCPrZKmkV7/cnKXM0L2QadJbRjECzDPT
         GO2zr9a+xdDwID0m2bB5R4FDFMaK3PsWiAVihXcA07gElbQ2HyewqgzPllIk2611o3vs
         ZlpLJp9xdFifpnnklBk0LnsshYB3RYJwmHZVNZB5ZhtQhQ8LNc9vpcxpTU97jja8b5tk
         Ld+g==
X-Gm-Message-State: AOAM533gGiqss9dgEFp1jR/FrCF2EEL4TCBcTD6Ln2ApN9vaPFirnYVx
        573k0oJ7DSbkHQhAvVM2fg==
X-Google-Smtp-Source: ABdhPJwQxPC3TlRejg4SvaZFmO7PuTEZVo1/PtrrdUYbJhGod1dUI9GyuRnKaU6J8NWm0/aTzDK6Yw==
X-Received: by 2002:a05:6e02:164b:b0:2be:4119:bc6d with SMTP id v11-20020a056e02164b00b002be4119bc6dmr3486017ilu.30.1645140086894;
        Thu, 17 Feb 2022 15:21:26 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id s13sm2495950iln.69.2022.02.17.15.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 15:21:26 -0800 (PST)
Received: (nullmailer pid 3960587 invoked by uid 1000);
        Thu, 17 Feb 2022 23:21:24 -0000
Date:   Thu, 17 Feb 2022 17:21:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        festevam@gmail.com, jassisinghbrar@gmail.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, daniel.baluta@nxp.com,
        krzysztof.kozlowski@canonical.com, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V3 1/5] dt-bindings: mailbox: imx-mu: add i.MX93 MU
Message-ID: <Yg7YdNvkXaJ7F914@robh.at.kernel.org>
References: <20220211060301.1852772-1-peng.fan@oss.nxp.com>
 <20220211060301.1852772-2-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211060301.1852772-2-peng.fan@oss.nxp.com>
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

On Fri, 11 Feb 2022 14:02:57 +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add bindings for i.MX93 MU which derived from i.MX8ULP
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  Documentation/devicetree/bindings/mailbox/fsl,mu.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
