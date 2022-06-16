Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77F0554E696
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 18:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378014AbiFPQB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 12:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378088AbiFPQBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 12:01:24 -0400
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436C446B3E;
        Thu, 16 Jun 2022 09:01:24 -0700 (PDT)
Received: by mail-il1-f174.google.com with SMTP id y16so1210656ili.13;
        Thu, 16 Jun 2022 09:01:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ml5idGZZFGVZsmwkedTnnQ7F9wlS56EbCyap4RP3ahY=;
        b=F4WsVOdRzjWsJSbA2TOu6xqb+f38WimScRAk76K6zBWQGoCIZ4lTgdvvkf4MWItV2a
         b1J4691eO6EUpGDHVEGd1b+DPALaRhyES+4sIaT6KzaB3Hb1IDAneyt0doRzAYhcsdB5
         +wQ3KGf61XeSt0ZiVbFTtrMf8OjrJmkEhK5AHbwRhq89Meyk/4UyA2T1IFDGPfg6WwYP
         9Zjs387qKbWSWd1hOwr5/7bYNByTdeMiwPYAMqOVT6HdizL/eNoXpgL98XZggBiBKsiO
         nif52Afk5Qa0ntBd/ClI/BktKkLmlfRZ3FadRiNAvtwH7ebi/XvMI22UpCCqS00d0jcw
         t3FQ==
X-Gm-Message-State: AJIora8ECc8ZYC2sd5JVeSaV/UBsXwKWxmZIgDGZ9sIwd/7GpjKtHPwT
        Q0FGnXd7OTPKzbwDhRGd3A==
X-Google-Smtp-Source: AGRyM1uNL2FZJlVB+LbfQzJBLhgEXIPxZR/R3NDQMBJ/s6rrAfeFYBYsxiPCLYQ+P/eg4YPBpflRqg==
X-Received: by 2002:a05:6e02:1b0c:b0:2d3:bfdf:e3c5 with SMTP id i12-20020a056e021b0c00b002d3bfdfe3c5mr3288764ilv.138.1655395283471;
        Thu, 16 Jun 2022 09:01:23 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id x7-20020a056638026700b0033074471f78sm1022920jaq.101.2022.06.16.09.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 09:01:23 -0700 (PDT)
Received: (nullmailer pid 3557158 invoked by uid 1000);
        Thu, 16 Jun 2022 16:01:20 -0000
Date:   Thu, 16 Jun 2022 10:01:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-kernel@vger.kernel.org,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        linux-leds@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: leds: Fix reference to definition of
 default-state
Message-ID: <20220616160120.GA3557025-robh@kernel.org>
References: <20220609223114.183038-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220609223114.183038-1-j.neuschaefer@gmx.net>
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

On Fri, 10 Jun 2022 00:31:13 +0200, Jonathan Neuschäfer wrote:
> At least since the YAML conversion, the default-state property is
> described in leds/common.yaml, so there's no need to point to another
> file for its definition.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
>  Documentation/devicetree/bindings/leds/common.yaml | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
