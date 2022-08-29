Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186925A4FF2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 17:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiH2PNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 11:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbiH2PNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 11:13:39 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D48394EFD;
        Mon, 29 Aug 2022 08:13:36 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id a133so10696423oif.4;
        Mon, 29 Aug 2022 08:13:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc;
        bh=p3A0HExHq2mOkVucF/vsIJSYsXoF+Z4KJG+f4AEIqcQ=;
        b=VvxL3U4VXxUzi7JWfVfek+97wFh8IYxMF8HN8rNJ9KH/qUQxXsajPoXZSXAMPUOPCk
         iyTFt/K16eF5ZOfzgN05PZSNKQjwoxrwihq+o6ar5l0lQhjsfYuWQCRnRsSn9nTzdrDa
         surEey/PJlD1v1A5sN9Bc55MVw5GBj1JYFYm5yPT35Yz2dnY/rK6Gy+DLHyaZs3pRawM
         8C+Cn0tb+zkwqdpeZm4J4dDla+SsaxMfWu02tInu8Q3QlRrHpuyizPFhdr8pPMblvpKS
         rMjLksjNyxmtdzRQnVTsar6sWG6lbxL5BUtbFqdbHQzGeGqVdxhV+ah416iuwmrjP3fz
         JY3g==
X-Gm-Message-State: ACgBeo1xQDG74Ho7/tWsvw7U4p9jJHnQ7p1BNwb42Rq6SolBo/c80gip
        qPZP8cR5IQJCRc42czGgtA==
X-Google-Smtp-Source: AA6agR7mAXUlmEi+3D1JiT2cdYdbmWM+9f4FsoLPeje1bDuMzE9p9iV5a3ynjEp7pFHdM7xWwuXY6A==
X-Received: by 2002:a05:6808:10c2:b0:345:c2da:79b9 with SMTP id s2-20020a05680810c200b00345c2da79b9mr6123161ois.298.1661786015562;
        Mon, 29 Aug 2022 08:13:35 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z14-20020a056830128e00b006389650374dsm5765491otp.54.2022.08.29.08.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 08:13:35 -0700 (PDT)
Received: (nullmailer pid 1600522 invoked by uid 1000);
        Mon, 29 Aug 2022 15:13:34 -0000
Date:   Mon, 29 Aug 2022 10:13:34 -0500
From:   Rob Herring <robh@kernel.org>
To:     Olliver Schinagl <oliver@schinagl.nl>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Daniel Mack <daniel@zonque.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleh Kravchenko <oleg@kaa.org.ua>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Simon Shields <simon@lineageos.org>,
        Olliver Schinagl <oliver+list@schinagl.nl>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 resend] dt-bindings: leds: Expand LED_COLOR_ID
 definitions
Message-ID: <20220829151334.GA1596856-robh@kernel.org>
References: <20220819152904.433514-1-oliver@schinagl.nl>
 <YwzJMAaYT/frJLaT@ada.ifak-system.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwzJMAaYT/frJLaT@ada.ifak-system.com>
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

On Mon, Aug 29, 2022 at 04:12:00PM +0200, Alexander Dahl wrote:
> Hei Olliver,
> 
> Am Fri, Aug 19, 2022 at 05:29:04PM +0200 schrieb Olliver Schinagl:
> > In commit 853a78a7d6c7 (dt-bindings: leds: Add LED_COLOR_ID definitions,
> > Sun Jun 9 20:19:04 2019 +0200) the most basic color definitions where
> > added. However, there's a little more very common LED colors.
> > 
> > While the documentation states 'add what is missing', engineers tend to
> > be lazy and will just use what currently exists. So this patch will take
> > (a) list from online retailers [0], [1], [2] and use the common LED colors
> > from there, this being reasonable as this is what is currently available to
> > purchase.
> > 
> > Note, that LIME seems to be the modern take to 'Yellow-green' or
> > 'Yellowish-green' from some older datasheets.
> 
> Just noticed you did not send this to neither linux-leds mailing list
> nor the LED subsystem maintainer. Maybe you want to do this in v3?

Yes, please do. If Pavel doesn't pick up v3 in a timely manor, then I 
will.

Rob
