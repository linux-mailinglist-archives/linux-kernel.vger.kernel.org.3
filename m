Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F50A5A4F16
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 16:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbiH2OXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 10:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiH2OXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 10:23:04 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D80883DA;
        Mon, 29 Aug 2022 07:23:04 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id d68so6632835iof.11;
        Mon, 29 Aug 2022 07:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=PNt+onL4ClTGcGyv6RZetjSFdA6iAHMD9oHCxPI/soM=;
        b=MFSqRVGOZAoV890KYUkC2e/s/8COn1XxXCGybEtI0iebrfFUmAA0oYr5EPe6bRn+m8
         7ObknMAjjAahzsKI0d6HQLI4zf6+RlzyC6sI0vKnhijfqMRpXzZ0fD7eZS5LeDhf+8Go
         aMjvHz43sLg0EC3d3r17wisMtYGyc9Rrh7EMpYfnvnJlRj+9bvHZfPixktoFbYBxpPHv
         xkboEAyTkIHKYrAR8iVXiBZT72X74Xl59hy6TiTYZPsJbyJDDiYUdYnZOJnHkCfDlP3F
         4HAkHDx9vqYLtskKySjPaap6c1qAFfn5+Fb/EbvJwi4xkhFXnNRsQ81KmdvsHnNg/J3y
         PUlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=PNt+onL4ClTGcGyv6RZetjSFdA6iAHMD9oHCxPI/soM=;
        b=YI5QTdBSJqN1OWuys6QC9t8Fi+P9+k3DVuDXkmiuFF9Co+5ZJ24v3bI7rRAXmV9FnO
         iQhze7JWg0jQVVXTajwLx6dSL4gP55WnFEmet3PJFM6SPExo8iT3Z7Le3qvevkmqa715
         fhMfMtS5Q4oNoX4UOjwPSYUtx6vPSaqSDC3bost9L+YaPulkhZSXIZ288QwUe6LZ+vDU
         GWFB+TRo9EPzKKKTDHxZOs+P+jvLmdMU22Eyy5D8/nIT1OxBlAEeZ2puIcZDnrGU8ZZS
         JUZF3m3McKTrLdZFu0nQQc29KIoMDpEuNPWpOh2kg5B4Ac02POIRpCgTDP2BMqa8ezLI
         nSaw==
X-Gm-Message-State: ACgBeo1C3PnOLt9UpIYxDefwr0EdMg9IwJ03q/zfOCulVZpyXiZ1Msnq
        +aDTTIIYGKZuvrJY49lwWEU=
X-Google-Smtp-Source: AA6agR5uPSHD12ylnxWxiH+y99KcNQPD/2vJtnGDyLZiBtjcNQhYoidJRkpqktfg174/Srnp5I/+hw==
X-Received: by 2002:a5e:9417:0:b0:689:f25c:6f7d with SMTP id q23-20020a5e9417000000b00689f25c6f7dmr8471097ioj.123.1661782983582;
        Mon, 29 Aug 2022 07:23:03 -0700 (PDT)
Received: from [192.168.0.27] ([204.237.49.50])
        by smtp.gmail.com with ESMTPSA id e7-20020a026d47000000b00349ce27c2c6sm4311534jaf.169.2022.08.29.07.23.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 07:23:03 -0700 (PDT)
Message-ID: <d4a2c953-90e9-2ea2-ee18-a4f7bd7dae28@gmail.com>
Date:   Mon, 29 Aug 2022 10:23:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [RFC v1 2/2] HID: logitech-hidpp: Remove hard-coded "Sw. Id." for
 HID++ 2.0 commands
Content-Language: en-US
To:     Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        =?UTF-8?Q?Filipe_La=c3=adns?= <lains@riseup.net>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>
References: <20220829134852.312548-1-hadess@hadess.net>
 <20220829134852.312548-2-hadess@hadess.net>
From:   "Peter F. Patel-Schneider" <pfpschneider@gmail.com>
In-Reply-To: <20220829134852.312548-2-hadess@hadess.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
> Some HID++ 2.0 commands had correctly set a non-zero software identifier
> directly as part of their function identifiers, but it's more correct to
> define the function identifier and the software identifier separately
> before combined them when the command is sent.
>
> As this is now done in the previous commit, remove the hard-coded 0x1
> software identifiers in the function definitions.
>
> Signed-off-by: Bastien Nocera <hadess@hadess.net>
> ---
>   drivers/hid/hid-logitech-hidpp.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
> index 02f8c99672c7..46b3e51cb854 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -859,8 +859,8 @@ static int hidpp_unifying_init(struct hidpp_device *hidpp)
>   #define HIDPP_PAGE_ROOT					0x0000
>   #define HIDPP_PAGE_ROOT_IDX				0x00
>   
> -#define CMD_ROOT_GET_FEATURE				0x01
> -#define CMD_ROOT_GET_PROTOCOL_VERSION			0x11
> +#define CMD_ROOT_GET_FEATURE				0x00
> +#define CMD_ROOT_GET_PROTOCOL_VERSION			0x10
>   
>   static int hidpp_root_get_feature(struct hidpp_device *hidpp, u16 feature,
>   	u8 *feature_index, u8 *feature_type)
> @@ -937,9 +937,9 @@ static int hidpp_root_get_protocol_version(struct hidpp_device *hidpp)
>   
>   #define HIDPP_PAGE_GET_DEVICE_NAME_TYPE			0x0005
>   
> -#define CMD_GET_DEVICE_NAME_TYPE_GET_COUNT		0x01
> -#define CMD_GET_DEVICE_NAME_TYPE_GET_DEVICE_NAME	0x11
> -#define CMD_GET_DEVICE_NAME_TYPE_GET_TYPE		0x21
> +#define CMD_GET_DEVICE_NAME_TYPE_GET_COUNT		0x00
> +#define CMD_GET_DEVICE_NAME_TYPE_GET_DEVICE_NAME	0x10
> +#define CMD_GET_DEVICE_NAME_TYPE_GET_TYPE		0x20
>   
>   static int hidpp_devicenametype_get_count(struct hidpp_device *hidpp,
>   	u8 feature_index, u8 *nameLength)
> @@ -1969,8 +1969,8 @@ static int hidpp_touchpad_fw_items_set(struct hidpp_device *hidpp,
>   
>   #define HIDPP_PAGE_TOUCHPAD_RAW_XY			0x6100
>   
> -#define CMD_TOUCHPAD_GET_RAW_INFO			0x01
> -#define CMD_TOUCHPAD_SET_RAW_REPORT_STATE		0x21
> +#define CMD_TOUCHPAD_GET_RAW_INFO			0x00
> +#define CMD_TOUCHPAD_SET_RAW_REPORT_STATE		0x20
>   
>   #define EVENT_TOUCHPAD_RAW_XY				0x00
>   



Looks good to me.


peter


