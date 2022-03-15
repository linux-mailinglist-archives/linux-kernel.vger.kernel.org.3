Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419414D9584
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 08:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345591AbiCOHn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 03:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345745AbiCOHnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 03:43:21 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375224B43D;
        Tue, 15 Mar 2022 00:42:10 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id p8so18292350pfh.8;
        Tue, 15 Mar 2022 00:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JvkMr70WJPPuXqL6MLAf4rnX0ShimyVa3ekil/QyEYQ=;
        b=idUtQSXKngSZiivE9bSKriV7w0fKkHRYCqyMyr4a3qoTPOwkRlpYXone+hQio7n1+0
         E1UK5BdcCjwDeXf3pe+3ooUdlIPM+HH6F6WbvEI/ZFHoAxgLbSaj8H5cbVhr5FDiK9EW
         xiSJP5h+jefSoyySIWT+c+ljMIlEnVGe0lsQp+zjBWySsnUzCzdgrsWxx5tinFXHcXuu
         ZGIpP0Vx+o/OiDt3jqHpBwvwfkK2muNzsxkqzZw+GLDMFBkoIXryI4gzf3bA8Y67tWja
         uPBj1/LXYzuW+90wXcU73iJK+zMXvXsJRlNPPxGLLF85FdeXeJWEPy8eyIycTLl6hLiV
         kJDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JvkMr70WJPPuXqL6MLAf4rnX0ShimyVa3ekil/QyEYQ=;
        b=pn5e9cMsr1g3dwrmq44X6q7gaEpu8rrWooPYwHAg8W9STv7BEZv1dtIduQPfjglgOK
         doh6rhDd5/aYO4fKxW6HWplI8cvPSByraEIdNeGXza6twDnWvBGqkMcwl2oXLkMUaRjY
         E8t7tGEa+hHWWiZS8d1tjwlhzQxpmhmECh85JV+mDj/znvK0+pWFiaJNDSFaVRAbReRt
         oe8b9lt0+v5qzx25FKY1yg6R6cBTnzeQklUcaEiemooRN5AUhkjxFLcFJEo6+evk7+xa
         ovJixTg2p7TsgRScMJ/AMlJ29MEl6oUi/B88uARHkGUhXvLXHtrYQAFcpxutVNda9TBR
         HaDA==
X-Gm-Message-State: AOAM531+75CZADistzqOWURhd6HPYeZ0tDGTj5FkGdjRp74y4DkaZR0F
        eMuyZ3QCXpZZF1fmj7xcnQs=
X-Google-Smtp-Source: ABdhPJxEhyzhWKO7pnstMetgtav0ywjKj7rm9UdPPrXO6uDqvojJLtUFw6Tc17S9/03kxDHDLt8sBw==
X-Received: by 2002:a05:6a00:2389:b0:4f7:5d29:5148 with SMTP id f9-20020a056a00238900b004f75d295148mr27573971pfc.52.1647330129618;
        Tue, 15 Mar 2022 00:42:09 -0700 (PDT)
Received: from 9a2d8922b8f1 ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id d11-20020a056a0024cb00b004f725ecf900sm23973058pfv.97.2022.03.15.00.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 00:42:09 -0700 (PDT)
Date:   Tue, 15 Mar 2022 13:12:03 +0530
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: bcm-cygnus: Update spi clock properties
Message-ID: <20220315074203.GA19021@9a2d8922b8f1>
References: <20220311084114.16408-1-singh.kuldeep87k@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220311084114.16408-1-singh.kuldeep87k@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2022 at 02:11:14PM +0530, Kuldeep Singh wrote:
> PL022 binding require two clocks to be defined but broadcom cygnus
> platform doesn't comply with bindings and define only one clock.
> 
> Update spi clocks and clocks-names property by adding appropriate clock
> reference to make it compliant with bindings.
> 
> CC: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>

Florian, this patch was initially based on stblinux,devicetree-arm64. I
just checked on devicetree branch, and it can apply cleanly anyway. I
hope there shouldn't be any need to send patch again. Please let me know
in case something needs to be taken care. Thanks!

-Kuldeep
