Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C1A5616CA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 11:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234286AbiF3JuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 05:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiF3JuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 05:50:10 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5945343399;
        Thu, 30 Jun 2022 02:50:09 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (dkwl20tj04snw15cjtflt-3.rev.dnainternet.fi [IPv6:2001:14ba:4493:6f40:fec3:d72a:e447:8113])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 3197A1B00133;
        Thu, 30 Jun 2022 12:50:06 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1656582606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pSeIhViRCy+/xh4kXDryisAXOZaaJ4uKR122HsLjhdo=;
        b=Qcb2SLALy7gcfDQ0E5276p+ZWRC5uOxajdTYmqBi2DeYeMCMekN6HcJ9bl0fdK+i8bXKF9
        PGHqfOkTIEB0kK9f+HN3ulaaSIBDZu7lO+1tddPzcUWwqAUHnDs7jLlfGxfOP9gO8kc8Vw
        SeAWP6oetewuCyA8VUC4J7QpSCdrEi+7rWKFz27v7Pk1U9DnRz9xVfNRRHRCLiwoaM3+Sx
        u0z4sprFdYfldXz2c2gjkYLByPz6y9OgK+0ExToj+PbyLY+CLq0bSadOfj9ZDXKcGDrdFc
        dzgxEocZPlYbIPliCETfG55h23pl02Pr8yDapuWJn13NCwPrhNeGmlEjoFpn4Q==
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id C2FB2634C91;
        Thu, 30 Jun 2022 12:50:05 +0300 (EEST)
Date:   Thu, 30 Jun 2022 12:50:05 +0300
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linuxfancy@googlegroups.com, linux-amarula@amarulasolutions.com,
        quentin.schulz@theobroma-systems.com,
        Daniel Scally <djrscally@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/6] media: dt-bindings: ov5693: document YAML binding
Message-ID: <Yr1xzeqW2p4jVDzS@valkosipuli.retiisi.eu>
References: <20220630074525.481790-1-tommaso.merciai@amarulasolutions.com>
 <20220630074525.481790-6-tommaso.merciai@amarulasolutions.com>
 <167f09c1-795d-1471-20f7-9f4df29355ed@linaro.org>
 <20220630090232.GC482517@tom-ThinkPad-T14s-Gen-2i>
 <Yr1pD2U2ilXXXX+Q@valkosipuli.retiisi.eu>
 <20220630091613.GD482517@tom-ThinkPad-T14s-Gen-2i>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220630091613.GD482517@tom-ThinkPad-T14s-Gen-2i>
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1656582606; a=rsa-sha256;
        cv=none;
        b=Nxfl1guUSYCp+iJrg20bZ7vZ7G6BnZoD2DdsyMV3+713PW+S+tfM83YfvE5rFN3VW8goG5
        vCPm5WaHLS94A3XJHe+8H04vs6I6f4/wiX5V8OEU1X2QzMZFZS5y9YljIKwj+epm7oYIH3
        REGxQVVuXylNEjmCouryie3T8Wmu3ORAX/i4MQZPcGqUsBcEO5XF5Dss0iQwvHnaAqR2ek
        lxt0upMGkCaSBy+9Zqz24OTM+MgpeMzoMUWUuS8B59rheU0KG6YxlQmEAvHFPxtlssHUiG
        +7QjcltE+g5TYvRqjNvE9qM043TuDWArB6/ipY3xt9jyqJ4D+jqmVOib64Kt/w==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1656582606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pSeIhViRCy+/xh4kXDryisAXOZaaJ4uKR122HsLjhdo=;
        b=oC8hbtP0h7ts7B3QcEY0qL8YFC6e6IYK8r2DjjVb8zrO3Cv++za6BYi6/Ts+c2Oi2Mp/J8
        uejmiYxblvk+hz3mjdnHIJlzKAq2kJv7swqbsQFpkJ5tu/WUil5tNmFM6W8zWgSYfDrTAB
        P/6c3k1LLVHqCI+xrniXmLt+mIjqf6BNgp23/xVkKfFP9s8JoIBqERU1ISF9h9AcT9QzPI
        VofzvarmrKZ7HoeCGPY6mGrkKnG80m9zycw45YoABjAIY49VwI3UGkVIibYlpL4Tr01hr2
        Mv97LqMlNi6QO7OoZyNcxiUS+ERmMx7J8cUrmgnLva5QDY6WNVw3sMuwQ+Gk/Q==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tommaso,

On Thu, Jun 30, 2022 at 11:16:13AM +0200, Tommaso Merciai wrote:
> Hi Sakari,
> 
> On Thu, Jun 30, 2022 at 12:12:47PM +0300, Sakari Ailus wrote:
> > On Thu, Jun 30, 2022 at 11:02:32AM +0200, Tommaso Merciai wrote:
> > > On Thu, Jun 30, 2022 at 10:07:19AM +0200, Krzysztof Kozlowski wrote:
> > > > On 30/06/2022 09:45, Tommaso Merciai wrote:
> > > > > Add documentation of device tree in YAML schema for the OV5693
> > > > > CMOS image sensor from Omnivision
> > > > > 
> > > > > Signed-off-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
> > > > > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > > > Reviewed-by: Sakari Ailus <sakari.ailus@iki.fi>
> > > > 
> > > > How Sakari's tag appeared here? There was no email from him.
> > > 
> > > Sakari made me some review on v2, but I think he forgot to add the mailing
> > > list in cc. ( I suppose :) )
> > > 
> > > Let me know if I need to remove this.
> > 
> > You're only supposed to put these tags into patches if you get them in
> > written form as part of the review, signalling acceptance of the patch in
> > various forms. Just commenting a patch does not imply this.
> > 
> > Please also see Documentation/process/submitting-patches.rst for more
> > information on how to use the tags.
> 
> Thanks for sharing this. My bad.
> I remove your tags.

The patches themselves seem fine. I'd just drop the 4th patch or at least
come up with a better name for ov5693_hwcfg() --- you're acquiring
resources there, and that generally fits well for probe. The code is fine
already.

-- 
Sakari Ailus
