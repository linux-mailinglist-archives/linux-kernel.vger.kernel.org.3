Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E934AD180
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 07:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347326AbiBHG1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 01:27:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347304AbiBHG1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 01:27:08 -0500
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F90C0401F0;
        Mon,  7 Feb 2022 22:27:07 -0800 (PST)
Received: by mail-wr1-f44.google.com with SMTP id k1so12259774wrd.8;
        Mon, 07 Feb 2022 22:27:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ml/x/PyxdLV1/Hir7HAdb60W83k0QDNVYkweRtj8UqE=;
        b=mTmO8zfQzHTmMz6im1SZ6nXgCvme10cy6yvSQm2JiT8TrwxxosD6tgLqa0p6fKhpXw
         TtjyfL+j5fNkSsms3KzXMJdJ8fKNlvjccMqea++vezFHt8EpHlTwflUjCS+jxRWyuqlZ
         CqIfWeMjzwmdyPO3PPdLLyLFnQVyqn4yjdBRwUYzf9b5YPAA2Zg6wK8JdPo2cYxNpo7i
         CziYQo4I80iflgCqaKt0RTbU6qxPBXybx7g9Xkv3sXGtBSHPP1oH0acC2weRno6KoObR
         Qcj5XwwxEo5/0ojdJs2P9MW7wQl5A8gD9WVg23eoRCmccgQsIOI+lRMJXWmkL2xWDXsD
         +FHQ==
X-Gm-Message-State: AOAM532dp+qoiViv6E5H3fgZxk1sZzpKFX1lpEpa62R5wcFmSO/2sBff
        v1cMeWQPfhqNz31yNI2SJYm98RV0QAo=
X-Google-Smtp-Source: ABdhPJx+i47vYzVLrYAoFB5BP3d95i3dalrtqRYiBA7T9N+ghG3VKgk1xxE73gx3LiFoOYTU45VhZA==
X-Received: by 2002:adf:f54d:: with SMTP id j13mr2077800wrp.596.1644301626253;
        Mon, 07 Feb 2022 22:27:06 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id o3sm4070742wrc.41.2022.02.07.22.27.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 22:27:05 -0800 (PST)
Message-ID: <7aa14a1e-2814-0014-a682-f40666f635ac@kernel.org>
Date:   Tue, 8 Feb 2022 07:27:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v7 2/2] serial:sunplus-uart:Add Sunplus SoC UART Driver
Content-Language: en-US
To:     Hammer Hsieh <hammerh0314@gmail.com>, gregkh@linuxfoundation.org,
        robh+dt@kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de
Cc:     wells.lu@sunplus.com, hammer.hsieh@sunplus.com
References: <1644213481-20321-1-git-send-email-hammerh0314@gmail.com>
 <1644213481-20321-3-git-send-email-hammerh0314@gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <1644213481-20321-3-git-send-email-hammerh0314@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 07. 02. 22, 6:58, Hammer Hsieh wrote:
> +static void sunplus_shutdown(struct uart_port *port)
> +{
> +	unsigned long flags;
> +	unsigned int isc;
> +
> +	spin_lock_irqsave(&port->lock, flags);
> +
> +	isc = readl(port->membase + SUP_UART_ISC);
> +	isc &= ~(SUP_UART_ISC_RXM | SUP_UART_ISC_TXM);

Is this correct? I mean: will the SUP_UART_ISC read contain the control 
bits, not only status bits?

> +	writel(isc, port->membase + SUP_UART_ISC);
> +
> +	spin_unlock_irqrestore(&port->lock, flags);
> +
> +	free_irq(port->irq, port);

I am still waiting for explanation why this is safe with respect to 
posted writes.

regards,
-- 
js
suse labs
