Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9487C46A2FA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 18:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242479AbhLFRcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 12:32:10 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:44596 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbhLFRcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 12:32:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 84B2ACE171C;
        Mon,  6 Dec 2021 17:28:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64132C341C1;
        Mon,  6 Dec 2021 17:28:34 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM64 PORT AARCH64 ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, james.morse@arm.com,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] arm64: entry: Use SDEI event constants
Date:   Mon,  6 Dec 2021 17:28:32 +0000
Message-Id: <163881168906.164288.11915946236560213112.b4-ty@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211118201811.2974922-1-f.fainelli@gmail.com>
References: <20211118201811.2974922-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Nov 2021 12:18:10 -0800, Florian Fainelli wrote:
> Use SDEI_EV_FAILED instead of open coding the 1 to make it clearer how
> SDEI_EVENT_COMPLETE vs. SDEI_EVENT_COMPLETE_AND_RESUME is selected.

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: entry: Use SDEI event constants
      https://git.kernel.org/arm64/c/c9f5ea08a0f0

-- 
Catalin

