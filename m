Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414FE4DA098
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 17:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350337AbiCOQ5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 12:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350328AbiCOQ5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 12:57:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133BB57481;
        Tue, 15 Mar 2022 09:56:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9AB0E614DB;
        Tue, 15 Mar 2022 16:56:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2840C340E8;
        Tue, 15 Mar 2022 16:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647363378;
        bh=UAi0EMv7XsaC3HXAENW9LvxyhyYi4MVZ3DgO7/FLUp0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ERXHZ56yH3rxoSi6lsHSdTpbahIEeZM/LRAtagcCIbdCTez+wWSFu4AmPEW8mjaAS
         jgbQa8n6/hP7AVe+7bHEv0vZMHQoUMGbcZ/t6H2QHvc4vDePixQ0nAHwb0zJzPsRJp
         d7Aq+zivS6/MqDjrJXY9YnSWZUdE1HX246CdSOTnCcvOTP723kEAU5dXNBGzf8XZxq
         Ncs8FoMBdZC/Dl6jCI7zcGj7QGDHTIUNkO2JL+upGtKODTwTJqJbOkhUf3r23Jcx8r
         6pczn5ArO9g48+DZTtr5tRbf7TO2gXahXa+vMR8xGYuP4ayAY4bQeRCp+9KPqkS4a+
         /BrrPM6bZIKjQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220312135722.20770-1-povik+lin@cutebit.org>
References: <20220312135722.20770-1-povik+lin@cutebit.org>
Subject: Re: [PATCH] clk: clk-apple-nco: Allow and fix module building
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin =?utf-8?q?Povi=C5=A1er?= <povik+lin@cutebit.org>
To:     Martin =?utf-8?q?Povi=C5=A1er?= <povik+lin@cutebit.org>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Tue, 15 Mar 2022 09:56:16 -0700
User-Agent: alot/0.10
Message-Id: <20220315165617.F2840C340E8@smtp.kernel.org>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Martin Povi=C5=A1er (2022-03-12 05:57:22)
> Signed-off-by: Martin Povi=C5=A1er <povik+lin@cutebit.org>
> ---

Applied to clk-next
