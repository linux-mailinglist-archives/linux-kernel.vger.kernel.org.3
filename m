Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D24A04D6C3A
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 04:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiCLDZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 22:25:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiCLDZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 22:25:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147DA1081BA;
        Fri, 11 Mar 2022 19:24:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B78D5B82462;
        Sat, 12 Mar 2022 03:24:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70250C340E9;
        Sat, 12 Mar 2022 03:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647055447;
        bh=7whFL6Y3ycFXD6pTFu6ulOAxdy224/kQD2sGSZcpULE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=SQETUFTtreJZxZp04Zlna/DAMQCAws5/HnScmI8mpjRSvFCh2kJdojsHDx4zd/AC4
         2PgFmnYRJ3Ret6lXPHnfjtiSevhNgAEJyFyX7NqS8Nt8aZmZo+aLjvr4JWt7Ufi4Qj
         2NbK0quqqi3Eanxb53SLjGI20Y1q7BcbScLEE47ueLWEf/dioRiZcBF5lAUH+ekI2/
         HCPdA+uenHqqoYSnfn3QPkHEhZqdpQuEgWuF5zq/8ARt4UbJ/VFla1xrdHiH25AkYa
         1JHBpILjwxI4tQj6dvqY3Ka1rx+tLkIUxeELG+pUTWPTqRYFboI3S/T3BSl037WmZm
         gQZXmDWLJSEXg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220303014856.2059307-1-chi.minghao@zte.com.cn>
References: <20220303014856.2059307-1-chi.minghao@zte.com.cn>
Subject: Re: [PATCH] clk: Use of_device_get_match_data()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     narmstrong@baylibre.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-oxnas@groups.io,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
To:     cgel.zte@gmail.com, mturquette@baylibre.com
Date:   Fri, 11 Mar 2022 19:24:04 -0800
User-Agent: alot/0.10
Message-Id: <20220312032407.70250C340E9@smtp.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting cgel.zte@gmail.com (2022-03-02 17:48:56)
> From: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>
>=20
> Use of_device_get_match_data() to simplify the code.
>=20
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>
> ---

Applied to clk-next
