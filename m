Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40AFC4B5690
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 17:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238559AbiBNQhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 11:37:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356466AbiBNQgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 11:36:49 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B064165162
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 08:36:16 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id i14so27752534wrc.10
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 08:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=n+pe1ICl9ewzw4TZgGAHasEYIW8plx51y2a9efb27Bk=;
        b=MAolyPYplTZr3Z0asslEHMSvIqKgp7oSbecwg+8PK2eS2NYe4IhZFTvnXMMFa+T9LW
         luq8pOeuYQZtMGoz+OycvRsWeR4WU0/ej/saNASo8jNPOp61B3W29XgLj0KNbpYBe9GM
         JDcYBGXnOeMaMpQ+9sw55288pkr2TvpvRfb5iJ1zYOO1ZDX4zBCRJdLtHHYtkMqzK6F+
         46PYgnBYVpoRy77XDdSeXF8K5WlDpzbflTQsTwYO6FrR0qPEdXEWlcVeL0JrmuBFEooH
         u/d6zEF9znxqQBL12T1BrxToRIuCFpCADTnOtCCu2z54iOCrQ8afbsWBqOEsfrhLv2Xs
         hmDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=n+pe1ICl9ewzw4TZgGAHasEYIW8plx51y2a9efb27Bk=;
        b=3vyPCkfspekrNw5WM7sT/QreF/k2SoVDYcznuwyEYfSIAFvi+l8VxFR9+W/pDLPk9P
         MqWJic+rjIi33nekoyrUD+ihovjR1IMMSlMloSUhKWx7+ap6Z4MLyU12BAQc2FJeFAfq
         ts/KvT/0MUOoPBVUkC1lcQR0llOQ1z03oMgb6jMk/wdfDQgGXRzvtNoFPIKCa3qcG5fi
         mybn+4QuZzMNobePN52XSXL1gZdSJgNAGhodFRcq1BuXI69A2l9g0M3E2DiykG0rH8u0
         Va+lMdaAIQT+ItrfQwE+/vdIn8GNaOcPcOzdWlOGy6jjmxDw1cfmKf7GpfKwZ5/Fmfy4
         PKZQ==
X-Gm-Message-State: AOAM533XfDjOPtUFPPxBQBjPODREgqqEy93WTKbqj3gSL5mRDmZsh2rp
        oL16kDoA+oHqvagEs9AR3LLZRQ==
X-Google-Smtp-Source: ABdhPJwT1NDvOiOtqW1aozcoW/vxtXUCGwkn3VR8i+/m2MuLda31W368jJ3lCfYDYYb8SQ/X/Kf+Lw==
X-Received: by 2002:adf:e5ce:: with SMTP id a14mr346377wrn.317.1644856575188;
        Mon, 14 Feb 2022 08:36:15 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id x18sm29792103wrw.17.2022.02.14.08.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 08:36:14 -0800 (PST)
Date:   Mon, 14 Feb 2022 16:36:12 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Michael Walle <michael@walle.cc>, SoC Team <soc@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] MAINTAINERS: add myself as a maintainer for the sl28cpld
Message-ID: <YgqE/OvNDco5wEY3@google.com>
References: <20220207184652.1218447-1-michael@walle.cc>
 <YgpkCyoSMg5RYfkO@google.com>
 <YgpkQMbhWAJG6oCh@google.com>
 <CAK8P3a0UWO=h6K4NpzCVC2vbOvThJH28GM5ddm9U1crr1Su7vQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK8P3a0UWO=h6K4NpzCVC2vbOvThJH28GM5ddm9U1crr1Su7vQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Feb 2022, Arnd Bergmann wrote:

> On Mon, Feb 14, 2022 at 3:16 PM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > On Mon, 14 Feb 2022, Lee Jones wrote:
> >
> > > On Mon, 07 Feb 2022, Michael Walle wrote:
> > >
> > > > The sl28cpld is a management controller found on the Kontron SMARC-sAL28
> > > > board for now. Support for it was added by me quite a while ago, but I
> > > > didn't add a MAINTAINERS entry. Add it now.
> > > >
> > > > Signed-off-by: Michael Walle <michael@walle.cc>
> > > > ---
> > > > Hi,
> > > >
> > > > since this affects so many subsystems, I'm not sure through which tree this
> > > > should go. I'm sending this to the arm soc maintainers because it's an
> > > > aarch64 board where this driver is used as well as Lee as the MFD
> > > > maintainer.
> > >
> > > I'm happy to take this, if it pleases everyone.
> >
> > Hold on, you're not going to get many Acks if you don't send it to the
> > other subsystem maintainers. :)
> 
> I've already applied this one through the soc tree.

You did?  I missed the acceptance email.

It would have been nice to give the other maintainers a chance to look
at it first, but I guess it's not a big deal in the great scheme.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
