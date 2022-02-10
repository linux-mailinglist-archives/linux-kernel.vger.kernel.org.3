Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74E1C4B06EB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 08:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235906AbiBJH0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 02:26:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiBJH0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 02:26:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F381F254;
        Wed,  9 Feb 2022 23:26:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B7A25B80AF9;
        Thu, 10 Feb 2022 07:26:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E08DC004E1;
        Thu, 10 Feb 2022 07:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644477962;
        bh=XAK3gR3Jt5PIItnDx9L7GXAYJrQ2zpIn/6UBryAXvQY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Cyxta8klKp0UWC/zY0xy77TNqZ715uKvTCE8n5pr+MmAmCwkjFMPRHn2HakQ+BBqU
         1vSIhkAARALOxGqYMBGl1hfWHGU98a5C9afw48O8rovcWhPv9s0mCNAKu3LSBQx2et
         vKJbDXhgiGK3eNiQjug59BALdN1ZHmnliN6k+Pl/jlAuAASy9nxzDwc98g7UsNonnk
         yRkYKyHjMWE1vKn7lw4jJfCj7kLxqIGkozL1yQZQBEc1Os7D3A5ud2cPfx8SGnQ9Xn
         D4G7r7cMp5+IyHxLbRVr/kfYYAHTnkZLqx9ObdTfR7PpKIaH7MUPjYIaU2U6gotiU5
         2RVJoHueNcMHw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220209172513.17873-1-tdas@codeaurora.org>
References: <20220209172513.17873-1-tdas@codeaurora.org>
Subject: Re: [v1 1/2] clk: qcom: gdsc: Use the default transition delay for GDSCs
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>
Date:   Wed, 09 Feb 2022 23:26:00 -0800
User-Agent: alot/0.10
Message-Id: <20220210072602.6E08DC004E1@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2022-02-09 09:25:12)
> Do not update the transition delay and use the default reset values.

Why? I know why because I'm CCed on the internal bug but nobody else
knows what's going on here. Please clearly describe what you're fixing,
i.e. that you're seeing black screens on sc7180 because the gdsc is
being enabled/disabled so rapidly that the hardware is getting borked.
Lots more detail please. Otherwise we're going to ignore this patch
series as nonsense because we don't have enough information to realize
that it is important.
