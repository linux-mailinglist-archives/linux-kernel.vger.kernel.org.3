Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 681F34C8A5B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 12:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234464AbiCALME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 06:12:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbiCALMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 06:12:00 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA6B574B6
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 03:11:19 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id i1so12267709ila.7
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 03:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fj0SLbJAFPPDyHux4es9GyIDIVS++BeLuXmN1cXaQ5c=;
        b=rIE6j3yGSulZ+uo7r9Qs4gn8AaF0CyuXRT0NkbUhlPyvuf/XVrk8MtkLoQnKAVo1kM
         K8VGeerumaZhlY48Fxbyz8STicFSduxHogjZAL0h9lmMhLMI9MeGdng/17JDSxjnOzED
         NGx2blwFDRdt+lE5M3ur5E24dcm017YY18FznMKMz09wxLSnhqNYSFF6Bi7Vx9Cub/Dp
         G3i52kaWGgb2bCpa1mg8tw/7K1VcrjO1/SnoImgypbLTN1UwAAMiLZ1pebn/EaE2s8Zd
         vquAaO2ERvTORvorZ/EfUCtjXY7V+yJcHFulEDzZQyEUCcYgJCwwQkehvhXQenNQ19sU
         C8hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fj0SLbJAFPPDyHux4es9GyIDIVS++BeLuXmN1cXaQ5c=;
        b=NM2wkY3sUk0guFyggKEQGH1KziuPrYYYCaLGtZicV8OaVUJAuQW5Edp9zkMWGGfeTG
         wNYk50NLjxtmY1MGgOCzwXK4kBaMFuQrdN2lBvj/6F0bYaggudxxIzbqInWF28XRoe7o
         gZvNlfraLz2ai7wc22CB7Znkai4c7AXBMPhsbvrgJ4ybwiYglxLWh4nrMxQS1ebEFeeO
         PKcWxvGCt/ymYOYjArcD3GEbEGc49ycx1ELH+umuBXBcoZETqOj5euN7txNA3PWa/1wY
         vRHVaTaig11pK3/fGbmMrRrIMm5f0+12ygFnsHW6YsBSAmfdeFGAlq9Yh4DZhOvs55NA
         KeIw==
X-Gm-Message-State: AOAM532y3eUihqiycYDn0hw5XIszeJaoNKV3zOw/Rz+sh8v9xCYn3uyo
        E1+/YxDqHjaL8f7iNQV09jVZMQ==
X-Google-Smtp-Source: ABdhPJxg4iN6Dj35P4F0h/z9aXBxCXkPyblS6rfnGHk6e854HYXYU9vXpykyzFw4GYGendvx32L29A==
X-Received: by 2002:a05:6e02:1a6c:b0:2c2:4653:eb4 with SMTP id w12-20020a056e021a6c00b002c246530eb4mr22070473ilv.227.1646133078557;
        Tue, 01 Mar 2022 03:11:18 -0800 (PST)
Received: from [172.22.22.26] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id i3-20020a056e021b0300b002c272157f3bsm7779867ilv.81.2022.03.01.03.11.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 03:11:17 -0800 (PST)
Message-ID: <1488c55b-4481-a4fc-a2af-a2bef0b41f83@linaro.org>
Date:   Tue, 1 Mar 2022 05:11:16 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] interconnect: Add stubs for the bulk API
Content-Language: en-US
To:     Georgi Djakov <djakov@kernel.org>
Cc:     bjorn.andersson@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220301090735.26599-1-djakov@kernel.org>
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <20220301090735.26599-1-djakov@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/22 3:07 AM, Georgi Djakov wrote:
> Add stub functions for the bulk API to allow compile testing.
> 
> Signed-off-by: Georgi Djakov <djakov@kernel.org>

I have this patch--almost exactly--sitting in my queue waiting
for another to get accepted.

Thanks Georgi, it looks good to me.

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>   include/linux/interconnect.h | 36 +++++++++++++++++++++++++++++-------
>   1 file changed, 29 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/interconnect.h b/include/linux/interconnect.h
> index f2dd2fc8d3cd..f685777b875e 100644
> --- a/include/linux/interconnect.h
> +++ b/include/linux/interconnect.h
> @@ -38,13 +38,6 @@ struct icc_bulk_data {
>   	u32 peak_bw;
>   };
>   
> -int __must_check of_icc_bulk_get(struct device *dev, int num_paths,
> -				 struct icc_bulk_data *paths);
> -void icc_bulk_put(int num_paths, struct icc_bulk_data *paths);
> -int icc_bulk_set_bw(int num_paths, const struct icc_bulk_data *paths);
> -int icc_bulk_enable(int num_paths, const struct icc_bulk_data *paths);
> -void icc_bulk_disable(int num_paths, const struct icc_bulk_data *paths);
> -
>   #if IS_ENABLED(CONFIG_INTERCONNECT)
>   
>   struct icc_path *icc_get(struct device *dev, const int src_id,
> @@ -58,6 +51,12 @@ int icc_disable(struct icc_path *path);
>   int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw);
>   void icc_set_tag(struct icc_path *path, u32 tag);
>   const char *icc_get_name(struct icc_path *path);
> +int __must_check of_icc_bulk_get(struct device *dev, int num_paths,
> +				 struct icc_bulk_data *paths);
> +void icc_bulk_put(int num_paths, struct icc_bulk_data *paths);
> +int icc_bulk_set_bw(int num_paths, const struct icc_bulk_data *paths);
> +int icc_bulk_enable(int num_paths, const struct icc_bulk_data *paths);
> +void icc_bulk_disable(int num_paths, const struct icc_bulk_data *paths);
>   
>   #else
>   
> @@ -112,6 +111,29 @@ static inline const char *icc_get_name(struct icc_path *path)
>   	return NULL;
>   }
>   
> +static inline int of_icc_bulk_get(struct device *dev, int num_paths, struct icc_bulk_data *paths)
> +{
> +	return 0;
> +}
> +
> +static inline void icc_bulk_put(int num_paths, struct icc_bulk_data *paths)
> +{
> +}
> +
> +static inline int icc_bulk_set_bw(int num_paths, const struct icc_bulk_data *paths)
> +{
> +	return 0;
> +}
> +
> +static inline int icc_bulk_enable(int num_paths, const struct icc_bulk_data *paths)
> +{
> +	return 0;
> +}
> +
> +static inline void icc_bulk_disable(int num_paths, const struct icc_bulk_data *paths)
> +{
> +}
> +
>   #endif /* CONFIG_INTERCONNECT */
>   
>   #endif /* __LINUX_INTERCONNECT_H */

