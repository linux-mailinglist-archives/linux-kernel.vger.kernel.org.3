Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 888F55ADB34
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 00:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbiIEWKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 18:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiIEWKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 18:10:40 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5268AB1D6;
        Mon,  5 Sep 2022 15:10:39 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id t11-20020a17090a510b00b001fac77e9d1fso13137071pjh.5;
        Mon, 05 Sep 2022 15:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=rHbwa+ETbtYUANsBTVWNjZWG0BkqdCsIfqhd9acGOgw=;
        b=cjh6syUgRz97EiiPXr+qHE4yf0c4EUKusy+vZkNeNgcob8hqHjA2CgfDkQJLaY1ehV
         pMwZCzMIiOAb18oWKGqRb5/rn10dnUFtsryv3qsaAAbM8QIRsH1SNT5w+Xtj27YT0VsA
         XCjQRsiBbDne5BujCK1CmHSnIaLxTK3jaB/qI9oCA9Zdb3Kz25zZP0ZtrZDo/BSZGniV
         RJAJqmfujcOhascsSK/d1yKixsbvyd1Nd0dfJouT7IrQZboeNiykpKaMDnicZnAii4vP
         gF/BhFb+CPXW3ya2Ck55BwpNEPX3dvy0YtP24NGJJhau/a1agNxd7ySW1lbeKlnJTQ1Q
         yxAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=rHbwa+ETbtYUANsBTVWNjZWG0BkqdCsIfqhd9acGOgw=;
        b=yUnKs1F50HIbWUN+OID+fVsTuJq2a+37FK9VzDp/oNq+rrfILNTSFrvQOqhKWEPelu
         NucsmODhpBLYgBlgFNFNxLpUMv0hrj17bn6P6t5vMvP+ekM+LaoNozKTfRzYKvENgDYO
         fwf14S6NA7x6gm9AyWBeLXsQ061gyALO0kLrZAspnQz/fVn9ad3nOjbx+Z5aDsAnsz6Y
         iqlEBol/6YLp/z34xFjaGBFWYOl2PkgYZDtdtXwbVfL9+xOZbf3uKnHB8q7eKR+ZZGHh
         0qm22t02mbmIV0c7sI4Efp+jGNBbaYQcOTiT4ws1qCKwsUTM/7IVJ1En5oIBDEnCck8S
         YTBw==
X-Gm-Message-State: ACgBeo2jWsOKQKEBa17W1N4sWqrbynZvWwCqishxY86iDS31lfS/3lAJ
        Pf5BgCKBUD7wIxEId7Seo2o=
X-Google-Smtp-Source: AA6agR5TpH1oRv3WHQn+TNNZ1cubaRlmz2AFvfZRkStlyJDL5bREK8hZM3eSs3Fb38I8cnVOE53zsw==
X-Received: by 2002:a17:903:189:b0:176:861a:d4d1 with SMTP id z9-20020a170903018900b00176861ad4d1mr12779641plg.154.1662415838849;
        Mon, 05 Sep 2022 15:10:38 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x16-20020aa79410000000b0053e19468443sm242628pfo.37.2022.09.05.15.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 15:10:38 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 5 Sep 2022 15:10:37 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc:     linux-hwmon@vger.kernel.org, robert.marko@sartura.hr,
        luka.perkov@sartura.hr, jdelvare@suse.com, dev@aboehler.at,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] hwmon: (tps23861) fix byte order in resistance
 register
Message-ID: <20220905221037.GA3694440@roeck-us.net>
References: <20220905142806.110598-1-mr.nuke.me@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220905142806.110598-1-mr.nuke.me@gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2022 at 09:28:04AM -0500, Alexandru Gagniuc wrote:
> The tps23861 registers are little-endian, and regmap_read_bulk() does
> not do byte order conversion. On BE machines, the bytes were swapped,
> and the interpretation of the resistance value was incorrect.
> 
> To make it work on both big and little-endian machines, use
> le16_to_cpu() to convert the resitance register to host byte order.
> 
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/tps23861.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hwmon/tps23861.c b/drivers/hwmon/tps23861.c
> index 42762e87b014..f7c59ff7ae8e 100644
> --- a/drivers/hwmon/tps23861.c
> +++ b/drivers/hwmon/tps23861.c
> @@ -493,18 +493,20 @@ static char *tps23861_port_poe_plus_status(struct tps23861_data *data, int port)
>  
>  static int tps23861_port_resistance(struct tps23861_data *data, int port)
>  {
> -	u16 regval;
> +	unsigned int raw_val;
> +	__le16 regval;
>  
>  	regmap_bulk_read(data->regmap,
>  			 PORT_1_RESISTANCE_LSB + PORT_N_RESISTANCE_LSB_OFFSET * (port - 1),
>  			 &regval,
>  			 2);
>  
> -	switch (FIELD_GET(PORT_RESISTANCE_RSN_MASK, regval)) {
> +	raw_val = le16_to_cpu(regval);
> +	switch (FIELD_GET(PORT_RESISTANCE_RSN_MASK, raw_val)) {
>  	case PORT_RESISTANCE_RSN_OTHER:
> -		return (FIELD_GET(PORT_RESISTANCE_MASK, regval) * RESISTANCE_LSB) / 10000;
> +		return (FIELD_GET(PORT_RESISTANCE_MASK, raw_val) * RESISTANCE_LSB) / 10000;
>  	case PORT_RESISTANCE_RSN_LOW:
> -		return (FIELD_GET(PORT_RESISTANCE_MASK, regval) * RESISTANCE_LSB_LOW) / 10000;
> +		return (FIELD_GET(PORT_RESISTANCE_MASK, raw_val) * RESISTANCE_LSB_LOW) / 10000;
>  	case PORT_RESISTANCE_RSN_SHORT:
>  	case PORT_RESISTANCE_RSN_OPEN:
>  	default:
