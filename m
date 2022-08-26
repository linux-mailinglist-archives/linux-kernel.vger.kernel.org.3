Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA8C95A276E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 14:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245378AbiHZMKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 08:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245424AbiHZMKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 08:10:05 -0400
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78DD5C9CB;
        Fri, 26 Aug 2022 05:09:59 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 2A81F1256;
        Fri, 26 Aug 2022 14:09:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1661515797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3h8/eJqCYZ/dADzqZWuV0zwBc0KXnjFesE2bqzDwrdI=;
        b=Jv6ymp5snFeJbwFVRDop/u4DHNCzZVF6Yxsp0nN6aT0YvLO9yMqLl/L57bbvNGJoSmhTjU
        Vls8xSNPjNHuF6gn6rOXjd1fPqB6X3gTgobGDwE/8P05+h1UcZExaP2n9LHxF7taSWWWq2
        ujf8JS+TwX/xBxBneFWUPaT4hihBpo/UV2YKgD7r4L9ENQ5lIc56HNlrLLo0sN8Rzimz03
        WiHgJiXUOKpmBVEnx8tk+RH9kF34j6xjYOxWUcJQc7WB6vlC9orK+lld57DqhSKVIRXpdf
        K4/MgXAYNxn1QxBVr2+IwztomfIJY1DUzda1CTqzixfeXRy1xAXRcb+UDtjTUg==
MIME-Version: 1.0
Date:   Fri, 26 Aug 2022 14:09:57 +0200
From:   Michael Walle <michael@walle.cc>
To:     Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        UNGLinuxDriver@microchip.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: sparx5: rename pinctrl nodes
In-Reply-To: <20220420194600.3416282-1-michael@walle.cc>
References: <20220420194600.3416282-1-michael@walle.cc>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <53bb4366654fc451a40cb05ea6c199ca@walle.cc>
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

[+ Arnd because he was the one who picked the first two
patches of this file. Resend because I forgot Arnd, doh!]

Am 2022-04-20 21:46, schrieb Michael Walle:
> The pinctrl device tree binding will be converted to YAML format. 
> Rename
> the pin nodes so they end with "-pins" to match the schema.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
> The YAML conversion patch is alread in
> https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git/log/?h=devel

Ping. Who is picking this one up?

-michael
