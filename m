Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5573650EBBE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 00:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236560AbiDYWYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 18:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343572AbiDYVgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 17:36:08 -0400
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E78388E;
        Mon, 25 Apr 2022 14:33:02 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-d39f741ba0so17460532fac.13;
        Mon, 25 Apr 2022 14:33:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QY5JW2v7HSbT1hDkjRPZNNU8p+12B6QymuL3kJfE5XI=;
        b=wD5n9GNdSp+2EsJ14khiDjUDlPZ6lQz8WkHbG1ynlzFPW1DfvJdUKyvYrCcx1aPOaz
         mJhWCBTo9NAZWUM9cuQMAafS7rsHkTFmrhpCVb6JX0W/AxW/ET3ad0i4Yc6cpMiz4xY4
         TSllvssyhqe2EaC9VgVfv5U424G9JZQ/OD6oy3BJ7cB4oJfpDix9B3C+JM7DjrkCZbcW
         LKakaXmjsFEuzLj/bPkl79unRzVqhPGappe3KwUi31crM1VIMt8emxfl1YyNzYwKUJlg
         2aQv+8WSGX6iSF1A4C+IRROOCB0FgZcXsG11dqnoeAWnzrb+G+KQi5oJwyAlYQ1nZZmY
         Hf+A==
X-Gm-Message-State: AOAM530yQQYqKGmYkQwdjXxHdeO/8hQXRDcrXmL2k4SwvYOdK+mbjrIf
        sImBW52OXP1TqdJmoOdYfw==
X-Google-Smtp-Source: ABdhPJxg7V0WshHnQdpqtbth9drF587QkF1vqISr18GX25hBvkaHQgNvi2RhjX5q0y2yuAuxpFb4FQ==
X-Received: by 2002:a05:6871:85:b0:d9:ac7a:7a5a with SMTP id u5-20020a056871008500b000d9ac7a7a5amr8021873oaa.9.1650922382146;
        Mon, 25 Apr 2022 14:33:02 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n66-20020acabd45000000b002ef6c6992e8sm4124993oif.42.2022.04.25.14.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 14:33:01 -0700 (PDT)
Received: (nullmailer pid 323996 invoked by uid 1000);
        Mon, 25 Apr 2022 21:33:00 -0000
Date:   Mon, 25 Apr 2022 16:33:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     Ashish Mhetre <amhetre@nvidia.com>
Cc:     jonathanh@nvidia.com, linux-kernel@vger.kernel.org,
        dmitry.osipenko@collabora.com, devicetree@vger.kernel.org,
        thierry.reding@gmail.com, robh+dt@kernel.org, digetx@gmail.com,
        Snikam@nvidia.com, krzysztof.kozlowski+dt@linaro.org,
        vdumpa@nvidia.com, krzysztof.kozlowski@linaro.org,
        linux-tegra@vger.kernel.org
Subject: Re: [Patch v8 3/4] dt-bindings: memory: tegra: Update validation for
 reg and reg-names
Message-ID: <YmcTjBxU7BfOX/SB@robh.at.kernel.org>
References: <20220425075036.30098-1-amhetre@nvidia.com>
 <20220425075036.30098-4-amhetre@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425075036.30098-4-amhetre@nvidia.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Apr 2022 13:20:35 +0530, Ashish Mhetre wrote:
> 

Reviewed-by: Rob Herring <robh@kernel.org>
