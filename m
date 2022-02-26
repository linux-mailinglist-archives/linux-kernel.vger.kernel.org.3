Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF204C52CD
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 02:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240418AbiBZBBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 20:01:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239387AbiBZBBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 20:01:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFBD2023B9;
        Fri, 25 Feb 2022 17:00:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C5B461926;
        Sat, 26 Feb 2022 01:00:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C870C340E7;
        Sat, 26 Feb 2022 01:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645837233;
        bh=ECfcqW6e0y2ETHVpgOzHTU2xw5sNJOJEnitYPIXbMa0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=JS/ds7H5jaXsaLqnxh0fiw54h9u3Zsn1yXMRHq0JUbeEVvy5tJiqPf8z3hM8SJRex
         LgjRkVS5KksAjIEa3fLeyOLNUsX35qmPvY4DSNjuHbwu4zXXqB65mLj+WD1XjzaiO0
         sesbXqUK9w1lR0NGWG8MUsUKsiL/rgmR7j27kdNhP/eWgwdxhVPkto9vKrOUmVpWEq
         GMHhC19UNNiefz04FKZnc/eGX1qLG3Jlfysb5W9Z8nXWftAGdNDK7ffNTIx4gUnj2P
         JT16hJTR1YFagq70AZEoehYkfjp48Ytu4yzlCo8u/SiAG3wzwMpvlGv9fZ9zg5w6IA
         TMsdCmhlBL16Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220205103613.1216218-1-j.neuschaefer@gmx.net>
References: <20220205103613.1216218-1-j.neuschaefer@gmx.net>
Subject: Re: [PATCH v2 0/7] clk: Declare mux tables as const u32[]
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jonathan =?utf-8?q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Jonathan =?utf-8?q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-clk@vger.kernel.org
Date:   Fri, 25 Feb 2022 17:00:31 -0800
User-Agent: alot/0.10
Message-Id: <20220226010033.6C870C340E7@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jonathan Neusch=C3=A4fer (2022-02-05 02:36:06)
> I noticed that the 'table' parameter to clk_register_mux_table is never
> used for modifying the table elements, and so it can be declared const.
>=20
> In version 2 I'm addressing two warnings in the clk-lpc18xx-cgu driver
> that I previously missed.

The format of these patches deeply confused my scripts that use git
interpret-trailer. I fixed it now, hopefully it keeps working. In the
future, please don't add more triple dash '---' sections to the patch.
It looks like those extra sections for the changelog messed everything
up. Or there's a new bug in interpret-trailers.  Either way,
interpret-trailers was adding tags after the entire patch contents
because I think it looks for the last triple dash instead of the first
triple dash. Not sure why it's done that way. I resorted to
reconstructing the patch after splitting it with mailinfo.
