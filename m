Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A91048CFFA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 02:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiAMBHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 20:07:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbiAMBHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 20:07:15 -0500
X-Greylist: delayed 17104 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 12 Jan 2022 17:07:15 PST
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [IPv6:2001:4b98:dc4:8::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58EEAC06173F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 17:07:15 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 486C1200002;
        Thu, 13 Jan 2022 01:07:12 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     bbrezillon@kernel.org, trix@redhat.com, ndesaulniers@google.com,
        vitor.soares@synopsys.com, nathan@kernel.org
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] i3c: master: dw: check return of dw_i3c_master_get_free_pos()
Date:   Thu, 13 Jan 2022 02:07:11 +0100
Message-Id: <164203602351.2985932.12500501407570919307.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220108150948.3988790-1-trix@redhat.com>
References: <20220108150948.3988790-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Jan 2022 07:09:48 -0800, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> Clang static analysis reports this problem
> dw-i3c-master.c:799:9: warning: The result of the left shift is
>   undefined because the left operand is negative
>                       COMMAND_PORT_DEV_INDEX(pos) |
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> [...]

Applied, thanks!

[1/1] i3c: master: dw: check return of dw_i3c_master_get_free_pos()
      commit: 13462ba1815db5a96891293a9cfaa2451f7bd623

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
