Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5984D6C00
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 03:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbiCLCSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 21:18:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbiCLCSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 21:18:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256592A8245;
        Fri, 11 Mar 2022 18:17:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53F2C616C8;
        Sat, 12 Mar 2022 02:17:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8111C340E9;
        Sat, 12 Mar 2022 02:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647051424;
        bh=JPxKYI+kioKY//dZa/ghEUtfKXCeysUUvoxNqwRuWrk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=MT4fzddmsMpcw0gwbQHPu1wIZlt98BVF1NgwG6Yp+Cm46PsOTkSo6+ngiPHqCDIEf
         vgEq3miSrBxsnmf5tiJkWlwhfUnAWMqYAGhpvIvWa80t5LzZZwc3x6t9nVJnCKCPJ4
         QXAbjpOh0nRM9MPRQqpU3cmwLKCNpFoH6mtzOlNK9i4Zmt/XW5ZaC+gM1z+x+uBOjN
         BRjVTh30Dv+I2yhoTChrOueR8prRCCKCdHJe8TUJUGKQM2YjJ05vJaAmQzy/E5DIHr
         t1fWF5njcqfUJ18Bqlti3X3hkMrjM5+ov0rivObnhB/tBeHWAI3vOmQl1pn/Ub345O
         gLlKU8D1KKA8w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220218000922.134857-6-j.neuschaefer@gmx.net>
References: <20220218000922.134857-1-j.neuschaefer@gmx.net> <20220218000922.134857-6-j.neuschaefer@gmx.net>
Subject: Re: [PATCH v4 5/5] clk: actions: Make sentinel elements more obvious
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org,
        Philippe =?utf-8?q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        Jonathan =?utf-8?q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Andreas =?utf-8?q?F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-actions@lists.infradead.org
To:     Jonathan =?utf-8?q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-clk@vger.kernel.org
Date:   Fri, 11 Mar 2022 18:17:02 -0800
User-Agent: alot/0.10
Message-Id: <20220312021704.A8111C340E9@smtp.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jonathan Neusch=C3=A4fer (2022-02-17 16:09:21)
> The sentinel elements of various tables in drivers/clk/actions can be a
> bit hard to recognize. Make them easier to see by changing the style
> from { 0, 0 } to { /* sentinel */ }.
>=20
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> ---

Applied to clk-next
