Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C403D4F1DA1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383041AbiDDVck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379693AbiDDRwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 13:52:16 -0400
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC4D27142;
        Mon,  4 Apr 2022 10:50:20 -0700 (PDT)
Received: by mail-oo1-f46.google.com with SMTP id h3-20020a4ae8c3000000b00324b9ae6ff2so1871797ooe.10;
        Mon, 04 Apr 2022 10:50:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=00wJuMFju4M2Mlh4UvXveyZxAyuzzgzHODF3ZJjSU0M=;
        b=VBGLGRvuDSI+VaFWq6KK7Qh5rzCUulijWFtzGQcGtbXMnabJefproWPcqOskBKRFJ4
         G6BSuujiraHt+LILqMEBVfJQ1EydCGGHAV3l7mtmBL/otpQMTbkwknW/6KrSSQeqgLhk
         maGTsdxoEDmL1TmjqJjcaSwaVwcZvY3kqt9BWmxa/mNoaw0jjdNz9plW4wMHL/VkcusT
         5V13zQKgf9ycQoqwsVbT5Ykk1xUypiXpz+v4rj56zDAyVMTau79rYLLeFgEsxt065/4e
         4MRanuWNEHjSnMAk9JIKgEETwQxXbR9UO7J/qudEm1tCmV5mTOmaX0nHrFDEY6HnLLGB
         5D5A==
X-Gm-Message-State: AOAM532YGK4cFiSQJqEJYt/E9J0bVKwWEKDq6dKZbAHPjMr9ljtFA53h
        h6LkZ2kKYp7lfoTQye56j6B8jdZ80A==
X-Google-Smtp-Source: ABdhPJzZgD4gLpmDxNxhb+yy7bA8P4mluzAI2ZE7CKPXMCutUZS5iH9XYSp9kYhIVljdV2j16Pja6A==
X-Received: by 2002:a4a:c449:0:b0:320:f8ac:8f88 with SMTP id h9-20020a4ac449000000b00320f8ac8f88mr281201ooq.94.1649094619516;
        Mon, 04 Apr 2022 10:50:19 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r81-20020acaf354000000b002ecf46e8016sm4407510oih.51.2022.04.04.10.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 10:50:18 -0700 (PDT)
Received: (nullmailer pid 1612125 invoked by uid 1000);
        Mon, 04 Apr 2022 17:50:18 -0000
Date:   Mon, 4 Apr 2022 12:50:18 -0500
From:   Rob Herring <robh@kernel.org>
To:     Xin Ji <xji@analogixsemi.com>
Cc:     devicetree@vger.kernel.org, qwen@analogixsemi.com,
        Rob Herring <robh+dt@kernel.org>, robert.foss@linaro.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, bliang@analogixsemi.com
Subject: Re: [PATCH 2/4] dt-bindings: media: video-interfaces: Add new
 bus-type
Message-ID: <Yksv2voEepz6WPpO@robh.at.kernel.org>
References: <20220328120956.1848795-1-xji@analogixsemi.com>
 <20220328120956.1848795-2-xji@analogixsemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220328120956.1848795-2-xji@analogixsemi.com>
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

On Mon, 28 Mar 2022 20:09:53 +0800, Xin Ji wrote:
> No properly bus-type for DPI video bus, add bus-type 7 for it.
> 
> Signed-off-by: Xin Ji <xji@analogixsemi.com>
> ---
>  Documentation/devicetree/bindings/media/video-interfaces.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
