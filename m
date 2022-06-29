Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6895955F2EA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 03:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbiF2BnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 21:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbiF2BnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 21:43:07 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 57D1B113A;
        Tue, 28 Jun 2022 18:43:05 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 11D8B1E80D11;
        Wed, 29 Jun 2022 09:41:56 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id yRny1j0QDjLp; Wed, 29 Jun 2022 09:41:53 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: kunyu@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 760C91E80CDC;
        Wed, 29 Jun 2022 09:41:53 +0800 (CST)
From:   Li kunyu <kunyu@nfschina.com>
To:     bjorn.andersson@linaro.org
Cc:     agross@kernel.org, kunyu@nfschina.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org
Subject: Re: (subset) [PATCH] drivers: the return value statement of the gcc_sm6350_probe function has an extra semicolon
Date:   Wed, 29 Jun 2022 09:42:49 +0800
Message-Id: <20220629014250.4536-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <165644753306.10525.6775278248022275480.b4-ty@linaro.org>
References: <165644753306.10525.6775278248022275480.b4-ty@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,BODY_SINGLE_WORD,
        RDNS_NONE,SCC_BODY_SINGLE_WORD,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


thanks!

