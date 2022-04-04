Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1F14F1DAC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbiDDVk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379828AbiDDSLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 14:11:45 -0400
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB7C3A5F9;
        Mon,  4 Apr 2022 11:09:49 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id v75so10919785oie.1;
        Mon, 04 Apr 2022 11:09:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GrWsWifEwSB/Di8qodK8eTaSlwfNnYpeHBLpuV2qFD0=;
        b=NgTZFNa36c/f2izIc/Ttcn8H6IiuDy+HaVk9/aW2nOavOgmmExTSQ3BoIei942S20r
         ewFNFQg2v8Kxai7nyaKtwVyqIvffa/RtC3ceRjVBjv8NymxnB3qTRNf0mUEzW8/dHWiq
         zfiKaUs7rcaKMA4MMSBdmu6wwFVyK/WiOCRZw1QEkdgJGH0jQhb6Pyj2Yn2LhfAdfluz
         ZO2m5NXKlrLGkGBwdQY8b7DVfdkDIOm4OeyEzqIOIwBbcmprBKB4jj49AXeQsf1hEGi/
         Ha7wZMae0DM2cwbnhMCvMrG0fDWnvX87ypWxX/0jpWOJwdHYOs2eRapCqVs6dquayx8Z
         17oQ==
X-Gm-Message-State: AOAM532xAGEFoVKi5d9PT8MY8fCFh5qKQW0qY+ahiOY096VonItqs46P
        V5+AZKNz2WOdMuAE0Jnn8Q==
X-Google-Smtp-Source: ABdhPJzJ8JBWLf9zowjpziQW3ouFz5h0r+qSqLu4rRuyYtgrnrt/DwlRiLul6qKVYHcAloy2KKl+AQ==
X-Received: by 2002:a05:6808:20d:b0:2ef:88b6:28c3 with SMTP id l13-20020a056808020d00b002ef88b628c3mr180565oie.149.1649095788816;
        Mon, 04 Apr 2022 11:09:48 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a17-20020a4ae931000000b0032933be7230sm3229704ooe.4.2022.04.04.11.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 11:09:48 -0700 (PDT)
Received: (nullmailer pid 1645093 invoked by uid 1000);
        Mon, 04 Apr 2022 18:09:47 -0000
Date:   Mon, 4 Apr 2022 13:09:47 -0500
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-renesas-soc@vger.kernel.org,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: memory: renesas,rpc-if: Document R-Car
 H3/M3/E3 support
Message-ID: <Yks0a3s5KN5GPl4A@robh.at.kernel.org>
References: <3784b6cb76a008fb56d6cb4ba228d78c77e710fa.1648546583.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3784b6cb76a008fb56d6cb4ba228d78c77e710fa.1648546583.git.geert+renesas@glider.be>
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

On Tue, 29 Mar 2022 11:38:03 +0200, Geert Uytterhoeven wrote:
> Document support for the SPI Multi I/O Bus Controller (RPC-IF) in the
> R-Car H3, M3-W, M3-W+, M3-N, and E3 SoCs.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  .../bindings/memory-controllers/renesas,rpc-if.yaml          | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
