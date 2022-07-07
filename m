Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9767C569B66
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 09:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234948AbiGGHR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 03:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234837AbiGGHRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 03:17:46 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7223190F;
        Thu,  7 Jul 2022 00:17:42 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id t24so29650480lfr.4;
        Thu, 07 Jul 2022 00:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ONQyd7NlYpKbAArBY2tce3c9kK6yCgRvojd8mJ0QPWM=;
        b=D4FZuNO00PIIYIrtVUwN0Jw9D+og6xzZ5eC2wt+arZJFc9tl/NTMMp/dayl1SAXrFx
         aRJbTgeC2dWWQgWSgcwOBrZRMtm5VXIKzbE9iRM8RavlAl5uAqdCJUD7mhWH5WrF9Xdb
         EXQ9C59Iz422r0lJhQYvZR9XtM/e6WvksN1ny5RMp7oyqUajMbzPYQWqNILcVpCGKbH0
         ua7VA+feeD7BgaDqIvxn32zlw8GRp3EDZR1xUhzHmH85f0JTF8GhT9h4HuFwmKjYDUBw
         62idmmBzoYNYcIynoKoRNS5+IOCPPxLyJ6Tqz5hJSWOWuKZODtWa/HDZPoFNeQT35XVI
         1W6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ONQyd7NlYpKbAArBY2tce3c9kK6yCgRvojd8mJ0QPWM=;
        b=zXTyNFk5qnAibKpOhBEq4QrTXqP8z+DbZtc6d4Rc4ppbIdn9RINqhWIBTTSDMi5Tid
         V70Tsu20CQZxmxFrF3Z1rOyTQaZZJlBzP/xQr4R2vXGihhnPVS4x+FW1mPWNBnu/6h8I
         X3aJzNVCCIMybx5Npu/vcGlMINamMJNoslJ+fqrPKqHpvLctK9d8m2LXBeR7ugRHVzrE
         T5po0ESXafcWVvVF8j+F52jILz3r3Zc+ElJlYrNzs9Nr78RsifxFQWliG5P2dwwcJ/PG
         H9YUAWYyMC360fPM0gCofyZ0ZJUN7UaKHn902hbt5lNwpFlfGe+aFI+VO2m6T8E3B/kS
         kPlw==
X-Gm-Message-State: AJIora9kPOj1lDcX/NI0P2SHLvUchC6JpeQ89aaFp/bRsL0cARRX7S8/
        Fy1UT5ypJxn4hdvncOVULqG8ummkiBHmIZ5x330=
X-Google-Smtp-Source: AGRyM1s0WLQMMzuJVlNNNN8nWTFiJzCRTe1dFFznk1mABU/V0XTnC+ZF2++r2fHbBpyWA1K8Kghqnr6Iv2g7BNtLvNw=
X-Received: by 2002:a05:6512:3f18:b0:47f:797b:4d6 with SMTP id
 y24-20020a0565123f1800b0047f797b04d6mr30733534lfa.356.1657178259768; Thu, 07
 Jul 2022 00:17:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220527084647.30835-1-ctcchien@nuvoton.com> <20220527084647.30835-4-ctcchien@nuvoton.com>
 <YrYd+FkiFPz84twJ@mail.local> <CAHpyw9cdmCSZEE4ZbpnehpyvFhpPWA+_E5zXzJerNX9xqYet5Q@mail.gmail.com>
In-Reply-To: <CAHpyw9cdmCSZEE4ZbpnehpyvFhpPWA+_E5zXzJerNX9xqYet5Q@mail.gmail.com>
From:   Mining Lin <mimi05633@gmail.com>
Date:   Thu, 7 Jul 2022 15:17:28 +0800
Message-ID: <CAL3ZnpzSm7f1L2MMuDr9_vg3TQuk3PSr46fwmJTMz4sA2sdCJg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] RTC: nuvoton: Add NCT3018Y real time clock driver
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Benjamin Fair <benjaminfair@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Patrick Venture <venture@google.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, a.zummo@towertech.it,
        KWLIU@nuvoton.com, YSCHU@nuvoton.com, JJLIU0@nuvoton.com,
        KFTING <KFTING@nuvoton.com>, ctcchien@nuvoton.com,
        Medad Young <medadyoung@gmail.com>,
        CS20 MYLin1 <mylin1@nuvoton.com>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Alexandre,

Thank you for your comments.
I will refine and reply below.

Thanks.
Best Regards,
Mia

Medad Young <medadyoung@gmail.com> =E6=96=BC 2022=E5=B9=B47=E6=9C=887=E6=97=
=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=881:31=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Hello Alexandre,
>
> Thanks for your comments.
> I add Mining Lin <mimi05633@gmail.com> into this mail thread,
> and she is going to follow up this RTC driver.
> She will be in charge of maintaining this driver.
>
> Alexandre Belloni <alexandre.belloni@bootlin.com> =E6=96=BC 2022=E5=B9=B4=
6=E6=9C=8825=E6=97=A5 =E9=80=B1=E5=85=AD =E5=87=8C=E6=99=A84:26=E5=AF=AB=E9=
=81=93=EF=BC=9A
> >
> > Hello,
> >
> > Please run ./scripts/checkpatch.pl --strict on your patch, there are a
> > bunch of issues.
> >
[Mia] I will run ./scripts/checkpatch.pl --strict on my patch to fix issues=
.

> > On 27/05/2022 16:46:47+0800, medadyoung@gmail.com wrote:
> > > +static int nct3018y_set_alarm_mode(struct i2c_client *client, bool o=
n)
> > > +{
> > > +     int err, flags;
> > > +
> > > +     dev_dbg(&client->dev, "%s:on:%d\n", __func__, on);
> > > +
> > > +     flags =3D  i2c_smbus_read_byte_data(client, NCT3018Y_REG_CTRL);
> > > +     if (flags < 0) {
> > > +             dev_err(&client->dev,
> > > +                     "Failed to read NCT3018Y_REG_CTRL\n");
> >
> > You should cut down on the number of error messages, they are usually
> > not useful as the user doesn't have any specific action after getting
> > one of them apart from trying the action once again. Also, this will
> > make your code shorter. dev_dbg is fine.
> >
[Mia] I will modify dev_err to dev_dbg if there is an error and nothing to =
do.

> > > +/*
> > > + * In the routines that deal directly with the nct3018y hardware, we=
 use
> > > + * rtc_time -- month 0-11, hour 0-23, yr =3D calendar year-epoch.
> > > + */
> > > +static int nct3018y_rtc_read_time(struct device *dev, struct rtc_tim=
e *tm)
> > > +{
> > > +     struct i2c_client *client =3D to_i2c_client(dev);
> > > +     unsigned char buf[10];
> > > +     int err;
> > > +
> >
> > You should still return an error if the time is invalid there but witho=
ut
> > an error message.
> >
[Mia] I will verify the time by rtc_valid_tm(tm).

> > > +     err =3D i2c_smbus_read_i2c_block_data(client, NCT3018Y_REG_SC, =
sizeof(buf), buf);
> > > +     if (err < 0)
> > > +             return err;
> > > +
> > > +     tm->tm_sec =3D bcd2bin(buf[0] & 0x7F);
> > > +     tm->tm_min =3D bcd2bin(buf[2] & 0x7F);
> > > +     tm->tm_hour =3D bcd2bin(buf[4] & 0x3F);
> > > +     tm->tm_wday =3D buf[6] & 0x07;
> > > +     tm->tm_mday =3D bcd2bin(buf[7] & 0x3F);
> > > +     tm->tm_mon =3D bcd2bin(buf[8] & 0x1F) - 1;
> > > +     tm->tm_year =3D bcd2bin(buf[9]) + 100;
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static int nct3018y_rtc_read_alarm(struct device *dev, struct rtc_wk=
alrm *tm)
> > > +{
> > > +     struct i2c_client *client =3D to_i2c_client(dev);
> > > +     unsigned char buf[5];
> > > +     int err;
> > > +
> > > +     err =3D i2c_smbus_read_i2c_block_data(client, NCT3018Y_REG_SCA,
> > > +                                         sizeof(buf), buf);
> > > +     if (err < 0) {
> > > +             dev_err(&client->dev, "Unable to read date\n");
> > > +             return -EIO;
> > > +     }
> > > +
> > > +     dev_dbg(&client->dev, "%s: raw data is sec=3D%02x, min=3D%02x h=
r=3D%02x\n",
> > > +             __func__, buf[0], buf[2], buf[4]);
> > > +
> > > +     tm->time.tm_sec =3D bcd2bin(buf[0] & 0x7F);
> > > +     tm->time.tm_min =3D bcd2bin(buf[2] & 0x7F);
> > > +     tm->time.tm_hour =3D bcd2bin(buf[4] & 0x3F);
> > > +
> > > +     err =3D nct3018y_get_alarm_mode(client, &tm->enabled, &tm->pend=
ing);
> > > +     if (err < 0)
> > > +             return err;
> > > +
> > > +     dev_dbg(&client->dev, "%s:s=3D%d m=3D%d, hr=3D%d, enabled=3D%d,=
 pending=3D%d\n",
> > > +             __func__, tm->time.tm_sec, tm->time.tm_min,
> > > +             tm->time.tm_hour, tm->enabled, tm->pending);
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static int nct3018y_rtc_set_alarm(struct device *dev, struct rtc_wka=
lrm *tm)
> > > +{
> > > +     struct i2c_client *client =3D to_i2c_client(dev);
> > > +     unsigned char buf[3];
> > > +     int err;
> > > +
> > > +     dev_dbg(dev, "%s, sec=3D%d, min=3D%d hour=3D%d tm->enabled:%d\n=
",
> > > +             __func__, tm->time.tm_sec, tm->time.tm_min, tm->time.tm=
_hour,
> > > +             tm->enabled);
> > > +
> > > +     buf[0] =3D bin2bcd(tm->time.tm_sec);
> > > +     buf[1] =3D bin2bcd(tm->time.tm_min);
> > > +     buf[2] =3D bin2bcd(tm->time.tm_hour);
> >
> > I don't think buf is useful in this function
[Mia]  I will remove buf in this function.

> > > +
> > > +     err =3D i2c_smbus_write_byte_data(client, NCT3018Y_REG_SCA, buf=
[0]);
> > > +     if (err < 0) {
> > > +             dev_err(&client->dev, "Unable to write NCT3018Y_REG_SCA=
\n");
> > > +             return err;
> > > +     }
> > > +
> > > +     err =3D i2c_smbus_write_byte_data(client, NCT3018Y_REG_MNA, buf=
[1]);
> > > +     if (err < 0) {
> > > +             dev_err(&client->dev, "Unable to write NCT3018Y_REG_MNA=
\n");
> > > +             return err;
> > > +     }
> > > +
> > > +     err =3D i2c_smbus_write_byte_data(client, NCT3018Y_REG_HRA, buf=
[2]);
> > > +     if (err < 0) {
> > > +             dev_err(&client->dev, "Unable to write NCT3018Y_REG_HRA=
\n");
> > > +             return err;
> > > +     }
> > > +
> > > +     return nct3018y_set_alarm_mode(client, tm->enabled);
> > > +}
> > > +
> >
> >
> > > +static struct clk *nct3018y_clkout_register_clk(struct nct3018y *nct=
3018y)
> > > +{
> > > +     struct i2c_client *client =3D nct3018y->client;
> > > +     struct device_node *node =3D client->dev.of_node;
> > > +     struct clk *clk;
> > > +     struct clk_init_data init;
> > > +     int flags, err;
> > > +
> > > +     /* disable the clkout output */
> > > +     flags =3D 0;
> > > +     err =3D i2c_smbus_write_byte_data(client, NCT3018Y_REG_CLKO, fl=
ags);
> >
> > BTW, this introduces a glitch in the clock output if the clock is
> > actually used. Maybe you could just rely on the CCF core to disable thi=
s
> > clock when there are no users.
> >
[Mia] Do you mean there is no need to disable the clock output here?

> > > +     if (err < 0) {
> > > +             dev_err(&client->dev, "Unable to write oscillator statu=
s register\n");
> > > +             return ERR_PTR(err);
> > > +     }
> > > +
> > > +     init.name =3D "nct3018y-clkout";
> > > +     init.ops =3D &nct3018y_clkout_ops;
> > > +     init.flags =3D 0;
> > > +     init.parent_names =3D NULL;
> > > +     init.num_parents =3D 0;
> > > +     nct3018y->clkout_hw.init =3D &init;
> > > +
> > > +     /* optional override of the clockname */
> > > +     of_property_read_string(node, "clock-output-names", &init.name)=
;
> > > +
> > > +     /* register the clock */
> > > +     clk =3D devm_clk_register(&client->dev, &nct3018y->clkout_hw);
> > > +
> > > +     if (!IS_ERR(clk))
> > > +             of_clk_add_provider(node, of_clk_src_simple_get, clk);
> > > +
> > > +     return clk;
> > > +}
> > > +#endif
> > > +
> > > +static const struct rtc_class_ops nct3018y_rtc_ops =3D {
> > > +     .read_time      =3D nct3018y_rtc_read_time,
> > > +     .set_time       =3D nct3018y_rtc_set_time,
> > > +     .read_alarm     =3D nct3018y_rtc_read_alarm,
> > > +     .set_alarm      =3D nct3018y_rtc_set_alarm,
> > > +     .alarm_irq_enable =3D nct3018y_irq_enable,
> > > +     .ioctl          =3D nct3018y_ioctl,
> > > +};
> > > +
> > > +static int nct3018y_probe(struct i2c_client *client,
> > > +                       const struct i2c_device_id *id)
> > > +{
> > > +     struct nct3018y *nct3018y;
> > > +     int err, flags;
> > > +
> > > +     if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
> >
> > Don't you rather need I2C_FUNC_SMBUS_BYTE and I2C_FUNC_SMBUS_BLOCK_DATA=
?
> >
[Mia] I will also check I2C_FUNC_SMBUS_BYTE and I2C_FUNC_SMBUS_BLOCK_DATA.

> > > +             dev_err(&client->dev, "%s: ENODEV\n", __func__);
> > > +             return -ENODEV;
> > > +     }
> > > +
> > > +     nct3018y =3D devm_kzalloc(&client->dev, sizeof(struct nct3018y)=
,
> > > +                             GFP_KERNEL);
> > > +     if (!nct3018y)
> > > +             return -ENOMEM;
> > > +
> > > +     i2c_set_clientdata(client, nct3018y);
> > > +     nct3018y->client =3D client;
> > > +     device_set_wakeup_capable(&client->dev, 1);
> > > +
> > > +     flags =3D i2c_smbus_read_byte_data(client, NCT3018Y_REG_CTRL);
> > > +     if (flags < 0) {
> > > +             dev_err(&client->dev, "%s: read error\n", __func__);
> > > +             return flags;
> > > +     } else if (flags & NCT3018Y_BIT_TWO)
> > > +             dev_dbg(&client->dev, "%s: NCT3018Y_BIT_TWO is set\n", =
__func__);
> > > +
> > > +
> > > +     flags =3D NCT3018Y_BIT_TWO;
> > > +     err =3D i2c_smbus_write_byte_data(client, NCT3018Y_REG_CTRL, fl=
ags);
> > > +     if (err < 0) {
> > > +             dev_err(&client->dev, "Unable to write NCT3018Y_REG_CTR=
L\n");
> > > +             return err;
> > > +     }
> > > +
> > > +     flags =3D 0;
> > > +     err =3D i2c_smbus_write_byte_data(client, NCT3018Y_REG_ST, flag=
s);
> > > +     if (err < 0) {
> > > +             dev_err(&client->dev, "%s: write error\n", __func__);
> > > +             return err;
> > > +     }
> > > +
> > > +
> > > +     nct3018y->rtc =3D devm_rtc_allocate_device(&client->dev);
> > > +     if (IS_ERR(nct3018y->rtc))
> > > +             return PTR_ERR(nct3018y->rtc);
> > > +
> > > +     nct3018y->rtc->ops =3D &nct3018y_rtc_ops;
> > > +     nct3018y->rtc->range_min =3D RTC_TIMESTAMP_BEGIN_2000;
> > > +     nct3018y->rtc->range_max =3D RTC_TIMESTAMP_END_2099;
> > > +
> > > +     if (client->irq > 0) {
> > > +             err =3D devm_request_threaded_irq(&client->dev, client-=
>irq,
> > > +                             NULL, nct3018y_irq,
> > > +                             IRQF_ONESHOT | IRQF_TRIGGER_FALLING,
> > > +                             "nct3018y", client);
> > > +             if (err) {
> > > +                     dev_err(&client->dev, "unable to request IRQ %d=
\n", client->irq);
> > > +                     return err;
> > > +             }
> > > +     }
> >
> > You need to clear RTC_FEATURE_UPDATE_INTERRUPT and RTC_FEATURE_ALARM
> > from nct3018y->rtc->features when client->irq <=3D 0
> >
[Mia] I will clear RTC_FEATURE_UPDATE_INTERRUPT and RTC_FEATURE_ALARM
if client->irq <=3D 0.

> > > +
> > > +     return devm_rtc_register_device(nct3018y->rtc);
> > > +
> >
> > > +#ifdef CONFIG_COMMON_CLK
> > > +     /* register clk in common clk framework */
> > > +     nct3018y_clkout_register_clk(nct3018y);
> > > +#endif
> > > +
> >
> > This code is not reachable anymore
> >
[Mia] I will refine it. Thank you.

> > > +     return 0;
> > > +}
> > > +
> > > +static const struct i2c_device_id nct3018y_id[] =3D {
> > > +     { "nct3018y", 0 },
> > > +     { }
> > > +};
> > > +MODULE_DEVICE_TABLE(i2c, nct3018y_id);
> > > +
> > > +
> > > +static const struct of_device_id nct3018y_of_match[] =3D {
> > > +     { .compatible =3D "nuvoton,nct3018y" },
> > > +     {}
> > > +};
> > > +MODULE_DEVICE_TABLE(of, nct3018y_of_match);
> > > +
> > > +static struct i2c_driver nct3018y_driver =3D {
> > > +     .driver         =3D {
> > > +             .name   =3D "rtc-nct3018y",
> > > +             .of_match_table =3D of_match_ptr(nct3018y_of_match),
> > > +     },
> > > +     .probe          =3D nct3018y_probe,
> > > +     .id_table       =3D nct3018y_id,
> > > +};
> > > +
> > > +module_i2c_driver(nct3018y_driver);
> > > +
> > > +MODULE_AUTHOR("Medad CChien <ctcchien@nuvoton.com>");
> > > +MODULE_DESCRIPTION("Nuvoton NCT3018Y RTC driver");
> > > +MODULE_LICENSE("GPL v2");
> > > --
> > > 2.17.1
> > >
> >
> > --
> > Alexandre Belloni, co-owner and COO, Bootlin
> > Embedded Linux and Kernel engineering
> > https://bootlin.com
>
> B.R.
> Medad
