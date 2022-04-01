Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB304EF99B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 20:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347805AbiDASRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 14:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238409AbiDASRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 14:17:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F161788E0;
        Fri,  1 Apr 2022 11:15:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 231E060B19;
        Fri,  1 Apr 2022 18:15:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AAF3C340EE;
        Fri,  1 Apr 2022 18:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648836945;
        bh=dVdKOaXz9iaxANVQcfDDCpVI8xWzvRSZh/at93Wv6jg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=uQfzd4BOHaVqDO4ZgZhQhCLT+3p5a1pzo3UJ+8d7cx4bocv5rqXkpG6DD9FXK+sE6
         6xnxiJb23d+LqznCMJUkzJl4Z6tcJq4+JBlBlb7hWf4CjNThkjlGBeW7hBC6HsmTmE
         l/RygU0hN2DtTiUjnU/ItO/PL5pIzTpl+aT+8tY3Z4IiTX+EDNpHOjhHinIMN/g9qS
         tKjfdIOTeoKpsO3vVrWVMLXJX2ISOOkI0KHMrupTroypga+zRE90iwWjuiEFOPL46z
         8q5Ns3WfyrxUzmmiCIHFA2yc1Yha0+07/gf0dTHza66DZd93WOVVnQz11vXOO65diX
         L7kpSOQa1iLxQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220324165904.538861-1-steve@sk2.org>
References: <20220324165904.538861-1-steve@sk2.org>
Subject: Re: [PATCH] clk: use i2c_match_id and simple i2c probe
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wolfram Sang <wsa@kernel.org>, Stephen Kitt <steve@sk2.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Kitt <steve@sk2.org>
Date:   Fri, 01 Apr 2022 11:15:43 -0700
User-Agent: alot/0.10
Message-Id: <20220401181545.7AAF3C340EE@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please fix the subject.

Quoting Stephen Kitt (2022-03-24 09:59:04)
> As part of the ongoing i2c transition to the simple probe
> ("probe_new"), this patch uses i2c_match_id to retrieve the
> driver_data for the probed device. The id parameter is thus no longer
> necessary and the simple probe can be used instead.
>=20
> Signed-off-by: Stephen Kitt <steve@sk2.org>
> ---
>  drivers/clk/clk-cdce925.c | 8 +++++---
>  drivers/clk/clk-si5351.c  | 8 +++++---
>  drivers/clk/clk-si544.c   | 8 +++++---
>  drivers/clk/clk-si570.c   | 8 +++++---

Also split the patch for each driver and send in one patch series with a
cover letter. Then the subject can be appropriate for that driver
instead of generic "clk:" which is only for core things. Looking at
previous patches to these files should help with the subject line.
