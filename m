Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D02435A15DB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 17:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242823AbiHYPcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 11:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242207AbiHYPcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 11:32:05 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF143ECEE
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 08:32:03 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id m21-20020a9d6ad5000000b00638df677850so14153302otq.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 08:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=Xp1nkevgvam4evex1VBaq84Y/tlFXUGnP5SjRSPeMOU=;
        b=wmc9CsuP1JzA7LFdYsBPnZ96XWGlF56SC8pCn7lqq4c+n17qroMX6tkDUTACy17+eb
         Wu7SYnZpNwUoPpKSs+txhfxE5rbO9i1Z5RmoehBhoMAVqonbtwoJHRD7f0JWFWxD3btP
         Fv+3qMwqJhvh4MLBYs3x4Jlkcn0U8Wcz2rneIWakxdOuHcFNZ53qSIL4/LKZMaUQgmRh
         uGSPAfBdhWObwscs7+QcttAm1avFDklIp14VKKaVsub8s0icd0xpT8TeuapsYsPUSPVg
         IvDEb/glN0bIk3PLAsXsgZviTmt0i7tgV8aUp9guj87frvLtaOKXLXXRRAdcYpdfncsr
         P7eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=Xp1nkevgvam4evex1VBaq84Y/tlFXUGnP5SjRSPeMOU=;
        b=8CK4LKXtTXUiJkJJD3AhSk/q+KA1gmtUTIprZ1RYrSHCUgVlXMxGBvWkpJNKXkzI+Z
         QY/arnRCn9JQXa5Vjz/tfjUsWua7I9BGfv5VlVGmwel4U+mQ5YaZFqDapRXrqe975bDL
         oJBXY15LG5SUTgnFSnPslSoSEcap8ye9APf2MQhLRjtDE++Hnw/BI85sR8lPyunKjlEp
         RxKpiN89TvpntTNgnpPV/TmPYWxVxDiOKMK3vrrFN5KXaTaoC+Xb9DbFUsNq7WLt4rVx
         JH+rQA2e5DAaV1Ez0OS2jfDEkdRYfqUecS8TRAf4MMJMhcGo4cKVqSWZs7bYRBYntR46
         YuEg==
X-Gm-Message-State: ACgBeo1dc1pW+HtjKsJ5xyEfAgpGlNCTkhW58kGDBjTVLQZYV6ZG2Mk2
        +j5mbypccp84ulRvTkEdBrBel3YVswbz6xorwEY+Yg==
X-Google-Smtp-Source: AA6agR70yB58v6+DBzgr9+5ArdgcwJi2J1FqY/nUHA61PKWbR3vJy3rcnTlTo1vJIq2QtWMkHlSnZz3jtI5EY3FAjIs=
X-Received: by 2002:a9d:4592:0:b0:637:35cc:68e7 with SMTP id
 x18-20020a9d4592000000b0063735cc68e7mr1547028ote.355.1661441522937; Thu, 25
 Aug 2022 08:32:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220825143737.77732-1-dev@aboehler.at> <20220825150236.GB240395@roeck-us.net>
 <CA+HBbNEEvyn7a-CXzbFHywvHBky-Kwu8O3POrqo=huOJf-n2pQ@mail.gmail.com> <20220825152934.GA1439919@roeck-us.net>
In-Reply-To: <20220825152934.GA1439919@roeck-us.net>
From:   Robert Marko <robert.marko@sartura.hr>
Date:   Thu, 25 Aug 2022 17:31:52 +0200
Message-ID: <CA+HBbNH5GGrqN4mUB2hByVuTjc02f_t88pdpKEKXNjxScYyrtw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] Documentation: devicetree: update bindings for tps23861
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     =?UTF-8?Q?Andreas_B=C3=B6hler?= <dev@aboehler.at>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 5:29 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Thu, Aug 25, 2022 at 05:07:45PM +0200, Robert Marko wrote:
> > On Thu, Aug 25, 2022 at 5:02 PM Guenter Roeck <linux@roeck-us.net> wrot=
e:
> > >
> > > On Thu, Aug 25, 2022 at 04:37:36PM +0200, Andreas B=C3=B6hler wrote:
> > > > The tps23861 driver does not initialize the chip and relies on it b=
eing
> > > > in auto-mode by default. On some devices, these controllers default=
 to
> > > > OFF-Mode and hence cannot be used at all.
> > > >
> > > > This brings minimal support for initializing the controller in a us=
er-
> > > > defined mode.
> > > >
> > > > Signed-off-by: Andreas B=C3=B6hler <dev@aboehler.at>
> > >
> > > nack for the series, sorry. The suggested properties are not hardware
> > > monitoring but phy properties. There should be a separate phy driver
> > > to manage those.
> > >
> > > Also, as mentioned, the hwmon 'enable' attribute is abused to control
> > > port functionality and should be removed.
> >
> > Hi Guenter,
> > Are you referring to an ethernet PHY driver or the generic PHY framewor=
k?
> >
>
> Could be both, though ethernet phy sounds about right for me.
> I don't know where/how similar chips are handled. hwmon is most definitey
> the wrong place.

Hi,

Well, that is the thing, this is definitively not an ethernet PHY nor
a PHY of any other kind.
I dont see where it would fit if not hwmon, there is no more specific
subsystem in the
kernel.

Regards,
Robert

>
> Guenter



--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura Ltd.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
