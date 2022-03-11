Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4C24D649C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 16:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349201AbiCKPbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 10:31:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235632AbiCKPbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 10:31:38 -0500
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3361AD3B7;
        Fri, 11 Mar 2022 07:30:35 -0800 (PST)
Received: by mail-oo1-f42.google.com with SMTP id n5-20020a4a9545000000b0031d45a442feso10901097ooi.3;
        Fri, 11 Mar 2022 07:30:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q8XI+4Iss5k+7LUf9y/wUHl96+m30olu3rf2rc/5Tp0=;
        b=podi3LVIMtmzknx4F2vtxHX1HJ6lh3zZCcZ4zUOqfhNDzyfgKm+TuPiurj1r/NL/ut
         Mtoy2TwgWnslONxiN9Obqx0b7HjlFyf8as4Pz4kt7+j0ra3Da0382j1beorPBdrzkZYe
         LdCAX+ZsZNDm6dWEXo9ghxnpP/86ouUyWYCG9ISWXbWOhCYXOkdUV06V0rWW0koauMjd
         q9Jb9+iv/icLfwWrqVDFvgFR7xW4DCAGe5G+zZ8pHH9M7qLlXGjfvjyTIQNN0utCnxKq
         rSE+PC2NH4ZzLA51H/FyrE4ML+hU8nt7jlhFAynrquauLkQEossoODlDY8PHDxIoU7p/
         RAjg==
X-Gm-Message-State: AOAM533WtPwuHFT7GGW+mA1JnqUDvNJ9dPI8QX98Ix3Ch8QZzjtHXyBQ
        8zSXD1v+jAbNs57jCCutIA==
X-Google-Smtp-Source: ABdhPJwT4Tr9y3eJPSVY9aRVc5cu5v4TEk7bu2x1P2u937ujZQSEO/818pFnvJFxGpbUjNUyXCZm4w==
X-Received: by 2002:a05:6870:3283:b0:da:609c:f385 with SMTP id q3-20020a056870328300b000da609cf385mr12031170oac.261.1647012634668;
        Fri, 11 Mar 2022 07:30:34 -0800 (PST)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 69-20020a9d0bcb000000b005af83322c6asm3647239oth.12.2022.03.11.07.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 07:30:33 -0800 (PST)
Received: (nullmailer pid 3834454 invoked by uid 1000);
        Fri, 11 Mar 2022 15:30:32 -0000
Date:   Fri, 11 Mar 2022 09:30:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: kbuild: Pass DT_SCHEMA_FILES to
 dt-validate
Message-ID: <YitrGFz09dKVduRi@robh.at.kernel.org>
References: <20220310160513.1708182-1-robh@kernel.org>
 <20220310160513.1708182-2-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310160513.1708182-2-robh@kernel.org>
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

On Thu, 10 Mar 2022 10:05:12 -0600, Rob Herring wrote:
> In preparation for supporting validation of DTB files, the full
> processed schema will always be needed in order to extract type
> information from it. Therefore, the processed schema containing only
> what DT_SCHEMA_FILES specifies won't work. Instead, dt-validate has
> gained an option, -l or --limit, to specify which schema(s) to use for
> validation.
> 
> As the command line option is new, we the minimum dtschema version must be
> updated.
> 
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v2:
>  - Change DT_TMP_SCHEMA from '?=' to ':='
> ---
>  Documentation/devicetree/bindings/Makefile | 28 +++-------------------
>  scripts/Makefile.lib                       |  5 ++--
>  2 files changed, 5 insertions(+), 28 deletions(-)
> 

Applied, thanks!
