Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4BA5A57D9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 01:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbiH2Xqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 19:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiH2XqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 19:46:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3F898A5A;
        Mon, 29 Aug 2022 16:46:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C3F3EB815D1;
        Mon, 29 Aug 2022 23:46:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5F2EC43470;
        Mon, 29 Aug 2022 23:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661816780;
        bh=WYQPNXG9dqE+9O4LnJLU3eHkWGDJlK0p2LnIx9mJadI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IX6t+6/7xcBoY9fTbX1KRcUycV8kugLe6XHuD3dgIpIxN66ycBzlN3w7lcbP7HeSw
         jxz4xvFNFwscRH7luSpSvtHGrut0lwOzSRsgw/JpQVTsrNjNqolj6nuG4d8RpPkJer
         8NH+0mms0sYq6K5TojMkkauA1sk2t+90HW6E/ul6HB15mOuPqk/YKMnF1sfXe2e7+b
         x9JrIMfE/hFDjudfw0WkaM1AAMNPCDZ5h0ToPAR3Ie7LQm12BcgJT7eS5RNpqgRxFu
         bQm1XRITwGChz5pDjprlF2WZlNBwzKFCNGm8sWw50H07sCqhv57G3y6eJJ62HqAgJ5
         5GB7/poDRU3dw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>, konrad.dybcio@somainline.org,
        mathieu.poirier@linaro.org, Bjorn Andersson <andersson@kernel.org>
Cc:     linux-remoteproc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Update Bjorn's email address
Date:   Mon, 29 Aug 2022 18:45:42 -0500
Message-Id: <166181675993.322065.9091360700945964893.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220819142549.1605081-1-bjorn.andersson@linaro.org>
References: <20220819142549.1605081-1-bjorn.andersson@linaro.org>
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

On Fri, 19 Aug 2022 07:25:49 -0700, Bjorn Andersson wrote:
> Update the email address for Bjorn's maintainer entries and fill in
> .mailmap accordingly.
> 
> 

Applied, thanks!

[1/1] MAINTAINERS: Update Bjorn's email address
      commit: 8c8d28e1f10a0359f0c704be18cf744b3513acd2

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
