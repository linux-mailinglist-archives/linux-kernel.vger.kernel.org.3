Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86AA74CA599
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 14:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235898AbiCBNI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 08:08:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235028AbiCBNIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 08:08:23 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675DF2B24D;
        Wed,  2 Mar 2022 05:07:40 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id ev16-20020a17090aead000b001bc3835fea8so1786916pjb.0;
        Wed, 02 Mar 2022 05:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vy88rPf4HP0qCY7ppcGXjkLJQx9SMGIil+BjWV6/Jao=;
        b=RbYvGZOEHlCYI4oDWtJXd+49ZvgEU+NXhe/5CMQ3gOY+QwmL8NdlPE+VrYzwz8gKId
         ismE+esvInxP0L/UqtHVvV/BVfOA7Pdv1hHiFF8glUKrrFz1vjOGTdc5YwesuM1woF/s
         VkN4oLIvMI/afgTgiq2aBiyuzAg1Qxm7aFulWtq4aaG35ESbP2M/q+NjsAHU8OGlmg4j
         oXt2Z91eK4JHIZOd0pkLdxfOuRGUvP6i4GVlmTJm+HBl6+NN0iK4XZ6GY4rk2hxKdW9j
         FtZdiHMa/gLQYosiay4D3RMT9yscSFA/tFleJr7Xm77VTR221vrW2DpMbGbsTAnfb1vV
         Hmng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vy88rPf4HP0qCY7ppcGXjkLJQx9SMGIil+BjWV6/Jao=;
        b=X1HYOX7uuMeVYnXjsrKU4M5meeKc8vN8+MieO2tHuI6Hxko7KzEQrD/7IlhpHSEFVa
         90LmucWWTSwOmMvSelXrX7JL7ZlZYNjZxarUYKyWtn6NJ9Vh7A09W4EYaRHOuY8OG80n
         Rm8dP7PPTEsR/nA4h5SCtlSS/w5L3CP6DfSbo0zJmxvXzywjV0oKFLyz9lDQu6jxfv2B
         jfhMWTzNcT2e6rh67vgTzMsesVWQsgrdzkAt5ePvPDpYhqLuKcV9Y+ZRfkjlM9zWO4pz
         U7mFRMdGBOp6xaKeiIq7YwwCZpx9jlELdujZImwtxz0dzZSSpNPruYGnRI1eD/9+f9Ph
         DRvA==
X-Gm-Message-State: AOAM533GsLE8vKRhSG3VGtVsjkRvcIVezPfkd6aFLu77qWlOWx5cuPrC
        Hue3BEVo5jABciuOYVm3eTY=
X-Google-Smtp-Source: ABdhPJxZ2jUdDyuL/30KkHL1bbiJEz0vZKIHg09OGKTHoPskVjy65Jtp/4Sxps/loMNSc8Hn5w6Rhw==
X-Received: by 2002:a17:902:d4cc:b0:151:3857:817b with SMTP id o12-20020a170902d4cc00b001513857817bmr25133745plg.139.1646226459799;
        Wed, 02 Mar 2022 05:07:39 -0800 (PST)
Received: from 9a2d8922b8f1 ([122.161.53.154])
        by smtp.gmail.com with ESMTPSA id l10-20020a056a00140a00b004c55d0dcbd1sm20536758pfu.120.2022.03.02.05.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 05:07:39 -0800 (PST)
Date:   Wed, 2 Mar 2022 18:37:34 +0530
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Scott Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: ns2: Fix spi-cpol and spi-cpha property
Message-ID: <20220302130734.GA2026@9a2d8922b8f1>
References: <20220228110903.97478-1-singh.kuldeep87k@gmail.com>
 <bdb6a903-6efc-e7ff-3a88-70ad9fe3fc09@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdb6a903-6efc-e7ff-3a88-70ad9fe3fc09@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 01:31:50PM -0800, Florian Fainelli wrote:
> 
> 
> On 2/28/2022 3:09 AM, Kuldeep Singh wrote:
> > Broadcom ns2 platform has spi-cpol and spi-cpho properties set
> > incorrectly. As per spi-slave-peripheral-prop.yaml, these properties are
> > of flag or boolean type and not integer type. Fix the values.
> > 
> > CC: Ray Jui <rjui@broadcom.com>
> > CC: Scott Branden <sbranden@broadcom.com>
> > CC: Florian Fainelli <f.fainelli@gmail.com>
> > Fixes: d69dbd9f41a7c (arm64: dts: Add ARM PL022 SPI DT nodes for NS2)
> > Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
> > ---
> > Hi,
> > 
> > This patch is on top of git://github.com/broadcom/cygnus-linux.git,
> > master branch which is not updated since 4.14 kernel.
> > Hope the reference is correct. Thanks!
> 
> The reference is not correct, but it applied cleanly anyway. The correct
> reference would have been the github.com/Broadcom/stblinux
> refs/heads/devicetree-arm64/next

Thanks Florian for mentioning.
I took a quick look at MAINTAINERS file before sending patch and found
cygnus-linux repo as base reference. It seems the correct reference is
not updated in MAINTAINERS file.

> 
> Applied, thanks!

Thanks!

-- 
Best Regards
Kuldeep
