Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19BAB5A4F14
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 16:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiH2OWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 10:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbiH2OWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 10:22:36 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92158E4FB;
        Mon, 29 Aug 2022 07:22:32 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id l6so2790752ilk.13;
        Mon, 29 Aug 2022 07:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=r2IisvDZhIUwr3A4znPc/Y5pU34Q3HM0h5+VHVWhOk4=;
        b=gHRIscN/jmrTqobS5b2rFsptm4KH1+QQiZdg/c4BJJ+nZ7VIzisYERmizhRPFmwKU0
         SxIacjlrjP1QHzndUY5Z1A3/acAqOh0DDpDS5MZb1eRrajp+KFpE2ufYGXvWwkBHuGFy
         H57kRraoxtdG09kqsKSYS7DpsqksYAQBWeMWM5ssFkTZaa/oYY/ZxKsDjc9PH7RDTbeY
         7uPswya4MXUNvy0fC1BH8nc2tdJ6849qHtsz39qiM4eL5kBpGEbxF+JMpZBD0aLPQX7/
         jbCvj/JCdPzwhr1zbw49eRGaSI29DlmM8adoRWD/dLmTOQs0XNGolZJuf7NeQhQomNw4
         U6ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=r2IisvDZhIUwr3A4znPc/Y5pU34Q3HM0h5+VHVWhOk4=;
        b=FJCw1jaO7QMwML5oejPlt+1HfyDfwG/MQ08IvzG/O6oVfqjtIKQNbENrtWSTIER0lE
         m7YK/cV+MKumdLtGf9LBz8iYc7YDCLNCyqsgUc7STUevUkAfmXQ0YdvypNkImRyF6Uf4
         0ewQyB+eJojl29jvBWw8d4KSSVjBNRxp9nOGTsnb30RY9rOQs3CovEMV8xvXR+GRDvif
         fgsOAOKUzjOGOHlZwLoXx1wPeRkmHsZj6xLQEavru+zpXVe3XzHyHZOvr4NNVgxk8atw
         asq0vMLBSrlqAubFWUKyLk3CmiZ1gSTpdLkAADgYw0DYZyYvS+eO2ELQ50Hq6lypxTOB
         C47w==
X-Gm-Message-State: ACgBeo3p/Gxf15vTOICoW9eqJVXP361m2yLwbrn33WEValpwZs0+CESP
        DS5zcoKJMHnxAt/FYUo9L0s=
X-Google-Smtp-Source: AA6agR7dSn8UGvaaP95ttMa51jL3T38SsmfSy8tqy4l3eQroIkxmc1Vapo6+T0bEXq5pCmYQdz0aew==
X-Received: by 2002:a92:c242:0:b0:2e9:62e2:a87c with SMTP id k2-20020a92c242000000b002e962e2a87cmr9970868ilo.246.1661782951170;
        Mon, 29 Aug 2022 07:22:31 -0700 (PDT)
Received: from [192.168.0.27] ([204.237.49.50])
        by smtp.gmail.com with ESMTPSA id h16-20020a92d850000000b002eb109706f4sm1316923ilq.84.2022.08.29.07.22.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 07:22:30 -0700 (PDT)
Message-ID: <fab763ac-2865-58b1-d735-51a28a76aa94@gmail.com>
Date:   Mon, 29 Aug 2022 10:22:28 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [RFC v1 1/2] HID: logitech-hidpp: Fix "Sw. Id." for HID++ 2.0
 commands
Content-Language: en-US
To:     Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        =?UTF-8?Q?Filipe_La=c3=adns?= <lains@riseup.net>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>
References: <20220829134852.312548-1-hadess@hadess.net>
From:   "Peter F. Patel-Schneider" <pfpschneider@gmail.com>
In-Reply-To: <20220829134852.312548-1-hadess@hadess.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/29/22 09:48, Bastien Nocera wrote:
> Always set a non-zero "Sw. Id." in the lower nibble of the Function/ASE
> and Software Identifier byte in HID++ 2.0 commands.
>
> As per the "Protocol HID++2.0 essential features" section in
> https://lekensteyn.nl/files/logitech/logitech_hidpp_2.0_specification_draft_2012-06-04.pdf
> "
> Software identifier (4 bits, unsigned)
>
> A number uniquely defining the software that sends a request. The
> firmware must copy the software identifier in the response but does
> not use it in any other ways.
>
> 0 Do not use (allows to distinguish a notification from a response).
> "
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=215699
> Signed-off-by: Bastien Nocera <hadess@hadess.net>
> ---
>   drivers/hid/hid-logitech-hidpp.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
> index 86e7a38d8a9a..02f8c99672c7 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -41,6 +41,9 @@ module_param(disable_tap_to_click, bool, 0644);
>   MODULE_PARM_DESC(disable_tap_to_click,
>   	"Disable Tap-To-Click mode reporting for touchpads (only on the K400 currently).");
>   
> +/* Define a non-zero software ID to identify our own requests */
> +#define LINUX_KERNEL_SW_ID			0x06
> +
>   #define REPORT_ID_HIDPP_SHORT			0x10
>   #define REPORT_ID_HIDPP_LONG			0x11
>   #define REPORT_ID_HIDPP_VERY_LONG		0x12
> @@ -343,7 +346,7 @@ static int hidpp_send_fap_command_sync(struct hidpp_device *hidpp,
>   	else
>   		message->report_id = REPORT_ID_HIDPP_LONG;
>   	message->fap.feature_index = feat_index;
> -	message->fap.funcindex_clientid = funcindex_clientid;
> +	message->fap.funcindex_clientid = funcindex_clientid | LINUX_KERNEL_SW_ID;
>   	memcpy(&message->fap.params, params, param_count);
>   
>   	ret = hidpp_send_message_sync(hidpp, message, response);



Looks good to me.  It might be better to use ID 0x01 to signifiy the "first" 
software but that is a minor quibble.


peter


