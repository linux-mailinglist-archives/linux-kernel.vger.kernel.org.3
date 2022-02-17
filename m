Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65E274BA74B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 18:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243830AbiBQRhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 12:37:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbiBQRhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 12:37:08 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADB6CE;
        Thu, 17 Feb 2022 09:36:54 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id d7so9682219qvk.2;
        Thu, 17 Feb 2022 09:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=YT6i6zAvuPIDw8rTT9iPdqVsfeJV5gVLu6Dx+ZSH/OY=;
        b=aHY3iAwP93+Sffc+Iy8H+y3Z4UBYKxmRouQbVIphbflwD79lzkmL+AgV8pHerrz9vq
         dP2nar/x4c829KAcM6P/Tzbc4HhUF8pnkv1LCSsZnWUhNtR63xDihqzO1yLBZ6Kx84An
         eReDKqiFv3cFlOwwmu/Da6lHjgav6pNLtbLaqX6v2no4MYDje6wbn2ukVBO5hRokx3dr
         BZuqYDxVuqmQ76ih4pputFZLJU1jKbfg7omosoBlFj9zw/GrPSy+72wcoy+Lquc0DZwy
         Yxlc2Ew+rFsprXE/P5h5/apHK0KvmD+kd98Oz3kAGUChU7/eCf2krAu3WV2XPE/BRszj
         EGJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=YT6i6zAvuPIDw8rTT9iPdqVsfeJV5gVLu6Dx+ZSH/OY=;
        b=fmP/z57fiU3el3jmCbejEDeBNGkKHg8cOSgXW77KCJQgF7EEus+yW575ZVRQWOgvwZ
         0ANOsgTXV5jyZuKr8jPIunE2Q27G5bEtd3YU9hhJmKYoBNoUyDqclU9lbtOKV5jVaLaG
         9dzR5OJlQrewZa4p6qgcfHMUgzf/UxuCn8xhZvekJeG9huJcVYuFbSo5p8LoENlaRFE5
         6yiTR48S7rgrgMRMOoC4o6yUT90+I+3YFgwaMGgjU/7YHFCpO3XOLqdyTOXka2UxOVoq
         46sXgiasFdRPH9t07CZ7P4OcMq3wHfnbgjwkig45OKwlU+lfxAPw2BN2BEr44qJ5uT+I
         28MA==
X-Gm-Message-State: AOAM530M8YFdELg3dIU618n8qyrl5Knf7tnrC8cVnc3y5p9M4NFYWr17
        7vpTYFvvzpzt4Q1QF5Up3bs=
X-Google-Smtp-Source: ABdhPJw2puxE1pTENCjPFJTErkM68D0PT+SquQSdWLfxjixiX0Wd0bm45v2Us+WFviI2Rul3eZuBvg==
X-Received: by 2002:ac8:5907:0:b0:2dc:62f:27c7 with SMTP id 7-20020ac85907000000b002dc062f27c7mr3451592qty.315.1645119413377;
        Thu, 17 Feb 2022 09:36:53 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 84sm3611257qkk.32.2022.02.17.09.36.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 09:36:52 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <15b95695-6fbc-1916-ff39-abf13e989fc4@roeck-us.net>
Date:   Thu, 17 Feb 2022 09:36:51 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Marcello Sylvester Bauer <sylv@sylv.io>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>
References: <cover.1645092563.git.sylv@sylv.io>
 <d3563864d03a3d3450cf00b3be05465dc506e161.1645092563.git.sylv@sylv.io>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v1 1/1] hwmon: (pmbus) Add regulator supply into macro
In-Reply-To: <d3563864d03a3d3450cf00b3be05465dc506e161.1645092563.git.sylv@sylv.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/17/22 02:23, Marcello Sylvester Bauer wrote:
> Add optional regulator supply into PWBUS_REGULATOR macro. This makes it

The code doesn't look optional to me. What exactly is optional ?

> possible to define a vin-supply in DT. Not defining a supply will only
> cause the following debug output:
> 
> ```
> Looking up vin-supply property in node [...] failed
> ```
> 
> Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
> ---
>   drivers/hwmon/pmbus/pmbus.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hwmon/pmbus/pmbus.h b/drivers/hwmon/pmbus/pmbus.h
> index e0aa8aa46d8c..38f049d68d32 100644
> --- a/drivers/hwmon/pmbus/pmbus.h
> +++ b/drivers/hwmon/pmbus/pmbus.h
> @@ -464,6 +464,7 @@ extern const struct regulator_ops pmbus_regulator_ops;
>   #define PMBUS_REGULATOR(_name, _id)				\
>   	[_id] = {						\
>   		.name = (_name # _id),				\
> +		.supply_name = "vin",				\
>   		.id = (_id),					\
>   		.of_match = of_match_ptr(_name # _id),		\
>   		.regulators_node = of_match_ptr("regulators"),	\

That seems to be quite far reaching. How does this affect / change behavior
of existing systems which so far did not expect supply_name to be set ?

Guenter
