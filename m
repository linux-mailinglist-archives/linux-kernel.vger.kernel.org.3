Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3EA955516D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 18:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358909AbiFVQnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 12:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357542AbiFVQnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 12:43:06 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E12275C9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 09:43:03 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-101d96fe0a5so13672621fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 09:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SSsa0pENwU2Tn6HMSvnHASt+fmeOl5yphMHT/THLtgA=;
        b=YCTNtGyw+LYOyfHU+VTvp8GFMZx9Nof9V75hUszxpRYpfAsj2viT0n7x6dGqt7vhnq
         FCo//eybu/kJW4WWm4NzhPcNdYootMx+n/axkxtGq1ubEGcs0NV0vQZlqceGdHo0wyQz
         pRq7+lpqJidCECIXdXtW/ORT0Q+BGTpsp3+3Pr3tLukRxVSs1/cTQVUa5cSYG0KnTiqu
         9Tq5QcNUB9TkC9zMhZXyIzLrqE1GT9z31oR1555DV1fBdrztvwjFOpnRLxgRAz+tVAl2
         9qQPGCilI4HF3QdIHxzamwRYCNu59uvfimFRv/ryHc665wbhZTPuP+lmVAIios8/ix1S
         Hczw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SSsa0pENwU2Tn6HMSvnHASt+fmeOl5yphMHT/THLtgA=;
        b=3Q8ptyKViW9DhtRBxCIIzlNKcQJrJ6eUSvbjgrV53MhOgUfidI23Fy68NiFSmeveqd
         CZuhCEPrnCOOfnPFVpSB3OO/SlMJSK+YzDhnh+iDzxppSfKe9P8cnZV9U+HMvJuLE//3
         Z1MhE43ie5oI6ZIRYi+ktMILpB/nAf1FbwOw3pgIoxAPsDUXahWjU9ObVVFwFaDYpuxN
         HdRICzB6BJhcwR5BlUEOPVFkm4NIU3VJmrnFeX0RZGv8hobzx3yv2oGJiKukyKd+Wq2D
         VINTNxrR6b0bgEVQf+xWcDnrLfFO+xnq+KSopais8XFTaFZQfS0hntx0R8Y6FQgiEHr0
         fXLA==
X-Gm-Message-State: AJIora+Ddt+nz9knPyrS0vz3d54CKwNssOcuB8fNaoABwI4m3kXySuHN
        qcqKy29612zWvdCkm86pT8w3rqpi+hIMEZzqMHzcEIjHdgr+LQ==
X-Google-Smtp-Source: AGRyM1sbHm7CzbE3m7tICYA6ULjj3QBmWvxH0kjYvvtq83ZpoY/qggXvnXRvH2KYYzL4i7mjGSXCErp1YzAwweTNHjc=
X-Received: by 2002:a05:6870:b01e:b0:f1:ea32:181d with SMTP id
 y30-20020a056870b01e00b000f1ea32181dmr25531029oae.126.1655916182930; Wed, 22
 Jun 2022 09:43:02 -0700 (PDT)
MIME-Version: 1.0
References: <DB9PR04MB84779EF2842D789FA66094C380B09@DB9PR04MB8477.eurprd04.prod.outlook.com>
 <YrCXILblKsp6DuN3@sirena.org.uk> <DB9PR04MB8477CD99D5847291A629994180B09@DB9PR04MB8477.eurprd04.prod.outlook.com>
 <YrCznap77OyHu4bO@sirena.org.uk> <DB9PR04MB847785E1861525FC1E4AD97280B39@DB9PR04MB8477.eurprd04.prod.outlook.com>
 <YrHkXH1M4NydBfQT@sirena.org.uk> <DB9PR04MB84772F73D4AA1B49F87BECCF80B39@DB9PR04MB8477.eurprd04.prod.outlook.com>
 <CAA+hA=RQVRHzdy_ZpwcC-ZB8mwUYuMYu_iLNAfuPcMCS1G9WXA@mail.gmail.com>
 <YrMMzizzE7rIji5x@sirena.org.uk> <CAA+hA=SA7BY8WxrbuRAOsuHyz+bx-EJq-UT_YLW5wYMS+io+pg@mail.gmail.com>
 <YrNC3eHx7ARQy/Vd@sirena.org.uk>
In-Reply-To: <YrNC3eHx7ARQy/Vd@sirena.org.uk>
From:   Dong Aisheng <dongas86@gmail.com>
Date:   Thu, 23 Jun 2022 00:42:51 +0800
Message-ID: <CAA+hA=SHgp1jZn1Qwrcu3fMnn22aaVimS4+Y2hPcWehS4zdRoA@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] regmap: add option to disable debugfs
To:     Mark Brown <broonie@kernel.org>
Cc:     Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Peng Fan <peng.fan@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 12:27 AM Mark Brown <broonie@kernel.org> wrote:

> > > > -       WARN_ON(map->cache_bypass && enable);
> > > > +//     WARN_ON(map->cache_bypass && enable);
>
> > > What is the purpose of this change?  Why would the combination of cache
> > > only and bypass modes work be a good idea, and how should things behave
> > > in that case?
>
> > Because without this change, there will be a kernel dump caused by
> > WARN_ON when drivers call regcache_cache_only(map, true) after power
> > is off. There's no cache used in the imx blkctl driver. So map->cache_bypass
> > is default to true.
>
> cache_bypass is only going to be true if something enabled bypass, why
> would a device that doesn't use a cache enable bypass?  It does get
> turned on transiently by things like patching but those only make sense
> if the device can be accessed so caceh_only shouldn't be on then.

It was enabled by default according to the code:
__regmap_init -> regcache_init

int regcache_init(struct regmap *map, const struct regmap_config *config)
{
        int ret;
        int i;
        void *tmp_buf;

        if (map->cache_type == REGCACHE_NONE) {
                if (config->reg_defaults || config->num_reg_defaults_raw)
                        dev_warn(map->dev,
                                 "No cache used with register defaults set!\n");

                map->cache_bypass = true;
                return 0;
        }
}

Regards
Aisheng
