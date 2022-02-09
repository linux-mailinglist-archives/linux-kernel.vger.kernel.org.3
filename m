Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD29E4AFFB2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 23:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234789AbiBIV7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 16:59:51 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:56324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234896AbiBIV7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 16:59:38 -0500
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD559E01CC92;
        Wed,  9 Feb 2022 13:59:26 -0800 (PST)
Received: by mail-oi1-f175.google.com with SMTP id s185so4008731oie.3;
        Wed, 09 Feb 2022 13:59:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MGdX2WFmEhVLFBlT/gqp0drYFDMwrpl5YkLFjEkVgTE=;
        b=TucUkQmhSnQft/zgSRJbaPJKRh9sp+moZhG5IzRbNrW4k3W2mKjBAPqDhBcSaana0u
         KdZNTsZzd68b0NcTTjoP9Pyc9I7OH3rDsFO6pPBk9ZENpzWzCcFauFb0BXu4KlKZ7/aG
         ls4KMsDNtqj9BejnSiWei1tL4O90c+V8vTyoxQduuhN6uGOQWyI7aOnC9FSkScBvr2CD
         nlhFprUM+PCmGvK2DCE+DwD+JkXZvJC9+YxMkXFCl8yayTBr6/cLN41Ys3cYrW4AHqtN
         pAfPxksqR3GFv8Cqgmjg8L9n9fBqxdpoO90eKRYOv/6QA5MPU0gpckdc+esM//xtOjJe
         1Qnw==
X-Gm-Message-State: AOAM530O7OV0GJoyF4CDgLWT1Uy849mFsWY02cY79TsOjIIlWcBV5CDj
        OBfHTU+ZSofHpVvaQxCABw==
X-Google-Smtp-Source: ABdhPJxvdK3GGnFV/0tcZhFZmPy6zrwxpqzrNnfmTTB13OBy2gyqsnA1mhv1nnPEKLXZrBSfWpkjag==
X-Received: by 2002:a05:6808:a94:: with SMTP id q20mr2429747oij.165.1644443966164;
        Wed, 09 Feb 2022 13:59:26 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id ep17sm7623919oab.21.2022.02.09.13.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 13:59:25 -0800 (PST)
Received: (nullmailer pid 1002126 invoked by uid 1000);
        Wed, 09 Feb 2022 21:59:24 -0000
Date:   Wed, 9 Feb 2022 15:59:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Denis Ciocca <denis.ciocca@st.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: vendor-prefixes: Add silan vendor
 prefix
Message-ID: <YgQ5PLDR5ZuZBAl0@robh.at.kernel.org>
References: <20220202235049.8051-1-samuel@sholland.org>
 <20220202235049.8051-2-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202235049.8051-2-samuel@sholland.org>
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

On Wed, 02 Feb 2022 17:50:46 -0600, Samuel Holland wrote:
> Hangzhou Silan Microelectronics Co., Ltd. (http://www.silan.com.cn/) is
> a manufacturer of ICs, including MEMS sensors.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
> (no changes since v1)
> 
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
