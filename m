Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EAA44B2A77
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 17:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351552AbiBKQeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 11:34:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242130AbiBKQeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 11:34:17 -0500
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B182D65;
        Fri, 11 Feb 2022 08:34:15 -0800 (PST)
Received: by mail-qv1-f41.google.com with SMTP id a28so8942019qvb.10;
        Fri, 11 Feb 2022 08:34:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ezNh3EWqFsaaHlTrJOp98oUzk3Ea1bEigkfyW/1bRyI=;
        b=jw06rknBTakeYUYLqiVd1ypF3mhjn0E7Hv7cQII8Y34axuPkq8JzHuOo8dCO/nv5Yh
         2rk5FI+N5n7Z1YoCns7kQ66HFn6GioDiRcsF0kZFHHIHKd3aHMdmxeKw2NS4LdWo/W40
         yzjFzHdBzM5ZH6O83ojVRARuJAhHwixX+YbSTpkyx+iAnvFLfc4naTNRZd6IK00yXwlV
         qiLalHghZbjHxhhyT25gDAL39Cid8V6uBGCjScQjf4a9B4j0st4UucFApQNvDHRUiA+Q
         CuyKpVPUr1NmqxryfD2kJFxS+X7C8TwVqvSxuYEYlhknnZHD1kDbXBRqpWT7wq0zPzhZ
         pE3A==
X-Gm-Message-State: AOAM531CzU19CPGLtqLNOK/dp2sjTUCEbv+WDaSmZE5rwo8cUH/Cw2iP
        0cCp39EIxvspqEGAP9yo51ZwK2iJ9Q==
X-Google-Smtp-Source: ABdhPJzj+wCyynuKjTOGmIuc/1i5fpet5RySNhT8B/SqV7zEdro99sXdRni/6BFsjBoqncLtEVijyA==
X-Received: by 2002:ad4:5bac:: with SMTP id 12mr1717492qvq.34.1644597254399;
        Fri, 11 Feb 2022 08:34:14 -0800 (PST)
Received: from robh.at.kernel.org ([2607:fb90:5fee:dfce:b6df:c3e1:b1e5:d6d8])
        by smtp.gmail.com with ESMTPSA id bp18sm4153957qtb.72.2022.02.11.08.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 08:34:13 -0800 (PST)
Received: (nullmailer pid 480397 invoked by uid 1000);
        Fri, 11 Feb 2022 16:34:11 -0000
Date:   Fri, 11 Feb 2022 10:34:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?Andr=E9?= Apitzsch <git@apitzsch.eu>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-leds@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 2/3] dt-bindings: leds: sgm3140: Document ocp8110
 compatible
Message-ID: <YgaQAwfYnt6E9buG@robh.at.kernel.org>
References: <20211117091405.7412-1-git@apitzsch.eu>
 <20220207230638.56730-1-git@apitzsch.eu>
 <20220207230638.56730-3-git@apitzsch.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220207230638.56730-3-git@apitzsch.eu>
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

On Tue, Feb 08, 2022 at 12:06:37AM +0100, André Apitzsch wrote:
> Signed-off-by: André Apitzsch <git@apitzsch.eu>

Commit msg? What's this h/w?

> ---
>  Documentation/devicetree/bindings/leds/leds-sgm3140.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/leds/leds-sgm3140.yaml b/Documentation/devicetree/bindings/leds/leds-sgm3140.yaml
> index f68259619488..1c345cf16d08 100644
> --- a/Documentation/devicetree/bindings/leds/leds-sgm3140.yaml
> +++ b/Documentation/devicetree/bindings/leds/leds-sgm3140.yaml
> @@ -18,7 +18,9 @@ description: |
>  
>  properties:
>    compatible:
> -    const: sgmicro,sgm3140
> +    enum:
> +      - ocs,ocp8110
> +      - sgmicro,sgm3140
>  
>    enable-gpios:
>      maxItems: 1
> -- 
> 2.35.1
> 
> 
