Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54CFF4D6C51
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 04:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbiCLDqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 22:46:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbiCLDql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 22:46:41 -0500
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C16D238932;
        Fri, 11 Mar 2022 19:45:37 -0800 (PST)
Received: by mail-oi1-f181.google.com with SMTP id n7so11523294oif.5;
        Fri, 11 Mar 2022 19:45:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F+svWGiQPbj6b5eqrrYsXkkVUBwPXGhMy9dOFM1Y7js=;
        b=Enut/Y3lSXl6tE/k28hnMJge6HHL5rKy1tgCHIrOCY9cu1U8RTt4Zpq2h2EzoKG3dc
         fRPpJay/TxsyriXiixpBxxyn9Ml3FPoWAlGKhx09ekQJp9N51Kob0H6PEO0eRMjcRuKE
         wEoY7mxiBtLJqOCG+rKLY4xPOs18yrujF8pL52u7472N/n1uYX9Ii3fx2rpTCdzFI2ga
         QkvWiC7C/I7ekXftyfgsVjmTBfRHUkVlOxkSeHumlPPH0bSkwRuTY/k1kHW2rpprpuM6
         8MQC0oX6gVGz2/vxT+wwIR3KOaIH2JI6z6n3fnvwYXAHE1xG3x2Vt6WHGhm2njy3+92j
         Yyww==
X-Gm-Message-State: AOAM533LZ00J8o7MqOJjQfRSyuZSzShdToIuEmBn93e7HFhho4Jr5rWZ
        nrt/azzXx2AaLqZ2NSAFrg==
X-Google-Smtp-Source: ABdhPJzk4+0YFHC3Pb78/3qG1BRW4mUW3u2Py+qjT/Are8jNXsASCtST45p8XPbSbImBaTWkD8R3KQ==
X-Received: by 2002:a05:6808:130f:b0:2da:3ed2:68ca with SMTP id y15-20020a056808130f00b002da3ed268camr9481487oiv.216.1647056736564;
        Fri, 11 Mar 2022 19:45:36 -0800 (PST)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y8-20020a544d88000000b002d525da014bsm4392686oix.42.2022.03.11.19.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 19:45:35 -0800 (PST)
Received: (nullmailer pid 730669 invoked by uid 1000);
        Sat, 12 Mar 2022 03:45:34 -0000
Date:   Fri, 11 Mar 2022 21:45:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Frank Wunderlich <linux@fw-web.de>
Cc:     Russell King <linux@armlinux.org.uk>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Gregory Clement <gregory.clement@bootlin.com>,
        linux-kernel@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Andrew Lunn <andrew@lunn.ch>, linux-ide@vger.kernel.org,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        linux-rockchip@lists.infradead.org, Jens Axboe <axboe@kernel.dk>,
        soc@kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        devicetree@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>
Subject: Re: [PATCH v6 4/6] dt-bindings: ata: ahci-platform: Add
 power-domains property
Message-ID: <YiwXXl61xODMuGlW@robh.at.kernel.org>
References: <20220311210357.222830-1-linux@fw-web.de>
 <20220311210357.222830-5-linux@fw-web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220311210357.222830-5-linux@fw-web.de>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Mar 2022 22:03:55 +0100, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Some SoC using power-domains property so add it here
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
> changes in v5: added reviewed by
> changes in v4: none
> changes in v3:
>   - new patch
> ---
>  Documentation/devicetree/bindings/ata/ahci-platform.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Applied, thanks!
