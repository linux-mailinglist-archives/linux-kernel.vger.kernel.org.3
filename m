Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D49346ADBA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 23:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377079AbhLFW4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 17:56:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376936AbhLFWzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 17:55:49 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E1AC0698CB;
        Mon,  6 Dec 2021 14:52:00 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id gu12so11345545qvb.6;
        Mon, 06 Dec 2021 14:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oimzPdENQiMl9fABHsD/hSKDeXpkMF2Ol/l4UxA1adI=;
        b=ZnSxnSOOzGKmCxXJJe+326847cQ2mOdjA54lgbnFe98LNn5NicUQjkv/gZmURoJlLp
         NTYXr+qtC9a0jRTDr6v8tYFex1tb/wyF/IffF4P0TmFnTK1YUUCkwDVU01sQ43ocW4Xu
         HaVXB7kET0l73RbDo/EdNjcEqKRR41U9iT1ps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oimzPdENQiMl9fABHsD/hSKDeXpkMF2Ol/l4UxA1adI=;
        b=iaiDMg+b+528aAaEAIPd8i398mkJBnElaRi52JiajD7H/CoqqcnjjW2Oca/j8fUCbX
         q35dLi3j1ByQUgrnUdhzqjTIQDqSlPfbozxkvPshLnx67HXgSDskU7ju0eIrcK4JQ375
         Xa5y2ral1gSCHUnCS36ca/k7s/L+g8kjFCzsAPT1jbaSEoct0e9Q1qAK2maIi/QDWPp4
         EtrAHGmREiqaF1y3l/460NE032OsDVuDBJK/UihEwRjtRy7vOtIoqt7U2RnSOXEp9tWN
         9w4KU1d/ocDvHxw4FyMdn7X5F5jXD3tTo04NuO32JZkOBVSaIQlDuT+UeFYn3YLRYBKK
         JgqQ==
X-Gm-Message-State: AOAM531b+lFVCr61YTNTNA72wjqAe+9hlAXlXok8hHkWB1u4gw+eH8YG
        ucJYcP+82kuHKzfLDm7QYSRy4JaVbobkwR1UI6U=
X-Google-Smtp-Source: ABdhPJwsWtljRtloMBy/nfiuFRYja1NNoa0XZcTHeRYj8LCekz6T0FBQdBLEpUwA+gpdZZ+w0JiXyKR92W4AskOR8as=
X-Received: by 2002:a05:6214:c6f:: with SMTP id t15mr41090372qvj.49.1638831119274;
 Mon, 06 Dec 2021 14:51:59 -0800 (PST)
MIME-Version: 1.0
References: <20211201033738.121846-1-howard.chiu@quantatw.com> <Ya5/v+VhOM9o9BtQ@heinlein>
In-Reply-To: <Ya5/v+VhOM9o9BtQ@heinlein>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 6 Dec 2021 22:51:46 +0000
Message-ID: <CACPK8XdCjqB+HZ_g9O=gjnSne3=iV44i6jKP5M8yWcsjnttaog@mail.gmail.com>
Subject: Re: [PATCH v6] ARM: dts: aspeed: Adding Facebook Bletchley BMC
To:     Patrick Williams <patrick@stwcx.xyz>
Cc:     Howard Chiu <howard10703049@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        SoC Team <soc@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Howard Chiu <howard.chiu@quantatw.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Dec 2021 at 21:25, Patrick Williams <patrick@stwcx.xyz> wrote:
>
> On Wed, Dec 01, 2021 at 11:37:38AM +0800, Howard Chiu wrote:
> > Initial introduction of Facebook Bletchley equipped with
> > Aspeed 2600 BMC SoC.
> >
> > Signed-off-by: Howard Chiu <howard.chiu@quantatw.com>
> >
>
> ...
>
> > Change since v2:
> > - Remove uart5 workaround
> > - Remove gpio nodes of pca9552/pca9539
> > - Modify gpio-line-name of led/power/presence pins with openbmc pattern
>
> A number of the GPIOs do not have defined openbmc patterns for them yet.  The
> names you have chosen are ok for now, but we will be changing them as we refine
> development of this machine further.
>
> > +             gpio-line-names =
> > +             "SLED0_MS_DETECT1","SLED0_VBUS_BMC_EN","SLED0_INA230_ALERT","SLED0_P12V_STBY_ALERT",
> > +             "SLED0_SSD_ALERT","SLED0_MS_DETECT0","SLED0_RST_CCG5","SLED0_FUSB302_INT",
> > +             "SLED0_MD_STBY_RESET","SLED0_MD_IOEXP_EN_FAULT","SLED0_MD_DIR","SLED0_MD_DECAY",
> > +             "SLED0_MD_MODE1","SLED0_MD_MODE2","SLED0_MD_MODE3","power-host0";
>
> Such as these...
>
> > --
> > 2.25.1
> >
>
> Otherwise,
>
> Reviewed-by: Patrick Williams <patrick@stwcx.xyz>

Thanks for reviewing.

Howard, I'm merging patches for v5.17 but I can't apply this until you
fix the warnings I mentioned.

Cheers,

Jeol
>
> --
> Patrick Williams
