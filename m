Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12015A8F55
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 09:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233680AbiIAHH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 03:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233647AbiIAHHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 03:07:17 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B585E6053B
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 00:06:54 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id g5so7348096ybg.11
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 00:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edgeble-ai.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=zK32TEUGn/Arvhzey5bx898nOws+A6RDwPmVxDOXRRM=;
        b=OeX9NMuQiEuDkLAHz6Ts3OmmYlLl/gRRAxrz7ydEg+aQp8cEQtJZfKwW/oJrZ+zanE
         tF3nN9vStDEFgDenYvzGX0NBE4v+G4psAcvPmmQamitEnSSosX0riC0+jT3/41smTjP8
         LqO9qCYy9QmD3bN1ulpmxxOHu1NpEv5uBHkmHb75WJ/01LdBb6rsB7tKCrloecTfLtRi
         KCXy+BAIb5ZFvTM8WYDJ+PHmkDnj0YTfUCozOZPmfppZMWF0YL0OYMGh0H9TJBmA65ut
         HyNnkayrlawPVD9Ny9t0S3Jpz9y6Ar8pddjDRVC0QnR7bLqlZrpV1vXa0dEYWnG40mz5
         KKDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=zK32TEUGn/Arvhzey5bx898nOws+A6RDwPmVxDOXRRM=;
        b=Ga7TX2G9rkFUeBcj0C3bzY+B9Lj92PzdRYICw+Zu8gAtEHTBAwzqPMCmUNIMuftmTE
         9wxdEVbbP03eAJAY6ZkhIAYTw/AY1zB0RbVQGpmest8NBLbHUqkq1lfP0QewPYFYpuca
         WjVsuGEAzHfWEtVs8Heq4XbPMmQoS1W0kG0MMX2sq6INhEbM5N9za8RlbYbQ3UvpUV9L
         1DvqqFtrI3wnqoTxC/vW5xMGgHyLZ0YDtqS6I4QEShC1TYyXLqVSr0R35t9cp02rKpPa
         3DdUkrCPKSe2GElmKsLRiekJctAphQBETeL2PsMplnfal7Za0vuxtynX3EsyNUWISdwl
         2MiQ==
X-Gm-Message-State: ACgBeo0Ya5MtIPxPWU/YP9yVtREEby1gWBcVfd2/Fa1AXnYN5j9ubtq3
        3ASrGCOT3eISmVJ7pnHE1C/UWFhsIhHzL9kVamkxdw==
X-Google-Smtp-Source: AA6agR7txfyyGwgcudxqDLdEC3BY5D6O/gOKss/ew2QiR82vMl/EkDoLUSR9VwKAqGazOuqej+7FuDxpZ3nJTHT+438=
X-Received: by 2002:a25:485:0:b0:69e:f6e0:abb9 with SMTP id
 127-20020a250485000000b0069ef6e0abb9mr3103346ybe.524.1662016013713; Thu, 01
 Sep 2022 00:06:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220829065044.1736-1-anand@edgeble.ai> <20220829065044.1736-2-anand@edgeble.ai>
 <Ywy6o2d9j4Z7+WYX@lunn.ch>
In-Reply-To: <Ywy6o2d9j4Z7+WYX@lunn.ch>
From:   Anand Moon <anand@edgeble.ai>
Date:   Thu, 1 Sep 2022 12:36:43 +0530
Message-ID: <CACF1qnfmzcq55GvsD=GQ+ciLRstZ-7ef1EDaBzKMqBzU0O+WRw@mail.gmail.com>
Subject: Re: [PATCH 2/2] net: ethernet: stmicro: stmmac: dwmac-rk: Add rv1126 support
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Sugar Zhang <sugar.zhang@rock-chips.com>,
        David Wu <david.wu@rock-chips.com>,
        Jagan Teki <jagan@edgeble.ai>, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Mon, 29 Aug 2022 at 18:40, Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Mon, Aug 29, 2022 at 06:50:42AM +0000, Anand Moon wrote:
> > Rockchip RV1126 has GMAC 10/100/1000M ethernet controller
> > via RGMII and RMII interfaces are configured via M0 and M1 pinmux.
> >
> > This patch adds rv1126 support by adding delay lines of M0 and M1
> > simultaneously.
>
> What does 'delay lines' mean with respect to RGMII?
>
> The RGMII signals need a 2ns delay between the clock and the data
> lines. There are three places this can happen:
>
> 1) In the PHY
> 2) Extra long lines on the PCB
> 3) In the MAC
>
> Generally, 1) is used, and controlled via phy-mode. A value of
> PHY_INTERFACE_MODE_RGMII_ID passed to the PHY driver means it will add
> these delays.
>
> You don't want both the MAC and the PHY adding delays.
>
These are set to enable MAC transmit clock delay set for Tx and Rx for
iomux group.
>
>     Andrew

Thanks
-Anand
