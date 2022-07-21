Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6BC57D244
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 19:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiGURO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 13:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiGUROZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 13:14:25 -0400
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8638987220;
        Thu, 21 Jul 2022 10:14:24 -0700 (PDT)
Received: by mail-il1-f181.google.com with SMTP id n13so1119367ilk.1;
        Thu, 21 Jul 2022 10:14:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/e55ZEMCQkaNfvycHhe9ziyAAyk3V5xXXgVJZrzfB1k=;
        b=7XUMFjXZBhgd/ZC9yEd1SR/oVJH1uxDTn/gTirQ38wtPBbAUN0+868Si3etBf/b6zJ
         ZAUyP6/AmRUJATSjl3UNkkzmowD71T8FeGfmytwUlnyw8v96Za6lQgXkVnikM8BFPjNq
         yGfoS1cOQVJcnHhICqKcvWIcSqY9PZgXjWLT6zbq2q2Oof/z+bKfyBdPnEjhCKubdULZ
         cHJVoKLva5EVPZ3agYKNO5Hf0jtd2LKUteMTYGMZtDT1bdcmZD50JTcZHrh7FLtLi+Jh
         9W71UqFHJK5QatoQnRp2LGcepenSG3ImpaY+EsgjyrtSzgrevScv+L71NJl8hWvUx+HI
         KiAg==
X-Gm-Message-State: AJIora/eY/IcJrZrZBwo+1vceGKYVVsicwMhKmDadSFE8kdTMqOhuzlf
        obz2gBYGLHeGYeKwqhbQCQ==
X-Google-Smtp-Source: AGRyM1uBFllvA3IpIP9m7SNsDhstzXJcAbj0YrXBXQgST5iYyNYFUMf1oc8Q117GBj3QL86xtWLJEw==
X-Received: by 2002:a05:6e02:12e6:b0:2dc:cc76:aca9 with SMTP id l6-20020a056e0212e600b002dccc76aca9mr14058114iln.14.1658423663787;
        Thu, 21 Jul 2022 10:14:23 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id x9-20020a056638010900b0033f53d7ffdesm980864jao.161.2022.07.21.10.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 10:14:23 -0700 (PDT)
Received: (nullmailer pid 1583447 invoked by uid 1000);
        Thu, 21 Jul 2022 17:14:21 -0000
Date:   Thu, 21 Jul 2022 11:14:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Vincent Knecht <vincent.knecht@mailoo.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        phone-devel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, hns@goldelico.com,
        Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 01/12] dt-bindings: leds: Convert is31fl319x to
 dtschema
Message-ID: <20220721171421.GA1583139-robh@kernel.org>
References: <20220712100841.1538395-1-vincent.knecht@mailoo.org>
 <20220712100841.1538395-2-vincent.knecht@mailoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712100841.1538395-2-vincent.knecht@mailoo.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jul 2022 12:08:27 +0200, Vincent Knecht wrote:
> Convert leds-is31fl319x.txt to dtschema.
> Set license to the one recommended by DT project
> and set myself as maintainer.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
> ---
> v3:
> - changed license back to (GPL-2.0-only OR BSD-2-Clause) and
>   maintainer to myself, with Nikolaus agreement
> ---
>  .../bindings/leds/issi,is31fl319x.yaml        | 113 ++++++++++++++++++
>  .../bindings/leds/leds-is31fl319x.txt         |  61 ----------
>  2 files changed, 113 insertions(+), 61 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/leds/issi,is31fl319x.yaml
>  delete mode 100644 Documentation/devicetree/bindings/leds/leds-is31fl319x.txt
> 

Applied, thanks!
