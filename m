Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A695153AD0C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 20:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbiFASvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 14:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiFASvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 14:51:21 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB92C1312A0;
        Wed,  1 Jun 2022 11:51:19 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id w130so3872476oig.0;
        Wed, 01 Jun 2022 11:51:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=O4z4N6i9xomFIEVTjR+Dhz8QGgdya/AgUb+aDwmZcCs=;
        b=MyFatKo3CeuR1NuZWvTj496NhmbpLlhFtApebhVT+O3Kp320O54nT0NgqMaWm5dTra
         8d7wWQiNBoA7npEHeCP7pcceSq3tzuYxohqLGvOEpCWddo2mYc7wxaN72nTmrLwYHRxq
         MLlYYMy3Ym+KYbIdlf8w8JSnKFiG0iplZzVy6HqjPY6jfaFjon2XZaXPKEjzd4q4qd3v
         QsBKfJ/MRbCHg6Zm84pTSzpHzmbZG2VtUEzUuBjeVqGWOKZV2qHbCF5pCqdi0zhzsZwS
         Dv5m5fDkxyTyHgGiqYcW/HaPxEUZD8ady45bVc4Ccq60SSw6NAAnsz8gEOFb3XkxEnT6
         n7mw==
X-Gm-Message-State: AOAM531xO+YZ8EQJodSu/ygHAsrYOyo1vbLBvy5O9J+cKSqEWlJY76r0
        M74Xl1cJZ/mc+XZh/7gvhA==
X-Google-Smtp-Source: ABdhPJwkkTU9SfqBYEX0qew2XvLefev6XgeAjr4IaPvilbM4y/HGxZWgiQlKzhPkscCe0k2lk5WE6w==
X-Received: by 2002:a05:6808:3084:b0:32b:14f8:1ab with SMTP id bl4-20020a056808308400b0032b14f801abmr16038012oib.223.1654109478925;
        Wed, 01 Jun 2022 11:51:18 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id ay31-20020a056808301f00b00328c9e63389sm1352957oib.11.2022.06.01.11.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 11:51:18 -0700 (PDT)
Received: (nullmailer pid 215240 invoked by uid 1000);
        Wed, 01 Jun 2022 18:51:17 -0000
Date:   Wed, 1 Jun 2022 13:51:17 -0500
From:   Rob Herring <robh@kernel.org>
To:     medadyoung@gmail.com
Cc:     JJLIU0@nuvoton.com, venture@google.com, avifishman70@gmail.com,
        devicetree@vger.kernel.org, YSCHU@nuvoton.com, yuenn@google.com,
        ctcchien@nuvoton.com, openbmc@lists.ozlabs.org,
        alexandre.belloni@bootlin.com, KFTING@nuvoton.com,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, tali.perry1@gmail.com, KWLIU@nuvoton.com,
        a.zummo@towertech.it, tmaimon77@gmail.com, benjaminfair@google.com
Subject: Re: [PATCH v3 1/3] dt-bindings: rtc: nuvoton: add NCT3018Y Real Time
 Clock
Message-ID: <20220601185117.GA215023-robh@kernel.org>
References: <20220527084647.30835-1-ctcchien@nuvoton.com>
 <20220527084647.30835-2-ctcchien@nuvoton.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527084647.30835-2-ctcchien@nuvoton.com>
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

On Fri, 27 May 2022 16:46:45 +0800, medadyoung@gmail.com wrote:
> From: Medad CChien <ctcchien@nuvoton.com>
> 
> Document devicetree bindings for the Nuvoton NCT3018Y Real Time Clock.
> 
> Signed-off-by: Medad CChien <ctcchien@nuvoton.com>
> ---
>  .../bindings/rtc/nuvoton,nct3018y.yaml        | 44 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/nuvoton,nct3018y.yaml
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

