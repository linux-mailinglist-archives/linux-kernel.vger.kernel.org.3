Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254FC525F7C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 12:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378753AbiEMJ3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 05:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376600AbiEMJ3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 05:29:06 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7F4207902
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 02:29:02 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 81C0E2222E;
        Fri, 13 May 2022 11:29:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1652434140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gqj2kKQOx4E7Q+QxDP67neEt70wGDf/E/8hkpcy6wjU=;
        b=tB2O4hmwfWgyBsJihYXZZHCM4lQTaGfc2OKEaNKGpfkiV0NVRNph8+/c2x00ZhW5vNs+9x
        vWUK/fzkqKo4ma+YOf4nvclC/96mLQV5r7JmP+zVBNSy5auLOwhW9Irw21CxI2iA9jP6TE
        BpgWQ1J4C03g64I5bSrxoOOyQHxEEm0=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 13 May 2022 11:29:00 +0200
From:   Michael Walle <michael@walle.cc>
To:     Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
Cc:     linux@armlinux.org.uk, linus.walleij@linaro.org,
        alexandre.belloni@bootlin.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        UNGLinuxDriver@microchip.com, Manohar.Puri@microchip.com
Subject: Re: [PATCH v4] ARM: at91: debug: add lan966 support
In-Reply-To: <20220513092530.19213-1-kavyasree.kotagiri@microchip.com>
References: <20220513092530.19213-1-kavyasree.kotagiri@microchip.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <6865bc97e975e631ca884114d127952d@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-05-13 11:25, schrieb Kavyasree Kotagiri:
> Add support for low-level debugging on FLEXCOM USART of
> LAN966 SoC.
> 
> Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>

Reviewed-by: Michael Walle <michael@walle.cc>
Tested-by: Michael Walle <michael@walle.cc>

-michael
