Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E604158112A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 12:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbiGZK1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 06:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238662AbiGZK1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 06:27:19 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49FA63244F
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 03:27:16 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id t17so9733274lfk.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 03:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=TMi+bjKy7+WtWPXtstlGwzQClNVWhga6kNx+LvTNJdY=;
        b=cGoPyMRCRG1wVftIfDL0na3cR29l2mbznyINOy4G21vt7LkfhPNzCVn6pGP92k84OI
         B3r9JWWwZgF1DS4ZIMn3FDhOdugj7ni01vQWYboEGeYxzRzryZesnfwyOvY8p/pMz1HT
         ks4iYsZYSEOo+pUjiKWCGNcizbTnIgv4nmxUGCM7DKfpjutAecKTuRiur6oobhlZSRjh
         UDCx0GnkIvsg0RZ4BgdyCV5pjqFrvHEvqatCcqBFiBlZ+Z0HUzNEe+gSWzD+A4/FOdoS
         iiFiGL59QhmvJkx7/w1ZlV+2Fj0LPrBzQ+XLbeqBExysWr1e0n55QPV79+oHnPJXlH0L
         ZzZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TMi+bjKy7+WtWPXtstlGwzQClNVWhga6kNx+LvTNJdY=;
        b=CWK3j7H1mcB3hADh8286E2RWD5XSWZ3vYMPEKauuywm+o8XkXjpLy1W2iIjvvo+Maq
         vOe2F+hbTveU69LNQTnNhCRT4ZJJda3OpKZI66VNgt9ifcdyNtPmJUMHEbTtGKucvLa3
         4EVtNBxnjDo2/Q8Ew9nAG3gCfwz1K5OTmLch2cQ/fwunSbmUPH6G/Tg51JD2P4l20GLj
         kw7kLDxBHNjO/tYC//digeDUEQ5oTpT/epoGSadTOv7+eAYaFugxC7Ex3OuxBnZyzET9
         GzbBK56gI1tWVNICGNxJL6FSdmSUdUieqSPbbcf2Vn1riOC/eVFpCybdonqrX3FxmwS3
         f4WA==
X-Gm-Message-State: AJIora8Ns7rGUGIgTq6yH7aQ0+RHEhnRMO/XnOGRrNa4aOU60HAilJJ9
        1SD79P+R/zhO87IZfYxqYQ3vPg==
X-Google-Smtp-Source: AGRyM1uo4j3H6oHQ9Qu/k+9ltEMAux8NWWJeXFv14NJa5aTEhvH9PCsvcwnh/gZG5kUyOKOSY2asMQ==
X-Received: by 2002:a05:6512:3503:b0:481:4470:4134 with SMTP id h3-20020a056512350300b0048144704134mr6017873lfs.42.1658831234451;
        Tue, 26 Jul 2022 03:27:14 -0700 (PDT)
Received: from [192.168.3.197] (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id b15-20020a056512070f00b0048a7901903esm2357778lfs.144.2022.07.26.03.27.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 03:27:14 -0700 (PDT)
Message-ID: <57f8d9c4-6f49-ad3d-fc82-7a0f66d1775a@linaro.org>
Date:   Tue, 26 Jul 2022 12:27:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v4 2/2] power: reset: qcom-pon: add support for
 qcom,pmk8350-pon compatible string
Content-Language: en-US
To:     Anjelique Melendez <quic_amelende@quicinc.com>, corbet@lwn.net,
        sre@kernel.org, robh+dt@kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org
Cc:     krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        linux-doc@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220725191314.19456-1-quic_amelende@quicinc.com>
 <20220725191314.19456-3-quic_amelende@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220725191314.19456-3-quic_amelende@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/07/2022 21:13, Anjelique Melendez wrote:
> Add support for the new "qcom,pmk8350-pon" comptaible string.
> 
> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
> ---
>  drivers/power/reset/qcom-pon.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/power/reset/qcom-pon.c b/drivers/power/reset/qcom-pon.c
> index 4a688741a88a..16bc01738be9 100644
> --- a/drivers/power/reset/qcom-pon.c
> +++ b/drivers/power/reset/qcom-pon.c
> @@ -82,6 +82,7 @@ static const struct of_device_id pm8916_pon_id_table[] = {
>  	{ .compatible = "qcom,pm8916-pon", .data = (void *)GEN1_REASON_SHIFT },
>  	{ .compatible = "qcom,pms405-pon", .data = (void *)GEN1_REASON_SHIFT },
>  	{ .compatible = "qcom,pm8998-pon", .data = (void *)GEN2_REASON_SHIFT },
> +	{ .compatible = "qcom,pmk8350-pon", .data = (void *)GEN2_REASON_SHIFT },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, pm8916_pon_id_table);

This is now confusing. The new device has entirely different first and
second IO address spaces, but you do not code here any differences.

Best regards,
Krzysztof
