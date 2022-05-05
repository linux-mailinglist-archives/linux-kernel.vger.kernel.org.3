Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7C851C6A7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 20:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382941AbiEESFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 14:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbiEESFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 14:05:40 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DAED4BFFC;
        Thu,  5 May 2022 11:02:00 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id be20so6073782edb.12;
        Thu, 05 May 2022 11:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9t4LNeKMgDm4bsG6VjPLo2oZxRoaM8DUvvm+HYE+R1M=;
        b=iJoOmgsIjvyuFihyonY0t0eMJ1r4WRq2au65ubOWz4svZ7uNke1xkh5TMl5Uk1C4ar
         UIY/BEIb559kc/8GA6AN2jZbtK3HJUgDyFcf8WYibLMc4HUxfjX6QN0xwUZxTH3bch5f
         TpiHeFKPDqdrDDweoPDKVkKe0H69aGPfNEBD0lxurv4GAGtssFoph6Z3LIYL2wxFRX8W
         l3guDXZ+n306XJnPKwzETB0ujHwqeVXGp3xpkZe1ZSLKJGvydMrE5OiDGzIL3LGVfVNK
         m9QhBxtqSxYy18lmWGr2EAHMM9HquaSsC1yXL1dJ2GxYlyf3YhgL6KBvi44ez6Sum4DJ
         JZ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9t4LNeKMgDm4bsG6VjPLo2oZxRoaM8DUvvm+HYE+R1M=;
        b=wQgah8rVFW4z64LJm6bBhPN3qY1qM3VtVv095jFvGPIcvZXmScdWzXyHIZgW0B/Ou+
         NFN9DzdYoEpXf+O8gPn3ePaLYEW4oxc/TLOqz4ZtQvvLdQ3nk4M6h+sb+ubb2LO59oM6
         m6lNsoBN6ZZam0pII34pso21Ro5pM6mWuS2J1795gG3YnOD/pOm6utahn239IT+/46V0
         O81rNKg0bBiPWfhu933RI93UCf0pzVVNzWRpxyKaef91/WfzOnoRa5HS6vevJ0jsCnRa
         kCclYCb6HXxqJJ27FwE7BwPxlqWhmhtIVtgIEj/uCCGOVGrFDQJ8wy23XUTqAsWAIXvh
         N/uw==
X-Gm-Message-State: AOAM531ky5YN6yM6NKCIxFxLP4u5mJgj51dSVx5WXww+1h9mHl9i/BT/
        vSbeireKuqg6uloUKKv89N9twhJjx8ot1QX3eo0=
X-Google-Smtp-Source: ABdhPJwS8lSH9jpq6E2YTDJsT+UUIAttq51sN8ZOaVxn+s/4vminCmuIhkjtgAfiFHBrFFujkBJeOKFSZV9VWi3/Zok=
X-Received: by 2002:aa7:d350:0:b0:425:e029:da56 with SMTP id
 m16-20020aa7d350000000b00425e029da56mr31711234edr.296.1651773718814; Thu, 05
 May 2022 11:01:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220504133612.604304-1-Qing-wu.Li@leica-geosystems.com.cn>
 <20220504133612.604304-4-Qing-wu.Li@leica-geosystems.com.cn>
 <CAHp75VeseZ2ChtbafmbgVavS4KvCvrQ4+XSRkeiJSyqr8__dSw@mail.gmail.com>
 <AM9PR06MB7844E8FE0EDF712C769271DAD7C39@AM9PR06MB7844.eurprd06.prod.outlook.com>
 <CAHp75VfEK_TXXA3NdGgjis7duHgoDo4aSOZntdO0wEGLw0sQ7g@mail.gmail.com> <AM9PR06MB7844C01CA580F046FA570B43D7C29@AM9PR06MB7844.eurprd06.prod.outlook.com>
In-Reply-To: <AM9PR06MB7844C01CA580F046FA570B43D7C29@AM9PR06MB7844.eurprd06.prod.outlook.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 5 May 2022 20:01:22 +0200
Message-ID: <CAHp75VcD-UpG=ppuE2Du2SsQK66MYdrwhXvjHksN5=gqcppYqA@mail.gmail.com>
Subject: Re: [PATCH V3 3/5] iio: accel: sca3300: modified to support multi chips
To:     LI Qingwu <qing-wu.li@leica-geosystems.com.cn>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Tomas Melin <tomas.melin@vaisala.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
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

On Thu, May 5, 2022 at 4:12 PM LI Qingwu
<qing-wu.li@leica-geosystems.com.cn> wrote:
> > -----Original Message-----
> > From: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Sent: Wednesday, May 4, 2022 10:39 PM
> > On Wed, May 4, 2022 at 4:35 PM LI Qingwu
> > <qing-wu.li@leica-geosystems.com.cn> wrote:
> > > > From: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > > Sent: Wednesday, May 4, 2022 10:20 PM On Wed, May 4, 2022 at 3:36 P=
M
> > > > LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn> wrote:

...

> > > > > +struct sca3300_chip_info {
> > > > > +       const struct iio_chan_spec *channels;
> > > > > +       const int (*accel_scale_table)[2];
> > > > > +       const int *accel_scale_modes_map;
> > > > > +       const unsigned long *scan_masks;
> > > > > +       const int *avail_modes_table;
> > > > > +       const int *freq_modes_map;
> > > > > +       const int *freq_table;
> > > > > +       const u8 num_accel_scales;
> > > > > +       const u8 num_avail_modes;
> > > > > +       const u8 num_channels;
> > > > > +       const u8 num_freqs;
> > > > > +       const u8 chip_id;
> > > >
> > > > Why do you have const qualifier on all members?  The last one is
> > > > understandable, but the rest, esp. pointers should be justified.
> > > Because I thought it was static and has fix value for each chip, unac=
ceptable
> > for you?
> >
> > But why const qualifier? What is the point of it for example for u8 mem=
bers if
> > the entire object is qualified as const below in the same patch?
> >
> > On top of that, please explain what in your opinion the "const ...
> > *foo" gives us, and what we will lose if we remove the "const" part out=
 of them.
>
> Ah, you are right, those const are unnecessary for nonpointer members.
> for the pointers, the contexts that the pointer points to are still writa=
ble.
> what about if I remove all the const from nonpointer and keep it for the =
pointers?
> Like=EF=BC=9A
> const struct iio_chan_spec *channels;
> const int (*accel_scale_table)[2];
> const int (*incli_scale_table)[2];
> const int *accel_scale_modes_map;
> const int *incli_scale_modes_map;
> const unsigned long *scan_masks;
> const int *avail_modes_table;
> const int *freq_modes_map;
> const int *freq_table;
> const char *name;
> u8 num_accel_scales;
> u8 num_incli_scales;
> u8 num_avail_modes;
> u8 num_channels;
> u8 num_freqs;
> u8 chip_id;
> bool angle;

It's better, but you still need to justify the rest with explanation
in the commit message.
And I leave this to maintainers to say if the const:s are needed or not.

> > > > > +       const char *name;
> > > > > +};

--=20
With Best Regards,
Andy Shevchenko
