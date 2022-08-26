Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B4A5A2C08
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 18:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242414AbiHZQLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 12:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbiHZQLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 12:11:15 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4EEAC26E;
        Fri, 26 Aug 2022 09:11:10 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id b9so1470142qka.2;
        Fri, 26 Aug 2022 09:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=hUZ/i8qZ4uBMnmjSLX55Poh2FuPd4rO6x4KjLMimiTU=;
        b=JbTsaEdoOtC7MMTlIebUwBUK0RGInSTlHucQtqu0MavdkPv9YjznVyDsiEguqCgGPZ
         4e8tMZNQ/8Q3m8U3CfaKu8d65xNOb/L655Vn084qpG47pAVz3coz1vaPdDTeHa/cV5gp
         9cpPqx4WWCi8N+QmicbcsMTEUSCeVDtW1Dkw3r0cauw4LRWDJ2tO6rgXkiNk4QhTWuwu
         ml30y9DUkXyKP+W+c0yd+fU4Wac9V6GaY46ZOLvdG/thJQ4gSpDDvM5ax7Ytkw9v7O47
         TXoCZP99ctTS4oENZeWo19MrtxnNsOgHjrb+sjR2WdgPi5SQ1VJu7PmBJxsQN/w5Kh0N
         fOdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=hUZ/i8qZ4uBMnmjSLX55Poh2FuPd4rO6x4KjLMimiTU=;
        b=L0OjDyElkm4mGpqWS2Vcpm1OzkfCYl+JZMeN69aftRUE1DqwYyLczfCYNN9WK8C6TN
         uZJ56CEEZnuknI8dLjD7po9Qm/ansG20SqigxIfxk79Zu+p3iJPqGve42UCqpnMKTMYr
         NIo5Z76E6Kj/yGVdu5RY+gkKAM5V8YYdoI6562xw2VqdEFTHQM/MlJFoKewUkK59A6Gy
         bMrAFzLD+XUORsbM4F1PU5YgHWeoGarPLj2p25xdUQOh1Y9Xk5R29EjvJQPl3jzkUZg7
         /eQjdUEu/fPN/e9zpUaooszmI697Mej/MliGXiNPjIeyWTRJmOmWrHAPxh8VYI97vjjF
         +E3Q==
X-Gm-Message-State: ACgBeo3nqDRM3Ec0diMBlkwFYV203EOrm/EBJd64UDrtN3bHOpK3qQRd
        9rsT620dR9fNEX1bUnhSS1j2ivqdWFHmlz6oX7D/RRJeTZk=
X-Google-Smtp-Source: AA6agR5xFD0+4HiZewaXqQoEKR2gi2JWLNamkPELLfKvjkwS9GWLT/0oVdZ1mbJ2nxWTKwgXKedVpUDm5oZUPIdsKdY=
X-Received: by 2002:ae9:e311:0:b0:6ba:e711:fb27 with SMTP id
 v17-20020ae9e311000000b006bae711fb27mr339089qkf.320.1661530269675; Fri, 26
 Aug 2022 09:11:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220825144012.24a33bb0@endymion.delvare> <CAHp75VeSgmO_=mXVR4uSpbQDO8MBGZu4O2vLEqunHYuoPfJbbQ@mail.gmail.com>
 <20220826124603.4a28a154@endymion.delvare> <CAHp75VcGopXaksmvXP_vMM-iGK0o_g5Fw_F5zvH+PXcCUx_cDQ@mail.gmail.com>
 <20220826180609.01262f0a@endymion.delvare>
In-Reply-To: <20220826180609.01262f0a@endymion.delvare>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 26 Aug 2022 19:10:33 +0300
Message-ID: <CAHp75VfP-5-MPJs81denx9MT_MY_gi_QXkYqm63FY2sK+Kykcg@mail.gmail.com>
Subject: Re: [PATCH] iio:accel:dmard06: Optimize when CONFIG_OF isn't set
To:     Jean Delvare <jdelvare@suse.de>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
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

On Fri, Aug 26, 2022 at 7:06 PM Jean Delvare <jdelvare@suse.de> wrote:
> On Fri, 26 Aug 2022 18:18:20 +0300, Andy Shevchenko wrote:
> > On Fri, Aug 26, 2022 at 1:46 PM Jean Delvare <jdelvare@suse.de> wrote:
> > > therefore of_match_ptr() should be
> > > removed from the kernel entirely?
> >
> > (...) But for some cases it still
> > makes sense: platform is known to never be non-OF, component is known
> > to be used only on such platforms, etc.
>
> Well, I can't see the value of of_match_ptr() in such case either. In
> fact I've submitted a couple patches to remove such occurrences lately:
>
> https://patchwork.kernel.org/project/linux-mediatek/patch/20220730144833.0a0d9825@endymion.delvare/
> https://patchwork.kernel.org/project/linux-pm/patch/20220804135938.7f69f5d9@endymion.delvare/

They are different to what we are discussing here, but yes, in common
denominator the of_match_ptr() is useless in almost 100% cases.

-- 
With Best Regards,
Andy Shevchenko
