Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDEC94D8F11
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 22:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245412AbiCNVvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 17:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236193AbiCNVvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 17:51:39 -0400
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49FA6344C7;
        Mon, 14 Mar 2022 14:50:29 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id r11so20014918ioh.10;
        Mon, 14 Mar 2022 14:50:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=CGEh5iCMps2XS5R44sd7XPYTqLJq0sP1C+L9zYhWYlI=;
        b=8Kv9xUNbCfhsRri5gbSrC9Tr0i+26T5SBixQtEQn4UxEtcfJWK7+RH37pbAVk+9RxM
         ES5X3FAP4FDgUGJ+B0iQ9hteG9DtcfwQ3fkKLk1EOO+tN99KaFq9+9gLLJT3/G1Rg/yc
         r2B1OYK9pRinkxZyVSC6gKj35TllfhPP+NXIbVu7Ky+Tfxdvbtmm4k9zTiP+Pa8CWOZH
         MqojTJp1Osa9eca4/r/G9MFkQcX7EBWfsRIQHudS+W0PHzesNzDuGE4Iwkk2a1mEY8iT
         j9s+7aLS+1iJJpfQqEqE4xnXU5Y/au1l2tOUUr49T7C92xhnZSpr1ZYgERAf+SXsZ3vM
         50jQ==
X-Gm-Message-State: AOAM530Rlusdxn7t130DM1fknv7n7IqalCB9FAtJ2xk+RUo02nBNAoaT
        /c22A12SPOaNxL+ZUApQLw==
X-Google-Smtp-Source: ABdhPJweO3VWhgxdwP7gQ1lIiOQaKbWSgKSaZY/XLgS/m78dLb5ar/Nckf4Npe8/Eq4Iw9CzsqdXRQ==
X-Received: by 2002:a02:bb8c:0:b0:317:b015:1998 with SMTP id g12-20020a02bb8c000000b00317b0151998mr21388886jan.134.1647294628516;
        Mon, 14 Mar 2022 14:50:28 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id c12-20020a056e02058c00b002c63f71c7dbsm9137733ils.56.2022.03.14.14.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 14:50:27 -0700 (PDT)
Received: (nullmailer pid 623447 invoked by uid 1000);
        Mon, 14 Mar 2022 21:50:24 -0000
Date:   Mon, 14 Mar 2022 15:50:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Frank Wunderlich <linux@fw-web.de>, devicetree@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>, soc@kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: Re: [PATCH v6 3/6] ARM: dts: spear13xx: Fix sata node name
Message-ID: <Yi+4oN5xuS2pq0ru@robh.at.kernel.org>
References: <20220311210357.222830-1-linux@fw-web.de>
 <20220311210357.222830-4-linux@fw-web.de>
 <20220314034940.rxkgue2kllnqhucp@vireshk-i7>
 <trinity-0f1389c2-6d2b-4499-a2fc-3cb93f4d09cb-1647272336831@3c-app-gmx-bap56>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <trinity-0f1389c2-6d2b-4499-a2fc-3cb93f4d09cb-1647272336831@3c-app-gmx-bap56>
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

On Mon, Mar 14, 2022 at 04:38:56PM +0100, Frank Wunderlich wrote:
> Hi,
> 
> thanks for for checking the spear-patch.
> 
> > Gesendet: Montag, 14. März 2022 um 04:49 Uhr
> > Von: "Viresh Kumar" <viresh.kumar@linaro.org>
> >
> > On 11-03-22, 22:03, Frank Wunderlich wrote:
> > > From: Frank Wunderlich <frank-w@public-files.de>
> > > 
> > > After converting the binding to yaml the node name does
> > > not match the standard pattern, change it.
> > > 
> > > arch/arm/boot/dts/spear1340-evb.dt.yaml: ahci@b1000000:
> > > $nodename:0: 'ahci@b1000000' does not match '^sata(@.*)?$'
> > > 	From schema: Documentation/devicetree/bindings/ata/ahci-platform.yaml
> > > 
> > > Fixes: 07658d9a659b ("SPEAr13xx: Add dts and dtsi files")
> > 
> > I don't think this is correct. The above patch is correct. The first
> > patch in this series changes the names and that's where things break.
> 
> it's right that my binding will break it, but the nodes are not named the right way.
> And i used the commit that introduces the wrong node-names.
> Maybe fixes-tag is wrong in this case.

I'm pretty sure Viresh just meant the Fixes tag is not right.

Rob
