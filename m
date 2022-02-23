Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912984C17DF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 16:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242517AbiBWP63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 10:58:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiBWP61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 10:58:27 -0500
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52AB8B2D77;
        Wed, 23 Feb 2022 07:58:00 -0800 (PST)
Received: by mail-oo1-f54.google.com with SMTP id 189-20020a4a03c6000000b003179d7b30d8so22888636ooi.2;
        Wed, 23 Feb 2022 07:58:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MXdhDqHwo9RSoGDS4F+6YXTay9qxmpFa8aYups9hS1A=;
        b=CLgtxzDivu4bC/JfXabDfvlqvmxET2hwG14oJ0LOIFKJoa9lBEcYyZ7VXsbuUG4B3Q
         A8Du8iQhZu1cI1Fu/1EsmeqRFl2bLTqI2jWNaYjq3cQ/UxwAsepktyULg4Szu+RkW8dd
         dGKMNDPiE92B1ymiUMgn9/89IIKyxMAuvIXiSRGYIiDB/f7uRrDexHKeJ6uQA0wVUHM0
         +V+sNiiVZRUI9DJPfKSNvToEgmLZXHrbJB38dfrmqpZt3KNSJMC3bu8tB6aLCMvpGufv
         iNV86oxOkCGpkPEK+7a0qHA/CYcrjLeyzcSRvg6JplHWamT8PoGMIDGGtVhNq+GlFwq2
         LxKA==
X-Gm-Message-State: AOAM532VF0TRraIFQ4cLNumcQH0LXlALz7SbCFSyFnjAqlx/hn9PLNEl
        9EcBncMXsj0M/+Y0VM55MyNE14s/fg==
X-Google-Smtp-Source: ABdhPJxzUe+lJIur2gdc+j9OgKQIEfPj1dm2wxDDipkMIvMR9csXumgpHJcUUi9gfQzfXkkbK1XtsA==
X-Received: by 2002:a05:6870:8883:b0:d3:6ffa:cf20 with SMTP id m3-20020a056870888300b000d36ffacf20mr4027959oam.104.1645631879697;
        Wed, 23 Feb 2022 07:57:59 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id q10sm5860otl.1.2022.02.23.07.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 07:57:58 -0800 (PST)
Received: (nullmailer pid 1005248 invoked by uid 1000);
        Wed, 23 Feb 2022 15:57:58 -0000
Date:   Wed, 23 Feb 2022 09:57:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Markuss Broks <markuss.broks@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Henrik Rydberg <rydberg@bitmath.org>,
        ~postmarketos/upstreaming@lists.sr.ht, linux-input@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        phone-devel@vger.kernel.org, devicetree@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH v6 1/2] dt-bindings: input/touchscreen: bindings for
 Imagis
Message-ID: <YhZZhUVldKkSaKsb@robh.at.kernel.org>
References: <20220222203414.8656-1-markuss.broks@gmail.com>
 <20220222203414.8656-2-markuss.broks@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222203414.8656-2-markuss.broks@gmail.com>
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

On Tue, 22 Feb 2022 22:34:10 +0200, Markuss Broks wrote:
> This patch adds device-tree bindings for the Imagis
> IST3038C touch screen IC.
> 
> Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../input/touchscreen/imagis,ist3038c.yaml    | 74 +++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
>  2 files changed, 76 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml
> 

Acked-by: Rob Herring <robh@kernel.org>
