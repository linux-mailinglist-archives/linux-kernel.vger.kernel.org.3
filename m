Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 178AF4B194E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 00:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345577AbiBJXRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 18:17:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345151AbiBJXRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 18:17:48 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8878FB37;
        Thu, 10 Feb 2022 15:17:48 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id c15so10144902ljf.11;
        Thu, 10 Feb 2022 15:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YBwbR1kfaUcjXLL/JErsVbZh7K8KaPOAlgJd4IsVbZo=;
        b=itgm2BhEwvfTMxc68Ux/piIvgdWhkdxG8vl3df2oj1msFZ1ZWlT380bgQlANY7Mh2h
         X+WycdEPITqd/4zalr0KJUbSHM9QHNSRi5PDh22MaqADuCJPXuuFLkQYgC9pxGmevmXx
         6XTvJ/x6k/mccGMSOLo00J13yAhAsQJE+/BadNPoSXU6etZP6QSpsUMKqdAzIicJ3KGm
         jyNEG1Jef6PsWZvWEZxd2KD8f+KmEgOJxVyMQtZLTg2iqtpdx8sI1U0yjBoZ+bidhCHK
         ocpokCe+ehBN6c2rH8Jr0g2qFFzKmJcKQxe3Finci59H1cRoUwn8ptuDCFmarrgNCUfR
         neWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YBwbR1kfaUcjXLL/JErsVbZh7K8KaPOAlgJd4IsVbZo=;
        b=sILqZ72fdd+ybUG+g9/zF70gmxN8lr/TX23WXd44haeKjf2tf9zgwuglB2LnESF7ZW
         eFGWP5/nANH38CO6+tEy9U4O2Ao+mBy3QGusNXhpTsMUyWdbg2WBaYwkJbyXS6JwbzFz
         rkj+O8UydqpJZiMRQIZ17OtXqGztnjYzpbZjLYs8ioOc4ZpgdFpTsuLMnUf0HswQaAUX
         Qwg4lZej0WntUeT+SwXQPpoQHOArVfUWGbbSqwoDesGJ9Qw7vRBhyCizzQp3ka1b5sFf
         Flp53Pu2xOVCUcmu0emT7tMKvKLQZTKqLEP3pmCFnOcbyx9Yge9DmZ16NFpVnO8SPUgQ
         f0PQ==
X-Gm-Message-State: AOAM5304YQlH+Di02KvOUGlPSq2AVBSGaX3UwuQO6ZW59BwNAl+Xz7iI
        zo5sV9LI83A6RvlIVh1j4FA=
X-Google-Smtp-Source: ABdhPJxyjKx22xANHqMYIJ2sFOBupzDvlwNvb6SN7kz1mlL+wLImv7HdWxxuq50N7/N+BbwlDuR98w==
X-Received: by 2002:a2e:878f:: with SMTP id n15mr6321873lji.159.1644535066762;
        Thu, 10 Feb 2022 15:17:46 -0800 (PST)
Received: from dimatab (109-252-138-165.dynamic.spd-mgts.ru. [109.252.138.165])
        by smtp.gmail.com with ESMTPSA id f30sm1433412lfj.112.2022.02.10.15.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 15:17:46 -0800 (PST)
Date:   Fri, 11 Feb 2022 02:17:39 +0300
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Julius Werner <jwerner@chromium.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh@kernel.org>, linux-tegra@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v5 3/9] dt-bindings: memory: lpddr2: Add revision-id
 properties
Message-ID: <20220211021739.14f3614c@dimatab>
In-Reply-To: <CAODwPW-VfbvWs3OVON1m=WWFXN2V86o9jqurVDShpfTrSn=Mkw@mail.gmail.com>
References: <20211006224659.21434-1-digetx@gmail.com>
        <20211006224659.21434-4-digetx@gmail.com>
        <YWimShkkxkR+bQLK@robh.at.kernel.org>
        <CAODwPW-2othAhTC9a_joBdHScA86iqs-FkZJZDrK5LxrJm8F8Q@mail.gmail.com>
        <d69f99ed-75a4-9b8c-addb-3eaa2b2be6a6@canonical.com>
        <CAODwPW-AMqQ+ZbnvUTuxP5Bbxdcy08GSXnhcLC+V6BW=OPYaqg@mail.gmail.com>
        <6568fd31-113f-1581-4eff-45a4a1eb4e5d@canonical.com>
        <c33c9de2-ff0f-0ba7-b424-728d316dcca2@gmail.com>
        <CAODwPW-VfbvWs3OVON1m=WWFXN2V86o9jqurVDShpfTrSn=Mkw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D0=92 Wed, 9 Feb 2022 16:32:25 -0800
Julius Werner <jwerner@chromium.org> =D0=BF=D0=B8=D1=88=D0=B5=D1=82:

> > I don't mind, but I also don't see where the revision-id property of
> > LPDDR3 is used at all. I can't find any device-tree with LPDDR3
> > revision-id and don't see it being used in the code either. Maybe
> > it's the LPDDR3 binding that needs to be changed? =20
>=20
> We are using the revision ID in userspace (read through
> /proc/device-tree) for runtime memory identification. We don't have a
> kernel driver bound to it. Our boot firmware is inserting this value
> at runtime into the FDT (that's basically the reason we have this, our
> firmware auto-detects memory during boot and we use the FDT to report
> what it found to userspace), that's why you can't find it anywhere in
> the static device trees in boot/dts/.

Thank you for the clarification. Which device is that and why userspace
needs to know so much about memory?

> > I made each LPDDR2 revision-id property to correspond to a
> > dedicated MR of LPDDR, which feels okay to me to since it matches
> > h/w. =20
>=20
> I'm not super married to my solution, so if that makes things easier
> we can standardize on the two-property version as well. I mostly
> designed it my way because I thought we may one day also want to do
> something like this for the 8-byte LPDDR5 serial-id, and then it would
> get kinda cumbersome to have serial-id1 through serial-id8 all as
> separate properties. But that's also a bridge we can cross when we get
> there.
>=20
> My use case is in a position where we could still change this now
> without requiring backwards-compatibility. Krzysztof, would you be
> okay if I instead changed the "jedec,lpddr3" to the same thing
> "jedec,lpddr2" does -- seeing as the original patch was from me, my
> use case could handle the switch, there has never been any actual
> kernel code using the property, and it seems very unlikely that anyone
> else has silently started using the same thing in the time it's been
> in the tree? Or do we also need to go the official deprecation route
> for that?

If you're going to use multiple cells for other properties, then indeed
will be better to keep it consistent.

