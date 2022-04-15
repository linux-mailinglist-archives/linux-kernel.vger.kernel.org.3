Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7C31502BF2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 16:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354557AbiDOOfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 10:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354530AbiDOOfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 10:35:14 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD528BE1F;
        Fri, 15 Apr 2022 07:32:45 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id r85so3353124oie.7;
        Fri, 15 Apr 2022 07:32:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=WRvWFCZM+CSlWmbu28ZW3agDB/Ioh2AgkDnpKocjFBE=;
        b=jbcLuV3Q33imNNoipA7PL6D0OzXNktu2DR7dSHO9IkecfyJcPHJt/9+dDFvoobsr7H
         Nq7G6NU+jDIi11X4bqKkJiRVyMB/53DdL8vRDRED3JwkCcyC5WM/JRwW7n9LywWC1XOC
         dtPT/rEYmu9Sz3ZlvlsnEmpcjegaq/82SgS+/C0670WXdmBfWQvG2b71Iih6GVBtX3n6
         TlXZt/rI1UvHvqLyZxfTzL39oYxBz264i5CckM0QBycBXeZ+NmGKjRDq+ulou9D5uL9C
         U72SJl3Teq9T5HtltRv+LuXefcC+LS9dOyCqLVxqhvUUsukevZxDudvc78wQEmL2LwoF
         3hiA==
X-Gm-Message-State: AOAM531604cjovVKnXK1w14lBwXqkvuSNDeaty/OSf26DvTlmsZsKcnV
        sXDrN8VhcOcEHyan+46E5g==
X-Google-Smtp-Source: ABdhPJy+M+qLnqcZGHZA2zAZsZUD29gfwCAun1jdghPH9Ok1etH7dNXYHty41fGiEXQm7/IucVah8g==
X-Received: by 2002:a05:6808:211f:b0:2da:84f6:9eed with SMTP id r31-20020a056808211f00b002da84f69eedmr1597872oiw.239.1650033164763;
        Fri, 15 Apr 2022 07:32:44 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bf35-20020a056808192300b002fa282123b7sm1178973oib.2.2022.04.15.07.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 07:32:44 -0700 (PDT)
Received: (nullmailer pid 251789 invoked by uid 1000);
        Fri, 15 Apr 2022 14:32:41 -0000
From:   Rob Herring <robh@kernel.org>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     robh+dt@kernel.org, sebastian.hesselbarth@gmail.com,
        ulf.hansson@linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        andrew@lunn.ch, linux-mmc@vger.kernel.org,
        gregory.clement@bootlin.com, krzk+dt@kernel.org
In-Reply-To: <20220414230603.567049-4-chris.packham@alliedtelesis.co.nz>
References: <20220414230603.567049-1-chris.packham@alliedtelesis.co.nz> <20220414230603.567049-4-chris.packham@alliedtelesis.co.nz>
Subject: Re: [PATCH 3/4] dt-bindings: mmc: convert orion-sdio to JSON schema
Date:   Fri, 15 Apr 2022 09:32:41 -0500
Message-Id: <1650033161.788328.251788.nullmailer@robh.at.kernel.org>
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

On Fri, 15 Apr 2022 11:06:02 +1200, Chris Packham wrote:
> Convert the orion-sdio binding to JSON schema.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>  .../bindings/mmc/marvell,orion-sdio.yaml      | 43 +++++++++++++++++++
>  .../devicetree/bindings/mmc/orion-sdio.txt    | 16 -------
>  2 files changed, 43 insertions(+), 16 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/marvell,orion-sdio.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mmc/orion-sdio.txt
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/


mvsdio@90000: $nodename:0: 'mvsdio@90000' does not match '^mmc(@.*)?$'
	arch/arm/boot/dts/kirkwood-b3.dtb
	arch/arm/boot/dts/kirkwood-blackarmor-nas220.dtb
	arch/arm/boot/dts/kirkwood-c200-v1.dtb
	arch/arm/boot/dts/kirkwood-cloudbox.dtb
	arch/arm/boot/dts/kirkwood-d2net.dtb
	arch/arm/boot/dts/kirkwood-db-88f6281.dtb
	arch/arm/boot/dts/kirkwood-db-88f6282.dtb
	arch/arm/boot/dts/kirkwood-dir665.dtb
	arch/arm/boot/dts/kirkwood-dns320.dtb
	arch/arm/boot/dts/kirkwood-dns325.dtb
	arch/arm/boot/dts/kirkwood-dockstar.dtb
	arch/arm/boot/dts/kirkwood-dreamplug.dtb
	arch/arm/boot/dts/kirkwood-ds109.dtb
	arch/arm/boot/dts/kirkwood-ds110jv10.dtb
	arch/arm/boot/dts/kirkwood-ds111.dtb
	arch/arm/boot/dts/kirkwood-ds112.dtb
	arch/arm/boot/dts/kirkwood-ds209.dtb
	arch/arm/boot/dts/kirkwood-ds210.dtb
	arch/arm/boot/dts/kirkwood-ds212.dtb
	arch/arm/boot/dts/kirkwood-ds212j.dtb
	arch/arm/boot/dts/kirkwood-ds409.dtb
	arch/arm/boot/dts/kirkwood-ds409slim.dtb
	arch/arm/boot/dts/kirkwood-ds411.dtb
	arch/arm/boot/dts/kirkwood-ds411j.dtb
	arch/arm/boot/dts/kirkwood-ds411slim.dtb
	arch/arm/boot/dts/kirkwood-goflexnet.dtb
	arch/arm/boot/dts/kirkwood-guruplug-server-plus.dtb
	arch/arm/boot/dts/kirkwood-ib62x0.dtb
	arch/arm/boot/dts/kirkwood-iconnect.dtb
	arch/arm/boot/dts/kirkwood-iomega_ix2_200.dtb
	arch/arm/boot/dts/kirkwood-is2.dtb
	arch/arm/boot/dts/kirkwood-l-50.dtb
	arch/arm/boot/dts/kirkwood-laplug.dtb
	arch/arm/boot/dts/kirkwood-linkstation-lsqvl.dtb
	arch/arm/boot/dts/kirkwood-linkstation-lsvl.dtb
	arch/arm/boot/dts/kirkwood-linkstation-lswsxl.dtb
	arch/arm/boot/dts/kirkwood-linkstation-lswvl.dtb
	arch/arm/boot/dts/kirkwood-linkstation-lswxl.dtb
	arch/arm/boot/dts/kirkwood-linksys-viper.dtb
	arch/arm/boot/dts/kirkwood-lschlv2.dtb
	arch/arm/boot/dts/kirkwood-lsxhl.dtb
	arch/arm/boot/dts/kirkwood-mplcec4.dtb
	arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dtb
	arch/arm/boot/dts/kirkwood-nas2big.dtb
	arch/arm/boot/dts/kirkwood-net2big.dtb
	arch/arm/boot/dts/kirkwood-net5big.dtb
	arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dtb
	arch/arm/boot/dts/kirkwood-netgear_readynas_nv+_v2.dtb
	arch/arm/boot/dts/kirkwood-ns2.dtb
	arch/arm/boot/dts/kirkwood-ns2lite.dtb
	arch/arm/boot/dts/kirkwood-ns2max.dtb
	arch/arm/boot/dts/kirkwood-ns2mini.dtb
	arch/arm/boot/dts/kirkwood-nsa310a.dtb
	arch/arm/boot/dts/kirkwood-nsa310.dtb
	arch/arm/boot/dts/kirkwood-nsa320.dtb
	arch/arm/boot/dts/kirkwood-nsa325.dtb
	arch/arm/boot/dts/kirkwood-openblocks_a6.dtb
	arch/arm/boot/dts/kirkwood-openblocks_a7.dtb
	arch/arm/boot/dts/kirkwood-openrd-base.dtb
	arch/arm/boot/dts/kirkwood-openrd-client.dtb
	arch/arm/boot/dts/kirkwood-openrd-ultimate.dtb
	arch/arm/boot/dts/kirkwood-pogo_e02.dtb
	arch/arm/boot/dts/kirkwood-pogoplug-series-4.dtb
	arch/arm/boot/dts/kirkwood-rd88f6192.dtb
	arch/arm/boot/dts/kirkwood-rd88f6281-a.dtb
	arch/arm/boot/dts/kirkwood-rd88f6281-z0.dtb
	arch/arm/boot/dts/kirkwood-rs212.dtb
	arch/arm/boot/dts/kirkwood-rs409.dtb
	arch/arm/boot/dts/kirkwood-rs411.dtb
	arch/arm/boot/dts/kirkwood-sheevaplug.dtb
	arch/arm/boot/dts/kirkwood-sheevaplug-esata.dtb
	arch/arm/boot/dts/kirkwood-t5325.dtb
	arch/arm/boot/dts/kirkwood-topkick.dtb
	arch/arm/boot/dts/kirkwood-ts219-6281.dtb
	arch/arm/boot/dts/kirkwood-ts219-6282.dtb
	arch/arm/boot/dts/kirkwood-ts419-6281.dtb
	arch/arm/boot/dts/kirkwood-ts419-6282.dtb

mvsdio@90000: Unevaluated properties are not allowed ('bus-width', 'cap-sdio-irq', 'cap-sd-highspeed', 'cap-mmc-highspeed', 'broken-cd' were unexpected)
	arch/arm/boot/dts/kirkwood-dreamplug.dtb
	arch/arm/boot/dts/kirkwood-sheevaplug.dtb
	arch/arm/boot/dts/kirkwood-topkick.dtb

mvsdio@90000: Unevaluated properties are not allowed ('bus-width', 'cap-sdio-irq', 'cap-sd-highspeed', 'cap-mmc-highspeed', 'cd-gpios' were unexpected)
	arch/arm/boot/dts/kirkwood-l-50.dtb
	arch/arm/boot/dts/kirkwood-mplcec4.dtb
	arch/arm/boot/dts/kirkwood-openrd-base.dtb
	arch/arm/boot/dts/kirkwood-openrd-client.dtb
	arch/arm/boot/dts/kirkwood-openrd-ultimate.dtb
	arch/arm/boot/dts/kirkwood-rd88f6281-a.dtb
	arch/arm/boot/dts/kirkwood-rd88f6281-z0.dtb

mvsdio@90000: Unevaluated properties are not allowed ('bus-width', 'cap-sdio-irq', 'cap-sd-highspeed', 'cap-mmc-highspeed', 'cd-gpios', 'wp-gpios' were unexpected)
	arch/arm/boot/dts/kirkwood-pogoplug-series-4.dtb
	arch/arm/boot/dts/kirkwood-sheevaplug-esata.dtb

mvsdio@90000: Unevaluated properties are not allowed ('bus-width', 'cap-sdio-irq', 'cap-sd-highspeed', 'cap-mmc-highspeed', 'non-removable' were unexpected)
	arch/arm/boot/dts/kirkwood-guruplug-server-plus.dtb

mvsdio@90000: Unevaluated properties are not allowed ('bus-width', 'cap-sdio-irq', 'cap-sd-highspeed', 'cap-mmc-highspeed' were unexpected)
	arch/arm/boot/dts/kirkwood-b3.dtb
	arch/arm/boot/dts/kirkwood-blackarmor-nas220.dtb
	arch/arm/boot/dts/kirkwood-c200-v1.dtb
	arch/arm/boot/dts/kirkwood-cloudbox.dtb
	arch/arm/boot/dts/kirkwood-d2net.dtb
	arch/arm/boot/dts/kirkwood-dir665.dtb
	arch/arm/boot/dts/kirkwood-dns320.dtb
	arch/arm/boot/dts/kirkwood-dns325.dtb
	arch/arm/boot/dts/kirkwood-dockstar.dtb
	arch/arm/boot/dts/kirkwood-ds109.dtb
	arch/arm/boot/dts/kirkwood-ds110jv10.dtb
	arch/arm/boot/dts/kirkwood-ds111.dtb
	arch/arm/boot/dts/kirkwood-ds112.dtb
	arch/arm/boot/dts/kirkwood-ds209.dtb
	arch/arm/boot/dts/kirkwood-ds210.dtb
	arch/arm/boot/dts/kirkwood-ds212.dtb
	arch/arm/boot/dts/kirkwood-ds212j.dtb
	arch/arm/boot/dts/kirkwood-ds409.dtb
	arch/arm/boot/dts/kirkwood-ds409slim.dtb
	arch/arm/boot/dts/kirkwood-ds411.dtb
	arch/arm/boot/dts/kirkwood-ds411j.dtb
	arch/arm/boot/dts/kirkwood-ds411slim.dtb
	arch/arm/boot/dts/kirkwood-goflexnet.dtb
	arch/arm/boot/dts/kirkwood-ib62x0.dtb
	arch/arm/boot/dts/kirkwood-iconnect.dtb
	arch/arm/boot/dts/kirkwood-iomega_ix2_200.dtb
	arch/arm/boot/dts/kirkwood-is2.dtb
	arch/arm/boot/dts/kirkwood-laplug.dtb
	arch/arm/boot/dts/kirkwood-linkstation-lsqvl.dtb
	arch/arm/boot/dts/kirkwood-linkstation-lsvl.dtb
	arch/arm/boot/dts/kirkwood-linkstation-lswsxl.dtb
	arch/arm/boot/dts/kirkwood-linkstation-lswvl.dtb
	arch/arm/boot/dts/kirkwood-linkstation-lswxl.dtb
	arch/arm/boot/dts/kirkwood-linksys-viper.dtb
	arch/arm/boot/dts/kirkwood-lschlv2.dtb
	arch/arm/boot/dts/kirkwood-lsxhl.dtb
	arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dtb
	arch/arm/boot/dts/kirkwood-nas2big.dtb
	arch/arm/boot/dts/kirkwood-net2big.dtb
	arch/arm/boot/dts/kirkwood-net5big.dtb
	arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dtb
	arch/arm/boot/dts/kirkwood-netgear_readynas_nv+_v2.dtb
	arch/arm/boot/dts/kirkwood-ns2.dtb
	arch/arm/boot/dts/kirkwood-ns2lite.dtb
	arch/arm/boot/dts/kirkwood-ns2max.dtb
	arch/arm/boot/dts/kirkwood-ns2mini.dtb
	arch/arm/boot/dts/kirkwood-nsa310a.dtb
	arch/arm/boot/dts/kirkwood-nsa310.dtb
	arch/arm/boot/dts/kirkwood-nsa320.dtb
	arch/arm/boot/dts/kirkwood-nsa325.dtb
	arch/arm/boot/dts/kirkwood-openblocks_a6.dtb
	arch/arm/boot/dts/kirkwood-openblocks_a7.dtb
	arch/arm/boot/dts/kirkwood-pogo_e02.dtb
	arch/arm/boot/dts/kirkwood-rd88f6192.dtb
	arch/arm/boot/dts/kirkwood-rs212.dtb
	arch/arm/boot/dts/kirkwood-rs409.dtb
	arch/arm/boot/dts/kirkwood-rs411.dtb
	arch/arm/boot/dts/kirkwood-t5325.dtb
	arch/arm/boot/dts/kirkwood-ts219-6281.dtb
	arch/arm/boot/dts/kirkwood-ts219-6282.dtb
	arch/arm/boot/dts/kirkwood-ts419-6281.dtb
	arch/arm/boot/dts/kirkwood-ts419-6282.dtb

mvsdio@90000: Unevaluated properties are not allowed ('wp-gpios', 'cd-gpios', 'bus-width', 'cap-sdio-irq', 'cap-sd-highspeed', 'cap-mmc-highspeed' were unexpected)
	arch/arm/boot/dts/kirkwood-db-88f6281.dtb
	arch/arm/boot/dts/kirkwood-db-88f6282.dtb

mvsdio@d4000: $nodename:0: 'mvsdio@d4000' does not match '^mmc(@.*)?$'
	arch/arm/boot/dts/armada-370-c200-v2.dtb
	arch/arm/boot/dts/armada-370-db.dtb
	arch/arm/boot/dts/armada-370-dlink-dns327l.dtb
	arch/arm/boot/dts/armada-370-mirabox.dtb
	arch/arm/boot/dts/armada-370-netgear-rn102.dtb
	arch/arm/boot/dts/armada-370-netgear-rn104.dtb
	arch/arm/boot/dts/armada-370-rd.dtb
	arch/arm/boot/dts/armada-370-seagate-nas-2bay.dtb
	arch/arm/boot/dts/armada-370-seagate-nas-4bay.dtb
	arch/arm/boot/dts/armada-370-seagate-personal-cloud-2bay.dtb
	arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtb
	arch/arm/boot/dts/armada-370-synology-ds213j.dtb
	arch/arm/boot/dts/armada-375-db.dtb
	arch/arm/boot/dts/armada-xp-axpwifiap.dtb
	arch/arm/boot/dts/armada-xp-crs305-1g-4s-bit.dtb
	arch/arm/boot/dts/armada-xp-crs305-1g-4s.dtb
	arch/arm/boot/dts/armada-xp-crs326-24g-2s-bit.dtb
	arch/arm/boot/dts/armada-xp-crs326-24g-2s.dtb
	arch/arm/boot/dts/armada-xp-crs328-4c-20s-4s-bit.dtb
	arch/arm/boot/dts/armada-xp-crs328-4c-20s-4s.dtb
	arch/arm/boot/dts/armada-xp-db.dtb
	arch/arm/boot/dts/armada-xp-db-dxbc2.dtb
	arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dtb
	arch/arm/boot/dts/armada-xp-gp.dtb
	arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dtb
	arch/arm/boot/dts/armada-xp-linksys-mamba.dtb
	arch/arm/boot/dts/armada-xp-matrix.dtb
	arch/arm/boot/dts/armada-xp-netgear-rn2120.dtb
	arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dtb
	arch/arm/boot/dts/armada-xp-synology-ds414.dtb

mvsdio@d4000: Unevaluated properties are not allowed ('bus-width', 'cap-sdio-irq', 'cap-sd-highspeed', 'cap-mmc-highspeed', 'broken-cd' were unexpected)
	arch/arm/boot/dts/armada-370-db.dtb
	arch/arm/boot/dts/armada-370-mirabox.dtb
	arch/arm/boot/dts/armada-370-rd.dtb
	arch/arm/boot/dts/armada-xp-db.dtb
	arch/arm/boot/dts/armada-xp-db-dxbc2.dtb

mvsdio@d4000: Unevaluated properties are not allowed ('bus-width', 'cap-sdio-irq', 'cap-sd-highspeed', 'cap-mmc-highspeed', 'cd-gpios', 'wp-gpios' were unexpected)
	arch/arm/boot/dts/armada-375-db.dtb

mvsdio@d4000: Unevaluated properties are not allowed ('bus-width', 'cap-sdio-irq', 'cap-sd-highspeed', 'cap-mmc-highspeed' were unexpected)
	arch/arm/boot/dts/armada-370-c200-v2.dtb
	arch/arm/boot/dts/armada-370-dlink-dns327l.dtb
	arch/arm/boot/dts/armada-370-netgear-rn102.dtb
	arch/arm/boot/dts/armada-370-netgear-rn104.dtb
	arch/arm/boot/dts/armada-370-seagate-nas-2bay.dtb
	arch/arm/boot/dts/armada-370-seagate-nas-4bay.dtb
	arch/arm/boot/dts/armada-370-seagate-personal-cloud-2bay.dtb
	arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtb
	arch/arm/boot/dts/armada-370-synology-ds213j.dtb
	arch/arm/boot/dts/armada-xp-axpwifiap.dtb
	arch/arm/boot/dts/armada-xp-crs305-1g-4s-bit.dtb
	arch/arm/boot/dts/armada-xp-crs305-1g-4s.dtb
	arch/arm/boot/dts/armada-xp-crs326-24g-2s-bit.dtb
	arch/arm/boot/dts/armada-xp-crs326-24g-2s.dtb
	arch/arm/boot/dts/armada-xp-crs328-4c-20s-4s-bit.dtb
	arch/arm/boot/dts/armada-xp-crs328-4c-20s-4s.dtb
	arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dtb
	arch/arm/boot/dts/armada-xp-gp.dtb
	arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dtb
	arch/arm/boot/dts/armada-xp-linksys-mamba.dtb
	arch/arm/boot/dts/armada-xp-matrix.dtb
	arch/arm/boot/dts/armada-xp-netgear-rn2120.dtb
	arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dtb
	arch/arm/boot/dts/armada-xp-synology-ds414.dtb

