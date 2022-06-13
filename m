Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4D754A0CD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 23:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351732AbiFMVGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 17:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353149AbiFMVFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 17:05:05 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D50E22296
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 13:40:58 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id g7so8824704eda.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 13:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=HfmXHviBVE0o3HCHUdS6+8UmjzDzxiux613KeakQDqU=;
        b=PZWPoYp+2PbenEf3ERwBjT4BMMcm6VBJJjKmkOmnD2bo/dDEyuNP6EuoVBt3iDfr7V
         KwQp/h7BrRRKlOK12kI8odiDgVTBY0YDh5t1xgQKkTy7rxe+8uYUrG/VtfR58u+/zama
         zpZpgeRI5yLJY8yUsjAz/tBZqCS/beclAyCPDlP1XfDbSjZCsDwzcYbaTrtq5dRyThMB
         wH8gu+VYtrVuJAxlLWxGsLtVdyqtpw3kdrZGJD1LgZBXzPUFkNuEUv3NHQkWt9FdNzY9
         74LcCimIhP+N8IHT/QGlsRuTqIqxw9FXtrPtq8y3LtaZSHEpFzZkKkTDcPeCapioHIeg
         bLHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HfmXHviBVE0o3HCHUdS6+8UmjzDzxiux613KeakQDqU=;
        b=QP2FutBAdMuRsQEZcWeS/i6AC222XX4qBWFeGUN8LOJSFN3L2hSKav8SXXx29uuHAh
         +rSUq12CjXLXPb9G3pRsBUdde2/eDyC7lZEDu5SVYbUQ2gUJmUnV3QngkQ5O7PZwFBuL
         CmNBZ7cYzdlbUu3491NMNKs7teFeoA1MTXUU9qwa5eKHYhN3GBZrn/x4lJSbSP8McDJX
         GkrvyYwRMY37jRjQ+W5vYre5mC9fuD4E6bPxOaHMw8q8Aixf3zpAqMr5sXkyUl0jNLfw
         kl5k3wpBl/+d2AHkhT6O3zkCXeSTRuDQ6TAGiON8ZCtI/2TiD0lb1BF0ES88B4rEp+g9
         zcvA==
X-Gm-Message-State: AOAM533cfNy2pwiZbD5ixpcZxS6NaSahoUpbBaBmEOo3PDBRWmLm7Dh0
        hdRYwgBwubKNYZdeFhM6O8Y=
X-Google-Smtp-Source: AGRyM1vpVm7eBeDc2tw8ECHvWLsSplSmSPRlSc74+ct2mEQku8nUVQQI8dhEds1V2Wurb7kQ+uT0wQ==
X-Received: by 2002:a05:6402:22ad:b0:433:d474:1fb with SMTP id cx13-20020a05640222ad00b00433d47401fbmr1779604edb.129.1655152856749;
        Mon, 13 Jun 2022 13:40:56 -0700 (PDT)
Received: from ?IPV6:2a02:a466:68ed:1:9c12:8f08:a584:7d53? (2a02-a466-68ed-1-9c12-8f08-a584-7d53.fixed6.kpn.net. [2a02:a466:68ed:1:9c12:8f08:a584:7d53])
        by smtp.gmail.com with ESMTPSA id wl21-20020a170907311500b0070759e37183sm4217579ejb.59.2022.06.13.13.40.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jun 2022 13:40:56 -0700 (PDT)
Message-ID: <77a486ae-06bb-7f1b-17ab-8d60ccfbdee6@gmail.com>
Date:   Mon, 13 Jun 2022 22:40:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v1 1/1] phy: ti: tusb1210: Don't check for write errors
 when powering on
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Kishon Vijay Abraham I <kishon@ti.com>
References: <20220613160848.82746-1-andriy.shevchenko@linux.intel.com>
From:   Ferry Toth <fntoth@gmail.com>
In-Reply-To: <20220613160848.82746-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Op 13-06-2022 om 18:08 schreef Andy Shevchenko:
> On some platforms, like Intel Merrifield, the writing values during power on
> may timeout:
>
>     tusb1210 dwc3.0.auto.ulpi: error -110 writing val 0x41 to reg 0x80
with the patch this error continues to appear in the logs
>     phy phy-dwc3.0.auto.ulpi.0: phy poweron failed --> -110
>     dwc3 dwc3.0.auto: error -ETIMEDOUT: failed to initialize core
>     dwc3: probe of dwc3.0.auto failed with error -110
these errors are gone
> which effectively fails the probe of the USB controller.

and probe of dwc3 succeeds

Tested on Intel Edison (Merrifield)

> Drop the check as it was before the culprit commit (see Fixes tag).
>
> Fixes: 09a3512681b3 ("phy: ti: tusb1210: Improve ulpi_read()/_write() error checking")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/phy/ti/phy-tusb1210.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/phy/ti/phy-tusb1210.c b/drivers/phy/ti/phy-tusb1210.c
> index c3ab4b69ea68..669c13d6e402 100644
> --- a/drivers/phy/ti/phy-tusb1210.c
> +++ b/drivers/phy/ti/phy-tusb1210.c
> @@ -105,8 +105,9 @@ static int tusb1210_power_on(struct phy *phy)
>   	msleep(TUSB1210_RESET_TIME_MS);
>   
>   	/* Restore the optional eye diagram optimization value */
> -	return tusb1210_ulpi_write(tusb, TUSB1210_VENDOR_SPECIFIC2,
> -				   tusb->vendor_specific2);
> +	tusb1210_ulpi_write(tusb, TUSB1210_VENDOR_SPECIFIC2, tusb->vendor_specific2);
> +
> +	return 0;
>   }
>   
>   static int tusb1210_power_off(struct phy *phy)
