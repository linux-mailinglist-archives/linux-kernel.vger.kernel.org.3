Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29EC757F86D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 05:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbiGYDEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 23:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbiGYDEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 23:04:20 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B716E11815;
        Sun, 24 Jul 2022 20:04:18 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id z12-20020a056830128c00b0061c8168d3faso7818507otp.7;
        Sun, 24 Jul 2022 20:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Z8VigLY0Qe5Wt0sZFZKdYiNrvB9gNTv3hXgFffu85uA=;
        b=MOqflB7rR3ZqnL01H7ohe3XBZx1613109J7RJPoPTINY+JuOKnZXSci6TG3zh62mmy
         dWWCSI+y3/NtaZyghCitHdrCVIQywbplElwBvkuQWhrgX8B2dAkGH/n9EdHgrZfV8RWC
         hu8FHyF+KBzGAcgxbcwEJTQRI6yvfT+84CGxqpRgxOnnwyk6RoI1Tj9gl53TcBgfM2ZH
         UVIIxLzXmmMBcuIW0shKtQ6sBZomjTakKM2z0r+d95smCxF5K+aqZuNvEn7cNXApAyjF
         p6CJkiVr/hGfT824fCHAzUoUCEuWRdfYzVCDYLD1SvzTFHSljMuOFVdOA4RTuxabXfnu
         uinA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Z8VigLY0Qe5Wt0sZFZKdYiNrvB9gNTv3hXgFffu85uA=;
        b=Hr/4u94LWaVHt+cB2fgp8RPnj384b7rB/wLP7wumKuQBWsyQyr6UMclh3Fv/Si9Pr7
         iZMT1zzA5qstdwn3oeiEQdTs7AVxKvsXa2heICk+LhTFbqUrHRzNZ74nMCYui45f0ho0
         z1lCfG3QnGHMhyjrpMQJ8zLdB1PByMmetmSct2ZFA2aQPC/Ik3q5ZlNg//cJQHjenoXR
         qust7h4Xc8wVGhULU+pcl/TgApo5Jz254RslkGrZisJRK1Y3XIUuDYzMc/NIO+VvXsRn
         Tj7E5saTfFaIYJDLuiPzGzruh5NYDzq9UdXwsQURnEGbXjnLkV6L/eMJa3a3szyUG8df
         pIIA==
X-Gm-Message-State: AJIora8HFJsDiNe4j1SkNxz9PYPm5crmT/Lqvo94MFLSMbGrMyt4nD1Q
        vrnHD+PoIMrf83iAujM2tix2n6kb/yYOReXIuvD69tEYNPg=
X-Google-Smtp-Source: AGRyM1u6r4AuoRq378KMyjaabGXzQdGYgd5B320d7a9lXJOkNe7sp0B1nsw84rJsfGSq+MeK9bCRLI1zqShQBcPqkV8=
X-Received: by 2002:a05:6830:314f:b0:61c:bc96:5a42 with SMTP id
 c15-20020a056830314f00b0061cbc965a42mr3946106ots.346.1658718257592; Sun, 24
 Jul 2022 20:04:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220721061144.35139-1-gene.chen.richtek@gmail.com>
 <20220721061144.35139-6-gene.chen.richtek@gmail.com> <0eb24b16-7837-cc79-fbb9-da8ceec72e63@roeck-us.net>
In-Reply-To: <0eb24b16-7837-cc79-fbb9-da8ceec72e63@roeck-us.net>
From:   Gene Chen <gene.chen.richtek@gmail.com>
Date:   Mon, 25 Jul 2022 11:04:05 +0800
Message-ID: <CAE+NS36b=8XXEHs94CZbvX8_LVcN9z1Fx-YyuCTCJ6TgJ_DAxQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] usb: typec: tcpci_rt1711h: Add compatible id with rt1715
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, linux-usb@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Gene Chen <gene_chen@richtek.com>,
        ChiYuan Huang <cy_huang@richtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guenter Roeck <linux@roeck-us.net> =E6=96=BC 2022=E5=B9=B47=E6=9C=8821=E6=
=97=A5 =E9=80=B1=E5=9B=9B =E6=99=9A=E4=B8=8A10:44=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On 7/20/22 23:11, Gene Chen wrote:
> > From: Gene Chen <gene_chen@richtek.com>
> >
> > Add compatible id with rt1715, and add initial setting for
> > specific support PD30 command.
> >
> > Signed-off-by: Gene Chen <gene_chen@richtek.com>
> > ---
> >   drivers/usb/typec/tcpm/tcpci_rt1711h.c | 24 ++++++++++++++++++++++--
> >   1 file changed, 22 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c b/drivers/usb/typec=
/tcpm/tcpci_rt1711h.c
> > index e65b568959e9..3316dfaeee0d 100644
> > --- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> > +++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> > @@ -17,6 +17,7 @@
> >
> >   #define RT1711H_VID         0x29CF
> >   #define RT1711H_PID         0x1711
> > +#define RT1715_DID           0x2173
> >
> >   #define RT1711H_PHYCTRL1    0x80
> >   #define RT1711H_PHYCTRL2    0x81
> > @@ -28,6 +29,7 @@
> >                           (((ck300) << 7) | ((ship_off) << 5) | \
> >                           ((auto_idle) << 3) | ((tout) & 0x07))
> >   #define RT1711H_AUTOIDLEEN_MASK     BIT(3)
> > +#define RT1711H_ENEXTMSG_MASK        BIT(4)
>
> I would suggest to drop _MASK.
>
> >
> >   #define RT1711H_RTCTRL11    0x9E
> >
> > @@ -46,6 +48,7 @@ struct rt1711h_chip {
> >       struct device *dev;
> >       struct regulator *vbus;
> >       bool src_en;
> > +     u16 did;
> >   };
> >
> >   static int rt1711h_read16(struct rt1711h_chip *chip, unsigned int reg=
, u16 *val)
> > @@ -82,8 +85,9 @@ static struct rt1711h_chip *tdata_to_rt1711h(struct t=
cpci_data *tdata)
> >
> >   static int rt1711h_init(struct tcpci *tcpci, struct tcpci_data *tdata=
)
> >   {
> > -     int ret;
> >       struct rt1711h_chip *chip =3D tdata_to_rt1711h(tdata);
> > +     struct regmap *regmap =3D chip->data.regmap;
> > +     int ret;
> >
> >       /* CK 300K from 320K, shipping off, auto_idle enable, tout =3D 32=
ms */
> >       ret =3D rt1711h_write8(chip, RT1711H_RTCTRL8,
> > @@ -91,6 +95,14 @@ static int rt1711h_init(struct tcpci *tcpci, struct =
tcpci_data *tdata)
> >       if (ret < 0)
> >               return ret;
> >
> > +     /* Enable PD30 extended message for RT1715 */
> > +     if (chip->did =3D=3D RT1715_DID) {
> > +             ret =3D regmap_update_bits(regmap, RT1711H_RTCTRL8,
> > +                                      RT1711H_ENEXTMSG_MASK, 0xFF);
>
> 0xFF -> RT1711H_ENEXTMSG
>
> > +             if (ret < 0)
> > +                     return ret;
> > +     }
> > +
> >       /* I2C reset : (val + 1) * 12.5ms */
> >       ret =3D rt1711h_write8(chip, RT1711H_RTCTRL11,
> >                            RT1711H_RTCTRL11_SET(1, 0x0F));
> > @@ -246,7 +258,11 @@ static int rt1711h_check_revision(struct i2c_clien=
t *i2c)
> >               dev_err(&i2c->dev, "pid is not correct, 0x%04x\n", ret);
> >               return -ENODEV;
> >       }
> > -     return 0;
> > +     ret =3D i2c_smbus_read_word_data(i2c, TCPC_BCD_DEV);
> > +     if (ret < 0)
> > +             return ret;
> > +     dev_info(&i2c->dev, "did is 0x%04x\n", ret);
>
> Unnecessary noise. If needed for testing, please make it dev_dbg.
>
> > +     return ret;
>
> I think it would make sense to pass chip as parameter and set chip->did h=
ere.
>
> Also, validation is missing. This function is supposed to check/validate
> revision data, but it just accepts all DIDs. Then later DID values are us=
ed
> to distinguish functionality. At the same time, the new device ID and OF
> compatible strings are not used for that purpose and thus have no real va=
lue.
>
> Since there can be chips with different DIDs which require different func=
tionality,
> DID values should be validated, and only chips with supported DIDs should=
 be
> accepted. Also, since there are separate device IDs and devicetree compat=
ible
> properties, the DIDs associated with supported chips should be referenced=
 there.
>
> Thanks,
> Guenter
>

ACK, I will add RT1711H_DID, and check did in order to only support
for rt1711h and rt1715.

The difference between RT1711H and RT1715 is that whether PD3.0 is
supported and rx dead zone workaround setting.
PD3.0 is set in pd_version of typec_caps which is fixed while calling
tcpm_register_port.
Therefore, the data of struct of_device_id isn't needed. Should I just
remove the compatible name "rt1715"?

> >   }
> >
> >   static int rt1711h_probe(struct i2c_client *client,
> > @@ -265,6 +281,8 @@ static int rt1711h_probe(struct i2c_client *client,
> >       if (!chip)
> >               return -ENOMEM;
> >
> > +     chip->did =3D ret;
> > +
> >       chip->data.regmap =3D devm_regmap_init_i2c(client,
> >                                                &rt1711h_regmap_config);
> >       if (IS_ERR(chip->data.regmap))
> > @@ -315,6 +333,7 @@ static int rt1711h_remove(struct i2c_client *client=
)
> >
> >   static const struct i2c_device_id rt1711h_id[] =3D {
> >       { "rt1711h", 0 },
> > +     { "rt1715", 0 },
> >       { }
> >   };
> >   MODULE_DEVICE_TABLE(i2c, rt1711h_id);
> > @@ -322,6 +341,7 @@ MODULE_DEVICE_TABLE(i2c, rt1711h_id);
> >   #ifdef CONFIG_OF
> >   static const struct of_device_id rt1711h_of_match[] =3D {
> >       { .compatible =3D "richtek,rt1711h", },
> > +     { .compatible =3D "richtek,rt1715", },
> >       {},
> >   };
> >   MODULE_DEVICE_TABLE(of, rt1711h_of_match);
>
