Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C77A56479B
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 15:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbiGCNzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 09:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbiGCNzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 09:55:18 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4752EF58;
        Sun,  3 Jul 2022 06:55:17 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id q140so6646915pgq.6;
        Sun, 03 Jul 2022 06:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=TIiGx/EEHym2I0yynhOroEkRxYFAU0a4P5SghNqA/Os=;
        b=JJlz4V6gs3ioLlo0OwIvOn3CYlRRvqfAhaXr8waz7dSqPokJo6Vt6YnbsNA1R0SrwR
         bHxJbZ5GnXxBrfWu5+er9gsJbGNQxqV6WNp14XYqaHrvy7c7gAzonKNmen9gMU9SPVaV
         TjR69MEEce6eKScjxr4G+D8gs7IP5mhMd2T4yQXnTgoBKPDeo+eMd9Qmz23OF44VAJgR
         5yKhGpcVGA6zYgPuZuUnvDaLEMt5TkoObPqRxbaTP/sVTZbVHlZFWQ3plDXNzWGxEhMu
         2O3FuTWePqfgt+j+UG2TcTiNZ9Ae1LPgGy5BU5rgyj+i+bUsJJE1r6zv7ciqPJl//Ubf
         IrMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TIiGx/EEHym2I0yynhOroEkRxYFAU0a4P5SghNqA/Os=;
        b=f/y0EYjDteKYUDycJjGEqPYuy6yt2D1BknaEgzgVa2TQ3K+mZU1UObh/0An88bs20q
         4+LjQSEHkXW/Se5FC2tqi/ujzm1rUTPVgUxga9SxSMWa0SNVrI1HdyZZHOGRJHzuAn0J
         3863MpPxDegP8UfT4O0iaB9IfepTnfjhe7HsP6HI3xRAU3eI7kwYyIAI4nEFp9B3aHVL
         KXgLgDJFQq0Pp2OrR0FyWV59kPOg3dXj10ltM9Z1Y5HPRT+BhUlxl9Z/4exRVCyj9i6a
         jdhP52m1uDarZsm3nTYuzz6ue02FMDzDFpYgGi3TJZ9RRc4JZQ8uikE+ppgxN6+phgr/
         MqDg==
X-Gm-Message-State: AJIora+g9OL562Fq+E8pvns2Za2Xrj+iOfLn+U9FQ8WpxzQrsmCSDuw3
        POLlzmhosTdzi9lIxMixQqtLheTf4dk=
X-Google-Smtp-Source: AGRyM1uZW/hrChlatw3hN9PZb5qKHW8QCucFPk8Hq+pcwXumn+CtyP4btlBRvGTTbTeaZTcUpVzSAw==
X-Received: by 2002:a65:6b8a:0:b0:3db:7dc5:fec2 with SMTP id d10-20020a656b8a000000b003db7dc5fec2mr20660291pgw.223.1656856516736;
        Sun, 03 Jul 2022 06:55:16 -0700 (PDT)
Received: from [172.30.1.37] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id pc3-20020a17090b3b8300b001ef3f85d1aasm7576804pjb.9.2022.07.03.06.55.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Jul 2022 06:55:16 -0700 (PDT)
Message-ID: <03f29fbf-4616-2fc1-c7cd-c575f31f8463@gmail.com>
Date:   Sun, 3 Jul 2022 22:55:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH V3 09/10] PM / devfreq: imx: Register i.MX8MP interconnect
 device
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, djakov@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        abel.vesa@nxp.com, abailon@baylibre.com, l.stach@pengutronix.de,
        laurent.pinchart@ideasonboard.com, marex@denx.de,
        paul.elder@ideasonboard.com, Markus.Niebel@ew.tq-group.com,
        aford173@gmail.com, cw00.choi@samsung.com,
        kyungmin.park@samsung.com, myungjoo.ham@samsung.com
Cc:     kernel@pengutronix.de, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        abelvesa@kernel.org, Peng Fan <peng.fan@nxp.com>
References: <20220703091132.1412063-1-peng.fan@oss.nxp.com>
 <20220703091132.1412063-10-peng.fan@oss.nxp.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <20220703091132.1412063-10-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22. 7. 3. 18:11, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Same to i.MX8MM/N/Q, register i.MX8MP interconnect device to make
> i.MX8MP Interconnect driver work.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/devfreq/imx-bus.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/devfreq/imx-bus.c b/drivers/devfreq/imx-bus.c
> index f87067fc574d..a727067980fb 100644
> --- a/drivers/devfreq/imx-bus.c
> +++ b/drivers/devfreq/imx-bus.c
> @@ -145,6 +145,7 @@ static const struct of_device_id imx_bus_of_match[] = {
>  	{ .compatible = "fsl,imx8mq-noc", .data = "imx8mq-interconnect", },
>  	{ .compatible = "fsl,imx8mm-noc", .data = "imx8mm-interconnect", },
>  	{ .compatible = "fsl,imx8mn-noc", .data = "imx8mn-interconnect", },
> +	{ .compatible = "fsl,imx8mp-noc", .data = "imx8mp-interconnect", },
>  	{ .compatible = "fsl,imx8m-noc", },
>  	{ .compatible = "fsl,imx8m-nic", },
>  	{ /* sentinel */ },

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
