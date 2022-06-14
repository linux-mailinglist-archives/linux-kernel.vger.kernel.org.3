Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D682454BCBC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 23:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353350AbiFNVYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 17:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352048AbiFNVYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 17:24:41 -0400
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EEEC50B23;
        Tue, 14 Jun 2022 14:24:39 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id e80so10785790iof.3;
        Tue, 14 Jun 2022 14:24:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hcfLxsZ5vDmOo7F9XYzWOLiXZ2KSXHI+er+DlTCXNp0=;
        b=2ve8cOFjV/9rS3UHJ82vGWCN+WcJw3uibFJw+sSXSW4X6fSZnOAh4NXq5XFStEy27o
         QyHr2RQmM1zH95kG0SmecjE24JtpR/HJXvv+M3uV89H29aHMFSO4H95SsvPE/PHncUpS
         JxaPtUyv+iLP9f1LFQjocM7U+YolVM1JvPlmDYmij2NWYG6jd65JLd8SpmW++5ViEGnA
         8oUijhWneknXStC4FsKSVje2O639wvHBzpBRsUIYKl3jq3gRRsOh4lpnRXi69ox4EvQG
         DyC1lg7n0vk2guSP3XCrqaL0xwI9ph23Vcynw4lnMZkso1yPtj23IVJRLT5TLpHaK5ir
         0SpQ==
X-Gm-Message-State: AOAM5335fOtrg/eaLMF0pYooW2yRXe7FmgsIImuUk/laraL0vuavpwqk
        N+hi1W5h4HGARH3xAnGKxg==
X-Google-Smtp-Source: ABdhPJwzlYtFO567HdT98/YrpCoro+8S3BL4fgiyD9vSsWKuKfkp49wOL2FmGthsr1n6cyr8M9rv7w==
X-Received: by 2002:a05:6602:3996:b0:669:d9e6:46a3 with SMTP id bw22-20020a056602399600b00669d9e646a3mr3649201iob.14.1655241878839;
        Tue, 14 Jun 2022 14:24:38 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id p7-20020a6bbf07000000b00669c94f2288sm5748165iof.38.2022.06.14.14.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 14:24:38 -0700 (PDT)
Received: (nullmailer pid 2660166 invoked by uid 1000);
        Tue, 14 Jun 2022 21:24:35 -0000
Date:   Tue, 14 Jun 2022 15:24:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Brad Larson <brad@pensando.io>
Cc:     blarson@amd.com, robh+dt@kernel.org, gsomlo@gmail.com,
        fancer.lancer@gmail.com, thomas.lendacky@amd.com,
        catalin.marinas@arm.com, yamada.masahiro@socionext.com,
        broonie@kernel.org, will@kernel.org, p.yadav@ti.com, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org,
        suravee.suthikulpanit@amd.com, piotrs@cadence.com,
        linux-kernel@vger.kernel.org, lee.jones@linaro.org,
        ulf.hansson@linaro.org, brijeshkumar.singh@amd.com,
        samuel@sholland.org, rdunlap@infradead.org, krzk@kernel.org,
        p.zabel@pengutronix.de, andy.shevchenko@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, gerg@linux-m68k.org,
        adrian.hunter@intel.com, alcooperx@gmail.com
Subject: Re: [PATCH v5 05/15] dt-bindings: mfd: syscon: Add
 amd,pensando-elba-syscon compatible
Message-ID: <20220614212435.GA2659987-robh@kernel.org>
References: <20220613195658.5607-1-brad@pensando.io>
 <20220613195658.5607-6-brad@pensando.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613195658.5607-6-brad@pensando.io>
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

On Mon, 13 Jun 2022 12:56:48 -0700, Brad Larson wrote:
> From: Brad Larson <blarson@amd.com>
> 
> Add the AMD Pensando Elba SoC system registers compatible.
> 
> Signed-off-by: Brad Larson <blarson@amd.com>
> ---
>  Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
