Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05DF15939F3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 21:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245694AbiHOT3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 15:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245561AbiHOT0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 15:26:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DB32A972;
        Mon, 15 Aug 2022 11:41:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8C7D61052;
        Mon, 15 Aug 2022 18:41:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34EF2C433D6;
        Mon, 15 Aug 2022 18:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660588884;
        bh=vLER9ahWMnnAVUjZqdQ45knecrK2MCT78YL5vPl0AyM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=IVr2mMMDTz0rzFchBqIJhG8SPJGCa5MUJnMpZg3URb3AeLBZhnne+L1PgvKfPI3bs
         Zw0fh/evjFcCki+V9JR5wqAFEdPwLU7VkoVO8gsnH4aEqCgUxY8Duc2E6B+cEAwUWG
         vOSkmf1AKb19m3h9bd0zA1ixoXQEpxzGmg7WStDBTxuwKTh4eBPVN1ZVr5KI6I9yAt
         nmydNPRGmHJdz795iJ5uKoQ9tm9K0et8KTCB6Z/VC5zjevP1/Orjx2EcUyvyxFfKpd
         Nh65ZdxnkRXw00HjwdS61ixI4JjaE5bI1I50+5Kj6PvEm+PdjZT+HYHbNwcX/DlokH
         MyMv8dk9Benfw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220510084315.1706978-1-zheyuma97@gmail.com>
References: <20220510084315.1706978-1-zheyuma97@gmail.com>
Subject: Re: [PATCH] clk: max9485: Register a callback to disable the regulator
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zheyu Ma <zheyuma97@gmail.com>
To:     Zheyu Ma <zheyuma97@gmail.com>, mturquette@baylibre.com
Date:   Mon, 15 Aug 2022 11:41:22 -0700
User-Agent: alot/0.10
Message-Id: <20220815184124.34EF2C433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Zheyu Ma (2022-05-10 01:43:15)
> The driver should register a callback which can disable the regulator
> when it fails to probe.
>=20
> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> ---

Looks like there's going to be a devm_regulator_get_enable() API that
we can use instead. Please do that.

https://lore.kernel.org/all/cover.1660292316.git.mazziesaccount@gmail.com/
