Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D26A531000
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235330AbiEWMEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 08:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235284AbiEWMEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 08:04:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFAD2BD;
        Mon, 23 May 2022 05:04:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4A046B8109E;
        Mon, 23 May 2022 12:04:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B68FC385A9;
        Mon, 23 May 2022 12:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653307487;
        bh=j4sEh1Ryhhs8fM+uoxt7DayuRYDj0+vAUMwZVamtxQw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TD0UcwjKYaJUbG4fRMwxKhKExyjbUdqojBjdBqixm0Oe5nih7Ttb6xD+pTvE5fgp2
         3ZYcR6+f7RG4/kSkrQe21fZNZ/3XzJdiDMQpGaUV+srAcST5FLF/TizTPxZPSPJGDG
         BPQTt4anY7FBKoo+2a58GtCjraE1B16LhdY4fhUiwRgwiz+rSSvsNXtcvYQqflXDvg
         U0UTKqUA3Rhz8yH3uyQV1ObgZuOrlpReWhxR0oYGofNiMxxBaXpxt4caJuG0VVSvkF
         5QMZQfgm5tIwExjh9+DmgChXH1moIkrEvTjbUmv0D+KFF51LARBhRAfokiAUW+JUf5
         RQom8IAPyPnYA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nt6nk-0003CZ-GW; Mon, 23 May 2022 14:04:44 +0200
Date:   Mon, 23 May 2022 14:04:44 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] clk: qcom: gdsc: add support for collapse-vote
 registers
Message-ID: <Yot4XHaf6uHcJxTL@hovoldconsulting.com>
References: <20220520100948.19622-1-johan+linaro@kernel.org>
 <20220520100948.19622-3-johan+linaro@kernel.org>
 <20220521035228.1FD9AC385A9@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220521035228.1FD9AC385A9@smtp.kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 08:52:26PM -0700, Stephen Boyd wrote:
> Quoting Johan Hovold (2022-05-20 03:09:47)
> > Recent Qualcomm platforms have APCS collapse-vote registers that allow
> > for sharing GDSCs with other masters (e.g. LPASS).
> 
> Maybe just say 'with other subsystems' because LPASS is an entire
> subsystem.

The term "subsystem" is too broad and also has a different meaning in
Linux.

The vendor kernel uses "masters" here which is clear enough and
presumably matches their documentation.

Johan
