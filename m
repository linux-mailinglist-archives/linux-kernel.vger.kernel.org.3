Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656464AE71D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 03:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236772AbiBICmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 21:42:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244683AbiBICO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 21:14:26 -0500
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6380FC06157B;
        Tue,  8 Feb 2022 18:14:26 -0800 (PST)
Received: by mail-oi1-f181.google.com with SMTP id s185so1097237oie.3;
        Tue, 08 Feb 2022 18:14:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q9K+kQmTViwQgMbuDZS5abBLQ8Er416I8TDPy6qw6Ao=;
        b=4uj09Sm9CCapcsh0TKiEthOFekOthxSQJrTTD9eroafKod6Hhn4cGWABUhl3R7Qd8r
         HjvWuMoKgDG2+SqLQ1R3IZCVrB0jKXMfLshsSn8QCgPrzwUwmEbo96wixqZtfiiq5LkB
         N6gAXQr1zpiSSW4rRhJPF6LTbKafG20MY0/vtemOpcNAfmVW+2n/dNMhOqeXqZBdiL9d
         8Mh6vDDdWYgQLS+eX3eYGNdGyl3TelIojtT767VtCPqlSRGZfXk5wxqBftwSfm49mv3Z
         Yz9fwP6NSEeH4EaVcokDscAxqvCqmucApjN0TdmfkworA+oNw2BbALTyGA/B0pCZvPHk
         TjWw==
X-Gm-Message-State: AOAM533Rf6zgEDB5BaZmP7Jp/4StTy9btRWozlbR6aeyLceYv9SQAsUB
        ik3iZNqQ8NsDUSa9C7S8Ya5AoAvD3Q==
X-Google-Smtp-Source: ABdhPJxe1OyJ60lzKK2sQjMngRVns7MBxnq/b3uDsQqkBrnsw58M77JEG/LKeuDEY76EenPBNv3CFg==
X-Received: by 2002:a05:6808:208d:: with SMTP id s13mr380725oiw.282.1644372865690;
        Tue, 08 Feb 2022 18:14:25 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id r186sm6228746oie.23.2022.02.08.18.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 18:14:25 -0800 (PST)
Received: (nullmailer pid 3468203 invoked by uid 1000);
        Wed, 09 Feb 2022 02:14:24 -0000
Date:   Tue, 8 Feb 2022 20:14:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>
Subject: Re: [PATCH 14/15] dt-bindings: arm: qcom: Document sdm632 and
 fairphone,fp3 board
Message-ID: <YgMjgJmVSEA3htyO@robh.at.kernel.org>
References: <20220112194118.178026-1-luca@z3ntu.xyz>
 <20220112194118.178026-15-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220112194118.178026-15-luca@z3ntu.xyz>
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

On Wed, 12 Jan 2022 20:41:03 +0100, Luca Weiss wrote:
> Add binding documentation for Fairphone 3 smartphone which is based on
> Snapdragon 632 (sm632).
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
