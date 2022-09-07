Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 436755B03ED
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 14:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiIGMbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 08:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiIGMbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 08:31:16 -0400
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7B88A1F7;
        Wed,  7 Sep 2022 05:31:15 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 102C711C;
        Wed,  7 Sep 2022 14:31:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1662553873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kN857gTumoZn8Gb2kgshbbS+axSnJL0KMWhLpEISQRg=;
        b=eDJBA+01/tWF6T6Z2G/KVG87d5jG/MYtuzd03CFy4WLb3v5gd68EbnYEzede+ddjVz9Y0z
        XpZONl52PTG1qMJPBGIc2YYW3Fi/jGFvcSBG8Ihnweod8lyZXE1S1i2M3Q1au0Fu0Q8YSC
        PaHJV1fcHj2KPZ7gAn+/5Bhw4BUIzYYV62P90Qznf3YXLgYZaMFjojNL1pZtlrREphyjLo
        QrFC30QwEjt8aykM7R2FirMIopICWriYYJea+lsaPlSajzZDyRG163nqNAKCET08oTfXC5
        MO6WN+1i3i5nvaN8yjmjlg+HSCXoDozDdL6e1UmF+IWDmF26uvQNZBiM4TJQXA==
MIME-Version: 1.0
Date:   Wed, 07 Sep 2022 14:31:12 +0200
From:   Michael Walle <michael@walle.cc>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v2 11/20] nvmem: imx-ocotp: replace global post processing
 with layouts
In-Reply-To: <20220901221857.2600340-12-michael@walle.cc>
References: <20220901221857.2600340-1-michael@walle.cc>
 <20220901221857.2600340-12-michael@walle.cc>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <42a72fc508b8f3896092a2b1d56305b1@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-09-02 00:18, schrieb Michael Walle:
> In preparation of retiring the global post processing hook change this
> driver to use layouts. The layout will be supplied during registration
> and will be used to add the post processing hook to all added cells.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
> Complile-time tested only! Please test.

Tested-by: Michael Walle <michael@walle.cc> # on kontron-pitx-imx8m

-michael
