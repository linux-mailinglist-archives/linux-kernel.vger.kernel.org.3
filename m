Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3684E920D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 11:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240072AbiC1J4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 05:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237730AbiC1J4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 05:56:04 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39B84D9F7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 02:54:24 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id f10so3998703plr.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 02:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vFzI/UO9S/7amXxoLgmYKGJ5Mev3LOFubNmP39fe8tI=;
        b=TMsLXfqkJdT1zPna/+HAShg++nN7DF7jJsTb4VSpRixOLRQlZax4SyZ7cooc+dbQYe
         orGkB0WXzAlWV7F4OPxRZXYgHqfUTKcknBVkKAAuf2d9C/jlrBTdts44nY1DbCvGQeEw
         RC5EpqZrVDJZhtoIObQClGHZCBXF+6id6SNJXNrMSrm/DyX+x18EJsWZGJy5TFH+UfTf
         iChpKdFEi5ou2S9mJcO6vPOVA5oanURTWuqUonvz4cD5eN1M6E2VeQfGPXVSk3rw0rvB
         5xoWqBTBxtsRUtq8/mpn7vfw7cDLnABFHLo0Zx+yepOjfPFi1C0RWkAkZHuOwmTRcVU8
         eRzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vFzI/UO9S/7amXxoLgmYKGJ5Mev3LOFubNmP39fe8tI=;
        b=I4lUmYW72jot//vrO4VGCqNa1TQOghU2ozAVH836uIgKWZwj5P5DcCXRaq1BJCOiK+
         yDRaDshVBYU7caONd5uyYIsh/C9ePgJ0JQ1c9JRTjdXe8YRHpfpdf4YSTzl+t3zx2pqA
         2mTSK/zNfHPdf2J0IR9R0NfYXDpwB/pxVzrBFCewBdWkBCoI0maHrr1fKIPEUypOJRTD
         jZ7XWIuI+LQMKhCa+GHHBx06NC4ZjJfcQMYZR013wkJEdZn5rPV6NnKUgev6G7BklKJd
         TSrtYE1QwKu0heAxmiTOQWA6GZ8pfoengMVr8tKbuV4Kd93p4OB5BGjLBjcT0cCQ/XrX
         cI7A==
X-Gm-Message-State: AOAM530qs1O8xenV0M1bdCJ7mtp8/Ub65+eb6W2qaBRIkyD6fkb5wvtx
        xuYLPiXBo1JAH7evvGi+L2Of2/AtcaKmgMHUkVqdeQ==
X-Google-Smtp-Source: ABdhPJzbwvWS4Ya4eSWLbt3jj91/xcjC8ySl3W6dm7vJZUIPTR+YYZCh59b57AISL/1wZWV+X0VTOrH7gRzWttv8tKI=
X-Received: by 2002:a17:902:9301:b0:153:2252:44ea with SMTP id
 bc1-20020a170902930100b00153225244eamr25086369plb.65.1648461263991; Mon, 28
 Mar 2022 02:54:23 -0700 (PDT)
MIME-Version: 1.0
References: <20211105031904.2641088-1-xji@analogixsemi.com>
 <20211105031904.2641088-3-xji@analogixsemi.com> <YiTruiCIkyxs3jTC@pendragon.ideasonboard.com>
 <YiWiYpEfTOOqgyAN@google.com> <CAG3jFys-BYsBp07AAFQ2O_TFsXOwhcVDnsOh8WVNNSag3HZw+Q@mail.gmail.com>
 <CAG3jFyu47cv8oSecONM95KVoP=NOvgwafAp4TQ33CZ0Y4zWmnQ@mail.gmail.com> <20220321115226.GA1484106@anxtwsw-Precision-3640-Tower>
In-Reply-To: <20220321115226.GA1484106@anxtwsw-Precision-3640-Tower>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Mon, 28 Mar 2022 11:54:12 +0200
Message-ID: <CAG3jFysvDa2FS3NS6f2sXAid_TmrXyb9vCADN87v=mJ-txGp0A@mail.gmail.com>
Subject: Re: [PATCH v12 3/4] drm/bridge: anx7625: add MIPI DPI input feature
To:     Xin Ji <xji@analogixsemi.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, a.hajda@samsung.com,
        narmstrong@baylibre.com, dan.carpenter@oracle.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        sam@ravnborg.org, pihsun@chromium.org, tzungbi@google.com,
        maxime@cerno.tech, drinkcat@google.com, hsinyi@chromium.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        bliang@analogixsemi.com, qwen@analogixsemi.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, Chen-Yu Tsai <wenst@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > > > -   DRM_DEV_DEBUG_DRIVER(dev, "found dsi host node.\n");
> > > > > > +   bus_type =3D V4L2_FWNODE_BUS_TYPE_PARALLEL;
> > > > > > +   mipi_lanes =3D MAX_LANES_SUPPORT;
> > > > > > +   ep0 =3D of_graph_get_endpoint_by_regs(np, 0, 0);
> > > > > > +   if (ep0) {
> > > > > > +           if (of_property_read_u32(ep0, "bus-type", &bus_type=
))
> > > > > > +                   bus_type =3D 0;
> > > > > > +
> > > > > > +           mipi_lanes =3D of_property_count_u32_elems(ep0, "da=
ta-lanes");
> > > > > > +   }
> > > > > > +
> > > > > > +   if (bus_type =3D=3D V4L2_FWNODE_BUS_TYPE_PARALLEL) /* bus t=
ype is Parallel(DSI) */
> > > > >
> > > > > This is not correct *at all*. V4L2_FWNODE_BUS_TYPE_PARALLEL has n=
othing
> > > > > to do with DSI. DSI stands for Digital *Serial* Interface. If any=
thing,
> > > > > the V4L2_FWNODE_BUS_TYPE_PARALLEL type would map better to DPI, e=
ven if
> > > > > it's not an exact match.
> > > > >
> > > > > This patch has landed in v5.17-rc1, along with the corresponding
> > > > > bindings. As DT bindings are an ABI, we should really fix this be=
fore
> > > > > v5.17 is released. There is no DSI bus types defined in DT, and a=
dding
> > > > > one as a fix so late in the v5.17-rc cycle seems a bit of a stret=
ch to
> > > > > me (unless Rob disagrees).
> > > > >
> > > > > It would seem best to revert this series and the corresponding bi=
ndings,
> > > > > and retry in v5.18.
> > > >
> > > > There is a DT patch using this property that is already queued up f=
or 5.17
> > > > in the soc tree:
> > > >
> > > > https://nam10.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2=
Flore.kernel.org%2Fall%2F20220214200507.2500693-1-nfraprado%40collabora.com=
%2F&amp;data=3D04%7C01%7Cxji%40analogixsemi.com%7C69542695a9cd42cff5a508da0=
0ea7baa%7Cb099b0b4f26c4cf59a0fd5be9acab205%7C0%7C0%7C637823304343387964%7CU=
nknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLC=
JXVCI6Mn0%3D%7C3000&amp;sdata=3DKbitBhnvGWfpHu6PNLUmrgdqcoZbXaA3hGwq9iAjQfI=
%3D&amp;reserved=3D0
> > > >
> > > > merged here:
> > > >
> > > > https://nam10.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2F=
git.kernel.org%2Fsoc%2Fsoc%2Fc%2F32568ae37596b529628ac09b875f4874e614f63f&a=
mp;data=3D04%7C01%7Cxji%40analogixsemi.com%7C69542695a9cd42cff5a508da00ea7b=
aa%7Cb099b0b4f26c4cf59a0fd5be9acab205%7C0%7C0%7C637823304343387964%7CUnknow=
n%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI=
6Mn0%3D%7C3000&amp;sdata=3DYJAs0IPxR0hrHpGR7K00itcTIF9cnz4L4ta%2B9ACQdSk%3D=
&amp;reserved=3D0
> > > >
> > > > We will need to revert that one as well.
> > >
> > > I just submitted a series reverting the dt-binding change + the
> > > related commit to "mt8183: jacuzzi".
> > > Can I get a quick r-b/a-b in order to get this into v5.17.
> > >
> > > https://nam10.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fl=
ore.kernel.org%2Fall%2F20220307154558.2505734-3-robert.foss%40linaro.org%2F=
&amp;data=3D04%7C01%7Cxji%40analogixsemi.com%7C69542695a9cd42cff5a508da00ea=
7baa%7Cb099b0b4f26c4cf59a0fd5be9acab205%7C0%7C0%7C637823304343387964%7CUnkn=
own%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXV=
CI6Mn0%3D%7C3000&amp;sdata=3DS5ScH2jid3ZRobvO%2Fl2nVgdOvFHNj1nWafTQYG3L9d0%=
3D&amp;reserved=3D0
> > >
> >
> > v2 of revert submitted.
> >
> > https://nam10.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flor=
e.kernel.org%2Fall%2F20220308094911.2680291-1-robert.foss%40linaro.org%2F&a=
mp;data=3D04%7C01%7Cxji%40analogixsemi.com%7C69542695a9cd42cff5a508da00ea7b=
aa%7Cb099b0b4f26c4cf59a0fd5be9acab205%7C0%7C0%7C637823304343387964%7CUnknow=
n%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI=
6Mn0%3D%7C3000&amp;sdata=3DD6ulS16g4v4x0u23OtYRrSeitTqllWwDzPiT%2BxMcQQg%3D=
&amp;reserved=3D0
> >
> > Xin: Will you spin a series that adds DPI support and re-enables DPI
> > for anx7625? Additionally, "mt8183: jacuzzi" will have to have DPI
> > re-enabled.
> Hi Robert Foss, I'm little confused, do I need resend this serial or
> send a patch based on currently define(V4L2_FWNODE_BUS_TYPE_PARALLEL)?
>
> And use V4L2_FWNODE_BUS_TYPE_PARALLEL for DPI, other value for DSI
> setup?

V4L2_FWNODE_BUS_TYPE_PARALLEL is not meant to be used for DPI, but
rather is used to represtent CPI. So another enum (something along the
lines of V4L2_FWNODE_BUS_TYPE_DPI) needs to be defined, and then this
series needs to use this new enum.

I'd like to see the following:
 - Introduction of V4L2_FWNODE_BUS_TYPE_DPI
 - Reworking this series to use V4L2_FWNODE_BUS_TYPE_DPI
 - Reworking "mt8183: jacuzzi" to use V4L2_FWNODE_BUS_TYPE_DPI

Does that make sense?


Rob.
