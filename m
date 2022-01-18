Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9A78492E42
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 20:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348578AbiARTP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 14:15:26 -0500
Received: from mail.antaris-organics.com ([91.227.220.155]:43324 "EHLO
        mail.antaris-organics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348640AbiARTPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 14:15:20 -0500
X-Greylist: delayed 537 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Jan 2022 14:15:19 EST
Date:   Tue, 18 Jan 2022 20:06:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mareichelt.com;
        s=202107; t=1642532781;
        bh=LtWB4D6zeLWHh+inbSDbj5BIxXp3i6a424NYMgVLAuw=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=Qvf6cbzlSnoYJma2N262b3MALOCwFYQ/Xh7cZepxbDCmNqe9zhfb7S2y94pYra2Ir
         0wTGy1B2qVBQKkWiRTJ+yOvV9lBYkHQfCNK8Zxwg+vHkumGt9dSMVjjqHvjCVDr5Uo
         2KFKTAOwwMr5XlMAMt3ppWonhU8pY+YHl1YF+ikJMqtHc8q889652oRhJ7XkdaMjBt
         PQJIC8XIbuup83fbQ4Z2i2NvujqaGX9caiKwfa/NPRjlH0ZZH+IHLZUecVePBmmjgu
         pi99esdMlbghOBuyDF80lpkzHW/0klkMB9Xk8kISJxh8QT5pvyacxyn0hmpQwar23+
         Ur0jiiY28KswA==
From:   Markus Reichelt <ml@mareichelt.com>
To:     "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Announce loop-AES-v3.7w file/swap crypto package
Message-ID: <YecPrJMJTpUwYz4s@pc21.mareichelt.com>
Mail-Followup-To: "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <8LUdOFjFwCBEYnY82H3a1lkMp0bcXSZs4UNYBpQP9lNigJqB7tnq6OUQR5LB4Lk1eus6P2XpWAlzbTBGc1RJNpkwD7dIED07P5E1N87YL80=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8LUdOFjFwCBEYnY82H3a1lkMp0bcXSZs4UNYBpQP9lNigJqB7tnq6OUQR5LB4Lk1eus6P2XpWAlzbTBGc1RJNpkwD7dIED07P5E1N87YL80=@protonmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Jari Ruusu <jariruusu@protonmail.com> wrote:

> loop-AES changes since previous release:
> - Worked around kernel interface changes on 5.16 kernels.
> - Silenced switch-case fall through C-compiler warnings.

thank you!
