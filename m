Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9032A4D6C02
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 03:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbiCLCXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 21:23:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiCLCXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 21:23:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948A05A5AF;
        Fri, 11 Mar 2022 18:21:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3C686B80EDF;
        Sat, 12 Mar 2022 02:21:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6447C340E9;
        Sat, 12 Mar 2022 02:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647051714;
        bh=Qa6NYXUVK5J85jvGspXom1kBE5U9NjRF3yYu7+L14fk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=W8CrnnzAUqnB00gFKvGETdZXOgBY5Cw0Bm+sa5j+4enxjsqOcO51Rig8uus1B5scJ
         TekQX7VRtcXtNtJxSPlaqlrKcVAPt5A0I+WTAFyvqb7s1ylt8E+L+Sf8ftqWXY4lAC
         zr1Bse/sGb/DZuM3AuHd+c4WU/8sPJSE8UIvGLiPOivRqOsNdSBjZp8J1NMEZzPXmL
         yYgzrPN8ZbQLUffjvO7nip09PV0nFKoHDhu3gova4L03bq0TChbTUXzD+/DPhCYecE
         UyaNr+yUqsTh97NZfmaoOXsxLnBJFnXYxSMzlj0H/vGiof7AfYONShmUvgtm6Fzrmb
         RWW4rfi7LOGOA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220217173453.3262672-1-trix@redhat.com>
References: <20220217173453.3262672-1-trix@redhat.com>
Subject: Re: [PATCH] clk: socfpga: cleanup spdx tags
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
To:     dinguyen@kernel.org, mturquette@baylibre.com, trix@redhat.com
Date:   Fri, 11 Mar 2022 18:21:52 -0800
User-Agent: alot/0.10
Message-Id: <20220312022153.E6447C340E9@smtp.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting trix@redhat.com (2022-02-17 09:34:53)
> From: Tom Rix <trix@redhat.com>
>=20
> Replace tabs with spaces in SPDX tag
>=20
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---

Applied to clk-next
