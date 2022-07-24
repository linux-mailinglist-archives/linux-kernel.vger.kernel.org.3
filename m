Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E745857F42A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 10:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbiGXIop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 04:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiGXIon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 04:44:43 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8086E140D5;
        Sun, 24 Jul 2022 01:44:42 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id p10so6302220lfd.9;
        Sun, 24 Jul 2022 01:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lv3zYQALgYY1iSSRJ6c3vQT0Or5W0piyPXsF6s1qXTo=;
        b=XMKD8Nu+jwF+epSxh759innZceuNK2Bbw9dU7ztnxIx45oOakZqPaox2OvzAs013QZ
         Nh6gNZg7PGK3ONX/9CrIxeNtTjC66xDS6dT7ETZjZzOaowbI+d/6Y8+44v937IVGkSd+
         KMPZybjD5f7ACQR7H+9/BPfgLeKXBvOGUrjrfhPB5NxftKUyig+bivm0nk3z8IUqQKu4
         QFELteaFI5z8iPfUqizJi8x/E+Er7goe3ih38q7ECzw/OXJ0DzW3bv5xNsHdlQZ7o+1H
         ckgRUpJAWzOWvFfHjm0IwTVnJHW51Y4aQKrZdAKWK30cLmo+zgKoKtSlnnXqKZ8WeOZh
         Uxzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lv3zYQALgYY1iSSRJ6c3vQT0Or5W0piyPXsF6s1qXTo=;
        b=7RstymHkf2GtnfbP1UcHUYZYDAZu7LXUwv4sKOqhanXu6+stqm9i77yYrVWYUbdXIa
         +XpsNWt2ZB9QELPuVw6EMDEyGs4/6+00llFiqdbJaDdMUj74/pJsIoiHBL3VuE5eTGAc
         Rk6paBryRA+HhWmwvUSyCOcnJYW9+3N8QDE7UgOgpUMAKkDiIrdzaxn/qPflK4HEcVIg
         b99N0BQiY/FaLEC93BZQpTD40jZDffv2qk4ZECBLkNLTwhtoWLugEtVLRkBaCPg9fNhT
         grz0Y4CjrN1B2RFZcTePhsTJpw1vmmlQvdYFNsTUYmWMp1/M3lj50S9i0NWMNfQjfAum
         UZ2Q==
X-Gm-Message-State: AJIora/pq9br31bOOndnqVzNEPwnjhlxu0bOEPDFEkGFBifxOtDb4/LH
        s2mz2vwsHXdakRRduwn93jmFeL2H4A7LzDZau3EGlrPgzsA=
X-Google-Smtp-Source: AGRyM1sMjnyjs4vQ7R5Dp7jQ1b/Q/TvIyjqqZKfRGL4+99ObRiyjPqebsPomLEK3FjhrAd+IKrP3ZH2PFUr+abpBM40=
X-Received: by 2002:a19:6d0d:0:b0:48a:8b3c:e28 with SMTP id
 i13-20020a196d0d000000b0048a8b3c0e28mr304341lfc.265.1658652280751; Sun, 24
 Jul 2022 01:44:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220722114136.251415-1-tmaimon77@gmail.com> <20220722114136.251415-3-tmaimon77@gmail.com>
 <afae04e0-76a3-1bcb-5b47-9944fa9ab2c0@linaro.org> <YtrvyyMGm64hFG5j@sirena.org.uk>
 <0c8688d5-b0c1-8cc1-ec27-292acbb38dfc@linaro.org> <YtrzF9BFJrXfxiz0@sirena.org.uk>
In-Reply-To: <YtrzF9BFJrXfxiz0@sirena.org.uk>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Sun, 24 Jul 2022 11:44:29 +0300
Message-ID: <CAP6Zq1iRowFv4qg=AqdVmBRRx5p4-5AaC1G-aZs=2LnOAOELXA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] spi: npcm-pspi: Add NPCM845 peripheral SPI support
To:     Mark Brown <broonie@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        linux-spi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark and Krzysztof,

Thanks for your reply,

On Fri, 22 Jul 2022 at 21:57, Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, Jul 22, 2022 at 08:47:24PM +0200, Krzysztof Kozlowski wrote:
> > On 22/07/2022 20:43, Mark Brown wrote:
>
> > > ...with a fallback list required by the bindings so the driver actually
> > > binds.  Note that bindings are currently not in YAML format so there'd
> > > be even less enforcement of that than normal, and as they're currently
> > > written the bindings don't require fallback.
>
> > Yes, the bindings document should be rephrased but we were living like
> > that for few years. :)
>
> The binding document as it stands only has one compatible, there's no
> existing problem with it other than the YAML conversion.  If we're
> adding something new that requires a fallback we should be explicit
> about that rather than have something that's actively misleading where
> previously things were clear.  I don't mind if we add the compatible to
> the driver or document the requirement for the fallback but we should do
> one of the two.

is V2 good enough? adding the compatible to the driver and the document?
Or should we use fallback?
If fallback is choosen, can you explain how I should do it?

Best regards,

Tomer
