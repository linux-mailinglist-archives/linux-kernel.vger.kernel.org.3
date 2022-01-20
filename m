Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF337495183
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 16:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376699AbiATPdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 10:33:51 -0500
Received: from mail-108-mta11.mxroute.com ([136.175.108.11]:33777 "EHLO
        mail-108-mta11.mxroute.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1376666AbiATPdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 10:33:47 -0500
Received: from filter004.mxroute.com ([149.28.56.236] filter004.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta11.mxroute.com (ZoneMTA) with ESMTPSA id 17e781a9fcb000bdf2.004
 for <linux-kernel@vger.kernel.org>
 (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256);
 Thu, 20 Jan 2022 15:28:37 +0000
X-Zone-Loop: 8b04c47f0568cd3a1f4ee070b5f323d3a2297cbb00ea
X-Originating-IP: [149.28.56.236]
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ds0.me; s=x
        ; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
        :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
        References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
        List-Owner:List-Archive; bh=d4rlcBSsDMSlADxswOGFTDUxcitWqo4M6bUPgSom6w0=; b=Y
        cBI97RpG7pM4ucvHjBwkZMoxkSbQEsL/zRDaAqKe8oCW+Xjm+WeWmZPxE6+dojhEap9vQkDPhmlug
        IipZOJ5XutXwm2Y4Plz6ZZHD6oHxwrmva0CqGNz6S/1Yv/X2x9LAR+kDpXoz6KLbEESIP9X090zb/
        HZH6cHmNYSnExDT2fi8uv4m/fNYHNij6fNQc06E031lSjSgpPG8S8TvVbiZ7Ny+jDRqzAYYaiPQw0
        f//4DRDFnwqx5jII50eEtWrQru4lCrI5PK/4rozq5nk9CsDU71ZBwqiGz2Pb7phd1Y3cTjgvf8ChM
        Ws/+MZE9TJdI5ecpWoLa8rK/EWAbpcJtQ==;
From:   Myrtle Shah <gatecat@ds0.me>
To:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com
Cc:     linux-kernel@vger.kernel.org
Subject: 
Date:   Thu, 20 Jan 2022 15:28:26 +0000
Message-Id: <20220120152828.4089364-1-gatecat@ds0.me>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AuthUser: dave@ds0.me
X-Spam: Yes
X-Zone-Spam-Resolution: add header
X-Zone-Spam-Status: Yes, score=11, required=15, tests=[ARC_NA=0,
 SPAM_FLAG=5, FROM_HAS_DN=0, RCPT_COUNT_THREE=0, R_MISSING_CHARSET=2.5,
 TO_DN_NONE=0, BROKEN_CONTENT_TYPE=1.5, NEURAL_SPAM=0, MID_CONTAINS_FROM=1,
 RCVD_COUNT_ZERO=0, FROM_EQ_ENVFROM=0, EMPTY_SUBJECT=1, MIME_TRACE=0]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are some initial patches to bugs I found attempting to
get a XIP kernel working on hardware:
 - 32-bit VexRiscv processor
 - kernel in SPI flash, at 0x00200000
 - 16MB of RAM at 0x10000000
 - MMU enabled
 
I still have some more debugging to do, but these at least
get the kernel as far as initialising the MMU, and I would
appreciate feedback if anyone else is working on RISC-V XIP.


