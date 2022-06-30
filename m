Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0DDD5615BA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 11:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233898AbiF3JM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 05:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233779AbiF3JMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 05:12:54 -0400
X-Greylist: delayed 34499 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 30 Jun 2022 02:12:51 PDT
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43051CB2F;
        Thu, 30 Jun 2022 02:12:51 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (dkwl20tj04snw15cjtflt-3.rev.dnainternet.fi [IPv6:2001:14ba:4493:6f40:fec3:d72a:e447:8113])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by meesny.iki.fi (Postfix) with ESMTPSA id EE9532006F;
        Thu, 30 Jun 2022 12:12:48 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1656580369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TLRwBn9UXXli3PGpjsfVklActhmxiReU97C0QNKDOvY=;
        b=kvhWddh1DbwrpFE9ab7GwdbQp8KfiJMvhCj7vhXB8E8M8wB4Nv3aVaeJ9kt8Vs/pJXd4SN
        l6m+j+bxG3gmMzMV5pAIJAykRkig9oURWnQROzE3f6kxBa2UzVV8DonhR+EF/UUBiomZLY
        K0zXyKoZNHo6CoMZ4vRhpUTqoLi07pc=
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id C9FCC634C91;
        Thu, 30 Jun 2022 12:12:47 +0300 (EEST)
Date:   Thu, 30 Jun 2022 12:12:47 +0300
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
Message-ID: <Yr1pD2U2ilXXXX+Q@valkosipuli.retiisi.eu>
References: <20220630074525.481790-1-tommaso.merciai@amarulasolutions.com>
 <20220630074525.481790-6-tommaso.merciai@amarulasolutions.com>
 <167f09c1-795d-1471-20f7-9f4df29355ed@linaro.org>
 <20220630090232.GC482517@tom-ThinkPad-T14s-Gen-2i>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220630090232.GC482517@tom-ThinkPad-T14s-Gen-2i>
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1656580369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TLRwBn9UXXli3PGpjsfVklActhmxiReU97C0QNKDOvY=;
        b=lpVpDPsRoS4PajOnLBBgfcJw9triksPg+5Em1BSvH7k+/EZaTkjASpVVQnohNS5yNlOTbU
        gB6aGDJ+Mw0sFTjOA3xO4AhLpEtL9sy3zMoQDG8uyrCfhOu3g4TjZTZpAqVxBWMYZcdEYp
        1xtKwJ5uD3QXguCMHOm55Tae+0RPMNE=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1656580369; a=rsa-sha256; cv=none;
        b=JyMc3AwKN7Uwp6GUIzZIVTyHMWwOSIMn7Ry0CzODoxYahGuBI9dogP/fqFwoeq3UQYmxVH
        PlJFDVco74sl6swfZKKWiVeyQ5u1m3FFV0zFqCcbFR+ehIxTOX+Z8S3ZBxj25QQ9dFQwGr
        8m1tXRBFZUppPGnbb+yMgadYo+pXy80=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 11:02:32AM +0200, Tommaso Merciai wrote:
> On Thu, Jun 30, 2022 at 10:07:19AM +0200, Krzysztof Kozlowski wrote:
> > On 30/06/2022 09:45, Tommaso Merciai wrote:
> > > Add documentation of device tree in YAML schema for the OV5693
> > > CMOS image sensor from Omnivision
> > > 
> > > Signed-off-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
> > > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > Reviewed-by: Sakari Ailus <sakari.ailus@iki.fi>
> > 
> > How Sakari's tag appeared here? There was no email from him.
> 
> Sakari made me some review on v2, but I think he forgot to add the mailing
> list in cc. ( I suppose :) )
> 
> Let me know if I need to remove this.

You're only supposed to put these tags into patches if you get them in
written form as part of the review, signalling acceptance of the patch in
various forms. Just commenting a patch does not imply this.

Please also see Documentation/process/submitting-patches.rst for more
information on how to use the tags.

-- 
Sakari Ailus
