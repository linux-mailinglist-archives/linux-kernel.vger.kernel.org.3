Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57BE4F7E02
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 13:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244781AbiDGLZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 07:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232523AbiDGLZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 07:25:56 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFD8637E;
        Thu,  7 Apr 2022 04:23:55 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 6F93022175;
        Thu,  7 Apr 2022 13:23:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1649330633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zGgRGtTK60vlO5rrtbSkRkY0I7pneiIfRmRnhVQTqiA=;
        b=eJq/xpGUixdj2taujpeYf62eEyp0Tsxjm2RpOu01SoSj6ZQChrYPmr+NwcUKMGycjOLgQJ
        qlwynXfDHgBa7PMLhfOxqcYEI2PZa8Httt1JeL8KbhWIX8a8iQVIBYtHNlNFJYkg5w1zeA
        ZYsUZe1PvNp09PTgmjjEZbnSQUVFSG0=
From:   Michael Walle <michael@walle.cc>
To:     broonie@kernel.org
Cc:     Manohar.Puri@microchip.com, UNGLinuxDriver@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        devicetree@vger.kernel.org, kavyasree.kotagiri@microchip.com,
        krzk+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        nicolas.ferre@microchip.com, robh+dt@kernel.org,
        tudor.ambarus@microchip.com, Michael Walle <michael@walle.cc>
Subject: Re: [PATCH] spi: atmel,quadspi: Define lan966x QSPI
Date:   Thu,  7 Apr 2022 13:23:45 +0200
Message-Id: <20220407112345.148316-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <Yk7Ex5ltaxC7Z+N6@sirena.org.uk>
References: <Yk7Ex5ltaxC7Z+N6@sirena.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > @@ -19,6 +19,7 @@ properties:
> >        - microchip,sam9x60-qspi
> >        - microchip,sama7g5-qspi
> >        - microchip,sama7g5-ospi
> > +      - microchip,lan966x-qspi
> 
> Generally DT compatibles should be for specific SoCs rather than having
> wildcards in them, even if that means you have to list a lot of SoCs.
> Having used wildcards in the past doesn't mean it's a good idea to
> continue adding them!

The subject should also be prefixed with "dt-bindings: ".

Mark, I did a git log on
Documentation/devicetree/bindings/spi/atmel,quadspi.yaml and all the
subjects are without "dt-bindings:" although the original patch was with
that prefix [1]. Is that intended?

-michael

[1] https://lore.kernel.org/linux-devicetree/163962128492.2075495.3678727080606971257.b4-ty@kernel.org/
