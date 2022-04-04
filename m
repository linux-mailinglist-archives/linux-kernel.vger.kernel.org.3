Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3D54F12CD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 12:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356349AbiDDKNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 06:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356381AbiDDKMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 06:12:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A599026106
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 03:10:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 53A12B81215
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 10:10:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85B44C34111;
        Mon,  4 Apr 2022 10:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649067057;
        bh=2BwDnn1trZk8I7YDpZE133kDbeMx+yhjkHpk3sb2of8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hYhO2mIp6xcutazZBtnUbwLUu29ulnNikJbrfuBntbc7e1hQycJJOO6Nyk44vORPf
         bbE7Wo+ltMNMt9sNG1PjcoF38JTg1znoQ3lfJ2BoPkq6Th4RNF4mEj/6pTTqP3+dFd
         /ZBlYjwajk43Vidg0sPfoGG58PR00k5DgSCVeEumYlKiE6W7H+Nn/uON0vz8n/I+dQ
         ibU+lESvRZi4NudBcOej+ATDknkrNwYDWUrIABCX92qn5MixDJOYCxa/4AcgLoKurn
         MQy4w9cezpWdZd7iWeTnGBwuyc2O/Of9Wn0gNy2FoAh6XHxuLRCqoQFzPyLxtjgGqW
         D6F5iIefOBKgg==
From:   Will Deacon <will@kernel.org>
To:     catalin.marinas@arm.com, Zhiyuan Dai <daizhiyuan@phytium.com.cn>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        maz@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: Fix comments in macro __init_el2_gicv3
Date:   Mon,  4 Apr 2022 11:10:45 +0100
Message-Id: <164906495492.25766.5356643866625389852.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1647831387-3686-1-git-send-email-daizhiyuan@phytium.com.cn>
References: <1647831387-3686-1-git-send-email-daizhiyuan@phytium.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Mar 2022 10:56:27 +0800, Zhiyuan Dai wrote:
> Fix typo in comment.
> 
> 

Applied to arm64 (for-next/fixes), thanks!

[1/2] arm64: Fix comments in macro __init_el2_gicv3
      https://git.kernel.org/arm64/c/4dfa1f3657a0

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
