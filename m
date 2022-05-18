Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B25CD52C1BE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 20:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240759AbiERRyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 13:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbiERRyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 13:54:40 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E8521A966
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 10:54:40 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-2fefb051547so32901107b3.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 10:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wAFhBNGkOYqIauqmAMb6moZVrSw8HOJBfdYpqesZq6Y=;
        b=vs9ButGw7170Q/jEs+fO1lQveZiTXXsgwXYCkgtgQO09RlQztc3/GxtOitWuHeXu2+
         /m5UIMGqa+jiWxNGKo3H1/D9oMvC/sYdhfX+LOTuCNJVTY8nvtyyodAe7NB4yVZ6tK0+
         c/SdQO3Y6jVZmVJAXeNoY/5fs3sDRwtH/fP80XkLq3cUjQ/Rc4dX5GTWC9+tzMSg48sW
         Flac7WAF1NQggHKxkWDJIJ6Vh4LASxdp06hGbSQOl1y08Guq5Y61mXm47is1jS7G/Wjl
         EixXBi++mSL7Xffq0yM4KMyLbCrYwJueODALS+TYjh7Z5o0zOVDvtAixJzlR7m41G89u
         Jdtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wAFhBNGkOYqIauqmAMb6moZVrSw8HOJBfdYpqesZq6Y=;
        b=4CdsDOqS9q92CDfU+w1ukAk9/1FIFulFM8HX4pcmqogZ6fI67xQ3MpLX1hpJYJNdKL
         bwvkTOs/3BqkOsWb0sTOw0vcZxP7otl3YmMCzthG7JMrInoSJ4g30KTthWT/1WXJcYu2
         t2mbPUG4Q0TcrQurHyfev0Y05gnD42AyGTxwHyhnR+qKyqSI8+EglTB6SiV6B5V7eut9
         kfyy8b7vO0wl5UmX5x6ruN5qbwVlECYcrYAuaL91EoXvzUx4Fu6WeqcoCk3AalfVs/hl
         4z9WfdyogptMCBxYD8F8wzEX7xdZCmuuE4McFExoldAQ0Hi2IXYjyDx86UuNS/T042Cf
         O0kA==
X-Gm-Message-State: AOAM533PkhRmGyAwWWYN+mgSi3ohZTN22F9p1K542oAYqN9MVvjk4F7L
        i6FiXmeqLhi3AihZladHSFpK4utMC02y6XsIMBcJuA==
X-Google-Smtp-Source: ABdhPJxcdiytOucNPQKz7tmCfcmD4wZOseejv1XT7mflreTeZKYT19r/h5oY+Ga1GZ2fAhunKyzGPlKDPrqsdZg1R/o=
X-Received: by 2002:a81:1dcf:0:b0:2fa:d094:14ff with SMTP id
 d198-20020a811dcf000000b002fad09414ffmr642224ywd.10.1652896479286; Wed, 18
 May 2022 10:54:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220517101410.3493781-1-andre.przywara@arm.com>
 <20220517153444.GA1057027-robh@kernel.org> <CAFEAcA8sE8Rj0GmF71ox4BdDr0UcaS4QwiLUVUUFH5oj+hDhfA@mail.gmail.com>
 <CAL_JsqLRvEn2E7cpTzQJRCJ=aeLjUtKhDimWat=nPtm3QP+cfA@mail.gmail.com>
 <CAFEAcA_DRoJmnFdyEEcSvCxtPYignZFqQFnHyWkcpyijCBSrCg@mail.gmail.com> <20220518165421.GF3302100-robh@kernel.org>
In-Reply-To: <20220518165421.GF3302100-robh@kernel.org>
From:   Peter Maydell <peter.maydell@linaro.org>
Date:   Wed, 18 May 2022 18:54:28 +0100
Message-ID: <CAFEAcA80B2aGdaxK2pm7AK84KK_UqwD-KCMKtK6b8fF41MeKRg@mail.gmail.com>
Subject: Re: [PATCH] of/fdt: Ignore disabled memory nodes
To:     Rob Herring <robh@kernel.org>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ross Burton <ross.burton@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 May 2022 at 17:54, Rob Herring <robh@kernel.org> wrote:
>
> On Tue, May 17, 2022 at 08:19:47PM +0100, Peter Maydell wrote:
> > We generate the DTB with libfdt, so source-only information
> > isn't something we can put in, I think. (The quoted DT fragment
> > in this patch's commit message is the result of decompiling
> > the runtime generated DT binary blob with dtc.)
>
> Given the runtime aspect with overlays, it's conceivable that libfdt
> could support setting labels some day and then dts output maintaining
> them.
>
> We could also consider a standard node name such as 'secure-memory'.
> It's a whole can of worms though on how secure vs. non-secure memory
> (and other things) are represented.

Mmm. We put in the very basic parts years ago in
Documentation/devicetree/bindings/arm/secure.txt
which is (and has remained) generally sufficient for the QEMU->Trusted
Firmware-> maybe uboot->Linux stack, which is pretty much the only use
case I think. (My intention when we wrote that up was that memory
that's S-only would be indicated the same way as S-only devices,
with the secure-status and status properties.)

> > Are we just stuck with what we have for historical reasons ?
>
> Yes. If we were designing this, we'd probably have 'compatible =
> "memory"'. We're likely just stuck with things how they are. Mostly node
> names haven't been an ABI and we're just trying to be consistent in
> naming and use of unit-addresses.

So, do you think it's worthwhile/a good idea for me to rename
the DT node that QEMU is currently calling "secmem" to be
"memory" ? My default is "leave it as it is", for economy of
effort reasons :-) -- but it's an easy enough change to make.
Though EDK2's dtb reading code just looks for the first
"memory" node and assumes it's the big one, so changing the node
name would make us reliant on the order of the two nodes in the
DTB unless we fixed EDK2 (which we should probably do anyway, tbh).

thanks
-- PMM
