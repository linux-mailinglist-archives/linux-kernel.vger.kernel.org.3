Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E872758E163
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 22:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbiHIUzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 16:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiHIUzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 16:55:21 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BCB827FD9
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 13:55:18 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id u9so15290695oiv.12
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 13:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=V3kd0GLzKy41gfQ9IEI3wn6TRwNxIiRQ8cwem/v8MbE=;
        b=y4Co9+i1jfCDVrDLWWMksvIzTuPmlOe+SSEEfU3kDlrTK5T0lN8WXhBZVsRDtgxvnN
         wgdMlhMiyPwYNYIWpDLxMj519AxU5hiKdqhZSw8ghi8FEfb+BpmVSZItYc8aAT72qs9i
         2qE8dEWoeKmReoDPl5vuxhNOiKfg+RFyVkkRYy9pd77B39M+FW75aAn0v1D396Iz2QK0
         tUBXRC8957BRMSTX1C/g4HdrTK9QfrdVchDZ8VVOm8KIDgUgJ4PNx9tmwls+fHD1vubs
         AJF29XqbYoWw1DIpgxXZLzr3eXr0XLayOz4nnMaErpXtQzZNy7BeY5SuIscdFAkmZ5sP
         gEnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=V3kd0GLzKy41gfQ9IEI3wn6TRwNxIiRQ8cwem/v8MbE=;
        b=jeFoH3w+arzcPTWXS6NQRUAdX19yXTL7NdSYW8wOkPzxI28KDJGYXPtB03xUkDDD+j
         v5OebkOD5SEeI1i90P4BH7UddJPLi87/G0Dw7dl16l98+6v8I+OoN0RUT55q5Gpc/wft
         gDAHXbgLUmmaq02LD2FwEmb27cNSe0UKmW+bLjP5HdAc0AyFkykha49s0e04Wf+qaBok
         Kne/gVkMxxdPCrMHYfbj+KMFj8SLwqTrT9S0QQTIs241YRULGDPBsXvvXK8XEQxvxq82
         ar7VS3aA/DPh+9bElXN7DgQpSeDOyDm65tCSFJqXaIZfs0EFqlYlWSGHDQphV1l/Ooyb
         R6Lg==
X-Gm-Message-State: ACgBeo2yMgsOLTP/R0FTEbgc+q9OM0Gda9p9WHjeQfGru9l/J84BuQCj
        tQVEUIMa90WiAsozyoLSgqgD6A==
X-Google-Smtp-Source: AA6agR42oUNVc/j41uT6xcpEvBEJj5bdqOMX4luQXF0PuTiXpkoYee+BxQ6EgNpmJGGPMHeTqz8Gnw==
X-Received: by 2002:a05:6808:2007:b0:343:f1e:1df3 with SMTP id q7-20020a056808200700b003430f1e1df3mr145381oiw.24.1660078517662;
        Tue, 09 Aug 2022 13:55:17 -0700 (PDT)
Received: from baldur ([2600:380:785a:7aa8:200:ff:fe00:0])
        by smtp.gmail.com with ESMTPSA id m16-20020a4abc90000000b004455b3dabd4sm204722oop.27.2022.08.09.13.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 13:55:17 -0700 (PDT)
Date:   Tue, 9 Aug 2022 15:55:14 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rajendra Nayak <quic_rjendra@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abel.vesa@linaro.org>
Subject: Re: [PATCH] soc: qcom: rpmhpd: Use highest corner until sync_state
Message-ID: <YvLJsm29h8eQwaQc@baldur>
References: <20220806155035.968340-1-bjorn.andersson@linaro.org>
 <cb0c6fbd-bf5c-b5ce-b4c5-8a605836204d@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb0c6fbd-bf5c-b5ce-b4c5-8a605836204d@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 08 Aug 03:17 CDT 2022, Rajendra Nayak wrote:

> 
> On 8/6/2022 9:20 PM, Bjorn Andersson wrote:
> > In some cases the hardware that the bootloader has left configured
> > depends on RPMH power domains for their operation up until the point
> > where the related Linux device driver probes and can inherit that
> > configuration, or power down the hardware gracefully.
> > 
> > Unfortunately as Linux probes the releavant drivers in sequence there
> > are periods during the Linux boot flow where either the genpd refcount
> > will reach 0, or worse where the active performance_state votes does not
> > meet the requirements of the state that the hardware was left in.
> > 
> > One specific example of this is during boot of e.g. SM8150/SC8180X,
> > where the display clock controller probes, without any particular
> > performance state needs (to access its registers). This will drop the
> > MMCX rail to MIN_SVS, which isn't sufficient to sustain the clock rates
> > that the later probing MDP is configured to. This results in an
> > unrecoverable system state.
> > 
> > Handle both these cases by keeping the RPMH power-domais that are
> > referenced voted for highest state, until sync_state indicates that all
> > devices referencing the RPMH power-domain driver has been probed.
> > 
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> >   drivers/soc/qcom/rpmhpd.c | 35 ++++++++++++++++++++++++++++++++++-
> >   1 file changed, 34 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
> > index 092f6ab09acf..494bb6c75ed7 100644
> > --- a/drivers/soc/qcom/rpmhpd.c
> > +++ b/drivers/soc/qcom/rpmhpd.c
> > @@ -39,6 +39,7 @@
> >    * @res_name:		Resource name used for cmd-db lookup
> >    * @addr:		Resource address as looped up using resource name from
> >    *			cmd-db
> > + * @state_synced:       Indicator that sync_state has been invoked for the rpmhpd resource
> >    */
> >   struct rpmhpd {
> >   	struct device	*dev;
> > @@ -54,6 +55,7 @@ struct rpmhpd {
> >   	bool		enabled;
> >   	const char	*res_name;
> >   	u32		addr;
> > +	bool		state_synced;
> >   };
> >   struct rpmhpd_desc {
> > @@ -493,7 +495,13 @@ static int rpmhpd_aggregate_corner(struct rpmhpd *pd, unsigned int corner)
> >   	unsigned int this_active_corner = 0, this_sleep_corner = 0;
> >   	unsigned int peer_active_corner = 0, peer_sleep_corner = 0;
> > -	to_active_sleep(pd, corner, &this_active_corner, &this_sleep_corner);
> > +	if (pd->state_synced) {
> > +		to_active_sleep(pd, corner, &this_active_corner, &this_sleep_corner);
> > +	} else {
> > +		/* Clamp to highest corner if sync_state hasn't happened */
> > +		this_active_corner = pd->level_count - 1;
> > +		this_sleep_corner = pd->level_count - 1;
> > +	}
> >   	if (peer && peer->enabled)
> >   		to_active_sleep(peer, peer->corner, &peer_active_corner,
> > @@ -708,11 +716,36 @@ static int rpmhpd_probe(struct platform_device *pdev)
> >   	return of_genpd_add_provider_onecell(pdev->dev.of_node, data);
> >   }
> > +static void rpmhpd_sync_state(struct device *dev)
> > +{
> > +	const struct rpmhpd_desc *desc = of_device_get_match_data(dev);
> > +	struct rpmhpd **rpmhpds = desc->rpmhpds;
> > +	unsigned int corner;
> > +	struct rpmhpd *pd;
> > +	unsigned int i;
> > +
> > +	mutex_lock(&rpmhpd_lock);
> > +	for (i = 0; i < desc->num_pds; i++) {
> > +		pd = rpmhpds[i];
> > +		if (!pd)
> > +			continue;
> > +
> > +		pd->state_synced = true;
> []
> 
> > +		if (pd->enabled)
> > +			corner = max(pd->corner, pd->enable_corner);
> > +		else
> > +			corner = 0;
> > +		rpmhpd_aggregate_corner(pd, corner);
> 
> can't this be
> 		if (pd->enabled) {
> 			corner = max(pd->corner, pd->enable_corner);
> 			rpmhpd_aggregate_corner(pd, corner);
> 		}

Please correct me if I'm wrong, but that would imply that if the
power-domain was disabled by all clients when we hit the sync_state we
would be left at max state until one of them tickles it again.

The way it's written here means that in addition to keeping things at
the highest corner we also keep it on until sync_state hits - but no
longer.

> 
> also, we do check for return value of rpmhpd_aggregate_corner() but I guess
> here there isn't much different we would do even if there is an error?
> 

You're right, ignoring the return value here means that an error would
be completely silent. There's not much we can do about it, but it might
be useful to the developer to know that this happened.

So a dev_err() seems in order.

Thanks,
Bjorn

> > +	}
> > +	mutex_unlock(&rpmhpd_lock);
> > +}
> > +
> >   static struct platform_driver rpmhpd_driver = {
> >   	.driver = {
> >   		.name = "qcom-rpmhpd",
> >   		.of_match_table = rpmhpd_match_table,
> >   		.suppress_bind_attrs = true,
> > +		.sync_state = rpmhpd_sync_state,
> >   	},
> >   	.probe = rpmhpd_probe,
> >   };
