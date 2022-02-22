Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096D34C036E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 21:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235609AbiBVU4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 15:56:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbiBVU4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 15:56:52 -0500
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC13A9E3B;
        Tue, 22 Feb 2022 12:56:23 -0800 (PST)
Received: by mail-ot1-f47.google.com with SMTP id p12-20020a05683019cc00b005af1442c9e9so6670757otp.13;
        Tue, 22 Feb 2022 12:56:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=bGeKkIIkOUwzz2iAuilz0oqe7PmBCMUY+uBWerfv8+Y=;
        b=XWjgKWLkTg1D+mVT4anVaBOXWZUT7YHyB0vsgZG3pvbnZW6/u01RCK7tDbcioc77Gn
         QFfIoWar4V5JNXadKPC20bbpRvgRYQbWrjFld96Mq/VM1qHeUyw+VtAE5oIrPEMi1e8l
         F40i1MUHvGaG3i2UrPMpIwT0iHd8nBIHRZ+B4snCM9KXUUgBquKBNWxH20DjQjRvSLgg
         WGySCiUiDcg1KLFJt3iWoI8tcWzD4xyS+i1HcTSKugzWc4DqxhjuiI94VYRqdI8iXtGx
         tQvj+sIP8+c4bkMyE+ADabx63uoOVAx0bP7eqODfsAkocFmqOSmPpkrzz1MM0FGsLw+R
         HtAQ==
X-Gm-Message-State: AOAM533pmUlkp7F75V9nx6HWjNCW2TeUkn3E0mJrg4Wwxqb2+YF4skdL
        5zQp3etKbQ9EqonW8IH5pw==
X-Google-Smtp-Source: ABdhPJxQh+yP7jsV56J8XzSvanqJpge0VAe+oVDO95jnT5YCP9cCLyOSFmVMWHxBgS25jkCApmtALw==
X-Received: by 2002:a05:6830:563:b0:5ad:3ecd:ed67 with SMTP id f3-20020a056830056300b005ad3ecded67mr6729100otc.143.1645563382397;
        Tue, 22 Feb 2022 12:56:22 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id v41sm2865514ott.74.2022.02.22.12.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 12:56:21 -0800 (PST)
Received: (nullmailer pid 3571045 invoked by uid 1000);
        Tue, 22 Feb 2022 20:56:20 -0000
Date:   Tue, 22 Feb 2022 14:56:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?Andr=E9?= Apitzsch <git@apitzsch.eu>
Cc:     devicetree@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>, linux-leds@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3 2/3] dt-bindings: leds: sgm3140: Document ocp8110
 compatible
Message-ID: <YhVN9MoUyme53OeK@robh.at.kernel.org>
References: <20211117091405.7412-1-git@apitzsch.eu>
 <20220212180942.8241-2-git@apitzsch.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220212180942.8241-2-git@apitzsch.eu>
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

On Sat, 12 Feb 2022 19:09:41 +0100, André Apitzsch wrote:
> Add devicetree binding for Orient Chip OCP8110 charge pump used for
> camera flash LEDs.
> 
> Signed-off-by: André Apitzsch <git@apitzsch.eu>
> ---
> V2 -> V3: Add commit message, h/w info
> 
>  Documentation/devicetree/bindings/leds/leds-sgm3140.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
