Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A91E550A7C0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 20:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390850AbiDUSGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 14:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391169AbiDUSGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 14:06:17 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2384B1CB;
        Thu, 21 Apr 2022 11:03:14 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 6B41E221D4;
        Thu, 21 Apr 2022 20:03:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1650564192;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AU7UbtZJdZaLPTjfGoEbJIKD0KbKovMrFEPJbze4IkY=;
        b=a7FkFIFKpGy23OqXgon8b7LyQZoQe3T4r7ngPnmiY15wVV+WrU4C7SoEZsC0hLFv5qQTvw
        ZLBg3Qn9mH9RDXsIrmcDdwXC0OpMXfHU6dOTvjoT7SFD6NlcOITxqnkAlfbyBB2zig1zML
        sZBuS67UhK2zxe0Qj+CYfIr2+htJWP0=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 21 Apr 2022 20:03:12 +0200
From:   Michael Walle <michael@walle.cc>
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 1/8] dt-bindings: nvmem: sfp: Fix typo
In-Reply-To: <20220421175657.1259024-2-sean.anderson@seco.com>
References: <20220421175657.1259024-1-sean.anderson@seco.com>
 <20220421175657.1259024-2-sean.anderson@seco.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <8edc55ae1114adff8bdb1244fcacc979@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-04-21 19:56, schrieb Sean Anderson:
> There is a small gramattical error in the description. Fix it.
> 
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>

Reviewed-by: Michael Walle <michael@walle.cc>
