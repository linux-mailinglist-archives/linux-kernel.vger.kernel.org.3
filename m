Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9440453EC21
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239229AbiFFNsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 09:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239208AbiFFNsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 09:48:31 -0400
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BC49A985;
        Mon,  6 Jun 2022 06:48:27 -0700 (PDT)
Received: by mail-il1-f181.google.com with SMTP id v7so11961216ilo.3;
        Mon, 06 Jun 2022 06:48:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Iq+/ZT5S/tsKY65k+c5zzqLlMmHdbOtpYrK6tQD4cqY=;
        b=0zL69b45rZX+vti6TKAhUTuVAXolTaDVadZv3AygbgK75Iwf2HvWmPV4oa88S+yJDi
         uREPJe51ALGVCoXQ9D+EaLN8GPGLRMptCyAyVYTFsMGPGQ1pnSLSe3vaHkvKnwRuT55A
         swxhSbjT4a+9YHKrF28nIaaupjbMwfzCjrGGdwPhRj39NEvTbgTTqMaouCU1d5Y3Cn+W
         548W5PBtE/5tupQ8GxbfTjde1KPkD+QlTtsLY5tXZ7pO6ikoJXT3OUViUpPwVZc6Afrr
         Tl7GxeahBcEJUGQghjsP7/TZah1tJqZQH271sfFcRSkXnhNMwOUUu0T3KTKO9l0cLa1X
         uiTA==
X-Gm-Message-State: AOAM530SmjNBbwU5Jgg0m4QurEfekARzbCbcaDzuVYxGVDHDg50PRGVy
        yCmETxiOrZpNxQxXezBKSQ==
X-Google-Smtp-Source: ABdhPJwbi6EJiI2PaM91wEcFQReWOmrXQCRfzQHoHXpccKkWDSHoKnOoq6i68X1AyLTQWbbX3840mg==
X-Received: by 2002:a05:6e02:15ca:b0:2bf:ad58:4a6d with SMTP id q10-20020a056e0215ca00b002bfad584a6dmr14825916ilu.13.1654523306793;
        Mon, 06 Jun 2022 06:48:26 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id y38-20020a029529000000b0032e583132e4sm5675598jah.123.2022.06.06.06.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 06:48:26 -0700 (PDT)
Received: (nullmailer pid 632986 invoked by uid 1000);
        Mon, 06 Jun 2022 13:48:24 -0000
Date:   Mon, 6 Jun 2022 08:48:24 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     broonie@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        thierry.reding@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        perex@perex.cz, tiwai@suse.com, jonathanh@nvidia.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/6] ASoC: tegra: Add binding doc for OPE module
Message-ID: <20220606134824.GB564610-robh@kernel.org>
References: <1654238172-16293-1-git-send-email-spujar@nvidia.com>
 <1654238172-16293-2-git-send-email-spujar@nvidia.com>
 <20220603203003.GA852734-robh@kernel.org>
 <b70e024b-4f80-16b9-4bbe-ed8a24a384df@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b70e024b-4f80-16b9-4bbe-ed8a24a384df@nvidia.com>
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

On Mon, Jun 06, 2022 at 01:47:48PM +0530, Sameer Pujar wrote:
> 
> On 04-06-2022 02:00, Rob Herring wrote:
> > Doesn't apply for me. I guess there is some undocumented dependency
> > here? Resend after the merge window if that solves it.
> 
> These were getting applied fine on linux-next.

linux-next is not a base maintainers can apply to. Convenient instead of 
having to get a specific tree, but you still need to say what the base 
is (what tree it should be applied to).

> Merge window seems to have closed now and v5.19-rc1 release is out. I can
> apply these cleanly on v5.19-rc1. Please let me know if re-send is needed
> now or I need to wait for some more time? Thanks.

Yes, or the automated checks don't run.

Rob
