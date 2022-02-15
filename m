Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7A54B7A9B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 23:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244626AbiBOWk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 17:40:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244717AbiBOWk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 17:40:56 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5FEC12D5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 14:40:45 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id 24so229972ioe.7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 14:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=NAChw+hiqySRtT5lFZamqaOkHF7+UdMed1yWTO7hPco=;
        b=QmgtFDdnWbSOynDL7bHicQtuY2xqel/5AmiOvaB2ij/8eG5S76lOzRQLKT0AiS/sEV
         SynZqxVKdDr9Lfj4N05mArX0f+sZ+lQc88rPXIytVLT4gQ92aC/M2DPsuJyVatE6bLlY
         cAwFoOWh2GIY9O2egGbYY2fwUIsDC+HzyrxqUMKZ1GQ2414ZTTlN02Kfrb2lWT2F35I+
         QQDf1IS51zgB5nnVKZXNdigWt7sfyrcixT/nq8zjTpbolldB4KSvzgpll+o6bQl2DjJn
         NVRtRro8+v+zHSxOEfoz35Fv4gVizeC2riFgbnwFwnkHTNm5bFndDhvCHozn2QcZ+zFe
         HluA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NAChw+hiqySRtT5lFZamqaOkHF7+UdMed1yWTO7hPco=;
        b=ItCQTFa0dm6mYXwQMcpnopzQWYE5lH/o2eTTIfX7trdjGzbhajeOQtnnMb015iPGnM
         qedGFNcSPbDYS5fe1eo2frtDRMKM7x9rG8dMtA+ivdPOdgh4RRkPLNN61FzNjr8cLQ78
         cNJBW9US/d/5vG/8qF0A7UT2frNsm0uoAECiAdiS3zJ7HuVVW4RtIyGdTaBPpblrZ9SC
         cM9UHv7Z2bAkaqYM/hIWq47x1C/5I3V5b03V562b0eS7mdIDDqM1SKne2qQOQe8+kstZ
         lUn4aMXbgne22kromAXg0HoqTuXIYPUWPS6acKHxvyGyKuAlDU7NYmABqMYLOzVyNaMl
         V0fw==
X-Gm-Message-State: AOAM533sBVRNtGStT7DOvtI4AbNS/jkYfpaR7E+GLu5NfEZpm1eG2yMz
        T0+UIHhXO9ToYsp42Fpyy81j2A==
X-Google-Smtp-Source: ABdhPJy97qIXRtee/cwA9QDvGDMMcW7NHPaAf9UoOi2hJJBivCxjR9bSAF5tFasPd6q8M4GpauUocQ==
X-Received: by 2002:a05:6602:490:b0:638:c8ed:1e38 with SMTP id y16-20020a056602049000b00638c8ed1e38mr13085iov.202.1644964845019;
        Tue, 15 Feb 2022 14:40:45 -0800 (PST)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id f15sm8851041ila.86.2022.02.15.14.40.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 14:40:44 -0800 (PST)
Message-ID: <971f1cfc-b74d-8fdb-e5ff-89af27331be1@linaro.org>
Date:   Tue, 15 Feb 2022 16:40:43 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 25/25] bus: mhi: ep: Add uevent support for module
 autoloading
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        mhi@lists.linux.dev
Cc:     quic_hemantk@quicinc.com, quic_bbhatt@quicinc.com,
        quic_jhugo@quicinc.com, vinod.koul@linaro.org,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        quic_vbadigan@quicinc.com, quic_cang@quicinc.com,
        quic_skananth@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220212182117.49438-1-manivannan.sadhasivam@linaro.org>
 <20220212182117.49438-26-manivannan.sadhasivam@linaro.org>
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <20220212182117.49438-26-manivannan.sadhasivam@linaro.org>
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

On 2/12/22 12:21 PM, Manivannan Sadhasivam wrote:
> Add uevent support to MHI endpoint bus so that the client drivers can be
> autoloaded by udev when the MHI endpoint devices gets created. The client
> drivers are expected to provide MODULE_DEVICE_TABLE with the MHI id_table
> struct so that the alias can be exported.
> 
> The MHI endpoint reused the mhi_device_id structure of the MHI bus.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Looks OK to me.

Reviewed-by: Alex Elder <elder@linaro.org>


Next time I review this, I think I'll review the code
in its entirety (i.e., with the entire series applied
rather than in steps).  At that point I'm sure it will
be nearly perfect.

					-Alex

> ---
>   drivers/bus/mhi/ep/main.c       |  9 +++++++++
>   include/linux/mod_devicetable.h |  2 ++
>   scripts/mod/file2alias.c        | 10 ++++++++++
>   3 files changed, 21 insertions(+)
> 
> diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
> index 315409705b91..8889382ee8d0 100644
> --- a/drivers/bus/mhi/ep/main.c
> +++ b/drivers/bus/mhi/ep/main.c
> @@ -1546,6 +1546,14 @@ void mhi_ep_driver_unregister(struct mhi_ep_driver *mhi_drv)
>   }
>   EXPORT_SYMBOL_GPL(mhi_ep_driver_unregister);
>   
> +static int mhi_ep_uevent(struct device *dev, struct kobj_uevent_env *env)
> +{
> +	struct mhi_ep_device *mhi_dev = to_mhi_ep_device(dev);
> +
> +	return add_uevent_var(env, "MODALIAS=" MHI_EP_DEVICE_MODALIAS_FMT,
> +					mhi_dev->name);
> +}
> +
>   static int mhi_ep_match(struct device *dev, struct device_driver *drv)
>   {
>   	struct mhi_ep_device *mhi_dev = to_mhi_ep_device(dev);
> @@ -1572,6 +1580,7 @@ struct bus_type mhi_ep_bus_type = {
>   	.name = "mhi_ep",
>   	.dev_name = "mhi_ep",
>   	.match = mhi_ep_match,
> +	.uevent = mhi_ep_uevent,
>   };
>   
>   static int __init mhi_ep_init(void)
> diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
> index 4bb71979a8fd..0cff19bd72bf 100644
> --- a/include/linux/mod_devicetable.h
> +++ b/include/linux/mod_devicetable.h
> @@ -835,6 +835,8 @@ struct wmi_device_id {
>   #define MHI_DEVICE_MODALIAS_FMT "mhi:%s"
>   #define MHI_NAME_SIZE 32
>   
> +#define MHI_EP_DEVICE_MODALIAS_FMT "mhi_ep:%s"
> +
>   /**
>    * struct mhi_device_id - MHI device identification
>    * @chan: MHI channel name
> diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
> index 5258247d78ac..d9d6a31446ea 100644
> --- a/scripts/mod/file2alias.c
> +++ b/scripts/mod/file2alias.c
> @@ -1391,6 +1391,15 @@ static int do_mhi_entry(const char *filename, void *symval, char *alias)
>   	return 1;
>   }
>   
> +/* Looks like: mhi_ep:S */
> +static int do_mhi_ep_entry(const char *filename, void *symval, char *alias)
> +{
> +	DEF_FIELD_ADDR(symval, mhi_device_id, chan);
> +	sprintf(alias, MHI_EP_DEVICE_MODALIAS_FMT, *chan);
> +
> +	return 1;
> +}
> +
>   /* Looks like: ishtp:{guid} */
>   static int do_ishtp_entry(const char *filename, void *symval, char *alias)
>   {
> @@ -1519,6 +1528,7 @@ static const struct devtable devtable[] = {
>   	{"tee", SIZE_tee_client_device_id, do_tee_entry},
>   	{"wmi", SIZE_wmi_device_id, do_wmi_entry},
>   	{"mhi", SIZE_mhi_device_id, do_mhi_entry},
> +	{"mhi_ep", SIZE_mhi_device_id, do_mhi_ep_entry},
>   	{"auxiliary", SIZE_auxiliary_device_id, do_auxiliary_entry},
>   	{"ssam", SIZE_ssam_device_id, do_ssam_entry},
>   	{"dfl", SIZE_dfl_device_id, do_dfl_entry},

