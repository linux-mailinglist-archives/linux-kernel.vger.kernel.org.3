Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C14115538E6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 19:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232907AbiFURbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 13:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiFURb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 13:31:27 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0633664DB
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 10:31:22 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id o7so29012431eja.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 10:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1/UNVcWR6bHar0SlMs/rmdzR06UMVCG83t3ZdJi0y/4=;
        b=R7H14Y5ZYaJJKGVg2XL381SR1L8csld9m8PysyYeYlIubKzTz7Cnq5IvJcEGKr7oNo
         KU6E7KMc9AIdXVaYKGbBHkvFbBc0zMSQt466pg99+ITATtZAEaHLJR4Rho0WmdVlFx76
         cR64FlAhPC687XcpAO6/lQXxPGQd4QQkz29xFUwc6BW6t/JVHI+pCZsksOjU8nPk5W0Q
         cFOMNDj+An8ztlKczJLqSGVgKkW2RfQfse+I3Hl7P6Z3CEc1CD32xz0+iOV6kLapVCxJ
         fcZUAPyQ6LKqrks4FZ8IL47LxoJAXYjmcDr2VgM1jC4yta/t4EpzBo6zI9WYtXcfHRW7
         vgEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1/UNVcWR6bHar0SlMs/rmdzR06UMVCG83t3ZdJi0y/4=;
        b=Op43Hfl5+mWmxm7nnx7xwk2lwW7puo5ldIvIyqNfs4sV7G6/BvX4OrEJwMPcgfS2Iz
         O9iWYs0grIBu8nJ/Xq1DT0xUowg4wtNo+6K7GjEDTj3MTkIh+P+GZPK7SGwCwwxAKxBq
         HThH87uYRVm1mmvCVUj7JwOAkcTfdkqE6KkvA+eRuscMkixM42WrSNbnO2xhPGx/76IS
         q6z/R3KGIZciY7Fi4XKUwrdLh+ldi3WisT33LWZwXeGre60Fa+zthw2z6yuTa3qUdUiM
         YQ1oLVa9bigWIBodUXOEM/Aa5ocpeyoYjhJZyGT0ciP2uhWLRAY6XzGjOOBOC6yTewdI
         YESw==
X-Gm-Message-State: AJIora/2jwpVjOFuHU4p3OnUzgyDB/sgmMIDKOEAz+/3PulIJ6UkQ30V
        q04vFE3hO4rF0qi3eiPgvzvHbqsu9cPTfOdesLAg2g==
X-Google-Smtp-Source: AGRyM1uSalwwTw2jrzPIXHt8halvjwQg/GwtsE6BlWznwr9g7PP3kdL79Cyii/EtwpXGyOfCN7UqZrSg6CpBKmS7+f4=
X-Received: by 2002:a17:907:2d87:b0:711:dd41:1e72 with SMTP id
 gt7-20020a1709072d8700b00711dd411e72mr26693242ejc.742.1655832680413; Tue, 21
 Jun 2022 10:31:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220616123150.5890-1-aford173@gmail.com> <20220616123150.5890-2-aford173@gmail.com>
 <CAPY8ntCKYN=8PC4nrsjxAMKQ+s992JqS6wpRLf4z9RcH_3RpUg@mail.gmail.com> <CAHCN7xJZ0K6MrLSOXKhOBRxWDBZypM2ViqT8GrZftdVPvkpbzw@mail.gmail.com>
In-Reply-To: <CAHCN7xJZ0K6MrLSOXKhOBRxWDBZypM2ViqT8GrZftdVPvkpbzw@mail.gmail.com>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Tue, 21 Jun 2022 18:31:05 +0100
Message-ID: <CAPY8ntCxorq_95zbZM0mRAUi9YfCNymgJ4BtctOV6nJfS8xzcA@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] media: i2c: imx219: Support four-lane operation
To:     Adam Ford <aford173@gmail.com>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adam Ford-BE <aford@beaconembedded.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jun 2022 at 18:08, Adam Ford <aford173@gmail.com> wrote:
>
> On Tue, Jun 21, 2022 at 11:05 AM Dave Stevenson
> <dave.stevenson@raspberrypi.com> wrote:
> >
> > Hi Adam
> >
> > On Thu, 16 Jun 2022 at 13:31, Adam Ford <aford173@gmail.com> wrote:
> > >
> > > The imx219 camera is capable of either two-lane or four-lane
> > > operation.  When operating in four-lane, both the pixel rate and
> > > link frequency change. Regardless of the mode, however, both
> > > frequencies remain fixed.
> > >
> > > Helper functions are needed to read and set pixel and link frequencies
> > > which also reduces the number of fixed registers in the table of modes.
> > >
> > > Since the link frequency and number of lanes is extracted from the
> > > endpoint, move the endpoint handling into the probe function and
> > > out of the imx219_check_hwcfg.  This simplifies the imx219_check_hwcfg
> > > just a bit.
> > >
> > > Signed-off-by: Adam Ford <aford173@gmail.com>
> > > ---
> > > V2:  Replace if-else statements with ternary operator
> > >      Fix 4-lane Link Rate.
> > >      Fix checking the link rate so only the link rate for
> > >      the given number of lanes is permitted.
> > >
> > > diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
> > > index a43eed143999..0d9004a5c4d2 100644
> > > --- a/drivers/media/i2c/imx219.c
> > > +++ b/drivers/media/i2c/imx219.c
> > > @@ -42,10 +42,16 @@
> > >  /* External clock frequency is 24.0M */
> > >  #define IMX219_XCLK_FREQ               24000000
> > >
> > > -/* Pixel rate is fixed at 182.4M for all the modes */
> > > +/* Pixel rate is fixed for all the modes */
> > >  #define IMX219_PIXEL_RATE              182400000
> > > +#define IMX219_PIXEL_RATE_4LANE                280800000
> > >
> > >  #define IMX219_DEFAULT_LINK_FREQ       456000000
> > > +#define IMX219_DEFAULT_LINK_FREQ_4LANE 363000000
> > > +
> > > +#define IMX219_REG_CSI_LANE_MODE       0x0114
> > > +#define IMX219_CSI_2_LANE_MODE         0x01
> > > +#define IMX219_CSI_4_LANE_MODE         0x03
> > >
> > >  /* V_TIMING internal */
> > >  #define IMX219_REG_VTS                 0x0160
> > > @@ -306,6 +312,10 @@ static const s64 imx219_link_freq_menu[] = {
> > >         IMX219_DEFAULT_LINK_FREQ,
> > >  };
> > >
> > > +static const s64 imx219_link_freq_4lane_menu[] = {
> > > +       IMX219_DEFAULT_LINK_FREQ_4LANE,
> > > +};
> > > +
> > >  static const char * const imx219_test_pattern_menu[] = {
> > >         "Disabled",
> > >         "Color Bars",
> > > @@ -481,6 +491,9 @@ struct imx219 {
> > >
> > >         /* Streaming on/off */
> > >         bool streaming;
> > > +
> > > +       /* Two or Four lanes */
> > > +       u8 lanes;
> > >  };
> > >
> > >  static inline struct imx219 *to_imx219(struct v4l2_subdev *_sd)
> > > @@ -943,6 +956,13 @@ static int imx219_get_selection(struct v4l2_subdev *sd,
> > >         return -EINVAL;
> > >  }
> > >
> > > +static int imx219_configure_lanes(struct imx219 *imx219)
> > > +{
> > > +       return imx219_write_reg(imx219, IMX219_REG_CSI_LANE_MODE,
> > > +                               IMX219_REG_VALUE_08BIT, (imx219->lanes == 2) ?
> > > +                               IMX219_CSI_2_LANE_MODE : IMX219_CSI_4_LANE_MODE);
> > > +};
> > > +
> > >  static int imx219_start_streaming(struct imx219 *imx219)
> > >  {
> > >         struct i2c_client *client = v4l2_get_subdevdata(&imx219->sd);
> > > @@ -960,6 +980,13 @@ static int imx219_start_streaming(struct imx219 *imx219)
> > >                 goto err_rpm_put;
> > >         }
> > >
> > > +       /* Configure two or four Lane mode */
> > > +       ret = imx219_configure_lanes(imx219);
> > > +       if (ret) {
> > > +               dev_err(&client->dev, "%s failed to configure lanes\n", __func__);
> > > +               goto err_rpm_put;
> > > +       }
> > > +
> > >         /* Apply default values of current mode */
> > >         reg_list = &imx219->mode->reg_list;
> > >         ret = imx219_write_regs(imx219, reg_list->regs, reg_list->num_of_regs);
> > > @@ -1191,6 +1218,11 @@ static const struct v4l2_subdev_internal_ops imx219_internal_ops = {
> > >         .open = imx219_open,
> > >  };
> > >
> > > +static unsigned long imx219_get_pixel_rate(struct imx219 *imx219)
> > > +{
> > > +       return (imx219->lanes == 2) ? IMX219_PIXEL_RATE : IMX219_PIXEL_RATE_4LANE;
> > > +}
> > > +
> > >  /* Initialize control handlers */
> > >  static int imx219_init_controls(struct imx219 *imx219)
> > >  {
> > > @@ -1212,15 +1244,16 @@ static int imx219_init_controls(struct imx219 *imx219)
> > >         /* By default, PIXEL_RATE is read only */
> > >         imx219->pixel_rate = v4l2_ctrl_new_std(ctrl_hdlr, &imx219_ctrl_ops,
> > >                                                V4L2_CID_PIXEL_RATE,
> > > -                                              IMX219_PIXEL_RATE,
> > > -                                              IMX219_PIXEL_RATE, 1,
> > > -                                              IMX219_PIXEL_RATE);
> > > +                                              imx219_get_pixel_rate(imx219),
> > > +                                              imx219_get_pixel_rate(imx219), 1,
> > > +                                              imx219_get_pixel_rate(imx219));
> > >
> > >         imx219->link_freq =
> > >                 v4l2_ctrl_new_int_menu(ctrl_hdlr, &imx219_ctrl_ops,
> > >                                        V4L2_CID_LINK_FREQ,
> > >                                        ARRAY_SIZE(imx219_link_freq_menu) - 1, 0,
> > > -                                      imx219_link_freq_menu);
> > > +                                      (imx219->lanes == 2) ? imx219_link_freq_menu :
> > > +                                      imx219_link_freq_4lane_menu);
> > >         if (imx219->link_freq)
> > >                 imx219->link_freq->flags |= V4L2_CTRL_FLAG_READ_ONLY;
> > >
> > > @@ -1315,67 +1348,76 @@ static void imx219_free_controls(struct imx219 *imx219)
> > >         mutex_destroy(&imx219->mutex);
> > >  }
> > >
> > > -static int imx219_check_hwcfg(struct device *dev)
> > > +static int imx219_check_hwcfg(struct imx219 *imx219, u64 link_frequency)
> > >  {
> > > -       struct fwnode_handle *endpoint;
> > > +       struct i2c_client *client = v4l2_get_subdevdata(&imx219->sd);
> > > +
> > > +       /* Check the number of MIPI CSI2 data lanes */
> > > +       if (imx219->lanes != 2 && imx219->lanes != 4) {
> > > +               dev_err(&client->dev, "only 2 or 4 data lanes are currently supported\n");
> > > +               return -EINVAL;
> > > +       }
> > > +
> > > +       if (link_frequency != ((imx219->lanes == 2) ?
> > > +                             IMX219_DEFAULT_LINK_FREQ : IMX219_DEFAULT_LINK_FREQ_4LANE)) {
> > > +               dev_err(&client->dev, "Link frequency not supported: %lld\n",
> > > +                       link_frequency);
> > > +               return -EINVAL;
> > > +       }
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static int imx219_probe(struct i2c_client *client)
> > > +{
> > > +       struct device *dev = &client->dev;
> > > +       struct imx219 *imx219;
> > >         struct v4l2_fwnode_endpoint ep_cfg = {
> > >                 .bus_type = V4L2_MBUS_CSI2_DPHY
> > >         };
> > > -       int ret = -EINVAL;
> > > +       struct fwnode_handle *endpoint;
> > > +       int ret = 0;
> > > +       u64 link_frequency = 0;
> > >
> > > +       imx219 = devm_kzalloc(&client->dev, sizeof(*imx219), GFP_KERNEL);
> > > +       if (!imx219)
> > > +               return -ENOMEM;
> > > +
> > > +       v4l2_i2c_subdev_init(&imx219->sd, client, &imx219_subdev_ops);
> > > +
> > > +       /* Fetch the endpoint to extract lanes and link-frequency */
> > >         endpoint = fwnode_graph_get_next_endpoint(dev_fwnode(dev), NULL);
> > >         if (!endpoint) {
> > >                 dev_err(dev, "endpoint node not found\n");
> > > -               return -EINVAL;
> > > +               ret = -EINVAL;
> > > +               goto fwnode_cleanup;
> > >         }
> > >
> > >         if (v4l2_fwnode_endpoint_alloc_parse(endpoint, &ep_cfg)) {
> > >                 dev_err(dev, "could not parse endpoint\n");
> > > -               goto error_out;
> > > +               ret = -EINVAL;
> > > +               goto fwnode_cleanup;
> > >         }
> > >
> > > -       /* Check the number of MIPI CSI2 data lanes */
> > > -       if (ep_cfg.bus.mipi_csi2.num_data_lanes != 2) {
> > > -               dev_err(dev, "only 2 data lanes are currently supported\n");
> > > -               goto error_out;
> > > -       }
> > > +       imx219->lanes = ep_cfg.bus.mipi_csi2.num_data_lanes;
> > >
> > >         /* Check the link frequency set in device tree */
> > > -       if (!ep_cfg.nr_of_link_frequencies) {
> > > +       if (ep_cfg.nr_of_link_frequencies != 1) {
> > >                 dev_err(dev, "link-frequency property not found in DT\n");
> > > -               goto error_out;
> > > -       }
> > > -
> > > -       if (ep_cfg.nr_of_link_frequencies != 1 ||
> > > -           ep_cfg.link_frequencies[0] != IMX219_DEFAULT_LINK_FREQ) {
> > > -               dev_err(dev, "Link frequency not supported: %lld\n",
> > > -                       ep_cfg.link_frequencies[0]);
> > > -               goto error_out;
> > > +               ret = -EINVAL;
> > > +               goto fwnode_cleanup;
> > >         }
> > > +       link_frequency = ep_cfg.link_frequencies[0];
> > >
> > > -       ret = 0;
> > > -
> > > -error_out:
> > > +       /* Cleanup endpoint and handle any errors from above */
> > > +fwnode_cleanup:
> > >         v4l2_fwnode_endpoint_free(&ep_cfg);
> > >         fwnode_handle_put(endpoint);
> >
> > Having a "goto" to the middle of a function, and then if(ret) return
> > ret; is horrid. Working with diffs has messed this up a bit which is
> > why I hadn't noticed it in the last patch set, but I was about to
> > comment that link_frequency doesn't need to be initialised to 0 above,
> > but it does due to this (except it should take the return path).
> >
> > I'm not quite sure why you need to move the fwnode calls out of
> > imx219_check_hwcfg. Pass in struct imx219 *imx219 and it can check the
>
> It seemed more appropriate to me for probe to set the values instead
> of passing it to a helper function to set them.  Since the Probe
> function needed to extract the fwnode info to do this, I moved the
> calls out of the helper.
>
> > link_frequency and assign imx219->lanes with the values it was already
> > validating. You can drop the struct device *dev as it is available via
> > imx219->sd->dev, initialised by v4l2_i2c_subdev_init. The
> > v4l2_fwnode_endpoint_free and fwnode_handle_put can then remain at the
> > end of the function as common cleanup code.
> > Rename imx219_check_hwcfg to imx219_read_hwcfg if the name offends as
> > it is now doing more than just checking it.
>
> Would be you ok if we did it all in the probe function and drop this
> helper function?

imx219_probe was 115 lines.
Your changes increased it to 154, and you're now wanting to take it up
to ~165, and it still needs some further work to clean up the error
handling.

Handling the endpoint and extracting the CSI config from it is
self-contained as an operation. Why does it need to directly be in
probe? The compiler is very likely going to inline the helper, but
breaking it up aids readability IMHO.
Look at imx334 [1] and it goes further and gets all the GPIO config
within a helper function (imx334_parse_hw_config).

[1] https://elixir.bootlin.com/linux/latest/source/drivers/media/i2c/imx334.c#L776

> >
> >   Dave
> >
> > > -
> > > -       return ret;
> > > -}
> > > -
> > > -static int imx219_probe(struct i2c_client *client)
> > > -{
> > > -       struct device *dev = &client->dev;
> > > -       struct imx219 *imx219;
> > > -       int ret;
> > > -
> > > -       imx219 = devm_kzalloc(&client->dev, sizeof(*imx219), GFP_KERNEL);
> > > -       if (!imx219)
> > > -               return -ENOMEM;
> > > -
> > > -       v4l2_i2c_subdev_init(&imx219->sd, client, &imx219_subdev_ops);
> > > +       if (ret)
> > > +               return ret;
> > >
> > >         /* Check the hardware configuration in device tree */
> > > -       if (imx219_check_hwcfg(dev))
> > > +       if (imx219_check_hwcfg(imx219, link_frequency))
> > >                 return -EINVAL;
> > >
> > >         /* Get system clock (xclk) */
> > > --
> > > 2.34.1
> > >
