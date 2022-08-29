Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D74FB5A5827
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 01:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbiH2Xsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 19:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiH2Xrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 19:47:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28032A7212;
        Mon, 29 Aug 2022 16:46:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E8B3261416;
        Mon, 29 Aug 2022 23:46:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EE16C433D6;
        Mon, 29 Aug 2022 23:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661816804;
        bh=ZrtJr9E9ZvaIDT6FyqnfqLvUkcXvV+S+53NObKdxVyQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HnzgB1XEBEwquGL+eMa3bkI50gTv0i4+iOe379TxI4R1Revnj0nzdindtINULHgpc
         DY2599Puu41hWqcIV9zThx0vtKDmwUmqSosIG0p00dRsBYr+bXC7EzO3X+4AcBvvdx
         SJ+gz9ZpFn+PAHBMYj7lpXyITnzD8+l8fow99BQ1LdlFfBLrPBubfr5fvGuRzMPOvD
         uhcDT+R3PkLMsTsoUJyFmf9z9BR8mHSLDw7EcjTDrZ+OhvQLg5v41N8SkYcDjbT4Pp
         Ghz2/gTVWxSrvVHcFZOIml+6CbxGFvCMCMWxVh24KejVjHqbojRUynzM9N+39TqU/h
         tlIZ6FhNlBw9w==
From:   Bjorn Andersson <andersson@kernel.org>
To:     mka@chromium.org, Bjorn Andersson <andersson@kernel.org>,
        robh+dt@kernel.org, konrad.dybcio@somainline.org,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org
Cc:     dianders@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc7280-herobrine: Don't enable the USB 2.0 port
Date:   Mon, 29 Aug 2022 18:46:06 -0500
Message-Id: <166181675988.322065.1838980983190531415.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220826084813.1.I8c9a771fcf4d1cfb6e8e0ef17a153143af9a644d@changeid>
References: <20220826084813.1.I8c9a771fcf4d1cfb6e8e0ef17a153143af9a644d@changeid>
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

On Fri, 26 Aug 2022 08:48:27 -0700, Matthias Kaehlcke wrote:
> The USB 2.0 port of sc7280 is currently not used by any herobrine
> board. Delete the device tree entries that enable it.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sc7280-herobrine: Don't enable the USB 2.0 port
      commit: 643d05163e3a18f224e4e1a80de09b2b74e1d249

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
