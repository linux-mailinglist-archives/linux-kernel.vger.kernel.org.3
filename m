Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF2D58B82C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 22:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiHFUU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 16:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbiHFUUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 16:20:55 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF57F5B6
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 13:20:53 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id w15so6291547ljw.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Aug 2022 13:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=QVvsJ9CeX2LySg7T0a1qFniCTfiEl+1nmmOnQ6I/W54=;
        b=m0DytzPcDjf+Z/i78J8beCsf8lFs2h7nq5LA4XoB4RUuZ6OuqRiCPaHU1ADZ9nasVx
         UGLfqyKfPfGFA+imUTd8FtvIu/MH0sCh2b3ofv3W9Nu/H7JA9LpbIK+gksqQGV6KQZFh
         hAGvJJveTRt0y6G0hClbxtTvtD6EwyWdO3I+zGrQBuWdDXKMzEMIlrzcv8w0pUroXL8A
         jCqRnOkSFaHiVyLNyAVzyB1a3wanG3QxIcVLjeALGjruziQ6jnVEOn6Qd+WcjeMKQ0i/
         VnQae5ZHloUn7l9pnWA9BW5bGo9iedpcapJOeyvtqNr4WypkPe+wjGeFsZjsBexun7Jj
         X0mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=QVvsJ9CeX2LySg7T0a1qFniCTfiEl+1nmmOnQ6I/W54=;
        b=KxwwFQ6CJKAEE7mY6T8jPkToQERFB/AOZZqqBWOyxyK22c/uL5NCSo+SCv3DirLiFj
         MqnUkpXO62kc8s2K61C4qZjKqmlwBDyWbCZVj1sfYcIGDJSj2JPwO7ZvjtZzKhfZ9slW
         /vgVP5bnN7oWoV7NrysZy6p4ukvLFeLwSLa4GWzQPCny1IdOBAZ1ZicltoTS8u1ovi/r
         sEu/eMj/+eG9Ba2CqCXTr1PUC/8DiajQblKwyYkEF6ka+da4iyqroem+REkX9uPE5/Ro
         oVIOtSjR/MWfcwvmv18AEaPWNurZ0tFbwWrwg4JxflDOWflnsFYYlvFDcZPUrWbDK0dM
         Lz4w==
X-Gm-Message-State: ACgBeo3nrCE1VvhTuoUK4+vnQX2d+Hpw6L8qBkNRZyUXUT4eXteV+fT8
        AsLb2mYi0rZf+p3V3xvnShik9w==
X-Google-Smtp-Source: AA6agR5Kqg8Mpuqsnv2emPbDL4T7Y79AFQz4eRCHargpsWvNUlbqO8mxGrJxanpWRr3pij4v4ogvgg==
X-Received: by 2002:a2e:921a:0:b0:25e:b171:1f39 with SMTP id k26-20020a2e921a000000b0025eb1711f39mr2132144ljg.3.1659817251284;
        Sat, 06 Aug 2022 13:20:51 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id be9-20020a056512250900b0048b03ec561fsm866689lfb.150.2022.08.06.13.20.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Aug 2022 13:20:50 -0700 (PDT)
Message-ID: <a739ee26-eb43-d754-ce16-3fe95cc713c1@linaro.org>
Date:   Sat, 6 Aug 2022 23:20:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] soc: qcom: rpmhpd: Use highest corner until sync_state
Content-Language: en-GB
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abel.vesa@linaro.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
References: <20220806155035.968340-1-bjorn.andersson@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220806155035.968340-1-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/08/2022 18:50, Bjorn Andersson wrote:
> In some cases the hardware that the bootloader has left configured
> depends on RPMH power domains for their operation up until the point
> where the related Linux device driver probes and can inherit that
> configuration, or power down the hardware gracefully.
> 
> Unfortunately as Linux probes the releavant drivers in sequence there
> are periods during the Linux boot flow where either the genpd refcount
> will reach 0, or worse where the active performance_state votes does not
> meet the requirements of the state that the hardware was left in.
> 
> One specific example of this is during boot of e.g. SM8150/SC8180X,
> where the display clock controller probes, without any particular
> performance state needs (to access its registers). This will drop the
> MMCX rail to MIN_SVS, which isn't sufficient to sustain the clock rates
> that the later probing MDP is configured to. This results in an
> unrecoverable system state.
> 
> Handle both these cases by keeping the RPMH power-domais that are
> referenced voted for highest state, until sync_state indicates that all
> devices referencing the RPMH power-domain driver has been probed.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   drivers/soc/qcom/rpmhpd.c | 35 ++++++++++++++++++++++++++++++++++-
>   1 file changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
> index 092f6ab09acf..494bb6c75ed7 100644
> --- a/drivers/soc/qcom/rpmhpd.c
> +++ b/drivers/soc/qcom/rpmhpd.c
> @@ -39,6 +39,7 @@
>    * @res_name:		Resource name used for cmd-db lookup
>    * @addr:		Resource address as looped up using resource name from
>    *			cmd-db
> + * @state_synced:       Indicator that sync_state has been invoked for the rpmhpd resource
>    */
>   struct rpmhpd {
>   	struct device	*dev;
> @@ -54,6 +55,7 @@ struct rpmhpd {
>   	bool		enabled;
>   	const char	*res_name;
>   	u32		addr;
> +	bool		state_synced;
>   };
>   
>   struct rpmhpd_desc {
> @@ -493,7 +495,13 @@ static int rpmhpd_aggregate_corner(struct rpmhpd *pd, unsigned int corner)
>   	unsigned int this_active_corner = 0, this_sleep_corner = 0;
>   	unsigned int peer_active_corner = 0, peer_sleep_corner = 0;
>   
> -	to_active_sleep(pd, corner, &this_active_corner, &this_sleep_corner);
> +	if (pd->state_synced) {
> +		to_active_sleep(pd, corner, &this_active_corner, &this_sleep_corner);
> +	} else {
> +		/* Clamp to highest corner if sync_state hasn't happened */
> +		this_active_corner = pd->level_count - 1;
> +		this_sleep_corner = pd->level_count - 1;
> +	}
>   
>   	if (peer && peer->enabled)
>   		to_active_sleep(peer, peer->corner, &peer_active_corner,
> @@ -708,11 +716,36 @@ static int rpmhpd_probe(struct platform_device *pdev)
>   	return of_genpd_add_provider_onecell(pdev->dev.of_node, data);
>   }
>   
> +static void rpmhpd_sync_state(struct device *dev)
> +{
> +	const struct rpmhpd_desc *desc = of_device_get_match_data(dev);
> +	struct rpmhpd **rpmhpds = desc->rpmhpds;
> +	unsigned int corner;
> +	struct rpmhpd *pd;
> +	unsigned int i;
> +
> +	mutex_lock(&rpmhpd_lock);
> +	for (i = 0; i < desc->num_pds; i++) {
> +		pd = rpmhpds[i];
> +		if (!pd)
> +			continue;
> +
> +		pd->state_synced = true;
> +		if (pd->enabled)
> +			corner = max(pd->corner, pd->enable_corner);
> +		else
> +			corner = 0;
> +		rpmhpd_aggregate_corner(pd, corner);
> +	}
> +	mutex_unlock(&rpmhpd_lock);
> +}
> +
>   static struct platform_driver rpmhpd_driver = {
>   	.driver = {
>   		.name = "qcom-rpmhpd",
>   		.of_match_table = rpmhpd_match_table,
>   		.suppress_bind_attrs = true,
> +		.sync_state = rpmhpd_sync_state,
>   	},
>   	.probe = rpmhpd_probe,
>   };


-- 
With best wishes
Dmitry
