Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCFA4DA5C6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 23:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344404AbiCOW4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 18:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbiCOW4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 18:56:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31FA613D43;
        Tue, 15 Mar 2022 15:55:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DCA92B8175E;
        Tue, 15 Mar 2022 22:55:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73F2DC340E8;
        Tue, 15 Mar 2022 22:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647384899;
        bh=hP0hQ+FSDuIJsjGAAZ54SAGZsV5IZs9klzsGioeb6+E=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Tb7BXTjUZuwjCHV6reInbp6pttDwUfN3gAhDQ7JVgIabvAuHuHvawepnBmHwpLvqK
         Jco14rXeADtC67CrvRmcPLto68sagjjcnzkg/u6WKUw8uKkxZy+Xmr7FLtzPBS4Mb2
         Z6lIsS3s7VzfMGeiswenjU4TgUjQVnY3LiUnVMsEBocSghpiDuTaoBTNLMH/pLo5Pg
         WZx6j/2BMPXXZYpZdjDnZcjPnXFmOgHVvnYfkwobjPOV58DEvVUJDhR5Wh5mpUSOJb
         la5OpD2YnbYBwp5od936BdfephsaJjhEyu/wLNdV++heqdkUcmWJKPXGskpLf/Gr15
         Ti2XX6ntGBEAQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <db92d209fa700f7da8bc8028083476fcc138d80e.1646388139.git.zong.li@sifive.com>
References: <cover.1646388139.git.zong.li@sifive.com> <db92d209fa700f7da8bc8028083476fcc138d80e.1646388139.git.zong.li@sifive.com>
Subject: Re: [PATCH v2 3/5] riscv: dts: Change the macro name of prci in each device node
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Zong Li <zong.li@sifive.com>, Palmer Dabbelt <palmer@rivosinc.com>
To:     Zong Li <zong.li@sifive.com>, devicetree@vger.kernel.org,
        lee.jones@linaro.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        mturquette@baylibre.com, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org
Date:   Tue, 15 Mar 2022 15:54:57 -0700
User-Agent: alot/0.10
Message-Id: <20220315225459.73F2DC340E8@smtp.kernel.org>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Zong Li (2022-03-04 02:03:19)
> We currently change the macro name for fu540 and fu740 by adding the
> prefix respectively, these marcos are referenced by some device nodes,
> they should be modified as well.
>=20
> Signed-off-by: Zong Li <zong.li@sifive.com>
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---

Cool. So it looks like I can take the clk patches and not this one and
it should be OK?
