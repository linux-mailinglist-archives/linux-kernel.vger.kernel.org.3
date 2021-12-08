Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 824A246CC90
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 05:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240254AbhLHEe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 23:34:29 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:56838 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233519AbhLHEe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 23:34:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 17101B81D81;
        Wed,  8 Dec 2021 04:30:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEFD6C00446;
        Wed,  8 Dec 2021 04:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638937854;
        bh=EOEbeN/Kgi0GMYMankSSg0gzAST/9Pr1LyNkGfdUlxA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Zn5CWZq7kQWCXlUGJFwTbIhdsZOlWu6ZHNBOI+v8wAZM9eDl5LtMJKwBy5R9zAAkV
         +mgmQHMFesOKhq0b0b50NPwkDyx+1+DCK7kYrKPeHJ18Pv7/9vjIBrYQCxzTjuZu7F
         vzTMbZ04ZqWlUgHfiCEPq3FEK5S4ZRnTNKcDqRFu3CsdVxy5nByUGqSWRAa6l0++SL
         uwalAWnFAT+sXCcjFE0qe54kkEJ8McApYjbtht1s1zEgqExovfCszbIwh4j+8okLGv
         2e+/r4bJ0IZi1JaBvUO/6+qgnN3iaLbQJFgDRCCP+J6dZrPGtag5AjdQjmCSWf67hF
         MqkKSz8ySONMQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <jgJW1u3RfTQcv5ZBcVQt4fz8_sA4gvyXsN5x18zzLo_nTR5nfLpZtdAjy-WlEaCMnmnPGZjeFGV5OoiWNtA4Tn5wLhqNJdQEvPw5Cqs1z3I=@wujek.eu>
References: <20211203141515.2448129-1-dev_public@wujek.eu> <20211206225354.BF0AFC341C6@smtp.kernel.org> <jgJW1u3RfTQcv5ZBcVQt4fz8_sA4gvyXsN5x18zzLo_nTR5nfLpZtdAjy-WlEaCMnmnPGZjeFGV5OoiWNtA4Tn5wLhqNJdQEvPw5Cqs1z3I=@wujek.eu>
Subject: Re: [PATCH] clk: si5341: Add sysfs property to check selected input
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     wujek dev <dev_public@wujek.eu>
Date:   Tue, 07 Dec 2021 20:30:53 -0800
User-Agent: alot/0.9.1
Message-Id: <20211208043054.CEFD6C00446@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting wujek dev (2021-12-06 15:08:03)
> Other sysfs properties used by this driver are not documented so I didn't=
 add for this one. Even more not a single property from clk subsystem is de=
scribed. Shall I the add description of this single property?
>=20

Please don't top post. sysfs properties are supposed to be single value
and for machine consumption. Is this a debugfs property?
