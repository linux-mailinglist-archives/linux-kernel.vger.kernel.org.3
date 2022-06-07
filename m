Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F76540198
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 16:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245676AbiFGOjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 10:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245682AbiFGOi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 10:38:56 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F60F33B6
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 07:38:53 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id q1so35655023ejz.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 07:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1q+4tLsdC0zrMSjNpf94Uv+psei2r8wHu1mqiQccHsY=;
        b=p3FTbvkD0jW3mKqYE9noJtq/j7R1WZzImBpCqC69C7tj47k5s3adWRIsCwbPXnpYk6
         uYdCSCMPkZ7dRyLplAH5K/GrCsuvVKQoSTVexTiKaAHIxTYZnN+lHqKHEEbNHbpnkjOr
         GU+396A0v76jDiXEcjV847HPr/VxWZSqGcqr9puo/TAFLs+QPDQE1bX5yoZGqkoMeBFF
         TFj62FrCS4NmRDX8JOXHJ6XppadlyOa8ztCoaWc/pdWzz14cWeEc7Bu/pfk//M+05pLZ
         99KJz5dIFn83iSN3PN8Yd6UawqAgXRGBWzhtj46oHSNX/KTf1NhiMXKH69G5xdA1nceH
         TXLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1q+4tLsdC0zrMSjNpf94Uv+psei2r8wHu1mqiQccHsY=;
        b=rodEBQmjK2GNwMN2ahXBXfJ5tnzwQLtN54PbWo2FfmDt0XIsHk4moGKVPNxgQ595Er
         1IPgAuQaogcUAgJF9OT1HWXZGdRGaXSZlUvd3ZpKeZTHRmxNjxLezlcneEPT+75KeeFP
         RxisJeg7DLi1uPmVsg+fTjYR47SQTFmqbK2DpgjLXuHRswWo5SmZCR3LN/Syvvr0Bimy
         VpxwvdOTzu9kFtpG8U6vIyt78wPnzWfTbsQPnac3cwMEPM4BWCW4Jg/Hhc3W+KdiLiIU
         JmUnNAieJ4bfq+8/69o0zO6rK45egkn8/F2xJAdD7ecJhD0rOYWmo5Pygjx92t39/pby
         cQIA==
X-Gm-Message-State: AOAM5320sj3HZ2e2OELRv9mSgqMeZiiaaJeSPWMq6DYsw16HaT7G2x8+
        waIApO+wfWTfY7NxlmVafArjMMenokHeXZC5xp194Q==
X-Google-Smtp-Source: ABdhPJy9GdmrZgC2O3HgfND3XMUiqFXjvF88ZpFxRJw5ByYj4Z4TuAnHH16y+VTTzX1P+Go3bImyg3An/aDGdQub8NI=
X-Received: by 2002:a17:906:4d50:b0:70d:afd4:1e63 with SMTP id
 b16-20020a1709064d5000b0070dafd41e63mr22699999ejv.618.1654612731917; Tue, 07
 Jun 2022 07:38:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220606201825.763788-1-pmalani@chromium.org> <20220606201825.763788-3-pmalani@chromium.org>
In-Reply-To: <20220606201825.763788-3-pmalani@chromium.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Tue, 7 Jun 2022 07:38:40 -0700
Message-ID: <CABXOdTeWK+uP=S2bmbuhJ3cKV-TWkFmBRPQ5XmoH6TyCb=VOJg@mail.gmail.com>
Subject: Re: [PATCH 2/3] platform/chrome: cros_ec_proto: Rename
 cros_ec_command function
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        "open list:CHROME HARDWARE PLATFORM SUPPORT" 
        <chrome-platform@lists.linux.dev>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 6, 2022 at 1:19 PM Prashant Malani <pmalani@chromium.org> wrote:
>
> cros_ec_command() is the name of a function as well as a struct, as such
> it can confuse indexing tools (like ctags). Avoid this by renaming it to
> cros_ec_cmd(). Update all the callsites to use the new name.
>
> This patch is a find-and-replace, so should not introduce any functional
> changes.
>
> Suggested-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>  drivers/mfd/cros_ec_dev.c                   |  4 +--
>  drivers/platform/chrome/cros_ec_proto.c     | 22 ++++++------
>  drivers/platform/chrome/cros_ec_typec.c     | 39 ++++++++++-----------
>  drivers/platform/chrome/cros_usbpd_notify.c |  4 +--
>  drivers/regulator/cros-ec-regulator.c       | 24 ++++++-------
>  include/linux/platform_data/cros_ec_proto.h |  2 +-
>  6 files changed, 47 insertions(+), 48 deletions(-)
>
> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> index 596731caf407..02d4271dfe06 100644
> --- a/drivers/mfd/cros_ec_dev.c
> +++ b/drivers/mfd/cros_ec_dev.c
> @@ -250,8 +250,8 @@ static int ec_device_probe(struct platform_device *pdev)
>          * The PCHG device cannot be detected by sending EC_FEATURE_GET_CMD, but
>          * it can be detected by querying the number of peripheral chargers.
>          */
> -       retval = cros_ec_command(ec->ec_dev, 0, EC_CMD_PCHG_COUNT, NULL, 0,
> -                                &pchg_count, sizeof(pchg_count));
> +       retval = cros_ec_cmd(ec->ec_dev, 0, EC_CMD_PCHG_COUNT, NULL, 0,
> +                            &pchg_count, sizeof(pchg_count));
>         if (retval >= 0 && pchg_count.port_count) {
>                 retval = mfd_add_hotplug_devices(ec->dev,
>                                         cros_ec_pchg_cells,
> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> index 13ced9d2dd71..b6bea183ee28 100644
> --- a/drivers/platform/chrome/cros_ec_proto.c
> +++ b/drivers/platform/chrome/cros_ec_proto.c
> @@ -860,8 +860,8 @@ bool cros_ec_check_features(struct cros_ec_dev *ec, int feature)
>
>         if (features->flags[0] == -1U && features->flags[1] == -1U) {
>                 /* features bitmap not read yet */
> -               ret = cros_ec_command(ec->ec_dev, 0, EC_CMD_GET_FEATURES + ec->cmd_offset,
> -                                     NULL, 0, features, sizeof(*features));
> +               ret = cros_ec_cmd(ec->ec_dev, 0, EC_CMD_GET_FEATURES + ec->cmd_offset,
> +                                 NULL, 0, features, sizeof(*features));
>                 if (ret < 0) {
>                         dev_warn(ec->dev, "cannot get EC features: %d\n", ret);
>                         memset(features, 0, sizeof(*features));
> @@ -942,7 +942,7 @@ int cros_ec_get_sensor_count(struct cros_ec_dev *ec)
>  EXPORT_SYMBOL_GPL(cros_ec_get_sensor_count);
>
>  /**
> - * cros_ec_command - Send a command to the EC.
> + * cros_ec_cmd - Send a command to the EC.
>   *
>   * @ec_dev: EC device
>   * @version: EC command version
> @@ -954,13 +954,13 @@ EXPORT_SYMBOL_GPL(cros_ec_get_sensor_count);
>   *
>   * Return: >= 0 on success, negative error number on failure.
>   */
> -int cros_ec_command(struct cros_ec_device *ec_dev,
> -                   unsigned int version,
> -                   int command,
> -                   void *outdata,
> -                   int outsize,
> -                   void *indata,
> -                   int insize)
> +int cros_ec_cmd(struct cros_ec_device *ec_dev,
> +               unsigned int version,
> +               int command,
> +               void *outdata,
> +               int outsize,
> +               void *indata,
> +               int insize)
>  {
>         struct cros_ec_command *msg;
>         int ret;
> @@ -987,4 +987,4 @@ int cros_ec_command(struct cros_ec_device *ec_dev,
>         kfree(msg);
>         return ret;
>  }
> -EXPORT_SYMBOL_GPL(cros_ec_command);
> +EXPORT_SYMBOL_GPL(cros_ec_cmd);
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index 7cb2e35c4ded..d6088ba447af 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -525,8 +525,8 @@ static int cros_typec_configure_mux(struct cros_typec_data *typec, int port_num,
>         enum typec_orientation orientation;
>         int ret;
>
> -       ret = cros_ec_command(typec->ec, 0, EC_CMD_USB_PD_MUX_INFO,
> -                             &req, sizeof(req), &resp, sizeof(resp));
> +       ret = cros_ec_cmd(typec->ec, 0, EC_CMD_USB_PD_MUX_INFO,
> +                         &req, sizeof(req), &resp, sizeof(resp));
>         if (ret < 0) {
>                 dev_warn(typec->dev, "Failed to get mux info for port: %d, err = %d\n",
>                          port_num, ret);
> @@ -585,8 +585,8 @@ static int cros_typec_configure_mux(struct cros_typec_data *typec, int port_num,
>         /* Sending Acknowledgment to EC */
>         mux_ack.port = port_num;
>
> -       if (cros_ec_command(typec->ec, 0, EC_CMD_USB_PD_MUX_ACK, &mux_ack,
> -                           sizeof(mux_ack), NULL, 0) < 0)
> +       if (cros_ec_cmd(typec->ec, 0, EC_CMD_USB_PD_MUX_ACK, &mux_ack,
> +                       sizeof(mux_ack), NULL, 0) < 0)
>                 dev_warn(typec->dev,
>                          "Failed to send Mux ACK to EC for port: %d\n",
>                          port_num);
> @@ -754,8 +754,8 @@ static int cros_typec_handle_sop_prime_disc(struct cros_typec_data *typec, int p
>         int ret = 0;
>
>         memset(disc, 0, EC_PROTO2_MAX_RESPONSE_SIZE);
> -       ret = cros_ec_command(typec->ec, 0, EC_CMD_TYPEC_DISCOVERY, &req, sizeof(req),
> -                             disc, EC_PROTO2_MAX_RESPONSE_SIZE);
> +       ret = cros_ec_cmd(typec->ec, 0, EC_CMD_TYPEC_DISCOVERY, &req, sizeof(req),
> +                         disc, EC_PROTO2_MAX_RESPONSE_SIZE);
>         if (ret < 0) {
>                 dev_err(typec->dev, "Failed to get SOP' discovery data for port: %d\n", port_num);
>                 goto sop_prime_disc_exit;
> @@ -837,8 +837,8 @@ static int cros_typec_handle_sop_disc(struct cros_typec_data *typec, int port_nu
>         typec_partner_set_pd_revision(port->partner, pd_revision);
>
>         memset(sop_disc, 0, EC_PROTO2_MAX_RESPONSE_SIZE);
> -       ret = cros_ec_command(typec->ec, 0, EC_CMD_TYPEC_DISCOVERY, &req, sizeof(req),
> -                             sop_disc, EC_PROTO2_MAX_RESPONSE_SIZE);
> +       ret = cros_ec_cmd(typec->ec, 0, EC_CMD_TYPEC_DISCOVERY, &req, sizeof(req),
> +                         sop_disc, EC_PROTO2_MAX_RESPONSE_SIZE);
>         if (ret < 0) {
>                 dev_err(typec->dev, "Failed to get SOP discovery data for port: %d\n", port_num);
>                 goto disc_exit;
> @@ -870,8 +870,8 @@ static int cros_typec_send_clear_event(struct cros_typec_data *typec, int port_n
>                 .clear_events_mask = events_mask,
>         };
>
> -       return cros_ec_command(typec->ec, 0, EC_CMD_TYPEC_CONTROL, &req,
> -                              sizeof(req), NULL, 0);
> +       return cros_ec_cmd(typec->ec, 0, EC_CMD_TYPEC_CONTROL, &req,
> +                          sizeof(req), NULL, 0);
>  }
>
>  static void cros_typec_handle_status(struct cros_typec_data *typec, int port_num)
> @@ -882,8 +882,8 @@ static void cros_typec_handle_status(struct cros_typec_data *typec, int port_num
>         };
>         int ret;
>
> -       ret = cros_ec_command(typec->ec, 0, EC_CMD_TYPEC_STATUS, &req, sizeof(req),
> -                             &resp, sizeof(resp));
> +       ret = cros_ec_cmd(typec->ec, 0, EC_CMD_TYPEC_STATUS, &req, sizeof(req),
> +                         &resp, sizeof(resp));
>         if (ret < 0) {
>                 dev_warn(typec->dev, "EC_CMD_TYPEC_STATUS failed for port: %d\n", port_num);
>                 return;
> @@ -960,9 +960,9 @@ static int cros_typec_port_update(struct cros_typec_data *typec, int port_num)
>         req.mux = USB_PD_CTRL_MUX_NO_CHANGE;
>         req.swap = USB_PD_CTRL_SWAP_NONE;
>
> -       ret = cros_ec_command(typec->ec, typec->pd_ctrl_ver,
> -                             EC_CMD_USB_PD_CONTROL, &req, sizeof(req),
> -                             &resp, sizeof(resp));
> +       ret = cros_ec_cmd(typec->ec, typec->pd_ctrl_ver,
> +                         EC_CMD_USB_PD_CONTROL, &req, sizeof(req),
> +                         &resp, sizeof(resp));
>         if (ret < 0)
>                 return ret;
>
> @@ -997,9 +997,8 @@ static int cros_typec_get_cmd_version(struct cros_typec_data *typec)
>
>         /* We're interested in the PD control command version. */
>         req_v1.cmd = EC_CMD_USB_PD_CONTROL;
> -       ret = cros_ec_command(typec->ec, 1, EC_CMD_GET_CMD_VERSIONS,
> -                             &req_v1, sizeof(req_v1), &resp,
> -                                   sizeof(resp));
> +       ret = cros_ec_cmd(typec->ec, 1, EC_CMD_GET_CMD_VERSIONS,
> +                         &req_v1, sizeof(req_v1), &resp, sizeof(resp));
>         if (ret < 0)
>                 return ret;
>
> @@ -1090,8 +1089,8 @@ static int cros_typec_probe(struct platform_device *pdev)
>         typec->typec_cmd_supported = cros_ec_check_features(ec_dev, EC_FEATURE_TYPEC_CMD);
>         typec->needs_mux_ack = cros_ec_check_features(ec_dev, EC_FEATURE_TYPEC_MUX_REQUIRE_AP_ACK);
>
> -       ret = cros_ec_command(typec->ec, 0, EC_CMD_USB_PD_PORTS, NULL, 0,
> -                             &resp, sizeof(resp));
> +       ret = cros_ec_cmd(typec->ec, 0, EC_CMD_USB_PD_PORTS, NULL, 0,
> +                         &resp, sizeof(resp));
>         if (ret < 0)
>                 return ret;
>
> diff --git a/drivers/platform/chrome/cros_usbpd_notify.c b/drivers/platform/chrome/cros_usbpd_notify.c
> index 91ce6be91aac..4b5a81c9dc6d 100644
> --- a/drivers/platform/chrome/cros_usbpd_notify.c
> +++ b/drivers/platform/chrome/cros_usbpd_notify.c
> @@ -71,8 +71,8 @@ static void cros_usbpd_get_event_and_notify(struct device  *dev,
>         }
>
>         /* Check for PD host events on EC. */
> -       ret = cros_ec_command(ec_dev, 0, EC_CMD_PD_HOST_EVENT_STATUS,
> -                             NULL, 0, &host_event_status, sizeof(host_event_status));
> +       ret = cros_ec_cmd(ec_dev, 0, EC_CMD_PD_HOST_EVENT_STATUS,
> +                         NULL, 0, &host_event_status, sizeof(host_event_status));
>         if (ret < 0) {
>                 dev_warn(dev, "Can't get host event status (err: %d)\n", ret);
>                 goto send_notify;
> diff --git a/drivers/regulator/cros-ec-regulator.c b/drivers/regulator/cros-ec-regulator.c
> index 1c5fc74a4776..1591636f86c3 100644
> --- a/drivers/regulator/cros-ec-regulator.c
> +++ b/drivers/regulator/cros-ec-regulator.c
> @@ -30,8 +30,8 @@ static int cros_ec_regulator_enable(struct regulator_dev *dev)
>                 .enable = 1,
>         };
>
> -       return cros_ec_command(data->ec_dev, 0, EC_CMD_REGULATOR_ENABLE, &cmd,
> -                              sizeof(cmd), NULL, 0);
> +       return cros_ec_cmd(data->ec_dev, 0, EC_CMD_REGULATOR_ENABLE, &cmd,
> +                          sizeof(cmd), NULL, 0);
>  }
>
>  static int cros_ec_regulator_disable(struct regulator_dev *dev)
> @@ -42,8 +42,8 @@ static int cros_ec_regulator_disable(struct regulator_dev *dev)
>                 .enable = 0,
>         };
>
> -       return cros_ec_command(data->ec_dev, 0, EC_CMD_REGULATOR_ENABLE, &cmd,
> -                              sizeof(cmd), NULL, 0);
> +       return cros_ec_cmd(data->ec_dev, 0, EC_CMD_REGULATOR_ENABLE, &cmd,
> +                          sizeof(cmd), NULL, 0);
>  }
>
>  static int cros_ec_regulator_is_enabled(struct regulator_dev *dev)
> @@ -55,8 +55,8 @@ static int cros_ec_regulator_is_enabled(struct regulator_dev *dev)
>         struct ec_response_regulator_is_enabled resp;
>         int ret;
>
> -       ret = cros_ec_command(data->ec_dev, 0, EC_CMD_REGULATOR_IS_ENABLED, &cmd,
> -                             sizeof(cmd), &resp, sizeof(resp));
> +       ret = cros_ec_cmd(data->ec_dev, 0, EC_CMD_REGULATOR_IS_ENABLED, &cmd,
> +                         sizeof(cmd), &resp, sizeof(resp));
>         if (ret < 0)
>                 return ret;
>         return resp.enabled;
> @@ -82,8 +82,8 @@ static int cros_ec_regulator_get_voltage(struct regulator_dev *dev)
>         struct ec_response_regulator_get_voltage resp;
>         int ret;
>
> -       ret = cros_ec_command(data->ec_dev, 0, EC_CMD_REGULATOR_GET_VOLTAGE, &cmd,
> -                             sizeof(cmd), &resp, sizeof(resp));
> +       ret = cros_ec_cmd(data->ec_dev, 0, EC_CMD_REGULATOR_GET_VOLTAGE, &cmd,
> +                         sizeof(cmd), &resp, sizeof(resp));
>         if (ret < 0)
>                 return ret;
>         return resp.voltage_mv * 1000;
> @@ -108,8 +108,8 @@ static int cros_ec_regulator_set_voltage(struct regulator_dev *dev, int min_uV,
>         if (min_mV > max_mV)
>                 return -EINVAL;
>
> -       return cros_ec_command(data->ec_dev, 0, EC_CMD_REGULATOR_SET_VOLTAGE, &cmd,
> -                              sizeof(cmd), NULL, 0);
> +       return cros_ec_cmd(data->ec_dev, 0, EC_CMD_REGULATOR_SET_VOLTAGE, &cmd,
> +                          sizeof(cmd), NULL, 0);
>  }
>
>  static const struct regulator_ops cros_ec_regulator_voltage_ops = {
> @@ -130,8 +130,8 @@ static int cros_ec_regulator_init_info(struct device *dev,
>         struct ec_response_regulator_get_info resp;
>         int ret;
>
> -       ret = cros_ec_command(data->ec_dev, 0, EC_CMD_REGULATOR_GET_INFO, &cmd,
> -                             sizeof(cmd), &resp, sizeof(resp));
> +       ret = cros_ec_cmd(data->ec_dev, 0, EC_CMD_REGULATOR_GET_INFO, &cmd,
> +                         sizeof(cmd), &resp, sizeof(resp));
>         if (ret < 0)
>                 return ret;
>
> diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
> index 138fd912c808..816da4eef3e5 100644
> --- a/include/linux/platform_data/cros_ec_proto.h
> +++ b/include/linux/platform_data/cros_ec_proto.h
> @@ -231,7 +231,7 @@ bool cros_ec_check_features(struct cros_ec_dev *ec, int feature);
>
>  int cros_ec_get_sensor_count(struct cros_ec_dev *ec);
>
> -int cros_ec_command(struct cros_ec_device *ec_dev, unsigned int version, int command, void *outdata,
> +int cros_ec_cmd(struct cros_ec_device *ec_dev, unsigned int version, int command, void *outdata,
>                     int outsize, void *indata, int insize);
>
>  /**
> --
> 2.36.1.255.ge46751e96f-goog
>
