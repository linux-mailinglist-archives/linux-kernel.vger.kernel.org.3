Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3822650E577
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 18:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243329AbiDYQXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 12:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243255AbiDYQXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 12:23:11 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E8BBCB4;
        Mon, 25 Apr 2022 09:20:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 02C5BCE18C5;
        Mon, 25 Apr 2022 16:20:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0196C385A4;
        Mon, 25 Apr 2022 16:20:00 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Brown <broonie@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Jonathan Corbet <corbet@lwn.net>, Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] arm64: document the boot requirements for MTE
Date:   Mon, 25 Apr 2022 17:19:58 +0100
Message-Id: <165090359492.2745002.14281951356771675020.b4-ty@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220422202912.292039-1-pcc@google.com>
References: <20220422202912.292039-1-pcc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Apr 2022 13:29:12 -0700, Peter Collingbourne wrote:
> When booting the kernel we access system registers such as GCR_EL1
> if MTE is supported. These accesses are defined to trap to EL3 if
> SCR_EL3.ATA is disabled. Furthermore, tag accesses will not behave
> as expected if SCR_EL3.ATA is not set, or if HCR_EL2.ATA is not set
> and we were booted at EL1. Therefore, require that these bits are
> enabled when appropriate.
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: document the boot requirements for MTE
      https://git.kernel.org/arm64/c/b6ba1a89f73f

-- 
Catalin

