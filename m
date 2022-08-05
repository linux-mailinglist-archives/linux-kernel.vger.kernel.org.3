Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB0858AF31
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 19:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241035AbiHERwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 13:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241383AbiHERw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 13:52:27 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD9571BC9
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 10:52:25 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id q9-20020a17090a2dc900b001f58bcaca95so2149096pjm.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 10:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/cE83btomUIgrJts3c8glJP2T2vlJUmo9Trmde0fIKk=;
        b=hWRya6Fw+uO87JaMtvVrVKsIlLQb3d1uRscshzlFi55Qc1Pc6eJ3cs50gxc9XE/ukg
         AhjXvMuapsexgCTpj2RGn/w3NP1iQvH0PnlOicGEDu3EA2vhV2eS7orqNCSeuD/pU4l8
         eQz5cgKfVfODCu8H7IGtF1uwcYON2Gonw8854=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/cE83btomUIgrJts3c8glJP2T2vlJUmo9Trmde0fIKk=;
        b=QMb2MD3G6ROJ3RGx6SReFBHuyBUWasJJr5BmpodrncfmZYLgJjAjA2lZ1PVPrV9RvX
         QiHOpDOKoKM8QDvvRhK9SEkYyXdMJbPRYLPAic2DuCwAffxXe6vmqrdeq0ACTVSNwZV3
         RB1vNmqm6RjZ3UlNKFLhfzcSUBIMnpP6w8eD9B2XLbY4WcDfSlNMQNhIKfQwaLzvqm3Z
         waAmLAz4pZWubPm2eYFBWIy7hWKAJXE+9vICJxpEK1ny6oZsP4MFEPRQtWuFUrbZeLON
         /TZ/TpW3Rtnjt5p1yeh2ccoTX520bNNCtATC4mMRlef/SuJ02wrsoMkleurlUcO6Arqp
         +wRg==
X-Gm-Message-State: ACgBeo00iG8LzVZUgo7MIeaNypzmbO0pGvU2kru+ELIa/ZZ0Yhwlkv0b
        VcvNo5nQ7IiZcGiXWMybD1VfE8obvxcLAA==
X-Google-Smtp-Source: AA6agR5wOtE/eyx8fZWxoKNB3EaPPhF8anZ8wEWmDQ6MJ8W+jOFx/0dxkqy/RkV1ikTTlhD0C+I9mQ==
X-Received: by 2002:a17:902:848e:b0:16c:f6c7:bc3c with SMTP id c14-20020a170902848e00b0016cf6c7bc3cmr7801896plo.159.1659721944743;
        Fri, 05 Aug 2022 10:52:24 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:c59c:1680:614c:3338])
        by smtp.gmail.com with UTF8SMTPSA id h13-20020a170902f70d00b0016f0c2ea158sm3286656plo.157.2022.08.05.10.52.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 10:52:24 -0700 (PDT)
Date:   Fri, 5 Aug 2022 10:52:22 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] usb: dwc3: qcom: clean up icc init
Message-ID: <Yu1Y1nDCyzKhJUAI@google.com>
References: <20220805074500.21469-1-johan+linaro@kernel.org>
 <20220805074500.21469-3-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220805074500.21469-3-johan+linaro@kernel.org>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2022 at 09:45:00AM +0200, Johan Hovold wrote:
> Clean up the interconnect-initialisation helper by increasing
> indentation of (or merging) continuation lines and adding brackets
> around multi-line blocks in order to improve readability.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/usb/dwc3/dwc3-qcom.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
> index 196efa9f2545..f2ff4fe1490a 100644
> --- a/drivers/usb/dwc3/dwc3-qcom.c
> +++ b/drivers/usb/dwc3/dwc3-qcom.c
> @@ -253,7 +253,7 @@ static int dwc3_qcom_interconnect_init(struct dwc3_qcom *qcom)
>  	qcom->icc_path_ddr = of_icc_get(dev, "usb-ddr");
>  	if (IS_ERR(qcom->icc_path_ddr)) {
>  		dev_err(dev, "failed to get usb-ddr path: %ld\n",
> -			PTR_ERR(qcom->icc_path_ddr));
> +				PTR_ERR(qcom->icc_path_ddr));

What's wrong with the existing indentation? It looks similar to the indentation
changes you do below for icc_set_bw().

Maybe your preference is double indentation for continuation lines rather than
aligning them roughly with the opening parenthesis of the calling function?

>  		return PTR_ERR(qcom->icc_path_ddr);
>  	}
>  
> @@ -265,20 +265,19 @@ static int dwc3_qcom_interconnect_init(struct dwc3_qcom *qcom)
>  	}
>  
>  	max_speed = usb_get_maximum_speed(&qcom->dwc3->dev);
> -	if (max_speed >= USB_SPEED_SUPER || max_speed == USB_SPEED_UNKNOWN)
> +	if (max_speed >= USB_SPEED_SUPER || max_speed == USB_SPEED_UNKNOWN) {
>  		ret = icc_set_bw(qcom->icc_path_ddr,
> -			USB_MEMORY_AVG_SS_BW, USB_MEMORY_PEAK_SS_BW);
> -	else
> +				USB_MEMORY_AVG_SS_BW, USB_MEMORY_PEAK_SS_BW);
> +	} else {
>  		ret = icc_set_bw(qcom->icc_path_ddr,
> -			USB_MEMORY_AVG_HS_BW, USB_MEMORY_PEAK_HS_BW);
> -
> +				USB_MEMORY_AVG_HS_BW, USB_MEMORY_PEAK_HS_BW);
> +	}
>  	if (ret) {
>  		dev_err(dev, "failed to set bandwidth for usb-ddr path: %d\n", ret);
>  		return ret;
>  	}
>  
> -	ret = icc_set_bw(qcom->icc_path_apps,
> -		APPS_USB_AVG_BW, APPS_USB_PEAK_BW);
> +	ret = icc_set_bw(qcom->icc_path_apps, APPS_USB_AVG_BW, APPS_USB_PEAK_BW);
>  	if (ret) {
>  		dev_err(dev, "failed to set bandwidth for apps-usb path: %d\n", ret);
>  		return ret;

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
