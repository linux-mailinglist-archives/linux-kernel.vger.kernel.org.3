Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A634DA689
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 00:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352691AbiCPAA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 20:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344372AbiCPAA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 20:00:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C6655750;
        Tue, 15 Mar 2022 16:59:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F313361537;
        Tue, 15 Mar 2022 23:59:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FCC8C340E8;
        Tue, 15 Mar 2022 23:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647388783;
        bh=9b4hTTeP0bR6aPn4lwbDneU/xQj2l5nU58aIBNZnOSY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=hw5xvUyuMU09/78n9pIJpYJYkgzXnqi279u8niki5jTOGhhNFGXaIaG7MvawTgj7/
         XdwFQT0HMYISTpkUvALPzJxtcHB1NRvJULZYPq6WCFWS9DTSjJZsogT+B27HN0/y98
         MRFooug6KIHow/XqbcVyonJyB4oOj3UPdUQ0iYC93dhTj+BG+PNRJCqhGAG+Iod2JJ
         I5AUrgVHJP4vEmHFfSjLbIAls02GHDCQr7KE8GnBZmqsJoQnB82RFWs+fQsHLsqQTy
         jbVNT5nIB7g7TyygYi89ov29KlfaNbaL1Ym28m0bsf4nQMUKF9FMn71wHvoaEay1Z8
         8sSI8kfH5YEOQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <8cfd57f01cfb59adb716eb13ca0c8250c246dcb2.1646388139.git.zong.li@sifive.com>
References: <cover.1646388139.git.zong.li@sifive.com> <8cfd57f01cfb59adb716eb13ca0c8250c246dcb2.1646388139.git.zong.li@sifive.com>
Subject: Re: [PATCH v2 1/5] clk: sifive: duplicate the macro definitions for the time being
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Zong Li <zong.li@sifive.com>
To:     Zong Li <zong.li@sifive.com>, devicetree@vger.kernel.org,
        lee.jones@linaro.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        mturquette@baylibre.com, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org
Date:   Tue, 15 Mar 2022 16:59:40 -0700
User-Agent: alot/0.10
Message-Id: <20220315235943.4FCC8C340E8@smtp.kernel.org>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Zong Li (2022-03-04 02:03:17)
> This is a temporary patch in whole patch set. We are going to change the
> macro name in dt-binding, in order to avoid breaking the driver build
> and git bisect, add these macro definitions for the time being, and we
> will remove them later.
>=20
> Signed-off-by: Zong Li <zong.li@sifive.com>
> ---

Applied to clk-next
