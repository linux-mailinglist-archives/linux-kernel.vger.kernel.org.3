Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959A95AAAA3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 10:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235963AbiIBIwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 04:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235894AbiIBIwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 04:52:01 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9C17D1E9
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 01:52:00 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id e195so1105390iof.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 01:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edgeble-ai.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=fP5QUufc8/nDF8+DKG6kWqz0eNAOkgRskOzTNgrAPTY=;
        b=EVSQlDtpd3k83YmFx7EANYTPSj6pRkjkBpZTnZ3YsQVqwLh5bkWw04Rsq4WALtMlQP
         bNUxfYGeuwsjlw1cc4NZ95JJJgWqtpvU1UKFRR0GuLTyMCUFkza77EXIIkYAyjyfmnxJ
         r5SGXWd3T2Zogth/tQwHhtDjoHGVQ9hc3xloflJ0xO74TrzfsWxebKIbINXZyvxZrdsP
         PLD8EAAfKJ4HapDpsx2AqDi9zT0L9mB6B2ai/Ow77OA4oIZLqCq/e/aEo0XoIOkIh2FY
         M2drf6KSfMSCb9EDvfql4lqIo1d6pChqjGpdvar4l55XiWDo5pkDJlO8+uj5el7u4FH6
         djDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=fP5QUufc8/nDF8+DKG6kWqz0eNAOkgRskOzTNgrAPTY=;
        b=Kvsbu273FS8bSdZUTkxiGb8lAuXFLQVpn0zxtQdT28CjWqm+xHBmHXaXErEJL/KMKx
         gGhdrpY7rKtXaiftXdli5BM5kSQtYJvzuKAqLbV1CsM8gMA2k+d+NxCkzVYK5Bghk0up
         f1BT4hdrdx3NFt+ZGN6HEGeVoP852ISXFifRqnj8xrPdtb3ljwjKXOIJA1q37iLAqsbT
         qT5vzcqOHjZnT5SIf+r5AIMcAuqGJeNiAEOCwAXAqC0byO2DFqmB+Y6YrC6CxHPG24Wm
         pScQBv3enefYCtnfTll+Za9XZQVbKyiADGfZ15FfzT3D6wHLgOrjL0PmSFpAG8BM2GYr
         2vxQ==
X-Gm-Message-State: ACgBeo1YVmBxssj3qh5JPKF/JX4OeYOJG6evr1OEwF/dsn09sOZFqC+R
        SJDKIJc8ea4gzNqLl89a66AkTMwC4vNfchxI9TK07Q==
X-Google-Smtp-Source: AA6agR4w6j8Z8678KqWSVpdc1/Jc0po1marz2l8xOyZP+RhwkUrNvN3wWEP5gPchjuSBEMB+vtt29IjvqNLQVmup2mg=
X-Received: by 2002:a02:ce8e:0:b0:349:ce44:38dc with SMTP id
 y14-20020a02ce8e000000b00349ce4438dcmr20231978jaq.298.1662108719577; Fri, 02
 Sep 2022 01:51:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220829065044.1736-1-anand@edgeble.ai> <20220829065044.1736-2-anand@edgeble.ai>
 <Ywy6o2d9j4Z7+WYX@lunn.ch> <CA+VMnFzNcPesS8Mn2mwr-RDXf5sRz-2A3K+syDmpCo1va6JwMw@mail.gmail.com>
 <YxChtBzavS1Fooxs@lunn.ch>
In-Reply-To: <YxChtBzavS1Fooxs@lunn.ch>
From:   Jagan Teki <jagan@edgeble.ai>
Date:   Fri, 2 Sep 2022 14:21:48 +0530
Message-ID: <CA+VMnFy7KUzY_Hj5sX16XR1K=FouA+J7hCKu5j_94khHVmbEJg@mail.gmail.com>
Subject: Re: [PATCH 2/2] net: ethernet: stmicro: stmmac: dwmac-rk: Add rv1126 support
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Anand Moon <anand@edgeble.ai>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Sugar Zhang <sugar.zhang@rock-chips.com>,
        David Wu <david.wu@rock-chips.com>, netdev@vger.kernel.org,
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

On Thu, 1 Sept 2022 at 17:42, Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Thu, Sep 01, 2022 at 12:56:09PM +0530, Jagan Teki wrote:
> > On Mon, 29 Aug 2022 at 18:40, Andrew Lunn <andrew@lunn.ch> wrote:
> > >
> > > On Mon, Aug 29, 2022 at 06:50:42AM +0000, Anand Moon wrote:
> > > > Rockchip RV1126 has GMAC 10/100/1000M ethernet controller
> > > > via RGMII and RMII interfaces are configured via M0 and M1 pinmux.
> > > >
> > > > This patch adds rv1126 support by adding delay lines of M0 and M1
> > > > simultaneously.
> > >
> > > What does 'delay lines' mean with respect to RGMII?
> >
> > These are MAC receive clock delay lengths.
> >
> > >
> > > The RGMII signals need a 2ns delay between the clock and the data
> > > lines. There are three places this can happen:
> > >
> > > 1) In the PHY
> > > 2) Extra long lines on the PCB
> > > 3) In the MAC
> > >
> > > Generally, 1) is used, and controlled via phy-mode. A value of
> > > PHY_INTERFACE_MODE_RGMII_ID passed to the PHY driver means it will add
> > > these delays.
> > >
> > > You don't want both the MAC and the PHY adding delays.
> >
> > Yes, but these are specific to MAC, not related to PHY delays. Similar
> > to what is there in other Rockchip SoC families like RK3366, 3368,
> > 3399, 3128, but these MAC clock delay lengths are grouped based on the
> > iomux group in RV1126. We have iomux group 0 (M0) and group 1 (M1), so
> > the rgmii has to set these lengths irrespective of whether PHY add's
> > or not.
>
> So this is just fine tuning, in the order of pico seconds?
>
> If that is all it is, then this is fine. It becomes a problem when it
> is 2ns.

Yes, it is fine I think. We have tested the delay mentioned as per the
documentation.

tx_delay: Range value is 0~0x7F
rx_delay: Range value is 0~0x7F

Thanks,
Jagan.
