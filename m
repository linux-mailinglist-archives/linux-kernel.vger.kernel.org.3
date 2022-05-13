Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C93E525D46
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 10:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378176AbiEMIX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 04:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378173AbiEMIX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 04:23:56 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F3C25B076
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 01:23:54 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id t6so10404821wra.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 01:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=PyfNVqLhUzNkjpgQ9UuI9hC10iZbU2Sy8hokDDhjW1c=;
        b=uyE+J/VPE/aqnTrkoYawPZOjwR8W2AJEH4pjIBgBN6s4uE4Bqneq0UBCTPQvgJuLD7
         3i6I0bk+Ghzkd/Y0OApLv3XSvNbT/xBD+kMrarqJI5g0rIl6ksKsbQNluc2Dd36By0Tg
         UCdNwxIQS0qIUVp4hoQEKzDXqaHggpNJJlY9kN5tDiz2XfxARp5CfoJYMpAh1eghcQqv
         GMvyZhrtGvnyRi0ph7vstzMyjOljzqS7+2FUY9tnVndlgLBmxRk7fRk7tpZmH7liTXtG
         TjSI3zmV02BNZY/8QwjnW9Vxfsn3i8GtFksGO0C6ePN4ebs8nq6LA67UlGJWWn4OVffB
         8EnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PyfNVqLhUzNkjpgQ9UuI9hC10iZbU2Sy8hokDDhjW1c=;
        b=Jjptmz8DA59sORBT2HENxnc2U8kmkkmpq776xiYfFje5J5+F41YcbZORtOvA2Aqsgd
         Gf90ZOnJB4HK9Fu+m8wTFpu6cmGaT9TMQA+tzj8x0Upg02D975uqwqDAu0lS4vXiu/rR
         OHeEecaKGSDWgrzK/17FBBQMI4j5hl6I8uH0llt/pj1c/st4siDXfyHRaBxlCt/Orwrf
         aEgy1c1SkSBehAMmbkr8OzTBFq06MKFQRPGy+/5WHFZowT02VCkdEbqYsragiNadhdsJ
         EQybqDiQ4NF8dD8dxtWGmp2AbNUrhPs05kYl5R+ckUVit/TEd6STq32COvYwYbud9F/8
         crTw==
X-Gm-Message-State: AOAM533FiiBY5G5bpDsO/2Lt3LJqhgdB/NEVYKbuZpeKniqVAuwBYc6q
        CRVOIU40duvrMtDeZI5ZHKDrPQ==
X-Google-Smtp-Source: ABdhPJwdSWww2/id9LJNLs8/PG8ZeQp1Wg5I7GKKT8WISSKYbRD4qonFi6DvwWNJo/zk+LodMt0USA==
X-Received: by 2002:a5d:6643:0:b0:20a:f3a1:2d07 with SMTP id f3-20020a5d6643000000b0020af3a12d07mr2956737wrw.159.1652430232520;
        Fri, 13 May 2022 01:23:52 -0700 (PDT)
Received: from ?IPV6:2a01:cb05:8f8a:1800:1c97:b8d1:b477:d53f? (2a01cb058f8a18001c97b8d1b477d53f.ipv6.abo.wanadoo.fr. [2a01:cb05:8f8a:1800:1c97:b8d1:b477:d53f])
        by smtp.gmail.com with ESMTPSA id z18-20020a7bc152000000b003958af7d0c8sm1656105wmi.45.2022.05.13.01.23.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 May 2022 01:23:52 -0700 (PDT)
Message-ID: <3102213a-1b84-6559-9aa1-d35365be18b5@smile.fr>
Date:   Fri, 13 May 2022 10:23:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] bus: ti-sysc: Fix warnings for unbind for serial
Content-Language: en-US
To:     Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc:     Dave Gerlach <d-gerlach@ti.com>, Faiz Abbas <faiz_abbas@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Keerthy <j-keerthy@ti.com>, Kevin Hilman <khilman@baylibre.com>,
        Nishanth Menon <nm@ti.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220512053021.61650-1-tony@atomide.com>
From:   Romain Naour <romain.naour@smile.fr>
In-Reply-To: <20220512053021.61650-1-tony@atomide.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Le 12/05/2022 à 07:30, Tony Lindgren a écrit :
> We can get "failed to disable" clock_unprepare warnings on unbind at least
> for the serial console device if the unbind is done before the device has
> been idled.
> 
> As some devices are using deferred idle, we must check the status for
> pending idle work to idle the device.

I didn't noticed the "failed to disable" warning so far (kernel 5.10.106 from
ti-linux-kernel repository) but I applied this patch as suggested [1] while
investigating another issue "tty serial 8250 omap driver crash".

Reviewed-by: Romain Naour <romain.naour@smile.fr>

[1] https://marc.info/?l=linux-omap&m=164484408319083&w=2

Best regards,
Romain


> 
> Cc: Romain Naour <romain.naour@smile.fr>
> Fixes: 76f0f772e469 ("bus: ti-sysc: Improve handling for no-reset-on-init and no-idle-on-init")
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/bus/ti-sysc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
> --- a/drivers/bus/ti-sysc.c
> +++ b/drivers/bus/ti-sysc.c
> @@ -3395,7 +3395,9 @@ static int sysc_remove(struct platform_device *pdev)
>  	struct sysc *ddata = platform_get_drvdata(pdev);
>  	int error;
>  
> -	cancel_delayed_work_sync(&ddata->idle_work);
> +	/* Device can still be enabled, see deferred idle quirk in probe */
> +	if (cancel_delayed_work_sync(&ddata->idle_work))
> +		ti_sysc_idle(&ddata->idle_work.work);
>  
>  	error = pm_runtime_resume_and_get(ddata->dev);
>  	if (error < 0) {

