Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833215663CE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 09:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiGEHMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 03:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiGEHMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 03:12:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C1D64F0;
        Tue,  5 Jul 2022 00:12:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 89FDEB81607;
        Tue,  5 Jul 2022 07:12:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67B01C341C7;
        Tue,  5 Jul 2022 07:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657005169;
        bh=jecdmO07RSUAbMoa7+ZQbRfH07PxhO+rt6YpHbFgc9Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D3pp3WGDqfye6d51EI4wCI+SDPBOfnPLX9gA7eqrUEWIinoFh2oXK8pGRFkz/xTRf
         JkQ0CbS/5GqosbOEJK/BTEt6JtP3++D4v4XFVg9EQ5q5dtYdL8i1I1Y29tlk/ReifA
         5MjpURFxrf0AyQa9H1IvlgjaaUh+7Nn+1/LvncY+Z4K83kyvjKkDAQWVmeJ9fyc95o
         SRiFrOpZvUpNThuatSBGzDYOYYVfypoKsof5R6F5U8jNIOqrl94YPONQosUmH0p15c
         W0/Z1rx4EwnRuQ/UQpY9TPaEGOP1PDW2MtABEnBHh8ums6xqWAtG3vSOv4nJVq+98Q
         DohKCURq6vTFQ==
Date:   Tue, 5 Jul 2022 12:42:44 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] phy: qcom-qmp: clean up defines
Message-ID: <YsPkbAj7gYqbFOgz@matsya>
References: <20220609120338.4080-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220609120338.4080-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-06-22, 14:03, Johan Hovold wrote:
> Here are some trivial cleanups of the QMP defines for issues found while
> adding support for SC8280XP.

Applied, thanks

-- 
~Vinod
