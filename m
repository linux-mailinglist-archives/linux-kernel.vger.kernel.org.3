Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E3C578C99
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 23:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234181AbiGRVSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 17:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiGRVSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 17:18:16 -0400
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C2428705;
        Mon, 18 Jul 2022 14:18:15 -0700 (PDT)
Received: by mail-io1-f50.google.com with SMTP id n7so10355998ioo.7;
        Mon, 18 Jul 2022 14:18:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=CA6cnIkj6RDBPi8wVndYenOw7BfsLn6HBSCFjK/hRkk=;
        b=vY4E7Q0/yf8wqlPZgngrNwlmKxoXFYP+p/0wY40QylcYgo05vvW1jblY+8Y/rrD60W
         mvB+oq3IHROxgCx9/LMzKL0ZC6HgxHTR5dQBsK4iOpDRp4oTswfEopV1nSPGHILyDLsB
         o1msV9CvWwBPmxxITtLFY7K8KxdC3V5OPrNsFtKOYoiaJr1D54cmvBPCRml/2kfoGzn4
         UcwLqzvx0kvUM/FyRhmuFkHgGQUW4HqSXRoEIAw+WsaITdzLMsZLcvebdzvKlEhQtXcq
         4DpwP3spj4IlX1bvoFKwmeIVFXaLYvQNRezKfjWEh3X73CP+to6RSfCh5JbcEfsC+lkP
         s4Ng==
X-Gm-Message-State: AJIora8iFb7qL0NrVzKn57cr5wVF0oLrajW3ENOSrcTp2KQXihLFYLFJ
        BJxLQ7Pval5Vfs0VR0IVLA==
X-Google-Smtp-Source: AGRyM1tMwB1OR6cOOec4zTljTVtyHRR6P+TR082tR8av+kzniYWrINr3/JwNrtZTkmpwLMaUd9NU5w==
X-Received: by 2002:a02:a890:0:b0:33f:22b8:cb0b with SMTP id l16-20020a02a890000000b0033f22b8cb0bmr16115281jam.136.1658179093108;
        Mon, 18 Jul 2022 14:18:13 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id j195-20020a0263cc000000b003417ba4f66asm840832jac.41.2022.07.18.14.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 14:18:12 -0700 (PDT)
Received: (nullmailer pid 3574265 invoked by uid 1000);
        Mon, 18 Jul 2022 21:18:10 -0000
Date:   Mon, 18 Jul 2022 15:18:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        devicetree@vger.kernel.org,
        Gregory Clement <gregory.clement@bootlin.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-gpio@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] doc: gpio-mvebu: Add information about Armada 38x
 and Armada 39x
Message-ID: <20220718211810.GA3574206-robh@kernel.org>
References: <20220714115515.5748-1-pali@kernel.org>
 <20220714183328.4137-1-pali@kernel.org>
 <20220714183328.4137-2-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220714183328.4137-2-pali@kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jul 2022 20:33:26 +0200, Pali Rohár wrote:
> Armada 38x and Armada 39x should use compatible string "marvel,armadaxp-gpio".
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> ---
>  Documentation/devicetree/bindings/gpio/gpio-mvebu.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
