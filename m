Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C01244B27BF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 15:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350765AbiBKOVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 09:21:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234454AbiBKOVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 09:21:53 -0500
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC799188;
        Fri, 11 Feb 2022 06:21:52 -0800 (PST)
Received: by mail-qt1-f182.google.com with SMTP id p14so9182137qtx.0;
        Fri, 11 Feb 2022 06:21:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hs6Ap8pvv6rLiNRkR68HWZ4eW38QIARNwTh1k3Vr+zU=;
        b=S91l9tYjFkpsDoNMUINV6I2tPp2DPc9eBl8rmUJyPsvHv7xrfLwIgzOzBDb3OBIR/F
         qeu3rl/cIy1Olalau+rmS5s3LaZvwnUw5bApZPV2lI+lI+XMKVTHaX3X5QcCsOq3J0EB
         OLOVEHbwRGJOBlCgw2BqtG+RnpPdcAb/XoxQ2x7ZTsQIhLBoMOfiony2zzripV9WOYZY
         FF+HwEY3VYKcVb7uBnICjT0BY7SXQvNvZNpGmbw4+gNYQmNHDqQPc5fwDhYeDg8aFh+W
         5qHE+vLkudn5z8CEbTjKMUu6g52Twcyx3N56nuklqZ2Qv/jFNYhkjOQ1dxpEkIlFnZwA
         dK6A==
X-Gm-Message-State: AOAM533FMBws6yHxSxOZh+xMHX3t3IUoufMivcQ+A9fve0FL71dMTTrC
        9qd5zvwtgaTVAcEy+ssZ4A==
X-Google-Smtp-Source: ABdhPJx8w0KDh1IldBQXPmdd2nBRtR+3S0tWLeJdA7L6Xc1qSyZsVZjBlhAUfAptuOPx1AI6ExN57A==
X-Received: by 2002:ac8:5b94:: with SMTP id a20mr1230049qta.270.1644589312029;
        Fri, 11 Feb 2022 06:21:52 -0800 (PST)
Received: from robh.at.kernel.org ([2607:fb90:20d7:a802:e6b0:6d9c:32f7:4bd9])
        by smtp.gmail.com with ESMTPSA id t11sm6372671qkp.82.2022.02.11.06.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 06:21:51 -0800 (PST)
Received: (nullmailer pid 304856 invoked by uid 1000);
        Fri, 11 Feb 2022 14:21:48 -0000
Date:   Fri, 11 Feb 2022 08:21:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Eugen.Hristev@microchip.com, Nicolas.Ferre@microchip.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, clement.leger@bootlin.com
Subject: Re: [PATCH] dt-bindings: microchip: atmel,at91rm9200-tcb: remove
 mandatory interrupts property
Message-ID: <YgZw/IB1V7NTRUJQ@robh.at.kernel.org>
References: <20220204081446.474991-1-eugen.hristev@microchip.com>
 <Yfz15ta50G5WC158@piout.net>
 <e939a0df-052c-43a6-8be6-51848d3fe5e5@microchip.com>
 <Yf0Bkh4pXKORmNkG@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yf0Bkh4pXKORmNkG@piout.net>
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

On Fri, Feb 04, 2022 at 11:36:02AM +0100, Alexandre Belloni wrote:
> On 04/02/2022 10:28:43+0000, Eugen.Hristev@microchip.com wrote:
> > On 2/4/22 11:46 AM, Alexandre Belloni wrote:
> > > On 04/02/2022 10:14:46+0200, Eugen Hristev wrote:
> > >> The timer block can be used only to be read and to measure time in a polling
> > >> fashion. This can be used by Linux like this for example, or it can be used
> > >> by different projects which do not have interrupt controllers, or do not
> > >> wish to enable them (e.g. U-boot).
> > >> As DT is ABI, the binding should relate to all possible use cases and describe
> > >> the hardware and the requirements.
> > >> The interrupt is not a hard requirement for the timer to function in a
> > >> specific way.
> > >> Thus, choose to remove the interrupts property from the mandatory list of
> > >> properties.
> > >>
> > > 
> > > The correct hardware description is that the interrupt is present on the
> > > IP. Having software behave differently depending on the presence of that
> > > property is configuration, not hardware description.
> > 
> > I agree. The interrupt is present on the IP, thus the property exists 
> > and it's described.
> > However, the interrupt is not mandatory for IP operations. Thus it 
> > should not be in the list of mandatory properties.
> > 
> 
> If the interrupt is always present, it is mandatory, it doesn't matter
> whether is is used or necessary to get the IP to work.

Agreed.
