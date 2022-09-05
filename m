Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4885AD468
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 15:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238050AbiIEN7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 09:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237251AbiIEN7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 09:59:03 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687F44330A
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 06:59:02 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id d5so5300790wms.5
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 06:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=aCI4sTeVrLwlbGChffEl+/B0GzkzQBf1lhgxPD1msHo=;
        b=D4RPmlZhp41BSBt0R7XQnctXxaUzGyRG6UkepKRONfe+CyBXTlY2p+cvEEP84/6pPh
         PeZ8bwwNDkWePoIwblPZDkphIZVArN7/iYhRlw0hTsKAgb09FAysUQ+aONpfde2rTcVk
         EbLMnunLDhXKyZtZkYbVgUINFzY+GuMVhQArUY43Z3p6FpxYxDd57rlRbbvlE4LTKzEN
         sFFTHZmW7y/bNNdnExTiWzeBaeAYMZtOcgODwleQc4aNEqgGXBVDxM5Kh7eWak43Gf3e
         AV+ivVbhEgXJz7HLFUwJkuw4VdlGK5zzf4O9OSBPj1+V3lnxk+QIQ2EjftZ/AYBneyqh
         RroA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=aCI4sTeVrLwlbGChffEl+/B0GzkzQBf1lhgxPD1msHo=;
        b=cEb6PYPQp+Ts3sQRDHY+EB91Pl3VI2AM/qLROZI8PJZBAIIgkqeDMxdzlKPAFJlq1/
         RNb2PHbjdMhKFZCWbw7tPVv//5Et6NSpLpjX9UoyzOEN6+Wu8W2YvefmKoFKkodl9BCG
         Ep86osJcIg8tRE2tfMg01rXgqLeyL8FMQ6ogffy+5K4BdA2jvIgFf5wXjTJwcv/2T1GQ
         4/LhrIvxhG0WLJEWf7YCvT7pebGuYIF3AfCUZHhFPSWa0EkVLHE4PmPv74py2R2heCz0
         oHeHX9pO9gMcvAw4Jm+JlRRUd82Ttu/ZWkxax/3tjjOq3gSFagdxOSxe8hpgi+MIG1Yy
         zoBQ==
X-Gm-Message-State: ACgBeo0MlzNpMDtMaJsMqJKhliuuG3r7nqdTtgdFcbrfMXjAZ2f/hfRx
        5Qd7PRPRywKLbJ/IS7128mgJKA==
X-Google-Smtp-Source: AA6agR5ZmRTK9YYIiIlt6npxptul6FhU/QIcTD8gSoKlxL5GrdQ/cs77QrlXt9xD0+4KE4UyWBDIkg==
X-Received: by 2002:a7b:cbd0:0:b0:3a6:9f6:a3e8 with SMTP id n16-20020a7bcbd0000000b003a609f6a3e8mr10668021wmi.13.1662386340597;
        Mon, 05 Sep 2022 06:59:00 -0700 (PDT)
Received: from google.com (ec2-18-168-47-91.eu-west-2.compute.amazonaws.com. [18.168.47.91])
        by smtp.gmail.com with ESMTPSA id v22-20020a7bcb56000000b003a5ad7f6de2sm10978054wmj.15.2022.09.05.06.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 06:59:00 -0700 (PDT)
Date:   Mon, 5 Sep 2022 14:58:38 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Charles Mirabile <cmirabil@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Robinson <pbrobinson@gmail.com>,
        Serge Schneider <serge@raspberrypi.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Nicolas Saenz Julienne <nicolassaenzj@gmail.com>,
        Mattias Brugger <mbrugger@suse.com>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, rh-kdlp@googlegroups.com,
        Joel Savitz <jsavitz@redhat.com>, Lee Jones <lee@kernel.org>
Subject: Re: [PATCH 1/5] drivers/mfd: sensehat: Add Raspberry Pi Sense HAT to
 simple_mfd_i2c
Message-ID: <YxYAdaa9F/L++lTi@google.com>
References: <20220823174158.45579-1-cmirabil@redhat.com>
 <20220823174158.45579-2-cmirabil@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823174158.45579-2-cmirabil@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Aug 2022, Charles Mirabile wrote:

> This patch adds the compatible string for the Sense HAT device to
> the list of compatible strings in the simple_mfd_i2c driver so that
> it can match against the device and load its children and their drivers
> 
> Co-developed-by: Joel Savitz <jsavitz@redhat.com>
> Signed-off-by: Joel Savitz <jsavitz@redhat.com>
> Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
> ---
>  drivers/mfd/simple-mfd-i2c.c | 1 +
>  1 file changed, 1 insertion(+)

If you have not already done so, please resend, Cc'ing my kernel.org
address, as-per MAINTAINERS.  Thank you.

> diff --git a/drivers/mfd/simple-mfd-i2c.c b/drivers/mfd/simple-mfd-i2c.c
> index f4c8fc3ee463..c47f36581f3f 100644
> --- a/drivers/mfd/simple-mfd-i2c.c
> +++ b/drivers/mfd/simple-mfd-i2c.c
> @@ -75,6 +75,7 @@ static const struct simple_mfd_data silergy_sy7636a = {
>  static const struct of_device_id simple_mfd_i2c_of_match[] = {
>  	{ .compatible = "kontron,sl28cpld" },
>  	{ .compatible = "silergy,sy7636a", .data = &silergy_sy7636a},
> +	{ .compatible = "raspberrypi,sensehat" },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, simple_mfd_i2c_of_match);

-- 
DEPRECATED: Please use lee@kernel.org
