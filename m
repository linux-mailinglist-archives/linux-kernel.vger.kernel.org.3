Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1025557CEB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 15:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbiFWN1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 09:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbiFWN1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 09:27:15 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5F049FAF
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 06:27:13 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id ay16so21724952ejb.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 06:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=5ylVnp3BSSdv5mYX+gIt89P5txW/THyvIIqRQl/zP1I=;
        b=j5F9eo3VSk566JM8309igcXWFCSvnwI68IUkr8Z5qbdoSfFziyktOUUArrKR22wwre
         gayN8HbXTNDLDuYUFHUcvBfWAEoBF+aM2qvSxeGsOFLzOW9BBjD42tyF/arRfvRO5Ny4
         0yXurLqIJyJL9keZzNQhBCWLa7qSHGFYk7mjCBoP0KTErPIO8FaA6ieXdz68OTpW8zQo
         yk2EQ9k+6g7ZvgVGURRxPZ/iBgT4UWTHG+vWLkV7ygjFtXwFy++z6nwXeg2VUeMPueE9
         ygplFJvcZ0gejIH+X6QcGsWz+USPXT0qzQD0rgY5uXWO5KiMqx2iCYHwAznbW0a6RgeL
         8ZNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=5ylVnp3BSSdv5mYX+gIt89P5txW/THyvIIqRQl/zP1I=;
        b=diWipdn9z2+gHQJzF8ZyzrThJIRc6fRqWoZxiA4lqb188M+9t4+8FOr8VbpcJxwJXv
         TGVXpMkcIYFbZcCgaKykr11kVwpjLNV+E2zGfL6QPaq4GYC8lXCZota4Ov6a70NHXloM
         j+0lnEiLuwLQMSOzmlzOUYJfFUnygmUqqYIAl+L2TezZZDNZlHeFrUhjhmIJv4Xo5lCn
         GH8EWyx3B/7JCNMhmXkP7WzkvRSXoNZhZpMFIH4JYaF6PvSyHOs2Oyx7j4XN7FbfZjf0
         HbDNCqi72Vi34lghRJTCnnjF6eBuxqQBKKG4Vv9BQ7IUuq2fmXtwC5ekwAbt2RfH7xEB
         b3Ww==
X-Gm-Message-State: AJIora8yFSC+hqHxVpHTYF6rOVdlUXTulVbWrrxAi4YRo9uQ0FVbilNX
        I5mtvFF3hgqXzWcxmGwe4a9egFntlb7KVw==
X-Google-Smtp-Source: AGRyM1ukf+Laja3KQk2Vu7+qqO1tJTm4tDoDufqQNnz4OLn94rizYC3Cb6zamAlyGuV7nZmKAU9wIw==
X-Received: by 2002:a17:906:51cf:b0:722:e994:948e with SMTP id v15-20020a17090651cf00b00722e994948emr8396062ejk.656.1655990832395;
        Thu, 23 Jun 2022 06:27:12 -0700 (PDT)
Received: from [192.168.0.230] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id d13-20020a170906304d00b00704757b1debsm10844131ejd.9.2022.06.23.06.27.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 06:27:12 -0700 (PDT)
Message-ID: <a3aad0cc-caab-2e02-c731-8fff57906cee@linaro.org>
Date:   Thu, 23 Jun 2022 15:27:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 3/3] regulator: qcom_smd: Add PM8909 RPM regulators
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20220623094614.1410180-1-stephan.gerhold@kernkonzept.com>
 <20220623094614.1410180-4-stephan.gerhold@kernkonzept.com>
 <3f04d27f-4949-3544-9d39-73151a303569@linaro.org>
In-Reply-To: <3f04d27f-4949-3544-9d39-73151a303569@linaro.org>
Content-Type: text/plain; charset=UTF-8
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

On 23/06/2022 15:26, Krzysztof Kozlowski wrote:
> On 23/06/2022 11:46, Stephan Gerhold wrote:
> 
>>  static const struct rpm_regulator_data rpm_pm8916_regulators[] = {
>>  	{ "s1", QCOM_SMD_RPM_SMPA, 1, &pm8916_buck_lvo_smps, "vdd_s1" },
>>  	{ "s2", QCOM_SMD_RPM_SMPA, 2, &pm8916_buck_lvo_smps, "vdd_s2" },
>> @@ -1222,6 +1245,7 @@ static const struct rpm_regulator_data rpm_pm2250_regulators[] = {
>>  static const struct of_device_id rpm_of_match[] = {
>>  	{ .compatible = "qcom,rpm-mp5496-regulators", .data = &rpm_mp5496_regulators },
>>  	{ .compatible = "qcom,rpm-pm8841-regulators", .data = &rpm_pm8841_regulators },
>> +	{ .compatible = "qcom,rpm-pm8909-regulators", .data = &rpm_pm8909_regulators },
>>  	{ .compatible = "qcom,rpm-pm8916-regulators", .data = &rpm_pm8916_regulators },
>>  	{ .compatible = "qcom,rpm-pm8226-regulators", .data = &rpm_pm8226_regulators },
>>  	{ .compatible = "qcom,rpm-pm8941-regulators", .data = &rpm_pm8941_regulators },
> 
> Isn't this a new compatible? Looks like, so it needs bindings.

Ah, I see the patch now.


Best regards,
Krzysztof
