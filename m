Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC16D4D545A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 23:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344288AbiCJWNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 17:13:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343995AbiCJWNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 17:13:38 -0500
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5962DFB;
        Thu, 10 Mar 2022 14:12:33 -0800 (PST)
Received: by mail-oi1-f178.google.com with SMTP id o83so2441oif.0;
        Thu, 10 Mar 2022 14:12:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=omjoz0M9biHPr5EKrbgbc5QfautyWsC0HyZJaIjRDEg=;
        b=X7GYqySPrMybM2edaDOQg6w5BlZ4iKFQyUoYrAIU7nNp3ipMAYq/4b6Ot1e6yuwZtd
         VtAxqOyUY0Wm4aAD/KXfcCDpovUcnuHT7trlywzq3VgJqJAfGn9RhwQJPxg4GAh74Yby
         NvRxRqvoQ9e0F1zy8p2najFsNLLlrHvALF1OQbPAHyjOXW8jkWlEwq3LjtaOlu9lnk5Z
         0a6ptiOz5wifrk3+btkK6aHYIjJUwTMdBoP3rFS7IvDN546n5TYOJaZ8OaIlHfnB1l+Z
         FUngKREGoBFnZWZ1bJKj9t9FRgDAklU/1bnfAaxHTrNuhUS3J00Hx9uE9BSTj50HsY7I
         StVQ==
X-Gm-Message-State: AOAM533KrarHS3fgEtxRslyDTPHwXJgbzQEbVe/hVb2xrnj07P8D/uFD
        gcuPUMJ8//kh+xE0uBLcIw==
X-Google-Smtp-Source: ABdhPJxHna6A8giuUalT7X77knNuIyLF0eFu5RYM8FUTp80V2T9F0GnnEXgbqAyoeBJg75biyF6+tw==
X-Received: by 2002:a05:6808:1528:b0:2da:7f1d:f847 with SMTP id u40-20020a056808152800b002da7f1df847mr1796358oiw.85.1646950353167;
        Thu, 10 Mar 2022 14:12:33 -0800 (PST)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id c14-20020a056870b28e00b000d7d5962242sm2821551oao.35.2022.03.10.14.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 14:12:32 -0800 (PST)
Received: (nullmailer pid 2175473 invoked by uid 1000);
        Thu, 10 Mar 2022 22:12:31 -0000
Date:   Thu, 10 Mar 2022 16:12:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Trevor Wu <trevor.wu@mediatek.com>
Cc:     broonie@kernel.org, tiwai@suse.com, matthias.bgg@gmail.com,
        alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, aaronyu@google.com,
        yc.hung@mediatek.com
Subject: Re: [PATCH 2/5] dt-bindings: mediatek: mt8195: add reset property
Message-ID: <Yip3z3XoarN8TeMn@robh.at.kernel.org>
References: <20220308072435.22460-1-trevor.wu@mediatek.com>
 <20220308072435.22460-3-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308072435.22460-3-trevor.wu@mediatek.com>
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

On Tue, Mar 08, 2022 at 03:24:32PM +0800, Trevor Wu wrote:
> Add required properties "resets" and "reset_names", which are used to
> specify audiosys hw reset for mt8195 afe driver.

The subject needs to be more specific and indicate this applies to ASoC 
and mt8195-afe-pcm. Try to write subjects that could only ever appear 
once as you can never make the same change twice.

Rob
