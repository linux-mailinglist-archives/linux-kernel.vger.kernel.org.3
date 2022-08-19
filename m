Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95A0E599ACC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 13:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347745AbiHSLJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 07:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348499AbiHSLJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 07:09:48 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CFDEEF29;
        Fri, 19 Aug 2022 04:09:47 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id m3-20020a05600c3b0300b003a5e0557150so3770294wms.0;
        Fri, 19 Aug 2022 04:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc;
        bh=N1+SQP9/NNEeMXRgIAtNMNNPsYesv58EgfwcQ2TqP80=;
        b=S46/LPn6eUw1mXd3EnYZ/rw4+v9qEbEUjrviABS48ma7s69nVa0g+uQfs1Dq82slMH
         ROPd5ydcib/qy3b+5W4ga3AWw6vybxp2vbyW87dPKcyCq/cOjsPzAXb0JpPX+YEj0ktj
         0useeDJY5oMfkDLSNy86a+FO+YJrxYYB9moxcguERDTimV2ZpgyImwFjc0atukt9Ufnk
         wlLuhdovNL9TnUl95MpEcLNuLYYOMMLSMKYou97uUBsRSks5ZQw0awRYnc2MfIWrrVLp
         y4h6qdUbvKFsssLIuQfbxEb7RGPrd7czpQWA+YeKplkVYs06YBsL/vFvmg9OGKq1WXUa
         mcmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc;
        bh=N1+SQP9/NNEeMXRgIAtNMNNPsYesv58EgfwcQ2TqP80=;
        b=j86KbabbcVa+Q2Dy30OjUMcmVOvLdf1P0ZuTpL+8SvstPhcAjZEm5HPCQ+r2XHKM6e
         13ZFjiW9Zo3ariLsIplz/yNZukE8q+O93tdgPpbrSmzkoxXci11lZIjyoqAu5gPluGRl
         Rhl66WXp2alrsnFPj2JVOal9/VpZ6f7GBhrbt80CIqVW52PvsyhKkdgKhxK70JqBFEra
         BtM1ydrgnhL7aXQebN1eihq72/Xl359WdQ/jD6itRwnNsUJBeRWLhy8LKCTxl2D0Qa60
         Z2JC20RtRftp4cqdT3vsqR3svHdxERJ8DdWzSAbg+5SKsR+v+olClaPtqz1XjegtuiKG
         2Vxg==
X-Gm-Message-State: ACgBeo3lbjgwQz729DdP+2sicShiOE1iasDiI8PL+McO81e9y019IuGl
        QcYwKyQT5/fie0FDrP3Z7qI=
X-Google-Smtp-Source: AA6agR75FbIKZGPSpxBNj5h9oWPX52jL+AmyluIEK9LMg40HfqZM4n9G7Ou95KKB+qaSuE3srDGE6g==
X-Received: by 2002:a05:600c:4f05:b0:3a5:ffec:b6b with SMTP id l5-20020a05600c4f0500b003a5ffec0b6bmr7525600wmq.199.1660907385752;
        Fri, 19 Aug 2022 04:09:45 -0700 (PDT)
Received: from DreamMachine2.lan (188.red-83-35-57.dynamicip.rima-tde.net. [83.35.57.188])
        by smtp.gmail.com with ESMTPSA id a13-20020a05600c348d00b003a5dfd7e9eesm5127117wmq.44.2022.08.19.04.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 04:09:45 -0700 (PDT)
Message-ID: <269bf90a6cccb16e59f063b58f088ca6cd39c4b3.camel@gmail.com>
Subject: Re: [PATCH] iio: pressure: bmp280: fix datasheet links
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Fri, 19 Aug 2022 13:09:44 +0200
In-Reply-To: <CAHp75VeSsVD8rMz-Cj6kFovqdQQPjbH7rUXWS6paRtsBaB-Kww@mail.gmail.com>
References: <6e908cc827c70b95dae683717592aff0b003e7c9.1660606478.git.ang.iglesiasg@gmail.com>
         <CAHp75VdTZ_JYB2aYVdQTOx9QW1HPKhwYyQH-0tVCtpjHV=VcaQ@mail.gmail.com>
         <8a1f372f34be71895268e874bb3fbbf105dfabdb.camel@gmail.com>
         <CAHp75VeSsVD8rMz-Cj6kFovqdQQPjbH7rUXWS6paRtsBaB-Kww@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (by Flathub.org) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-08-19 at 13:33 +0300, Andy Shevchenko wrote:
> On Fri, Aug 19, 2022 at 1:31 PM Angel Iglesias <ang.iglesiasg@gmail.com>
> wrote:
> > On Fri, 2022-08-19 at 12:37 +0300, Andy Shevchenko wrote:
> > > On Tue, Aug 16, 2022 at 2:39 AM Angel Iglesias <ang.iglesiasg@gmail.c=
om>
> > > wrote:
> > > >=20
> > > > Updated links for BMP280 and BME280 datasheets on Bosch website.
> > >=20
> > > > Datasheet of BMP180 is no longer available on the manufacturer's
> > > > website,
> > > > changed the link to a copy hosted by a third party.
> > >=20
> > > Note, that the version is downgraded (from 12.1 to 9).
> >=20
> > Apologies, I forgot to add a note about this. Changelog on datasheet 12=
.1
> > listed
> > these three changes from version 9:
> > * Page 26: Changed document referral from ANP015 to BST-MPS-AN004-00
> > * Chapter 3.5: New equation for B3 (adds a long cast to AC1)
> > * Page 26: Updated RoHS directive to 2011/65/EU effective 8 June 2011
>=20
> Perhaps you may add this to the comment below into the code.

Will do, thanks

>=20
> > Unfortunately, I couldn't find the most updated version in good quality
> > hosted
> > in a trustworthy place.
>=20
> Me neither.
>=20
> > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>=20

Kind regards,
Angel
