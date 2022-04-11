Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6DB4FC38D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 19:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348938AbiDKRjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 13:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239996AbiDKRjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 13:39:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3B821834;
        Mon, 11 Apr 2022 10:37:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5CA4260B8D;
        Mon, 11 Apr 2022 17:37:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34B2DC385A4;
        Mon, 11 Apr 2022 17:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649698646;
        bh=kYbh6pX/FHME7Yaf3yi+julbzImYTc4dZfXcNYYWD5I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TL/TnBpth40Ri4M7OsvCOZAPrXxbHxUkNB/eNmNclDjN2ERLvLC2oLVJ6AcW+m6wS
         LB6nN09+Z2grJ8aXoEXNt963h0cTvg1gnFTaibyDrJaznXn/quCC3Yj6aat5XTgiJS
         VT6tMd9hdI3PlXaD61qSCVQeXO1V/vRhMxzAIDQq7eNG2RwTrbCtoyLlE0AM+NM4SL
         KBe1v9Gc6rK1r2QDS6VqPqgw7TRS6cGMrsbEG1c8svwZyCM6QM+Aa7Be+WAiVsgUQh
         yE0FpXNby4nCq8Bbj6xvcFX+pvopWFOHurlqP9l/qEDw4JwzsaAgNrfZaC5wIMGA+F
         4CBx39qUN2n/w==
Date:   Mon, 11 Apr 2022 23:07:22 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH] phy: ti: tusb1210: Fix an error handling path in
 tusb1210_probe()
Message-ID: <YlRnUqSpXAclhWqs@matsya>
References: <07c4926c42243cedb3b6067a241bb486fdda01b5.1648991162.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07c4926c42243cedb3b6067a241bb486fdda01b5.1648991162.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-04-22, 15:06, Christophe JAILLET wrote:
> tusb1210_probe_charger_detect() must be undone by a corresponding
> tusb1210_remove_charger_detect() in the error handling path, as already
> done in the remove function.

Applied, thanks

-- 
~Vinod
