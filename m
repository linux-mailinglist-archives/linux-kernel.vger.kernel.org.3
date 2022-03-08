Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B304D266D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 05:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbiCIBXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 20:23:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbiCIBWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 20:22:44 -0500
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8328FB54D6;
        Tue,  8 Mar 2022 17:19:57 -0800 (PST)
Received: from relay6-d.mail.gandi.net (unknown [217.70.183.198])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 82E6DC86D9;
        Tue,  8 Mar 2022 23:32:09 +0000 (UTC)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 03765C0003;
        Tue,  8 Mar 2022 23:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646782289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YlCM3z0vt4xJuaDGP/qHthWWjPQ/iDmyI70ur1aJgMA=;
        b=ZeO298VTaZW4ZKPS+hbL1WnQkoxuOjCmgXkCIu5l9+mlTl+WzqybFHz15IKUn6dhK/iEJx
        0RaZ+8+OOFTKo3+f4Kz1ZV4FC53HEwpC0rxmE4DTJiAfyRrmI4p0TyUedzsaJZLbW6wlAi
        PnHqquyAUoxVVoiX3PuKWCcFC7I26/boPZUnZI1rtrI7qzur9Kco4ZsLM8plhy1jCX5xcF
        QEU4vwldXDjJxoE7C7QivEi33hy0F/2uARucukhVeB1Eio82925hJnBiM/n1r4+IpV0f8v
        IgjNOagNWFZmSZ2zcd7pgSA3yUMKqKB5sAQ6zB7mocPxCz0tjFqpqyOwrx5rQw==
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, a.zummo@towertech.it
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH] rtc: rtc-wm8350: Handle error for wm8350_register_irq
Date:   Wed,  9 Mar 2022 00:31:25 +0100
Message-Id: <164678227866.114704.3399068049794620806.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220303085030.291793-1-jiasheng@iscas.ac.cn>
References: <20220303085030.291793-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Mar 2022 16:50:30 +0800, Jiasheng Jiang wrote:
> As the potential failure of the wm8350_register_irq(),
> it should be better to check it and return error if fails.
> Also, it need not free 'wm_rtc->rtc' since it will be freed
> automatically.
> 
> 

Applied, thanks!

[1/1] rtc: rtc-wm8350: Handle error for wm8350_register_irq
      commit: 5e086367298dfaa1617885e797c8a58873365f03

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
