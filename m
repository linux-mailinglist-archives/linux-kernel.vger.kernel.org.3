Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 585E94D66FE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 18:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350493AbiCKRB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 12:01:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237446AbiCKRB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 12:01:57 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A851E4EA19;
        Fri, 11 Mar 2022 09:00:54 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id t5so8337703pfg.4;
        Fri, 11 Mar 2022 09:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EHaG9nWRlLaw6yB3xb7CSc3W36oXMnwjPEKkW41dEDQ=;
        b=Y0hY/Xvu6jmOAvcndI/MOgflznvOdJQxrYLluU6H7H3OAwG1AfgjQ+jso9h8st2w5A
         WePPeAQG/rD29JvYX8MNfBGYb5UdN/J1ykrzJRJw4AiW/4p8cl6bWAtXHu/9kDJ60cWS
         6v31OAeES1WHTyyaXjESgSrDoUtDVWVsd7zJbnBJKfAOQvi/kSqiwwaiCCmIlT6rokA+
         J9oTY8v5pfE5c44Nq4W3QspJBHZ1dHo9wOEQrDPm+tbaP07xq0+5c3suJDkPbRpcCAfX
         4lVKlgXHOJBgXhw9+BkgFg54VsPlk2bUMHTekbQCaDkBB1aehTqj3ouNELDLevNyTfpJ
         ew+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EHaG9nWRlLaw6yB3xb7CSc3W36oXMnwjPEKkW41dEDQ=;
        b=yHNR225ee1xxCpi/dW1HvIhLIntF3sgBFzea/uCt0Hwn91TSUio13VONGAlfPhZE8a
         Tct5gMIeFgduQ16NbQupDQxzA5LMeorEMAY/1bfMFqLfMEfgeCXpqbT9DrYNREAMyYF1
         1M6d5hXczGD0BkO4X+QED0/GBjzV+ZMbYe5QU0CJJV2OlPaRerYUE8YzO6upPG8TM6jy
         VoeOwLi+ZSbd/3EjGnW6KKA45n/WuYHA11zCcpz//HNgiLSYHVdoA/qoXBiO5t/sKieH
         uhVLjCEJ0fb1f/bewk/BZf+Ekf8a1ePBiIICtVcNityIbkm8R60h4HzzTQWfnDD/7tq+
         4qBA==
X-Gm-Message-State: AOAM533MwFWgP4o4iIYBfe5NEtA8ixyPo+nnnb2BXGoj1t/xjB1GfXYi
        qwlTcTzF0HmAC7f6lCioV0LZ+DhSi9E+BYGFjePOthfQVok=
X-Google-Smtp-Source: ABdhPJz3vwUydJutGEzbm5Giy2dHerMp0mVgpZFL2g963E9F44+jEU9tjdf9RbIrbVG6NhwS+f4gmeaWzibR/QgB8ig=
X-Received: by 2002:a05:6a00:2444:b0:4f7:71bd:892 with SMTP id
 d4-20020a056a00244400b004f771bd0892mr10004535pfj.81.1647018054130; Fri, 11
 Mar 2022 09:00:54 -0800 (PST)
MIME-Version: 1.0
References: <20220311120453.163297-1-cbranchereau@gmail.com>
 <20220311120453.163297-5-cbranchereau@gmail.com> <YitjvmxpKHARVcYk@robh.at.kernel.org>
In-Reply-To: <YitjvmxpKHARVcYk@robh.at.kernel.org>
From:   Christophe Branchereau <cbranchereau@gmail.com>
Date:   Fri, 11 Mar 2022 18:00:41 +0100
Message-ID: <CAFsFa87t_YrNP3LQs8Ft2JKfOpCPQ7-5jLV13zL4m4p4WoZSwg@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] dt-bindings: display/panel: Add Leadtek ltk035c5444t
To:     Rob Herring <robh@kernel.org>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
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

Hi Rob,

Sorry something I can't explain happened with git rebase

v4 on its way

On Fri, Mar 11, 2022 at 3:59 PM Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Mar 11, 2022 at 01:04:53PM +0100, Christophe Branchereau wrote:
> > Add binding for the leadtek ltk035c5444t, which is a 640x480
> > mipi-dbi over spi / 24-bit RGB panel based on the newvision
> > NV03052C chipset.
> >
> > It is found in the Anbernic RG350M mips handheld.
> >
> > Signed-off-by: Christophe Branchereau <cbranchereau@gmail.com>
> > ---
> >  .../display/panel/leadtek,ltk035c5444t.yaml   | 59 +++++++++++++++++++
> >  1 file changed, 59 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/display/panel/leadtek,ltk035c5444t.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/display/panel/leadtek,ltk035c5444t.yaml b/Documentation/devicetree/bindings/display/panel/leadtek,ltk035c5444t.yaml
> > new file mode 100644
> > index 000000000000..9e728f8ce0cd
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/panel/leadtek,ltk035c5444t.yaml
> > @@ -0,0 +1,59 @@
> > +# SPDX-License-Identifier: GPL-2.0
>
> Why did you change the license? It was correct before.
>
> Rob
