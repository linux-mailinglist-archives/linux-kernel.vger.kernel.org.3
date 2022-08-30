Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67545A59E9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 05:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbiH3D1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 23:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbiH3D0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 23:26:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70DD39D8F0;
        Mon, 29 Aug 2022 20:26:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 355B9B81619;
        Tue, 30 Aug 2022 03:26:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AD36C43142;
        Tue, 30 Aug 2022 03:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661830007;
        bh=PGOX+OD+EIdHRnAcNgzf6NHGQ7c+r+oNlOuxPZR85/I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LXYRiV0XlSaI9QhHppRdoDtBqWd1iH3s5G7De9dOmnf8te0fI1OHOSIyoL+F33bwz
         U5MG6bX0hwAeuoYyBhN00mqJ63+Ri+SO7Qhdu2+YWayKahHY5TuegAvSCwZQn1nwMC
         VQO1MmX2TEyHjQe7cGIDyvsopKTxxbbIBV9957RsjCrCMUvlcTvHr6vt+byQCuasLz
         xCnBZaYa5Xmv/8hVvsIggLXRym5GPs1KXw2aDrVgS7G2Qfrq/kcBol7hiakAfpvxtF
         pkmfQI+DAiDzK9uVwrDEGGwvIVEXCRG3kESBw4a614z1TwP6AlpU+EpfrxN3zsAo3I
         VdavY87QhvDMQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     mka@chromium.org, krzysztof.kozlowski+dt@linaro.org,
        Bjorn Andersson <andersson@kernel.org>,
        konrad.dybcio@somainline.org, robh+dt@kernel.org, agross@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, dianders@chromium.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc7280-qcard: Add alias 'wifi0'
Date:   Mon, 29 Aug 2022 22:26:44 -0500
Message-Id: <166182996517.340873.15964860358803573963.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220829094435.1.I4534cf408373478dd6e84dc8b9ddd0d4e1a3f143@changeid>
References: <20220829094435.1.I4534cf408373478dd6e84dc8b9ddd0d4e1a3f143@changeid>
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

On Mon, 29 Aug 2022 09:44:38 -0700, Matthias Kaehlcke wrote:
> Add the alias 'wifi0' for the WiFi interface on the Qcard. The alias
> is needed by the BIOS which patches the WiFi MAC address read from
> the VPD (Vital Product Data) into the device tree.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sc7280-qcard: Add alias 'wifi0'
      commit: cab29d324a0531cf396bf0fe57868146918af245

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
