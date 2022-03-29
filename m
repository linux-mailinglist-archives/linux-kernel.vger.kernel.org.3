Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E534EB68A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 01:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239715AbiC2XOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 19:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235262AbiC2XOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 19:14:08 -0400
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2069219B078;
        Tue, 29 Mar 2022 16:12:24 -0700 (PDT)
Received: by mail-ot1-f41.google.com with SMTP id a17-20020a9d3e11000000b005cb483c500dso13784172otd.6;
        Tue, 29 Mar 2022 16:12:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=19pOzULxVDfXXsKExnM0qOYmlT2C8TqThE9IQo+YRrQ=;
        b=oKaHVTwnWh2e7vs1GTvXInKaJ5Vk63/HVFNE4xKoyjXpCiY/GY6zLSXZQkSS9JFg7j
         TjC4kR8TA59z7hB1QW1ZmIljlsWzAcV7hsE2r+R5LUb7QRUF8UVrbCQsKa3HkXQOMFyz
         ZtOyqXXQJpeV8lbWPf1063WTgjfmArJ9KVnnOkozdYG8kjejvkjM65dvnTmO4G5cKXP3
         QoBxKBa15yEohMY0k0wiN3BQVq5g5XB16js5n0D5knBcbmdrOSia34uawO2ltMgrmqLe
         zEKqH4MJNGFXS+ZFk0VTzg6bsH+fn8+c3lGvmvLYZFkwc+9DQEj4ZPkirxgUZzQfCoAo
         2/Kw==
X-Gm-Message-State: AOAM5339pkXXHA12lmHY8eerHbukpB3ji8Z3kwW5+kSsub4kiRO50wNN
        qA4V/QaV9xEU1ovvN9ruiQ0lN1iNyQ==
X-Google-Smtp-Source: ABdhPJydkK7GxNHz+fTQpfZtCPQLNq4GqZsLPEkqhOP3kWjNeq8sHsTwLBDOrI0EsQ3z7BiRKstoqw==
X-Received: by 2002:a9d:5a07:0:b0:5cd:afdb:b0da with SMTP id v7-20020a9d5a07000000b005cdafdbb0damr2137782oth.188.1648595543463;
        Tue, 29 Mar 2022 16:12:23 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o18-20020a9d7652000000b005cbf6f5d7c5sm9678797otl.21.2022.03.29.16.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 16:12:22 -0700 (PDT)
Received: (nullmailer pid 1529180 invoked by uid 1000);
        Tue, 29 Mar 2022 23:12:21 -0000
Date:   Tue, 29 Mar 2022 18:12:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     Alistair Francis <alistair@alistair23.me>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        alistair23@gmail.com, dmitry.torokhov@gmail.com,
        robh+dt@kernel.org, andreas@kemnade.info,
        linux-kernel@vger.kernel.org, linus.walleij@linaro.org,
        linux-input@vger.kernel.org, rydberg@bitmath.org
Subject: Re: [PATCH v7 2/4] dt-bindings: input: Add Cypress TT2100
 touchscreen controller
Message-ID: <YkOSVeLoZfzSAG0I@robh.at.kernel.org>
References: <20220323120021.361137-1-alistair@alistair23.me>
 <20220323120021.361137-3-alistair@alistair23.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220323120021.361137-3-alistair@alistair23.me>
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

On Wed, 23 Mar 2022 22:00:19 +1000, Alistair Francis wrote:
> Add the Cypress TrueTouch Generation 5 touchscreen device tree bindings
> documentation. It can use I2C or SPI bus.
> This touchscreen can handle some defined zone that are designed and
> sent as button. To be able to customize the keycode sent, the
> "linux,code" property in a "button" sub-node can be used.
> 
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../input/touchscreen/cypress,tt21000.yaml    | 101 ++++++++++++++++++
>  1 file changed, 101 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
