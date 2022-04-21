Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E77B5097BE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 08:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243764AbiDUGjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 02:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiDUGjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:39:06 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDFDBC24
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 23:36:17 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id s18so8046887ejr.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 23:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WKuynMTHxmSCL5MLuqngJKsr8x3HYhon8V3FUCnYg1k=;
        b=OXyS2B0bI+8SuSfgqSseBFxiiTC+FZhMDRV7xqRPDZLphVaWSlUf7g1WiDEvpfQ58S
         Kl6J6Z5o8hYwFNC1h3x4GYmMOgR2HWU2B3F9CaM+KyXgwt/5LOESmTn4PBZHQSITaFQg
         4wxUF7G6dVyfE8Oo5L2TsKuf2EX4gwuLnfOKZa+0HpeIEB0AOLtwQjFV1bbPH50bgSxa
         KGZ17O+lH1uB0x+5S6L6RoqeMWyLMHEE4CTylyI54lnRkNU4LG2YHpSK2cfI7aww/dkD
         tFnU0jAvIWizrS/U3j39lbtsT1S8jFUPR5N2kuXMXswRxNgPCLxD6r+PUysVDayaaHEN
         u7zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WKuynMTHxmSCL5MLuqngJKsr8x3HYhon8V3FUCnYg1k=;
        b=cGu2AlaTMXnl3ChzAadhA1fQw0BPwN9yxsrLQ1QUP4HQXJVnv2B2HtheH7ZwX0N5ul
         jI7JMT7+nwOqub0Oavxtr5F/L/RMcznJ5B00EH4kQ23KznXLGcwdt/a/iYFIpolXb+MU
         hUwlOgm7WtOk3yKcIPGAQflz47fFSzkXeLLG5MfPTy7QwhPKMHYfOqze4WxhHYkziRR0
         1Wa+NGAxMuKBMBivg+q6sqQyzjsncgugIO8gjCmL+NeAje7Cix1n5tGUfbSUmG0y5Hyg
         drCcBv4tUGW1xY3nSdHU81sl8GqgI3RLRud4WgGF2hzVFfZKT/jKWIpVUj9oJamZthpl
         Ufrg==
X-Gm-Message-State: AOAM532tY94oxhJcTF9rONQziGhNoX5+8Yjk6wFTC0zNy252+x77PNrX
        6+xKi9eD/4wnpruZr4z5oLWv/v1R3X+7Cmm6Bcm1kzHUbuYQxw==
X-Google-Smtp-Source: ABdhPJzxFxXuDXDX9wwA8JtfrSF2KiBgxqan9YdS+vY8Ni8Nn22aWpv9uaYfRxAl9t/eIYp/5DXNxnyQM8CwLotM6U0=
X-Received: by 2002:a17:907:7d8d:b0:6e0:6216:3698 with SMTP id
 oz13-20020a1709077d8d00b006e062163698mr20749049ejc.144.1650522975789; Wed, 20
 Apr 2022 23:36:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220420142323.2078-1-etienne.carriere@linaro.org>
In-Reply-To: <20220420142323.2078-1-etienne.carriere@linaro.org>
From:   Etienne Carriere <etienne.carriere@linaro.org>
Date:   Thu, 21 Apr 2022 08:36:04 +0200
Message-ID: <CAN5uoS-xh03q2aZv8Gc2bi=3p=rGkd5rnqp=NBd+ZXyXY+-2RQ@mail.gmail.com>
Subject: Re: [PATCH] firmware: arm_scmi: support optee shared memory in optee transport
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

On Wed, 20 Apr 2022 at 16:23, Etienne Carriere
<etienne.carriere@linaro.org> wrote:
>
> Adds support for tee shared memory in optee scmi transport. When using
> tee shared memory, scmi optee transport manages SCMI messages using
> msg protocol (from msg.c) in shared memory, whereas smt (from shmem.c)
> protocol is used with static IOMEM shared buffers.
>
> Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> ---
>  drivers/firmware/arm_scmi/optee.c | 133 ++++++++++++++++++++++++------
>  1 file changed, 109 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/firmware/arm_scmi/optee.c b/drivers/firmware/arm_scmi/optee.c
> index 8302a2b4aeeb..6ff51b750b7b 100644
> --- a/drivers/firmware/arm_scmi/optee.c
> +++ b/drivers/firmware/arm_scmi/optee.c
> @@ -64,6 +64,22 @@ enum scmi_optee_pta_cmd {
>          * [in]     value[0].b: Requested capabilities mask (enum pta_scmi_caps)
>          */
>         PTA_SCMI_CMD_GET_CHANNEL = 3,
> +
> +       /*
> +        * PTA_SCMI_CMD_PROCESS_MSG_CHANNEL - Process SCMI message in a MSG
> +        * buffer pointed by memref parameters
> +        *
> +        * [in]     value[0].a: Channel handle
> +        * [in]     memref[1]: Message buffer (MSG and SCMI payload)
> +        * [out]    memref[2]: Response buffer (MSG and SCMI payload)
> +        *
> +        * Shared memories used for SCMI message/response are MSG buffers
> +        * referenced by param[1] and param[2]. MSG transport protocol
> +        * uses a 32bit header to carry SCMI meta-data (protocol ID and
> +        * protocol message ID) followed by the effective SCMI message
> +        * payload.
> +        */
> +       PTA_SCMI_CMD_PROCESS_MSG_CHANNEL = 4,
>  };
>
>  /*
> @@ -72,9 +88,17 @@ enum scmi_optee_pta_cmd {
>   * PTA_SCMI_CAPS_SMT_HEADER
>   * When set, OP-TEE supports command using SMT header protocol (SCMI shmem) in
>   * shared memory buffers to carry SCMI protocol synchronisation information.
> + *
> + * PTA_SCMI_CAPS_MSG_HEADER
> + * When set, OP-TEE supports command using MSG header protocol in an OP-TEE
> + * shared memory to carry SCMI protocol synchronisation information and SCMI
> + * message payload.
>   */
>  #define PTA_SCMI_CAPS_NONE             0
>  #define PTA_SCMI_CAPS_SMT_HEADER       BIT(0)
> +#define PTA_SCMI_CAPS_MSG_HEADER       BIT(1)
> +#define PTA_SCMI_CAPS_MASK             (PTA_SCMI_CAPS_SMT_HEADER | \
> +                                        PTA_SCMI_CAPS_MSG_HEADER)
>
>  /**
>   * struct scmi_optee_channel - Description of an OP-TEE SCMI channel
> @@ -85,7 +109,8 @@ enum scmi_optee_pta_cmd {
>   * @mu: Mutex protection on channel access
>   * @cinfo: SCMI channel information
>   * @shmem: Virtual base address of the shared memory
> - * @tee_shm: Reference to TEE shared memory or NULL if using static shmem
> + * @req: Shared memory protocol handle for SCMI request and synchronous response
> + * @tee_shm: TEE shared memory handle @req or NULL if using IOMEM shmem
>   * @link: Reference in agent's channel list
>   */
>  struct scmi_optee_channel {
> @@ -94,7 +119,10 @@ struct scmi_optee_channel {
>         u32 caps;
>         struct mutex mu;
>         struct scmi_chan_info *cinfo;
> -       struct scmi_shared_mem __iomem *shmem;
> +       union {
> +               struct scmi_shared_mem __iomem *shmem;
> +               struct scmi_msg_payld *msg;
> +       } req;
>         struct tee_shm *tee_shm;
>         struct list_head link;
>  };
> @@ -178,8 +206,8 @@ static int get_capabilities(struct scmi_optee_agent *agent)
>
>         caps = param[0].u.value.a;
>
> -       if (!(caps & PTA_SCMI_CAPS_SMT_HEADER)) {
> -               dev_err(agent->dev, "OP-TEE SCMI PTA doesn't support SMT\n");
> +       if (!(caps & (PTA_SCMI_CAPS_SMT_HEADER | PTA_SCMI_CAPS_MSG_HEADER))) {
> +               dev_err(agent->dev, "OP-TEE SCMI PTA doesn't support SMT and MSG\n");
>                 return -EOPNOTSUPP;
>         }
>
> @@ -193,9 +221,14 @@ static int get_channel(struct scmi_optee_channel *channel)
>         struct device *dev = scmi_optee_private->dev;
>         struct tee_ioctl_invoke_arg arg = { };
>         struct tee_param param[1] = { };
> -       unsigned int caps = PTA_SCMI_CAPS_SMT_HEADER;
> +       unsigned int caps = 0;
>         int ret;
>
> +       if (channel->tee_shm)
> +               caps = PTA_SCMI_CAPS_MSG_HEADER;
> +       else
> +               caps = PTA_SCMI_CAPS_SMT_HEADER;
> +
>         arg.func = PTA_SCMI_CMD_GET_CHANNEL;
>         arg.session = channel->tee_session;
>         arg.num_params = 1;
> @@ -249,6 +282,37 @@ static int invoke_process_smt_channel(struct scmi_optee_channel *channel)
>         return 0;
>  }
>
> +static int invoke_process_msg_channel(struct scmi_optee_channel *channel, size_t msg_size)
> +{
> +       struct tee_ioctl_invoke_arg arg = {
> +               .func = PTA_SCMI_CMD_PROCESS_MSG_CHANNEL,
> +               .session = channel->tee_session,
> +               .num_params = 3,
> +       };
> +       struct tee_param param[3] = { };
> +       int ret;
> +
> +       param[0].attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT;
> +       param[0].u.value.a = channel->channel_id;
> +
> +       param[1].attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT;
> +       param[1].u.memref.shm = channel->tee_shm;
> +       param[1].u.memref.size = msg_size;
> +
> +       param[2].attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT;
> +       param[2].u.memref.shm = channel->tee_shm;
> +       param[2].u.memref.size = SCMI_OPTEE_MAX_MSG_SIZE;
> +
> +       ret = tee_client_invoke_func(scmi_optee_private->tee_ctx, &arg, param);
> +       if (ret < 0 || arg.ret) {
> +               dev_err(scmi_optee_private->dev, "Can't invoke channel %u: %d / %#x\n",
> +                       channel->channel_id, ret, arg.ret);
> +               return -EIO;
> +       }
> +
> +       return 0;
> +}
> +
>  static int scmi_optee_link_supplier(struct device *dev)
>  {
>         if (!scmi_optee_private) {
> @@ -279,7 +343,26 @@ static void scmi_optee_clear_channel(struct scmi_chan_info *cinfo)
>  {
>         struct scmi_optee_channel *channel = cinfo->transport_info;
>
> -       shmem_clear_channel(channel->shmem);
> +       if (!channel->tee_shm)
> +               shmem_clear_channel(channel->req.shmem);
> +}
> +
> +static int setup_dynamic_shmem(struct device *dev, struct scmi_optee_channel *channel)
> +{
> +       const size_t msg_size = SCMI_OPTEE_MAX_MSG_SIZE;
> +       void *shbuf;
> +
> +       channel->tee_shm = tee_shm_alloc_kernel_buf(scmi_optee_private->tee_ctx, msg_size);
> +       if (IS_ERR(channel->tee_shm)) {
> +               dev_err(channel->cinfo->dev, "shmem allocation failed\n");
> +               return -ENOMEM;
> +       }
> +
> +       shbuf = tee_shm_get_va(channel->tee_shm, 0);
> +       memset(shbuf, 0, msg_size);
> +       channel->req.msg = shbuf;
> +
> +       return 0;
>  }
>
>  static int setup_static_shmem(struct device *dev, struct scmi_chan_info *cinfo,
> @@ -304,8 +387,8 @@ static int setup_static_shmem(struct device *dev, struct scmi_chan_info *cinfo,
>
>         size = resource_size(&res);
>
> -       channel->shmem = devm_ioremap(dev, res.start, size);
> -       if (!channel->shmem) {
> +       channel->req.shmem = devm_ioremap(dev, res.start, size);
> +       if (!channel->req.shmem) {
>                 dev_err(dev, "Failed to ioremap SCMI Tx shared memory\n");
>                 ret = -EADDRNOTAVAIL;
>                 goto out;
> @@ -325,7 +408,7 @@ static int setup_shmem(struct device *dev, struct scmi_chan_info *cinfo,
>         if (of_find_property(cinfo->dev->of_node, "shmem", NULL))
>                 return setup_static_shmem(dev, cinfo, channel);
>         else
> -               return -ENOMEM;
> +               return setup_dynamic_shmem(dev, channel);
>  }
>
>  static int scmi_optee_chan_setup(struct scmi_chan_info *cinfo, struct device *dev, bool tx)
> @@ -405,27 +488,27 @@ static int scmi_optee_chan_free(int id, void *p, void *data)
>         return 0;
>  }
>
> -static struct scmi_shared_mem __iomem *
> -get_channel_shm(struct scmi_optee_channel *chan, struct scmi_xfer *xfer)
> -{
> -       if (!chan)
> -               return NULL;
> -
> -       return chan->shmem;
> -}
> -
> -
>  static int scmi_optee_send_message(struct scmi_chan_info *cinfo,
>                                    struct scmi_xfer *xfer)
>  {
>         struct scmi_optee_channel *channel = cinfo->transport_info;
> -       struct scmi_shared_mem __iomem *shmem = get_channel_shm(channel, xfer);
> +       u32 scmi_msg_hdr;
>         int ret;
>
>         mutex_lock(&channel->mu);
> -       shmem_tx_prepare(shmem, xfer);
>
> -       ret = invoke_process_smt_channel(channel);
> +       if (channel->tee_shm) {
> +               msg_tx_prepare(channel->req.msg, xfer);
> +               ret = invoke_process_msg_channel(channel, msg_command_size(xfer));
> +               scmi_msg_hdr = msg_read_header(channel->req.msg);
> +       } else {
> +               shmem_tx_prepare(channel->req.shmem, xfer);
> +               ret = invoke_process_smt_channel(channel);
> +               scmi_msg_hdr = shmem_read_header(channel->req.shmem);
> +       }
> +
> +       scmi_rx_callback(cinfo, scmi_msg_hdr, NULL);

My mistake. Calling scmi_rx_callback() is not needed since
.sync_cmds_completed_on_ret flag is set.
I'll send a v2 removing this call.

Regards,
Etienne



> +
>         if (ret)
>                 mutex_unlock(&channel->mu);
>
> @@ -436,9 +519,11 @@ static void scmi_optee_fetch_response(struct scmi_chan_info *cinfo,
>                                       struct scmi_xfer *xfer)
>  {
>         struct scmi_optee_channel *channel = cinfo->transport_info;
> -       struct scmi_shared_mem __iomem *shmem = get_channel_shm(channel, xfer);
>
> -       shmem_fetch_response(shmem, xfer);
> +       if (channel->tee_shm)
> +               msg_fetch_response(channel->req.msg, SCMI_OPTEE_MAX_MSG_SIZE, xfer);
> +       else
> +               shmem_fetch_response(channel->req.shmem, xfer);
>  }
>
>  static void scmi_optee_mark_txdone(struct scmi_chan_info *cinfo, int ret,
> --
> 2.17.1
>
