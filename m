Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A5B5A477E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 12:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiH2Krs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 06:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiH2Krq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 06:47:46 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFFEA5B781;
        Mon, 29 Aug 2022 03:47:45 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-333a4a5d495so184372247b3.10;
        Mon, 29 Aug 2022 03:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=kSieKOlo1/WXICMwAgDNVpDovck1uNqjYZr77DgkzKg=;
        b=HxFupa1nz/7jnMJaXoUkalkcUiimSoG9gFuCoxaCaUCWO1XeKfJjotPNX/ld43NZV+
         xb9fofqFTbBB/m57w3kc8/VpE5FHKXIpTiXitBbscwLOjUS+PcSwh4B7+pVwnlHb6Ixr
         OyAlUxp49g5ZsZD2zR0yZf7syBmJ/2d249ax05/nlTgDAm6W2Z9gpIfJEGwkpHv4VmfE
         f6cOwXn93ePgjvTfxkoMmFn/GJ3OUTW6MPTmRn2qmv1sW77uoO/ZNnS0+beMWIFga/a6
         cQ6vB+lbrghQ1z5y5NmzA9xjtjl1UL3VW7hJ1hW/lM5PtNhIZ6tewoBopKHTFPn0J2Xm
         te3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=kSieKOlo1/WXICMwAgDNVpDovck1uNqjYZr77DgkzKg=;
        b=AWCxutxFgggjF6KhkfGGUZz/Vcc+whMMzUOVfAbFk7825GELiqdeKws+qJxEXGaMQE
         DmR71kjOELGnaKXAlnpqSjHHgxZm9tVwXQtgdrhnMMD7bFst8XNDkKNWPJLt/ul9MZ2c
         jOsMarmX8zS2XSykzIk5YBLwzfPu+KdtS3pSqR48b1u2INe6Sc2BcEcmhPXH0oXZ0h9W
         MxkzEwZ+s6bP9yi1ZOl5eKyj9cV+V+uDC/xwTR+Gf4jCT6KBgCSR8mEuY4iaAeyDgKee
         283ncm8UTbPRpRnZpV6Bl477hvB8g1PTgbnE5/S+XyYQUN266BnkSX+F4aVMcWtCDV68
         Lw8A==
X-Gm-Message-State: ACgBeo3My2fAeCNpIqUpYe4jioqBrOhI/pIWwfPC4AGYhQiEniLVanrb
        hqjHsMrORK2q39fOdEX6Ym+r7/FPjX0qh9bhdBk=
X-Google-Smtp-Source: AA6agR6JcTZw4epIOLkyhUxCjBwgxCGzrkYktQOOZ2cfKa/x8rbYWOImx4JDCrqVO/hXWrcwsNVGLCJpt6uwMl3sqlw=
X-Received: by 2002:a81:7882:0:b0:339:802b:b4c0 with SMTP id
 t124-20020a817882000000b00339802bb4c0mr9521292ywc.488.1661770064718; Mon, 29
 Aug 2022 03:47:44 -0700 (PDT)
MIME-Version: 1.0
References: <YwyORp72cuDrVYdA@debian> <TY2PR06MB321356F6EB09D3D59D37B53F80769@TY2PR06MB3213.apcprd06.prod.outlook.com>
In-Reply-To: <TY2PR06MB321356F6EB09D3D59D37B53F80769@TY2PR06MB3213.apcprd06.prod.outlook.com>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Mon, 29 Aug 2022 11:47:08 +0100
Message-ID: <CADVatmMevKbZ+gHfG-7kuy3s=K2_Qe1OOVrL92OUiTMeoK7ViA@mail.gmail.com>
Subject: Re: build failure of next-20220829 due to 108713a713c7 ("crypto:
 aspeed - Add HACE hash driver")
To:     Neal Liu <neal_liu@aspeedtech.com>
Cc:     Johnny Huang <johnny_huang@aspeedtech.com>,
        Dhananjay Phadke <dphadke@linux.microsoft.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 11:04 AM Neal Liu <neal_liu@aspeedtech.com> wrote:
>
> > -----Original Message-----
> > From: Sudip Mukherjee (Codethink) <sudipm.mukherjee@gmail.com>
> > Sent: Monday, August 29, 2022 6:01 PM
> > To: Neal Liu <neal_liu@aspeedtech.com>; Johnny Huang
> > <johnny_huang@aspeedtech.com>; Dhananjay Phadke
> > <dphadke@linux.microsoft.com>; Herbert Xu <herbert@gondor.apana.org.au>
> > Cc: David S. Miller <davem@davemloft.net>; Joel Stanley <joel@jms.id.au>;
> > Andrew Jeffery <andrew@aj.id.au>; linux-aspeed@lists.ozlabs.org;
> > linux-crypto@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > linux-kernel@vger.kernel.org; linux-next@vger.kernel.org
> > Subject: build failure of next-20220829 due to 108713a713c7 ("crypto: aspeed
> > - Add HACE hash driver")
> >
> > Hi All,
> >
> > The builds of arm allmodconfig have failed to build next-20220829 with the
> > error:
> >
> > ERROR: modpost: "aspeed_register_hace_hash_algs"
> > [drivers/crypto/aspeed/aspeed_crypto.ko] undefined!
> > ERROR: modpost: "aspeed_unregister_hace_crypto_algs"
> > [drivers/crypto/aspeed/aspeed_crypto.ko] undefined!
> > ERROR: modpost: "aspeed_register_hace_crypto_algs"
> > [drivers/crypto/aspeed/aspeed_crypto.ko] undefined!
> > ERROR: modpost: "aspeed_unregister_hace_hash_algs"
> > [drivers/crypto/aspeed/aspeed_crypto.ko] undefined!
> >
> >
> > git bisect pointed to 108713a713c7 ("crypto: aspeed - Add HACE hash driver")
> >
> > I will be happy to test any patch or provide any extra log if needed.
> >
> >
> > --
> > Regards
> > Sudip
>
> Hi Sudip,
>
> I already sent another patch to fix this build error, could you give it a try?
> https://lkml.org/lkml/2022/8/29/131

Thanks, that has fixed the failure.


-- 
Regards
Sudip
